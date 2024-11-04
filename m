Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B46D1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80si-0007cV-Nh; Mon, 04 Nov 2024 12:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sg-0007GI-9C
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80se-0000RD-Lb
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xCtG4s+R0hvYDBK1+6HaDNZNUOk+9107L2jl9gNn/a4=;
 b=A+wz3QXdusZUvs09PjdpsjUGpyz+dWhgEUrFYd0kXLz6rmhA8rjiD91d80OrVRkEApBZ4S
 MAy6kHMHh6hx6IFuMzGKtvAlCrsdIPuwURInZKgSD+f/5mkFvDf4vZR2Qn2HUl96SROIv0
 uWsyd2u6ahz/FAgUsM/AGUZdA9a40CY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-_eO2TMXLOxeCsI2glCDcMw-1; Mon, 04 Nov 2024 12:28:42 -0500
X-MC-Unique: _eO2TMXLOxeCsI2glCDcMw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso25377485e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741320; x=1731346120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCtG4s+R0hvYDBK1+6HaDNZNUOk+9107L2jl9gNn/a4=;
 b=syB2qlIAxjZMgwJ4ZHE9LCyaghDX0F6o3HqoZFRE0SljO29v4/8U/PNT7hpQ5mszNZ
 1lE+HM7JLDZnC1R0jRjEHyAbzpmcFKWoPXRtRMUieqOfNHN6fuEV/SuGuKqjhsnEyJYN
 lsEJhGRAu48yeVb9qGj4gmC5TzJr6I7s+sFHSBzB9u72buI+hOKJLoYVz/aov5xdqSkX
 7WcfI1bJxRE11OJ5pKY4LgmD4G3GrkO7shYUCywSb/gkTm7IMnENtOcrSid2JCkfcf6W
 kiXTofZPQc43mkZnjW8FQAaEVkuw8+zNUcYGRyC7HXA99PRzGQzR+lqUs9TZZNbr9zS6
 ZA0A==
X-Gm-Message-State: AOJu0Yw3c/sXWdPJzMMzmb8pvpLGaZWckimAkS2QJbWdz726dpl/16ju
 aM3eu5YVbJauu0CHWpyrWHzYpKbcW7SqopgHqZvCiK/7btSEabrklCd8/z1ppBIXNy4GTeaIzu2
 p7BR2gBxMoiKFXE1uJNThF24BS4kgkHzKYkCs0bjJ9HsfYMwvnQCHYQpl+/NfmYiBCOhlzWpiA4
 d2MfM56VCZFedL5zGO/2uJ+gAjS+iGAW74CiaKKFk=
X-Received: by 2002:a05:600c:4f41:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-4327dabab21mr125207725e9.10.1730741320332; 
 Mon, 04 Nov 2024 09:28:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ275ZT/Y3EvRaVSlN0VoNka0QqVeaEKQ8Ru8vqReBVa1RCh3qPItkpblg2u2+77nDu8z6DA==
X-Received: by 2002:a05:600c:4f41:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-4327dabab21mr125207525e9.10.1730741319881; 
 Mon, 04 Nov 2024 09:28:39 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e853esm193984035e9.8.2024.11.04.09.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 35/40] rust: allow version 1.63.0 of rustc
Date: Mon,  4 Nov 2024 18:27:14 +0100
Message-ID: <20241104172721.180255-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

All constructs introduced by newer versions of Rust have been removed.

Apart from Debian 12, all other supported Linux distributions have
rustc 1.75.0 or newer.  This means that they only lack c"" literals
and stable offset_of!.

Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index eb5660a0836..95b612e0b77 100644
--- a/meson.build
+++ b/meson.build
@@ -89,11 +89,12 @@ have_rust = have_rust and add_languages('rust', native: true,
     required: get_option('rust').disable_auto_if(not have_system))
 if have_rust
   rustc = meson.get_compiler('rust')
-  if rustc.version().version_compare('<1.80.0')
+  if rustc.version().version_compare('<1.63.0')
     if get_option('rust').enabled()
-      error('rustc version ' + rustc.version() + ' is unsupported: Please upgrade to at least 1.80.0')
+      error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.63.0')
     else
-      warning('rustc version ' + rustc.version() + ' is unsupported: Disabling Rust compilation. Please upgrade to at least 1.80.0 to use Rust.')
+      warning('rustc version ' + rustc.version() + ' is unsupported, disabling Rust compilation.')
+      message('Please upgrade to at least 1.63.0 to use Rust.')
       have_rust = false
     endif
   endif
-- 
2.47.0


