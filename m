Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AFDD1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80rf-0004zu-5p; Mon, 04 Nov 2024 12:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rc-0004wb-In
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rV-000059-HT
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q8T5ohAzgqW97P1xGHDRejf6Ns5stLHojZxuqE9/t5s=;
 b=H/PYl9AxS65mxzCGZcQaUpMR8Lc/N4cX4y9Ii6Q7QfVaIqVhHP/JLHdg8VqwDrROq8gFel
 cIpCxsg2sGV7s/uHEHFyIAk8DEZvbaoH1BSXKTDL1EeRfWlSM0Axe+KjZQkfzptSfaY4TL
 jvfuaPiFIC1ltA+rYSKNX2I5mSBr7Is=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-FF1ufoS8P5W7LyJrbyUlWA-1; Mon, 04 Nov 2024 12:27:29 -0500
X-MC-Unique: FF1ufoS8P5W7LyJrbyUlWA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315544642eso32998025e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741247; x=1731346047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q8T5ohAzgqW97P1xGHDRejf6Ns5stLHojZxuqE9/t5s=;
 b=l8lXyW+02AdR8mETh2oRmveqshsL5BjU464k9Fq03w2wwzUzNvx5jbTQrMYYJ5hqHD
 y/DBiKEMvFpW+pvxAZ+RLhYsLYyaEks0fc9CsxlLRKOXLCfk5YDaGRkaPLijVPYwGsht
 ZDRIG2KizHCXyq62gGNsfocEKAVCpOwB3D38Lu4NIpvqZVx291paSAPClGJi7sbsmMuL
 jBIzIJFdGBHGwp+r8jU4jM4skRcpkFPvJPSqiEm7NRzpTJrbmagnvcmdB+YZiWFAU3p1
 /JFNSAMckpIhiMlSF9s7a6ok/tM7WTQsYcfHQSEoqbqMOwAbmmVYWeyHYqIzluJn/V4e
 gRbA==
X-Gm-Message-State: AOJu0YxNZLmVjYDNl3Wv9Z+jMSYDo/wcsm8aw6YvhobeiVYcbo7RzCXZ
 6pZhyf2cIGFm1A/ppJZinq4rhhMQOfv3gAaHm/cMnk2OxbdABEM/nN91ZxxUjpR2hy1Atwx+ubt
 qM+buNdPGWynYt7kw6WaVspw/q3/hftPjeAajFSnpV9wHYL15imlpWO2MAhXT5Xe24VpoQUduBm
 GPOCmuQy3z8vzrKXm446XamBSZrMo5u47RTWc6TnQ=
X-Received: by 2002:a05:600c:3b14:b0:42c:de34:34c1 with SMTP id
 5b1f17b1804b1-4327b6f9590mr141504765e9.2.1730741247601; 
 Mon, 04 Nov 2024 09:27:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxd5enN/Bvknhn7HAAW4RU8c25hQFA1v7fX1FQJeiIBCFxwfDN0Yse7blmslwYiD8w6zWZzg==
X-Received: by 2002:a05:600c:3b14:b0:42c:de34:34c1 with SMTP id
 5b1f17b1804b1-4327b6f9590mr141504485e9.2.1730741247161; 
 Mon, 04 Nov 2024 09:27:27 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5bf4fdsm158644275e9.17.2024.11.04.09.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 02/40] rust/wrapper.h: define memory_order enum
Date: Mon,  4 Nov 2024 18:26:41 +0100
Message-ID: <20241104172721.180255-3-pbonzini@redhat.com>
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add stub definition of memory_order enum in wrapper.h.

Creating Rust bindings from C code is done by passing the wrapper.h
header to `bindgen`. This fails when library dependencies that use
compiler headers are enabled, and the libclang that bindgen detects does
not match the expected clang version. So far this has only been observed
with the memory_order enum symbols from stdatomic.h. If we add the enum
definition to wrapper.h ourselves, the error does not happen.

Before this commit, if the mismatch happened the following error could
come up:

  /usr/include/liburing/barrier.h:72:10: error: use of undeclared identifier 'memory_order_release'
  /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
  /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
  /usr/include/liburing/barrier.h:68:9: error: use of undeclared identifier 'memory_order_relaxed'
  /usr/include/liburing/barrier.h:65:17: error: use of undeclared identifier 'memory_order_relaxed'
  /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
  /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
  /usr/include/liburing/barrier.h:72:10: error: use of undeclared identifier 'memory_order_release'
  panicked at [..]/.cargo/registry/src/index.crates.io-6f17d22bba15001f/bindgen-cli-0.70.1/main.rs:45:36:
  Unable to generate bindings

To fix this (on my system) I would have to export CLANG_PATH and
LIBCLANG_PATH:

  export CLANG_PATH=/bin/clang-17
  export LIBCLANG_PATH=/usr/lib/llvm-17/lib

With these changes applied, bindgen is successful with both the
environment variables set and unset.

Since we're not using those symbols in the bindings (they are only used
by dependencies) this does not affect the generated bindings in any way.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/20241027-rust-wrapper-stdatomic-v2-1-dab27bbf93ea@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/wrapper.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/rust/wrapper.h b/rust/wrapper.h
index 77e40213efb..285d0eb6ad0 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -30,6 +30,23 @@
  * in order to generate C FFI compatible Rust bindings.
  */
 
+#ifndef __CLANG_STDATOMIC_H
+#define __CLANG_STDATOMIC_H
+/*
+ * Fix potential missing stdatomic.h error in case bindgen does not insert the
+ * correct libclang header paths on its own. We do not use stdatomic.h symbols
+ * in QEMU code, so it's fine to declare dummy types instead.
+ */
+typedef enum memory_order {
+  memory_order_relaxed,
+  memory_order_consume,
+  memory_order_acquire,
+  memory_order_release,
+  memory_order_acq_rel,
+  memory_order_seq_cst,
+} memory_order;
+#endif /* __CLANG_STDATOMIC_H */
+
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu-io.h"
-- 
2.47.0


