Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C815C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26CC-0002oE-Gz; Thu, 03 Sep 2026 08:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26C9-0002jf-Sq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:30 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26C7-0005JF-8o
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=bzX8ugD
 Il06QJ3jJHD74t6ibT6l0ECqHIaSfvSapBz9U/tjwRBQtbbWFTbtLLeYpd39RB7E0Ak2As
 pF2h4V4ipQ45Lzoe0oEg5cir+XGAnFOsRdYpQnspXlpwj6YfI8HCxVMoctxWcSIzJbWIFk
 UirsY64C7P3NKxj1vAkfM7VAjbMcQkhoyImu5BYreeu/cB1+mZxeAaKqEBpuHPwcfQxf+n
 gyeJ0p8Kjgz0B9v4BLSmMa6l3xjz/WDrcFxzKF+lsyfs60UJpRbQd1XyTZrK8qMAm2HEsy
 uZqWZQV/6I6atVlHgbgg8loE7cZpRyN63LxPRuvFj5N/Rrdn+GCplyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=n
 sknwmCpJ8wp9wFHy/xw1JvJkqzwM23UicaxYjyzWvk=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Fy4NkCO3KJH0UURvyF4c2amEoLevH8VF80IVb6Y+yFSH9Cgl8WW367edOtpAtjyschcv
 yagiAI55KVVuKbeB7IPTybvGLGE0YxSzv0HT7FseCqkpjdlg4+mnIINcsAJ+H5+bZsY/C9
 NS851WDh8GPRQ5pGhYvZxYXpyzZS/qXlkwPBvMs/q7GEw0Z7vMGIvgeNGEUHcByCm1m0tY
 PXPJzA5hJ2FnF5pW5+SqLeKctOQ5tGybXs6KDj4AVrzJU/3cXc+Osr8+51LIvJgRJnWllU
 A4o6kob86w7vspqZf0J5qmmvUBEO0ccU7WTuiDSaBxmr/89kCZays4SboFNbDI3w==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=sUKkD7xQ; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=+Ui+Hb/V;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=nsknwmCp
 J8wp9wFHy/xw1JvJkqzwM23UicaxYjyzWvk=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=sUKkD7xQOnIWqQDCOixPuHWjFJlQ9aSJc5t
 dlV1NzI1A+MOh7o2Pe6Tac6QwGZ7DLbvBOTsZi+CEnZn4q1bBRk4RDw1NI9cRUF/kq8wAC
 iqehh/3sPUzNZvvyJUB7i97INA46zaG57BuHkk9G6gOQNvlP64shRLTNRyltschCiPCJdi
 h1ADtEYwUrmsjYkdnG2q1inSco1g68xz/tcqlKrrHYyoTYQbfDsZ3v7HbjuJFsXsjRpr26
 ylDj6sAC5usnwxrH0KFFUjNaFm/91P3uBbEDZcER9rfOWp9IqKiGvia7Ft3+W5SvEOgeU2
 ZQJUC4Z1CvmbD8tJBLjOnHAc34w==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=nsknwmCpJ8wp9wFHy/xw1JvJkqzwM23UicaxYjyzWvk=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=+Ui+Hb/VRgvUvhjS+8
 ZO60nt2TMNHufp0M+LBUOrTIS5lqRigMMOX5hpQAhNRXTrRAyC2uox7URLgU3005MoCg==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 03ea62da
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 14:05:21 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 4630338c;
 Thu, 3 Sep 2026 14:05:15 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 03/25] target/mips: drop hidden TLB shadowing for tlbwr
Date: Thu,  3 Sep 2026 14:01:51 +0200
Message-ID: <20260903120510.34876-4-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903120510.34876-1-kirill@korins.ky>
References: <20260903120510.34876-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
index 9772df5d6c..4c0a25e622 100644
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
2.55.0


