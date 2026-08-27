Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276A3C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFs-0007JT-Tg; Thu, 27 Aug 2026 18:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFr-0007GC-FS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFp-0003Il-OT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLvwW1117698
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u+5WLdDS5F9nDMV/ufO3bHTKlXlRDTglwSfIkNahPt8=; b=LTcgspXS2EI62Swr
 Jfx+/YUGI0o2NzwEThLKODyj95r7sXll8khaUJrk/mVkicUKALCz4XJbStuFZShG
 RjvmBZe4jlZzxb7/dVfe0zu7s2WpdoFHDAi8+0wLViiNWod1ef3eKjYWDUDDw5nA
 DO8OKjOJpQ5N8s6mRZbCMN9P65DyQEv7aIZ4MxleukFGz3w/gZhVG+zcMjeUh/Ib
 XGhhwIwTEXjzmzCKG9HR9VoppVgG5dHto7H0VIyYM0dzOld0Om0eS4Dt3ah228w7
 QUt6VS2pwiSlywtoQ3SNJtng5ujSENuZuDX+yfP0/ox3ZWw9DuKQK382xB7H/cHK
 3ysCyA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0heeg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:14 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-85415923c8fso198997b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868434; x=1788473234; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u+5WLdDS5F9nDMV/ufO3bHTKlXlRDTglwSfIkNahPt8=;
 b=N6hTJcBK15eKduoeKcJMLYQtJEspPk30jQmgsxLlBt/9XR3w0w8EnURfSW8RIcHscS
 PlwSaW36ML4QPU9moxZmSLCRAdEDCilX7SMh8AlUwZQ4Qkw8qVL4UkygcKrd7zVd1GFT
 RLt+9TU7ioMomXcIzXfC93l5T80kYG0gFIhW1SmBOCci2lp/avbH7RF7EFGPJzNXkd8d
 hs1Y/PVVKbDviHORQhZc88vDmE2cRZSuuX51MG+X1bhN9Yra5So7SsYfXsNF7hxViUlh
 uZBUxySyqytajwqYPpH7pbiRUXJM/DkutuP//EVHf4QOnIJp0yKOigyPVWFOhq6lDRk1
 xOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868434; x=1788473234;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u+5WLdDS5F9nDMV/ufO3bHTKlXlRDTglwSfIkNahPt8=;
 b=skEdwib3XwV94Fxzqv//aNR5W9IynDMmgowjGTxIPmtfFWi3VK9bkox95lZJTUD1SW
 1z9m477TS719PB5pRoUpC9M+c4MoGsp+t9uNkR2mIVIJmHbUam540ufxZ/wQJFcCtoHJ
 xMeiIrka1eRSxXzGAVYtst7XPW/YRYkhZcsXkWqRCDCBNDFvW0Fk4N4amLqdglhnZKho
 YFgcyvM2uttsIQlsGP+7av1Srja8DS/DGlh0XjGKKl1UWPUi9YcmEPsda7cHxcro0Uez
 eBxJOMefVlUTFPv2STCr3mNETEfaYv/kmeBvjYnkfDtsbfB/5gqwuCajXK1YCg4YuQOM
 vIvQ==
X-Gm-Message-State: AFuF++mjMEkfqSqchg7POiZsXDxYt4a04hT+sCrbq5BeNuQVE1yO5q/c
 diwD7EFxbG3lEthK1LDHIha6GMCt6NLopbfRplHg/dqaBOMKM4xuRqR7tb3T+rM8uuWvKfEfif0
 5xhLtqK76sHiJD7LvFWp0cwQolo42JRpmvBFdYwyzcSGqMcRuWAfgHvTi8stp892EmA==
X-Gm-Gg: AR+sD11P/kfYjOhzGO1gELclV6T4rnutxg0n9fSI0UL8XPVnUAj3WtIDjM0yGYXDgX1
 kUNUm1fW1vl35DeLLWqaUzur+QLj2R+s5Dos9Rcs7Z4+sYyi1rKCJTib0awLSO5EZaSJobpPHtr
 JttTDLPbSTYKZ5+22QJrVzbTpzs2x1CrUbx0X6HqIJLfMqRi/StlbqnHT/gYl9611Xz8FiWWB7G
 bxGHB5AVc26rKwVOMYH9lLhhBlvoAkiH6ndiLIaBxV0HCrvHPEfDsNUBPX1zc0HXGY3L0gc1+sS
 7UeBm9470WtlycIV2mrpwJQ7xFq6morh5gx5D1984vSlgWMzrf9o68Of4Hd+qWjOaU08UAZJK3u
 XwgDdCQaV/eN69pBCCZRgo+0ceL4lE7WqyGYM5IeY8569rx4FqgMeK9RZE9A=
X-Received: by 2002:a05:6a00:4187:b0:851:b03a:fcb with SMTP id
 d2e1a72fcca58-85629543442mr5339327b3a.14.1787868433713; 
 Thu, 27 Aug 2026 15:07:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:4187:b0:851:b03a:fcb with SMTP id
 d2e1a72fcca58-85629543442mr5339207b3a.14.1787868433265; 
 Thu, 27 Aug 2026 15:07:13 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 018/105] tests/tcg/meson.build: add wrapper run_with_input
Date: Thu, 27 Aug 2026 22:05:12 +0000
Message-ID: <20260827220641.84885-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX+BOyoOYPa5qG
 uky1IheRIXYoU9vTb69OgT527lM4RD//wPOPQy5MN4nUuI1WqpkTeaSu25Vi3qtiu1pEERAP9QF
 uRmQGkIuVE5MhzBPAKrkq3Ht3wwAC1ijWdYMX54i6EuJXHQ4i5+TEWkp9a/JwCZbY7rnhTHGTz6
 lrtGN+iPqIAXM7f4sdLheV22U15oEmRxI9uV98isZQYLJqXPl6Pmja25qXn/wXh7g4oF28EJ+x+
 qXe6dsBKqlbGDDku0NSXUf0+Dp/sTm39EXaLRZuVAuuQlJsnQnTW/uhw3xht+LmEpZsXp0fsspa
 nPkFk3dno0KBB1l5KBOXXHRrqP6v5FEQ9+WmToZ909ifKCRlS4+njN6xiu5MkSinXZsFfxNX87a
 jr8WTiIxSKKWUVJ4cts2voOI56CmV3w5AVJZjxht+gKWCDBDjmVrHim8jw0ykHuETIN1HqSDgkF
 wCAtuSz7hvIwvliO8gQ==
X-Proofpoint-GUID: sz84w6bVqaqZK5D40JhkhE0U6koSCe76
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a90b512 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=RTlGP_lOJ6CgmFeI9PgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: sz84w6bVqaqZK5D40JhkhE0U6koSCe76
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX99cxvoQAQwBi
 jQcjHGm04xuY7DsZDwgm2ARuwW2ECpSvFQVOHtdcU0AOjK+568TSTiC4j91+hDYYpEWWBxWtcX0
 5X61UdTEIj9SpaEy5rqWa2frYI/lEpA=
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

Semihosting console tests require console interaction, and were flagged
as manual because of this. This wrapper automates interaction, by
sending a specific string on stdin.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build               |  1 +
 tests/tcg/scripts/run_with_input.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100755 tests/tcg/scripts/run_with_input.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c718555d257..f2c5d77bfe0 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -7,6 +7,7 @@ endif
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


