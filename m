Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42244C6FD1F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 08:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roIvn-0006hE-KV; Sun, 24 Mar 2024 04:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1roIvg-0006fm-33
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 04:10:08 -0400
Received: from gorilla.birch.relay.mailchannels.net ([23.83.209.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1roIvc-0002wD-OH
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 04:10:07 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 156B11014F2
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 08:09:59 +0000 (UTC)
Received: from outbound1a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 6902B101B55
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 08:09:58 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711267798; a=rsa-sha256;
 cv=pass;
 b=XzWgV3ws+goXL9EGkcnPEocziZtz4+wESR5tBOs7RU6Benn4uNn1Dq/+YtO0ZGa6ev2fGo
 OoJhWZAqqN6Gm/DDP1+atEBQ4hMdcdaOs8gNKzdtIVCwa1IJSQYEnXgQYzSatztwHleTA/
 iifJLPFkux0WZ2o+YtNtYLDJolW3TjCtpS59MFUnPDKwYxnelQf6CfvyuZgxh3rbrYy7Lu
 7z7icwwckQD/fJytNPPQZduakPlaia/SZqVOBazg5inw2C5DVlj2nOP7CtJPo4VEDNlJBr
 37ZlC6OWRjaafvxrByD9SCNB/QAL0UvvHogHNb5UA0Vw77bZZF7WC0p23wS5zQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711267798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=l2PzI7P53KTO09sAnCgFmtRCN8IXV8kPXG5rOa9qBWg=;
 b=bJK7Ye8WnlBLbDXBbOkG5A6YGj5zfkP2cB9wzAB8JWRlYRytDv5J0Fkahk1D4bJMf8Tepd
 EiyPQyRGa1VPsJnv0U1jhkpmlbDQyFbXqRDx0f38wnvDM/CzO2Fec/pRsNTbkJWuxdriUP
 9w+V1mU+rlmxezTZJ1AU0Go1Zl/qAOub34d/MrBDd2Bsn44XNWVun95Garw6k0RP0YW8p0
 r/2GcU2NuEt+iw9l8NEwTpTi3wdCNMYAE2AycuyF013jS0R4G7ML1vrl/17PRLIHqzxl8m
 qgNc+ay9kcEQHDuZzTQMnPoggVBgIXbpIvYUVFygIokRS3OYqUk6U7BBtF99NQ==
ARC-Authentication-Results: i=2; rspamd-dbbfdf895-4w9nv;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Exultant-Irritate: 77e23a5b1603677d_1711267798913_4279982622
X-MC-Loop-Signature: 1711267798913:285527920
X-MC-Ingress-Time: 1711267798913
Received: from outbound1a.eu.mailhop.org (outbound1a.eu.mailhop.org
 [52.58.109.202]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.118.191.199 (trex/6.9.2); Sun, 24 Mar 2024 08:09:58 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711267680; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=aFecisRA1mfdYOHtxKygm+e8XWsFvSTeYdR6DS5H7tqXq8iWdDekdblTr3Yjc1A9iOL6Cgn2gja9s
 6a7Sf+gKLFN+amjIxg9h2LgY6OorgLbXxVPEi9Hu9CTWKdJZlkakU5IYedS3JtA2Hd6U08LdTFWdZa
 Q/bT1QA5ITIpi5nPU2evzgG4CpwGIS47nsV/oTOmEVe9A9bfhf3WwEfzBQQ3S/AGlA3kvaSH0Ma7OI
 Yspk7U+l74zkbz6Hdveiu+HJV9ZXWCH765GI/8HGpuRRPI+dVA5JfKu4zKGo2L/9G/xkmltBerjcIN
 0Met97zwdTXEiQ8xGW/hcMdaUtAp1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=l2PzI7P53KTO09sAnCgFmtRCN8IXV8kPXG5rOa9qBWg=;
 b=aT0G6sNDBj6IUOpbnA1h+sXIWV8YmQOqKie0YEvsEcDbMnwTa4e+j6KHEIL3dy4sxYkwWFO6sGBZt
 Ya+6nMu+y1JP4NhT6YE9L9sXF4KbpBtVftWSo80UV8J8on3pr0dFflTasxf7oDaToB08q77xV3xAdb
 Y/YABnUVVKr4Fh8bND36bWR/e8Em31cbYEdLuRMUvBd0h/6rlg8CMed2yDiRMi2CR5OOgEf8+Z/Z3H
 BmHqieRRIhaQ4t7j6iLwGbpW6eVj5aNh51VKgxjk4tcY8Tb9mzRRGswDuLxIkZPMHD8fFLaOkuySN7
 UsrT+2QwQmQwjCn/xD3gPEDniD/J9wQ==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=Sdrz7IaY; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=l2PzI7P53KTO09sAnCgFmtRCN8IXV8kPXG5rOa9qBWg=;
 b=JQA8HvTOJHOzOg+w8KXQYpzAAkw8rnUyg4calKwtnGlZ3eNMm/oHiPPtkQA2QtQA+rHAjwXuQCM7o
 JEVyXtbojzkFlGJQRnVltqCFaYG6z2mFKL+81x21QWLfDgxkJ+px5tneq+VYcVe0Lkf3h+W3MlS0lQ
 cV0UhnCKiQXWeUnY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=l2PzI7P53KTO09sAnCgFmtRCN8IXV8kPXG5rOa9qBWg=;
 b=S61Cj4+UYaq0aJ9fQpaohz/Bd2KO6iARNFkzjFcKndi7cAYJnYJYtYu/rIK+vniODckckiHmZ7rld
 U7fPdoIPsukx2jXJzZA33RM0wUMuklCPbKsnL8rxFRjLNHN1CnuUy6H+Zod6/r0foV2FyGKlelb2vd
 tkfFusSDywkBCGzKu6Rlj85rsiEwan+EG+EBjRzzpAs919CC3TGYd+60SngpprEeG85BLgozOB2CWU
 KUNyNs5VQ+M5xijPcAFrq4AlYyvcFWkSq3Ed0zmG8UJe7phdouCCQ12MceVx2NS1wUTU/OXdatfAsO
 qnhtyslisIssj9sc75IIUP8eWYlwbZw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 9ee8226d-e9b5-11ee-b84a-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 9ee8226d-e9b5-11ee-b84a-9b9d9be6ef2c;
 Sun, 24 Mar 2024 08:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l2PzI7P53KTO09sAnCgFmtRCN8IXV8kPXG5rOa9qBWg=; b=Sdrz7IaYtjNfwN9mS0T+DRwqBQ
 wS5373YRMqVMoelUEHD8AokFVHLZQ3Nqge4raeCZfa8KuHVbYB2pDuXJlX0eUTuc8kWvJK+sbJPZB
 hP+4u6vgK/tcUI5ZVHLZGTgtg8428K+QuzHq6Gx7ZHn2CMrPi6SXglTa47SBF1ek8OnWT7BLbbheB
 jaAjkkmw9CGRKyKv9ST7H1mkogOJnBPRVSAt0EmEFOFRz4fTo71FwiI/iDsD10Tjtfus8D/iDaovI
 TIVrfAJdqu728Bmy09+Xua0Jyeweb6V9QsOAD06ipFgw03spFsxS92LxV6dbCD5amoUIdqbkA1aYA
 TQAWtX9w==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1roIvQ-005LYx-2O;
 Sun, 24 Mar 2024 09:09:52 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 1/3] target/hppa: use gva_offset_mask() everywhere
Date: Sun, 24 Mar 2024 09:09:43 +0100
Message-ID: <20240324080945.991100-2-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240324080945.991100-1-svens@stackframe.org>
References: <20240324080945.991100-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.209.75; envelope-from=svens@stackframe.org;
 helo=gorilla.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

move it to cpu.h, so it can also be used in hppa_form_gva_psw()

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/cpu.h       | 10 ++++++++--
 target/hppa/translate.c | 12 +++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index a92dc352cb..a072d0bb63 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -285,14 +285,20 @@ void hppa_translate_init(void);
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
+static inline uint64_t gva_offset_mask(target_ulong psw)
+{
+    return (psw & PSW_W
+            ? MAKE_64BIT_MASK(0, 62)
+            : MAKE_64BIT_MASK(0, 32));
+}
+
 static inline target_ulong hppa_form_gva_psw(target_ulong psw, uint64_t spc,
                                              target_ulong off)
 {
 #ifdef CONFIG_USER_ONLY
     return off;
 #else
-    off &= psw & PSW_W ? MAKE_64BIT_MASK(0, 62) : MAKE_64BIT_MASK(0, 32);
-    return spc | off;
+    return spc | (off & gva_offset_mask(psw));
 #endif
 }
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 19594f917e..0af125ed74 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -586,17 +586,10 @@ static bool nullify_end(DisasContext *ctx)
     return true;
 }
 
-static uint64_t gva_offset_mask(DisasContext *ctx)
-{
-    return (ctx->tb_flags & PSW_W
-            ? MAKE_64BIT_MASK(0, 62)
-            : MAKE_64BIT_MASK(0, 32));
-}
-
 static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
                             uint64_t ival, TCGv_i64 vval)
 {
-    uint64_t mask = gva_offset_mask(ctx);
+    uint64_t mask = gva_offset_mask(ctx->tb_flags);
 
     if (ival != -1) {
         tcg_gen_movi_i64(dest, ival & mask);
@@ -1403,7 +1396,8 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
 
     *pofs = ofs;
     *pgva = addr = tcg_temp_new_i64();
-    tcg_gen_andi_i64(addr, modify <= 0 ? ofs : base, gva_offset_mask(ctx));
+    tcg_gen_andi_i64(addr, modify <= 0 ? ofs : base,
+                     gva_offset_mask(ctx->tb_flags));
 #ifndef CONFIG_USER_ONLY
     if (!is_phys) {
         tcg_gen_or_i64(addr, addr, space_select(ctx, sp, base));
-- 
2.43.2


