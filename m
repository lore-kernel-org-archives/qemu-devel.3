Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB960C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wls0G-0008Gn-Bh; Mon, 20 Jul 2026 13:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzS-00080A-PN
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzQ-0002w8-Ub
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:18 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6bGT2785407
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QnMf7Oz5WE/
 3v9l+jo2BUBrK/b+AS4zs/d/5X9JacdQ=; b=HyL3SSpbMdNdhp61p48gP56sceM
 lumtW3W9jluBvhqpSNWxbdDyIKkAasJqHCIvZXj4tg4iyHylIWh7vus1ThcHAd20
 GvrSTC4cgE+KYjKK5yE2uLqfnAKusMlXIEuO6o5LpR80JgcQT8LcV1jFN5se4IxY
 QY/tMTlNXxJqTNycZDP8qWYZK9jFWKxqLD3fAuMZg6eu9EvPcVdlsjXDnEdOajcT
 GGwNpGYEmjhzMM0uaIKIMYXt0pyEMa4DtH/vYxYT0tH3tZElgykPYN1jW1PD174a
 LfVxMF27pIeVJHV4bjznBzezCoH+fz8xS3DdFkcx+2MTkLASREDxSlE2+NQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs529p1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cccfa32670so133775455ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784569274; x=1785174074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QnMf7Oz5WE/3v9l+jo2BUBrK/b+AS4zs/d/5X9JacdQ=;
 b=B/kW8t5lF7aekoUjIHbT6bHhGhInWctChdNJVIb3b89S2YN8Yf3I+ANq5NgOacUv6d
 4SmuZm1uKFm8OiNCXR6W+mHzNFIH0dV1dlEplBo9ymB1WkuoxzRLGpd9nXTU4gbEWKvD
 p19N5znXhav48yB+F60uPzz0UBeCW9xx1hIXOp+WBP5RNtioZoYSBQeKw4AYuvg9Y0a8
 6GPSgEGtfKNoPgWqjFZhC/NQuTCDVvooLcDWtrPKnMexqXBg8A2+xFZ9ZP8bhLoChMkS
 Q/G1lMKMq5P8eI2tB8bwLET5XyAyco7MVHtAwqZ6fbKDTkJTLUrHfMdB4gG8ySqY5p0d
 uzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569274; x=1785174074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QnMf7Oz5WE/3v9l+jo2BUBrK/b+AS4zs/d/5X9JacdQ=;
 b=JA6lLaGP2w9n62k0Sz34tGQ0eBy2neo4lIRx2uvDAig/prJhKl5etWbpu8q+Rv3k32
 B6saSAFbPsIrUJAIotP+SujI/9V4xzWnk996vfz7nUah4UaLrBDfUXZJgtNLiraIwmO7
 q90sKh881HlrVtw8Ug2OAeQdoLe+ZDpzkRNWW/oW77z6jhbNCO6tLLP8tToU/A/jxJz5
 qKKroCovNdQO2jjUghydLVvKSYXDXAzcc7Yzvy4Xmo5tI5SRgwduP1b1YefFly1wZXcQ
 6RrnQ0HcVC9heRhbS59aQAw3ReRlQBCIiLfc82HSbUDygwz1fwwaovWqkd2rTS4JGlPz
 08Uw==
X-Gm-Message-State: AOJu0YyQzL7ZaM8yEpvqvD5YbfxZvNcIup4UxWSHAZOpqQFKEosLTchh
 els6YtI13s4kvuGrA30uHnQyeNZmhFbu+Y0DMaIc7eiTUU9h92pY6n+bhlqb46qRiWHKP2DjNWQ
 TKpPjHEaR306m4m0oY6yl38oUAl+f0PhE8KI57SM9siJ/OtMzu7bKkX4qu6d9U2xf8Q==
X-Gm-Gg: AR+sD12WLLBn+l5PvrjfqoZ4pdLFlaOwmc/hZjxOQd7vNJ86boVXmYrnSQ5/PhIHfYo
 SQJc/qHIO+WdPMtFKo8PXWl2+LjlCmQ/3F4do5un9HWEWcn/O0BqjAVPJBADGx0lS+VsFJ0r4L/
 5PEog5KGb0Bm9fiVZH7SX+1yEsRfAuxO5S3Q5sz/uSUHaUFAZ9JGKk1kErj6nqLyPtiVyI+xQ7K
 JBWp47bEHAhQW+5q7klgx2bIUJ4be155e/fcDvkcOVsnc82z4QUrhN336p3pqhVK2wQFVOb3+RY
 ZalEnbxSBPCYa0Pkg2CDJl1ny/z9zQlVyD3oTf6jAyFAKGywYEJ2o0TnioEQ66adNztbouFuHNn
 SSrumDMyLta9PB2zx+hVkUooucTZZJXP/8kpbf+ahEZTOgyIypzduug8SQdRh9ZU=
