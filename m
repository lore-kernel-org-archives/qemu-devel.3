Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C58C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmizt-0004b6-2w; Mon, 24 Feb 2025 19:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizq-0004Z0-Fn
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:26 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizo-0003SJ-0R
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:25 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 194F0254018D;
 Mon, 24 Feb 2025 19:40:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 24 Feb 2025 19:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1740444022;
 x=1740530422; bh=KCkRYG/jH7j0XUGmJo5gVnglQvXIToUkt02zHQ4OVAo=; b=
 ZkU9N3LEUFDqweHzXQzVOL4K/v2D8SryFOGQXiSjCKE7JisdyZOnwRG6iSCZ5z/Y
 M260g2eGIEtRciyuM3C04ThNGeGOqKwABfhh2kw/X2neknSMlWvqpeuKaIwfyU5H
 6Rh13autGSc3QWS2TrK9lxNAd1guysCWZup1Se8XrfXIFIFYLbLbQc4qlh5zEdm+
 tv/hsrVDNkF7riMxb0jc1VOWk/wA8xIjPcnevSD5qke2dVXJ0NUTRe8XbHBi0j6Q
 PYcnHGEGodPlxQ7i62syNRSIxy12tphuIx42Q2tMqY5loswq2QieaTs66kv6pDRN
 2uakQrqe/v41ynrgWaMBbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740444022; x=
 1740530422; bh=KCkRYG/jH7j0XUGmJo5gVnglQvXIToUkt02zHQ4OVAo=; b=O
 rtcVwNO3ne+YSJszU+Z66voCT2foSrvO7w4BbJqFNEWkdZo7z7FFU8ScyEtunuDk
 RMm8jDevX8+wQNac62LPF9c/I5xQZ1RplOyv0226gqR0T+7UMhQ/J3MsOlSLKZkz
 nBcxrUQYnQzeTXt8SJOSN3yJzWl1EZfWT5g7mDzL9IhqpInWsmv6cfJW9b61IWuM
 xQ0ORFro7vvdau5CF+o0K9MO61KECTO1H2FcSwqUVDo7Nk7HtfdEs5HjTDJFTE3+
 F6DC0l7DP1wWKQ5pmtHHQzoih+AXE/pcOUHM0UP4HxT2AZeTLXlnE1Oy3bKFdl+m
 3VyHfuTh4IcYBkiM14Dmw==
X-ME-Sender: <xms:dhG9Zya2O4f89Pepxjmx5wVQ4jGEOxOUGqofFjMgXZtpH9RFhfANFg>
 <xme:dhG9Z1bOEGGRWU1kEmukYAqC7KJG_xEyBcvm0hrK6ePgYmSNQu8nVD8vhhoVX36Gl
 Yvla9gUjGy3rSJ5NU0>
X-ME-Received: <xmr:dhG9Z892MTAc0E9ff_cm10MPGiVhsRyClU423OCYR_V8XNn5pdfEJxU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektddviecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohepghgr
 ohhsohhngheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehqvghmuhdquggvvhgvlh
 esnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:dhG9Z0r8hEOlB7C6Hj4qSSEPc3vA0oAtBxi80TO01-c82uFza_vOeg>
 <xmx:dhG9Z9qrxTY3FQea8DolKhOiNsco6VzhEC2wbtNu4SaeC6KoR9GreA>
 <xmx:dhG9ZySkbuSb6nnTbhMabbmSB8xsfcXQ1ur7V9TnpPsAFWdAGm4Flg>
 <xmx:dhG9Z9rMYaYU1_1iuNXVYMrkWVqsifBJaatq6Erwz5-1Ei5zTxYN_A>
 <xmx:dhG9Z0XqESWY8m-o1mP-E3WnHGtGutFF2XXJrABzwxo7IYznsKn0JLau>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 19:40:22 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 25 Feb 2025 00:40:18 +0000
Subject: [PATCH v2 5/9] target/loongarch: Use target_ulong for iocsrrd
 helper results
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-la32-fixes1-v2-5-8ec68ada3dd5@flygoat.com>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
In-Reply-To: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=202.12.124.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Those results are all targeting TCGv values, which means they should
be in target_ulong type.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/helper.h           | 8 ++++----
 target/loongarch/tcg/iocsr_helper.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b3b64a021536255a3f9decfc10ff61fe8380e2ae..409d93a5b0808f0e32b8c0e2e17cebac9feaf8ed 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -104,10 +104,10 @@ DEF_HELPER_2(csrwr_estat, i64, env, tl)
 DEF_HELPER_2(csrwr_asid, i64, env, tl)
 DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
 DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
-DEF_HELPER_2(iocsrrd_b, i64, env, tl)
-DEF_HELPER_2(iocsrrd_h, i64, env, tl)
-DEF_HELPER_2(iocsrrd_w, i64, env, tl)
-DEF_HELPER_2(iocsrrd_d, i64, env, tl)
+DEF_HELPER_2(iocsrrd_b, tl, env, tl)
+DEF_HELPER_2(iocsrrd_h, tl, env, tl)
+DEF_HELPER_2(iocsrrd_w, tl, env, tl)
+DEF_HELPER_2(iocsrrd_d, tl, env, tl)
 DEF_HELPER_3(iocsrwr_b, void, env, tl, tl)
 DEF_HELPER_3(iocsrwr_h, void, env, tl, tl)
 DEF_HELPER_3(iocsrwr_w, void, env, tl, tl)
diff --git a/target/loongarch/tcg/iocsr_helper.c b/target/loongarch/tcg/iocsr_helper.c
index db30de2523fff01bcc8923eb12c7fca7bedca7bf..23d819de0ef9790eb82741f1e8a0e20dc139bf4b 100644
--- a/target/loongarch/tcg/iocsr_helper.c
+++ b/target/loongarch/tcg/iocsr_helper.c
@@ -15,25 +15,25 @@
 #define GET_MEMTXATTRS(cas) \
         ((MemTxAttrs){.requester_id = env_cpu(cas)->cpu_index})
 
-uint64_t helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
+target_ulong helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
 {
     return (int8_t)address_space_ldub(env->address_space_iocsr, r_addr,
                                       GET_MEMTXATTRS(env), NULL);
 }
 
-uint64_t helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
+target_ulong helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
 {
     return (int16_t)address_space_lduw(env->address_space_iocsr, r_addr,
                                        GET_MEMTXATTRS(env), NULL);
 }
 
-uint64_t helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
+target_ulong helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
 {
     return (int32_t)address_space_ldl(env->address_space_iocsr, r_addr,
                                       GET_MEMTXATTRS(env), NULL);
 }
 
-uint64_t helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)
+target_ulong helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)
 {
     return address_space_ldq(env->address_space_iocsr, r_addr,
                              GET_MEMTXATTRS(env), NULL);

-- 
2.43.0


