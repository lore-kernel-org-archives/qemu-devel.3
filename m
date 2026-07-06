Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE57BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtx-0003OB-Pd; Mon, 06 Jul 2026 18:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtd-0002t6-Je
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtb-0005cE-54
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:37 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEODT1613950
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FMzvURL2hz8
 rhEWj0P9ONBLF/8AqdJaHw+fLLS8/iM0=; b=hztfznW4VRDAf0syLHX0vHLl2om
 V2bWeWW4dr2rO5J5xo/GlqSyxZYdFduwg7xEkbU3ws1MFg7apakK4kj7HWuF5o6J
 6rfGOH+V+3EQLr//DylZwkuv+jDiIjywt6EDSfqHOLqhSH2zC48tdesklGzaqF2J
 ejZFOTQwed0NCyDqHiX0G8R8CyupETpl54lBzimgeV0pEYoXUS8c6ZmobqSsNcjE
 vj5AkoSBkdKPzzOavSElVCaiNPu/k/tMp8KhuIyCx74+YCLQRo4ffHWV4uA6w1T5
 Q71DbihSTkorYLpN+h8MmVRabN9BwNnEmXE+xG1N0MmpIvf5tlC6Vzim60Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h53jsk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:24 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85a298cd62so3022706a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377263; x=1783982063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMzvURL2hz8rhEWj0P9ONBLF/8AqdJaHw+fLLS8/iM0=;
 b=cy413gs/quPs0HyIbBXjTgyzX9C57RBy3/EYaBTlRtobK++yS7E2X5aSVFECfkXHnw
 rx5plnRisibgmky3Tmwc2ULZ7BUuY795TMfJJc65Fcf3HjKVLYKlgI3OU1nCMNEpDhWD
 LfbD4tohVmSb4dvEzNy929qn+Q/bLHZyw1dhpvU/EhfAjBeL06XQCY7DPSlpTlidII3m
 fCax17ZxFxk2QIQd/syQVQM6QtHl58xqkuP3Ncpzeb9gsXxwY0XV59v0bnJ8wV1h287l
 r9MADBeSer16bwbKvYSdcWAYcftFAREK0Yh3wCso3Va7R6ORRDY9ZHovtOWm56Jesg5P
 7zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377263; x=1783982063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FMzvURL2hz8rhEWj0P9ONBLF/8AqdJaHw+fLLS8/iM0=;
 b=DIMB/i5ELzJJcsUeK+u4Ktp2F/BLfuEWGDIOpjuuk1tjzcQq3J94qMeeBiAzNMRNkL
 TnJOPwPH83J9D6RZKFqZa4Zgt9elQ4+UOVB3DtLPtO9OgrmChQ8b2jeMv1MnUwuDdnkc
 ZX7imIddYW+PeyiOaHLHZmsd+VZIQ714F0Z8eisup+HE5nKPJAHvPTMVVOdRRiiif5Wo
 RWbK0FHa8Q8hapGzwvaNbulxAZ7Ond1WPbiMdcc0NqvI9MMVJZYDk3oq1ykIS/GfXSoS
 oMlm65xJ+oVMZutprhKeiIq7SM7hqRAvslEAb5w8ndxu5RVbzhcDBG2ERgJEpb3jt/ce
 1z9w==
X-Gm-Message-State: AOJu0Yw9GH+o3C5e8BYVf9dsgS4PLJpTiQuHy6ZxQS8YrgMAHxwyQb6n
 Jb/FRg3QUEt6QZXYEwHMFeRlvCVtaVoJpTjpHs8ZDRvvBSdhfOewB48dvKezqJ+ftD4gZiDufrN
 C7IBWB3+yke9T6RDX65iqYAK05NTxeIqQzRlHyeYE4VM/u8uVR2+EjjwbKVv8tMov1g==
