Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E85C44508
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwB-0005g1-GO; Mon, 13 Jul 2026 16:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMw9-0005fE-M3
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMw7-0006PK-F2
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9NRS2256612
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=La6u9P9hGx2
 XMRGIoiDTJ82+KI56tChJY1nT1bbhW/w=; b=C7DEw4Y372/Up5fFb3+dQDXEtgd
 0OtjesLMyAVpAyMFCYwvUEygzEhcVPIakgWugAvwa9TTObzW0bFipSbgSo/pNAvC
 +dXnJ5u6VZY+MLe6zDYSt5btDyOxZNe7FMd3BolMZtnrfcT/pIbF3f4rO25Mxmb7
 Y1iaIwwFRU/QgIQLwNh1YyfzP4BO2EALGS/FSWJjbJChqkhFU1DHbTg5xhT46hA9
 8dXcGQK8WUb4YOhgbY1lnmqg3MGDwk1EiAQLVMH997qgux+PdQ4nT84bZXuU8DhL
 N/ldikMEkJDYNThtFfeotpdp5QmP8r5kICOn6jiYVNZKcsYSuThj1AS81gA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9tdwa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dad28e86eso542928a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973249; x=1784578049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=La6u9P9hGx2XMRGIoiDTJ82+KI56tChJY1nT1bbhW/w=;
 b=YFlW3y3+3SWizWFEL2GmfBg59SS/TrZOyOdQ8bXJfqvxhDBZjGKBzXCiBkVBQ9nZkQ
 qOgSpFyS725UQblhbRC56Zm71NWpGlTfWme7tTpfKUj+pEyvjc+zhkpVt7y0CS9s0S3E
 isgMjppxUx7xiRfG+iw3mQv/QArHIrMngdKMooAFT0dJ+NYdZ8Yfvd9zKblXZgSaqp9b
 MSr3l1EuVpyaa6XLPVQ/YsRcBBUcOGzBoLJXyoEjKq7stD4O4WtblTJpy3DzN9Neoe7H
 5SGad6BnVQKcnR4mPzqjoJgH9LfTKXaOtkKhkdqwxkARP0mV9yk4oy4git6SjnHStwJ+
 TFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973249; x=1784578049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=La6u9P9hGx2XMRGIoiDTJ82+KI56tChJY1nT1bbhW/w=;
 b=dZUJWk8yFY4f7fniw3Y3CumE9zadhQO1pvxEZfaUCtHj3ltd4kr2ZEJvBuAf7UGGf+
 CQBoL//JbJjQQA/N1AFQARse8OmHLCk5IkHfc2WBqJGUzotsZoKOhLL/+CEudPBtcFMg
 3drlkjrhfyq8w45nhKgVyu+kQifHfB6qUKQlMfk7kT9eh8uLY8xa5jTEVS6+ofysXsbQ
 bBdOWvDhIEtH+d0QpzbD2Ub0HX79EBM5uUWnlYItHMeptxJIHDUQymiPkx7czz8sM38U
 JnVS8tyDbnOSmnSa9R4C34b9v6omQKTXimNTQIYJMrCZ3g4CAfsPZEjqMUQfGHB2GvyU
 M94A==
X-Gm-Message-State: AOJu0YzAu3HPItIn4FAgIclm1ePN3TlD5IqmHCwnp5UWF7LTO2+4Eb/n
 FA6A1ExXvH/Yi+Yq1c8hk8Bj+9lN6mCjeUYevgSI3oYmMmW5c7k1YsVb+uch/l17gxBrqKZrAVl
 gvE89EhpCRDGc3XAXvLsrgDacHlyeUOrEU/yjI5IFE9AU/88uQ/P9DPjL/4v2BrmsXfFj
