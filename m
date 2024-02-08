Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7E9C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8tT-0004BT-Bw; Thu, 08 Feb 2024 13:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8tQ-00048N-4S
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:00 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8tN-0006kC-SB
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:12:59 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a389ea940f1so6536866b.3
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707415975; x=1708020775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w2MStSDCsStbLku+FFcB1QAt3hfE/6paGjBeMPhTa10=;
 b=gSyxdpNCl6XxdHLBYe6vCnGNmaBeQvS82kA8/OZskTbdeDm66Ogr7a4L8pjfjHq2oA
 nZlQoVkxQdlzsXiI+II0oMkVX5AZnQ2+0+NK+jYFyvH6r21XTQq6EABJwmy+W+kTYSvx
 oarYVpsX2lkN4e54oo1VEsUAD4kXO7wpVI8ege56EZdP3o7u+1qR/HX64VDkHfH1XUSb
 Fa/WMHW7xSIXyC8fJN4tJaFChJ+z9VHoLZItQbe8afOMcNnv70I8k6sJd1AKl7bs48id
 IsXH7yZ9geTW3yTToavejmm4oz42AQGKSBM+AFZz8SRKd9+MvtBENQXzpHuTMcXber5O
 otyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707415975; x=1708020775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w2MStSDCsStbLku+FFcB1QAt3hfE/6paGjBeMPhTa10=;
 b=IXZx7+4728IQB3iE8iS2woUy0eG5OTuLj/13q19P8cqLSLviAdXK9eHjs+lmVQ7LFz
 dHfqdgEICT+8kyC1nXOZLAY9Q0Y98K03aDqOVxWl1Xe5xN7kqtnOTm7XhQ5exAoT7nDM
 18Qk+vIa4PwxfUPODZHzE4MEJOASMRnTa7jJ/8ArsHnF/NGGHO7iSgdJ7iD8hnRdc5xc
 jjrF1pCf81lOHfO/l/tHxoA93HZA8SA0hDAbnrlee9YhMWTNUJTWiXaJ1MtoDLV4Rrzp
 J4ZqpBZdS2bxP5iGNPF52VJ31OiP+467Gt/y5UZZByN89Jby304qDxNl3mQvSuUMKpDS
 Phuw==
X-Gm-Message-State: AOJu0Ywz3//og4+llBF9s2xM9vaU4Xl6FdElhx1TJkf7AhAbIFMi8k7p
 2r1XlILIclzacxVth/LBWTprPvzof3EKrYG4DVE68v0XuYeNups6Cdpb4nbEgrGbtUG15a7YVNE
 4Tsc=
X-Google-Smtp-Source: AGHT+IF4ZecCBlEKXGS2hW50rfn6SQDa007xmFWZa6LsRoOF2z1iEDxh8JK+DY6EF1ErEaNcOkktRA==
X-Received: by 2002:a17:906:b2d3:b0:a36:2df:5ded with SMTP id
 cf19-20020a170906b2d300b00a3602df5dedmr77560ejb.72.1707415974678; 
 Thu, 08 Feb 2024 10:12:54 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWvDhQpyJ+AI4o6GqNvSoUYNSlJubsBOjQg+Xc46YBKGB6fb5A4QPhJA8Qpq4ro7FWE+jJBo/TTBzS9jO0TY2uJVyx1y5bsi2oFIDF2dthoOQz7rFEY431l2Xx0kxYYWG/fMsd5kF+H0LpsPsd3FCMNkxgWpZUJqc0XChqwItk3ZKEJ4SJYuYMymuSs6V23wgts+eXBsxrhZXqysDE1NT1zUc9Foat5uXaQ1Ib0Xc2YGo+eeCEWiEeoIpYs8ETmK5fyvtV85ae6LE7IwbSBTH6vRE4NlFuP0IoJt7lgKZhBgs56J2HgI6XaHLiC6hh7bHiH4JjqyQ==
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a17090629cb00b00a3af8158bd7sm297255eje.67.2024.02.08.10.12.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Feb 2024 10:12:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/11] hw/ide/ich9: Use AHCIPCIState typedef
Date: Thu,  8 Feb 2024 19:12:34 +0100
Message-ID: <20240208181245.96617-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240208181245.96617-1-philmd@linaro.org>
References: <20240208181245.96617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

QEMU coding style recommend using structure typedefs:
https://www.qemu.org/docs/master/devel/style.html#typedefs

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ich.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 49f8eb8a7d..048ea7e509 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -99,14 +99,14 @@ static void pci_ich9_reset(DeviceState *dev)
 
 static void pci_ich9_ahci_init(Object *obj)
 {
-    struct AHCIPCIState *d = ICH9_AHCI(obj);
+    AHCIPCIState *d = ICH9_AHCI(obj);
 
     ahci_init(&d->ahci, DEVICE(obj));
 }
 
 static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
 {
-    struct AHCIPCIState *d;
+    AHCIPCIState *d;
     int sata_cap_offset;
     uint8_t *sata_cap;
     d = ICH9_AHCI(dev);
@@ -154,7 +154,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
 
 static void pci_ich9_uninit(PCIDevice *dev)
 {
-    struct AHCIPCIState *d;
+    AHCIPCIState *d;
     d = ICH9_AHCI(dev);
 
     msi_uninit(dev);
-- 
2.41.0


