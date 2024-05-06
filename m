Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBF4C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9A-0005x2-02; Mon, 06 May 2024 03:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8d-0005jS-Je
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8Z-0001Xj-NJ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NaFhvDsV4aiOiczV5OFhsyZUhVEImpMxri4NWO+aWMM=;
 b=I0aq9lvORKnzM9eK5ZiAOnpH9/IS8YINO7fJFC0VZ74R4ypy+QDgMoXzL7GJmz7CguV0RL
 0N700u23/cmg8UKY372dS//36kEGK4atUdI/bZV/DwesY8+gZTrtUGMKB+DsDSoymd6HCZ
 dot9lliKMKpXr5IG4lb/IlarpgXJYsQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-yT3oX4s_OoaDSlgzV18CKA-1; Mon, 06 May 2024 03:51:45 -0400
X-MC-Unique: yT3oX4s_OoaDSlgzV18CKA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59c942611bso53291366b.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981903; x=1715586703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NaFhvDsV4aiOiczV5OFhsyZUhVEImpMxri4NWO+aWMM=;
 b=KQcqZrKFfTuBdwaFQqSijRPEeHiDG6fXPMEEVqhrGTQ0evHzQBICS8JYVDfUiIzcPF
 veVU4xuH53+54msjf1RODiUfVne5asWZiXPhl9uM5rcbEE2CufxquZ9o1imEZkzj3ibG
 7vbZBjZsxQEpnoc3GPDMM8TBqpNf/EkB8SiJyLrqljL/HuavN4liKwoajwqgX0dN4jfb
 dVqjGq4TqxaswA+W4K4Df3DcOcsDxJigv+TEhcngQ1R8lyj5F5bvGkJPlah3zwI6UY/D
 ZIxEld8Xeco9KVQC2Ibl3lytnv7efwbtXhNKSeytvAzUD2ShH1B6GsduTviV1SwjGzGU
 f9lA==
X-Gm-Message-State: AOJu0Yx2f3dlwzkq3RK5IE6uIhUfQMATo+SkFeZEVNrw16R73qj9ro8R
 ItQTRqol4zEFhwLfdXUPiAwA6o0pNnsOjYAAwNQrWrKOSHOJ9Gs0n/CtHBvWXOXj8ASllBbqr03
 wTFkl6JENertPMcYdonMo5Dj3Od42Bahy25fIrRAir+jQ/FX74hyAVuY6jypWdnDq4B365+VaRI
 i7gvYhkXo9iYlerZ0qpEY8Wp5MdlkIgDgTTleO
X-Received: by 2002:a50:d659:0:b0:572:1625:ae99 with SMTP id
 c25-20020a50d659000000b005721625ae99mr5901636edj.31.1714981903295; 
 Mon, 06 May 2024 00:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxzrY/sFzbZX0zn5paavMmPOjTmDol1XfIskQew+lsNaDEue8viexc3xfKvt7bdJnQY/H1eA==
X-Received: by 2002:a50:d659:0:b0:572:1625:ae99 with SMTP id
 c25-20020a50d659000000b005721625ae99mr5901631edj.31.1714981902993; 
 Mon, 06 May 2024 00:51:42 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 fk4-20020a056402398400b005701eaa2023sm4909102edb.72.2024.05.06.00.51.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/46] configs: list "implied" device groups in the default
 configs
Date: Mon,  6 May 2024 09:50:45 +0200
Message-ID: <20240506075125.8238-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Match the optional device groups to what is actually included in
the config-devices.mak files.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/arm-softmmu/default.mak         | 2 ++
 configs/devices/loongarch64-softmmu/default.mak | 3 +++
 configs/devices/or1k-softmmu/default.mak        | 4 ++++
 configs/devices/ppc-softmmu/default.mak         | 4 ++++
 configs/devices/riscv32-softmmu/default.mak     | 4 ++--
 configs/devices/riscv64-softmmu/default.mak     | 4 ++--
 configs/devices/xtensa-softmmu/default.mak      | 4 ++++
 7 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index 6ee31bc1ab9..c1cfb3bcf75 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -1,5 +1,7 @@
 # Default configuration for arm-softmmu
 
