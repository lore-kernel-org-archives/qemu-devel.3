Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19423C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9V-0003cL-Ld; Fri, 26 Jun 2026 19:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9T-0003aJ-DV
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9R-00043t-K2
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:03 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxNMu796349
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cZoPr+343cB
 /jYeaHXbTMOT7ZSVJo9VCbsO6f4nij9Q=; b=QVccBKm6FkCFGg8LaSgiuC8Akpu
 QJVbFUMCTd0v8T9ZC0UNFEQ25wVSLHVUGFyYXNOgV/gWc/TBiIeenIAG9DBkkaY5
 B3oSrMXuFh+qhIh8pq2OAve0Nnco/4PFqeEhQPYKdDc55yI3odRLB1tiQltoZgDn
 B6UREQpOdmHRuBAVPb0QcEfp9aLHn/cOLNy7Hivyd0/4R2Iyb4DPHvMO1cGCxL5V
 fcmvrJfvYCGOgJLeLpGXYqGR+/R8FrMHrhzF9bqCuInWlDrNR+XYmxaYhqEvY+Dy
 JhzOC1Twb2y5xrxgK3n5T6z/K8GqcoNQYtvqQcHYhOrDws1fxywd4otx2wg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1ups9kke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30cb5001ed8so247980eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517189; x=1783121989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZoPr+343cB/jYeaHXbTMOT7ZSVJo9VCbsO6f4nij9Q=;
 b=E86F0CI8llbgigIT6Xp47MMg0o7SApLaFXjVCg7NyE9ClAU6KVJ/Trxk/K6oTAqg3J
 AgGBHcQjauN1jcBWVA3WexfqHK6tAIKCSGWMISBie+/zhZ8UJuQIblP5cNbik9TMVsrc
 hwFygwnzRWn5Pa5JBuDpY/ae9PSqFePlC/JAGwf17d2vUYscp1+LxzixdHPf7ddIV8mX
 Ru5phZsKTvnIg/jB5lz/gmwyy0MyCmhqIa6Yo4SZT0RAN/BSBbNjwPI7LGWTSZ8d3PW0
 Du4lwcWXE6+EUf2+ktEHNXufkk73mDFvPyOqSdYqRKmKGgiSqeJQLG/Zjs4HnaGqFCS/
 0y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517189; x=1783121989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cZoPr+343cB/jYeaHXbTMOT7ZSVJo9VCbsO6f4nij9Q=;
 b=VrGIWV4+toH09rWI1X4jP2sReRXHw//aLvEnLUwR2mFPVA0B6Am38cncW07DIPMRNK
 5gHX+xqeWxChmXFdPrBa70JUILBAg7InAk9g6VkiEnTA4d3+HB8ukRtU5GLvsjo6zK2d
 vNZ9VB3DELEdxCaZtN7ae3yMg9jG5XgroaGOyRm8JS+lNQWa+pxx8xBSR9Lfxp38ETCU
 VmeTr5CgPq0YWUbTY+v44osaQ61vTq08MAY8H1uruQTyGrINXpChcd5kCYRO4V4frepP
 BrzJyTCGTue9NAsVe5Xos4a08TeVkWjZMcbHScpp1EUcjzquQemDz50TiNFYgYj71cn0
 AQHg==
X-Gm-Message-State: AOJu0Yw1bTybM+gushSCFsSMAnU+/FngjNtWaAkjJUaE3rC8r+WKrvlu
 kny6Iz/c7wHk3zoaFMq1OQUmR9drWrEV52yh3ykk/9jQw44ehfgQSfi4DoWQBMwVSDu7aW0NYHn
 Gm0S12DTiZgcht0kqT9ZBa7k5fHMZKJNJ/+eEW/XbhcQmicfEYO0jpAGbx2SIsKpynA==
