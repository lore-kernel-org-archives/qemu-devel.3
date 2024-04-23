Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F8AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 19:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzLe5-0001rK-LM; Tue, 23 Apr 2024 15:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzLe4-0001rB-Ha
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 15:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzLe2-00055f-Pu
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 15:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713899853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JS40WGMZssL8xSLN75H7ZLPUAK/PS4Fo0sIeTbJc6nU=;
 b=Z5qo/W47DTqPkcqfjpngt8u987L2XVrJ5neihIBcuIbWTJfy6liSUs6PfLjRWHawCg8vk8
 AvcYTA8V3LSXO3MnfHRAE2OOkCFv0K5mw7tH7bthCvpaUBFvTOMZELF7YkDBbjTPMIyGWf
 EOkedFB9f0BUA5qrAtczCw3yO1KMK58=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-2uSKMwDJMY2iajAgg9_GpA-1; Tue, 23 Apr 2024 15:17:31 -0400
X-MC-Unique: 2uSKMwDJMY2iajAgg9_GpA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-572231087c1so517762a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 12:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713899850; x=1714504650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JS40WGMZssL8xSLN75H7ZLPUAK/PS4Fo0sIeTbJc6nU=;
 b=qonlvXRC+NX/qwf7OIu+Xur2K6T5OZbLVWFpE+l7I7PJFGV/wT70szrNR2Y6e0Ox3B
 gujD3BUpcYkswzPbxgUuKebSixnh1VssuU1SjoqIR8alesc+lHVMpamCjH4EmACcp9u2
 xsoegMEUDXAPh5QWaC9c1Q7ASLj0UZEZJ2FLzNryitst2tUnyUUHfWuKEm6yO4omzwe9
 HLyB/J16/e4gYzl//5tdRzxocadcytL8OxqHtJEi2ycUpPNvpznfWqObAyIzN2ZtBRC5
 Fyeb2A0KikEqeqPGVmlys4H6lsp/x6+j7mIfETu9gHQ4E1OYVUw73h2C6c/oiIESyEIn
 MMMQ==
X-Gm-Message-State: AOJu0YyAXTWI3PPZ7VXb8s9WDOsxCZVYo8IcLbXSMbo6apQeQBk/BG7C
 awNO1911BZcSJg7KuZL2ct9PclXy8CtNxBK/g0KndDXh0AauLGCRhtR+KiwLmNbpd2HAPm4I3dD
 5wA7jQs2ShtcNl+SRgckBdQ6zY5mCX7dqq5KV4I5Uc3o6xZZvAmijTLTeCgorDf1IYQy/d/9XcV
 IXAqbZnwTzkef+fiO2pp53GRKs2thYjJy2c3ME
X-Received: by 2002:a17:906:c114:b0:a51:de95:f592 with SMTP id
 do20-20020a170906c11400b00a51de95f592mr229917ejc.63.1713899849885; 
 Tue, 23 Apr 2024 12:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaVkxTMXkVI9k1PDvNUCCbRXSXZsY5fuuqW0ZuQszAvnu2Se4vzcOesJM+XUw5Ef/+Ax2kMQ==
X-Received: by 2002:a17:906:c114:b0:a51:de95:f592 with SMTP id
 do20-20020a170906c11400b00a51de95f592mr229897ejc.63.1713899849558; 
 Tue, 23 Apr 2024 12:17:29 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a170906b30b00b00a5242e285aesm7292492ejz.184.2024.04.23.12.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 12:17:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] Kconfig: kvm: allow building without any board
Date: Tue, 23 Apr 2024 21:17:28 +0200
Message-ID: <20240423191728.52535-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

KVM code might have to call functions on the PCIDevice that is
passed to kvm_arch_fixup_msi_route().  This fails in the case
where --without-default-devices is used and no board is
configured.  While this is not really a useful configuration,
and therefore setting up stubs for CONFIG_PCI is overkill,
failing the build is impolite.  Just include the PCI
subsystem if kvm_arch_fixup_msi_route() requires it, as
is the case for ARM and x86.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/Kconfig  | 2 ++
 target/i386/Kconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/Kconfig b/target/arm/Kconfig
index bf57d739cd1..5847c5a74a7 100644
--- a/target/arm/Kconfig
+++ b/target/arm/Kconfig
@@ -9,3 +9,5 @@ config ARM
 config AARCH64
     bool
     select ARM
+    # kvm_arch_fixup_msi_route() needs to access PCIDevice
+    select PCI if KVM
diff --git a/target/i386/Kconfig b/target/i386/Kconfig
index ce6968906ee..46898946394 100644
--- a/target/i386/Kconfig
+++ b/target/i386/Kconfig
@@ -1,5 +1,7 @@
 config I386
     bool
+    # kvm_arch_fixup_msi_route() needs to access PCIDevice
+    select PCI if KVM
 
 config X86_64
     bool
-- 
2.44.0


