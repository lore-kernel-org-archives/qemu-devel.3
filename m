Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E93C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG0r-0005Bn-SY; Tue, 23 Apr 2024 09:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0q-0005BX-3E
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0o-0001ve-EL
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqDRm0fAGdjZV6ibXIEOtjpw6ZjN24iUaHtZzdPh+OI=;
 b=hsdW4147HDd3cNnH31n41Wck0+/vt/z78JNzTx7YZjvz3i1vlV2FGJu5XPz4fdIgwvCDlE
 cwP8j86ak9iF7nbpzTvXdqFa1nAf8GE92xV5rIv83Lb3zPTEQ00EUaYJ0LCVE28pbUnQd+
 wFVZ0P6mZCLkhsuVuEWpqA8k0se6f9U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-jppiwWmPOmyvGHOxGWjFOg-1; Tue, 23 Apr 2024 09:16:40 -0400
X-MC-Unique: jppiwWmPOmyvGHOxGWjFOg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a572ceb5340so102193466b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878199; x=1714482999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yqDRm0fAGdjZV6ibXIEOtjpw6ZjN24iUaHtZzdPh+OI=;
 b=cACA+HaYYIfBVbXe3nO0U2qjEozygAguwrgxUXjySJlZc1AMbu1Xc0a54b9Y09PQlZ
 OOsUK/DKBcB8T2r53b5G7fvZD9fFSLbNpdMAgQjax6hjQRCGKTcQz66FI4rLWOfrL0Os
 7gVodVxZYfNGBC9o4fjE5drraLUVDiMoj1CzycWGlglEpwJA18IoRWU066/UX8vwzRcl
 4MfYaumPKoCku8O59OD4NhmhiCIxCiI0Ik4YbdwGE0v0OHuRqfWmdMeK0zqdVTexHjHb
 1+dYaZdF73lN3+et4nlIj5F4Ws+EPXG4leUQ0lE4YhMCC4AZ+xdY47zlqMdAjoj9aIoo
 pccg==
X-Gm-Message-State: AOJu0Yxj7BRhv/WA4uvnVO7WLz8/3My6y/Adhn7PzBkInTWrDPbP/3qP
 Di/F55jTaftQvMFPOAURhQBXZ2K6F/qf3inF26CjEgnYEHfTOPDvRl7A9mRZXgAq5ebO0rhrTwI
 KoGxMo2yDSjvF8cIfQMxzbPMkFW2x99cmQ8qRTGoRm5gaWN8N6NDIAQzxyd5wfdJ8zXj20U7c1a
 aFcoCNA8vQicCkyjOEQuUGcxvDXm/H2OaQu0rP
X-Received: by 2002:a17:906:561a:b0:a58:73ac:8b29 with SMTP id
 f26-20020a170906561a00b00a5873ac8b29mr2060846ejq.64.1713878199304; 
 Tue, 23 Apr 2024 06:16:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzcwHKHNHuEXq/ss6frcee/6Kjlbg5ZdZ0giFa/0o3xnOZAZjKD8c6HnIkQ6FuBtgGMGM68Q==
X-Received: by 2002:a17:906:561a:b0:a58:73ac:8b29 with SMTP id
 f26-20020a170906561a00b00a5873ac8b29mr2060826ejq.64.1713878199058; 
 Tue, 23 Apr 2024 06:16:39 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a170906c41300b00a587b25d648sm970426ejz.183.2024.04.23.06.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 09/22] m68k: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:15:59 +0200
Message-ID: <20240423131612.28362-10-pbonzini@redhat.com>
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

Some targets use "default y" for boards to filter out those that require
TCG.  For consistency we are switching all other targets to do the same.
Continue with m68k.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/m68k-softmmu/default.mak | 13 ++++++-------
 hw/m68k/Kconfig                          | 10 ++++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/configs/devices/m68k-softmmu/default.mak b/configs/devices/m68k-softmmu/default.mak
index 8dcaa28ed38..3ceda6b041b 100644
--- a/configs/devices/m68k-softmmu/default.mak
+++ b/configs/devices/m68k-softmmu/default.mak
@@ -1,9 +1,8 @@
 # Default configuration for m68k-softmmu
 
-# Boards:
-#
-CONFIG_AN5206=y
-CONFIG_MCF5208=y
-CONFIG_NEXTCUBE=y
-CONFIG_Q800=y
-CONFIG_M68K_VIRT=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_AN5206=n
+# CONFIG_MCF5208=n
+# CONFIG_NEXTCUBE=n
+# CONFIG_Q800=n
+# CONFIG_M68K_VIRT=n
diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index d88741ec9d1..0092cda4e9c 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -1,20 +1,28 @@
 config AN5206
     bool
+    default y
+    depends on M68K
     select COLDFIRE
     select PTIMER
 
 config MCF5208
     bool
+    default y
+    depends on M68K
     select COLDFIRE
     select PTIMER
 
 config NEXTCUBE
     bool
+    default y
+    depends on M68K
     select FRAMEBUFFER
     select ESCC
 
 config Q800
     bool
+    default y
+    depends on M68K
     select MAC_VIA
     select NUBUS
     select MACFB
@@ -29,6 +37,8 @@ config Q800
 
 config M68K_VIRT
     bool
+    default y
+    depends on M68K
     select M68K_IRQC
     select VIRT_CTRL
     select GOLDFISH_PIC
-- 
2.44.0


