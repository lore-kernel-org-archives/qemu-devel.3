Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AA4606A33F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kguEE+4c;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SVA/Vi89
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzxX-0004aC-Bs; Tue, 24 Nov 2026 18:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzxH-0004Di-U2
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:29:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzxA-00085z-6N
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:29:39 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMajF73520379
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ub2yUksx/IRgSe3xJlU9NwyrEoMwZziVLDrzJvliCDw=; b=kguEE+4cwUgrXYu3
 3ozCbVA1LAvAN9ESuV0P7aytf6vM66diTFv/6EjaJVzKpmlCH1+Afs0cGTPtDuEX
 oZ5Lgz2Ai7unW0/x4PIVuCTtOtveYlGEeMJaBM2JDC11UqdceWoA5z5pp0etkoZ+
 pAZ9yZHpbnZJSwCBD3QyvaiGnab/un+qNjSfUsRxlq4xC6k0H/Dj4yrIqpDcNGbD
 dpaPUaqeyShb1NpVIG2ShxOrsTyj2fSMPlnfOHyflCqvBctBkZPdcqgxqlfpBXEr
 mYHx8RhvxuEDzbyOXg/6vHqVg/eu6O2R2Fs+m3Y4j2xltGfC7Dvni1+Wr2Na4qtz
 R4QuqQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5f00h9hx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:29:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844cb60so908793385a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562974; x=1796167774; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ub2yUksx/IRgSe3xJlU9NwyrEoMwZziVLDrzJvliCDw=;
 b=SVA/Vi89Hc26BVVmt7LFoPKRF4VHf5f6XshSc48ANwPj+z5GjHpWT2pZGjxbNCVg+a
 YXoVpw7N8b8TOEvLd+PTHpVP6Ix8Olz8WE/dxDN3hA8ri9l1JH+9DYdUvMXOnZKgLLU5
 4Ck6YBFHzZa3+EdbL0vcSzZPeUbEIp3Z4DGbok7f8jk8yyVg4HJaWpbeeraUnYZBRxD4
 lvlmE3H+g80kr6AlnAeB6QH87SxI3PPCrdrAAIRjloE7oQoaBcJhrN2SmFTlqZ646OqO
 89ypiOtiPCJu/HOtCKsUpl3pi0cOao0Q6AlVuibyehHF62yWopgkiAwjcM72xgcj4mwz
 tR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562974; x=1796167774;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ub2yUksx/IRgSe3xJlU9NwyrEoMwZziVLDrzJvliCDw=;
 b=AF0BLjSCKRacU+hCXnSVXSIP6/PKXZ3VmgQ0Q/rS11+9Qt4CYJlFsBOTxVQsuw4aa2
 DNtyfkI+UEF2swUcSe/A8rM1OkE5e7rupzMA3Jpw0KXcAE2ArXAlaescLhIzO9obXcEL
 WTHXRdpJoBxuUUTPXd+SLVLzl68Z1Qh9L9p6cPtc2JFo2r0HaRXtSQgArus/X7azh/6n
 Y+w54TU1yBtI51v4belxZ9Sig/SMvxzOSelxm4bP/b8zoz6Q2eV6mx2N4s0ShFrxCRq0
 kv6Y3Q+M5fZOHH3+tutFVAa7u76KSEUKWa7pl1//qFeV1XwQRJg1TWhM/inSmYTfTpjW
 3sHw==
X-Gm-Message-State: APuU4Z+V/8B00iiI9hnRQXVb1YPIqIfvcpaf7xjFzMhXuWoAvfUewnOf
 NOdjJu1QolH94Xe1jtQy2L8xMja4Sr08GthcgnvrWNIE59QVgJfgdF/8hUULtJDaTaqgovPT0XI
 +EE47ukgiXHM7QdtKAWH/ThKs6Hx31PbOfsRUXLL0vvHinx7Dru6F6C3nAACKEjR0uMzy
X-Gm-Gg: AZFdTZdd8IXu+X54frKjRBoyzrdvALbWoKZB1/3T9jSHhwDsf+ocnKDbUPWn8maeVOL
 wuZVG+xS3QX3VR1SwurWb9rkZQVeucJ1rxyNTFez3tSabs1zm3VCd+Bc92o1yLlHrAQCBQvH9ae
 u6sP1HFgDAiDd+sEe5Y0g8sV9bkY/7ujUf0ahisiAnv6FeavcoGwhlZJ5Z49nKAb6/MAB/AD9Og
 0ghrGBSTGInNci8zoUrRLX6OFr3KQQ6wIqMFkTdzkBK4Av4gOM6fZvGiykOjt+hB6bNTu08Xkxm
 JOo5oRu5FrVwgge6Hy6VzM6DKwe10QCu1fy06OKXJH+C6FWa1a9cNDREzhNdeWMSBJwUH6RfrsT
 u0oFprMextQv4TfHnIUP+1bZDFV+9yrn/z71nD8G8WkQpbtifUk6Q4um47NtW3ZRSLLtQR9WbOu
 eCr42udoIitFra+w==
