Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E60BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9E-00068E-7P; Mon, 06 May 2024 03:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8v-0005qT-OC
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8t-0001eK-S8
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0edKtfywX3SnvAhiP6Z2wG4KJKnWgcP/HKkK2g/aBA=;
 b=YS8rZR4GSRwowVP4OHHMZ8KonboD+V6GKTFvb3R9D+xh9a5EcBbZNfTVQONfofR10FX+Nn
 Q0+uf4Dkrp0uc8bQclKwB+UexmycRzorRQGBKZtntXvqq2SlO6SzcAMIX9Ts3SvL4xmrep
 eW5WKNNj5aakADUYsMf66GAmoPunhPE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-jhNOLEpcNpi9j3l971kqyg-1; Mon, 06 May 2024 03:52:09 -0400
X-MC-Unique: jhNOLEpcNpi9j3l971kqyg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59c2583f0bso51903866b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981927; x=1715586727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0edKtfywX3SnvAhiP6Z2wG4KJKnWgcP/HKkK2g/aBA=;
 b=vms090WsuHbx+5vtPpy9qgGv72WivzXSttQ3VwgY39lhKA62sEbs/mpIdF70sTdfZw
 iSRgrAfAf4zMVZIVGypHo049gVjrGtAZW0Re4cqYR+5ViI0vQFkHuMY9m/5lAUe5EIo1
 X4hxbTmiw1+1IKE3OhaD2WA8pljGloS/tjNJ/7kItuH+0oYsMFxQIw+C6sEZGKC8h1Hz
 nTCWCy4XC+OiirpSfO7urqv2wBOERaTk8FxF3uOufHB/sxczLFNXuWGAVc5cBSAc1qQm
 DqfNg2UuAvdMD2j34qtaK9+kWHwbYpF6vUuSRChLGY8jAvSPHCueN2disidvv0eHfjL0
 9JmA==
X-Gm-Message-State: AOJu0YyRloXeQii5of0x2AETawGprXsbQVybUxl+T4t++cmmmq9Bhr/Y
 NpCTAmHgE/CbIHOj9RKsdQBiJI++CqUXUVhum2u2w7S7a3/rQGppLKzmTRfZvDQxW+NczhQRkv1
 4C4V9lPjK1rbBufDqDXqu6aypo+GUh5LR2jl+5PJec6VZLQb4lYCAhR5MFyV1w5PJnynqoSb/il
 9L9AXk2qssjG4sxe5mt0gxe0xwV+3T78xcNeWg
X-Received: by 2002:a17:907:980d:b0:a59:cfab:50d with SMTP id
 ji13-20020a170907980d00b00a59cfab050dmr1272069ejc.2.1714981927535; 
 Mon, 06 May 2024 00:52:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZS2Qrjc+l3+yBbOFnIp+kZcWbkUWQE38GaQKhMZOH0GQtGvj7bV5hrVRu7Xe0bfTCJjvFSw==
X-Received: by 2002:a17:907:980d:b0:a59:cfab:50d with SMTP id
 ji13-20020a170907980d00b00a59cfab050dmr1272055ejc.2.1714981927177; 
 Mon, 06 May 2024 00:52:07 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090652d800b00a59aa17f23fsm2573863ejn.203.2024.05.06.00.52.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/46] meson: make target endianneess available to Kconfig
Date: Mon,  6 May 2024 09:50:55 +0200
Message-ID: <20240506075125.8238-17-pbonzini@redhat.com>
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
index 5db2dbc12ec..43da4923721 100644
--- a/meson.build
+++ b/meson.build
@@ -3005,7 +3005,7 @@ foreach target : target_dirs
     }
   endif
 
-  accel_kconfig = []
+  target_kconfig = []
   foreach sym: accelerators
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
       config_target += { sym: 'y' }
@@ -3015,10 +3015,10 @@ foreach target : target_dirs
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
@@ -3078,6 +3078,9 @@ foreach target : target_dirs
                                                configuration: config_target_data)}
 
   if target.endswith('-softmmu')
+    target_kconfig += 'CONFIG_' + config_target['TARGET_ARCH'].to_upper() + '=y'
+    target_kconfig += 'CONFIG_TARGET_BIG_ENDIAN=' + config_target['TARGET_BIG_ENDIAN']
+
     config_input = meson.get_external_property(target, 'default')
     config_devices_mak = target + '-config-devices.mak'
     config_devices_mak = configure_file(
@@ -3088,8 +3091,7 @@ foreach target : target_dirs
       command: [minikconf,
                 get_option('default_devices') ? '--defconfig' : '--allnoconfig',
                 config_devices_mak, '@DEPFILE@', '@INPUT@',
-                host_kconfig, accel_kconfig,
-                'CONFIG_' + config_target['TARGET_ARCH'].to_upper() + '=y'])
+                host_kconfig, target_kconfig])
 
     config_devices_data = configuration_data()
     config_devices = keyval.load(config_devices_mak)
diff --git a/target/Kconfig b/target/Kconfig
index 5275a93ad02..7f64112e9e7 100644
--- a/target/Kconfig
+++ b/target/Kconfig
@@ -17,3 +17,6 @@ source sh4/Kconfig
 source sparc/Kconfig
 source tricore/Kconfig
 source xtensa/Kconfig
+
+config TARGET_BIG_ENDIAN
+    bool
-- 
2.44.0


