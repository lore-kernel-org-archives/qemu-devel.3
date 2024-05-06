Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02A0C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t8j-0005md-5O; Mon, 06 May 2024 03:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8c-0005jK-KB
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8Z-0001Ui-86
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JS40WGMZssL8xSLN75H7ZLPUAK/PS4Fo0sIeTbJc6nU=;
 b=POeba1OCwKTJTt9MSziSWyus1PNe0JgRU+ppKYVZ07IcxHGQtrNqPFNWocxS2WoP1Ef2UM
 nGQi7h7USrFTT291rIxvMdieEunMP76aoK66a7uEb7QEpfnsLkP78NajcSjzy7EVD3ekMg
 jA//a4Nq8KY7pzzqdItpWYYbNrej/Nc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-Gx-aH9xePu-e8lRWt8T8TQ-1; Mon, 06 May 2024 03:51:35 -0400
X-MC-Unique: Gx-aH9xePu-e8lRWt8T8TQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59a212d874so128293666b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981893; x=1715586693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JS40WGMZssL8xSLN75H7ZLPUAK/PS4Fo0sIeTbJc6nU=;
 b=DyUNxx8D0NuYVGmgLHbDnjc0x+jhPC6Ev/9lpIUTUAjZmRwTOL6Z9oxVV1BXOFsY0t
 DMFsQWv7tHmQc7YSCgRiw9TwuW01zuEgR+SxnhlcaED3LQ5dkH6iANvl1ehKBhrIup5x
 oHr2CUS34gvnzXitoeV+jvQZ5rbSupDKy/KxczJSCJG9fPWLiUS/VTMdQrf03S7JwShi
 dcsTCEzxBBYufkKGIHkXDd+OPD9+PZpkDF3vgUh6I68Wg1y4IjbrQ4wB3skWPVCmay9m
 O/rKkoTUIyrCe84aNufkE0CXaYMs2NsraDbYU2eOFPEBTqNu1tE3WjUJ1W1DLs4x+rbb
 XXiw==
X-Gm-Message-State: AOJu0YyW0PCWS4gy0GqwM7OQWhA/gcfyBncsoXJ//7IZq+RZ+ihhwY0u
 R9mcRxcagI4+BSMJ8vhUuBIrzysd8WV6jzlCflO7mK3eHJJhkbnRY/HMLxtAEI1NeR8u0auw8v5
 kPfD2I8GZWGFoBy104OPNxXCdVeUwtBymrcTX2hLUuOfXNSx/nIr9J4LNqCRQ72oNjeuAtIWkjn
 NP7fJKOUITil+LLb5z7cGrT46zNZTSASTOrNid
X-Received: by 2002:a17:906:1555:b0:a51:8d60:215a with SMTP id
 c21-20020a170906155500b00a518d60215amr5859708ejd.27.1714981893025; 
 Mon, 06 May 2024 00:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERJiTImqjrq5t8Z9eAfaY6QWt/zgf6Bnq44WAYLRkxN9uRnMeQG5EG5eBwz1VmT4aSBlz6xg==
X-Received: by 2002:a17:906:1555:b0:a51:8d60:215a with SMTP id
 c21-20020a170906155500b00a518d60215amr5859690ejd.27.1714981892621; 
 Mon, 06 May 2024 00:51:32 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a170906455400b00a59c4a16e4asm1557962ejq.120.2024.05.06.00.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 02/46] Kconfig: kvm: allow building without any board
Date: Mon,  6 May 2024 09:50:41 +0200
Message-ID: <20240506075125.8238-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


