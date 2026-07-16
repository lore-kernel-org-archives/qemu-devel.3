Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E2FC44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQUe-0000tC-Jj; Thu, 16 Jul 2026 14:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUb-0000sE-Vw
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUY-0001Sk-CM
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:29 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GHZPJn385076
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+zXU/69FU5k
 YbdCN77aH0WgAq6JzdjM3W7LYD9PIS6A=; b=Iml5Tz5S+jKd3ZzpStYcvtDB8Vp
 +jn8YJtM8m+nOZiGjIYPDnkBVCxbnFKNYHMl6nKjW1v4xIVwlIr4ekc4sfTdnids
 NA9NYM5jm3Q/wXzs4mN3xeutqQPqu4ozzPnm7D1Vuu9//QB+JYyU7rabPP3z6HOL
 FGQ8Djd1BsWt3w4kdumjK4yj7bJz6jOvB5L4BsYZuCYPuWwDGb1KRA1sZfPtqEkz
 lDnD6cAq+Rf0vlk6wezM7rLu3oKlIw9Pd+Cp+RjGQGnbztsv/GUmqBxx1Y8oUguF
 zOWy4CsKQ3c0K7SWCJTcs1Pn788DlWxpWRzM9CBrqeq2HxpGU0V5vX9dMkg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6g3ua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e4758ab46so72206a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225242; x=1784830042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+zXU/69FU5kYbdCN77aH0WgAq6JzdjM3W7LYD9PIS6A=;
 b=ffDBY4F3T5vXKmeNRtvqx/lQx/26RnkiXItF6WWKw3rw3n3AqA1K8W/dOaUIv6sjVl
 D6+RfBkPkFGXpXBzOaPItSxcVc5enWrixSHZ/QQAhbxu9pYTGLOM9F8dM0ffMGsL4BQW
 CpD8mUqe8zop6OH9Rnrbm43eRWRmZi4S1hGRqfryWm+GQv33ck+teVol/4R2oNIXWXaB
 dTKpi33p8MZJog3eiIOxlRy+rOKDyFqZFgw1ffooezrkGh9GgbBRdrU9PGm2FkR4x8ah
 bEzZyno+tNBi9nyPggY34Gp/G448cZXNRNcN54DsuEcetVykxiIdz23QrxoNOKUTkFNv
 5gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225242; x=1784830042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+zXU/69FU5kYbdCN77aH0WgAq6JzdjM3W7LYD9PIS6A=;
 b=jw0Ph4E6WA/iJhhh+sh5ZpM+viuKI3GqGKzfo/7ebLNUkALjxKlZKib7i6ol9bbxUm
 Xw71mmpNtwzyAf4AGl7ENNShdAdPkIT1+m4jn5LEAjAWp4/6gb2wkZtES+EjxzUo5NCv
 zBV8qThb/cLjmYo0qMRMvmeN5n2hbiqktsNhO4UdAjXAuCeKf19YOJYP5DOuNE45odWT
 yiwd8fMoGUd5cwRNql/v0IAMn1Lbs9kEsOIfWJn+3DcV9g+/VZqd1jhMDe4WVVlc6rQf
 KZk7EL2I9DBl2t65dYpkDPUoAOk1yMjHbNF+IrIfnbf2cuv0oNYp1oe+mZxrh4dj+B4v
 QWYw==
X-Gm-Message-State: AOJu0Yx2faqos6UJA3Hg8P2u9nwQIW8fQhOfVeB+XeR9gSszDMS+ilxI
 W8abQ5acnr31yLkJT4dKLWnjD7XtMlMyA/VTG0zpZIOcHy6r6osfDqrwL1bNDI1V7Ai/y/zq7Ck
 FSo3jyskjm8tx7TBnMXNbXpzmnFnhgkg2pwCMZ0V2O2hPOt96CQq9mzCiVD5bq6DPQw==
