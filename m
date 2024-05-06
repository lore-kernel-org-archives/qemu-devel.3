Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B868C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9P-0006VA-8z; Mon, 06 May 2024 03:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9J-0006IN-Di
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9D-0001iJ-PY
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hA/8UtUIcMrHoVNho/dJKKg/niTLU5xv9W0wZ+L1SHs=;
 b=LRp7wqRd/c0wOkdyv8KkvtZMCRxwY54fZIGzxQ5TJfzWAKPqtuXCwIcSD2brbMMaSLPdDW
 nP9P6OEuqBSOk0UgLCB0BZuWWcHn9S4BZ+zKJTmQZlD4hkzFXyMUu1qNfyz3K6rqXsPXQC
 EYVH424RBZ6GjXUkTrwZPCH3vHyvBZc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-gTbeYtNwOtaVocA5qAj1rA-1; Mon, 06 May 2024 03:52:28 -0400
X-MC-Unique: gTbeYtNwOtaVocA5qAj1rA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59c7586f7cso47850966b.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981946; x=1715586746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hA/8UtUIcMrHoVNho/dJKKg/niTLU5xv9W0wZ+L1SHs=;
 b=nK2eq7DsaeOq/YqkRIjP+loQHWnE2im/lX00bDbDguXHwXZZGx/QKb2hGc13RkZLqE
 y4RtylsOQeXIEkqVL621OqgPoq88odlXCsPiDypyU76OxOYELfB4bzErFDZJ5ig9DPWJ
 nwbbwr+630FNMlf+ampZ6HuMGzBJdj/D1IaE5scQt+8rrCBPyqGKTyVNW8JSXhnSMuE2
 /+GkhnRVHAYQCascc+0KadSMKlYXWy4BN4BSMYGdVNix7HTa8ju/VCsA8C22M6rheEED
 Sk9kKt5pukx108NvVXr7JNeiB+sKyfTFusJYlB+exL0m7r08AtfkweAu6/y/TpL6hU7R
 YrMA==
X-Gm-Message-State: AOJu0YzW0bGlOK1wp/8V6pfwLkRcqff+i9HhAGN+qZ3Z9airTjLzmPYa
 O05N0FZ/pgdhvdLJtnp9EkDflwPowzlIkQURN6g78XAeGMyhwGMS/LweaHloJzA/nOrRNNhsHgr
 WPEjX/XLZdeSUqPe13leqDSiPzxKxFtxCtA4zCfTeAAz0tlpo0HpOM5HEqnWhQRQ4sNVfzjIW6O
 e2CdrR5lccKa/lq0+XFpZzFAl5Xg2WLrdaaG80
X-Received: by 2002:a17:907:7da2:b0:a59:b784:ced5 with SMTP id
 oz34-20020a1709077da200b00a59b784ced5mr3104776ejc.67.1714981946716; 
 Mon, 06 May 2024 00:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6/zJExYOzfJK/Bdf+yc/FAx5Rhgrju58bzmjZYOwZ2VzbBMnC7H4xkxYmMXOysKDFgtUr0Q==
X-Received: by 2002:a17:907:7da2:b0:a59:b784:ced5 with SMTP id
 oz34-20020a1709077da200b00a59b784ced5mr3104764ejc.67.1714981946271; 
 Mon, 06 May 2024 00:52:26 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 em19-20020a170907289300b00a59c2da005csm1670932ejc.215.2024.05.06.00.52.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/46] sparc: switch boards to "default y"
Date: Mon,  6 May 2024 09:51:03 +0200
Message-ID: <20240506075125.8238-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Continue with SPARC and SPARC64.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/sparc-softmmu/default.mak   | 7 +++----
 configs/devices/sparc64-softmmu/default.mak | 7 +++----
 .gitlab-ci.d/buildtest.yml                  | 5 +++--
 hw/sparc/Kconfig                            | 4 ++++
 hw/sparc64/Kconfig                          | 4 ++++
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/configs/devices/sparc-softmmu/default.mak b/configs/devices/sparc-softmmu/default.mak
index ee852181151..87668fda5ea 100644
--- a/configs/devices/sparc-softmmu/default.mak
+++ b/configs/devices/sparc-softmmu/default.mak
@@ -5,7 +5,6 @@
 #CONFIG_TCX=n
 #CONFIG_CG3=n
 
-# Boards:
-#
-CONFIG_SUN4M=y
-CONFIG_LEON3=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_SUN4M=n
+# CONFIG_LEON3=n
diff --git a/configs/devices/sparc64-softmmu/default.mak b/configs/devices/sparc64-softmmu/default.mak
index e50030a229c..fa82f39a200 100644
--- a/configs/devices/sparc64-softmmu/default.mak
+++ b/configs/devices/sparc64-softmmu/default.mak
@@ -6,7 +6,6 @@
 #CONFIG_SUNHME=n
 #CONFIG_TEST_DEVICES=n
 
-# Boards:
-#
-CONFIG_SUN4U=y
-CONFIG_NIAGARA=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_SUN4U=n
+# CONFIG_NIAGARA=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index fd665931847..5d2ce161187 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -665,8 +665,9 @@ build-without-defaults:
       --disable-qom-cast-debug
       --disable-strip
     TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
-      mips-softmmu mips64-softmmu mipsel-softmmu
-      sparc64-softmmu hexagon-linux-user i386-linux-user s390x-linux-user
+      mips-softmmu mips64-softmmu mipsel-softmmu sparc-softmmu
+      sparc64-softmmu
+      hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
 
 build-libvhost-user:
diff --git a/hw/sparc/Kconfig b/hw/sparc/Kconfig
index 79d58beb7a6..3cc165dbfb7 100644
--- a/hw/sparc/Kconfig
+++ b/hw/sparc/Kconfig
@@ -1,5 +1,7 @@
 config SUN4M
     bool
+    default y
+    depends on SPARC && !SPARC64
     imply TCX
     imply CG3
     select CS4231
@@ -18,6 +20,8 @@ config SUN4M
 
 config LEON3
     bool
+    default y
+    depends on SPARC && !SPARC64
     select GRLIB
 
 config GRLIB
diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
index 7e557ad17b0..3b948a22907 100644
--- a/hw/sparc64/Kconfig
+++ b/hw/sparc64/Kconfig
@@ -1,5 +1,7 @@
 config SUN4U
     bool
+    default y
+    depends on SPARC64
     imply PCI_DEVICES
     imply SUNHME
     imply TEST_DEVICES
@@ -16,6 +18,8 @@ config SUN4U
 
 config NIAGARA
     bool
+    default y
+    depends on SPARC64
     select EMPTY_SLOT
     select SUN4V_RTC
     select UNIMP
-- 
2.44.0


