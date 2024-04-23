Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DB0C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG0z-0005Cr-Pi; Tue, 23 Apr 2024 09:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0w-0005CO-Pq
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0u-0001z0-Ex
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wSgDt6YU7vtcJ/Iy2yUD2TBUH68ZAHXi4ppwE8X5krc=;
 b=IIsjWsMP/dvm97aw+WatR3cvdn2briaG70Vt00whDBaSNQSdMqcS235OyeKc4TQcghZUpp
 Dq7HM1FY5/YOMpnmLEq3aEYIy+mKZJUtq951AY0VzCjeFt+HbsrT513EWrbO6FuspUReO3
 YMWRU60i9b2cEl3xoZu3e4JU8K6QRm4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-m1SgMh7LN8-2NPtNvAxdvA-1; Tue, 23 Apr 2024 09:16:46 -0400
X-MC-Unique: m1SgMh7LN8-2NPtNvAxdvA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a559bc02601so199354466b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878205; x=1714483005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wSgDt6YU7vtcJ/Iy2yUD2TBUH68ZAHXi4ppwE8X5krc=;
 b=eS+QJ6nzHELds6A1rFeKz1n4ZwQmzUeiAmrZm7VPg2Qb8qv/9EvlIN9e5gE9r58VTa
 ltS3UPbK8MVKVsoJNgnAcvP6IrL+Mgm2ksk7lepauHo6a1m+frjYGV7X5GzUXV36APzW
 v0v4qmXp0Pm36Sv7aQYYUg861daATL2acn3Qk7+5Vjcssj7hUMbNJCmq7o+QiLbvErkl
 Uzc5sULTiTaJ2EuvmfYbYFRxTwoiZH5NH2XDglTHrcK2d+S3jPkoR71EEePcbqzybFAF
 a/BN03//xlE9MyvMYYTTlNAZTP7bufTO8Jj8QynYhfKW5EerGj2wmwbm8silmbDncozL
 1sKw==
X-Gm-Message-State: AOJu0YyXtEE0lf8YZ9Lfugaq03fDaxMTV2Bjp5vy9qPkpVdojF+mDI/9
 SZhL7UeQCkeAuXMhDNBrz7+wn6YhZ/HO7NNG0uFQux9OZAuNK9Xexp9pQyoRiBZgRZ6hFzRvwiQ
 LMBguJk9ClrN4Y3143CSTuKMvY0KcW1YfmIQ1X0dDbQnCzayk3GHRE/LEbONaLAW5LYagfS2J6g
 hvxcH0cI7QG+zxoGnqSnfLJ32SKYE76HFM+Rca
X-Received: by 2002:a17:906:a386:b0:a55:b25d:9c9e with SMTP id
 k6-20020a170906a38600b00a55b25d9c9emr4930394ejz.74.1713878204863; 
 Tue, 23 Apr 2024 06:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbluqFc83GyIpO8+qJYoHLN8MN+C368MVGe2XsNZ7IDo+k0kQUV7y71thn8us+Qy+mZQTgZA==
X-Received: by 2002:a17:906:a386:b0:a55:b25d:9c9e with SMTP id
 k6-20020a170906a38600b00a55b25d9c9emr4930379ejz.74.1713878204589; 
 Tue, 23 Apr 2024 06:16:44 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a170906339300b00a5592a12fe2sm4796324eja.128.2024.04.23.06.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 11/22] meson: make target endianneess available to Kconfig
Date: Tue, 23 Apr 2024 15:16:01 +0200
Message-ID: <20240423131612.28362-12-pbonzini@redhat.com>
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
MIPS boards may only be available for big-endian or only for
little-endian emulators, add a symbol so that this can be described
with a "depends on" clause.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build    | 12 +++++++-----
 target/Kconfig |  3 +++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 9af60550753..9c4fb027853 100644
--- a/meson.build
+++ b/meson.build
@@ -3037,7 +3037,7 @@ foreach target : target_dirs
     }
   endif
 
-  accel_kconfig = []
+  target_kconfig = []
   foreach sym: accelerators
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
       config_target += { sym: 'y' }
@@ -3047,10 +3047,10 @@ foreach target : target_dirs
       else
         config_target += { 'CONFIG_TCG_BUILTIN': 'y' }
       endif
-      accel_kconfig += [ sym + '=y' ]
+      target_kconfig += [ sym + '=y' ]
     endif
   endforeach
-  if accel_kconfig.length() == 0
+  if target_kconfig.length() == 0
     if default_targets
       continue
     endif
@@ -3110,6 +3110,9 @@ foreach target : target_dirs
                                                configuration: config_target_data)}
 
   if target.endswith('-softmmu')
+    target_kconfig += 'CONFIG_' + config_target['TARGET_ARCH'].to_upper() + '=y'
+    target_kconfig += 'CONFIG_TARGET_BIG_ENDIAN=' + config_target['TARGET_BIG_ENDIAN']
+
     config_input = meson.get_external_property(target, 'default')
     config_devices_mak = target + '-config-devices.mak'
     config_devices_mak = configure_file(
@@ -3120,8 +3123,7 @@ foreach target : target_dirs
       command: [minikconf,
                 get_option('default_devices') ? '--defconfig' : '--allnoconfig',
                 config_devices_mak, '@DEPFILE@', '@INPUT@',
-                host_kconfig, accel_kconfig,
-                'CONFIG_' + config_target['TARGET_ARCH'].to_upper() + '=y'])
+                host_kconfig, target_kconfig])
 
     config_devices_data = configuration_data()
     config_devices = keyval.load(config_devices_mak)
diff --git a/target/Kconfig b/target/Kconfig
index 83da0bd2938..afc00dea30c 100644
--- a/target/Kconfig
+++ b/target/Kconfig
@@ -18,3 +18,6 @@ source sh4/Kconfig
 source sparc/Kconfig
 source tricore/Kconfig
 source xtensa/Kconfig
+
+config TARGET_BIG_ENDIAN
+    bool
-- 
2.44.0


