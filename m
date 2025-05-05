Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE36FC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl0c-0003rr-QV; Sun, 04 May 2025 21:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0b-0003qf-5M
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:41 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0S-0002Tx-Ej
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso3973634b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409951; x=1747014751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+insc5JF0LDgOcxml+QzIIv4GANFmGAhKwH/cRPIB3k=;
 b=rfwYKKZEMCRkIU9faGCDwUK7xJ/DEgILUlOMQ+08xKhEFiiBcSanWZLsPJRK+RV5vY
 x/kkP6C+lsF9KKYxFg3MFKt9AoVToVVHsnx78mSPsUb/7pqsB922OjLkICTTxTmxOY+z
 n3vXYTeNLHsIJy/DLXMQb58sZ5nEG+hKPV9I50RcuX7PSjHiLc2kMgx2kJYDmKzeHvIV
 eO1HxBEXizZTpXIqJavja1ItqE33OmWvLJEfGuLa3soOmrBLi1FGnsljIQqOobvk/l/q
 6JvkRA3ZFP+4yWbCCNzLNNvTEhOgBRhvWtcSpMzZvp1oiCYvvgdF/1n4ZYNfP04861wO
 VPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409951; x=1747014751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+insc5JF0LDgOcxml+QzIIv4GANFmGAhKwH/cRPIB3k=;
 b=sNuxmaUEX/Hr0L1rM5A4rj3sjg8HMYcwijQF8dnhAjINrjMoqwlbxhCGD0YSYAW/0N
 WNhFgFDsh/UtVFXi7jlW4rBaAAzNzVCgxNE1NpJlULTxE38tmLMr00iQy98w4a+shwtr
 efoL7fU25bwcKorwN0SSc0V0uLR5A/fb+gADax12bEg/+6JSpHy55Hqqa8Q7JoqBWnF7
 r7C1X6mITalSlw98KeSlyAtWHRGItRALOfUXjqIVJuXEPcfqeuH9kYoLNnJc9XzsLAxf
 HLei6XsBZBxreEQBU6+WZSsn5C7lw4xEVzUimdiit8E9wV76MBygII1b+mlgRMAUkUcW
 ojew==
X-Gm-Message-State: AOJu0Yx/Em9DvEu4rOyadn/HdrVSRS990F7l/YgGfdA1CcRvYAjMz9aV
 wHHZTjIPCChFPSHSGiAfFkw1Iccmy8/79rxWARan6pv5ky+mTyx1ewz9DgEaQWe4NEQ9n8/2gls
 rHXU=
X-Gm-Gg: ASbGncsQtafuBi/MjJMTOpeSNoptDYyNP0Ieb76RzgQTr52fYErhHMRCdX+TnI3AQYe
 Gw9lHwqcMZW8o70qTB3Kpbw/YDnPJ8Ya0yUQ3sgkwOP3zpQGkSCWvYov/4I6g0CThqMY7z84rQZ
 AEWnlbTRI+yUR8IHaJrFEtj+vC1MGUCbSnWPnPj1APHh5QgzBrf3jK366HEiWmIU+AFQl4XTFuv
 9csGRyTOjvdbfuf0J6fSeH90pfhzh7a8kAUx2lE73q2ufypKIKN1iRMwtiTldgv82Wy4VJERhyx
 RrC2LziJRTdFpSHNRAFT5KMiNkwCx7ubKHo1kVVoYGRXu3kFPOU=
X-Google-Smtp-Source: AGHT+IE8QIMP7OfGkKKt3trPX6lPSRIjp3VYA8PxD/ZDYRx4dMoMuOmuOKmsaz6Im0Gy3fu/ZCT8rw==
X-Received: by 2002:a05:6a21:3405:b0:1f5:7710:fd18 with SMTP id
 adf61e73a8af0-20e9660883emr6877505637.17.1746409951002; 
 Sun, 04 May 2025 18:52:31 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 04/48] meson: apply target config for picking files from
 libsystem and libuser
Date: Sun,  4 May 2025 18:51:39 -0700
Message-ID: <20250505015223.3895275-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

semihosting code needs to be included only if CONFIG_SEMIHOSTING is set.
However, this is a target configuration, so we need to apply it to the
libsystem libuser source sets.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index b2c79a7a928..1b365dcae17 100644
--- a/meson.build
+++ b/meson.build
@@ -4049,27 +4049,19 @@ common_ss.add(qom, qemuutil)
 common_ss.add_all(when: 'CONFIG_SYSTEM_ONLY', if_true: [system_ss])
 common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 
-libuser_ss = libuser_ss.apply({})
 libuser = static_library('user',
-                         libuser_ss.sources() + genh,
+                         libuser_ss.all_sources() + genh,
                          c_args: ['-DCONFIG_USER_ONLY',
                                   '-DCOMPILING_SYSTEM_VS_USER'],
-                         dependencies: libuser_ss.dependencies(),
+                         dependencies: libuser_ss.all_dependencies(),
                          build_by_default: false)
-libuser = declare_dependency(objects: libuser.extract_all_objects(recursive: false),
-                             dependencies: libuser_ss.dependencies())
-common_ss.add(when: 'CONFIG_USER_ONLY', if_true: libuser)
 
-libsystem_ss = libsystem_ss.apply({})
 libsystem = static_library('system',
-                           libsystem_ss.sources() + genh,
+                           libsystem_ss.all_sources() + genh,
                            c_args: ['-DCONFIG_SOFTMMU',
                                     '-DCOMPILING_SYSTEM_VS_USER'],
-                           dependencies: libsystem_ss.dependencies(),
+                           dependencies: libsystem_ss.all_dependencies(),
                            build_by_default: false)
-libsystem = declare_dependency(objects: libsystem.extract_all_objects(recursive: false),
-                               dependencies: libsystem_ss.dependencies())
-common_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: libsystem)
 
 # Note that this library is never used directly (only through extract_objects)
 # and is not built by default; therefore, source files not used by the build
@@ -4308,6 +4300,16 @@ foreach target : target_dirs
   target_common = common_ss.apply(config_target, strict: false)
   objects = [common_all.extract_objects(target_common.sources())]
   arch_deps += target_common.dependencies()
+  if target_type == 'system'
+    src = libsystem_ss.apply(config_target, strict: false)
+    objects += libsystem.extract_objects(src.sources())
+    arch_deps += src.dependencies()
+  endif
+  if target_type == 'user'
+    src = libuser_ss.apply(config_target, strict: false)
+    objects += libuser.extract_objects(src.sources())
+    arch_deps += src.dependencies()
+  endif
   if target_base_arch in target_common_arch_libs
     src = target_common_arch[target_base_arch].apply(config_target, strict: false)
     lib = target_common_arch_libs[target_base_arch]
-- 
2.47.2


