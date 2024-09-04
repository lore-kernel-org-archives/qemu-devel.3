Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28942CD484D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr95-0003yS-Q7; Wed, 04 Sep 2024 10:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr93-0003We-Gr
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:38:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr91-0005Zr-Lu
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:38:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-427fc97a88cso7733225e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725460682; x=1726065482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lebkpv5ro7XFsiXt7RJVD2jT1UPq/NhvUiEsG6u4ONY=;
 b=qsRa6V7NgTWJcl5namIapTfh+HGkvr5B3P6r50xDbxdlHrehbsT7kaGLlaqXVV5OWD
 u0xSC/jhzWsn53DTnTx0hq7Ze7RW1DcU+tvgrV2KAioC+IbwDhgkO8hdWhPu9AHSzsxs
 CdKdIZ9g5jDM6TtQ0kSk2D6eKnhsOcr44tqpJDL1YeW1m+MGBkDAhvVYMuowPY598s8S
 DPz2qSicJoxsUcLPN8Bv9OGkWB2e7ukPP515+DX19DRjXKUibSLX3uHvTaDTCxdSsCTN
 P1Gud8uHpjza0jT2fZ7GRn+Rjl1vE3xZgADcJVFVsTIydFo2Vcp92MtdJL5wAiX748LN
 ljoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725460682; x=1726065482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lebkpv5ro7XFsiXt7RJVD2jT1UPq/NhvUiEsG6u4ONY=;
 b=pa75jsbHsU8si6XvSjl8RloTVM0BvIZSkIkq3TwuxViL9Uw0u2Isb+AGGQska6clA5
 FqEq9Y57hDGuQJScptn9a+wAcN5RO2MTaR6zgMSRfeoTC88ymHXNJood/N1g7A8vXCyz
 8+wgh26L8OQSYxFbLWV8MJ2eKvHaDvz7a2frmp0rOCTKnAbST5704v/hwlYp3j7gsT0W
 SmOoJgpvfMXKBAnmBVNF04n/rn551y+hZla+G5BVDaZZSkJJ7yw0rtCnEzCUshzfdOsS
 ohBGIEjEGNyY+FC6iKry9J97NKNtsFO6nup3Qyq36f0wqk8th6tH2oiqRcm56TxCBuPd
 spNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvvoxIrY0DBGD+yGyueq6BZBi9ZxkNXJ3haytf1J090BMexXRoOvKZA9YrH17LZ8QBhIQOnsITPBh6@nongnu.org
X-Gm-Message-State: AOJu0YxcyuvrS3Ot7qC0B4HhUHunHU/ImXpN/HA9SFfxOHqrmVE3XJDT
 povOFTwueTknut4UJHh3tcNN7i/wU+EqHq3jMM2QnWAX/pHbmNukr04eOuvkcIg=
X-Google-Smtp-Source: AGHT+IGNtv0VQxYzY/BJYNSyHtGq3JSxzGWDq4M0j3UdLdGu17RVo3PtoYQAnkhE3yYk540Mc+dqGA==
X-Received: by 2002:adf:e24c:0:b0:371:c51a:3b2a with SMTP id
 ffacd0b85a97d-3776ee8fcccmr2018806f8f.4.1725460681903; 
 Wed, 04 Sep 2024 07:38:01 -0700 (PDT)
Received: from localhost.localdomain (56.red-95-127-44.staticip.rima-tde.net.
 [95.127.44.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374bd0ce240sm12810477f8f.70.2024.09.04.07.37.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Sep 2024 07:38:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/15] system: Remove support for CRIS target
Date: Wed,  4 Sep 2024 16:36:00 +0200
Message-ID: <20240904143603.52934-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904143603.52934-1-philmd@linaro.org>
References: <20240904143603.52934-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We are about to remove the CRIS target, so remove
the sysemu part. This remove the CRIS 'none' machine.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/devices/cris-softmmu/default.mak | 1 -
 configs/targets/cris-softmmu.mak         | 1 -
 qapi/machine.json                        | 2 +-
 include/sysemu/arch_init.h               | 1 -
 .gitlab-ci.d/buildtest.yml               | 2 +-
 .gitlab-ci.d/crossbuild-template.yml     | 2 +-
 6 files changed, 3 insertions(+), 6 deletions(-)
 delete mode 100644 configs/devices/cris-softmmu/default.mak
 delete mode 100644 configs/targets/cris-softmmu.mak

diff --git a/configs/devices/cris-softmmu/default.mak b/configs/devices/cris-softmmu/default.mak
deleted file mode 100644
index 3726699370..0000000000
--- a/configs/devices/cris-softmmu/default.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for cris-softmmu
diff --git a/configs/targets/cris-softmmu.mak b/configs/targets/cris-softmmu.mak
deleted file mode 100644
index e483c42066..0000000000
--- a/configs/targets/cris-softmmu.mak
+++ /dev/null
@@ -1 +0,0 @@
-TARGET_ARCH=cris
diff --git a/qapi/machine.json b/qapi/machine.json
index d4317435e7..63b84bc575 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -33,7 +33,7 @@
 # Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
-  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hppa', 'i386',
              'loongarch64', 'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 8d041aa84e..5b1c1026f3 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -6,7 +6,6 @@ enum {
     QEMU_ARCH_ALL = -1,
     QEMU_ARCH_ALPHA = (1 << 0),
     QEMU_ARCH_ARM = (1 << 1),
-    QEMU_ARCH_CRIS = (1 << 2),
     QEMU_ARCH_I386 = (1 << 3),
     QEMU_ARCH_M68K = (1 << 4),
     QEMU_ARCH_MICROBLAZE = (1 << 6),
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index aa32782405..0933d62db8 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -667,7 +667,7 @@ build-without-defaults:
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
-    TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
+    TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
       mips-softmmu mips64-softmmu mipsel-softmmu mips64el-softmmu
       ppc-softmmu s390x-softmmu sh4-softmmu sh4eb-softmmu sparc-softmmu
       sparc64-softmmu tricore-softmmu xtensa-softmmu xtensaeb-softmmu
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 18ec5b6253..2ce0432eb7 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -20,7 +20,7 @@
     - ccache --zero-stats
     - ../configure --enable-werror --disable-docs --enable-fdt=system
         --disable-user $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS
-        --target-list-exclude="arm-softmmu cris-softmmu
+        --target-list-exclude="arm-softmmu
           i386-softmmu microblaze-softmmu mips-softmmu mipsel-softmmu
           mips64-softmmu ppc-softmmu riscv32-softmmu sh4-softmmu
           sparc-softmmu xtensa-softmmu $CROSS_SKIP_TARGETS"
-- 
2.45.2


