Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0627AC4829A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 11:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXfss-0002s3-Vr; Wed, 07 Feb 2024 06:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsr-0002rc-KR
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsq-0003Pz-8P
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707304465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ub5GUD57Lh/GVgnjxd7D37mJ+L/nM2kPJlsENhc1GS0=;
 b=JdNn+0TxVTOJqRe/2RU3jYDpGAZpSPQyw0alHdy4MumbTTAFdoeozfGQpb2iDpRCPcZq3w
 WiQfVnC8wgAhQkQ/avhaBWBUNPlSJEEJ5bZ97wQXXUSEsuvA3Iq9LbIdn7fD8NgLv0lc5F
 2NshPdm+cvScRO4Wf6iQCZcQwl7IQjM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-ReYZndccOeyebEJkCWArlA-1; Wed, 07 Feb 2024 06:14:24 -0500
X-MC-Unique: ReYZndccOeyebEJkCWArlA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5605c7b1f34so620172a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 03:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707304463; x=1707909263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ub5GUD57Lh/GVgnjxd7D37mJ+L/nM2kPJlsENhc1GS0=;
 b=n1aci9L8Bv05iKjm39lVpoAqs7DFwX4Fl5APYTC9BifgU6nR4CL3LUL4Zi8IDT/8IC
 D7E0BkmsIGrb80SBIKkW2SFgiXzp7NZVIe/9/2uIkp0XxgjWJw1bul+ZV0jqQb0u7uwz
 Y3kPpnshEiWrIY1haZkqfiMQ9FoZW6ZQMOeXE0jfvCX3WTWMwdcyiJgT56igMR7xpDfQ
 xib87P2TrTp+om8IcKyn3noep3dX60b6F+UCRlVKbtNi4G/d5bN8sbdwHX8B29u1kB8K
 sqab2iDieRKNTl5/DLcI1SnQTfE8NpRqB2L9df713nmIZ6bQoQD4MG1sGdazz/hogedU
 f4PA==
X-Gm-Message-State: AOJu0YymFL6RfTfAd6AX5aDZnidbJwZEKWkNy+49K9n/JkA1klB5EK+4
 FXNDYk7+z6z1lVFKma7XmpkfcZHkAtMS+FR+iEzlB2tVsPsG2cQ23+7XFQpTUj6Iw56CgOX9Wg5
 2Ixj1+CWU5gi99Tt1C4QqmB4nu/lKyRhOoB+YStavm2auZhrFiDZpfj0AcJzszXU5YzCc3YhXKY
 uhNWZkGQXb1ev0t+CEKXnMtL998xkfcZFCgIGA
X-Received: by 2002:a05:6402:286:b0:560:2c15:38b9 with SMTP id
 l6-20020a056402028600b005602c1538b9mr5649293edv.4.1707304462824; 
 Wed, 07 Feb 2024 03:14:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmCghDX0qlZpkGFYtgTm35RlroUM6n7wGJ+n1m3AFEX0BxWZR6Df3IlRSJ/O6xr0BazSL2fg==
X-Received: by 2002:a05:6402:286:b0:560:2c15:38b9 with SMTP id
 l6-20020a056402028600b005602c1538b9mr5649280edv.4.1707304462573; 
 Wed, 07 Feb 2024 03:14:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWr3/qGeZqQk0A3F7kLSvKOza8o3rPKQ1/umbBhnjB0p0gUfv5dbY0j3E8GoQd8GAzBMtrv72e6q3mOieHIxkRJdA==
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 dn6-20020a05640222e600b00560422bd11asm561407edb.30.2024.02.07.03.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 03:14:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: shentey@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 4/8] isa: fix ISA_SUPERIO dependencies
Date: Wed,  7 Feb 2024 12:14:06 +0100
Message-ID: <20240207111411.115040-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207111411.115040-1-pbonzini@redhat.com>
References: <20240207111411.115040-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ISA_SUPERIO does not provide an ISA bus, so it should not select the symbol:
instead it requires one.  Among its users, VT82C686 is the only one that
is a PCI-ISA bridge and does not already select ISA_BUS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 7884179d08b..5df3c09cd51 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -15,7 +15,7 @@ config I82378
 
 config ISA_SUPERIO
     bool
-    select ISA_BUS
+    depends on ISA_BUS
     select PCKBD
     select PARALLEL
     select SERIAL_ISA
@@ -47,6 +47,7 @@ config PIIX
 
 config VT82C686
     bool
+    select ISA_BUS
     select ISA_SUPERIO
     select ACPI
     select ACPI_SMBUS
-- 
2.43.0


