Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E14C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txCzj-0000jP-OP; Tue, 25 Mar 2025 18:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txCzd-0000dI-7B
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:33 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txCza-0006vs-Gx
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:32 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso43327525e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942609; x=1743547409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIsbtSKYbmjuBlwlygMfh2FAmt4wKaqUSYQkYlcHhAY=;
 b=PQz9VHJQnv9EXVpieVpBpnyn5UKBTIaPufX3fyeO59/MWAgy4A9XjovQ7B2DZUZ2iC
 vEo0UV0XSBw6byBP+i1f8hE1+1Lbkbddv7LR6/hzkmqSkThlS04Td+42StZdNKNrQXkp
 GnHBpAFODeO69ur8c1CrSI58A150/Bux2K3bDLWHgY/R0OdXGZ3SoVbTGt59uPt8mOE2
 NOXx1E7/JZOts4qURzLobXDohK+8eKDDMFAQ34sD/mW+tXGm2HJb/CYs6oNwUpb7EKqj
 O3YdWmgM6qE5CerXhH9F+PQADUg3vasw5Io0rttNurzCdRcYbFDUYcZ93vBMefSTxXVS
 MdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942609; x=1743547409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uIsbtSKYbmjuBlwlygMfh2FAmt4wKaqUSYQkYlcHhAY=;
 b=FHAPDmUMKLx1lKcuCQqoCRvDAQuEk21iTGvUCU/hZ7jT4hM7w9AYM4nO7sfzlGErFE
 t2zCglc5mVBkvXr0Q+41jB188U2PAhd3n0U2x4KvvUYGJ/AFDkL5indLQlJHsLh28Y62
 9zHedPCHnTPL49soLzWOxYRi5ksbmwrGdWqnVEGRpGm59J5HIbWMvngWcEv9OdZHi2O7
 fmx+5OoV0GzOX8dPnn468aq91zNJpmtVaSwsEgJ7O2ZFctXw4Hicp2LSZKdTEpn6YBiJ
 SP9a6NolyQ5vpygN11BK3ycpw1dLhxdpB26Anqapv+mB/mZgs8mDrSxeNvLikE7ZybIG
 nrHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8i/I52qLlUkSv7kWsTPq0R3BBootP7aSx1DhoTO+XvKupaKz0O2mA3y0jbtGPlgIcx9ZaK/7AdsjE@nongnu.org
X-Gm-Message-State: AOJu0YyLi3A4ggd3G68jw3UHAJGMPJLDt+3VsWR2M5y80lMkRV2KgyPj
 wFHvv90JjSdnyFQJsWI8tEDVOFCpAi/frMptFvNaZxgOuWOGoZ2dnlHjso7dQhg=
X-Gm-Gg: ASbGnct+TRFrFiZ5r7ER+KCCEh801fmZPZxYiEQ+PwQx6qVrO0DPkBmcgiKLoXKoijc
 /qirxXSL/KI9/oDpeDYSvcBk2GGPmi+y5yL7d5e6Z4/kEqwS6JFh9OftRw+N9bIK3s71UBcVzo/
 GBy5h0/LrQWZRiKEDyQzCTXIJnGAe/Bt2+LFJ1nWP887obV7HodBvT7mN7v5MLvQjHzr5cc1ou3
 PuccyKRkXciokgLHvpokhqUKDgkKxdC85zDBeyQLHMHsF5674a09rLZaz9ESl91Qyx3Qk4ojCkO
 i89djEEz5VlS4wav90Bbfiz1yeOxxmterEv+oQiNcl7+Qjix36It2eguoVXOwh1URgDXiFt6a06
 /ESLdngwXxtq856JLYIg=
X-Google-Smtp-Source: AGHT+IEikcytfaNnArbXeF3qffbmnL+GFR4CLgt3WXT0mak2c6j/QH6STzKh/q5GWmP4LsWfw2zlRg==
X-Received: by 2002:a05:600c:34cc:b0:43c:efed:732c with SMTP id
 5b1f17b1804b1-43d50a3c1d4mr162965315e9.28.1742942609083; 
 Tue, 25 Mar 2025 15:43:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b517csm15243394f8f.51.2025.03.25.15.43.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 15:43:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 03/12] hw/display/dm163: Add description
Date: Tue, 25 Mar 2025 23:43:01 +0100
Message-ID: <20250325224310.8785-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325224310.8785-1-philmd@linaro.org>
References: <20250325224310.8785-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/dm163.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/dm163.c b/hw/display/dm163.c
index 75a91f62bd3..f6f0ec0c632 100644
--- a/hw/display/dm163.c
+++ b/hw/display/dm163.c
@@ -330,7 +330,7 @@ static void dm163_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    dc->desc = "DM163";
+    dc->desc = "DM163 8x3-channel constant current LED driver";
     dc->vmsd = &vmstate_dm163;
     dc->realize = dm163_realize;
     rc->phases.hold = dm163_reset_hold;
-- 
2.47.1


