Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C56C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmZWV-0003sv-9t; Wed, 22 Jul 2026 12:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZWS-0003lT-AR
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:10:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZWO-0002CM-SL
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:10:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MFY3pu1310319
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3sMR1nC0WJ6g3Wl8rImqyxWn4BZfIUb7CkmDbwhese8=; b=OIcTwHvYWd1ruFIA
 gnQZKpDvL+OE1LWnZUWbhQhOZpa0hZVXXR7mw3tyIKxdq3/Y3J29o9azhldWZDaS
 XV2yOJGaGGaKxRUGFf551kY4Qtsp9yeyzqQ5itg4FXOVMRBGwYoZYu7ZRtCCMmci
 X8d4neZXLf6MdsfpfEoKTY4e/YMhYau/Kht7IWajd/9S9t9vDJz1ND3TMLuf2x1M
 5JlYEiBrkVMg5pEcsRRLgKGjAkgwxSrdi6RsdKRNpY5NpCM9uFTXWjkDkRyL3qCv
 T58Bm63nmrHyPDC3NSPBowcDzcwOEzy6vXYXQXhbFWsIIjVEU/gSB9OnZcxGbR+m
 1HAibQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjt799xuw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:10:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8db414c7so222355251cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784736571; x=1785341371; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3sMR1nC0WJ6g3Wl8rImqyxWn4BZfIUb7CkmDbwhese8=;
 b=Jsmr+zGaVo1ufIasOeqsMQAxfQBj4r8hllcku8hTOPpyxUehDZKzSqZbWroqB+6XxN
 H/ipnxETIOvOf5eHz0XdyVCGvqtK70ml76bL0nhmG/sGwsp1Qw9wekfNzv+KXFlquKa1
 E8hIX1tPlUwAH7QU627g4u04bZlcFHIXYXYfs2/xw+pwL8GFgi9vOwiXrC53jpTJX50o
 7vhDklgEDDk3jpvTbm7pdrLHMvc8tK/b8QlG08zhrARIxjel61CIEyUoXJNnDKuT2ZOy
 GGp61EgNx/FZ3tzuQC006foyjtt963E9Q7O5mjV3yU5B9mcKM47hWuZ0pDXre4+ZiRJe
 x2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784736571; x=1785341371;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3sMR1nC0WJ6g3Wl8rImqyxWn4BZfIUb7CkmDbwhese8=;
 b=mHXzM9KcgkucW/+vXdMQrlVBRl2MjUiiCd36E2CIbHSITXFejYZl7QFuLtprEOscxE
 k8laWclR2HPQFAsVcmljgcz6lAeSYexrSYS8gfSxifLn3sO+uUtfwDJVqRDqtYqWgA6u
 4Bqc2HC1lDH9Hxrg8uqgBRbztzd8obsmxRW7r3Yxbbc5xvR3uwRugtP1IexGj0iJBEC9
 LigV3bbNT5S3fomjUNOuR0qnwbeiUDVeBMKTdelLj4Wwr8VXORPnkWFa+ewviQnbDq75
 /sWMCwJdvND9HlevtyBUkktt3qPLkZG12hN17X5u8bNnLFbQx/7WEkrHmNSTktPsrsZ+
 Pk1Q==
X-Gm-Message-State: AOJu0YzmztSk1CaCa6saBzj/VRHquww9+1SBm3Fn37Y5sfIs+tE4DHMa
 XN6BjunrtfiRtMv2q7CEX/wbIUvuMrSk3h1LHE/5pwW9bv4zhjAbu1szhWSPg6w2pe4fN80FH+Z
 U3eSKWmYHVDRSSaOGhWMU/IEU+2TSCcHLLfgfzoex1HyNxMSp/UtHs6lmczYpFhjI/Q==
X-Gm-Gg: AR+sD13fxO3nFoUT11Nn7GaqV1MJqjaf7w0IyOcrWPTbHA7ws/R+rQ1M6ZrVWJUrXlx
 28sxiwt5YdxESAOe0BF2V8l4T7lmRO6Ijr9OjphVR4r4HlAz4R7I8uXyYcPCTjaJtVm4aqyqXpY
 rhPEct+ea9siD3NcQWeOJKFprBk5LkzHU2NXL6io14IPfsAusyhuTnC+3FgrgXbfViCyN3rtiD2
 Y9arEZi+KGeG+1gV9VtdOVpQVRt2GggsThCRD+2hGafsyoIJKqSThZSEkn51Rn3lM88vANmR7Kq
 t7b5Nw9BtyMBOU71EdV36yu6qMfRpOwmqWTvvuoURU4qzYejNfj3HrVi+3d8fw8nrtqg7Zbjnd0
 PjyV5bvPY0/fgs2NarQo6g5gy9lDICqqujhbti2wSZyqAboPjRBVVmsk=
