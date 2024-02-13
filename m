Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D6AC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 08:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZnuc-0000w2-7q; Tue, 13 Feb 2024 03:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnuZ-0000uY-TL
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:13:03 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnuT-0000v2-TH
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:13:03 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4114e0a2936so10243985e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 00:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707811976; x=1708416776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9Mll3b0jD3+V1gEhLcEmdspqDBWW+gx7Ndf0tUMfZI=;
 b=ODlbnsDDlVkFrkvHkY1s/g+SmSP+mcpGx4jycFSii2JeolMY9XEOHpRUAH+o7x064s
 3lmHjeL6snn149zESBGifQEsXvI/+FnpQNY2q6H0ulqeXm7MvYZRVcNvQ3/tlnmEyMz9
 PCSQb1wEBQH9nnT47RntBV6/x0vmSfkqK/fSg4BzuQskw3iSoQ25dFyFbNvuc69ETd5S
 ybe/OcKaaylqiGp1S0pFLRqjtTyblcp+CFoK5JlaQ5OMWysB0WmL61eZ/W6qrburGkB2
 uYvmA6ACb/7xUQX+VtlALRuVd7Kno5BUBl0BDPBND87lcBHwcAYv40yECQNhiLFT2Szq
 P9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707811976; x=1708416776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o9Mll3b0jD3+V1gEhLcEmdspqDBWW+gx7Ndf0tUMfZI=;
 b=TmcxRSsGD/vEbJydXO3I2izYodCFOahmn6xAItWpvIIaNgvYPJap8cBTNlQuZksJfT
 dzX30UybaIRlrHl3CitQZoCmCxPQPq8hWiVOKhFA8lJNag9JZCt/S3C7SMOcgXs7vsiV
 tEaMGyWNNkPmDpS9IIlM1qiuKSMqanPv3iLsYlUjirdC8NwHtbnclZS0KNb13RTXrDTJ
 HGa9pW37qIMyTWSV2E4Q94hnAFUzYy6nOcm5f1EDWSX1b1T3YKnoUiHJD8wNDbnRC67T
 djWP3zmyAvpnq/11JPYJbb8smn/qtQJtzI8lRwCyy92Da2B72dznY5oy0ecfxT9PCuDq
 bCeQ==
X-Gm-Message-State: AOJu0Yw0nt9Ryyq0VNL7/ikJwCRP/sBpeMd3Ox2leyrGlInxUu+d1hM1
 73axlXgGIuvjsJm4HJK18N4HBByrzapmDyiD24M5fVpReH7aTacztuAH8VVeZRG2RoBMVfQcQGd
 n
X-Google-Smtp-Source: AGHT+IH/pbZ6t9xitqbhnzmLj0xdxZdob8vyzEWpC9pOBffHWOEIpyrCbU2qfu7MmYxqKZFOoCdpiQ==
X-Received: by 2002:a05:600c:5487:b0:410:cc53:a358 with SMTP id
 iv7-20020a05600c548700b00410cc53a358mr5102258wmb.16.1707811976001; 
 Tue, 13 Feb 2024 00:12:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXaF3ktzSm9VNZed+L5sZ6c4prONn+fJw8l4SkEvOb17m90mnfPe+5XmmsYDYWotcewD9rRFWM9+Pmu6eLkzU0kthbmP9mpXvR0+6s8pQHcjfBzs7G4mcNatOq6EH8rTS720Ej7dwRhn3/St9xHVHpvn7McPF9FhDuilFvSWsP7r+5HqXyZ+MUJMHAriJuJHyA97L5oyyBCXlPdm2WiR1/HVGiXPY8vseL4TPb+JWCeEmGH+OyHwRn3bIbDIeRnrk4njCOC59dDzukORHPyHC3G9w3BiRM=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a5d65c1000000b0033afb963d0dsm8828239wrw.101.2024.02.13.00.12.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 00:12:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/9] hw/ide/ahci: Remove SysbusAHCIState::num_ports field
Date: Tue, 13 Feb 2024 09:11:59 +0100
Message-ID: <20240213081201.78951-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213081201.78951-1-philmd@linaro.org>
References: <20240213081201.78951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

No need to duplicate AHCIState::ports, directly access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ide/ahci.h | 1 -
 hw/ide/ahci.c         | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index 604d3a0994..c0b10c2bb4 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -63,7 +63,6 @@ struct SysbusAHCIState {
     /*< public >*/
 
     AHCIState ahci;
-    uint32_t num_ports;
 };
 
 #define TYPE_ALLWINNER_AHCI "allwinner-ahci"
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 33f7e83687..041cc87c11 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1862,12 +1862,11 @@ static void sysbus_ahci_realize(DeviceState *dev, Error **errp)
 {
     SysbusAHCIState *s = SYSBUS_AHCI(dev);
 
-    s->ahci.ports = s->num_ports;
     ahci_realize(&s->ahci, dev, &address_space_memory);
 }
 
 static Property sysbus_ahci_properties[] = {
-    DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, num_ports, 1),
+    DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, ahci.ports, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


