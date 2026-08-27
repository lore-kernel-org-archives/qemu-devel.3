Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88631C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcFU-0006Hi-B7; Thu, 27 Aug 2026 11:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wzcFS-0006HI-RO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:42:38 -0400
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wzcFR-000193-0F
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:42:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=LOINFNK
 9A4AP8DHxnZyFYMxpH3/K9wEQFHYWzDOydL9vNKUdE3Meucn35156aMc6fePT1YY6YVs5t
 i8QhOti4Mx424pxvxBSPf4Ny4GUXJmlVTKVzqLenBfrt0hIB7RTM3igkZ17EBywDJyEZ9x
 Xde1p34wfUmnIQnK1KAuqiT9F6jayLihssKLq+y4goxsH0A4zvd4Ui8NOWDBA3uP/Fmy68
 CBGvvFzz3NHo+FP5fCKxUV9xY3tw2VPVLe4UPc+62LKHs4p4qUmmXHHSgZWG2n2zOcNtmt
 LWsDV7Sthiy7ysqrTLFBBMvwhKkGuTYzKZlTfOTsGPnYaQ1uCvNbqig==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=L
 38mssKJShTqPMLPvNfwMyO1HAru0zAlCLDv1fhZDAs=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=kAQV6JQFgAAMFNDIGLJuQpwy61U/+KtvZuf8I5mo1NWa9r5IFsX3W/WJ5eZrL6HeXJo0
 tpOqhadeNn0yiARzqPGxG+0Bmw8E6kZ5ppcuF6yNlZfKv+s+1YuZVG17hEEIwK8VTWwUCx
 frF4FRC/3onjHg/4U7ZXRsZuAzwimqLz8Fh+QFE95VWmC60B2W6+oFYclEPl+Nki8GlpEs
 hMOQToBpqL2AjHm7pUPTieHTLImsoIFAXAs+R+cgFi8trlJ32hGDQiNpmJBNtwV48gbT6W
 52q8VIUKaSzNVDNNbETrV+eQe3cV8ALkRFGKAZEJ8i7yqp52vmrz2l6A6dualKaA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=BRxBLCUM; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=DJyGDwGL;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=L38mssKJ
 ShTqPMLPvNfwMyO1HAru0zAlCLDv1fhZDAs=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=BRxBLCUM2ooN280PqpjkNAuN4x3P/pAf2vu
 UN79TjLGmPueDEGLmU6e2+zuaFP3vsy5/ENK1LBme4rIHpUkXBmVLFl1G8SCu6sZUl1fKQ
 OmlaCBWvuJWAexc4ufHVZTCd5y1gUWewHkWOcbGFZznpZQz+tmlEweGX09A7b/dtCThb/R
 b3D0G1CoCGcS+B19plmlwvuTjZty/On1cuYNKpHuEN778Cf13guL/gf/DppBJY38vdu5GY
 rKOeZgxRhSXXKOFEfTTW9Y+78fFN4jr4azpCRkn0HOHIeynFZCHVa1qCjDTjVu4gfPyy7k
 7+Yrplyer5kqJKg+zCWgvjt3wpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=L38mssKJShTqPMLPvNfwMyO1HAru0zAlCLDv1fhZDAs=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=DJyGDwGLlmjmROCAYd
 bgvvjJLnV4kcQwD+nIG1Uh2V8iI6qxr7zedCPCQHGBcwvVEoqvaEt3NAV87jfNrFuSCA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 29e3f135
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 27 Aug 2026 17:42:33 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 136dafd6;
 Thu, 27 Aug 2026 17:42:32 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 2/5] ppc: Raise decrementer IRQ on zero write
Date: Thu, 27 Aug 2026 17:41:14 +0200
Message-ID: <20260827154220.84845-3-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827154220.84845-1-kirill@korins.ky>
References: <20260827154220.84845-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

OpenBSD writes zero to an edge triggered decrementer, then enters idle
expecting its interrupt. QEMU defers the already due edge to a timer at
the current virtual time, leaving the guest stalled.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/ppc/ppc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index b123b4cc1c..d99e47d532 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
      * an edge interrupt, so raise it here too.
      */
     if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
+        ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && value == 0) ||
         ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
           && signed_decr >= 0)) {
         (*raise_excp)(cpu);
-- 
2.55.0