X-Gm-Gg: AfdE7cn3vEsyLVfYfHSqG5aqNxe2enzeyavEckmdgZSAsc7d2e0TtaDOAyt6+QipwMf
 Nj6LuFWIJETxM7vlNTrk8+RutuyjYgM1HFPknwFV2Qn9xrHZnCYyFx81Dv/CXJ+HT2EA40cpbU5
 FRTlZxFrl5f6kOpqZ/o/aHjyk8IOhE0VYbzdkUPKlug3HGmBW0p9oZrpQ01RTAzUDxoH6DaLNfH
 uaJZqzF1n/qgaaRbO0h/oE6xEA5g2CbAzKZ9W4AJgePm/dBYmXZLmc9Ng4ysNbjhU9TBfiWnPRU
 jIzFI+NMqtktiybF8YPIoyKSiXx0ETnr8M6eSXwowqF6JOJsyZEtWJCeWl+FV4HIH9+YEqD/s3H
 VSkbag6Ijq7RZKDXd6Xc3mCELWfAqGeQzxHmk/tqyJ0Yo/HBMCCQgJraNBEPXrN73no9N5JRuow
 ==
X-Received: by 2002:a17:90b:390f:b0:381:939e:adf0 with SMTP id
 98e67ed59e1d1-38dc7752a8dmr9025336a91.31.1783973249351; 
 Mon, 13 Jul 2026 13:07:29 -0700 (PDT)
X-Received: by 2002:a17:90b:390f:b0:381:939e:adf0 with SMTP id
 98e67ed59e1d1-38dc7752a8dmr9025314a91.31.1783973248925; 
 Mon, 13 Jul 2026 13:07:28 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:28 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH 02/14] target/hexagon: fix PC advancement for non-COF TB
 terminators
Date: Mon, 13 Jul 2026 13:07:10 -0700
Message-Id: <c0cc9ab4c7df71362178a74d52a813cc01e7ab8f.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX1T1tsUZbWPhy
 5T4HTHsE24sIyjYIA1RngjrlOklvB0nGiXOQYLDNtRirPiYjYqXn0VsBH3Qrs3+aEcJePVD4Bmf
 z2Modl1SCtUZRSziL9e758YO1oZxyjJXvpbJOiOilfNs/KS8mwuhtyuIK+GWC06OfC22F+1fxPs
 hQtDHBJmRfFwxbwxrpDcIG8B8eM8QfTYamLpsum9PvInGde1q6CvhSM2dacZ7MbPpOrBcMxfsge
 YSGNlmRNOqWXocaSzaPHhDypn0MPZXKYeA3ac9ZtYxwQH4vgSKF70bG+Mw4EIqrio0Wib1Pf1bX
 BiVspc3Dcg7isGWRXIrS9xBWJHwBsbVBoIRODUTp4kR5xhqiih1rDtCfAqfbAa310/Cp2pT6nEw
 Nlm65If4GULhqIIrQAmub6Z3WRf/RSbElMtfrb7zGE0rh4y3tQgSmtgFkr7aTDZyyQu31ivMEup
 3imTixQTjhbnmBVAIVg==
X-Proofpoint-ORIG-GUID: kr6NTeA2Q9DITxJOBlhuOldMZe1D10ke
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a554582 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=4a9di1UdVY1t8Q3xuf0A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: kr6NTeA2Q9DITxJOBlhuOldMZe1D10ke
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfXxyNotir1aRCe
 HiTgz3cjp7x5EF2Zae19nNCzDdDfpICf3Tq5eAM8iqJ8YZxL1aPyXJBYWyvEQeJMJO7l8rU3V+b
 kGB4CHi2ALpUnAb5zWOr9QTi0gl5nWE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130208
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

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/translate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 77235916f4b..06e76a6ba34 100644
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
@@ -282,6 +288,7 @@ static bool check_for_attrib(Packet *pkt, int attrib)
     return false;
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool check_for_opcode(Packet *pkt, uint16_t opcode)
 {
     for (int i = 0; i < pkt->num_insns; i++) {
@@ -291,6 +298,7 @@ static bool check_for_opcode(Packet *pkt, uint16_t opcode)
     }
     return false;
 }
+#endif
 
 static bool need_slot_cancelled(Packet *pkt)
 {
@@ -562,10 +570,7 @@ static void analyze_packet(DisasContext *ctx)
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