X-Received: by 2002:a05:620a:394b:b0:943:e872:f521 with SMTP id
 af79cd13be357-949b3572737mr3192599685a.9.1795562973625; 
 Tue, 24 Nov 2026 15:29:33 -0800 (PST)
X-Received: by 2002:a05:620a:394b:b0:943:e872:f521 with SMTP id
 af79cd13be357-949b3572737mr3192597085a.9.1795562973116; 
 Tue, 24 Nov 2026 15:29:33 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8526cbd0sm615866585e9.0.2026.11.24.15.29.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:29:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/18] target/mips: Do not sign-extend partial LWR results on
 Octeon
Date: Wed, 25 Nov 2026 00:27:22 +0100
Message-ID: <20261124232722.90234-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kYK5hDksEeTf5kgZ-F3Vvuw1i3GUU7p5
X-Proofpoint-GUID: kYK5hDksEeTf5kgZ-F3Vvuw1i3GUU7p5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX+fWCz+NpedM9
 8lAOMV95dDtrxelOYuO56CDw8o+xmKLNytWoj2QPBq2fWEdOb3dcpDaEAzu6s60xe3mKoGgtUGJ
 431Pov+GEG1lwZ98o1UVMs4vVmY+P1Q=
X-Authority-Analysis: v=2.4 cv=JqtkP84C c=1 sm=1 tr=0 ts=6b061dde cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=3UIKva1vFuA4V1yXjwQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX/liUWhoUrbTX
 Rl4N8FrGSrw19iT88Q7+LCWYzNcoE5zApWxiSmBaQ/GAliMMjxRKDdigasBFWeowDsmeU3xwOjH
 iy3GzaF6S4+umVhk+P45oDpNRdUoAkeKSqieE6m7WtEc9vXMpcEwXEMNbYsTiJHXpkHbbfhG7g3
 A4jIEFNOByFKgHsKAMt/g0frrYbJrP3V/TgDq4w4G4cchdxo2Q2DBG4r3TbU4wzF4UWSVR5p7wi
 8+hLEEEw1yFWElmJ5ijGmk+cf2oJGodncijf/ZZjL1EdhGJDF76jnR/riFw/9STb8eo1THhDICQ
 ua3U0VLju5+/d7OPUkl6AlzXUZO6gfjld0bmDvDzTBbbMZl78iH0Sg9qr+hpI2qh/GQRBOSl94i
 ePfozXk5MoNEhqbgHY7hRS5lZzP0HD1vWSyGBtLjOcIdnNzInW8LXBAwADn7nyRQy9wT5+5fnSP
 8mdI1hSRVt3maKKyMeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240092
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

The MIPS64 Release 6.05 manual (LWR description) says that when bit
31 is not loaded, bits 63..32 of the destination are implementation
dependent: either unchanged or a copy of bit 31. Both behaviours are
architecturally allowed.

Octeon III CN71XX hardware leaves bits 63..32 unchanged unless the
whole word is loaded (vAddr[1:0] = 3 for big-endian, 0 for
little-endian). QEMU always sign-extended the merged low word.

Seen replaying a risu trace recorded on a Cavium Octeon III CN71XX:
"lwr s7,26334(a2)" left r23 = 0004114d368db793 on the hardware where
QEMU had 00000000368db793.

Only change the behaviour for Octeon CPUs (INSN_OCTEON); all other
CPUs keep sign-extending the result. LWL always loads bit 31 and is
unchanged.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261113161158.25811-19-philmd@oss.qualcomm.com>
---
 target/mips/tcg/translate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 55dd69353eee..bbcccbbb467f 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -2063,7 +2063,7 @@ void gen_lx(DisasContext *ctx, int rd, int base, int index, MemOp mop)
 static void gen_ld(DisasContext *ctx, uint32_t opc,
                    int rt, int base, int offset)
 {
-    TCGv t0, t1;
+    TCGv t0, t1, t2, t3;
     int mem_idx = ctx->mem_idx;
 
     if (rt == 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F |
@@ -2176,7 +2176,17 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
         gen_lxr(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UL);
-        tcg_gen_ext32s_tl(t1, t1);
+        if (ctx->insn_flags & INSN_OCTEON) {
+            t2 = tcg_temp_new();
+            t3 = tcg_temp_new();
+            tcg_gen_ext32s_tl(t3, t1);
+            tcg_gen_andi_tl(t2, t0, 3);
+            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t2,
+                               tcg_constant_tl(disas_is_bigendian(ctx) ? 3 : 0),
+                               t3, t1);
+        } else {
+            tcg_gen_ext32s_tl(t1, t1);
+        }
         gen_store_gpr(t1, rt);
         break;
     case OPC_LLE:
-- 
2.55.0


