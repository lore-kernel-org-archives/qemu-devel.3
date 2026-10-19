Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C8C606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z+o+QDu1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yi+LU6O5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunh-0001lG-Dz; Mon, 19 Oct 2026 17:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunQ-0001hX-TG
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunO-0005ip-Vp
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJxpX549443
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CD2MV03z5YL
 e39V288IQtDr6CNDi1ffl6+smvrhQ9s4=; b=Z+o+QDu1u7mLdZnv32IOR9KH1lw
 wZJuyf2pC4bFClgXFHYIFNSeiU/4GeYWi+2j52jlnfa5ibTPHZ2vZmrIjQ4tKTmq
 iWa036Sj67MUgt0OTwm/eSuHH1BVH9PXDIX8DIGHHlAHzYQugTGZdjUg2v0KvwR4
 cJFKj3m5YVLp+Hg5tk4Vk0MmU/oyEsBZhu9NJ44KXjwJ9QxP8jUaRkhjbPMiru4w
 U5s5OcOslgUqEWoSc++pDfcH2LUXPlEZJQK3o+3cf24RlAie0n031Z8aFl6Oer1I
 x8BO2E9K60K0tbFw0NyRHCYqw2TgTExQCz32YyPIJ5PTKv6L4RG29SPzhkQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47kc60-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ad30487d55so1889368a91.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444885; x=1793049685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CD2MV03z5YLe39V288IQtDr6CNDi1ffl6+smvrhQ9s4=;
 b=Yi+LU6O5Usx9/7KkbutPxUBONZffzFMiseOFgvCtapMzRf1PzWFnCHBiXDCv3pqO1+
 /eVLneGd4RXQsv81NLafo/4HH+bW+x4a1xURBIf6gf8psVEyF4XnjORjGEHNCILWfRaD
 Q8kzJgRBgULQiSNQVv1S7W52yKMjtDNnc0wa6a8jw7Fcv19w6Aq1IuGBhTFmJioa88ue
 /AecmXARbMrvcPc9H0LrnbROaegf8gk5AenajXkSk8Calyz9wdp4bLBJh6AK5ICGDCbj
 /1v03qBDynLOtzAZZoqlJSeRy3p73I+SOzeWZNma72yKuXqfYUUhKwtiRQgBan41BpEb
 Il1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444885; x=1793049685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CD2MV03z5YLe39V288IQtDr6CNDi1ffl6+smvrhQ9s4=;
 b=ZR8sKLynaTu/+xjSxlixr7nlvGp6FP/5iFtQex7EBSyQViBk1Gf8JAonTy37m3Ylfi
 QG3UvW6WhfHn8TaPSUKiSy2jYiRcoI3qNBKrJN916hGZam+b3BOhHib+ib2Zq9A8Qojr
 5SzbKcJ0FBuutMTCtdIbYAD9MvBElJZ+TPVvnbjK8OZEdQpxlUMBI8K8dELhl6y2vnrm
 781cHWeV1L/V0MZ5FgF+vMaiQhdEER7ZDsxyzE5FlbzkOFY/6InKCKjlTuNk+K3Zp9kU
 1+Fb/ytVA9EZ7lIrdgJBm7sc67iGXub9kNovOpmei5NNTWrf2vkiR9k4aNl1FrxlAVac
 qcTw==
X-Gm-Message-State: AFq9FYIID1/zlUMBXraa8clN5vAm0wJOYPs8bQbH7cX85AcykyNautSN
 CRs/EbJuP/fZP/Byau0xXTbyP6oUTwa3k4coxLGhf6Nfwqe+Qe2B0LSS7N4XYHjwYowSbnUhdBP
 QxvpFNkMZ8L4sa9q5zhU5ag9SzJpBf94n2k4vjLJLGe7jhRoG+1WCVb+RR67hKTfuFQ==
X-Gm-Gg: AYBFou2wFbx/G/jHpthiwEFhfNbMBDd+9zGG0SNbJybmffWvVlBgxBdydlg/dVSOn+G
 2G1FxHyWwu36xltnUoG1E4Xo4aicCukNM1c32SQxEqrZKxE6DAF12Q+OzydVKT9droDIpNHdhaY
 LTEId2nj02L9jw9No0g0QJ8o1catVBzqsfGoHLO6YAuHihNUYTq4tw8vPQERPzm0ggoXWDyxmfw
 JvJ9bTvSMXKuQQdutHLh0ulDjo2Her9YlXIFB89hl70YGS7cwLKTrHXWRvF1wyvjUVw4pwuSXo7
 XXJOSZcpYX0ZAahsJd9eST0VSS9Nejv/z5OBMV2KT0oiTy9mZ0XrG7ZsfiPTc5boq9FxqodqgkB
 ZP0G4YXRSnZIcy0UCAy7iomMjUWyC1sRM8k+8r501j1yvYZoa+0EllQFwdGuGlho=
X-Received: by 2002:a17:90b:380f:b0:3a6:e901:e79b with SMTP id
 98e67ed59e1d1-3acef106598mr7579117a91.15.1792444884851; 
 Mon, 19 Oct 2026 14:21:24 -0700 (PDT)
X-Received: by 2002:a17:90b:380f:b0:3a6:e901:e79b with SMTP id
 98e67ed59e1d1-3acef106598mr7579092a91.15.1792444884233; 
 Mon, 19 Oct 2026 14:21:24 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 21/26] target/hexagon: remove explicit target specific prefix
