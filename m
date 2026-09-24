Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F214C98324
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lKu-0002t1-0y; Thu, 24 Sep 2026 11:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lK3-00020A-L4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lJk-0000Fo-Vz
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:02 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4VaE2749204
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t+IG37ezKLS7L6iV5pisKu46qfW34BXm3idgzkkBU2M=; b=es3wMESVP2haUtmP
 6Gkcfjgksf/8TU+tNsF7Pp4+RBemeQC+Y+WWG/A9jK84ZFEV/0SpbHyfppoyTfQm
 lyOsQKe2sh3cTXrxTMlJG9LhbOL7RTC0ZMpvPBLvBQCuoVB3mlVyWU4mYqMaM7kY
 vhvxydMxU7AskOSuEJWZxxHN6jyTvXBYKnO+PdEtbjIofsqW5ZK8l40jpKf29qXM
 aVjzZ2cVX0h/+TivkOSnhuwEeyOQacPoawSOcjSC4sfbKPdrZA0jeIeNLJ9OEmsu
 Uy9EvQBI0GJrH2+SwjogwAwuPXbYYV2e0xmpgYYRVXaAIIJOQkL3IDi14BPl9lWx
 8xi27w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1s919g7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:24:59 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-985374f150aso14511241.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263499; x=1790868299; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t+IG37ezKLS7L6iV5pisKu46qfW34BXm3idgzkkBU2M=;
 b=R+2rg71yHAQXdOn4TwWjQfaOF+F/3Jmn130feeu+gEuu5c0DLejw6Oh+oQwf5OZx6c
 kTXZU6na3y2jPPhjdn8vSUe4sw4pKotj+gPOR+e6wPk8PVch5jYX9JOeCu3zb+74zJfk
 N+r8D/P0RmhDTdyW1dQeH7atXPVjP0RbZ9gKGVHnqWhpIk1956WjbWIyXQiFK/uyjcBW
 e3W4Ckhq/C+we9fCmlAcBjmZcym5MOspUM3ur6VEhen5cgMpT2FwcbYrrjXU18Y1FMRP
 Ryg2bKeYV24WINNp8k5Nif708zra2BW9wcyDiZVqlmZiS/6ERNXZt2XZEGEJ+6YsugW4
 LS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263499; x=1790868299;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t+IG37ezKLS7L6iV5pisKu46qfW34BXm3idgzkkBU2M=;
 b=E6uyVtGU+TkMu0PniVS5i2HFhC9lGamGF8TDaSPKk6/QbSCmSos7IkHopY9kditM7z
 gY5Jzfh2kA+ivjIZdbz3y/DMJE1NVSOJ280zV8GSZbGlOpDsqXhvyaNBLJrKysqddZ66
 dIm/CY8oLV9QDXjC4Cz5QQiPOtzxRpvNSB/IgFEOHL/1vXpXrN3+CRhT5RfTBNkNC1Qg
 2eP/RtywrgPPQoKAJO4WjtHipkr5c13EzrwxCgUmjcodzGfZ1dFrvMqWxS7vpjhNtNPg
 AaPHi6upz7yl85w6iSktSaYMxksUjczsbjrBFLCiQWB9hLyfYcKcTeA6rnXW0QWV9179
 gfgw==
X-Gm-Message-State: AFuF++kx7Cuyb5vRkq7i9U3V54c/tEQ3XVz4b1QxXzvwBlXvU3vFy40c
 Cxq1XgEehUTLklbrqKAWWiPsjwvwi/ZN9fPqQ9JXtIXvsyUfK/HzMWyjDg3ly2tKCOyqZVdOTrt
 nPEJymwlX6s2XVhNhtH+GvpQp/pTjE9VAdENFlv+oFN8DDq0tgjnijTOugWzzmF6jYw==
X-Gm-Gg: AYBFou2KCbKNALZwd1InFhsOLwvJd3aEZ2vBpgC7soVvqPMGH0smVaC6siTDybI53xg
 YX7v4kGJXPaRcniEEJ7vjwFxSiywcA7wWGuPO5aDUE2v/kgA2QkcFGvuCoAuMREF9532mvf59e7
 vuoIGIWCJawayfNOK1sXVMzVgZbuU77t/H+JZ9STlUoh/1GIPWm+gtImKxcsSd/p9rp3PCnO5Z2
 uyzKB1J0lKx8ELpce2NlL3xCbgNx8oZJgEK3OFaQ0IQ07VytGtZAE4NGC2YgqPKREU14XgxnUY+
 hrtoDns9RAUHeGXKqnqhr6x00jiJBu73x+BfHwp0OymxifuhV4Xg2C+NChrC07Qgvx7S0lAaNk9
 eCSsqRtVfThpyzRCJUz14lejdi307dt71DdQASmO4
