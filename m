Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB7FC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrJq-0001EW-V0; Mon, 08 Apr 2024 11:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJf-0001By-Du
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJd-0001mo-UM
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=79a7jGvfDO7Nuy6O+o9VgLKVj6InbBKNyoXameAAwIQ=;
 b=UuKNv8sGHoFd/ByXu7oxAESSYwqkPD2g8jLivlnjcAhqUnn1Gv/6wHexFqdOYDrlu/Iufz
 XCGNseYcWMiF4QwTV3UStMT6fiL7jKLVQf1j4gYObMt6A5dcqcc40/jpAkCywYEsDpjikt
 tJqyGlymPbIpaELNLiWbhXKhLTE9+wg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-a8DdXFh_PGKMXwvvuHUxoQ-1; Mon, 08 Apr 2024 11:53:47 -0400
X-MC-Unique: a8DdXFh_PGKMXwvvuHUxoQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4147ddecd52so24119485e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591626; x=1713196426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79a7jGvfDO7Nuy6O+o9VgLKVj6InbBKNyoXameAAwIQ=;
 b=MvutPsbw6AUcNIn7cPSKNR9ULejxP0QsHzJ0WnCtL/Mdfw3Ko81XDpPHL8aDHtvSu8
 qebpBKlxZVGdzmfBKt8mbH7GbOZ5R5B3mBzPZiFJ/ixV8zc0gsWEr4skQA4YRe+Vpz4v
 TQDWzwYmqWdlQiwT6SRWLzb4Szjj2guaPdQHxDG0Jt4ScjtVwggBZOt/KuyBjcnsCSOC
 55oiuRn8J8vGXzqy4kE3ERcbjkPITKP3DG4yhGaJUe0F1NGlFE7X9fBGQJGju0xLoyTr
 25Yi9sjxeMpOTITt0yd4iYn2rfQrEsw8qhOxGT0hDyHMZwRCIQBZj5t7cn5W218rkTh3
 ucnw==
X-Gm-Message-State: AOJu0Yxl8RtLgOpO0g9USFwZOMrt2luo8+8b3ddk3lQbDwEZL50V+tta
 WM3gw13pC0OLNkPuUzWX3nlJYAATd5i8lfaSSfKWwxe5ipX48CXDeAJkq82nHgHt22uuKxjQBLE
 UQ2BVCqHzcmilv0N0YZmbsSkgg+4bSByK/koPRENJKFDJLLqjPuHOVCPL1jwaA2UJSnEaQ+41IM
 V/ytgIRBsok79leybyNLmPUL2USGCG0X6wk1mF
X-Received: by 2002:a05:600c:3511:b0:414:8ffb:a6bf with SMTP id
 h17-20020a05600c351100b004148ffba6bfmr55862wmq.18.1712591626168; 
 Mon, 08 Apr 2024 08:53:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9pby5yrYOx+zLbgIjZDWptPtSbnwRifWvzgLBkozQM8FYGpk54t/ZE2kLYFfJ+RlAq+BDPQ==
X-Received: by 2002:a05:600c:3511:b0:414:8ffb:a6bf with SMTP id
 h17-20020a05600c351100b004148ffba6bfmr55850wmq.18.1712591625914; 
 Mon, 08 Apr 2024 08:53:45 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a05600c468a00b00415f496b9b7sm14718561wmo.39.2024.04.08.08.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:53:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 04/18] tests/unit: match some unit tests to corresponding
 feature switches
Date: Mon,  8 Apr 2024 17:53:16 +0200
Message-ID: <20240408155330.522792-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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


