Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82156C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 18:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkp5j-0002yY-2d; Wed, 19 Feb 2025 13:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ASe2ZwgKCmwgeRKYdcRQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--wuhaotsh.bounces.google.com>)
 id 1tkp5b-0002wS-6S
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:35 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ASe2ZwgKCmwgeRKYdcRQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--wuhaotsh.bounces.google.com>)
 id 1tkp5Y-0004gb-1M
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:30 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2fc1cb0c2cbso341475a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 10:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739990785; x=1740595585; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=eJvoLmKWZueB4x2SO77z/CNBY4DFZv1QeYJU8Aspc4Q=;
 b=FO6g1fWUEWzw4MxizkL5PbRKoDkxwz5pv5/jj3rzqElxak8XfrNK9e2kZZX97tf7OY
 tRZup9XiWTkD/U0amDVk4avtU7vkuQlZmqvSVXeSO/foCOdq8YkQ2m3UUczMozK2Uf6V
 lQDRiI41bUby5vfDv+bj6xRklrVbRdCAOqpinI9KQBE8Mkr+E/3A+DClZub/yKtf3Hf9
 A3xAuvS/gMgliWBoKnPytft6hiFGFgXSP9Vy4sy2Nkali7zFRx7hjXEq/qIQORxlfNfu
 4tuRqItndVPn0+R+SaABJszHOYiqQgc/Tf1trAPA//gaQk5VY6NzddOlycjiMlogt4qr
 arvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739990785; x=1740595585;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eJvoLmKWZueB4x2SO77z/CNBY4DFZv1QeYJU8Aspc4Q=;
 b=GK9cTu4JP9Q+nt5kzSqec0zIMstB1ntPk6QhElm5QalJasl5G1PLeOrMgs73yxb4kX
 n02dBnBts8Js4LMFHIefDYAR77KwKJcPn8wCj/pOn0PFrEIAGHNQM69ZlvX7s7yLlD7l
 wI22sfw2tBX73B4z4cfEt858H7JEzcxQN5oK3HGmOuha+d0QsXMycJoiKU2aYCoaNh3R
 etAs1BSwGjAZbokz71vdmhvaJnkJCDfVQGDGqZSd+tqV8WnTQjhnJal1qWNe7beXF84y
 EBAUfykQ5clEnxGQzexJa/mzibk+SJ1zzmx9uDWK+r68gdfwWd4ExfkgQyzRly+puXfB
 jreg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiZlSmiYPZlWATCtaPQGlBG+edGi4rg+iXy1IvMAe1KWQHsdtJWMt7mH8zoDlzOpFiHsMmQeQ3HQzw@nongnu.org
X-Gm-Message-State: AOJu0YyluratV5VYzT76dlKQyh35uWjnj2qpPxEFgS3ZkhpnNgppbUQ+
 zTJoDcH/5HSBAHYzHYB/yvN9fQb60i1If713/alf4QGW+A8xdNsy2JrV8hlApRhEO0uamVptUOe
 KpfbbgE0UjA==
X-Google-Smtp-Source: AGHT+IGJ93tXDtILFIyLaWIaYFyxI6FE2U3H2VoMhenks3haRITiWKC69yP8nc/rZkLal77/94Zh5i7mmz0kRA==
X-Received: from pjbsm8.prod.google.com ([2002:a17:90b:2e48:b0:2fb:fa85:1678])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1e08:b0:2fa:1851:a023 with SMTP id
 98e67ed59e1d1-2fc41150587mr28814437a91.35.1739990785451; 
 Wed, 19 Feb 2025 10:46:25 -0800 (PST)
Date: Wed, 19 Feb 2025 10:45:52 -0800
In-Reply-To: <20250219184609.1839281-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250219184609.1839281-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219184609.1839281-2-wuhaotsh@google.com>
Subject: [PATCH v5 01/17] roms: Update vbootrom to 1287b6e
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3ASe2ZwgKCmwgeRKYdcRQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
2.48.1.601.g30ceb7b040-goog


