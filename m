Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD666C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4MAV-0006fb-Ma; Tue, 07 May 2024 10:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4MAT-0006ex-WE
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:51:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4MAS-0002qK-Je
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715093503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N25+1UPAT5thwCNy/6Q0XVQjeOkhX+mAvGM/gJJ6kXk=;
 b=L45RWBZ28BLYO1x8fOySCrh94XXoZei2L7hlY32r9WRZTDVvNfEEQbO0fj6VpxA9Hv0dqh
 8Y4DOAPAVipq1/8zdVlxvUuWENK5C23pqHgPz4H5wYpiKZzvZ77wK7saWekXKVibRMEQGk
 UrlWhMbwsCa68Z3rYR+Q1EsvNnCv8d4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-MciBo1_3NUS6d2xNAVgnxQ-1; Tue, 07 May 2024 10:51:42 -0400
X-MC-Unique: MciBo1_3NUS6d2xNAVgnxQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59bfd32b8fso173113566b.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715093500; x=1715698300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N25+1UPAT5thwCNy/6Q0XVQjeOkhX+mAvGM/gJJ6kXk=;
 b=wLXxEYmhy/qWqT9qpWI3yY/1IJW4ZTP9G7kOPQXHeFoknCNfhL/QV7gV2sLhYa162t
 T0ry3/ya/Rk4mAR+hPVka4XRHkFlcxT2IW2ImKvUTpKaLOHK6E5uE/D8GWcw+/0/M2uC
 iLIt+83NkIN1EZwLCfRuydh7nlwKCxUqDngNtr6a1mjDuH4uSEPYW+qnfd+uN6MPF4vz
 FXCsy9crkQeK0+eTu/rZ5MqgrCm/8ABZ06Eejz43hBiBZn7a4KHTTC0nhtuqYsWJue4A
 9Nz5N9Pzix/3Xeqgs17u8yOxWEWF0YsUX02AeR0J9vHYS7JMfX3vfEfGhbP30q4MwkJF
 HEvw==
X-Gm-Message-State: AOJu0YwD+lkqaBOYohi/WPfuFQGjBP5v8eo9uVMnpAeWgfq/RKTSKVzx
 9F/gxBBjQqERALoZZhPDGS3TPH86OdzJSwy5X5hpwyWpBexocHxcQyeBNtveBrrS2/vOo5aadyn
 DQY0AgSSW6gHeCNxnifEy/9hw1vz7AUzimg7esIsOGAJlKa5PBfqEBzh00i9cnRBfMYajbvVdIU
 qwMnIcI3nr5WuKpYMUsHcddohQdelTyu6AkipM
X-Received: by 2002:a17:907:7248:b0:a59:b784:ced4 with SMTP id
 ds8-20020a170907724800b00a59b784ced4mr7083154ejc.75.1715093500732; 
 Tue, 07 May 2024 07:51:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqHMB8rfog2hUWA8ncrm7IDJylFh1eXLpI6T9LTWfqfIV5JNuSyAea/dJkMtV4/jFDUJkLNw==
X-Received: by 2002:a17:907:7248:b0:a59:b784:ced4 with SMTP id
 ds8-20020a170907724800b00a59b784ced4mr7083141ejc.75.1715093500381; 
 Tue, 07 May 2024 07:51:40 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1709061d4a00b00a59ed1eb60fsm774129ejh.105.2024.05.07.07.51.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:51:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] sh4: select correct components for no-board build
Date: Tue,  7 May 2024 16:51:38 +0200
Message-ID: <20240507145138.270825-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 5 +++--
 hw/sh4/meson.build         | 2 +-
 target/sh4/Kconfig         | 2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index bab61945643..13afd0df1f0 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -650,7 +650,7 @@ build-tci:
 # Check our reduced build configurations
 # requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
 #   mips64el, or1k, ppc, ppc64, riscv32, riscv64, rx, x86_64
-# does not build without boards: i386, s390x, sh4, sh4eb, x86_64
+# does not build without boards: i386, s390x, x86_64
 build-without-defaults:
   extends: .native_build_job_template
   needs:
@@ -665,7 +665,8 @@ build-without-defaults:
       --disable-qom-cast-debug
       --disable-strip
     TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
-      mips-softmmu mips64-softmmu mipsel-softmmu sparc-softmmu
+      mips-softmmu mips64-softmmu mipsel-softmmu
+      sh4-softmmu sh4eb-softmmu sparc-softmmu
       sparc64-softmmu tricore-softmmu xtensa-softmmu xtensaeb-softmmu
       hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
diff --git a/hw/sh4/meson.build b/hw/sh4/meson.build
index 424d5674dea..70e814c3a28 100644
--- a/hw/sh4/meson.build
+++ b/hw/sh4/meson.build
@@ -1,5 +1,5 @@
 sh4_ss = ss.source_set()
-sh4_ss.add(files(
+sh4_ss.add(when: 'CONFIG_SH7750', if_true: files(
   'sh7750.c',
   'sh7750_regnames.c',
 ))
diff --git a/target/sh4/Kconfig b/target/sh4/Kconfig
index 2397c860280..93b92f1e480 100644
--- a/target/sh4/Kconfig
+++ b/target/sh4/Kconfig
@@ -1,2 +1,4 @@
 config SH4
     bool
+    # needed for sh_intc_get_pending_vector
+    select SH_INTC
-- 
2.45.0


