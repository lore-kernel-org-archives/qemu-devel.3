Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EF6C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhat3-0000jJ-17; Sun, 18 Jan 2026 17:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhasr-0000Yx-Ck
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:34 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaso-0000Sl-Cc
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:31 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so24380215ad.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773869; x=1769378669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZftrpeMp67H21abPmjnOQ3bq0oi0EoCBPPE1IUpN8c=;
 b=JEiyebqWWxsfYcFELjZfeFrj6Ef9zL0pkRBzsa3+9FuokQ0VJcJxpeZ6UjlJxaD59N
 /bVwm2t8zu9tGJF4SAPoaxM3XRkqmm3QN5HctJswEyXcqm/pAxBuAr7/keaDd13h9s87
 xtiZ7t38Qzm9cLYdpPgbsRG4VJbRr2XVGq4EiPfxMOwcYsmkBXy8ejwwuSQQBlqkpMU0
 gZ5BXb6gwn+DGdJSxYs2ZDyjV/cw1hdrQ6/Enwf71+r4H+9N2y/a1pCb34gr77nNK+1s
 C4rhnqgfyo82pZg+iNqLJxfMgA5Iz2SwDUN3xxeDbr9NfNznHvWXbefcdGWOgH4Q3spp
 b8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773869; x=1769378669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ZftrpeMp67H21abPmjnOQ3bq0oi0EoCBPPE1IUpN8c=;
 b=iUZPstyzIwDd5WqtVHWaZsOeDTtrejJSApyNQ+wtt0yPhFhz3C13bfo/kGAKdMrH8t
 8QSndt7AKv/Cvj5csHJmigtvr+e6nrZ5niVgo2sg0BJIuxbO6sRQuYqj9OPwPAoCMSeA
 jNVjjokqRFlTXX7+Y4eA7DpmgEA65xAm+Eepu9vIlaIdIFHdamM13OCEz0avtJp7f+zx
 XWXIbhDAAshubSoRlUfUqDUqYBeZBDOWwb8zncUo1O5pxGwTVJ56cQhZWvDE52dg5F9x
 tcU4p31dgC1JW8hM7UvjFQTrOYmvnI+9ufm4Np775MWGbdeIrVCF0VaittM/LogiOV2v
 ZGXA==
X-Gm-Message-State: AOJu0YwUli+7IJZ4Ap1zH5QTs3mfcPGsuiUxJP7ot0wfcnWMKVriDEuP
 1OfB4OS7sQ48TyctqFVjbzPSuuvsrV0Aib1t2L51PttwX3uahPdGJmaz6hMzNw9SyeLcQPbK0B4
 hZICCK2xAnQ==
X-Gm-Gg: AY/fxX7rpqkftRxYs3hzOfCXdbzIri/KsZtf9k/aEvxY+glHZTykQpucUD2dLVR1sGr
 vEqxr/baiW3J6jP9lw+a5IsI0uzje+yFr7Bo2QI0HSKw1+Alff+xgbu+FYmgoI9k2RIVNIGs9hz
 Lb+7W3sS551dpO3Mnxf85HsFjJQ5Z8/VGeZSPZ0WADronLp23XY7HKTwWl+k7JGDH/XXd0Dte89
 kyujAMsaj1WKqoJbMju0uehSw1WXiJ+ACim35ZIZTSGdHI4OjVT0OfJzC/eVIPuPl0XN32YD/54
 wt4SuXPK5NOH4xKW6yz9v54vsE0uA0FjQLkVxiojjEH0HFksED3cKcaACoSm99GYp01Mz9+2HEt
 2XwptdKsOY9xxwJmgnUaBDdXxfUMQMl/6tKrtsH82090nD1ehYueJxDk9TcGkTC9pDnbR9Njw9D
 S/hxSIK1GyBHSZXH945eYBtljRWyMr
X-Received: by 2002:a17:903:2a8f:b0:2a1:3cd9:a739 with SMTP id
 d9443c01a7336-2a7189479e3mr84461795ad.43.1768773868602; 
 Sun, 18 Jan 2026 14:04:28 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:04:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 04/54] meson: Reject 32-bit hosts
Date: Mon, 19 Jan 2026 09:03:24 +1100
Message-ID: <20260118220414.8177-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

