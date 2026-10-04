Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A39CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 07:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDGfU-0001YG-Ex; Sun, 04 Oct 2026 03:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDGfS-0001WC-9g
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 03:29:54 -0400
Received: from mail-dl2-x2b.google.com ([2607:f8b0:4864:38::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDGfQ-0006Di-EU
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 03:29:54 -0400
Received: by mail-dl2-x2b.google.com with SMTP id
 a92af1059eb24-1438cb9b3a3so593244c88.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 00:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791098991; x=1791703791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MdbuP9U3b12qhVahK6R7SD0hZ/DRj99u7NJ7dpFdnik=;
 b=pKXWxA0Q/rutGtB8MTsVJKgA2DK1hTob3tsfQ7vicOkDs3WdKA7ZmVQibW+3FSTjOC
 Oyw36pqADTwAyqbLgYRuqGkbVtGVvsxEuNoDolHmp1orocU6Cu5VFi3B7bvqsrwtQtUS
 i0Ehtec/Odx4q8GPmBLvzGAKA6eelrOQBXaHhbm9Z6TCWukTKbhdDJF9WgAL5MQDJ+bp
 DUU/5cIVDkwUsZLFEQHQaqsRbIlBPecP/sus5Eu7sQLV/oACCYWWdZ4OcBfO26D1rbdy
 ljWDrL5byJXsC7hen+Y0fagFw44iht78gOa9tAo7AQJ9yQrASmH4Pj5uRh2cADf/6Yn3
 u6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791098991; x=1791703791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MdbuP9U3b12qhVahK6R7SD0hZ/DRj99u7NJ7dpFdnik=;
 b=lrwCyrYPnIu3O8X1ALiqfk89gZyZzLTZ5DcN3zgJt3yn0vcasbANXVvPE+erCvcB1w
 zZQl8uVRMsniQXQ+sVqCMx0DjVH4YhLWIVdceJpocfdTyHOKQ5rpbgfrlSZEAsTvCAOk
 S6y/flyZDxCnLRsV2xkwURwoBaUMDPHjLX9ox/Gt4c61RpVO+OV4l99usb56DVYasAYg
 0Spwg7I3o/PgelzUYUJzhbZ+QrabjVEqjM/Mt5MSgppgCaUWwdF+Nm/aI6ANyoWGxcjJ
 lm7cFPNNd9+3eRr5a56h6anZ5GnE315HhR3m5fCtn5h7eBYjpZn+JMXAEU3ChaZRIITC
 HuAw==
X-Gm-Message-State: AFq9FYJ0csju+ueTgCmjwEF9yXp8rk2koGMTnoA0GJCSBssQHTQ4+wxO
 dAg+oKm6GWUBeAYVn9YMIbDBn1qR3+8tHD7575owy5fjWnANdOccVje73DQ0Ya5B
X-Gm-Gg: AYBFou0qQfVqIqNABd/gh5zqvDYkdNOiWJ9MvhOr9R0LId3O0Txjebs0EWax46RYf36
 V1epc8HWqSxJwXUoO23Bv1AllpL/iCvJ0grrrylxoLfHAArjUM3sXaRaAUYi6VVN4HGmKCXnZh0
 IJJR2VJww6DkshZ3L9g3h/6BY2YY3y4u6eLYP0h3DYI0tM3smVSApZJfoVRtXid8cf9Ay6rtJOH
 ZgXd3WgaHT4clxA56JsvMjeJTycYGAwpOcoEqqj+EPuTNByaim2P1+VM1bR+yPUYtPtrWxIS+QY
 Q5mRIzrO1C4S9yPs89GwHVZ5u70WaH30Yu8oHj/m0bXfHM7hGvLqREH/vTStbgSFnoOwEg/JeOU
 zYsSwTXZGLAZ9PLEBV6gu7elJWJgOb3HOvw9Bx1mQNTNaYobwR47cdniMf6wu0K1GV04HHhVqcn
 tLeRAFj/SL+kUaGwhvN2s9ShCtbqqtxVO81KPbX5NJwQH/s4O3fAFn5q4mqQnU4NjUP3TjewtQZ
 ZhY5vN/Cab05e+JcQ==
X-Received: by 2002:a05:7300:ce98:b0:33c:e74:4625 with SMTP id
 5a478bee46e88-34f2185df75mr7751936eec.28.1791098990728; 
 Sun, 04 Oct 2026 00:29:50 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-351270204e0sm3036770eec.1.2026.10.04.00.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 00:29:49 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 4/4] target-info: preserve full softmmu target identity
Date: Sun,  4 Oct 2026 15:29:26 +0800
Message-ID: <20261004072927.1142-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261004072927.1142-1-luoyonggang@gmail.com>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::2b;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Generate a full SysEmuTarget token separately from TARGET_ARCH, so variant
targets such as mipsel retain their QMP identity while user-mode targets
continue using the base architecture token.

Fixes: e934c624f3 ("target-info: Statically initialize target_arch")
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4640

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build        | 9 +++++++++
 target-info-stub.c | 2 +-
 target-info.c      | 8 +-------
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index cec12f109f..5c0607bfa5 100644
--- a/meson.build
+++ b/meson.build
@@ -3319,6 +3319,13 @@ foreach target : target_dirs
   endif
 
   config_target += keyval.load('configs/targets' / target + '.mak')
+  if 'TARGET_SYS_EMU' not in config_target
+    if target.endswith('-softmmu')
+      config_target += { 'TARGET_SYS_EMU': config_target['TARGET_NAME'] }
+    else
+      config_target += { 'TARGET_SYS_EMU': config_target['TARGET_ARCH'] }
+    endif
+  endif
 
   target_kconfig = []
   foreach sym: accelerators
@@ -3372,6 +3379,8 @@ foreach target : target_dirs
       # do nothing
     elif ignored.contains(k)
       # do nothing
+    elif k == 'TARGET_SYS_EMU'
+      config_target_data.set(k, v.to_upper())
     elif k == 'TARGET_BASE_ARCH'
       # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
       # not used to select files from sourcesets.
diff --git a/target-info-stub.c b/target-info-stub.c
index 4a8630b5f5..8f5d9fc728 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -26,7 +26,7 @@ QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
-    .target_arch = SYS_EMU_TARGET__MAX,
+    .target_arch = glue(SYS_EMU_TARGET_, TARGET_SYS_EMU),
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
diff --git a/target-info.c b/target-info.c
index bd126613b0..012b384036 100644
--- a/target-info.c
+++ b/target-info.c
@@ -24,13 +24,7 @@ unsigned target_long_bits(void)
 
 SysEmuTarget target_arch(void)
 {
-    SysEmuTarget arch = target_info()->target_arch;
-
-    if (arch == SYS_EMU_TARGET__MAX) {
-        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
-                               &error_abort);
-    }
-    return arch;
+    return target_info()->target_arch;
 }
 
 const char *target_cpu_type(void)
-- 
2.55.0.windows.3


