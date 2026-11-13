Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3B606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XaL+aZxm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WJAraO8z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtuj-0003OQ-Nh; Fri, 13 Nov 2026 11:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtuX-000352-EE
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:14:01 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtuV-0000LW-I4
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:57 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRCmi3618642
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PvB9rE2zU+deTzliT0JtSzIBzVyrGpyq8K4oaqKLNWA=; b=XaL+aZxm8xhgwrqI
 UxTl31DXAqsGxwGftrYWQ4W8qKq6aW6gX9tK3LVQYv808eiFoe/NoKG/ANq/OBwy
 SheAvkRGvmwdHgT/SFSqx9BXi0L6bcyos8Uh8EShS85EAGOT89fRi/JwqJ5+PV22
 0s7h3SLU9LwWpM7VWT7ypDsqqTLapo/O+2M556K0BqkHGBqUDMvBG4g5plEsTDFC
 0a92PvE5S96gMcoyTnN2B2jnvhGPq6eTWM4M7Js7x2Tywbt+e/g8lQG91yXoJFJP
 wUzI39YAzhPPlJxFoR5ytN+TRYWHTmT5p8FzwtdS3n0fc5PK4Lfw8LAAKw6H0t/1
 FFna7w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwg1bct0d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-944101e6367so207087285a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586433; x=1795191233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PvB9rE2zU+deTzliT0JtSzIBzVyrGpyq8K4oaqKLNWA=;
 b=WJAraO8zqtOktoDrm7wNVnT1qfXPzoEw4DFEs7zTi0S0TJH7CI0zWb3TAthAFPZWwQ
 9PQxsZYoP2iBNEqBTnyIQN5p/LaO3xgcTmEEnQm/ZbCiSkGBdg9DRYjzjr0ErQ9J3B5K
 i+ZVcKJgm2HBA7cC05gOF0KBjPRl/5HeMgVChQ6qw1QsdkzmN9DRSFOE6JdoN273rln4
 SpLTNgqIH8vLf5LmtTerIRfIiMnCGpwmp9fvaYozHcVVBnaTxhP3glqs9A29usxUD+U1
 sYP2x6V8Zt+F56xgAIkGWFZcJAggModrnlk77lexEjiBmc2r0RPsU2GtFX/BoKVKGJtD
 NGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586433; x=1795191233;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PvB9rE2zU+deTzliT0JtSzIBzVyrGpyq8K4oaqKLNWA=;
 b=OTAV3gMbPe0+clWFDONONX3m4zKvB2K5nXHwm1R6G527mb4yaMMiAWbEjoaYfInEzL
 nZznkbNicHAjLEEqfmUMsqcGE3hnLO2g/XwbbVSRA/pP4FmovFrutbGpv8j0bk2TAldV
 9PBvi+rTw72F7WExZ3YDv7Jij5GDruCKc7XMeX0vh6Rs/fmM4H9QkEnmDgbDbnBLc8gA
 maMgK+8SSZDPZ8gvEyUmXDV7O/oJCeqFmL6WFWUFsFhUPHTXTTIKmgchztZO5ieMTc4S
 cbrvM1brEyTvspNw/xtTlkWjqgtiSA/oqxM0XqRIZiM3NkDaLIbuQVzlCc9mUtO0oCK4
 f8AQ==
X-Gm-Message-State: APuU4Z9jesQ+qbYfmpNG5n7b4cPKvUzwk9ok+IolcLiUnADw1sr+z45j
 ZWchWU2sI2Yppvisd6Efz/dfrGOcxx3zcCvwV92B3WLEnBnE5QUiUngbBJ84pCCO1YAWpsx3vO8
 f/6/M5JuGBp3TrZnXVTUWtGnZF4TxqrnAlf20gYDg68Cgbwrhmj3gUjNsdgfqoeGK2167
X-Gm-Gg: AYBFou3GbyMa2kL3kzeb6bKmgg6GskyTU3d0VFVrm1U3DpEjoQ/wHc/8LKnZb7UmNUq
 13dckrP3l4JdX/HhVUXZfpIYiKYMfBoYLhGbzvkUMSPXNSgBvEGfRFgGwdebKEIK7DRAE4tZHlQ
 qp9T4gbvJLVnY2sRnKc7OL/CDeQcxMUB9nirgh90e/e0C+BJcE6rTBIAZe7+arrQXPTI8RMkObB
 8Vd7Eg76RQhCc/SBtslFt/cMGYdnMFggRVLCiEtLr5XvEe5Q8pAb8pdt4qOTmsEb7AjIB2kkSvn
 qncD6c+f1fKE5DZB4/eOeXShIjaWVzzn/aGegJu1iQcE8c76p5cbDmLLv7EG7+RvQXXE2q6Vi5g
 0OG7zrmMiLE1fySECjeFRcq6MjACEGK5zmXiajXEFsjw5nrmtpGEhpUuNosgzQ8vi6HaNzmfngd
 7aWoFJ6BbBsM2c9A==
X-Received: by 2002:a05:620a:444e:b0:93e:c12d:4eca with SMTP id
 af79cd13be357-9493316e8abmr967342985a.42.1794586432919; 
 Fri, 13 Nov 2026 08:13:52 -0800 (PST)
