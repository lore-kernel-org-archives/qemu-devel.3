Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9EFC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYW7h-0003TP-KT; Fri, 09 Feb 2024 14:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYW7g-0003Ss-I3
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:01:16 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYW7e-0003CY-Uo
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:01:16 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41047386d18so10927175e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707505273; x=1708110073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gHzvEeOz77T7oAbrgDJ/PTgWR9TkPSHHAdSLszapdfk=;
 b=Rk01EMPbNO8ZaA8Xb6pMknjqOBcf5vp838fcHVmxFlATT0c9xRVpH7V/l+xPEbvODS
 YMz6/qK00/MfvUGSDfVVusPx97FOc3BzMdYC2M0gG2dkjjqFx7YK6KjSaHZkHvfF5jGs
 nPaTPWaFjfzB8auiysDwt3fQ6xN/MvBYGBObf+PjvcGfnDiMSPJ0L9OFiisTheOisWw8
 tqe7FBUr7mAjYOrS9jlxAOa0K6A+DJEwjpDw7hpUwak2d+zwFeg5J+YHD4KeNfM4z8Kb
 UgMo/eQEEnbOh1HOU1KcJinEe00jSgNPXjIj6MpNpyR8XLww6bKynM19SpLyk9ptUtsj
 wTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707505273; x=1708110073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHzvEeOz77T7oAbrgDJ/PTgWR9TkPSHHAdSLszapdfk=;
 b=E8oG0/+GvZG2hrpCVOOjJNjeVywfdu+ukxl6Si2JHmFmwyFBFhoXyI49aysRuhkluf
 sMyXE5sUl6wZdFQNnaGrSiCkC1qa37kBFBrsl9MaYg3s3A66ywxE0g1b4XIj1xATCoa4
 2Fq2Ta6EyPAj74xEWpD1gdn919im/PEiD3pt7o8ND5pTwRHjS8giQdt59myzRjTyb8r/
 T7b9H7f+myRWpnqPFGSlB9mH2EcdBco+obU9lkKb/KIj68AMVMRHlflArgK1th8UHBGc
 NBPDhziZJDoMd2B/TTMEk9nOTUyR9xlzs757gO6k5EiOieFjKeTAyaWrrqgDcMmT2nXj
 TJuQ==
X-Gm-Message-State: AOJu0Yw5Ea8NdxTmcfp8iwUiNaP6G2QSgmRS8ntNHg6W82O2IWnWfy8S
 WUg8mo48PMyZxNMLzKluHagOCk4ibtVuCZrBSgHpXX80XbbbUsuw1oPf2WOb/NZPO1EJnib03mi
 z
X-Google-Smtp-Source: AGHT+IHC2lYKOY18HwyWko8jQWTIm0u/AakVdwNS/QcDrg+TtLo+JMAfhFIIbVnpJJLjxP9ccTzhnQ==
X-Received: by 2002:a05:600c:5123:b0:410:27e7:4c5 with SMTP id
 o35-20020a05600c512300b0041027e704c5mr185869wms.29.1707505272988; 
 Fri, 09 Feb 2024 11:01:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXm25cy0TzcFOxFbgUXNyIgj196W3OVUSiNWYooHT9UeUSYsh0TGJiKkA/D8U8toVhKnjjMDp5lfgE9Un8ANsVMauxEHJrLYYE92cdI/toQ9htb1udQy5k+Gw2QssQ/BQdKzAYQTUu4Mp9eo6yS7DPuD18y6wlzp/zlM+5kv9slrEVyoe2auNzf0UpV9BgBfpvetUafz/Zxmhv3MI1WZWCyHCZVTI5WN+g8ZxPCd/Th1WaUJhk2eDfRHQ9Ec+5B
Received: from m1x-phil.lan ([176.176.147.207])
 by smtp.gmail.com with ESMTPSA id
 n33-20020a05600c502100b004101bdae3a0sm1485711wmr.38.2024.02.09.11.01.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 11:01:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/i386/kvm/ioapic: Replace magic '24' value by proper
 definition
Date: Fri,  9 Feb 2024 20:01:09 +0100
Message-ID: <20240209190110.27413-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Replace '24' -> KVM_IOAPIC_NUM_PINS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/kvm/ioapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 409d0c8c76..b96fe84eed 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -35,7 +35,7 @@ void kvm_pc_setup_irq_routing(bool pci_enabled)
         kvm_irqchip_add_irq_route(s, i, KVM_IRQCHIP_PIC_SLAVE, i - 8);
     }
     if (pci_enabled) {
-        for (i = 0; i < 24; ++i) {
+        for (i = 0; i < KVM_IOAPIC_NUM_PINS; ++i) {
             if (i == 0) {
                 kvm_irqchip_add_irq_route(s, i, KVM_IRQCHIP_IOAPIC, 2);
             } else if (i != 2) {
-- 
2.41.0