X-Gm-Gg: AfdE7cm2B/rxN0Z21dV2iBlKFQMnUizr8lbuN3M8o8hUItGHSS2G/ou+PPHZBIe0GPe
 35z0z/c1e92GYoLWvHOJraGFSUvuUXrDB4fh7hCMkU36r+doLB4UK/+tBHO0igi+SI27oNxPy4F
 8gyipxZg5muW8fHEuSRECZvYY5cPZggZfv0L+R8x2VGdZCjz0FNX56WuH/2BzTLLk4+wDpeC6XK
 uEit4VIx5qzoYzQDqQVIaba9MFXwVRno2GHqnhDzGtsbyZJbLWWXMskL6opJ/qtbWMrSu1m5TJD
 M4QIxoHEcwFis1cX7OLeWiwBv7K/FIx3ybt8OcI37G7lH3AxdP0dd/KtQWsf08AHdRgyq1+oXhO
 0TrbBW6iPn8u4+iE0ki7/r/P9ZjyqcVIwkw0m6mbl/aUz78THkZnUeJY/VTihcsAyyJPOY4JBEw
 skTyb4HA==
X-Received: by 2002:a05:6a21:6e46:b0:39b:d937:8020 with SMTP id
 adf61e73a8af0-3c08eed0254mr2783723637.42.1783377263032; 
 Mon, 06 Jul 2026 15:34:23 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e46:b0:39b:d937:8020 with SMTP id
 adf61e73a8af0-3c08eed0254mr2783685637.42.1783377262542; 
 Mon, 06 Jul 2026 15:34:22 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 19/91] tests/tcg/meson.build: add wrapper record_replay
Date: Mon,  6 Jul 2026 15:32:31 -0700
Message-ID: <20260706223343.988769-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: R478qGh8fVmqJfg7CqGccuwV3bdU8hXx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX2MVTDY/LKk/I
 DDo4O7tKp2Rk4/xP4u1f8rQR4omwXOqcQsIK9OUKujiB4LOtfCTWRQJ8pmV3jrGM8WG/oEq1njy
 VKTrHtLvZ/rTkrmKCc20eqEsSyvTr7Y=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c2d70 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=B0LFpWwdb5_kycexZfEA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX9hglAIom61lF
 yLurgE4S9KKn2qkxH6nmAO/G3c0VuJx6EjNRD6cfEer6E02WLoFqRtLUDOHOjzG9cXIRaCxMoBi
 6EqWfYDxNc8zRYB0wfm7eXQHXno+nfSlSmIM3Dx3ddIMxnG9AQLOhCbzRtO0VFWS5ged66ol9PK
 rTuIw7dKHNNOSYjSJZsAhq7ETu0Mqq/OrcwG27zMsKF95wROvLUCUMTsm5EInarMiZKtYRey54s
 oG5eF4WCMMZwmrubZlRtT5K4x6Qww184wcnknyLmBT1MJI292JocRUxtkOJ9+Z8hhLODoiapgt6
 u9JR6TG1+jV2qAiBT/wUqcghYQvIk0q3WwNQZjOI+Tz24s6p62B4rCaH9KQhzyzcYKLGqjkrM6X
 ATPP3imtEi9Iu2YXr/bz7wrJMleTgkCSCuUYGRMB4bvM517M4WufPTBF+D4MOkPs5o4F+F5wl3z
 DNSBYWkaH09HhJi7gCw==
X-Proofpoint-ORIG-GUID: R478qGh8fVmqJfg7CqGccuwV3bdU8hXx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060227
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Runs a record and replay test, and make sure the output produced by
both runs is the same.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build              |  1 +
 tests/tcg/scripts/record_replay.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100755 tests/tcg/scripts/record_replay.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 30178df0f7a..e610ce30f40 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -7,6 +7,7 @@ if config_host.has_key('GDB')
 endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
+prog_record_replay = find_program('./scripts/record_replay.sh')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
 prog_run_with_input = find_program('./scripts/run_with_input.sh')
 prog_run_and_check_forbidden_output = find_program(
diff --git a/tests/tcg/scripts/record_replay.sh b/tests/tcg/scripts/record_replay.sh
new file mode 100755
index 00000000000..57775a2d4c1
--- /dev/null
+++ b/tests/tcg/scripts/record_replay.sh
@@ -0,0 +1,16 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "record_replay: qemu_bin [args]..." 1>&2
+    exit 1
+fi
+qemu="$1";shift
+tmp=$(mktemp -d)
+trap "rm -rf $tmp" EXIT
+set -x
+$qemu -icount shift=5,rr=record,rrfile=$tmp/rr.bin "$@" |& tee $tmp/record
+$qemu -icount shift=5,rr=replay,rrfile=$tmp/rr.bin "$@" |& tee $tmp/replay
+diff $tmp/record $tmp/replay
-- 
2.47.3


