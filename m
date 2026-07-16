Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009D3C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQUe-0000t6-B0; Thu, 16 Jul 2026 14:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUc-0000sG-G0
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUa-0001Tr-O2
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:30 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSluU3395615
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KB0+ifjklJB
 aJetinnUHaAFa+mf3BVSV9s1av0ljs/c=; b=fr6U8RsdZgvjaDLKqoe00HHzQ0w
 3sKmPytOFjCzucpBbD7c+NUA19RLUSH+5o+1hUOwcSPLUs1W+jg0U/bd8tJPbEz+
 bGNluixrovLWtzrWBL+/ETYG8ujdvH7dbv4vcSx2oetEXD3ezOmgUwHRePZgxmB4
 N2lre2EH3ELuYlfvRZXoSc1lAfa/WJwdYqnGQ7vlT5glIWa6ci2aYVfgGoKAlGI9
 XoWRX+8pINeRlJ+oweVeEOTeDUpoDdn0Yx6l6zH43dDX9Nka4HP78gCkI60sePcd
 MAYTC9CFskiKvxijH/5cuhiqYT7aL9CTjuUNxF+za7AdCg/CNtQh2ZUMQhA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym19f2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3811ae55313so3350220a91.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225247; x=1784830047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KB0+ifjklJBaJetinnUHaAFa+mf3BVSV9s1av0ljs/c=;
 b=Ot6DRzzzH7w2Q/Eib1gKWzvZGEu2wruVIQVGGXjhtszgCm+wDFAvBAW9qnyNtXhZDI
 AEW160oPJpZaub5zfTYuc3NDRkYKR07WGr57kc0mUn0eLlYBXfM1T4MVQdlYNZL7nhHH
 Pq2ESyfH7wwAQq+LnWge3lgIn1bgO+BTpnA3MK+fFtIZFjSktgBYsSeiBLPRKehXoTgn
 IG4vwAra5BDgNCi5r2oseQVAKGWUkBddIWg0xSbnMb4eWB54Yx7rVuLNxFuK9HRGbEhu
 6+5sBhh9sFJzgJM39M+vb1OxgICAy8I48hdT1xrWHuyWgeuVypd7J/GivWTo82RIuKHt
 24vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225247; x=1784830047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KB0+ifjklJBaJetinnUHaAFa+mf3BVSV9s1av0ljs/c=;
 b=jJZKeL53ODMAMhxVeTnaVgCeiaiHCrfrRzJ8DGT+GNLuIJKRHRe/6QAJZY0xaDeVVp
 3X+9vqMNI9QJjf6Ihjqez9VqGCucGhWIOU7oyGZBDcBYWBnNbcyr9LoeD7M4awNiZP2s
 DI0QTeQsEgajtNhA3FS5osBNHN/3oXssyEI7ULX6w/pfxenI+3rgA/UuQGkTH2dEZ8Fq
 NeER8V2Um/tVS9HIw+HtZd/XVFga+6QNzzk8VYRqtHEBTy8c4uv9HwufuQFHI3Fs8QkR
 gYaXqGGpIK3Ke0Cq1ODlQdOMPvu7YBH12cue7TfkJjL1PBjmK+0ltC/7OxGUqbl1LpKg
 MU8g==
X-Gm-Message-State: AOJu0YztqxRVke8IcBPoaEyXwT/LMVMdB5S9SfZIwOkgzmxVc5EItTSy
 T5zxmMbrd/OQvbGZfXPtVP2uybV7g6LMBcznmkURbvdWaHKm42rO9RPb4uSRWKqBTdvny+NMuRd
 khAakBqZeuTuBSNycWUu5v9LmEoQdd1pbF4gHONQlP+VI8NFPMAUWx4ImRkyXQ312qA==
