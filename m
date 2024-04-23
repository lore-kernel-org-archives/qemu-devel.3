Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A567C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG0b-00057Z-U4; Tue, 23 Apr 2024 09:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0X-00056h-HJ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0U-0001sE-Ud
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NaFhvDsV4aiOiczV5OFhsyZUhVEImpMxri4NWO+aWMM=;
 b=dLjnewz4tKWkLXuM8oUdXtvwQyidyJotc3JNqNWRiNjpdL+fMkW/NzYPH/kRkwPgrpzni6
 8mdBLKMacMoak/gjxloJfQM1ms0hNCD2HDUOnZqMHGZn0PpO2Yu+5hrmSvNr/xmK6vtweS
 gYV7ymNxTsXxo+Ui6hvMQ3S3uz6Vq6Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-o-1-S74vOkOAGjZ7ikoqFA-1; Tue, 23 Apr 2024 09:16:19 -0400
X-MC-Unique: o-1-S74vOkOAGjZ7ikoqFA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a5199cc13b2so533891866b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878178; x=1714482978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NaFhvDsV4aiOiczV5OFhsyZUhVEImpMxri4NWO+aWMM=;
 b=AjdhB2yS9OEBD4IW+IlhMZF3ZzjUS+RCvz2uUHSTjSFewXX//060ZP3VucjvAjLFRN
 9fBcFcEUMircTdjkjIvQN0xjEhonV2iXWvnOcWwvRgHp+qWuf/Di5A44Zin+VxlGH7w6
 tDWOfKeStdqv1lvJ6S20gCVJOoKyxgMFarurFv0rZBT5fHO6MyvAW9HKkdBM2OKvRCPW
 3Wds2ECcLT0HGLkqkFrxLPQM82aKpm+b0KvKWc0gBjH5DPSxkO4CZJcyFcCD7vAocVjz
 SNiUt84IomLRV77jy4+DkxHQctxqyZvz2/JERij2F+MO5syh7UYN+OYugO9HTtSpsXSJ
 e1Lg==
X-Gm-Message-State: AOJu0YzhAre0Vyet3c1MTMzmnV1hRMmrlTThwpaGc1xMgiwwsmnJAXKd
 /zGygOJJnZ/XpigWsM35lgmJ/I3O5zQp30c3eTYEIbBCmcdRspNx4/sy6s7uFCCTdG/536T5Gjg
 zR9FcP8IzVtdhelgLy6wvm8slxWjYzIXgcfXWz8zxEBlEoy/cM+znkFrTGFkH+g4FfgOKpKilKF
 4nQzR3vXA09f0yMYKuovhB7pogC5LFVUyQzXQi
X-Received: by 2002:a17:907:7e9a:b0:a58:8395:c661 with SMTP id
 qb26-20020a1709077e9a00b00a588395c661mr1434667ejc.13.1713878178338; 
 Tue, 23 Apr 2024 06:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJjdOKD5TGni2qV7iJaxCuuHaENJpFD6d3pl/eM8uSw9KCbkMR2PJImExkLVYEEkjMzntTEw==
X-Received: by 2002:a17:907:7e9a:b0:a58:8395:c661 with SMTP id
 qb26-20020a1709077e9a00b00a588395c661mr1434629ejc.13.1713878177909; 
 Tue, 23 Apr 2024 06:16:17 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a1709063ac200b00a4e1a9e1ab4sm7031994ejd.157.2024.04.23.06.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 01/22] configs: list "implied" device groups in the default
 configs
Date: Tue, 23 Apr 2024 15:15:51 +0200
Message-ID: <20240423131612.28362-2-pbonzini@redhat.com>
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


