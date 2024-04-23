Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D8EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG1V-0005UN-L2; Tue, 23 Apr 2024 09:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG1E-0005Hc-Ep
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG1C-00025r-Lm
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8N+zUFPDrSdnCw0bn/ZtpXuLRB19RGrrPQeBkAwY8OI=;
 b=H2bjenLy0O6uBJcNdZxY6mxQZ9AkIQCon5rZEqHkSY/dKr/ZljWIeBvv4yHPu93tTyn9Wz
 paPaF8SE6zxhhqRpZAG+c2Ttg+cW+AoQjosd2LRP2dA1jpNpBKnPlZOVpei/595lru7+RV
 t/qBwQJ8b8GqaqSYAQ9K88zZj20UeQc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-vnlC8sjUOTKE0qG_mcUFQA-1; Tue, 23 Apr 2024 09:17:04 -0400
X-MC-Unique: vnlC8sjUOTKE0qG_mcUFQA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5705ef0b425so2764617a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878223; x=1714483023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8N+zUFPDrSdnCw0bn/ZtpXuLRB19RGrrPQeBkAwY8OI=;
 b=a0CMEtEBxGjAgMEg39Px1fCpixICDbuFopzVB1zsNZszKCbgK9UsfDU9/soWxDHmZl
 VksqvaDY+99nAEAG6wguEPuIduf49oVVOJgNCCwDOWe0a5iVjvxzQ+Vn+AGu9Y3wXbxH
 mt5f2D1I3nhioYQ9G75sDG9QT3YB4pDsD06yvDPM4uWcpT14jeQJwK4Es0/Oe36XDOQ0
 DeBR8Xq7y4QlSwy24vvs9150BIR3W54POZ2EoTyyprC63JRT69jI59OGTux8kb0yf9Yz
 HYBi+KFd3SgUBcNJm+Wz9tcKmVdhRq5/pkI7P/yA7r3S5z2TKxRn3nxhzjxDKa70bMtI
 W3yw==
X-Gm-Message-State: AOJu0Yz8Kd0eS2/Xj/HrxxJcQc7HXwZ7h3ap5JAdB6ccj36M1YfUyWwT
 4GH7GQjS6PwuqSHDgCgRSW6V9ztU0D/9hnOO68yGFuFF/ufuhZkexrHm4gOdQ/jaIOk9gfPK+Ge
 MO2Vy+d1SQIExWdPuZvfR9Zgm3muMzxnLAfZhbITX4lgsg5ImF2sOO1SfzgZJrEvwD2mW5yfRhZ
 XFxlhp+GY2fALq/sns6fBsEBAjunyisX83PPDX
X-Received: by 2002:a50:d781:0:b0:56e:22b6:d924 with SMTP id
 w1-20020a50d781000000b0056e22b6d924mr8759160edi.13.1713878223110; 
 Tue, 23 Apr 2024 06:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP4Ybl9EYNCbksILrpj8A4/SR6EyijhIAjZtZyB5oBIK5x8+feE8ij7BGQDAw3P9a1kPPjnw==
X-Received: by 2002:a50:d781:0:b0:56e:22b6:d924 with SMTP id
 w1-20020a50d781000000b0056e22b6d924mr8759146edi.13.1713878222819; 
 Tue, 23 Apr 2024 06:17:02 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 dh20-20020a0564021d3400b005721ceed263sm1010894edb.32.2024.04.23.06.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:17:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 19/22] sh4: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:16:09 +0200
Message-ID: <20240423131612.28362-20-pbonzini@redhat.com>
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
Continue with SH.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/sh4-softmmu/default.mak | 7 +++----
 hw/sh4/Kconfig                          | 4 ++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/configs/devices/sh4-softmmu/default.mak b/configs/devices/sh4-softmmu/default.mak
index 565e8b0b5df..c06a427053a 100644
--- a/configs/devices/sh4-softmmu/default.mak
+++ b/configs/devices/sh4-softmmu/default.mak
@@ -5,7 +5,6 @@
 #CONFIG_PCI_DEVICES=n
 #CONFIG_TEST_DEVICES=n
 
-# Boards:
-#
-CONFIG_R2D=y
-CONFIG_SHIX=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_R2D=n
+# CONFIG_SHIX=n
diff --git a/hw/sh4/Kconfig b/hw/sh4/Kconfig
index e0c4ecd1a53..99a76a94c3f 100644
--- a/hw/sh4/Kconfig
+++ b/hw/sh4/Kconfig
@@ -1,5 +1,7 @@
 config R2D
     bool
+    default y
+    depends on SH4
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply RTL8139_PCI
@@ -13,6 +15,8 @@ config R2D
 
 config SHIX
     bool
+    default y
+    depends on SH4
     select SH7750
     select TC58128
 
-- 
2.44.0