32-bit hosts have been deprecated since 10.0.
As the first step, disable any such at configuration time.
Further patches will remove the dead code.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/about/deprecated.rst       | 29 -----------------------------
 docs/about/removed-features.rst |  6 ++++++
 meson.build                     | 17 ++++-------------
 3 files changed, 10 insertions(+), 42 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7abb3dab59..88efa3aa80 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -186,28 +186,6 @@ maintain our cross-compilation CI tests of the architecture. As we no longer
 have CI coverage support may bitrot away before the deprecation process
 completes.
 
-System emulation on 32-bit x86 hosts (since 8.0)
-''''''''''''''''''''''''''''''''''''''''''''''''
-
-Support for 32-bit x86 host deployments is increasingly uncommon in mainstream
-OS distributions given the widespread availability of 64-bit x86 hardware.
-The QEMU project no longer considers 32-bit x86 support for system emulation to
-be an effective use of its limited resources, and thus intends to discontinue
-it. Since all recent x86 hardware from the past >10 years is capable of the
-64-bit x86 extensions, a corresponding 64-bit OS should be used instead.
-
-TCG Plugin support not enabled by default on 32-bit hosts (since 9.2)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-While it is still possible to enable TCG plugin support for 32-bit
-hosts there are a number of potential pitfalls when instrumenting
-64-bit guests. The plugin APIs typically pass most addresses as
-uint64_t but practices like encoding that address in a host pointer
-for passing as user-data will lose data. As most software analysis
-benefits from having plenty of host memory it seems reasonable to
-encourage users to use 64 bit builds of QEMU for analysis work
-whatever targets they are instrumenting.
-
 TCG Plugin support not enabled by default with TCI (since 9.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
@@ -216,13 +194,6 @@ is going to be so much slower it wouldn't make sense for any serious
 instrumentation. Due to implementation differences there will also be
 anomalies in things like memory instrumentation.
 
-32-bit host operating systems (since 10.0)
-''''''''''''''''''''''''''''''''''''''''''
-
-Keeping 32-bit host support alive is a substantial burden for the
-QEMU project.  Thus QEMU will in future drop the support for all
-32-bit host systems.
-
 System emulator CPUs
 --------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index e81d79da47..b0d7fa8813 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -572,6 +572,12 @@ like the ``akita`` or ``terrier``; it has been deprecated in the
 kernel since 2001. None of the board types QEMU supports need
 ``param_struct`` support, so this option has been removed.
 
+32-bit host operating systems (removed in 11.0)
+'''''''''''''''''''''''''''''''''''''''''''''''
+
+Keeping 32-bit host support alive was a substantial burden for the
+QEMU project.  Thus QEMU dropped all support for all 32-bit host systems.
+
 
 User-mode emulator command line arguments
 -----------------------------------------
diff --git a/meson.build b/meson.build
index 600c50007d..28f61be675 100644
--- a/meson.build
+++ b/meson.build
@@ -332,6 +332,10 @@ endif
 # Compiler flags #
 ##################
 
+if cc.sizeof('void *') < 8
+  error('QEMU requires a 64-bit CPU host architecture')
+endif
+
 foreach lang : all_languages
   compiler = meson.get_compiler(lang)
   if compiler.get_id() == 'gcc' and compiler.version().version_compare('>=7.4')
@@ -3247,9 +3251,6 @@ if host_os == 'windows'
   endif
 endif
 
-# Detect host pointer size for the target configuration loop.
-host_long_bits = cc.sizeof('void *') * 8
-
 # Detect if ConvertStringToBSTR has been defined in _com_util namespace
 if host_os == 'windows'
   has_convert_string_to_bstr = cxx.links('''
@@ -3360,10 +3361,6 @@ foreach target : target_dirs
 
   target_kconfig = []
   foreach sym: accelerators
-    # Disallow 64-bit on 32-bit emulation and virtualization
-    if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
-      continue
-    endif
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
       config_target += { sym: 'y' }
       config_all_accel += { sym: 'y' }
@@ -5036,12 +5033,6 @@ if host_arch == 'unknown'
     message('configure has succeeded and you can continue to build, but')
     message('QEMU will use a slow interpreter to emulate the target CPU.')
   endif
-elif host_long_bits < 64
-  message()
-  warning('DEPRECATED HOST CPU')
-  message()
-  message('Support for 32-bit CPU host architecture ' + cpu + ' is going')
-  message('to be dropped in a future QEMU release.')
 elif host_arch == 'mips'
   message()
   warning('DEPRECATED HOST CPU')
-- 
2.43.0