X-Received: by 2002:a17:902:dacb:b0:2ca:329:3da1 with SMTP id
 d9443c01a7336-2cf348abd80mr172240915ad.16.1784569274286; 
 Mon, 20 Jul 2026 10:41:14 -0700 (PDT)
X-Received: by 2002:a17:902:dacb:b0:2ca:329:3da1 with SMTP id
 d9443c01a7336-2cf348abd80mr172240585ad.16.1784569273626; 
 Mon, 20 Jul 2026 10:41:13 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm66281257eec.21.2026.07.20.10.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:41:13 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v3 02/13] target/hexagon: fix PC advancement for non-COF TB
 terminators
Date: Mon, 20 Jul 2026 10:40:58 -0700
Message-Id: <ab16d424acd9b300da0149b129c952efd4f15585.1784568922.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX6ACIYigOhk0c
 kSiUudQwFF+y4JmetYHcvXEXg4LuesG74H3JQ1di2yyoQ7grpXnqb1/8QBhGUOjAfhOfQqIMgOH
 +J0Ov/W7OLx5WoQiJglmJmo9W+GBluk=
X-Proofpoint-GUID: 85BmJ-kiJtWVPMcd1DMgHrvbQWTAk4oY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX8hWzDQFkPov0
 3cUbem7vrSFHRv/m7pDC2HWQZ6pxCpInI5uhuW/UkGDIQi8u3upZN5ebhsa3d8Cv8nUKY1QLYRL
 ZOLlvlxfvyA0whKZpUIfCjFhBaR5ybZKJ2+l5GIoZpMyX4xTJCrYC4ltmtPuW4zmz/W0sh3jaaT
 ZXhXV7Ne1cMByGZ9Lu4wMrj3TpCwerELzj4UnFoULmdQRw6vNxRaIWsUcYQ7gt7rCNMYDJzOoAX
 cA58NqieGYjN3Q1lphfGF/FAyE1xs+XxTvvpTG9zgoDtFCc0vryeAQ6k/P99+8YSMYZGq78yYmf
 KYXdz3zQfF6F1lsVz923MYpz+2DDzjIIPy1lQDXs6a6cJ2j29dXxbXrRW0P+ltBJd1eM4ZROQqZ
 2wIWZoR5b7+nj9f9HL2G8sKpgkZDrwdsglWcPdOZJt+7EBOaceg/PLG+Pyouq3t5SNM3zzvHiPS
 ahvul9CoCCUVDkxiJFQ==
X-Authority-Analysis: v=2.4 cv=CpiPtH4D c=1 sm=1 tr=0 ts=6a5e5dba cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=4a9di1UdVY1t8Q3xuf0A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 85BmJ-kiJtWVPMcd1DMgHrvbQWTAk4oY
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

Some packets end a translation block without a change-of-flow. These do
not update the PC during commit, so gen_end_tb() leaves
hex_gpr[HEX_REG_PC] pointing at the same packet and the block gets
re-entered forever. Set PC explicitly to next_PC in that gen_end_tb()
branch to fix execution of next blocks.

Note that gen_start_packet() used to have a special case for
tlblock/k0lock, setting ctx->next_PC to the packet's own address. This
relies on the tlblock/k0lock helpers to properly advance the PC, which
is never done (only env->next_PC is updated, but that never reaches
hex_gpr[HEX_REG_PC]).  Drop the special case so these packets advance to
the following packet like any other non-COF TB terminator.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/translate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 534b065caad..133d9f10ee8 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -217,6 +217,12 @@ static void gen_end_tb(DisasContext *ctx)
         gen_goto_tb(ctx, 0, ctx->base.tb->pc, true);
         gen_set_label(skip);
         gen_goto_tb(ctx, 1, ctx->next_PC, false);
+    } else if (!ctx->pkt.pkt_has_cof) {
+        /*
+         * Packet with no deferred COF that still ends the TB. PC is
+         * not updated during commit, so set it explicitly to next_PC.
+         */
+         gen_goto_tb(ctx, 0, ctx->next_PC, true);
     } else {
         tcg_gen_lookup_and_goto_ptr();
     }
@@ -293,6 +299,7 @@ static bool check_for_attrib(Packet *pkt, int attrib)
     return false;
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool check_for_opcode(Packet *pkt, uint16_t opcode)
 {
     for (int i = 0; i < pkt->num_insns; i++) {
@@ -302,6 +309,7 @@ static bool check_for_opcode(Packet *pkt, uint16_t opcode)
     }
     return false;
 }
+#endif
 
 static bool need_slot_cancelled(Packet *pkt)
 {
@@ -581,10 +589,7 @@ static void analyze_packet(DisasContext *ctx)
 static void gen_start_packet(DisasContext *ctx)
 {
     Packet *pkt = &ctx->pkt;
-    target_ulong next_PC = (check_for_opcode(pkt, Y2_k0lock) ||
-                            check_for_opcode(pkt, Y2_tlblock)) ?
-                               ctx->base.pc_next :
-                               ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
+    target_ulong next_PC = ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
     int i;
 
     /* Clear out the disassembly context */
-- 
2.37.2


