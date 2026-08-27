Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61722C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNw-0005oC-Er; Thu, 27 Aug 2026 18:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNu-0005iY-RE
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNs-00065d-G5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMJsk1118121
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DRZYWFLWQO1W8mA/syKCtsAYUhUhOMUc9r7nLxakjOU=; b=HTOSanQjyH9yTj7j
 nV8Qb4EsMasQcsZr2iSLX78qDbE7QAT0taE/HDLybvcFhuDdQQ6qY/8e/ZHye+l6
 vmLvx1fKaOhuoAhIKi6faacRIBuWUx7jMrmO5xV16DArJni/9XffIKPZjWiiDnjd
 2tZredL6qvrH8WeuGMxXyO19PUEfLnuD6bd8/aUw9QbJSYODJWMthIry8Idh18o8
 DeRGMgS6W3qGzH0uJVg/dZlmo5uVn25RwGqImTWa0fJVapv/3nHagPMufdkGKZNV
 OQ7X38EpQbaaiYW1Vt7nBjHJaKuPYCGTWeOtN3E+MYLwxMwJcEBKEYUGCeJBgq9E
 lH1Zrg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0hffk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:32 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-85321e37104so486112b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868932; x=1788473732; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DRZYWFLWQO1W8mA/syKCtsAYUhUhOMUc9r7nLxakjOU=;
 b=TV+czAnA6kF5wE4KKRoXzJfK9AH4SLoqA9QDAEWXmjNChHvlyheuf4VGZ2bbsVu3S5
 VzgKEBi6vwBY+kB9LvLek7p/cGyPgt+jo0ndxdv6N7LQ3RD272/6uzUNatVUvQtYvBAP
 h/qhWf17Vqy0zrbVPJHBySp20Ra2stKkjLqfBVFJ2ioI+eFRUdmJCxSocpA+pYS8DdBl
 hj4f2vIbeRv2t/XJcOe2S7Q6ZeRDrFADieH0reEOwZHvBrW/UH/23x+Jc36NEx90pOIT
 mw2QKHltpMbJtFUM12iofVn8uIBsEHU9PHTh2WozZj/LI1tPHGHud5PkNg8nhmPSwfTn
 i+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868932; x=1788473732;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DRZYWFLWQO1W8mA/syKCtsAYUhUhOMUc9r7nLxakjOU=;
 b=a8xeJCQg97bFc8yabT0sxAgnp2lfhbOWVcsZT0Dy00YVoLvoz8iMxhHTqGsZyEevy6
 T5fz9GmrbTRXc6Bke5IxVKrxlpJykveCpqQ3Vv+j3OXdqKjB/UshjF9kVnQFkQ6LghgN
 vmHjlJaUPWOsxL3cA2YPfASNirVxp3oJ9YH9FcAj8j9O7BQBXoSuFo22/jMAzocGDx/6
 48TPO36AmJRjepLsL8aDhgbOgMWrIWvpZ3iWy5uvF0ganfrlpv5imyXUPeSksBxX+qFO
 oyW/UZAY+jdu4aH8obVHkVfyJVRFLtET3XyROfu8qVSYOgpbzmiDkP8EK6qryYbzIOhK
 HtGg==
X-Gm-Message-State: AFuF++mBOON5KufpW+jIosSXdeaKhuGvuxUvntdtLZFv7DDVLPOFJdx1
 RgvgNJ8rMxPeuZvwvSMPQoxD47L/dctk1qixRxgg4OKcxB7owUcIYrigPZ6r/EeJREeIHVXCKXJ
 GOb51o8jUKq+xBEVP753rMiNTqEzxAmxWAvzSqdWfweM+sxIWCTSjMpOmj19xKgD1Tw==
X-Gm-Gg: AR+sD13CTz+oh6KgmS1JFaskEp4tgOkwLB/g4IAQGh5DZqsy+5yVdNZJmd5KmWYTt1K
 PY/kURNeisxaXO2TswW4LyUu/96BSJM7piizXmABvEIkd4TSrTPxmgbeRuy87LhFULnFZB8vQWe
 wOhGzgF+Kwb2NPcDJqIYzrR/miNIBEm7l7nr4JNS89zIgLJTcU8JzwQrXaAmPbp53LZPFBU9n6G
 q3w84oTQCJFLyhdCFPzsbdX3939Ny6SAL0E0R+EAalMPtzrsKZgjDc3S2zVasoO1EgS8+JURTvw
 oYUqazYhxyXVkOfJcmnCJH8x/8E+N5rn5iAoJsglpHZPohc9s5L4RFfMQRE672g+Ih+lHzgMzgr
 OBLshgu6431GTQ66pe/y01m/j6O6A79WV2hdkrGhHk/pgXS2+R6nKW/SgnNo=
X-Received: by 2002:a05:6a00:9505:b0:84f:dfce:966b with SMTP id
 d2e1a72fcca58-85628f65f09mr4121255b3a.8.1787868932015; 
 Thu, 27 Aug 2026 15:15:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:9505:b0:84f:dfce:966b with SMTP id
 d2e1a72fcca58-85628f65f09mr4121162b3a.8.1787868931619; 
 Thu, 27 Aug 2026 15:15:31 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 019/105] tests/tcg/meson.build: add wrapper record_replay
Date: Thu, 27 Aug 2026 22:13:40 +0000
Message-ID: <20260827221506.91574-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXzrhodO4ocWWr
 zpvDZm06f80uU4Q5PJaXVm9+3qMhNQUMqYYkbOzLzhfpeVEWqG1DCfj1AHSD0M1el2fsca14+XZ
 0QlovpShC9j4ndUiEq/fxm+bgPXElULqABTqA5ufjmgwDubjAErm69ppqs27eCLbfvZKaNn5juU
 GD+wXAJPMxmVbBUe4nZkZQFErCLBzucEse2BAON3K3NJc8Pw57pg3ykL4gEgt5SPaWvP1CYwEGM
 WxCKcCsEVi5fcaKJ0qF3SJUF496ebWT12pxt6FcEvblNHjFsoTzRaAT0mt01aQZdABapYvNMWeu
 w0ridPJH5vjUUj+J1a2mmMfARBB3l556B261Acwou06ika+85RPonjf3P5vTTHo1ZN9rCaHreaF
 mwrHCyQNu6sfKSai6G1Wzb3NwmwUeadiDaAi61WuZ2G0h3w9Ub3V6CyfFizXtcyHMp63j+1n2x3
 brPLmtK1OCQAY68dmow==
X-Proofpoint-GUID: YvTiY13NGlIY2cCwe3xNU2iB3ZEw0MrF
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a90b705 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=YUi3GN9lKCUlzkXueeIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: YvTiY13NGlIY2cCwe3xNU2iB3ZEw0MrF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX60dXRB9qt8fS
 JyIjCdL4SjiA5U1gSVDSNxc1rd16iLzCnPIaA+Th3pPf3OOIV0UHMrCW6fZs0BIvSbGMX3Q4Fno
 Qeh38xvKgLnxO7KN5R8BSIL1hX5zibw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build              |  1 +
 tests/tcg/scripts/record_replay.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100755 tests/tcg/scripts/record_replay.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f2c5d77bfe0..328592b28bc 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -6,6 +6,7 @@ if config_host.has_key('GDB')
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
2.43.0


