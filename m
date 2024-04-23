Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7027C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG16-0005Fq-BP; Tue, 23 Apr 2024 09:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG11-0005Ez-0N
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0y-000212-VS
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIzw1ooJRYdWb1ORIWKZDYF2U0eSao1bJMHeOLukmWI=;
 b=jSRsxjEg3eMIEUpSyMoRGkOM68Lgt3Am4llLqGoJg3k2VjeUCNxWb+4haXCe/fy+0VMAPT
 OFaB+pN7KP0pYxJUNt0siFMZZbB1sNlGxCWGLSO0c2njWdzkFx7XcGjHje+3SJJ4Gxz5C0
 Pq+iIaaM3nlKck6e6PwWgUi/I/d+2Qw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-ziM5RclPNJOKrgbGGMm7HA-1; Tue, 23 Apr 2024 09:16:51 -0400
X-MC-Unique: ziM5RclPNJOKrgbGGMm7HA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-56e46bd7f6eso3068579a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878209; x=1714483009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MIzw1ooJRYdWb1ORIWKZDYF2U0eSao1bJMHeOLukmWI=;
 b=KOJ7G1RXvNt6IT8EEhb9KMONmjjG3y9NyOu9CbluI4IfRDNu8mYqSK89Cz0isCai/8
 dANQC+/x8dtOdjyAg2mQlHmDOY8QkhYuYu0fSCzEW3Ky2GHKN2dPu7j31KLGWmUfg7V9
 EU18YtwLi97MDkINz/NyLEnJ+U3XQch2n+pltC0aV1o/iPliPZWHiT9y615byauWS4wM
 mYFuyrc4wGP8DH1KNXrsx8QwvKy2mOTZl/gajAOTnrZCZhstXY9FuU2HzHX8LveK631V
 LGvAN/zjcK4Wn/osfvxlnuENK4LLmFw6ioYSoqRCfpKnpwtohkWA4vDbsJwfl+xASJGH
 QaDw==
X-Gm-Message-State: AOJu0Yz/X0j9ZtqsMHOYIe7Igw4qaZm8Q9GeWunoKE9GtEpLPaw19r+Y
 FZyFZ3+LX/fjz4AUW7fIP9NfW2LVeF7XBFLfSrWgQoNu6PxmjAao6xO/Ti6PoXUvdnLNqB7dW/5
 WIht06Ll5IguA4a9LNbEoK10Cxy4OHcehzsj4MlsVLNroxLcTWQOyYVftVp2hRjKVJyhnuuJi0X
 IQ/m79b5g8X1BG5T3mHonSOzkujDWGprSLo6pM
X-Received: by 2002:a50:8e1a:0:b0:56d:f035:7db2 with SMTP id
 26-20020a508e1a000000b0056df0357db2mr8842769edw.24.1713878209724; 
 Tue, 23 Apr 2024 06:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg9B6mf0iHnWdtKBxVdwmjzif7VodSQg+NMjzEb/G30Drc8LKb2eilYBFquOZ+DUHSXk3CQg==
X-Received: by 2002:a50:8e1a:0:b0:56d:f035:7db2 with SMTP id
 26-20020a508e1a000000b0056df0357db2mr8842758edw.24.1713878209401; 
 Tue, 23 Apr 2024 06:16:49 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 o12-20020aa7dd4c000000b005704419f56csm6663143edw.86.2024.04.23.06.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 13/22] nios2: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:16:03 +0200
Message-ID: <20240423131612.28362-14-pbonzini@redhat.com>
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
Continue with Nios2.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/nios2-softmmu/default.mak | 7 +++----
 hw/nios2/Kconfig                          | 9 ++++-----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/configs/devices/nios2-softmmu/default.mak b/configs/devices/nios2-softmmu/default.mak
index e130d024e62..50a68d26b0f 100644
--- a/configs/devices/nios2-softmmu/default.mak
+++ b/configs/devices/nios2-softmmu/default.mak
@@ -1,6 +1,5 @@
 # Default configuration for nios2-softmmu
 
-# Boards:
-#
-CONFIG_NIOS2_10M50=y
-CONFIG_NIOS2_GENERIC_NOMMU=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_NIOS2_10M50=n
+# CONFIG_NIOS2_GENERIC_NOMMU=n
diff --git a/hw/nios2/Kconfig b/hw/nios2/Kconfig
index 4748ae27b67..ab7866a5358 100644
--- a/hw/nios2/Kconfig
+++ b/hw/nios2/Kconfig
@@ -1,13 +1,12 @@
 config NIOS2_10M50
     bool
-    select NIOS2
+    default y
+    depends on NIOS2
     select SERIAL
     select ALTERA_TIMER
     select NIOS2_VIC
 
 config NIOS2_GENERIC_NOMMU
     bool
-    select NIOS2
-
-config NIOS2
-    bool
+    default y
+    depends on NIOS2
-- 
2.44.0


