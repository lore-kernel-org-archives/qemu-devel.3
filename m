Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53EAC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvc-0008Gt-06; Fri, 30 May 2025 03:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvY-0008GM-AJ
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvW-0006ou-F8
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XuGM+7MdwY4mWdwDSJvhZdiW4JgFJnWIC6vsozdV364=;
 b=ZqU4c0swFqon/lic2dGmYptq5XJWwY1DRRe6Dvp85C5yTrZZtfG6WUxO9tojBXNXpafcXX
 U3HSTw3eZqWKmFmYFaZK2nofgoeWOSj35viRsllCFniL+bplsKBs6OtBswn4WasqUDqNbd
 eujBz0HiAmn+GNMSiXjltTbFt/lSKzc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-Pz0UYwPXNmK5Fp2TaM22TQ-1; Fri, 30 May 2025 03:13:12 -0400
X-MC-Unique: Pz0UYwPXNmK5Fp2TaM22TQ-1
X-Mimecast-MFC-AGG-ID: Pz0UYwPXNmK5Fp2TaM22TQ_1748589191
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-603f71f6432so1477261a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589190; x=1749193990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XuGM+7MdwY4mWdwDSJvhZdiW4JgFJnWIC6vsozdV364=;
 b=f9ekO6LHGG5aWfBen97+bMzJP80k5PcnHWKXBl8WJPSTYMBRH97NL7Eaq4OvsndMdU
 p2goBsMPAxQnhlpBnRSi+1fijh1n46UNQim681o5cO9kvxh+/JO6dwYKOcYqKuU55l7D
 YfQ/Uxeofgx5kwAfJ0i5kaL2aqxmb9bo2i+T1B3eiEvgBMBlhFb+lJKH36xQ/y/RGo5C
 D7rFISViMuLL93HFQ13+V7QoHDwkDPXN9xrSnnu+FbtHfCIF069Db8EM/7FZKPfc4gAJ
 vTmTXM2MFtQr0fR/U7TuL/ORnNcXHzpHIDN7MpRv7fnYLhpdbAvPagI76nOZLGu5qoKJ
 wlfQ==
X-Gm-Message-State: AOJu0Yw+cr4eV4OnltgsxMgCk/GzM9O2YNw5jJ/W//7GgIpQ0bb0xcao
 YcKq5NkOVuIQ4X4BJ9Bf4tP9k5k2SndA+WaBYN4fW86i+N+I3JE4sNMtKLtUNsIW5t6XB7NeqMz
 yovF8r2MDTmL5t5ltp4Tfl5uqh+SiGRSFdFYdTnQq9rb2KHDI2hsPBRIw2rzWCROX1C82dUY8DU
 sGk21Uj8x4JOMlgUaLeSPphjRPi/JSWhFTvM+aHz+B
X-Gm-Gg: ASbGncvjtgCTgYB6O2fYWLTaFaVFvf3UL+xCR4+YeHEjbxkuK7cz325HdFX9uNeE7Tx
 ss38qqz69GxOAbHnLwpjevJM5JLs3epEwPSXRheDcRQgnfQfh0FwuI7hZz8x50sYVhO+6RdmrtT
 Sc0U0VwkXTVw2M6bjHJx+W0bgiQBQB/EqbzYlV1TsPp143qdEp370q7fhi5wfpxKA8iYMF+x5Ao
 MxXoUi++XlQEPKEZbpmEIGct+U4fXFsW69XpefBPnN8WFfhFLbsxB+BeX9uiYhacHi0xTUhTQzU
 ByIsNiCLgZUsGg==
X-Received: by 2002:a05:6402:3514:b0:604:5a44:a5c4 with SMTP id
 4fb4d7f45d1cf-6057c60519bmr1055176a12.16.1748589189868; 
 Fri, 30 May 2025 00:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+oN78ZHS1NBeCBufuPwlffDfjXFfh1/HpuFsGAHJTdUrH+GPfe7Ptsy7/TiPacuVJOR2aIQ==
X-Received: by 2002:a05:6402:3514:b0:604:5a44:a5c4 with SMTP id
 4fb4d7f45d1cf-6057c60519bmr1055155a12.16.1748589189372; 
 Fri, 30 May 2025 00:13:09 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c31885sm1185639a12.10.2025.05.30.00.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/77] meson: merge hw_common_arch in target_common_system_arch
Date: Fri, 30 May 2025 09:11:37 +0200
Message-ID: <20250530071250.2050910-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

No need to keep two different libraries, as both are compiled with exact
same flags. As well, rename target common libraries to common_{arch} and
system_{arch}, to follow what exists for common and system libraries.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250521223414.248276-8-pierrick.bouvier@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index 1c9f1aa91e7..f614d112192 100644
--- a/meson.build
+++ b/meson.build
@@ -4101,7 +4101,6 @@ common_all = static_library('common',
                             dependencies: common_ss.all_dependencies())
 
 # construct common libraries per base architecture
-hw_common_arch_libs = {}
 target_common_arch_libs = {}
 target_common_system_arch_libs = {}
 foreach target_base_arch, config_base_arch : config_base_arch_mak
@@ -4130,22 +4129,10 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
   target_c_args = ['-DCPU_DEFS_H']
   target_system_c_args = target_c_args + ['-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU']
 
-  if target_base_arch in hw_common_arch
-    src = hw_common_arch[target_base_arch]
-    lib = static_library(
-      'hw_' + target_base_arch,
-      build_by_default: false,
-      sources: src.all_sources() + genh,
-      include_directories: inc,
-      c_args: target_system_c_args,
-      dependencies: src.all_dependencies() + common_deps + system_deps)
-    hw_common_arch_libs += {target_base_arch: lib}
-  endif
-
   if target_base_arch in target_common_arch
     src = target_common_arch[target_base_arch]
     lib = static_library(
-      'target_' + target_base_arch,
+      'common_' + target_base_arch,
       build_by_default: false,
       sources: src.all_sources() + genh,
       include_directories: inc,
@@ -4155,10 +4142,20 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
     target_common_arch_libs += {target_base_arch: lib}
   endif
 
+  # merge hw_common_arch in target_common_system_arch
+  if target_base_arch in hw_common_arch
+    hw_src = hw_common_arch[target_base_arch]
+    if target_base_arch in target_common_system_arch
+      target_common_system_arch[target_base_arch].add_all(hw_src)
+    else
+      target_common_system_arch += {target_base_arch: hw_src}
+    endif
+  endif
+
   if target_base_arch in target_common_system_arch
     src = target_common_system_arch[target_base_arch]
     lib = static_library(
-      'target_system_' + target_base_arch,
+      'system_' + target_base_arch,
       build_by_default: false,
       sources: src.all_sources() + genh,
       include_directories: inc,
@@ -4351,12 +4348,6 @@ foreach target : target_dirs
     objects += libuser.extract_objects(src.sources())
     arch_deps += src.dependencies()
   endif
-  if target_type == 'system' and target_base_arch in hw_common_arch_libs
-    src = hw_common_arch[target_base_arch].apply(config_target, strict: false)
-    lib = hw_common_arch_libs[target_base_arch]
-    objects += lib.extract_objects(src.sources())
-    arch_deps += src.dependencies()
-  endif
   if target_type == 'system' and target_base_arch in target_common_system_arch_libs
     src = target_common_system_arch[target_base_arch].apply(config_target, strict: false)
     lib = target_common_system_arch_libs[target_base_arch]
-- 
2.49.0


