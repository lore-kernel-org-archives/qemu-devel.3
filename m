Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF06BC54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfQ-0004qu-NO; Tue, 28 Jul 2026 00:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfO-0004l2-4G
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfM-0001bk-L5
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3bdc11702756
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u9Flkj2si26nLeuVsGfTVr3E6/Y0GgePRLKguVyHtdc=; b=mAX7whHWEDVJhMEr
 727nRvV/z89dNBcZjikxRuOv+HGXWFsUvUSALPDchRu/qrvkPDKsWaZ4PMKyHYkN
 YMUx3XuqO3g0v64K2zyCfPysN+RZTlvxIJY4C/awmn+irAEsx2Bny4k3Ris+gEJJ
 3UR5zBMZV83dj4pXHYjbyN8h1qBWZRJtd4BFe0JFZyMXMOfLVFyithXx/mOBDl1d
 03nKyF/D9ty+cvNnKuKBBjKjNHz8b9+9Rx8r90yIzh2j5cEZcOWr7AG7SFbMqf58
 VbbUGigYSrf4Yc/eW9o5iYFbUTC09TLMRQWHgHljOJKQBSlx4+Y/1DhBN8dtTQRQ
 Wg5Jew==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7gw71-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so5507987a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213813; x=1785818613; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u9Flkj2si26nLeuVsGfTVr3E6/Y0GgePRLKguVyHtdc=;
 b=KCcdJ0gwpthXMTjd41fJ0Lqzkj3VO84Qi3014dSFwYJyvZTYZUwT4TlZMkPlZ4MRqv
 opbDti8qZc8I/0JrznmWqEQRDZzyne+HHg2f+ODua+R42OA69sCYIl+/f0rZodfVXLEP
 anuUoYYKSDgzzyYTwg2QWlKkEiqf++37Q/TLu1b3KHd9I6t0pf5NADBIKKTA/Wy3f44U
 I0Oge/4qn2v89C0J3Sjz70hS3E9RsTlvgWvc4WItxYvjsLH8/DyusvQJ67JBs5dw8UWM
 HHPAjBfJ33KW1ihkyLkxayOPDcXlT7rvMhg3E8KSzx3uGy8+T2dRcEWhj6fyi1SlNubs
 ECkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213813; x=1785818613;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u9Flkj2si26nLeuVsGfTVr3E6/Y0GgePRLKguVyHtdc=;
 b=dJAfdh2M543SypQuUxUGJ+WEtYtwfDJqWZdRtv4vFVj9Nd/YOEeXv+a+JJpG75JI+9
 JZlFm3G4horL23koCdpHmVGQwHQToq5TIJPJzgZZCLZwG8ywazkURDyY1yUeMO7DJ6N0
 xEoaAanUz/cVugMhdunaHjj/MjqbRruBZf/pmPHLNhsDI+57MQ/L5YCamhHKsYuJ/8IV
 ez+oGNz407PI6dxFNiS9bpJ2e7+OUti9ezJpfSDDrWgoBu/J3OOBmdqfPQqJJ9dxA/Hi
 DvjETFvHxkRh5BxUW+E5sXpxsEjaJBKViB5m64Q/9rfH1MZQK58hFUAXzhl4qEwKQSPy
 yBkQ==
X-Gm-Message-State: AOJu0YyZoJgwHQ/Df/93Lwl8DWwEVACoKl9PJZFyapCwFuE1AaJfaJfx
 hqA5JhdSywgDvWguNHia6Tu7HOvqppgYEx4gW/TC9RUwwY+JBbfuP3DTWDt9G4cSKcZI5DdrMaO
 oYf//fgmuZbda48ZrA/eGXN+aOTbqUtrGysk96uM6y1WCLiErJNyvFR+lt+04byBnDw==
X-Gm-Gg: AR+sD11Soj1cioWOez7M2l9Zj8PErAwILieUBRHC4Eb6pvlvsEZpfd9apxhLvH97fzU
 Sp2vPLOgOE85XP5mQMrub6N1F8EZeZ8vIyqrCeTo2rhs3XXr+aif+W3KQsKtB9ThxJ7nmj7616+
 OwNkf6Rwq+iMsiV3oN47foc1m3F7G0+2pPz4CZrIcPo8EwT89PKxZiZBMUP0BFH+cue/y5DDgnZ
 3Nk0YOF1bGY2N4zlEPHLBLZJ8KvdNgp/gWrKAWPlrCE7cYfXrbimNaEmoJ7e6YdRAmwmzLTZTmD
 zjbHWo22Mi7+owbSiiwNqcaAaESByHJUuYdKGsXngf8w2ocAR6Z0KcF2WiTxLIAotVegNp4UuC5
 BalHf0UcPA5HU26F8nmbhUupQv8EuiJY/do72gaRiqAMvskFoanJOHPSxAGdO7AEGzG0oFUM=