X-Gm-Gg: AfdE7clVueVrjif7qNsEES+qsdCNEV4n9XjPGADwMdepPPGwFxViEn1A6TQTp9Lxpzm
 E3xBXDWEprcWvsY5uk+a8TGjlcLFluCdz7xVCXVUbIjYfrmZuGgn9oyEs6wudItJJ4p+3EBrSQk
 7qZn241G3Wx7q57I46l71cMHqyTHjwWSXaw8tfdMdxp4KcZl4YPzxnQmAjNsiIh1lOiXaeZA25/
 pFV/Mfprr4E5sbMAyk1yrgFnhqksdxLJnxlq31MNYB2oEcww+rYzt31fSO6FxH/wu93mAsP1RuR
 eW1OPNiVE7jl/Z4OnHwMTOBZjqCGdZ+UwPvjVh4DV9eD5iEvxYeQrNyW+0+pzN4A9I4kCGqM8WK
 xyI/sIzOqy8CaFTgwOQ1WdsBq95HfSDLvuj/kNOhlD5FBzTiCsyz++mH3gZRYJ2U=
X-Received: by 2002:a17:90b:28cb:b0:38e:524:8797 with SMTP id
 98e67ed59e1d1-38e46758b3bmr628529a91.13.1784225242098; 
 Thu, 16 Jul 2026 11:07:22 -0700 (PDT)
X-Received: by 2002:a17:90b:28cb:b0:38e:524:8797 with SMTP id
 98e67ed59e1d1-38e46758b3bmr628473a91.13.1784225241404; 
 Thu, 16 Jul 2026 11:07:21 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm17131184eec.11.2026.07.16.11.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:07:20 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v2 01/14] target/hexagon: fix improper assign of cause code to
 exception index
Date: Thu, 16 Jul 2026 11:06:45 -0700
Message-Id: <aaac9492e5a4b8fda69b49a966a70d975620ec6b.1784225209.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX5Jucc8YR19rt
 og/rWAWzP/D1NdBQ63bdS9lF8uTPiyRCu/HXNfcINNGzMIv9DwS9OsB4ShSWCrOGOscuv+OtJjV
 dyROFwQQhwF0FWzfzorGeRRreVgSuG0g6tTnA2v5ecLab4+gzwXUGBrhvleb/lFLFdgxQc8PHJ5
 fP/Q/w0QYQQH3SkkY8IBAGE00nN2BNZekxYmqrIGMaT7kir5irz4NKHelZYzVovxtEhXReFGvGW
 LDBApo4MV27Sm6gViSMX/UTsJhD5wNXD04xDvKdZc5J7ZIOvLYTv8tfliRMBCd6VHCqDaL0bR8g
 8smiJyOU/HsM1jw0o7HFDUHycI8O2JDXWsvKlRyTUlhlfkasED9QPgOAzgyRt4dM7sR1nciP4e+
 n/8xrHvlJU0W9tBaXgBzvQx9XSFIIDLcyY9d8u9RJYohfxOBXK3awnGdEjMYZ8RKWKIpoNNH+4S
 yIpddKIQlUaNYY3zIGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX3BiprXJs3rRq
 Droa/O8tOG8aHBndP01H0AfeYBcO4blpHW3G9jT9FYFyLCFpAsZjdzNZW/3Qc5RoxKquXwG9vtV
 vkjXIYGg+4RhWl3OVY5TWR1d0twG5Ys=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a591dda cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=gdgfPyyDDN4UGUr4234A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: XCxmeVXiJOVStKjcJI9TSW3rwosV2YFf
X-Proofpoint-ORIG-GUID: XCxmeVXiJOVStKjcJI9TSW3rwosV2YFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160185
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

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu.c       | 3 ++-
 target/hexagon/translate.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 42d93e5da47..eac355497d8 100644
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
index 77235916f4b..341842c6af1 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -238,7 +238,11 @@ static void gen_exception_decode_fail(DisasContext *ctx, int nwords, int excp)
 
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


