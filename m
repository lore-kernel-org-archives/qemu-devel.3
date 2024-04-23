Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8EBC10F15
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG0j-00059n-Vg; Tue, 23 Apr 2024 09:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0b-00057W-Hz
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0Z-0001st-RS
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DmvHSqu5XipQmDsZg4N60N7DRIVaJnPkLHNypoyLe7s=;
 b=BN2Qr7AdPyWvvfkcfqZfsHcxvAN+NIQ9vDHb965ZsnMxkQtc6TopFko87H0ufo4Tk/ggd7
 hg17lMADM6YWsnllo8kayyZh3sBzh34F8npoUgTIzI/krq0R4IIWqRxnoWT23kZhcGgCwC
 ckQzGZqjvamaVjGfP+W/ocBUY98ygwE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-kbvqsKoiMyay-FJpTeg_bw-1; Tue, 23 Apr 2024 09:16:25 -0400
X-MC-Unique: kbvqsKoiMyay-FJpTeg_bw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-56e46bd7f6eso3068403a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878183; x=1714482983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmvHSqu5XipQmDsZg4N60N7DRIVaJnPkLHNypoyLe7s=;
 b=wRaj+yHNSbFk4mwwO1uqo+qFne92jzXs4zKi9c1fn8KslelHF/t66VatDQ165OB/Rx
 IAx4XZ4XNylNgSmWTQu0qRBWeYQ0p6idjV6D7x4zNpJ0MJBzPROQC7EJx5dFpibiDAxV
 8piIfo4n8i8TI888nf1Olngw9/aMz2P/X837FkZp8Bhpzr9de6P3DZwwMbRfGabNB2Iy
 1I7DYlxileM5c6swbYJKnrmTKVch+hPQoM6fboWXWxIjNEsuygy6W6aSl2eB5w2JMgfo
 ohROeweP1R+BpTqLdeSGLYV9jpCMP7q5mg6qRy/Fv/3SE/UAguZ56nXBaFp+kUAbMr8C
 WxRQ==
X-Gm-Message-State: AOJu0YyMnsPNjAJr8bwWBoKZdapHqiCkzCbTa4y1SPKjy2vYxQyXFsHT
 A1IwuyPmGFyUgaLgXtHub/IWa8ChXm25yrI7tGzn3lWy9KHN4cejXT4qBcoLz2dHatev417YDTG
 F9P81SDBWoQsSCJ9RpjzNuDw2XIDyopnphXKOew0YJQxx/KNw1UZwkblblCQJHajXcohw+4a76h
 MA9TkWOKs3P+QRUBFsr/H8FDR26zXEp7xVsZAT
X-Received: by 2002:a50:9b01:0:b0:571:cad0:a702 with SMTP id
 o1-20020a509b01000000b00571cad0a702mr935885edi.17.1713878183235; 
 Tue, 23 Apr 2024 06:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLnDaBcWHecU+xlyabcXE7plMqtY/pp/tA+p3WmfAehJ4emCvPrLCzULsIVVWziklkLFp7KA==
X-Received: by 2002:a50:9b01:0:b0:571:cad0:a702 with SMTP id
 o1-20020a509b01000000b00571cad0a702mr935874edi.17.1713878182980; 
 Tue, 23 Apr 2024 06:16:22 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 f15-20020aa7d84f000000b00571db231915sm4710789eds.78.2024.04.23.06.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 03/22] arm: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:15:53 +0200
Message-ID: <20240423131612.28362-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423131612.28362-1-pbonzini@redhat.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

For ARM targets, boards that require TCG are already using "default y".
Switch ARM_VIRT to the same selection mechanism.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/arm-softmmu/default.mak | 3 ++-
 hw/arm/Kconfig                          | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index c1cfb3bcf75..31f77c20269 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -5,7 +5,8 @@
 # CONFIG_PCI_DEVICES=n
 # CONFIG_TEST_DEVICES=n
 
-CONFIG_ARM_VIRT=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_ARM_VIRT=n
 
 # These are selected by default when TCG is enabled, uncomment them to
 # keep out of the build.
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 893a7bff66b..1e7cd01087f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -1,5 +1,7 @@
 config ARM_VIRT
     bool
+    default y
+    depends on ARM
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VFIO_AMD_XGBE
-- 
2.44.0


