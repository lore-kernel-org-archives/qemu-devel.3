Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB102CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDeu-00018i-Mb; Wed, 27 Aug 2025 06:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDeE-000076-Sn
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDeB-0003M6-Cg
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756291490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6RfFR1+MhPYKxpFmzBGd/UaIwkpuqxjjVFphq00SEmA=;
 b=BG33BSylq66W96PH8gXPV9gvq7nXqglR0arMx/bk7mNnjoT4nruj6ZTSshOpt+rs1UJx5y
 svbJnqF5MYtWp4ipfkHaIeU7+ufCnyc/RMjPnY5TI8yO2ynZN19PCyroMOffoBrLCiD4tO
 8rWK1Wrt9fJd2GPGYXlny5kKhtkpzNA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-8rlkKs1COKq4n1Wjr_eDtw-1; Wed,
 27 Aug 2025 06:44:46 -0400
X-MC-Unique: 8rlkKs1COKq4n1Wjr_eDtw-1
X-Mimecast-MFC-AGG-ID: 8rlkKs1COKq4n1Wjr_eDtw_1756291485
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B0151800346; Wed, 27 Aug 2025 10:44:45 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E0BB1800447; Wed, 27 Aug 2025 10:44:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 22/22] docs: update rust.rst
Date: Wed, 27 Aug 2025 14:41:44 +0400
Message-ID: <20250827104147.717203-23-marcandre.lureau@redhat.com>
In-Reply-To: <20250827104147.717203-1-marcandre.lureau@redhat.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/rust.rst | 61 ++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 1e77a1c2b1..92378b3ff6 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -115,15 +115,18 @@ anymore.
 Writing Rust code in QEMU
 -------------------------
 
-QEMU includes four crates:
+QEMU includes several crates:
 
-* ``qemu_api`` for bindings to C code and useful functionality
+* ``common`` provides Rust-only utilities
 
-* ``qemu_api_macros`` defines several procedural macros that are useful when
+* ``bql``, ``chardev``, ``hw/core``, ``migration``, ``qom``, ``system``,
+  ``util`` for bindings to respective QEMU C library APIs
+
+* ``qemu_macros`` defines several procedural macros that are useful when
   writing C code
 
 * ``pl011`` (under ``rust/hw/char/pl011``) and ``hpet`` (under ``rust/hw/timer/hpet``)
-  are sample devices that demonstrate ``qemu_api`` and ``qemu_api_macros``, and are
+  are sample devices that demonstrate Rust binding usage and ``qemu_macros``, and are
   used to further develop them.  These two crates are functional\ [#issues]_ replacements
   for the ``hw/char/pl011.c`` and ``hw/timer/hpet.c`` files.
 
@@ -136,7 +139,7 @@ This section explains how to work with them.
 Status
 ''''''
 
-Modules of ``qemu_api`` can be defined as:
+The stability of the modules can be defined as:
 
 - *complete*: ready for use in new devices; if applicable, the API supports the
   full functionality available in C
@@ -152,26 +155,26 @@ Modules of ``qemu_api`` can be defined as:
 
 The status of the modules is as follows:
 
-================ ======================
-module           status
-================ ======================
-``assertions``   stable
-``bitops``       complete
-``callbacks``    complete
-``cell``         stable
-``errno``        complete
-``error``        stable
-``irq``          complete
-``log``          proof of concept
-``memory``       stable
-``module``       complete
-``qdev``         stable
-``qom``          stable
-``sysbus``       stable
-``timer``        stable
-``vmstate``      proof of concept
-``zeroable``     stable
-================ ======================
+========================== ======================
+module                     status
+========================== ======================
+``bql::cell``              stable
+``common::assertions``     stable
+``common::bitops``         complete
+``common::callbacks``      complete
+``common::errno``          complete
+``common::zeroable``       stable
+``hwcore::irq``            complete
+``hwcore::qdev``           stable
+``hwcore::sysbus``         stable
+``migration::vmstate``     proof of concept
+``qom``                    stable
+``system::memory``         stable
+``util::error``            stable
+``util::log``              proof of concept
+``util::module``           complete
+``util::timer``            stable
+========================== ======================
 
 .. note::
   API stability is not a promise, if anything because the C APIs are not a stable
@@ -272,7 +275,7 @@ to go from a shared reference to a ``&mut``.
 
 Whenever C code provides you with an opaque ``void *``, avoid converting it
 to a Rust mutable reference, and use a shared reference instead.  The
-``qemu_api::cell`` module provides wrappers that can be used to tell the
+``bql::cell`` module provides wrappers that can be used to tell the
 Rust compiler about interior mutability, and optionally to enforce locking
 rules for the "Big QEMU Lock".  In the future, similar cell types might
 also be provided for ``AioContext``-based locking as well.
@@ -304,7 +307,7 @@ the wrapper to be declared thread-safe::
 Writing bindings to C code
 ''''''''''''''''''''''''''
 
-Here are some things to keep in mind when working on the ``qemu_api`` crate.
+Here are some things to keep in mind when working on the QEMU Rust crate.
 
 **Look at existing code**
   Very often, similar idioms in C code correspond to similar tricks in
@@ -367,7 +370,7 @@ from the type after ``as`` in the invocation of ``parse_macro_input!``::
             .into()
     }
 
-The ``qemu_api_macros`` crate has utility functions to examine a
+The ``qemu_macros`` crate has utility functions to examine a
 ``DeriveInput`` and perform common checks (e.g. looking for a struct
 with named fields).  These functions return ``Result<..., syn::Error>``
 and can be used easily in the procedural macro function::
@@ -408,7 +411,7 @@ Right now, only the nightly version of ``rustfmt`` is supported.  This
 might change in the future.  While CI checks for correct formatting via
 ``cargo fmt --check``, maintainers can fix this for you when applying patches.
 
-It is expected that ``qemu_api`` provides full ``rustdoc`` documentation for
+It is expected that QEMU Rust crates provides full ``rustdoc`` documentation for
 bindings that are in their final shape or close.
 
 Adding dependencies
-- 
2.50.1