X-Received: by 2002:a05:622a:a07:b0:51b:fde4:cd57 with SMTP id
 d75a77b69052e-5213cec9838mr242945311cf.31.1784736571601; 
 Wed, 22 Jul 2026 09:09:31 -0700 (PDT)
X-Received: by 2002:a05:622a:a07:b0:51b:fde4:cd57 with SMTP id
 d75a77b69052e-5213cec9838mr242944861cf.31.1784736570917; 
 Wed, 22 Jul 2026 09:09:30 -0700 (PDT)
Received: from localhost.localdomain (92.171.88.92.rev.sfr.net. [92.88.171.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a60asm7278089f8f.3.2026.07.22.09.09.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jul 2026 09:09:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 7/7] target/microblaze/translate: fix reversed load/store
 translation
Date: Wed, 22 Jul 2026 18:08:07 +0200
Message-ID: <20260722160807.24031-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160807.24031-1-philmd@oss.qualcomm.com>
References: <20260722160807.24031-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Sr6gLvO0 c=1 sm=1 tr=0 ts=6a60eb63 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=8SOIyxyylBkeE3ShledptA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8 a=Kki4pL45bOIGBibXXkoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 1ssMUivjyF3V3E4g7ZxjZqZ7eLDl4sm1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX49hZZDTfLsF6
 xRZOGqh3s1ZSAPcvYlOyXObwFy0SnvSzyX3lnCFwpGB6ABzU2sI2kuge0yLdniGqJi91jaCfdvb
 VE2aK5/8+rCChbAWFJ/Ob8wmLE3KUATTR/kdCs34vjT4lcSBoB54zBflRMs+ml5PmB2NgNZw+FJ
 ud1JdRM6GG+AB+VLB4addPxb8LBHck/MOy8hoMhKPdzxwvZYsaSfoXmAmvUmP93p/qaIL4QtKmf
 SlEHvy7vDosySPDgqn1qT1iK3OvZUdi3f5okkc4pwWL3KQj0CMlJOrUEfwo3PTn02XdladlYk8U
 viePnXrN+vwWqUgxocsMFYw98ooJltff6qph9HkUslCtS4zm4faXNmmgBb1aO2HQCHR3CZQc9rj
 bp3PgLNrV3xd/HJnpn8FePmnkdXUBTb6Y2lIkGfqRUt7Ge4jC7LPM7CqoSG2FhlnFtwaOiMPzLm
 Qi8XlIFsf0pOAqIULCg==
X-Proofpoint-GUID: 1ssMUivjyF3V3E4g7ZxjZqZ7eLDl4sm1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX2wrmht5oT9TI
 zh7giCLoNFEovmbAi5BSXf50wdltVlH26lPgkjPmRkNGZjOcfghyVDkV740ltqGI5feLZgO5NFQ
 +nps4dp1rQn+noRQnzGujYcJRJweBk8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220159
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Luc Michel <luc.michel@amd.com>

Since 36a9529e60e0 the TCGv returned by compute_ldst_addr_type{a,b} for
the address can be a target register or a constant. However
do_{load,store} might modify it in the case of a reversed load/store.

Fix this by factoring out the reversed access logic and copying the
address in a new TCGv_i32 if it needs to be modified.

Fixes: 36a9529e60e0 (target/microblaze: Simplify compute_ldst_addr_type{a,b})
Signed-off-by: Luc Michel <luc.michel@amd.com>
[PMD: Return early for tcg_constant_i32() calls]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/microblaze/translate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8c530ed1191..1ad96410598 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -617,7 +617,10 @@ static TCGv_i32 reverse_ldst_addr(TCGv_i32 addr, MemOp mop)
      */
 
     if (mo_size < MO_32) {
-        tcg_gen_xori_i32(addr, addr, 3 - mo_size);
+        TCGv_i32 new_addr = tcg_temp_new_i32();
+
+        tcg_gen_xori_i32(new_addr, addr, 3 - mo_size);
+        return new_addr;
     }
 
     return addr;
@@ -637,7 +640,7 @@ static TCGv_i32 compute_ldst_addr_typea(DisasContext *dc, int ra, int rb,
     } else if (rb) {
         ret = cpu_R[rb];
     } else {
-        ret = tcg_constant_i32(0);
+        return tcg_constant_i32(0);
     }
     ret = reverse_ldst_addr(ret, mop);
 
@@ -659,7 +662,7 @@ static TCGv_i32 compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm,
     } else if (ra) {
         ret = cpu_R[ra];
     } else {
-        ret = tcg_constant_i32(imm);
+        return tcg_constant_i32(imm);
     }
     ret = reverse_ldst_addr(ret, mop);
 
-- 
2.53.0


