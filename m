Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF4EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG0m-0005Au-OD; Tue, 23 Apr 2024 09:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0l-0005A7-Di
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0j-0001ut-SU
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Egl3GcZqSB42uzZMSKlL6fe7IRgq+LTcd6BHkfvOPqo=;
 b=LlBRkEZvZfJpYrB6dF5/Y1wlWuiWJWyqCeatK8Xcc3t7Y+H84uyK5t0VVSk7SqphzDVrIB
 CIRa62Y8QPOYy6jaWy5yw6L8c8+LTT2Jt3WdzbFN1r9wBgSXocxnjCgbGSc4Ycr6wVBsE5
 +fz1fz11Log6KF3pOguyW+UvkEuR3wI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-KYZyQVhRM0GVCIGiUw1sbg-1; Tue, 23 Apr 2024 09:16:35 -0400
X-MC-Unique: KYZyQVhRM0GVCIGiUw1sbg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a51a2113040so265449766b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878192; x=1714482992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Egl3GcZqSB42uzZMSKlL6fe7IRgq+LTcd6BHkfvOPqo=;
 b=ti9t91I026TRpgYVnZyq9KawGLMUTUTrvgVAE6pOutoklz5RtsH/neT7HXxYqRxn/i
 h8j9Zfj6FQYuxb2ujf4nEW4UICNYb2E/5Pi7A9+tLXlJQQOayFJBDhL64uUc5aA84sJH
 AOVh18haeL875NiBtbaCmkSWi0oYCgWLyeugiYCASIYE5mIWEGqTK9Vyp1JvJnslUXE+
 DJynROUSDSK9kX3GCbyzEnj+wCOTF1jF+3ZliAsLExRGTGAdbdFT5qNZqLQLG9sbar2y
 rGaudQOU/n5YR7auVLjYpEujN5NDRMUBs73y368fqKye8Gml+TUCh01Spj0MJAOwT9FS
 A3hA==
X-Gm-Message-State: AOJu0Yx5JTzqk9QFG6wZ90qtc0PAy2Mztmf6ITjBDluTdJiaHn+0I/MW
 5utXK0gxdZm7LdJj/7K9YpVKhVPgKIIco+n/7s/VxmULiU5Dw2uK82mlBVRINa69kgiTCnA52Uh
 vDUtYXRpPGrb24Rxh/B09ldLRr09kYFVZ2/iaqptrUhIyd7WBDShP7+tYrcjo1WOuaVwNdWC0iB
 mbGtwaJI9Y3ryJMkG6zVejaeBVnTCm++NSzW7I
X-Received: by 2002:a17:906:fb92:b0:a52:430a:19bd with SMTP id
 lr18-20020a170906fb9200b00a52430a19bdmr7193791ejb.73.1713878192463; 
 Tue, 23 Apr 2024 06:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgvVj1ViQby+xb/y7EPXeWt0l79fQlM5QBkQ/qULOEYi1A8zfQFbezELGB2rZdKEw0yYujzw==
X-Received: by 2002:a17:906:fb92:b0:a52:430a:19bd with SMTP id
 lr18-20020a170906fb9200b00a52430a19bdmr7193782ejb.73.1713878192195; 
 Tue, 23 Apr 2024 06:16:32 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a17090627ca00b00a57b8297ad8sm1610905ejc.58.2024.04.23.06.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 07/22] i386: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:15:57 +0200
Message-ID: <20240423131612.28362-8-pbonzini@redhat.com>
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
Continue with i386.

No changes to generated config-devices.mak files, other than
adding CONFIG_I386 to the x86_64-softmmu target.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/i386-softmmu/default.mak | 11 +++++------
 hw/i386/Kconfig                          | 10 +++++++++-
 target/i386/Kconfig                      |  1 +
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 598c6646dfc..448e3e3b1ba 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -24,9 +24,8 @@
 #CONFIG_VTD=n
 #CONFIG_SGX=n
 
-# Boards:
-#
-CONFIG_ISAPC=y
-CONFIG_I440FX=y
-CONFIG_Q35=y
-CONFIG_MICROVM=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_ISAPC=n
+# CONFIG_I440FX=n
+# CONFIG_Q35=n
+# CONFIG_MICROVM=n
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index a6ee052f9a1..4362164962c 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -66,6 +66,8 @@ config PC_ACPI
 
 config I440FX
     bool
+    default y
+    depends on I386
     imply E1000_PCI
     imply VMPORT
     imply VMMOUSE
@@ -81,6 +83,8 @@ config I440FX
 
 config ISAPC
     bool
+    default y
+    depends on I386
     imply VGA_ISA
     select ISA_BUS
     select PC
@@ -91,6 +95,8 @@ config ISAPC
 
 config Q35
     bool
+    default y
+    depends on I386
     imply VTD
     imply AMD_IOMMU
     imply E1000E_PCI_EXPRESS
@@ -108,6 +114,8 @@ config Q35
 
 config MICROVM
     bool
+    default y
+    depends on I386
     select SERIAL_ISA # for serial_hds_isa_init()
     select ISA_BUS
     select APIC
@@ -142,4 +150,4 @@ config VMMOUSE
 config XEN_EMU
     bool
     default y
-    depends on KVM && (I386 || X86_64)
+    depends on KVM && I386
diff --git a/target/i386/Kconfig b/target/i386/Kconfig
index ce6968906ee..3e62fdc7064 100644
--- a/target/i386/Kconfig
+++ b/target/i386/Kconfig
@@ -3,3 +3,4 @@ config I386
 
 config X86_64
     bool
+    select I386
-- 
2.44.0