X-Received: by 2002:a05:6a21:e083:b0:3c3:bb40:790 with SMTP id
 adf61e73a8af0-3c8ba62b00cmr1130988637.66.1785213812607; 
 Mon, 27 Jul 2026 21:43:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:e083:b0:3c3:bb40:790 with SMTP id
 adf61e73a8af0-3c8ba62b00cmr1130962637.66.1785213812200; 
 Mon, 27 Jul 2026 21:43:32 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 020/103] tests/tcg/meson.build: add wrapper
 check_plugin_output
Date: Mon, 27 Jul 2026 21:41:24 -0700
Message-ID: <20260728044248.137626-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX71oHQU3gVNq3
 oLa1LerDuuhxwk6GSSoh9o+f6q2sUHG8hZzjADObWDdQbjc+KGg8b0tBRUSgYqyg/+KH1WeaJ3+
 YMGDkWj+SLN8c5OIEeFFTjMcyO/AX1fvwlz1dvca7kk62U3Jaz07+orUA4qLdbEuncnfrUkOUIC
 KOEnA3e2Qb2XQwFUaWxoIhaOWnqJu52rGNysHcAxm2X2ReWBEdTNT+PthSUOPEquuD8ZGSAJ6JT
 Ws7/q1KGv+0UHtRkl53+yZxYxN5tws5AUYheU1AqT1eYjbJAn9H3kvQHj0GVqbBr8cikuI2SCba
 fG3Au0bcRGFjqWEhjL2M3tcCQgLzvdUhkL1C5zn1Bao9YZwd6Okv4LERSTe6R5mVAOVCcdGppC0
 QPA3IyRiqIYmVFLUcdFSXpl9kgYAYlKBRk/mmbM+nQey4/ksps6qN7U5IqMGgwAsIu7ZPsVtaCy
 iEtgGqGKFazE802GCzg==
X-Proofpoint-ORIG-GUID: mWPWCtWLkGJ2egXtwdjGx6dmMcbWq1kZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXyacp9t1IwUw0
 TlZpeqraHY6864lixaR4948VOi89MTfRXlbYUkdNxH70l2lHFpjydd8+A3pHxlV4hGNIbnxiXku
 jxnxA99VI8bnGSyudvQPfQAf9TF8cl8=
X-Proofpoint-GUID: mWPWCtWLkGJ2egXtwdjGx6dmMcbWq1kZ
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a683375 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YJ5_JRR3wJtdSSnXqCYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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

This wrapper runs a qemu command, record command output and plugin
output, and forward both to a check script.
We use this pattern in several plugin tests (for instance, with
validate-memory-counts.py).

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                    |  1 +
 tests/tcg/scripts/check_plugin_output.sh | 25 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100755 tests/tcg/scripts/check_plugin_output.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 328592b28bc..779f9043abb 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -5,6 +5,7 @@ if config_host.has_key('GDB')
   gdb_progs = [config_host['GDB'], gdb_progs]
 endif
 gdb = find_program(gdb_progs, required: false)
+prog_check_plugin_output = find_program('./scripts/check_plugin_output.sh')
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_record_replay = find_program('./scripts/record_replay.sh')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
diff --git a/tests/tcg/scripts/check_plugin_output.sh b/tests/tcg/scripts/check_plugin_output.sh
new file mode 100755
index 00000000000..d942082ad86
--- /dev/null
+++ b/tests/tcg/scripts/check_plugin_output.sh
@@ -0,0 +1,25 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 3 ]; then
+    echo "check_plugin_output: check_cmd qemu_bin [args]..." 1>&2
+    exit 1
+fi
+check_cmd="$1"; shift
+check_cmd_args=""
+while [[ "$1" == "-"* ]]; do
+    check_cmd_args="$check_cmd_args $1"
+    shift
+done
+
+qemu="$1"; shift
+tmp=$(mktemp -d)
+trap "rm -rf $tmp" EXIT
+
+set -x
+
+$qemu -d plugin -D $tmp/plugin "$@" |& tee $tmp/output
+cat $tmp/plugin
+$check_cmd $check_cmd_args $tmp/output $tmp/plugin
-- 
2.47.3


