Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7493C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG1c-0005oN-2T; Tue, 23 Apr 2024 09:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG1G-0005Mz-NT
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG1E-000266-V1
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ae08np63GuCGS29+G5r73docyIdCs5Sqmj6L0PV170=;
 b=BHaF6fT19FIG6TBwbUZwFI+Vgz0xmtzemJJoMXlT4bDidfv1ikWHg6bFS+WMlf6aX6s6nr
 +E/XYFUtcBdnhazInPnl1Q3wkseV82TGcqTs6g6GvH3lDa4rETjZcW4o9EQGBZ6z8gZW9b
 G+sqdcacPHqF6EB8j4FjSkoktCLEsbI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-lAbQWvfpNnCoUhHW5JjlnA-1; Tue, 23 Apr 2024 09:17:07 -0400
X-MC-Unique: lAbQWvfpNnCoUhHW5JjlnA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a556121c01aso292427766b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878225; x=1714483025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ae08np63GuCGS29+G5r73docyIdCs5Sqmj6L0PV170=;
 b=vy/zWvJzW7eFAlpLJEKhNRTbT+yv2+RVAE5UEfJatF4OlqvilmBslsC8m8x4mg6ncG
 yoPNoTlDZvmN7fIvX3LvGW8iw9Uj/eleJpbvvAbf6SI/ZGtiM0g4Fpd9UBgF0oRe/6xY
 icxLpUUO/bVe+jztSG9suS/NlMIRdkyL9zfJEWvyDZ4c1JXmmSiIo7z78L+bSsvv/BoQ
 LeKcq1Hok1U1YirhPq28V2R3PcFBdH4nuVUTM6AyPGLfuGX7WmcceuBuYPQ52QGZb79a
 OWBdOKV3kgn8FH5Fpazx+AfvI9pmk/i4HcB91Ck9mNzSng+lxHa95JGRy0rAHNm0IFpZ
 N2eA==
X-Gm-Message-State: AOJu0YzRqvi/S3EWu6CambfD5JQHOGHsq8C1kIVn6E0JutGknzXq/1AB
 +5Y6BXaVoK/YJOHqLj9PNxBVjpTYloFoSUA/rSmXXRaaP3e87g80kIF8A1Hhb1X5CqeIpGryCdG
 v4kDbdz0lvz9rOJhgwtdIjNM567v6wt6L8OTQe2bZYm3dxCO7QtvCAjr2hdvhQu6TkpmZzNeGCQ
 eiFUMrKQ7p14rs3gHHaJeQnERqS08RvLBORDzR
X-Received: by 2002:a17:907:3ea6:b0:a51:8145:6877 with SMTP id
 hs38-20020a1709073ea600b00a5181456877mr9787476ejc.37.1713878225130; 
 Tue, 23 Apr 2024 06:17:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9JET7dwBQGPvazKl50jzX4vyX1BvrKmzuRtXhPbqRyf7OqMZEYgDk5hwWzdHzMhNze5XJyA==
X-Received: by 2002:a17:907:3ea6:b0:a51:8145:6877 with SMTP id
 hs38-20020a1709073ea600b00a5181456877mr9787462ejc.37.1713878224810; 
 Tue, 23 Apr 2024 06:17:04 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a170906315200b00a55b0d2f204sm2959051eje.44.2024.04.23.06.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:17:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 20/22] sparc: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:16:10 +0200
Message-ID: <20240423131612.28362-21-pbonzini@redhat.com>
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
Continue with SPARC and SPARC64.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/sparc-softmmu/default.mak   | 7 +++----
 configs/devices/sparc64-softmmu/default.mak | 7 +++----
 hw/sparc/Kconfig                            | 4 ++++
 hw/sparc64/Kconfig                          | 4 ++++
 4 files changed, 14 insertions(+), 8 deletions(-)

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


