Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9046BCD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JQ-0007L2-Uq; Tue, 09 Jun 2026 17:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JC-0006tv-FS
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4J5-0008C6-Pw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:29 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4hpH3229320
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wJRVYYDL9J5
 awLnVNWgque9y4f2f+h6eDXpG+UPbSkY=; b=oM1wxGUfTw4o39cntGHEKd4ZwoT
 t97KMLCdhWQEgcXSzFwyk/o5Ykd/7z0cXhVP1A7xUEzKKrZfz0b/u0M/+RhyzIsn
 ZfuD0yXRt42Ba75Pfz5FoX230IXOSedL2tbJzTmuc7yczewtib+JaPhM0EbWkT4N
 N5vo+fiQcd53oGStEsR9YwzLxVesCeV7iqmJTVZSD+svBZhiQPV7y8jgKrV0k8Rj
 qHI9AxqUOJo6H6jmQ+K6gLpdK+uSyl7OiksKXoeGc8uLrbU85A9zGX5BrnPfjhde
 hYswB+lg8nlclzY0j+GizgE1nNeVQ/lIuaO4Itytn1DYNZrd5yQqWsdYbLQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wkg2m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304ed777a96so4190409eec.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041692; x=1781646492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJRVYYDL9J5awLnVNWgque9y4f2f+h6eDXpG+UPbSkY=;
 b=QW14ThPKonk50txPgc1svzYeOwSpBZQsBir5jHJi7tmFC2B8tD80PAajNtgeblT8z9
 FWppI+lO9M3ZQo3y5zyrT3ML8kPk30T0BwNWSvoZnJiurRA4XKBMWk15mSiUaPMqkBqD
 adKA3fwMoBMlc7ePughLoAzL5NFjcqhKsSVejiJDxB22INYKwsaDGOd3GUv2Y8oYzIs4
 RyPUbj3Uimnr8Q1Bg+iU/ic7uuIbpL4AIcHeefvH1e/fu2enQf5EN9CQoa3DgpVkXc2G
 4bCTnM7Fkduj5BsNa2iQiB+QokxFJAle5Y/8cJUsxkawlt6NjLwkdrUbMk6KR6Y/9orc
 Zo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041692; x=1781646492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wJRVYYDL9J5awLnVNWgque9y4f2f+h6eDXpG+UPbSkY=;
 b=ekhHkYqkQWeIvM817UCOyoWoMtgUaZyYhyDoIaMRf1VStG54iFQl03E6UA2+a7jKIV
 CzOgGQqkGuHSb9V9+ZUey4V2pEI2jEWsFkIGWmhQkdbHs9s21uNyRR+orzajMMS+MFQy
 UxCg6sfX2/qal0M8q2eP4LtQLSX70lQif2+vwkAeitOmJGR8Uqg9so+cPvdFZSalUfU1
 ex0filqieDQw2Gl1+jMSEkak0oLNhiX6DeCrqYa9dXEThbqbLDo7sJpm9BHKtbrqjKb4
 8DIAsNJW9OD+WYUadaJ+hm6DcRK/4rpFlhVnsSWYvj/Mp7P2PqmtvPWi0GyVrkC181m0
 F3xw==
X-Gm-Message-State: AOJu0YxyEhSqdyfQDYTctH6WZCbxxRKJYK0rGSReTspLG/ZuX+MVaodl
 JIxD7pvRKurhd32b4c1kAZDuIUWUO/po6Wld4lC1gSJmGicud05af4UWb9Z90IbxOGqZApmgKHC
 XCOc5syIQ3KE/bGoMxL50rAVmejO2Bk6IiYIFINopSIm9EKwVokG6SLA2IEttE3LHbkKg
X-Gm-Gg: Acq92OE6IZeW3Ud9/lcXhoLUkLO1N/q9Bjh8SEj8TJuqX84nQvX9sqBriO/aHpwfNmV
 FDqRyKkkQarshr+e3l7vDi5owI3YTdnOzxwz0od0oybHGOoJLsqhYYnPrwU88XG93V/BjpBZkIa
 h/j74YIEnr/oF6LG4PV/uDDAcEdwn3FcgFuCAfYgrvFk8nrsxzn1NH8S9m1ObfxZkuXttVn7xPZ
 ZDG+MDih8Xgu5ZMwG4gfcG7oA4S3RqdXVS491YXZQuF6NKyhDd29jZFsCVMKLid2wyulzEYyKDW
 NTl7cOQHQfRgKsPGPujqQospvGMHz++817MAXgT97ZIjHVF4nuqjDHV3Cruboto+qHUJVL7TJcW
 nnnkd7wr4xUxcliw961U1QKTro8HHZVCjMrHojCUC6561mwsvAbe15+JNU/BeksJnlW4D5BAX4/
 oAFuTxEKAL0lH9QRTE
X-Received: by 2002:a05:7022:207:b0:136:4bbe:9523 with SMTP id
 a92af1059eb24-13807d3698bmr9681168c88.8.1781041691857; 
 Tue, 09 Jun 2026 14:48:11 -0700 (PDT)
X-Received: by 2002:a05:7022:207:b0:136:4bbe:9523 with SMTP id
 a92af1059eb24-13807d3698bmr9681139c88.8.1781041691368; 
 Tue, 09 Jun 2026 14:48:11 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 18/27] tests/tcg/meson.build: add wrapper run_with_input
Date: Tue,  9 Jun 2026 14:47:36 -0700
Message-ID: <20260609214745.772536-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfXwqATeOc9PnrJ
 vMtCr9Vu864q3xPtUR78ZeUvvBMnV74lyPiXYdsXO7JK7LKc2zB4VNn/HUU+/zsdxaaSqb2RiY7
 UpeLAsjX5aY0FfkCpTcSKo5NR15ZaWa623Spsr/2vYrm7rLAj+IHkeSqPmB+tOvVqaAuFqQvqZL
 kNK2YpalUXCGuvYDJyn7AMrWDoCmhLZXGBoMDfOlDfB1DGEQl9t7doBTU9vxdOfxVKYxYHk66ZA
 b/nsgEngDu7izlXoy7Fg5s+Y/DgcdTfopA+7DgjD/8e30NTbmY0wye85dU0VziWAVhPL4p2EVs1
 M6LJd/hWpKweg60yEvMQ4y6nsI2hQVDGlPTptGVW6H6TfRG51mAVswRelGhUM/SqmdSUHQonRVv
 Lt+Vr9/FS9vjNVN+BtNhgfkNffOu1WiNQLh3yITN9L6AkBf7+6SDiR2X0pl6v88K94Yp0zjlQdw
 j3FH/cXKv7S6wLWR8iQ==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a288a1c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=xR2A3ow12ysiLA1IkLQA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 8kmc14SzwxcaV4qk1dadD-cguxMqmAZr
X-Proofpoint-ORIG-GUID: 8kmc14SzwxcaV4qk1dadD-cguxMqmAZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090205
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index f379449e582..7201a7809e1 100644
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
2.43.0


