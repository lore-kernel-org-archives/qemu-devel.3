Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162B5C10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66nA-0003by-3j; Sun, 12 May 2024 06:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66my-0003Ud-LH
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mj-00065N-EU
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MwL5OXC5zx1oU7jPsvk03CZtymhzKTh+ZmsFA1G7QZs=;
 b=PBjCRkM8k7lCZHcQVBL+yNTddnZ4ETIKhY1hrVdx1urHERS9fTuXegO6BDghHJ7FDHzslc
 xBYv7GyPENT0OJjFG9qNoZhzruZTJRejzj5WgHEw8kwAOvOSp1mjX6s4c66CtcLPJ5sA/n
 ovzEmNvXVEy1SdLJhmyCPE+VhFF4MAg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-_r35OW57ODKjhZk1K0upoQ-1; Sun, 12 May 2024 06:50:12 -0400
X-MC-Unique: _r35OW57ODKjhZk1K0upoQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a55709e5254so151010966b.3
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511010; x=1716115810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwL5OXC5zx1oU7jPsvk03CZtymhzKTh+ZmsFA1G7QZs=;
 b=MVXd7wcJw791musJrgIFND1uj3DoWVdfWELkYWBZpI4CM4BZK0JdCMkpG8yMea5SxK
 Twq+tGsymCX1G5qwG6S33XLuO6M4uj/OK8u71nolAUmvHj/0qi54VVwjJ1i6LSk8sf95
 YcvLLNtBgwLN5zS+Rc6xTP0y8jAvYEez5QbkfM0YPEODqYnlCA9ghF8AgOjk5xyKI18B
 A+vmv02ER8PkrhFJUxLWiDYWL0mC4T0ZiMySX7+Neo0OqbQhOtJMHQTYeQ06K9lnk92d
 fM8shOUSS9izCPvnzvMof3aNNNha+DaJNCsjF4M3Kv2/sIgU8KW/N14RolAqgXB8jjrA
 gx0Q==
X-Gm-Message-State: AOJu0YxS8riMfWyHRDIOSClmewzcF9c3b7oOro8dgo9+XRfxQxjKXI+L
 ES5EbOYkH8mrh7fldH4icc9MvNhrK6eqf9r1EUVGcpTu1DCVwJrYCU35OHPrrNYvldvnA8yuKbh
 TU7Rf2KiGOpvDFxW46RX6N4jEYvr3qIZ0/N6Z/cgVxtJeDqZIk0UWNwHJGU3Rg2VPbgbdsPN7c7
 m44wrMiCcHvas5kqiX8Q2bl5xkJSsy1ZuGWbVP
X-Received: by 2002:a17:906:6805:b0:a59:bfab:b257 with SMTP id
 a640c23a62f3a-a5a2d6761d9mr443923766b.65.1715511010212; 
 Sun, 12 May 2024 03:50:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk7zX7uw/ah3Oc7ESgoy80OxMu8Ido3+jta8+9JS48lmeCkCerdIkcOSYDXMPW+TISn5pfyA==
X-Received: by 2002:a17:906:6805:b0:a59:bfab:b257 with SMTP id
 a640c23a62f3a-a5a2d6761d9mr443923166b.65.1715511009804; 
 Sun, 12 May 2024 03:50:09 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cd9csm440935266b.37.2024.05.12.03.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/27] sh4: select correct components for no-board build
Date: Sun, 12 May 2024 12:49:26 +0200
Message-ID: <20240512104945.130198-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 5 +++--
 hw/sh4/meson.build         | 2 +-
 target/sh4/Kconfig         | 2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 9836d81c24d..786c8f92090 100644
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