X-Gm-Gg: AfdE7clCTT2Jwatrn2pZMAEiqEqFedvb7i3JFIYz6djHhlW9ppVTNolwbkiwZJoqAat
 85/HEGdEoWY9P2BHFIjBTI/on3NvUf/ZqUTPhFOlGNhZNcMz3jK2/eSAnmigYefuX4zQ1V6HoY3
 aUwpfla3vp5f7Eap0HDYNRfzD4fnS8S5soa6k3amItqLm3OkCQi4iqeIKQoel6sL10ozRsVQYsd
 Y0kgk/NPm0pYTqAucUUuHmyD3yJFpRXEXqlbVyY3e2+Ztq69m7TI9hSA7jDRRS/5V09eoJxrPMF
 zLHcPJ343y9EF/N5o0oBl0HPy9ndwGxpEdqsMeOj6BdTAUzJW9sbzvHvo1IUqFkyfemmzwyKFA6
 wf+rUF/lMCyrTFoRhGRCBuJVJ0CPL6g4e5eCuY8qYR8K74d/HdMFeZMXUtslrriLPWEh6QEWx84
 DO96f7Yw==
X-Received: by 2002:a05:7301:9f13:b0:307:393a:8f1d with SMTP id
 5a478bee46e88-30c84b9bddemr8290496eec.14.1782517189078; 
 Fri, 26 Jun 2026 16:39:49 -0700 (PDT)
X-Received: by 2002:a05:7301:9f13:b0:307:393a:8f1d with SMTP id
 5a478bee46e88-30c84b9bddemr8290476eec.14.1782517188549; 
 Fri, 26 Jun 2026 16:39:48 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 18/37] tests/tcg/meson.build: add wrapper run_with_input
Date: Fri, 26 Jun 2026 16:38:59 -0700
Message-ID: <20260626233918.158740-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfXyFvqWmxA1aIl
 ZtvmHyqpH10VbV/OeXjmuXtqDJb+fataVjwRgWcIFo0HnhQ2d8nRGDhD8w/ZK27hc7cGsmyvCkW
 sw2dbaNSmEUJLrvEzDOv8eajjW9WSVhCdK0CnhK19TM3gxKmVQHjpw4NFiP3OhocJhitRAevFzt
 uESRFkuszKFyavc/Ja67jpJ4Q0EIZVE8Y+aXuG1E08XREVxW0f4Stb6+OPuETvpKwGgUx9Ra08T
 cQAwnalb17B9dXnaLp9ZnkBnQlNZ6wbEhb6iTJTDFWZ7wlej8z/b8cVk9yemq4AQlUx7qpXSp9j
 GpAxjFVOGHYelfN9X2CRiT9aUvOLLy03W2bOqXbOxSzMaPpckfLTosl0N/Pn4mIF8jDbR71bCpX
 eB7fUr30JAXLC2DSljM0pqbwxBYvHhP9CgU2TECZs9zj6UNFBWB3EJukHAzPA3IFBrL520hkdHg
 cexpAr/DSXhk8gPOG8A==
X-Proofpoint-GUID: S2kRzzqXhl9NMZliWeDnEDhhqvmjDyag
X-Proofpoint-ORIG-GUID: S2kRzzqXhl9NMZliWeDnEDhhqvmjDyag
X-Authority-Analysis: v=2.4 cv=R6kz39RX c=1 sm=1 tr=0 ts=6a3f0dc5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=xR2A3ow12ysiLA1IkLQA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX1XFPTPY4NKMX
 O5bm7ti1GIt6Que3RxcJhOCfzatgWiY1r1EV+pJS9fVJpph9kQxraPPBFd1nc2BR3reuJgn9PSe
 H93nSNSonA4TdwcpBccq60x6GqYgxh4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Semihosting console tests require console interaction, and were flagged
as manual because of this. This wrapper automates interaction, by
sending a specific string on stdin.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build               |  1 +
 tests/tcg/scripts/run_with_input.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100755 tests/tcg/scripts/run_with_input.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 130f8a83c54..0e6546668c9 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -8,6 +8,7 @@ endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
+prog_run_with_input = find_program('./scripts/run_with_input.sh')
 prog_run_and_check_forbidden_output = find_program(
   './scripts/run_and_check_forbidden_output.sh'
 )
diff --git a/tests/tcg/scripts/run_with_input.sh b/tests/tcg/scripts/run_with_input.sh
new file mode 100755
index 00000000000..3d280547c3a
--- /dev/null
+++ b/tests/tcg/scripts/run_with_input.sh
@@ -0,0 +1,12 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "run_with_input: input_string cmd [args]..." 1>&2
+    exit 1
+fi
+input="$1";shift
+set -x
+echo "$input" | "$@"
-- 
2.47.3


