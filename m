Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E876D3398E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Qlc-0001B4-3k; Mon, 28 Oct 2024 10:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qkz-0000IG-5J
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qkr-0003jW-Ay
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGF/WI0T5FqI0OdtDWGfVkUzBUUfYU7X4tQjp4ynrPQ=;
 b=esBk3OvvyhXMxq47d7qVGhkxxVcATVYfgb76aX0kUwrWJ2Js7y7OCNIRbS3s8oMkszqiQO
 QArzKRK3uOUUMZo71VtZod0g81R8e+7ATasBlIiPp0IU3g5FmoYUzBUevndS/pk2NvtGzZ
 WRd2h+mjtPYvD9yZu04xci/JgLRVfww=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-1pVFd_CoNzC6oSxgwQeIfg-1; Mon, 28 Oct 2024 10:29:58 -0400
X-MC-Unique: 1pVFd_CoNzC6oSxgwQeIfg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4314f023f55so33634125e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125796; x=1730730596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGF/WI0T5FqI0OdtDWGfVkUzBUUfYU7X4tQjp4ynrPQ=;
 b=d/GB2HqXosiLcYc4Kc8TvvC9b0MfUi+oxJJfviaJybL8sEwNJ2KGyTk747TNu+12i6
 yXzymP3UsGaJdnL8tbopi5sF8IoVh9++8chSF1axm0ytBeWLRl+57vgPiSPPDsFTjwWq
 QqJXjW+Bwj1zq1stabX58FiSllIe4DZUP+giuSWuMdOtWv6oNELpD2V8BOggFwy3I57W
 BoZdCfsljuIcpI5SrfnFcLRNqjMEHK/cm3JxOJcElfdgqSWw/OrHRpPUPQMLgsZUiaoW
 sMmn9GQvR/aW/xFT7KIDyqHAyi/TtB+e38MBRlgVg2LSXKQQBnycZLm4lac+Y6Gc5q2m
 ipJw==
X-Gm-Message-State: AOJu0YyB4D44yLGM3w6I969/Zb+zXzo+tf7SdytfOkBDlBfOciVWQp00
 gJU3N4tOkXAwq/fNElH19q4KCFP0Bar7rRfzKKVlrjNAw7WnKHfeaXjWBj5V7Fw6DK2VL/Wy2jV
 LcPrB3TfeJTNifIv4TCQwjFmUDMgH/2ceMnpJT54ItBKdugyAI2QWvhAUmorZQZqB7Ji0IoOvCm
 ssaUxS806mol4039iyhfpo8v56OmdX/e6iVKDI3jE=
X-Received: by 2002:a05:600c:1c01:b0:431:12a8:7f1a with SMTP id
 5b1f17b1804b1-4319acadc13mr86604835e9.16.1730125796451; 
 Mon, 28 Oct 2024 07:29:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdP2G/Y/b2FdfR09qmGclwq9MAHOLyqLYsf/A/eHC72mJPkJa3jcWjiUCJgNf8so9qT+I8AA==
X-Received: by 2002:a05:600c:1c01:b0:431:12a8:7f1a with SMTP id
 5b1f17b1804b1-4319acadc13mr86604565e9.16.1730125796050; 
 Mon, 28 Oct 2024 07:29:56 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431935f8820sm112096405e9.30.2024.10.28.07.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:29:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 09/24] meson: import rust module into a global variable
Date: Mon, 28 Oct 2024 15:29:16 +0100
Message-ID: <20241028142932.363687-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index c26c417de16..891590353c4 100644
--- a/meson.build
+++ b/meson.build
@@ -15,6 +15,7 @@ meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
 
 not_found = dependency('', required: false)
 keyval = import('keyval')
+rust = import('rust')
 ss = import('sourceset')
 fs = import('fs')
 
@@ -3963,7 +3964,7 @@ if have_rust and have_system
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


