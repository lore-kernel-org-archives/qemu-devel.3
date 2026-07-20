Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E009DC4452D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wls0k-0000C6-9t; Mon, 20 Jul 2026 13:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzS-000807-OA
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzQ-0002uK-PA
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:18 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6btu2785408
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PJWIDxUU/im
 wHlGNxMzQREqkn50uwXs1ISA8F2opnAg=; b=Hofb01Og6vA5muFwMR2rC+wpBD6
 K+eqgCeC7SBo69qdmF0ZRSwnoH8na7JWPtuzIqk2yQC/ExtaxeU4f3a2Du+s3DG1
 njeSuhZqXIHSOxURdpefx454t5BzDXe3ZPNGZneH+nLUIIuHSMjZx4dghNsecA8D
 Kqun+D9nch0kfqzL5Q4svD8xdmIrx7ZlOR5UQy5/doWur54Jstk+N1mGId6slpog
 DrDUC6UT51Fg7hXX7pUfxzvPQmgSRcS1IZ2ew5g91l7xdDIGBcbec6h+6dUo2NeG
 Z6hDwsaYCX4glmRevKK/vBCFfFJ1WP6PKYsYpvKtluhWMn9aCgyUmAdF5Bg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs529ny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cceabd70f5so193470915ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784569273; x=1785174073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PJWIDxUU/imwHlGNxMzQREqkn50uwXs1ISA8F2opnAg=;
 b=HikPifBvQf+RTspUgDidmkSDiG5mVT55XDBY5GHamUHZo1E7bLi+bujb86hMonGcxl
 EpZpBpbAddLCj8EYdn7z2Dk+/oB2HyXVRGmtIgdJqFd80FtYmO8FLxyJH54sJPt/vmd3
 h/8VT6C3smMZIVWtluIBGxa73fJHiQv/VGZYa2IKCsj6Y1XoGdVEQYOKqDaoeVR1hP7S
 zNDwA5EnPQuFOyLoesSwk7WQ8ZbYv/GcMhMFzRsGBhWTO1CFJ2g8ActAaYZRO/Vy6eo0
 O4vqfyTg7oBItrCpZsCeCA5+VZ99gBoIzsNtzjnl2xlu63GIEjqPl2LVWMKg+C1CC/6m
 wQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569273; x=1785174073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PJWIDxUU/imwHlGNxMzQREqkn50uwXs1ISA8F2opnAg=;
 b=RC4szFLzw2+2Ea2hjb2djo3sJJ9C5Cizb8qXXgePQYW+QbDFv10JZrk9rx5wPjmruP
 bykgOQRnsseabzdueQgzDfKFMCi0jF2O6khqz+47n3GaJeRgpEAkwTX/lXzAHs89xKf1
 6s7iFrQfY5q8zSAQhwGZK9SvbMftHSk7SGXimBsiXkMjmR2VxAxzx9A00GTkHJ6GaEb5
 FKWv5GuN04JRpt0s5RCPNbW0HaDi4tnE6NJQ1NqoRuqSLfVEEcfIn54XbwEqdemhAiP2
 ClN1DsSl/Sj8Zc4eEigVbknP3iaKN/383TYN3/jsg8DsMG0PsFSwUpzudBrW2Y7/UM4P
 txLQ==
X-Gm-Message-State: AOJu0Ywvpqnc+mtzTMXH4S5ihwGE7rpw6/IHQBN/N9i3J+PbgMDWJaKx
 d1Vtn/CMtlvbrdSOLlHgsfzJL3rwxm965+tWZXR5l/s9zhYOka3C0J3G2Ku02vX5KvYAM63rGB2
 F25zHhI25wRtcINNrQqgx8iMtnYsgPQrThYhcdJ98x3LaxVEkSxThrQuCJpbMtAoFxQ==
X-Gm-Gg: AR+sD12klow6CHF1RJEmgttLED1oPyuMTo2okhOb2LOxk/avLCeSWKjD+EFXMZ+q0Ci
 EnHZ2huZChL8ySowyH5JgqEBzGKOlJp4DL7UUATTAAseB8pXkP96a1ubcZbUBq+NrTuz8kh/ohM
 y/jPiK982TDKYqFA1hHoyMCVsYLlc+iiUY7o/5kcTi34fY5N7+vrneFf33nTCLSNops0VsLBoyx
 NyIq9BuZkNvJCEjTc0wi9Nw10Ec5OSnXTR3wU4rmjVs2LnEgrmR+D5EfI4yO4WWgzWkJy5sw8JC
 mJMK4SwMfsTRAY8qkCwKVfsQWAiz8rFGi56ycU1aWhg3IYIKmPWrjMKQxGBxmiAUPy9t+JIyPB+
 CgHzeDyGwtwqT78oWl2aKlEqvOl1lCFcb1U9kcICiyug4hZ0YtCtOD35+vsq9wVU=