X-Gm-Gg: AfdE7cnpyK+BuWa6Noy4EcUkNvkmfre/9C/WPoWL8W9oiS51RrP7gfA9Tg3eGaD/9fo
 z6g7opjd7W0j4KKalY1hGjuxA+C1Sgl+JC92g9ZIDqX8gitl/BLOJQIoI1rWmSE9uFaFj4isLKR
 rQ/svd5PNykg0iSCzEWHIVFuQaxSql53tRaf+/AsmjWL5bHKu5hZGM/2qldHMFWjytX9uk+FB4K
 gwTyLZ1x11E+TMm5XONMwbtEXhd28VZR0teYxIbTu8kpzE0KUXRPOGs0zNTd+0w8pKB4dQk1TxZ
 4b7vgPtrIUadM2Zt6PaWUZzzM+nwd21NTFQ8Lpeh0Ffc6k76buKlzMP987+f8O+Hd3Pe+vUo9s4
 vWcluO+cUZ2N2IqoJIuRorRrsVmkty9ZbuxBo4HpWr6k++XifJeTysf/ywvoprnA=
X-Received: by 2002:a17:90a:d004:b0:382:3dcc:1487 with SMTP id
 98e67ed59e1d1-38e4676ec91mr686014a91.25.1784225246578; 
 Thu, 16 Jul 2026 11:07:26 -0700 (PDT)
X-Received: by 2002:a17:90a:d004:b0:382:3dcc:1487 with SMTP id
 98e67ed59e1d1-38e4676ec91mr685976a91.25.1784225246166; 
 Thu, 16 Jul 2026 11:07:26 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm17131184eec.11.2026.07.16.11.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:07:24 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v2 03/14] target/hexagon: fix PC advancement for non-COF TB
 terminators
Date: Thu, 16 Jul 2026 11:06:47 -0700
Message-Id: <2cac81d1782c84534dd3be657541fda020e5613c.1784225209.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a591ddf cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=4a9di1UdVY1t8Q3xuf0A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfXwL/ktPAMwqwt
 iRIHmTaC7Vg09sEfZSTt6B/kyA/sQbG34h80fbmY9Q0OHJ4QD4ksJXrf/J5jnRlFO6RprrLh1FX
 ioLKLBOQ2aFLKYt2y7LygRg82np1Gftt1tZkWaZZnt8e3D6NioslozT9DSaQUxs3GCHKl/Ol1r1
 UB9ukN7dyYP1iHrjk/5IMlV4C+odHqnMVHd5sWT6qQsR1GOa8OOAtvKne6heENNm+9pqRvE/6Xp
 J+LlMRdh/d7fCGnR6beroDLI7QaxBQgG3EvMAdDj0OjsiEhRo4LvCi16HEFUMGx3mO1TKHeyYuj
 qhS9FAlAdhChJUheYRaDyWVaC9ZUMwifnlBNh4WVAQiAp2ZTYNsIdHjlcCtm4AWW9mwA+TYkngv
 Hb/CAnxbSlyaifUYD57KxMr6HWf9t+3Nyl0rwYSCl0DVd62/d00hI2vqWhur2kj3tLQI6dkEdf/
 JSgfRPqWwDTHirWfcCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX/ezZYJ0HozR/
 1AM8u8fIZr1371oGYLb9n8JW8ld+lNnX+DjxHBD8jC9s2iuMPzdTzXsDvkDJFNDhBy1Xygetphc
 SlrY7YYHgafWFvHLT98fFPWcI7zbFMI=
X-Proofpoint-GUID: fvMpgJnyrxKDVfGpv-TNxBZKKtPSN5rl
X-Proofpoint-ORIG-GUID: fvMpgJnyrxKDVfGpv-TNxBZKKtPSN5rl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160185
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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
index 341842c6af1..f8b87c279e5 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -210,6 +210,12 @@ static void gen_end_tb(DisasContext *ctx)
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
@@ -286,6 +292,7 @@ static bool check_for_attrib(Packet *pkt, int attrib)
     return false;
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool check_for_opcode(Packet *pkt, uint16_t opcode)
 {
     for (int i = 0; i < pkt->num_insns; i++) {
@@ -295,6 +302,7 @@ static bool check_for_opcode(Packet *pkt, uint16_t opcode)
     }
     return false;
 }
+#endif
 
 static bool need_slot_cancelled(Packet *pkt)
 {
@@ -566,10 +574,7 @@ static void analyze_packet(DisasContext *ctx)
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


