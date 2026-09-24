Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCF2C9830D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 02:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Z4g-00022h-7J; Wed, 23 Sep 2026 22:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Z4Y-00022A-Fm
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 22:20:30 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Z4X-0003S7-3w
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 22:20:30 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 00721157ae682-89666eea29cso18835547b3.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 19:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790216428; x=1790821228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AW1GkBPywgZoEStu2MNuXL0xW0ldvsctKuy25GvzewU=;
 b=Sb5VW8Osy9ENe60wB7WR9CQmWX/fJ65gmTi6GMfJIE1z1bQrTkJZkS22yzABWjfp0/
 A6vPNEZor25spxopINTAGVOxMVYUP9Wqg3SUa8gimnUSMcCIi1hjY0144njsYyMaWHcP
 IWRAybu9wM9ZvfvN/tEoXkKuhGGYKk51qkP10MKP56xCX9GNrtSjjEhrXMpUCwVbKoK0
 MMQE0E8yhOmBEp+EEY8v0Xoffcypt4c0Z9QvQezDwuMlbUg1h7anekp1jcBd+HN77vSe
 hErf39DEhNgqf7yj6qq88qIkovwiUD6rGtk4wjRHvZw2PmnmHq0Z4FbtoEkYTHPNWWvW
 +lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790216428; x=1790821228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AW1GkBPywgZoEStu2MNuXL0xW0ldvsctKuy25GvzewU=;
 b=m4gJOWPPy3jjeGCYdxu0CAITLiDKmGYcVUtsjMMVQ0p90sf/lDlKDSjFXUJsDr1s5p
 AZB6NuPfNy4g5/RARtGPA9x8fLy4/aR4OrzJr/3KXC0nyhaPOCIITq8K3I1FjhmW691m
 W1iuQBd//Jak25caxtTBOEyQ2EqLL8FHwaD+ZTBvvkk3egm359qzIP4y6DlxaNmN9AHl
 oPMBgOhgDyqHn2umg3gwjuuhjcaAemr/6SZiaq0J97m8osKkFyHAKsXNqWZIjSS9qilk
 ATwMg1Jf/fJ9oJMc4LqqAu5KHyxCgqZ+QcmQw23oXhcdyj1ufiVPOkfVymvG19T11as8
 gGyA==
X-Gm-Message-State: AFuF++nHaR9ME1JYykt7ZotxVpoTka1XCLMsZ6I8qZkW72U8TRtgmOqe
 fThHX5/exO1IM3qUwh04GuO6ATEHmSVzpwJkUXfdYjRhM5ECDqhmy2ihQ/4TPA==
X-Gm-Gg: AYBFou0seMl/4JpMB6oVbEvVGm/hl3BEeqY+RCF6PqPgKDreRBGMRjka3IUM0TuZ8Bj
 PC0IEBYQQMnWAAKPwKkUuX856mBecC2dNcDZ8ld+3TIjMWaQZ9QWvmiwqvPVVDXRQRn3dGjn3yN
 wC7tYzG5LypcyzFtuk7vTy/kNyBbFsvF8dhSjfaRIs+BdeuVSDdnROfRATOBpupV2j9+ePJXnwU
 BBG773EOa6MLLYd+Pvy8KeeCCp+nnUkRH9sYrAOE6qalG7nkbK6RJLGGoZFxUZW109bs0xgLps9
 DCQ8zyACiAVNBjXJvDcdH0iIuh+ko6nqQ63QCPm2hvM2/jNZYbE/2Xbnd7ag5YJOYV7S98k9UZV
 behDObKqk9J1qw34qXmahaR8GmZeRMKooJnJOQ2fLNKzicfWFNDTudXDUI/7rKMW0AG0iuLYmST
 25l5K0xMXCMpFtsirTHlAWJLwyO7NngaIivFMALjoVQtrz6uUmfuFPvLtNqysqu770udQKgVNOz
 l72CPoPIw==
X-Received: by 2002:a05:690c:c513:b0:8a4:cc7b:fdb with SMTP id
 00721157ae682-8a64e5bf0b9mr5014177b3.37.1790216427864; 
 Wed, 23 Sep 2026 19:20:27 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a6520d6225sm3420017b3.22.2026.09.23.19.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 19:20:27 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH qemu-palcode 2/3] console-low: Fix $8/$19 stack slot collision
 in entInt
Date: Wed, 23 Sep 2026 22:20:21 -0400
Message-ID: <20260924022022.2414514-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260924022022.2414514-1-mattst88@gmail.com>
References: <20260924022022.2414514-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=mattst88@gmail.com; helo=mail-yx2-x0e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

$8 and $19 were both stored to 9*8($sp), so $19 overwrote $8's saved
value and the interrupted context got $19's value back in $8.

Store $8 at 8*8($sp) instead, matching its .cfi_rel_offset.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 console-low.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/console-low.S b/console-low.S
index 1f61cbc..83adb2a 100644
--- a/console-low.S
+++ b/console-low.S
@@ -46,7 +46,7 @@ entInt:
 	stq	$5, 5*8($sp)
 	stq	$6, 6*8($sp)
 	stq	$7, 7*8($sp)
-	stq	$8, 9*8($sp)
+	stq	$8, 8*8($sp)
 	stq	$19, 9*8($sp)
 	stq	$20, 10*8($sp)
 	stq	$21, 11*8($sp)
@@ -87,7 +87,7 @@ entInt:
 	ldq	$5, 5*8($sp)
 	ldq	$6, 6*8($sp)
 	ldq	$7, 7*8($sp)
-	ldq	$8, 9*8($sp)
+	ldq	$8, 8*8($sp)
 	ldq	$19, 9*8($sp)
 	ldq	$20, 10*8($sp)
 	ldq	$21, 11*8($sp)
-- 
2.54.0


