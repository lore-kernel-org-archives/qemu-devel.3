Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7B4C54FC6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 00:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skuY2-0008IS-29; Sun, 01 Sep 2024 20:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1skuY0-0008HR-Gp
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 20:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1skuXy-0004CS-DP
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 20:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725235429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B8BWBynZiqu5W0tPrxT2WqoU5n0IrKBPLt4KWbMfpz8=;
 b=hZoazc9hNxWGx9Atc8phupBqzWJpQaje2pjQz7EPS153iQOsX8pUfjYLM+nMTT/O4CuaUp
 0TUX7YVkofgaHxFfXFajnOt490HMml/r5IX/mkKH7GU/oWBf90AK0OvtAQB+e8nC0pR2gG
 6gQRUr3DCYNLWor5jPQD6EaLNb9yJh4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-Ov8PpLReNhSFeC0s34Bdew-1; Sun, 01 Sep 2024 20:03:48 -0400
X-MC-Unique: Ov8PpLReNhSFeC0s34Bdew-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374c434b952so635355f8f.1
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2024 17:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725235426; x=1725840226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B8BWBynZiqu5W0tPrxT2WqoU5n0IrKBPLt4KWbMfpz8=;
 b=Zp5jBth35J5tENkbEdTXDolF2lRtmL3TFzEyDPJWuclVh0TtEHbEVwSaBryJWDpur7
 Lc+orBi54UjMQVgFOlGjcVNzE7+gRBPn+lm9Ka6H5KUMsb60jHEt3WklEpzxmGxcKaBb
 CkVV1yWyM7IlGsvmpgqV8IiLTCck8qTsqgm4JH+pjIQFbBocoA2HdXYURGRQ3qjoIms6
 kqoOlD4eMXYpH+b8un08KPdVZX6XoTAAFQ05K4XPn2WnaJQepW9eVvsobp6S14x68nYO
 gHZrBxd5Za1R88LhdJLLhCwWCIoz/wRr3g+cITdEvjfYXgDrTzNV//6Fy0P+8R3qkx2b
 HK3A==
X-Gm-Message-State: AOJu0Ywe+EBIT0uG8PcQUObKVRXB+SAbuimJteCAlviGxvYmqIFeAPIC
 iedfziNm7JORoupU+AIhNxRcpwEdBD1ISM6tFTt/GqV0wg17SQBmAFYukxcNH48oNwxQDxfXt/q
 Me3TvmIcw4RN0HVyo4iS4HM7sDBSnn1/lNKQAeMIRzs+J0Zi+BRXPUwhGTEbLCd1HqAX8C76dzX
 0l3M4Y1BIhkxI5xeZQbel7zh9kO/wrg0/fOe7KC7g=
X-Received: by 2002:adf:9c8b:0:b0:36c:ff0c:36d7 with SMTP id
 ffacd0b85a97d-374bef3a257mr4220604f8f.2.1725235425657; 
 Sun, 01 Sep 2024 17:03:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNpK0aYBnPtuRmJ0SVxHUCYRULi7xBQztXCsGUw9GMkcg7dA9qaiL0i1CRwV+/d1e2bH3Rpw==
X-Received: by 2002:adf:9c8b:0:b0:36c:ff0c:36d7 with SMTP id
 ffacd0b85a97d-374bef3a257mr4220590f8f.2.1725235425010; 
 Sun, 01 Sep 2024 17:03:45 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c226c7c32dsm4549226a12.48.2024.09.01.17.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 17:03:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Richard W.M. Jones" <rjones@redhat.com>
Subject: [PATCH] tests/unit: remove block layer code from test-nested-aio-poll
Date: Mon,  2 Sep 2024 02:03:43 +0200
Message-ID: <20240902000343.54021-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

GCC is reporting a NULL pointer dereference when compiling aio_wait_kick()
with LTO.

The issue is that test-nested-aio-poll.c does not call qemu_init_main_loop().
It doesn't _need_ to because it never calls AIO_WAIT_WHILE(), but it seems
that LTO does not do enough dead-code elimination to catch that.

Fortunately aio_wait_kick() is only used in few places, and only in block
layer or system emulation code; and this test only needs the core event loop
functionality.  It does not even need iothreads.   So remove everything that
calls aio_wait_kick(), which is nice for coverage compared to adding the call
to qemu_init_main_loop().

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2434
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/unit/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 490ab8182dc..6c377917636 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -115,7 +115,7 @@ if have_block
   if host_os != 'windows'
     tests += {
       'test-image-locking': [testblock],
-      'test-nested-aio-poll': [testblock],
+      'test-nested-aio-poll': [],
     }
   endif
   if config_host_data.get('CONFIG_REPLICATION')
-- 
2.46.0


