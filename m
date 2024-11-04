Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693BED1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80rm-00055v-Le; Mon, 04 Nov 2024 12:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rj-00053h-VO
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rZ-00007c-Pu
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsXnct9jOSuPLQFzAaGlvw55sZX5mXIut7PiLhLE4FI=;
 b=KbeNe4qJ5Ik4uKjBzJIVymmH6PDux/D9Od6UNcHDCK2wP692H6O1i8ELa+H+8LkFPLXMAP
 /EgC8hCiqYz80obNODG9FJNQ7mFidKdewltAyU/jCd73lK/wIZ8p9SP7OveEH0xLPcTUqP
 qaenKkRjPjPm+tfwdGF9O0luf0Y7WjY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-GuEF6pGkPS6jPRsPNrG2bg-1; Mon, 04 Nov 2024 12:27:35 -0500
X-MC-Unique: GuEF6pGkPS6jPRsPNrG2bg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539f7ed336bso2776396e87.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741253; x=1731346053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KsXnct9jOSuPLQFzAaGlvw55sZX5mXIut7PiLhLE4FI=;
 b=Hq84qPrhPTGqUTLQnvD8Q2wdN/otDe200iuTYPpE4BiP/EqmxjNdnFMX4B5YzsB6UZ
 c4tpOVK53hp3PzOLr0K1cOuJnLqKoUJT/bhMoVVR9yPf7BV6tFH5CoYkluCb47TmP6eA
 PJ/pYLrc/d9OGVO/bjCcaQ4KZcMkuseGC7rX76/scp6A3pejAZhroY0SEvcRipGSts8+
 +86JdtT1+sVg6YPmY+WCsuTFmcGdmNUiOHCLhBUxndNeTV7XEAYKlAqjf/fv4w3zJPty
 TOV8U47uyTLIzlTygEm9kQJknGjAD38+sKWY3FUHMTorVhUR7d/p0qzzVY7aNBZtHFRr
 GG2w==
X-Gm-Message-State: AOJu0YyYbeKEs4tNH/HBHvVPcn/fZjz7jylElLI2bU5ZewEgjl6WaG9/
 oca0KvEn7D3vm9m0LzG0y8VVRlAsLqaEqBpOjsDf3VfD5/YgQ74ed9J3kkKrIv9z6R0vKq1X4qF
 C7aIXrXqypzxo9vj5SEhCavCXKJETn9rlVSZzHHjqVxJDUks1OP1KwnSqdcsbObuDsWI0k4xiP2
 qJo+d92PPTtsbe+x6j5E65ETszlRKAsmCIH+RpY90=
X-Received: by 2002:a05:6512:1092:b0:53b:20a1:1c4a with SMTP id
 2adb3069b0e04-53b34a19077mr16160843e87.42.1730741253382; 
 Mon, 04 Nov 2024 09:27:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfQW3qVGu5BqFQ/U4DyIUy6sR4ljt9kykUVZo2l3HZNp8nBfaEZzLJ8xsHm/ywUb99RmMXHw==
X-Received: by 2002:a05:6512:1092:b0:53b:20a1:1c4a with SMTP id
 2adb3069b0e04-53b34a19077mr16160818e87.42.1730741252801; 
 Mon, 04 Nov 2024 09:27:32 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7c2bsm13787311f8f.23.2024.11.04.09.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/40] meson: import rust module into a global variable
Date: Mon,  4 Nov 2024 18:26:44 +0100
Message-ID: <20241104172721.180255-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Tested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                      | 3 ++-
 rust/qemu-api-macros/meson.build | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index f7d45175212..dd6193c4c37 100644
--- a/meson.build
+++ b/meson.build
@@ -15,6 +15,7 @@ meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
 
 not_found = dependency('', required: false)
 keyval = import('keyval')
+rust = import('rust')
 ss = import('sourceset')
 fs = import('fs')
 
@@ -3977,7 +3978,7 @@ if have_rust and have_system
   # this case you must pass the path to `clang` and `libclang` to your build
   # command invocation using the environment variables CLANG_PATH and
   # LIBCLANG_PATH
-  bindings_rs = import('rust').bindgen(
+  bindings_rs = rust.bindgen(
     input: 'rust/wrapper.h',
     dependencies: common_ss.all_dependencies(),
     output: 'bindings.rs',
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
index 517b9a4d2d5..24325dea5c2 100644
--- a/rust/qemu-api-macros/meson.build
+++ b/rust/qemu-api-macros/meson.build
@@ -2,7 +2,7 @@ quote_dep = dependency('quote-1-rs', native: true)
 syn_dep = dependency('syn-2-rs', native: true)
 proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
 
-_qemu_api_macros_rs = import('rust').proc_macro(
+_qemu_api_macros_rs = rust.proc_macro(
   'qemu_api_macros',
   files('src/lib.rs'),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
-- 
2.47.0


