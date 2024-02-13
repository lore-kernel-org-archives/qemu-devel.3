Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBC9C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 08:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZnto-0000QJ-MU; Tue, 13 Feb 2024 03:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZntn-0000Pc-3O
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:15 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZntk-0000ij-O6
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:14 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-411c863c1c6so659165e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 00:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707811931; x=1708416731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24s0na+x6T/s2HoEAp3AWZgaRuEgOsYG8hssre/glwc=;
 b=Q/u3Zh66GkrQFROPvonglXEhBYDpcWS0IvRW+qbtXdAPCwuSIkPn5WZto8DHo5AYV9
 Dr00HH0zHcKp0k600R4w6GHF6z9oDcgU3mlzsh5fOGmdt+GV0esqQIfHYV1pYQsr2nfk
 kbrmaUrXiltKxbTHjwYwLC60UD10C6t34m1g97nBwtnGbD6EuI7iwzBRhvKzARa4MHYJ
 k5RIU7/5YugBxrgJSZzS1iZkocEzuAYXtvcEU0fR2jXHG0+gZEgjo1RUYKd/SqsmDBgn
 ywN/X/NQKXVqaPMcGwyNbwdxFoCTBCwXMdeusv9IMhnDNBqx4uH78aduxCfDsFrO62Hd
 L26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707811931; x=1708416731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24s0na+x6T/s2HoEAp3AWZgaRuEgOsYG8hssre/glwc=;
 b=wBZMhLwrdue+ZT2SxxkhGf/TRGaWnN1gC9+4lXq1cxUT56GEz0hSXY+fOPNRjpQMEA
 TSejgldJx3ViJEsva+XqswPYl/kKCmJOImhDjCvYQjzQk0gN93pJo6TK7tq46PydAMlM
 xMqcMbs+iC4s5lfafQY6uhzPYCyl0F5D+DfneQg6QrSacITc8m6N1/7NFuCh9WsTjCoV
 +H2sfg05W8fNcD9UzoDTFBsUFW+5BaqfsB1hly3KSv4se5GTX7NwsGRDQlJssi0xMZYe
 O6Pa0c+yzVt1VcYGFqxBeW2XQqad7dmsZsKvJabWGQQNA9l2ATB2ZUmFWXtD9McoxqWl
 oxVg==
X-Gm-Message-State: AOJu0YxTkxVhYCrGqzImeOP42JjgG7FwVgBd+5yxR/mzgtyQRnAKZgAg
 S12c01e+AnHH+ZDl7uiYr0sBKJ9zosDy2xSRMbRZMdzXQ0ndpUHnDGYzAbi5j6fypNl0OqFH3oZ
 p
X-Google-Smtp-Source: AGHT+IEYzWg6goeMSFg3G4W+8HP25eFJpy6VVrt+3OqREf188gRN28/pSbTclfmjQ2DM2P78yq1yog==
X-Received: by 2002:a05:600c:5204:b0:410:6d23:dd6e with SMTP id
 fb4-20020a05600c520400b004106d23dd6emr7631551wmb.13.1707811931188; 
 Tue, 13 Feb 2024 00:12:11 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVZr/ZZeRsWJDXNqVUnG1h8mN8q7pav7jiHUq5Sbzq6SN7ZE6G5TekGAv4tT8asPRzo6QMZkXT1B+5Yg+UDWov94084c8aEZCDqqR67jWd3trdEhurssUi+a4RIDfyr8UpSzffOh35dPcDEk7DoEXTPYxtorIDqWvQPmqALWIgAW8aV4DyqUk9MijO6iMGX6huWbQC4tq7LaGDEdId1Vi5FkdVagchaOiPiDV4BW7SIpo1QQVj2gUS5+afBkiWmyCNsJinyQwvZiwHAaxcXimVavj3ApMg=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 fc9-20020a05600c524900b00410727c315fsm10857739wmb.16.2024.02.13.00.12.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 00:12:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/9] hw/i386/q35: Use DEVICE() cast macro with PCIDevice object
Date: Tue, 13 Feb 2024 09:11:52 +0100
Message-ID: <20240213081201.78951-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213081201.78951-1-philmd@linaro.org>
References: <20240213081201.78951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

QDev API provides the DEVICE() macro to access the
'qdev' parent field of the PCIDevice structure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_q35.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 7ca3f465e0..33a4413708 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -309,8 +309,8 @@ static void pc_q35_init(MachineState *machine)
                                                PCI_DEVFN(ICH9_SATA1_DEV,
                                                          ICH9_SATA1_FUNC),
                                                "ich9-ahci");
-        idebus[0] = qdev_get_child_bus(&ahci->qdev, "ide.0");
-        idebus[1] = qdev_get_child_bus(&ahci->qdev, "ide.1");
+        idebus[0] = qdev_get_child_bus(DEVICE(ahci), "ide.0");
+        idebus[1] = qdev_get_child_bus(DEVICE(ahci), "ide.1");
         g_assert(MAX_SATA_PORTS == ahci_get_num_ports(ahci));
         ide_drive_get(hd, ahci_get_num_ports(ahci));
         ahci_ide_create_devs(ahci, hd);
-- 
2.41.0


