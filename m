Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA10AC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNl-00058Y-9L; Thu, 27 Aug 2026 18:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNi-000537-OV
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNg-00065P-U3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:34 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLoNu218267
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u+5WLdDS5F9nDMV/ufO3bHTKlXlRDTglwSfIkNahPt8=; b=oJba1RfNkUnlNIP5
 mqSeIey+4A41Hz9ZeVDFK+7scZyKLfLQhWxZjExJ2MXD82Ahcs2CQXGxmtjJBR4C
 MUm7b8xL7nKf1Y4cAUDxVK2DupedchPv7FDk5MPeud4amrhZFEAO8tP0EH8J0i+U
 0Wt3uu8EXI5i9z/9N/5IH+Ed3H4Gg/vZ9LjLlZOsXtZS6R+3hXJap741uxsBliPm
 FxAeXAUbHRmr1ZM9POpWJaJppTEMm5Ynq+1Cq7ygqKNeA9P5VhCgHdZDQD3SGyJy
 dqF3mQDbOr5Pjhm/DfL1MKKN+I4GQSacg9K6YobDUgk1oEpNgiyX3tv33cPQJFme
 PJE/Qg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw22ak-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:31 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1c057f480so437185a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868931; x=1788473731; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u+5WLdDS5F9nDMV/ufO3bHTKlXlRDTglwSfIkNahPt8=;
 b=T9L/cB8yk0Nt52dAyiPvB5t1GyNIX6HWCF0dG0fMGlO/HcpkXeGDG9T+N6XRlTMMGG
 VAGUin/ndo+EVUThNL/3ZE6qE8DJjBsskN2s+a72X9JxcvIUMY1pRuU5IxHXkQH6EWom
 AmQrBPeoGyrk2dqtAKc+DtHarWfZzGdAmGtY/03IVGC4m3piAYt1t8PZnyyv0/DsB2WL
 L3RiNytlIXciSwnofhmQluwwcjaQnEPNXOSiqo3vr583W+HFGuFhtJCjumy4tzk0vrke
 mKqu+f825ZzqtvGsQHEBlI/jS6FrVUio18x9w6/jWIouMBOfySpr+uamEYzWdaf2fAvw
 c5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868931; x=1788473731;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u+5WLdDS5F9nDMV/ufO3bHTKlXlRDTglwSfIkNahPt8=;
 b=jA9TBUxtHMyIIGvUVorOvjm+r2P1tuPYHGD0dwr72LHQ1u2L0WKR12wB/WyvTGxEnW
 5wfQB7zU641KRi6H3SZNfCxju4ZbgHcJgsFzuC/6lMEhfawqjXTW2oWew3ZgLdwxBIMc
 uf3y2Mghcgl1oSq7j5ZJhdqzt0IHSkSn4Az15QH1lOJy1lqB0QmBqzg39h6okhJt59GB
 Qo3sAzwDLHB3veZRRoGDp8v5anFpFYSEwqGkaTimTDZA5BHgn58oezmZ/RoVMjeA4Fgu
 aVsgAmZpdqKszcm692+fCbNaShFQEg7xBbiUmZjs4ihSyl0ZW2OPwpkpx6KHiSmyHSkf
 Tu+w==
X-Gm-Message-State: AFuF++nVUlKhqKJeulpPExUzbqARCcdVE6A72oieoCj2y/ogzExNvmA8
 kEKpKylrzgrzMpvACEaWMHnxsaO30Ksc+I7ASy+5PWAhCO6X1IBMzwCxJPzZEU4q/5ceZ1c3iPN
 L6c2iOVY+IPNYKniOud3ceivzBb89hubozQM8XB+yEeAvKCD1DAFiwqQ9FT/vs98c+g==
X-Gm-Gg: AR+sD10GzK2lFfVK9zcosbSrt9i/INYVgH3kfnGQSMaFh6Kd3VfD2yJQcOiy1O3DJu+
 d4VSlvLUcfA3o9wnok1uGzyKnGKiKcpce29DDebG+oEJzkXeckPjVDyQyiFkmwA/qyOdQzM1uWz
 9XRm+Xb/rYpVRZnsFczMbNNtViD9UjlIFBBaw761K1CDPaXK+Hu/oa+Dz4bphEGan5qFqfFq/ZU
 qJQqbwrsRKHCrqsmZuUrtHqCKUxngc19JiQTwOmpJTLVcTAFiKRbrq0rwRs5IbOr2wbwxvpEEq6
 oGjnglGeCKW/7whRw80J/XtxBG9hbAk5/OlyZfclO4bHwLJxmzQMy7iC7KjrvOYYtp29UvAfUMD
 Ddh02SQxERomDPvH6nPRbT2z6hfx/LgeJtCgDB9rdS9NidHFEtKJl7k6zwpg=
X-Received: by 2002:a05:6a00:1702:b0:847:9aa8:d3ce with SMTP id
 d2e1a72fcca58-856276e7307mr4143871b3a.2.1787868930998; 
 Thu, 27 Aug 2026 15:15:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:1702:b0:847:9aa8:d3ce with SMTP id
 d2e1a72fcca58-856276e7307mr4143789b3a.2.1787868930515; 
 Thu, 27 Aug 2026 15:15:30 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:29 -0700 (PDT)
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
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 018/105] tests/tcg/meson.build: add wrapper run_with_input
Date: Thu, 27 Aug 2026 22:13:39 +0000
Message-ID: <20260827221506.91574-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bwKc5sKSS6jdDgds946dpnh15dHWksDQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX7r2qXCY/AekI
 3Phe7xig3edHr9RZItNoTZudhAwpTFKNGVD3EczlHwoIIRoaw4P46kuZA2GvXN2TtnrAtqcR7DD
 4aOpPxLM48C5OTIyz46HUPL2DmXEsAo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX6S1C8oA/u+EC
 FjDurVLJRNqRNXWflbQIEEPZXvVebLTVZtGLJ0HA5K+6QwU0oeNsxudcVded++3/Ffb3vdy8Sqq
 y0vogdovB/ISkj0UH9zHwbLXqHY/9XXRMQz5Fw//8kMZ6Amwnh+tYh2JiZs0UudneKg1zmKbvHO
 ZKK3SckGKHo2RbXrAtw8KzfbEy29ZzXWfqCIPp0fPN2FJgkWOAW1iNWOR6nLDovGz2KgH6W6wWm
 8Cxq0/WNIo8ceeTFpryMNecmXUb1SIatui2dg7FbQJGAYmmLEB2SocC9ik4mzKRrr4T9il/38r/
 ElPGM89fJLJcUy27IH6GN+obDH5QMmGQ4R01Ae0NhtHgCKrcRz/U03Yv1urNkH3XIq7Te2HI0kK
 5LiFd60wyS29RQY13JLIkOArTmHrwNkxhFlMH/GsNctLZ9QL1PrjCqf4HRhhBqJNIvf8pLwA1yU
 ShvH5pP52t4zSiYAFUg==
X-Proofpoint-ORIG-GUID: bwKc5sKSS6jdDgds946dpnh15dHWksDQ
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a90b703 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=RTlGP_lOJ6CgmFeI9PgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
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