+# Uncomment the following lines to disable these optional devices:
+# CONFIG_I2C_DEVICES=n
 # CONFIG_PCI_DEVICES=n
 # CONFIG_TEST_DEVICES=n
 
diff --git a/configs/devices/loongarch64-softmmu/default.mak b/configs/devices/loongarch64-softmmu/default.mak
index 928bc117ef7..0893112b81d 100644
--- a/configs/devices/loongarch64-softmmu/default.mak
+++ b/configs/devices/loongarch64-softmmu/default.mak
@@ -1,3 +1,6 @@
 # Default configuration for loongarch64-softmmu
 
+# Uncomment the following lines to disable these optional devices:
+# CONFIG_PCI_DEVICES=n
+
 CONFIG_LOONGARCH_VIRT=y
diff --git a/configs/devices/or1k-softmmu/default.mak b/configs/devices/or1k-softmmu/default.mak
index 89c39e31237..3aecdf9d738 100644
--- a/configs/devices/or1k-softmmu/default.mak
+++ b/configs/devices/or1k-softmmu/default.mak
@@ -1,5 +1,9 @@
 # Default configuration for or1k-softmmu
 
+# Uncomment the following lines to disable these optional devices:
+# CONFIG_PCI_DEVICES=n
+# CONFIG_TEST_DEVICES=n
+
 # Boards:
 #
 CONFIG_OR1K_SIM=y
diff --git a/configs/devices/ppc-softmmu/default.mak b/configs/devices/ppc-softmmu/default.mak
index b85fd2bcd71..3061b26749a 100644
--- a/configs/devices/ppc-softmmu/default.mak
+++ b/configs/devices/ppc-softmmu/default.mak
@@ -1,5 +1,9 @@
 # Default configuration for ppc-softmmu
 
+# Uncomment the following lines to disable these optional devices:
+# CONFIG_PCI_DEVICES=n
+# CONFIG_TEST_DEVICES=n
+
 # For embedded PPCs:
 CONFIG_E500PLAT=y
 CONFIG_MPC8544DS=y
diff --git a/configs/devices/riscv32-softmmu/default.mak b/configs/devices/riscv32-softmmu/default.mak
index 94a236c9c25..07e4fd26df3 100644
--- a/configs/devices/riscv32-softmmu/default.mak
+++ b/configs/devices/riscv32-softmmu/default.mak
@@ -1,8 +1,8 @@
 # Default configuration for riscv32-softmmu
 
 # Uncomment the following lines to disable these optional devices:
-#
-#CONFIG_PCI_DEVICES=n
+# CONFIG_PCI_DEVICES=n
+# CONFIG_TEST_DEVICES=n
 
 # Boards:
 #
diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
index 3f680594484..221963d4c5c 100644
--- a/configs/devices/riscv64-softmmu/default.mak
+++ b/configs/devices/riscv64-softmmu/default.mak
@@ -1,8 +1,8 @@
 # Default configuration for riscv64-softmmu
 
 # Uncomment the following lines to disable these optional devices:
-#
-#CONFIG_PCI_DEVICES=n
+# CONFIG_PCI_DEVICES=n
+# CONFIG_TEST_DEVICES=n
 
 # Boards:
 #
diff --git a/configs/devices/xtensa-softmmu/default.mak b/configs/devices/xtensa-softmmu/default.mak
index 49e4c9da88c..f650cad7609 100644
--- a/configs/devices/xtensa-softmmu/default.mak
+++ b/configs/devices/xtensa-softmmu/default.mak
@@ -1,5 +1,9 @@
 # Default configuration for Xtensa
 
+# Uncomment the following lines to disable these optional devices:
+#
+#CONFIG_PCI_DEVICES=n
+
 # Boards:
 #
 CONFIG_XTENSA_SIM=y
-- 
2.44.0


