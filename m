Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A63C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 11:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXfsz-0002tE-R8; Wed, 07 Feb 2024 06:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsx-0002sx-FR
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsv-0003Rb-Oh
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707304473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0KI2721IFtb4WAKrG3+R+L2haa/vmvr3mnGCgCOoT4=;
 b=VeJ2nHOA0XqLRqeyo5W1ikbjRCjt+IXFB9PHzM3Jsv8xWTSjQ87DWytdRhiKrQOlB3pxBs
 /CTPKx5AKJSAy6VA5PXj0SBn5JoiCFp4YKAEvzMBA/4pcQCQYIKbtWKTdp1dz1V6jX2eDk
 7y6sNLeICkTkPqCBgJxP0YY76a2aSq4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-RGmsWFqNODaAKBZkFEfNEg-1; Wed, 07 Feb 2024 06:14:32 -0500
X-MC-Unique: RGmsWFqNODaAKBZkFEfNEg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d0c1aa652eso5957221fa.2
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 03:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707304470; x=1707909270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R0KI2721IFtb4WAKrG3+R+L2haa/vmvr3mnGCgCOoT4=;
 b=NbCB21tDg8DXEYcQhUTA4ancCwfPPSH+RPdAqrol8ceJmVdkBdIUkZtYlmnEU9tes/
 456YSux8xh1J6bBLPSS7SZbGPjNKvpqTqvcESfnbPJpiNL3OAGvM46NXxwcMRTS9f0QQ
 Wq7aue7aS3NSbClBXOc0qR5gqoLXowzK+0uCjjBj5+RUp7IXk3WCoWtOQTZ9aFlG6NKX
 CsyRYotfO2FvMn4HjyGPKpr68uxVN35ZtEgvGtf8CrjSpWx6rj8DIh9kA+u55zqyhevK
 1+76ZQBcbIXRxOlFimVhaUoOPCbWN4pmb1gheIVMkZk5KFld5RWDyXPyq96zLlQGhBby
 NC9A==
X-Gm-Message-State: AOJu0YzHNT4dTmRlxoNwtW/tkxvvUxGozPEcGAmnJWDbc+dLsdHAfuax
 bqXNaFNLuj19w0GV7F7JAEKiLxsVv2Uvs32VZFkAKUD738o6yfECE8eH1YYLyDeZZKbtruCCXYW
 eA1DbMY7M5qlmD2dHv8mKHSdfoJPX9oiU6vU+BzW2YDpzTXsugp+EkqMIICWaj+Hg+NEowJor3o
 q+N+tiy4t4k+oV+nkw7TZXnrtfCVnnY65lKkEJ
X-Received: by 2002:a05:651c:695:b0:2d0:b025:f1ee with SMTP id
 x21-20020a05651c069500b002d0b025f1eemr3027851ljb.21.1707304470016; 
 Wed, 07 Feb 2024 03:14:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY0eYuSBAGKAd1+PxkefcHY7yc6nAL7p53a+kSRfZYZVtqDT6Dxj9Yw63JP+R7Ed7wIN+BZw==
X-Received: by 2002:a05:651c:695:b0:2d0:b025:f1ee with SMTP id
 x21-20020a05651c069500b002d0b025f1eemr3027835ljb.21.1707304469595; 
 Wed, 07 Feb 2024 03:14:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXx/zhrZv/znHdBPtHtBcJzixxiO/iDTu5fY95DbYdFU+ti5g30/O9V+kXE0PAEmVk5UPCOePrYHE9+YFeRi5F2kA==
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 v2-20020aa7d802000000b0055efaddeafdsm552613edq.86.2024.02.07.03.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 03:14:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: shentey@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 7/8] mips: allow compiling out CONFIG_MIPS_ITU
Date: Wed,  7 Feb 2024 12:14:09 +0100
Message-ID: <20240207111411.115040-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207111411.115040-1-pbonzini@redhat.com>
References: <20240207111411.115040-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

itc_reconfigure() is referenced from TCG, provide a stub if needed.
This makes it possible to build a QEMU binary that only includes
boards without a CPS device (only Malta and Boston create one).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/mips_itu-stub.c | 26 ++++++++++++++++++++++++++
 hw/mips/meson.build     |  1 +
 2 files changed, 27 insertions(+)
 create mode 100644 hw/mips/mips_itu-stub.c

diff --git a/hw/mips/mips_itu-stub.c b/hw/mips/mips_itu-stub.c
new file mode 100644
index 00000000000..4cc82b8461f
--- /dev/null
+++ b/hw/mips/mips_itu-stub.c
@@ -0,0 +1,26 @@
+/*
+ * Inter-Thread Communication Unit emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/mips_itu.h"
+
+void itc_reconfigure(MIPSITUState *tag)
+{
+    abort();
+}
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index f06d88f3430..2b1b96147a6 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -4,6 +4,7 @@ mips_ss.add(when: 'CONFIG_FW_CFG_MIPS', if_true: files('fw_cfg.c'))
 mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c', 'loongson3_virt.c'))
 mips_ss.add(when: 'CONFIG_MALTA', if_true: files('malta.c'))
 mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
+mips_ss.add(when: 'CONFIG_MIPS_ITU', if_false: files('mips_itu-stub.c'))
 
 if 'CONFIG_TCG' in config_all_accel
 mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
-- 
2.43.0


