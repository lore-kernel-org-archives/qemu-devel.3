Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F64C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 05:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFnbO-0006Fw-J3; Fri, 16 May 2025 01:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbM-0006D5-OI
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:20 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbL-0001Mb-4a
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:20 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af51596da56so1281229a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 22:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747373238; x=1747978038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEF4F6w/QQ4yK0T92qmZBuHANuJnFGe0fNZ2771Yy/Q=;
 b=rVa5Mla92LYkP8LjojtiTtRaSW0X/c6swHheVMT456CGqntskJvoWTj659jPQR3RZS
 vy5XgqD1XnrswYhAO8OVmGEoyJLFBFdVHywREcMNCpBmuuyjwGFXQYib2N7Pv4Ehe5qq
 Sa3mf4A55DjJMjE+7FUVTaoldpKxkYqUC8/W9yP+ikL5yzHAgfS2rZWBg4BdT5TKS+tG
 HHJd1OCxqobSKzFlkBPrstjzPIec2l0zIFyQrwq/o3rV2Hg626EbsAA9A+2rdffh0ng5
 uNqAOG+E4J15CneeLO85XKG0WUlWrs3EHe+DpixTbNdGffDp0f6v20kMZc0fO1fNHKDz
 PJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747373238; x=1747978038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEF4F6w/QQ4yK0T92qmZBuHANuJnFGe0fNZ2771Yy/Q=;
 b=fASfMrgWDURzVRQn+s02t3JjVa0U5aZC1RrKpnlJz7/g4ofcnYY9e1KICs8vQjR1BU
 FjFILRA+EH7jKwIwQDY/ICkrortXrmPOICM08fICZMJ7kh+ZFnLeOrLj4uke7+08k7PA
 EWRZoo/55tHsUr02F9wuw/Ui0pK+rBufJNxvSScl25/oMmW31GYPL7wvCODqeOGSMOb/
 VOUVMPdd2J//eAIhjs6VWFxcRdlHaNsuNqZfoyi2Futq9PUt3HWmzb9xRxwaeuYO8Jhl
 ed8HK7clKzA/vUkUGZvJ5IBthDG2T/kQqj0RgjeYCLfVX5A21z7n6bs44/PcB6EzyUN6
 RFhg==
X-Gm-Message-State: AOJu0YzRzw6dcwu5YdrrrqgRngaf4NWRD0O+B+0l7ngeCavCBSwZVV54
 8PFHftqQH/dfo0HBixrHfeiPSWK5o9oW4zyKgiHzcJ6mMVuYCRNjFwI1ffJbQG0wV4Cp54lOPSj
 R+tCT
X-Gm-Gg: ASbGncsG6w0LwYKXO2tmGrNMfILxSukEGuJRMcnDIEivEUEZvMXW4FkVppnrYNYRW9R
 nQ1RcaY7LWmZHIwlWYjcVTXOZg2/YSp4drqsTilhZRpMJ9OxRZsHW3HyULkxyVvbztJuo3/mb2u
 GE+k+OQB0JLQXhMQkodChspdq9k7FJqcXXAzR/CRZpqDzUxKbm/5J3iN6lddBAKE/QyNDzOAzmf
 Ts87TXWkS9AE0DXNmXS8XXcIifQY2pz8WH5U+yTnxMVdZApIuL8P7CPf4nS0l1mVdIjO7n/L20N
 st+fmmsUM6ih9mKEiwgLGFTegtskVOelVFV9Xcz7/IyhG0enyAQ=
X-Google-Smtp-Source: AGHT+IGPEveysat8bzRiYMukNhUVqpew1Z/2O4CApz/R//sdjAbc7lwW4sgret2LPc/WaP0OW/Xr2A==
X-Received: by 2002:a17:902:d4d1:b0:224:721:ed9 with SMTP id
 d9443c01a7336-231d45ab656mr29851825ad.44.1747373237831; 
 Thu, 15 May 2025 22:27:17 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebabfesm6539135ad.174.2025.05.15.22.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 22:27:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/6] meson: build target libraries with common dependencies
Date: Thu, 15 May 2025 22:27:03 -0700
Message-ID: <20250516052708.930928-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

As mentioned in 20250513115637.184940-1-thuth@redhat.com, dependencies
were missing when compiling per target libraries, thus breaking
compilation on certain host systems.

We now explicitely add common dependencies to those libraries, so it
solves the problem.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 49c8b0e5f6a..197fdc1c210 100644
--- a/meson.build
+++ b/meson.build
@@ -3259,6 +3259,7 @@ config_devices_mak_list = []
 config_devices_h = {}
 config_target_h = {}
 config_target_mak = {}
+config_base_arch_mak = {}
 
 disassemblers = {
   'alpha' : ['CONFIG_ALPHA_DIS'],
@@ -3451,6 +3452,11 @@ foreach target : target_dirs
     config_all_devices += config_devices
   endif
   config_target_mak += {target: config_target}
+
+  # build a merged config for all targets with the same TARGET_BASE_ARCH
+  target_base_arch = config_target['TARGET_BASE_ARCH']
+  config_base_arch = config_base_arch_mak.get(target_base_arch, {}) + config_target
+  config_base_arch_mak += {target_base_arch: config_base_arch}
 endforeach
 target_dirs = actual_target_dirs
 
@@ -4131,12 +4137,17 @@ common_all = static_library('common',
 hw_common_arch_libs = {}
 target_common_arch_libs = {}
 target_common_system_arch_libs = {}
-foreach target : target_dirs
+foreach target_base_arch, config_base_arch : config_base_arch_mak
   config_target = config_target_mak[target]
-  target_base_arch = config_target['TARGET_BASE_ARCH']
   target_inc = [include_directories('target' / target_base_arch)]
   inc = [common_user_inc + target_inc]
 
+  target_common = common_ss.apply(config_target, strict: false)
+  common_deps = []
+  foreach dep: target_common.dependencies()
+    common_deps += dep.partial_dependency(compile_args: true, includes: true)
+  endforeach
+
   # prevent common code to access cpu compile time definition,
   # but still allow access to cpu.h
   target_c_args = ['-DCPU_DEFS_H']
@@ -4151,7 +4162,7 @@ foreach target : target_dirs
         sources: src.all_sources() + genh,
         include_directories: inc,
         c_args: target_system_c_args,
-        dependencies: src.all_dependencies())
+        dependencies: src.all_dependencies() + common_deps)
       hw_common_arch_libs += {target_base_arch: lib}
     endif
   endif
@@ -4165,7 +4176,7 @@ foreach target : target_dirs
         sources: src.all_sources() + genh,
         include_directories: inc,
         c_args: target_c_args,
-        dependencies: src.all_dependencies())
+        dependencies: src.all_dependencies() + common_deps)
       target_common_arch_libs += {target_base_arch: lib}
     endif
   endif
@@ -4179,7 +4190,7 @@ foreach target : target_dirs
         sources: src.all_sources() + genh,
         include_directories: inc,
         c_args: target_system_c_args,
-        dependencies: src.all_dependencies())
+        dependencies: src.all_dependencies() + common_deps)
       target_common_system_arch_libs += {target_base_arch: lib}
     endif
   endif
-- 
2.47.2