Date: Mon, 19 Oct 2026 21:20:40 +0000
Message-ID: <20261019212046.149572-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: beqlnBZden6HLIO8a6Iit1ceg2uG3J5c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX+SbQ1MBHDmmg
 JP/li3fzz40PXHltyxnCM3Bx5DGhMDZLAjzTdME+9MRcFJe9YLZsaLKJiafAZEB7v4vHX/OSf71
 p75ZnoTIWe1MfX6lSJaoK1JfOH101yaREEFRM8lhEM+uiRtBUrgVtpZEVpvhdGVfi33VW4X7mpv
 Zy5QrlJCqhvWLaH0fEWTNJL1xANuPFjWLDnQIJJHCs8Eq0NuXbOKfsCYLq3hVKT0nqUNWrdS0gt
 uUIwRJ7VQDrkpDqIgfMGv5cP3FcJtoX9bP76nHURyNvIUVAMI/MKseDNritw6TD4EULee5YyLUf
 k6leiA8YnA0Ekc9u9JQc+ac6u4W60G43Brn1b55T2mMIlq9whMF40qazfKH8AapMX5PZk0HpMxc
 r05cfFE/XejE3ONqKmNQBoPBU49xw395I07Rx/xc2i1CHIJkaDx1eIDvht+SIJs4KC+h82HDv7s
 VIayauwSogc241Q9tIA==
X-Proofpoint-GUID: beqlnBZden6HLIO8a6Iit1ceg2uG3J5c
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXxh1R11gpkx1w
 gwUOb0wQrd8xyoz7oR9S3urSp6eDb+o/EbKAyfNDmOSTrT83WKTx1YwfdldeSycY1LfEVVfwd1K
 BRu/OdtLaKe8yCCTUhrWfOCBOfkYTxw=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad689d5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=xJBkFjxltbiK57tzlAwA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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

Now that we have a generic mechanism to prefix all helpers, we can undo the
recent changes that fixed conflicts between targets in multi-target set.

This reverts commit 086150a223a6dfeae85e8bb925c5df0ca3061ed5
"target/hexagon: prefix helpers conflicting with other arch"

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hexagon/gen_tcg.h     | 2 +-
 target/hexagon/gen_tcg_sys.h | 2 +-
 target/hexagon/helper.h      | 4 ++--
 target/hexagon/op_helper.c   | 4 ++--
 target/hexagon/translate.c   | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index ed05f97efed..80d8a7b6bac 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -1135,7 +1135,7 @@
 #define fGEN_TCG_J2_pause(SHORTCODE) \
     do { \
         uiV = uiV; \
-        gen_helper_hexagon_raise_exception(tcg_env, \
+        gen_helper_raise_exception(tcg_env, \
             tcg_constant_i32(EXCP_YIELD), \
             tcg_constant_i32(ctx->next_PC)); \
     } while (0)
diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index 3760b671adf..413ccc97f7b 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -80,7 +80,7 @@
 #define fGEN_TCG_Y2_wait(SHORTCODE) \
     do { \
         RsV = RsV; \
-        gen_helper_hexagon_wait(tcg_env); \
+        gen_helper_wait(tcg_env); \
     } while (0)
 
 #define fGEN_TCG_Y2_resume(SHORTCODE) \
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 28591417040..47958c48ea9 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -18,7 +18,7 @@
 #include "internal.h"
 #include "helper_protos_generated.h.inc"
 
-DEF_HELPER_FLAGS_3(hexagon_raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
+DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
 DEF_HELPER_2(commit_store, void, env, int)
 DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
@@ -138,7 +138,7 @@ DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
 DEF_HELPER_3(setprio, void, env, i32, i32)
 DEF_HELPER_2(start, void, env, i32)
 DEF_HELPER_1(stop, void, env)
-DEF_HELPER_1(hexagon_wait, void, env)
+DEF_HELPER_1(wait, void, env)
 DEF_HELPER_2(resume, void, env, i32)
 DEF_HELPER_1(resched, void, env)
 DEF_HELPER_3(modify_ssr, void, env, i32, i32)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 9850dc07289..82d38dc0b08 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -93,7 +93,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
     do_raise_exception(env, exception, pc, 0);
 }
 
-G_NORETURN void HELPER(hexagon_raise_exception)(CPUHexagonState *env, uint32_t excp,
+G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp,
                                         uint32_t PC)
 {
     hexagon_raise_exception_err(env, excp, PC);
@@ -1839,7 +1839,7 @@ void HELPER(resched)(CPUHexagonState *env)
     resched(env);
 }
 
-void HELPER(hexagon_wait)(CPUHexagonState *env)
+void HELPER(wait)(CPUHexagonState *env)
 {
     BQL_LOCK_GUARD();
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 2c18f5eebff..e2a5038a1a5 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -139,7 +139,7 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
 static void gen_precise_exception(int cause, uint32_t PC)
 {
     tcg_gen_movi_i32(hex_cause_code, cause);
-    gen_helper_hexagon_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
+    gen_helper_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
                                tcg_constant_i32(PC));
 }
 
@@ -1146,7 +1146,7 @@ static void check_imprecise_exception(DisasContext *ctx)
     TCGLabel *label = gen_new_label();
 
     tcg_gen_brcondi_tl(TCG_COND_EQ, hex_imprecise_exception, 0, label);
-    gen_helper_hexagon_raise_exception(tcg_env, hex_imprecise_exception, PC);
+    gen_helper_raise_exception(tcg_env, hex_imprecise_exception, PC);
     gen_set_label(label);
 }
 #endif
-- 
2.43.0


