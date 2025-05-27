Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257AFC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxj0-0005i6-5X; Tue, 27 May 2025 13:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxix-0005fq-4A
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxiv-0006hD-GP
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748365460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MaRtQvyQVdxiccHruMjcY+PBk/KP5Z1xfXXYJBauOQ=;
 b=GnzI07iP6ZMJpPrkULIORdcEUORAygWWHyI8SpzlTWOv4EAKFopm2rYYA+Bjyx0GTC+FR8
 VpMPZ4MY6jFkDKHiO38UEJJmIYcZArRPVlysI+v2KphWmAitUmEX8adHDYeC3DEjyRg4/G
 yyG4M1amXUcN9b75VgaIXyzZbZcAhk4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-i7zzO9H6Pa2oYhkQUeaKow-1; Tue, 27 May 2025 13:04:18 -0400
X-MC-Unique: i7zzO9H6Pa2oYhkQUeaKow-1
X-Mimecast-MFC-AGG-ID: i7zzO9H6Pa2oYhkQUeaKow_1748365458
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad5271a051eso339088666b.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 10:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748365456; x=1748970256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MaRtQvyQVdxiccHruMjcY+PBk/KP5Z1xfXXYJBauOQ=;
 b=OW2BoCHd3q2K+c7ZahfW23PEjTarSG5GMrkrA/n9JeHbcZ518RCkMMGW79/PfFTFAt
 Fu+NK6Wq82NhCUqcnDqw2hiG5VacqRKFZImxzu3Uk07U+Vl5EIVJjXX9gsOQkIJ7pOVz
 Xx+VeFB+Ux4Ccfd+aYczeP1tBy/g6vHm2TsSqbYXrENQXIoZMR1LjDYx2jnzdXgT//k5
 oyZSoNFPpRZOsELbqnPkjG0bmo4INpem3Gj0pyMs9I7fAg0s2xPGbWKoLN0rwr/K0dZd
 yNhGGOkfYG0A5CEgMn4hTICPaYvh7r6zLql5TYBMr5Qfl6lhrRYOXb6pOPFXO+OoLaME
 Afsw==
X-Gm-Message-State: AOJu0Yw5BKCwqL/0HTzcs577JVETsMyfcsRippqFWNmSBcoGeI2SJDLH
 zyjMpLPveYJVnxMQXlsJ+zRUbciHeO35EOt1nmKbIPj/BwHGe8HA7NW6ZbpiPXsXNvArZ8XC4fC
 cIN0HAy+ShWBn4934Z8CT9oFL9yg0eUMlpx//mXsVGMxrz2y0xot2z/KZZf3M0sTbc0aS1IQ1yl
 Eoo6dxvg3AEjl39HA9fs5CmzJukaD8WfpJfHucUSl5
X-Gm-Gg: ASbGnctFC1fVo7cY0YmWIoUlIx7QVhVl8AlgeHUy9Y189HhWqxMLwjJlP1Otumgrnhj
 +t/nqjihO2dx4LSsy2xq/50osPV4EF9ouF+2GlpvMQCEuV55DHtBZEABDptfDzDuiRNRutF+AAt
 0aD/RQlXiFWihYh5YaAh1i5lTK0xBZh7miEM0fE2UnijwUMOAPLef4wkitq8Yg3Dc1/WY7qo8CK
 ZRoPyiBEha/9benFbbFIWRDXFOLAfZod4twi/yohjC85XyLYkjY6A32FXVSd28hjghzLVoLisFU
 oewl1a5SH67cwQ==
X-Received: by 2002:a17:907:d716:b0:ad5:6b8a:a0a6 with SMTP id
 a640c23a62f3a-ad85b319ab8mr1346044866b.58.1748365456499; 
 Tue, 27 May 2025 10:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/I/4u//Q0qm0idcjRPra2TwV54TBZPShO+oKHsdDkuUuySCPF+/QW+NybXVZM/H9yZmKMhA==
X-Received: by 2002:a17:907:d716:b0:ad5:6b8a:a0a6 with SMTP id
 a640c23a62f3a-ad85b319ab8mr1346038766b.58.1748365455967; 
 Tue, 27 May 2025 10:04:15 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d438086sm1864422766b.89.2025.05.27.10.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 10:04:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 5/6] rust: cell: remove support for running doctests with
 "cargo test --doc"
Date: Tue, 27 May 2025 19:04:03 +0200
Message-ID: <20250527170404.1580482-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527170404.1580482-1-pbonzini@redhat.com>
References: <20250527170404.1580482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is not needed anymore now that tests link with libqemuutil.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/cell.rs | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 05ce09f6cb6..27063b049d5 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -225,27 +225,23 @@
 
 /// An internal function that is used by doctests.
 pub fn bql_start_test() {
-    if cfg!(MESON) {
-        // SAFETY: integration tests are run with --test-threads=1, while
-        // unit tests and doctests are not multithreaded and do not have
-        // any BQL-protected data.  Just set bql_locked to true.
-        unsafe {
-            bindings::rust_bql_mock_lock();
-        }
+    // SAFETY: integration tests are run with --test-threads=1, while
+    // unit tests and doctests are not multithreaded and do not have
+    // any BQL-protected data.  Just set bql_locked to true.
+    unsafe {
+        bindings::rust_bql_mock_lock();
     }
 }
 
 pub fn bql_locked() -> bool {
     // SAFETY: the function does nothing but return a thread-local bool
-    !cfg!(MESON) || unsafe { bindings::bql_locked() }
+    unsafe { bindings::bql_locked() }
 }
 
 fn bql_block_unlock(increase: bool) {
-    if cfg!(MESON) {
-        // SAFETY: this only adjusts a counter
-        unsafe {
-            bindings::bql_block_unlock(increase);
-        }
+    // SAFETY: this only adjusts a counter
+    unsafe {
+        bindings::bql_block_unlock(increase);
     }
 }
 
-- 
2.49.0


