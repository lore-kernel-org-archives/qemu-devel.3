Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21EC606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=xLjVBlwH;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=JhS75eaJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLeg5-0005Nm-LZ; Tue, 27 Oct 2026 06:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLefx-0005Lw-P0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:06 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLefv-0007qu-Vx
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=CeRGK8n
 WMyZh3wluI0XIjA0gxA8eSmm7bLdVfnxLxMUA+2U2NGjDAYdkbxUt+vOTLpImU1tKbrN5Z
 q5rbYoXxrtv/nk5uDsH+1b6U5ETVCKDVoMCJpz6h//YtecPTsLuwZ14mmqqYotZkrPNYGh
 JSx4WaDej6fY7QluGH8tuWQVDivhmdpJEoagD4pEd+mY73McSpsa+NJuNzTFyUJlK3FTKW
 +LxfCBWvVLc0cIUe3Bh2Pf9t+pgjC7tZ7OUIk0wQQ9hvhWxy3L6JvhdgCMqSxC+DwpKec0
 nDSfOslbdoA1njXp6sXdPhUGdx1oud8BjWedAqQ8YvO9LrdkYCuvSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=f
 ZWoVYtihMAGecRXeM0IB+dCNHoJM5vkDWNsfUy7TrE=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=RgbRwT0k2UxbbLjp0XeejERAyHopThaQUnpBhZTrFh3Zra7lfqtdK3gj8pgjz8Ton0Ww
 0XXlAmxJB+B4lN4aVu8hvuzxd76x7od/x4oX3D05WvdEf9D0oupeevXxJ0xb9Qg1F2wGfj
 Ww8KkBurUICWDwAV8/1tWKz83d1wV8+jCpHCv22Sf55tNPVDTolrQ0UjCeaX093JBfkNZn
 L+fhrSK/OMFX666arzQdkJXeWchEG6m5s6KSPGLDMaXOWQHIwBWUPMtnL6uVX8nW3CUuTY
 ZdA66U1I112pp8wAmsgj5bLkMug0iyISZq/RfC9xwBTr/xictTTa7o+RkKL+xgfg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=xLjVBlwH; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=JhS75eaJ;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=fZWoVYti
 hMAGecRXeM0IB+dCNHoJM5vkDWNsfUy7TrE=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=xLjVBlwHhYZoUUyPIEWkxHGnd6mJW3qqu7w
 w11jVd1295TbWIsWLF/qp2FVUY+qKpOeA9XA2W0NzbzyliDZ+HmFPjukKYwc/N2lTGqxw6
 +02MJqqydqeqSdyjLY78RM46IgHvgN279FfzXo+ZCxi++QN/hTB8X7qVbVdtt0oTtgAOJF
 y/qhx5E53RX2D58oWz/JqwEqbKp8uELZ81/HSC0Yol3jX7UKi0NJMp9PBbXGmZ/TPms4k8
 YTt+84Tz02zkFW7xAGoNsnJba4IFrS9YS3fse48lrywsnBNcfxkJAD8s4rHDvZe1zIxkHr
 jDsEd7i0l2m0HeLML2aazEsg0xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=fZWoVYtihMAGecRXeM0IB+dCNHoJM5vkDWNsfUy7TrE=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=JhS75eaJlLE5JGDhgo
 gF1WJNLoSAaIy2J5pveWfK3kcNMNUiiVmwBy4hAD8PlKn0gif6MuncBSKxblDgkYxgCQ==
Received: by mx2.catap.net (OpenSMTPD) id 7819ac2d;
 Tue, 27 Oct 2026 11:44:53 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 17787502;
 Tue, 27 Oct 2026 11:44:51 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v4 03/25] target/mips: drop hidden TLB shadowing for tlbwr
Date: Tue, 27 Oct 2026 11:41:27 +0100
Message-ID: <20261027104433.25720-4-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027104433.25720-1-kirill@korins.ky>
References: <20261027104433.25720-1-kirill@korins.ky>
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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


