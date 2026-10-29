Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED6606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=zW+tuuSG;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=KkMIw+9S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMU8W-0003Xp-5Z; Thu, 29 Oct 2026 13:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8S-0003XT-Gb
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:41:56 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8P-0003HB-5E
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:41:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=YZQVzvC
 a6gseRVlxYQKM5nbop1rPH6GXJM/jwxjSJCbkhD9FWp7LUHyg3Coyt1Dzj0PuuvOyreWNh
 DlumXs7LvgM5U4O3I9Aucnxnu8P/uYN3xg9w2APqWL272pS0wHoR/CCOb3P8+3+CqXAVfg
 xGMRMF7nl8O6hLKonh+wwd5SjFUodb42pGaslKR8tFuos7QbmkdeTI6Fewq8TolrjnDIQd
 3TpaIoEEC+FvxdfZx8LUDqv0UQdU2zVeczzHTdrqS7FNS/xdxHE/APO/Rfj8eFpJS0Wgn3
 iNbq6ga+5Zr0lRSb0rLc9619GQl1SJcwvtBHtIARMpqqShvQiDnNULw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=A
 vQqO9B+9z2wC4qqJ1AjC6Gj8Wd5bz4fjkAepdoqxqo=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Hpn2uwHKh96RgsP2qAWSjPWHHu1A8eQo0ArtlG0GGEDjOjPmdXPMVApCky4Rz5oiP0Eg
 DjuiQ3uTyPOKz39djBGhI9s/3Kjzkgio766B3r2seuWo1M+KVdWwK7iywx1Lqnl76jZVn1
 DjOUoT955PPJEprbNnxm+2zZGEPjxmnZMYjQ8q8cVR721fg9MJfABYEtThfTFRdyweGb4A
 wWytYe5akqEj+/sSPxui4GfSRJ4L62+7yT5v4HV90fLv0R9Sdm1CZsp6kyZxxg4uuZ2d0x
 8HSaDtWctEETjsnhPW9uYEHur2qO9BHIgWiyqqnHX5dnOPKVauoPhaCMvMGgMjOQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=zW+tuuSG; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=KkMIw+9S;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=AvQqO9B+
 9z2wC4qqJ1AjC6Gj8Wd5bz4fjkAepdoqxqo=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=zW+tuuSGdOpDQRyk0khIb5b/lg8WoBfJRD0
 2c7QdO7m8RKFBdSTw/1rnFA/bCeCwYM6n0gOwHP6uQkqXcMaG4ZvTEIRv7r33XJB4i1pBO
 aV+hYsMcKsknJ2TQNjxjaQwAxvdSrhv0nYcR2sEc8e3bh03+BTAl2yeKq08MMHW7+0hAxS
 K54BiJCLZaR/CmulpkR8t5V19b4P++Pau3ePWG027wSbEJqHWj3DUyugWWnl6EcNnaLWoz
 hRWVPKnoGqw+3++FaTHZhZxL02o+xciXj7gEI1eJjn7dEINI7Yahd33BKy7nxwJ7capHJA
 2eGYgJqaMF498ckhfMZZglAUOCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=AvQqO9B+9z2wC4qqJ1AjC6Gj8Wd5bz4fjkAepdoqxqo=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=KkMIw+9S+IAiz5pwUr
 z2LyEYg2qy5xI63H8wh4/epgF6RedNVSKevJ2cM6bA+sxuMUeuF5RhAriu2LNLxXCtDw==
Received: by mx2.catap.net (OpenSMTPD) id 49e78960;
 Thu, 29 Oct 2026 18:41:50 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id c96f157e;
 Thu, 29 Oct 2026 18:41:47 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 03/26] target/mips: drop hidden TLB shadowing for tlbwr
Date: Thu, 29 Oct 2026 18:36:03 +0100
Message-ID: <20261029174139.44302-4-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029174139.44302-1-kirill@korins.ky>
References: <20261029174139.44302-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tlbwr replaces a random architectural TLB entry. Once that happens, the
evicted entry must stop translating guest virtual addresses.

The current helper keeps the evicted entry in QEMU-only extra TLB state.
That makes the old mapping survive until some later operation discards
the extra entries. A guest can observe this directly by writing through
a TLB mapping, replacing that entry with tlbwr, and writing through the
old virtual address again.

Invalidate the replaced entry instead of shadowing it. This keeps the
translated TLB state aligned with the architectural TLB contents.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 target/mips/tcg/system/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 9e01c07609..08b978b3f5 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -165,7 +165,7 @@ static void r4k_helper_tlbwr(CPUMIPSState *env)
 {
     int r = cpu_mips_get_random(env);
 
-    r4k_invalidate_tlb(env, r, 1);
+    r4k_invalidate_tlb(env, r, 0);
     r4k_fill_tlb(env, r);
 }
 
-- 
2.56.0