X-Received: by 2002:a05:6102:3ed4:b0:7a1:f7d2:e80a with SMTP id
 ada2fe7eead31-7af1eaeabd3mr1320462137.18.1790263499184; 
 Thu, 24 Sep 2026 08:24:59 -0700 (PDT)
X-Received: by 2002:a05:6102:3ed4:b0:7a1:f7d2:e80a with SMTP id
 ada2fe7eead31-7af1eaeabd3mr1320449137.18.1790263498502; 
 Thu, 24 Sep 2026 08:24:58 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877a247sm16120226f8f.28.2026.09.24.08.24.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:24:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/18] target/mips: Use gen_mxu_logic for gen_mxu_S32SLT
Date: Thu, 24 Sep 2026 17:23:40 +0200
Message-ID: <20260924152353.36209-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX0ssQ0Kbkaoo2
 gucYc9A324BCiafSYZ+B2w7YEDz7K2++4w+Bo7f9QcDBNKoKtHthDs3PBW+nKNL2mdZ9eqGQjqM
 AHIiDpr0G7J1Hr6GgJ32wtPduFy8aKv/g+lyecCTJ43znRgw94yzh+ljMZugzTLwlPPDMx8Bhqw
 nSEF/G0UVXlChfke3uWmEzMOpI1iEBo2E5t7T33z54FjGhwDgFvRLZBTrRHMfudBAPEyJ5ZPp70
 FZBUHxw+ZooeZILEk4Q4MfmwDdwQoELSNWeXjBVrBxmBuyJVBc3rlvosnCXbAAKaKOIeQJUYkZE
 4AY2bExOJwbrcoB3Jaqcf5WCM5gAGYkwW6fxYMjsz/dxIm5DaSwgSc6Ey2SG5Pj/1YiEQhkDmuW
 INPT92y+xHzwcg9IvbZhUL/KHkkMS5LTZR0uILeJmg2oTPw7+Uj0s3pBX9Ur9LMcB7NuNSWc/iu
 gokkJxplcgZF+UIDzug==
X-Authority-Analysis: v=2.4 cv=VPxIDNPX c=1 sm=1 tr=0 ts=6ab540cb cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=XNZCjgkWDX52U-mK3XcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX98MY1A0FY675
 WnLwijUpdMHTNJmnjehOv2tqZ7vJ0yyJ+Csz5WaGaZnl7XHlyOzMaSY78n5h1GoetjQHfSD/uAU
 MSNcMV2MweMKB26gccQzlfaRTyPpUpY=
X-Proofpoint-ORIG-GUID: y6ba4gsJP9nwMc2hLweB7dRKrnAXS_12
X-Proofpoint-GUID: y6ba4gsJP9nwMc2hLweB7dRKrnAXS_12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240063
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260914230901.1781309-6-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/mxu_translate.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 4b2c264f031..293eeb46c23 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -2313,34 +2313,15 @@ static void gen_mxu_q8slt(DisasContext *ctx, bool sltu)
  *    Update XRa with the signed "set less than" comparison of XRb and XRc.
  *    a.k.a. XRa = XRb < XRc ? 1 : 0;
  */
+
+static void gen_setcond_lt_i32(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
+{
+    tcg_gen_setcond_i32(TCG_COND_LT, d, s1, s2);
+}
+
 static void gen_mxu_S32SLT(DisasContext *ctx)
 {
-    uint32_t pad, XRc, XRb, XRa;
-
-    pad = extract32(ctx->opcode, 21, 5);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to zero */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same registers -> just set destination to zero */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else {
-        /* the most general case */
-        TCGv_i32 t0 = tcg_temp_new_i32();
-        TCGv_i32 t1 = tcg_temp_new_i32();
-
-        gen_load_mxu_gpr(t0, XRb);
-        gen_load_mxu_gpr(t1, XRc);
-        tcg_gen_setcond_i32(TCG_COND_LT, mxu_gpr[XRa - 1], t0, t1);
-    }
+    gen_mxu_logic(ctx, gen_setcond_lt_i32);
 }
 
 /*
-- 
2.53.0