X-Received: by 2002:a05:620a:444e:b0:93e:c12d:4eca with SMTP id
 af79cd13be357-9493316e8abmr967334785a.42.1794586432225; 
 Fri, 13 Nov 2026 08:13:52 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608d10b2sm9193477f8f.44.2026.11.13.08.13.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:13:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 14/19] target/mips: Fix nanoMIPS BLTUC with rs == $zero
Date: Fri, 13 Nov 2026 17:11:52 +0100
Message-ID: <20261113161158.25811-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6Q+0h9l c=1 sm=1 tr=0 ts=6af73742 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=UWHVqcNkj762p7UEE3oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: aeppJduxykYLmzOcsX41v8_4t4GGqFIw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX77ESZLTzw2J0
 ZHvUAcRJPIoXpApCNsvwIRLvEysIL2JhWfvDO2UzdRlh250MlRm1BRuM0A2fGJIpzaxpz2Thswf
 6B2UJr0y+8n4uOQXe2SXBz97Ekb29pmbLMXf3vh6Hdnt99y5ELBRqpSMk+eRO6fODzX6RJi3/Bx
 jOGTJ+BE/o6k+j4+3OwoomsCqya70Rkx08ioV6NE8eB679OC7SVaOgBOBaFNqaEcE4Ia1vT8hNW
 YGaKP3FlFMbWWmyiWW4k/e5L3yLOA9agbU9WyDs6ncX0y00Fcdor1/XsyUtBskeO9Fwz+7gspsb
 BciYFZYua7KuZU70Q8St28FLSO3rgs3F9sDvHxYLxJIfHkpSnIw5jh1EOcZKpm3UHstRau1mf3l
 bXhEEJCCVyw8itIl6Q6IQVLBu1vxjUofIr6t5AyUo4OSUpv8HkvX79LY3dRnLY9iPOK00ENNw8E
 zrrx2dg4ImNBuokhocw==
X-Proofpoint-ORIG-GUID: aeppJduxykYLmzOcsX41v8_4t4GGqFIw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX1sDnnR90SP34
 Y7R7cu+v9+ngSFtVIuSmHE5xuT8zl/1+Q/PPrukIo9VX74PsuCq5rt3ZcQ6kEpSKaZE93xkkzdN
 IXmX5PLYulJD6j7RDiL1QivcA0b6bZs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

BLTUC rs, rt branches if unsigned(rs) < unsigned(rt) (MD01247 p.55).
With rs == $zero it is taken when rt != 0, but the decoder treated
it as a NOP. Only skip the branch when rs == rt (never taken).

Reaching the generic path exposes the R6 BGTZALC/BLTZALC-like special
cases in gen_compute_compact_branch_nm(), which set $ra and compare as
signed; nanoMIPS has neither. Drop them from the unsigned branches
(they were unreachable for BGEUC, which the decoder maps to BC/BEQZC).

Fixes: 11d0fc10b7ef ("target/mips: Add emulation of nanoMIPS 32-bit branch")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 34 +++---------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 25d57e75a0b0..524972b24a98 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -2419,18 +2419,8 @@ static void gen_compute_compact_branch_nm(DisasContext *ctx, uint32_t opc,
     /* compact branch */
     case OPC_BGEC:
     case OPC_BLTC:
-        gen_load_gpr(t0, rs);
-        gen_load_gpr(t1, rt);
-        bcond_compute = 1;
-        ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
-        break;
     case OPC_BGEUC:
     case OPC_BLTUC:
-        if (rs == 0 || rs == rt) {
-            /* OPC_BLEZALC, OPC_BGEZALC */
-            /* OPC_BGTZALC, OPC_BLTZALC */
-            tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 4);
-        }
         gen_load_gpr(t0, rs);
         gen_load_gpr(t1, rt);
         bcond_compute = 1;
@@ -2476,28 +2466,10 @@ static void gen_compute_compact_branch_nm(DisasContext *ctx, uint32_t opc,
 
         switch (opc) {
         case OPC_BGEUC:
-            if (rs == 0 && rt != 0) {
-                /* OPC_BLEZALC */
-                tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_LE), t1, 0, fs);
-            } else if (rs != 0 && rt != 0 && rs == rt) {
-                /* OPC_BGEZALC */
-                tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_GE), t1, 0, fs);
-            } else {
-                /* OPC_BGEUC */
-                tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_GEU), t0, t1, fs);
-            }
+            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_GEU), t0, t1, fs);
             break;
         case OPC_BLTUC:
-            if (rs == 0 && rt != 0) {
-                /* OPC_BGTZALC */
-                tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_GT), t1, 0, fs);
-            } else if (rs != 0 && rt != 0 && rs == rt) {
-                /* OPC_BLTZALC */
-                tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_LT), t1, 0, fs);
-            } else {
-                /* OPC_BLTUC */
-                tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_LTU), t0, t1, fs);
-            }
+            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_LTU), t0, t1, fs);
             break;
         case OPC_BGEC:
             if (rs == 0 && rt != 0) {
@@ -4414,7 +4386,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 }
                 break;
             case NM_BLTUC:
-                if (rs == 0 || rs == rt) {
+                if (rs == rt) {
                     /* NOP */
                     ctx->hflags |= MIPS_HFLAG_FBNSLOT;
                 } else {
-- 
2.55.0