X-Received: by 2002:a17:902:fda3:b0:2c9:c46b:1286 with SMTP id
 d9443c01a7336-2cf3499737amr174530405ad.34.1784569273206; 
 Mon, 20 Jul 2026 10:41:13 -0700 (PDT)
X-Received: by 2002:a17:902:fda3:b0:2c9:c46b:1286 with SMTP id
 d9443c01a7336-2cf3499737amr174530135ad.34.1784569272700; 
 Mon, 20 Jul 2026 10:41:12 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm66281257eec.21.2026.07.20.10.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:41:12 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v3 01/13] target/hexagon: fix improper assign of cause code to
 exception index
Date: Mon, 20 Jul 2026 10:40:57 -0700
Message-Id: <4f4ec84cb852829097e7e2cd14de2acac01c15b9.1784568922.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX5GgCL4SQ52Ga
 bjNi5LCfBXBfoJJxBuX4WlhQ937FUM7vfzfoBqgZi6+1XhXPXpjhRaAO2G4GFbqTO/DqTjMzvVR
 kQjz7QlT0f6gKuMJTVPP2sf5IXFzZiE=
X-Proofpoint-GUID: jRjE6J7eBh9GWkM9Agrhv9o625qtOnN9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX94KUaMnitZ8L
 yT05Bb+W4aDs70vi4dxYklQP4iYOjlewV1A5NGjTDUCNfGHPGngov0yvYhJijVoe6Y5VYs2PgJ3
 pAkKDVtrXu4hzLXEE49DRDY1sEej9RaVOIE7eP6C7GjdPzle1dFw2kssUro1tVMRKoWg+af25Ow
 RVF3xpdV2B0pyyZpcBoeMWUqZfowekccCEF/EvW8TgNyfVZEZbNNyXkXvMSNGoR/wFvOrgGnFuh
 h/4kESgRC/yiL7LzUqluQU/nRzAX0kNqKKWpXhnCMxCoEuWAXN1keuZwcLRs07XOOPOL7DORS7V
 2c0y6Dmb9C6RKlIwsLtNVrfALGXBVAfaZWOwnnk/tWoe1fJCiua+7i9zBDJ/sVx6KC5ik0u6vdB
 Hja3Li5SWzd/1IMI7vUmIiwHxGXQbdQukkc4baEQs7w+93l0e4JI1eWsjVQXwRsP8mHW82gxnko
 F7U8kPqNbDabtnjU08g==
X-Authority-Analysis: v=2.4 cv=CpiPtH4D c=1 sm=1 tr=0 ts=6a5e5dba cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=gdgfPyyDDN4UGUr4234A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: jRjE6J7eBh9GWkM9Agrhv9o625qtOnN9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

hexagon_get_tb_cpu_state() detects a misaligned PC and raises an
exception, but it passed HEX_CAUSE_PC_NOT_ALIGNED (a cause code) as the
event argument to hexagon_raise_exception_err(), whose second parameter
is the event index (it ends up in cs->exception_index). This causes an
infinite reboot loop when we reache a misaligned PC.

Similarly, gen_exception_decode_fail() is called with a cause code
(HEX_CAUSE_INVALID_PACKET) but unconditionally routes it through
gen_exception(), which treats its argument as an event index and stores
it directly in cs->exception_index.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu.c       | 3 ++-
 target/hexagon/translate.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 12d27ce1381..e6b2ac1939d 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -320,7 +320,8 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
         hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
     }
     if (pc & PCALIGN_MASK) {
-        hexagon_raise_exception_err(env, HEX_CAUSE_PC_NOT_ALIGNED, 0);
+        env->cause_code = HEX_CAUSE_PC_NOT_ALIGNED;
+        hexagon_raise_exception_err(env, HEX_EVENT_PRECISE, (uint32_t)pc);
     }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 199b4f8c2ec..534b065caad 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -245,7 +245,11 @@ static void gen_exception_decode_fail(DisasContext *ctx, int nwords, int excp)
 
     gen_exec_counters(ctx);
     tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], fail_pc);
+#ifdef CONFIG_USER_ONLY
     gen_exception(excp, fail_pc);
+#else
+    gen_precise_exception(excp, fail_pc);
+#endif
     ctx->base.is_jmp = DISAS_NORETURN;
     ctx->base.pc_next = fail_pc;
 }
-- 
2.37.2


