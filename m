Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53946C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG1a-0005hi-J7; Tue, 23 Apr 2024 09:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG1M-0005Oe-QI
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG1L-00026j-CQ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FGhTZLTdf6DU5NBUYSsfak+5kzV/k/ReQ0dhwJWczE=;
 b=N2nlHiTA107O0Og//zdQmlQIgZsR918iePr59eY4MqjMkSxOtjg8q+3qIQxBXWOYDUX+9d
 js5PD2Ltrp8fppSU0s7Q3FuNN+73EceYyosV9oMqgGyxH9p1gyPGbRNZ1f3s1AO2LcrCVe
 R6Lq2r33TPnFnuBf360g5PjvR0xUROo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-2QFggmIENIKQOqIQ63oMPw-1; Tue, 23 Apr 2024 09:17:12 -0400
X-MC-Unique: 2QFggmIENIKQOqIQ63oMPw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a556121c01aso292434066b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878229; x=1714483029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FGhTZLTdf6DU5NBUYSsfak+5kzV/k/ReQ0dhwJWczE=;
 b=HWGlR/VGp5BOlRk4vYxpi1vjFsy+ip5m/UExTLwAtgqcRSvZ4przjq7op7BJbQFRL0
 EqLHYtK289OSRdVm6muj7W+KoN8gWAi9NwU59eoH99/Alp8EsCIyvUfBI1IzFNVQsnGk
 bM/ICCNBo82RPhrVQPPPZFV/r/gGRfjoXVtw+LC8AKndH9o6517iW8UiUSH+uX/xi0uh
 PqviZ1hGuM70PmhgOvqGL4jfQpDqRfUD1C7PwXKrkKBB58mbj5Wpb+jMdeNp5fwkthlK
 MNn4sQQGc35I/UJu9OmA5bzhR8JtkOSWGwl/d7EcDzxdyJIYr1zd5sQ5yzulqZmWL9Zz
 D5kw==
X-Gm-Message-State: AOJu0Yz4le88sckFcVNKiqSVL1gT1p9rNBrJwbW8SA93shNcgET3QR5D
 QX8vpM7+IertZikfOxwV7bFA2ioTo16omLfltIO1HUeFJ0mzVKonvf8587tDOfvLy6znJ3QdNQq
 VBRHPB+TwKFJGoqnXF2b44HbeeqQZC6B59503bUqjpKLpAu8MW5Oz17EWzfdf1nRVUHXUzaG7JG
 J3C0woLwHWjQlVinPVudSu/g4l2sGzJIjjIC0C
X-Received: by 2002:a17:907:7f2a:b0:a55:bb1c:80fb with SMTP id
 qf42-20020a1709077f2a00b00a55bb1c80fbmr4455713ejc.15.1713878229708; 
 Tue, 23 Apr 2024 06:17:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfGx1YYhV8hsKRNtxkXA+ZM0/tv3ZImU1e2XL+Szzt8wZzZEe7H7IOTJOvWxongefxyyausA==
X-Received: by 2002:a17:907:7f2a:b0:a55:bb1c:80fb with SMTP id
 qf42-20020a1709077f2a00b00a55bb1c80fbmr4455690ejc.15.1713878229346; 
 Tue, 23 Apr 2024 06:17:09 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a1709060a5000b00a5575c9d5b4sm6804990ejf.63.2024.04.23.06.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:17:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 22/22] xtensa: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:16:12 +0200
Message-ID: <20240423131612.28362-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423131612.28362-1-pbonzini@redhat.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some targets use "default y" for boards to filter out those that require
TCG.  For consistency we are switching all other targets to do the same.
Continue with Xtensa.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/xtensa-softmmu/default.mak | 9 ++++-----
 hw/xtensa/Kconfig                          | 6 ++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/configs/devices/xtensa-softmmu/default.mak b/configs/devices/xtensa-softmmu/default.mak
index f650cad7609..fbc3079a943 100644
--- a/configs/devices/xtensa-softmmu/default.mak
+++ b/configs/devices/xtensa-softmmu/default.mak
@@ -4,8 +4,7 @@
 #
 #CONFIG_PCI_DEVICES=n
 
-# Boards:
-#
-CONFIG_XTENSA_SIM=y
-CONFIG_XTENSA_VIRT=y
-CONFIG_XTENSA_XTFPGA=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_XTENSA_SIM=n
+# CONFIG_XTENSA_VIRT=n
+# CONFIG_XTENSA_XTFPGA=n
diff --git a/hw/xtensa/Kconfig b/hw/xtensa/Kconfig
index 0740657ea58..443b415c2ba 100644
--- a/hw/xtensa/Kconfig
+++ b/hw/xtensa/Kconfig
@@ -1,14 +1,20 @@
 config XTENSA_SIM
+    default y
+    depends on XTENSA
     bool
 
 config XTENSA_VIRT
     bool
+    default y
+    depends on XTENSA
     select XTENSA_SIM
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PCI_DEVICES
 
 config XTENSA_XTFPGA
     bool
+    default y
+    depends on XTENSA
     select OPENCORES_ETH
     select PFLASH_CFI01
     select SERIAL
-- 
2.44.0


