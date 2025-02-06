Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFEFC0219C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgA6b-0005bF-VQ; Thu, 06 Feb 2025 17:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3uTOlZwgKCvg1zmftyxmlttlqj.htrvjrz-ij0jqstslsz.twl@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6X-0005Y9-CC
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:14 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3uTOlZwgKCvg1zmftyxmlttlqj.htrvjrz-ij0jqstslsz.twl@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6V-0001Ot-9C
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:13 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2fa11d8e448so3061778a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738879929; x=1739484729; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=nlfgOR1z8uq+0HViR5TzWLg5SXxGRIor87rX7YQ2VLo=;
 b=2cNo4dkuvb7eMo2TFvMI3fU6GcfJiMEa8mCT0LNfI+pcH2JATQFqZuQ06xeRJblfMU
 RXAeq7yuCTOsEomGLn6JAigGNCKPkICx4YFWYaWxBXGcb0HbiTZCJ7NOAUkm4zmF5N8M
 VmYEYjtEUadKkCJujPFn/h+rjyIH0mNIqSusLZwYA+OjFrOLwyHjZKt2EEh5pwAwvpI4
 aAd0Q9Nw2ITpkIOmTytrMdEeXuh+SxD6epXh138MrDYVbwZB4ifNTG6VnS5z9VxX82Uj
 nh5ndRlut9bDZKV5q7PkYkE8KNDK8GZFDuPnJ/8JJOlYmsoSJxsxxcvStE2T9+7DDxbu
 7sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738879929; x=1739484729;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nlfgOR1z8uq+0HViR5TzWLg5SXxGRIor87rX7YQ2VLo=;
 b=o/up03c0C8FBNu0nWXSj6I8wVyJBVuwHtgGfcdCN7sHlSC4yRl2yO3fqjh7Wm+5DTt
 EBgBWWz+NeQLGBvo3ey2rbJfFUoj7J5jjGR8OjJCd6Tbzyk1PESwqhVNK5bi+minCTYM
 bfN529TEf4G/sF+EiCQ4eb76Hj2XKNIJqquTwHVgdTRb6QRikb72lowJg2hGyds3WMuK
 w/ts6TibGhwKOKRCp7r9KqtV6IwOUAU6LwMvIGMNoMNymwKnQN/nRPOSfpSkl1ITBE3N
 AFe/ZYe1hW9NHozXBTVNTct0teMEM0wZc2opkZjCspIa5SlFFiqVPMmmXmxpHlgxbtum
 jsSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf73PA/TtNysygX8BttSlptXUIBrrOy9/T6ORtmiUcQbzg+86xhkcnopzK6OFjrs1xFhA+pM4LDY5m@nongnu.org
X-Gm-Message-State: AOJu0YxzFb+6b0UckQKOBIXdE4UnIQtSLLhoVKHDcdByd72v0SST5hJd
 rOfy+3gpKjrRyCTyIyLr0z+Z5p2qqtpH1eI4fsl5Y+vUGnDMIsuOPr9XZrYDnKXUUpWstCEkzZg
 Wr9rYvCC3ZQ==
X-Google-Smtp-Source: AGHT+IEIhppTIa9bYy21vgNJpwJRf+32i+DUTuHZQRrlJTInlB+TuMg+WeiqvSmSGhjfpNt3BciHi1X6leiZ2Q==
X-Received: from pfbbq21.prod.google.com ([2002:a05:6a00:e15:b0:730:4a8d:b530])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e1c:b0:725:973f:9d53 with SMTP id
 d2e1a72fcca58-7305d516b3bmr1312135b3a.15.1738879929126; 
 Thu, 06 Feb 2025 14:12:09 -0800 (PST)
Date: Thu,  6 Feb 2025 14:11:47 -0800
In-Reply-To: <20250206221203.4187217-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206221203.4187217-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206221203.4187217-2-wuhaotsh@google.com>
Subject: [PATCH v4 01/17] roms: Update vbootrom to 1287b6e
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3uTOlZwgKCvg1zmftyxmlttlqj.htrvjrz-ij0jqstslsz.twl@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This newer vbootrom supports NPCM8xx. Similar to the NPCM7XX one
it supports loading the UBoot from the SPI device and not more.

We updated the npcm7xx bootrom to be compiled from this version.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 pc-bios/npcm7xx_bootrom.bin | Bin 768 -> 768 bytes
 roms/vbootrom               |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/npcm7xx_bootrom.bin b/pc-bios/npcm7xx_bootrom.bin
index 38f89d1b97b0c2e133af2a9fbed0521be132065b..903f126636f9ef5d1100c056656ccfb2b32e5e10 100644
GIT binary patch
delta 90
zcmZo*Yhc^(l+nU*!D9x6DNkDr=09a-2ztoGz`#|*F#jn7L;r()|Np;c0m>C1$z?$0
Ywog`Ma%Vh0Ig_b-VgU<}A_D>d06Rh+WdHyG

delta 69
zcmZo*Yhc^(lu^NO!D9x2$xoRb7CdZGnE#ZCA@Cs+0|QqL!~CZV4E+!GPG)41X52Pe
SmdTy*+~icIZXQJj1ONb5*AzJb

diff --git a/roms/vbootrom b/roms/vbootrom
index 0c37a43527..1287b6e42e 160000
--- a/roms/vbootrom
+++ b/roms/vbootrom
@@ -1 +1 @@
-Subproject commit 0c37a43527f0ee2b9584e7fb2fdc805e902635ac
+Subproject commit 1287b6e42e839ba2ab0f06268c5b53ae60df3537
-- 
2.48.1.502.g6dc24dfdaf-goog


