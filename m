Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9E1C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG13-0005FD-RW; Tue, 23 Apr 2024 09:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0y-0005Ct-S1
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0x-000203-3y
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gCKlrw9o4yb5qaqhszZhhWNDYutIOFOseJT54YRJVM=;
 b=ISnKAwEznzn5+C2PiSk7P5EhqliA90igBXXcWuKnNNJVnfo3PJ+ExcK5uPnM3KwjpqbAJy
 ON1XqvkHu14g2PkmbELFXzMcOyuxpE/GWLCo51kyt93TWoArv61NztLNKKxRh9oPnjGZqD
 vSWM/4ADRx3S8SOhqGvkBZ00L2WY61o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-HL1JgqtBO9O2BcgB0ctMrA-1; Tue, 23 Apr 2024 09:16:49 -0400
X-MC-Unique: HL1JgqtBO9O2BcgB0ctMrA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56e645a8762so3298793a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878207; x=1714483007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gCKlrw9o4yb5qaqhszZhhWNDYutIOFOseJT54YRJVM=;
 b=wAu2TwWIHmQS+afuZmEuifhfrasLcz23/AoJWfBPUPqRciWF1qwLvUAtwUJwlsf0li
 +mEEYHv9/vl5XiKpG3cx9FvZZ1C6lazQJSVSQlJVt38WuxbSv870SH3G5scbm7EeEiC+
 8UAxB/P3WXpcAzwXzzXqnzWJNz0f3NYO4cIjeEHdMqpgmdHeuviy8gwss/n3HU2dwBx8
 hc/C4dz9R5n9FhmHGo++USAvlUob/P7kPP+90Rwuol60r9F9LJ+Wjd3uV68Vs+a/wJ7n
 EScOyleEuhxRU52n2PXVLsin9lG1cL7hi1I1WmnXCJRdE1e3+7j6nynvSW+hvBXYyXZ3
 otEQ==
X-Gm-Message-State: AOJu0Yy7MoDpwzXaLkETaJTKCt0L1Ts54n22txjHbZcb1fpJbyGpeadM
 sfn/lsxQP+e0cr7xXlS9sQb8E+z1CLOIBRXOnCN8FgP20OFFHF2OCYNvETnWEEQ9W6fjSnTuE7C
 XqutaALQJaJQcPLXwgdUyTcGdDpk4qECXtv1zRVFULW0X+lKCMpqnAKSdTwZtLOFMtq0GDO7wOM
 ZC9b2/xCYtdA7cyz6ZPOasaa3iCRHvR2DL9s9n
X-Received: by 2002:a50:9b51:0:b0:56d:c40d:b921 with SMTP id
 a17-20020a509b51000000b0056dc40db921mr8986172edj.20.1713878207578; 
 Tue, 23 Apr 2024 06:16:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3HB9RM3Jlm3AGEFE3hIXuDFIsPvldm3qDjERHpPtKZ6uYkH4+GRuyETMc4xK40vW5fBFdbw==
X-Received: by 2002:a50:9b51:0:b0:56d:c40d:b921 with SMTP id
 a17-20020a509b51000000b0056dc40db921mr8986158edj.20.1713878207306; 
 Tue, 23 Apr 2024 06:16:47 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a50cd08000000b0056ff82e54a0sm6963745edi.31.2024.04.23.06.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 12/22] mips: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:16:02 +0200
Message-ID: <20240423131612.28362-13-pbonzini@redhat.com>
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
Continue with MIPS.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/mips-softmmu/common.mak      |  5 +++--
 configs/devices/mips64-softmmu/default.mak   |  4 +++-
 configs/devices/mips64el-softmmu/default.mak | 10 ++++++----
 hw/mips/Kconfig                              | 12 ++++++++++++
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/configs/devices/mips-softmmu/common.mak b/configs/devices/mips-softmmu/common.mak
index 416a5d353e8..b50107feafe 100644
--- a/configs/devices/mips-softmmu/common.mak
+++ b/configs/devices/mips-softmmu/common.mak
@@ -4,5 +4,6 @@
 # CONFIG_PCI_DEVICES=n
 # CONFIG_TEST_DEVICES=n
 
-CONFIG_MALTA=y
-CONFIG_MIPSSIM=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_MALTA=n
+# CONFIG_MIPSSIM=n
diff --git a/configs/devices/mips64-softmmu/default.mak b/configs/devices/mips64-softmmu/default.mak
index 566672f3c22..1b8d7ced1c6 100644
--- a/configs/devices/mips64-softmmu/default.mak
+++ b/configs/devices/mips64-softmmu/default.mak
@@ -1,4 +1,6 @@
 # Default configuration for mips64-softmmu
 
 include ../mips-softmmu/common.mak
-CONFIG_JAZZ=y
+
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_JAZZ=n
diff --git a/configs/devices/mips64el-softmmu/default.mak b/configs/devices/mips64el-softmmu/default.mak
index 88a37cf27f1..9dce346c4fb 100644
--- a/configs/devices/mips64el-softmmu/default.mak
+++ b/configs/devices/mips64el-softmmu/default.mak
@@ -1,7 +1,9 @@
 # Default configuration for mips64el-softmmu
 
 include ../mips-softmmu/common.mak
-CONFIG_FULOONG=y
-CONFIG_LOONGSON3V=y
-CONFIG_JAZZ=y
-CONFIG_MIPS_BOSTON=y
+
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_FULOONG=n
+# CONFIG_LOONGSON3V=n
+# CONFIG_JAZZ=n
+# CONFIG_MIPS_BOSTON=n
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 5c83ef49cf6..9bccb363eb9 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -1,5 +1,7 @@
 config MALTA
     bool
+    default y
+    depends on MIPS
     imply PCNET_PCI
     imply PCI_DEVICES
     imply TEST_DEVICES
@@ -13,11 +15,15 @@ config MALTA
 
 config MIPSSIM
     bool
+    default y
+    depends on MIPS
     select SERIAL
     select MIPSNET
 
 config JAZZ
     bool
+    default y
+    depends on MIPS64
     select ISA_BUS
     select RC4030
     select I8259
@@ -38,6 +44,8 @@ config JAZZ
 
 config FULOONG
     bool
+    default y
+    depends on MIPS64 && !TARGET_BIG_ENDIAN
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply ATI_VGA
@@ -48,6 +56,8 @@ config FULOONG
 
 config LOONGSON3V
     bool
+    default y
+    depends on MIPS64 && !TARGET_BIG_ENDIAN
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VIRTIO_PCI
@@ -69,6 +79,8 @@ config MIPS_CPS
 
 config MIPS_BOSTON
     bool
+    default y
+    depends on MIPS64 && !TARGET_BIG_ENDIAN
     imply PCI_DEVICES
     imply TEST_DEVICES
     select FITLOADER
-- 
2.44.0


