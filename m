Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E23C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHml-0004Mw-Ky; Tue, 23 Apr 2024 11:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHma-0004KV-FD
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmW-0008Lj-93
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nllsduu/a1clNlrIq9gPvJYfEJVxtCf5waO87JwB0V8=;
 b=g4kaR1G6We0OPJG6rctF/0I1Spoaj7V7zf9jUp4FrJZBttDGCfdMZvgy9ICElNzCPzgG3Y
 eglLepRbgNQHeQzHYUOsF++YpMM5vpn8quJeblpqCPT//slt1QVNbceCGbE4MoOd+paMEo
 bDjbfo9hlceg8bzxDyDrbAvi5JuiX5A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-yfJm5E_1MzOoeHKA0MVhMA-1; Tue,
 23 Apr 2024 11:09:59 -0400
X-MC-Unique: yfJm5E_1MzOoeHKA0MVhMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 490C33C23FC3;
 Tue, 23 Apr 2024 15:09:59 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB4AE200AFA2;
 Tue, 23 Apr 2024 15:09:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/63] tests/unit: match some unit tests to corresponding
 feature switches
Date: Tue, 23 Apr 2024 17:08:52 +0200
Message-ID: <20240423150951.41600-5-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

Try not to test code that is not used by user mode emulation, or by the
block layer, unless they are being compiled; and fix test-timed-average
which was not compiled with --disable-system --enable-tools.

This is by no means complete, it only touches the more blatantly
wrong cases.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240408155330.522792-5-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/unit/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 228a21d03c2..26c109c968c 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -18,7 +18,6 @@ tests = {
   'test-forward-visitor': [testqapi],
   'test-string-input-visitor': [testqapi],
   'test-string-output-visitor': [testqapi],
-  'test-opts-visitor': [testqapi],
   'test-visitor-serialization': [testqapi],
   'test-bitmap': [],
   'test-resv-mem': [],
@@ -46,12 +45,8 @@ tests = {
   'test-qemu-opts': [],
   'test-keyval': [testqapi],
   'test-logging': [],
-  'test-uuid': [],
-  'ptimer-test': ['ptimer-test-stubs.c', meson.project_source_root() / 'hw/core/ptimer.c'],
   'test-qapi-util': [],
   'test-interval-tree': [],
-  'test-xs-node': [qom],
-  'test-virtio-dmabuf': [meson.project_source_root() / 'hw/display/virtio-dmabuf.c'],
 }
 
 if have_system or have_tools
@@ -97,6 +92,8 @@ if have_block
     'test-crypto-ivgen': [io],
     'test-crypto-afsplit': [io],
     'test-crypto-block': [io],
+    'test-timed-average': [],
+    'test-uuid': [],
   }
   if gnutls.found() and \
      tasn1.found() and \
@@ -131,10 +128,13 @@ endif
 
 if have_system
   tests += {
+    'ptimer-test': ['ptimer-test-stubs.c', meson.project_source_root() / 'hw/core/ptimer.c'],
     'test-iov': [],
+    'test-opts-visitor': [testqapi],
+    'test-xs-node': [qom],
+    'test-virtio-dmabuf': [meson.project_source_root() / 'hw/display/virtio-dmabuf.c'],
     'test-qmp-cmds': [testqapi],
     'test-xbzrle': [migration],
-    'test-timed-average': [],
     'test-util-sockets': ['socket-helpers.c'],
     'test-base64': [],
     'test-bufferiszero': [],
-- 
2.44.0



