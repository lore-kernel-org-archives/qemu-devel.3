Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B65ECA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uquKs-0007DD-DK; Tue, 26 Aug 2025 10:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquKW-0006uP-Bw
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquJx-0007DC-3A
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756217199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTw9sLe7ru4Kf+wSu6PiTS6mpdXGTr9mFOwfKJLy9zs=;
 b=gkcyX9Zbi91AIX4AqIqJpx+kyX3qW9us1UqZh5F3h5oig226JZ1wlE2wD7g2nV7g+iPKH4
 vszYZMsa8NbyS5L/LZddlavoY5zWc58B36rRsVMKmGpwg0c0fFOS5zA1o1SuPvRZYGPctM
 QQL6Pn5rHktPnx4Qr9Cj2hsjpCvLSHc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-Q_dOJmA2PEyYIBMiU_3_4g-1; Tue,
 26 Aug 2025 10:06:38 -0400
X-MC-Unique: Q_dOJmA2PEyYIBMiU_3_4g-1
X-Mimecast-MFC-AGG-ID: Q_dOJmA2PEyYIBMiU_3_4g_1756217197
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0072019560A2; Tue, 26 Aug 2025 14:06:37 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F14A1800447; Tue, 26 Aug 2025 14:06:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC 18/18] docs: update rust.rst
Date: Tue, 26 Aug 2025 18:04:46 +0400
Message-ID: <20250826140449.4190022-19-marcandre.lureau@redhat.com>
In-Reply-To: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

---
 docs/devel/rust.rst | 51 ++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index b6737536c6..e7967ff7be 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -115,11 +115,14 @@ anymore.
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
+``common::zeroable``       stable
+``hwcore::irq``            complete
+``hwcore::qdev``           stable
+``hwcore::sysbus``         stable
+``migration::vmstate``     proof of concept
+``qom``                    stable
+``system::memory``         stable
+``util::errno``            complete
+``util::error``            stable
+``util::log``              proof of concept
+``util::module``           complete
+``util::timer``            stable
+========================== ======================
 
 .. note::
   API stability is not a promise, if anything because the C APIs are not a stable
-- 
2.50.1


