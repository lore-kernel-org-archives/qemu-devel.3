Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2E4C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZS8-0004tY-Pw; Tue, 03 Jun 2025 17:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZS5-0004t2-A4
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZS3-000660-N2
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MaRtQvyQVdxiccHruMjcY+PBk/KP5Z1xfXXYJBauOQ=;
 b=LkTWjCTn6qHX+1HVTcswP2ADoDcPHj4r8oPB9chejO4xVQG9vdkf8LkwiV3DYBQxBq0m+l
 dyEqeuET6UM7M4JE3OlWfod7bFuZ5CJqT9P+Bm0nIWPcNv1Dg5W4i4yZnJIOkSREVl3bNF
 62uqX0pYituGw5/k6WVQpwNCr6ux2EE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-GYrpHMJ3N6GXjp9klJ5t1A-1; Tue, 03 Jun 2025 17:45:41 -0400
X-MC-Unique: GYrpHMJ3N6GXjp9klJ5t1A-1
X-Mimecast-MFC-AGG-ID: GYrpHMJ3N6GXjp9klJ5t1A_1748987141
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a5058f9ef4so1187372f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987140; x=1749591940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MaRtQvyQVdxiccHruMjcY+PBk/KP5Z1xfXXYJBauOQ=;
 b=CukNKkhgUCfqgx0bo8lzTinU6sNqPhhzGcU0hbQp6CrAJojwYr7QiUM0cZ94ZmwK4d
 4fq9R7OB67SlJw9p3X2XH4Vq8+NSK8jP5BVrW4RJ9H14AuBi2g6NvI7cBS8Lm7ThGFfj
 fhvxvtU2mvCmmol0Y0CKLibChUFz60+JTJzhTbdb2UMzpPsuYv9wvqjSr+NHY/zmXM0w
 km/hyZSHTLc5sYWujHkZGJkg5XtBK8ieTUnBD2LYhwq1Hbwj3Zgd870xaOBDzkU5YwGK
 K5M5sHnJh5Cc2bMZoqI7aWuWgbTBpXkgmls9QhuJALKoVWpVVImn9qE7QzmU28yhTxHE
 hmUQ==
X-Gm-Message-State: AOJu0YwX/lzZz7mjJxnONtcKJvQduXMh8iFantjc9sTE4k7MC+2Evmb0
 OFpd85OPG0M6kG+yzmqFYZT2aLDab06vomXZ3NwLl7ofDw2Tlxi208hmf25jsJ5cFBJzwEMp96L
 x068T2Hd1bMdwram23/SJOUzb2Pwv3knQ9QPV6VSHg68NxoG0RzfnUbHwg0zcNeZN3ugQeGaThY
 1KG3sbKhbueKPpplLs3kCKRO2PeSd6BaivaL7C2Bl3
X-Gm-Gg: ASbGncuaQQLBXB9whfZzMlGZAQY62kumBOD8ibblvdvCt2sOcr0ZVokw9DM+lHzzCRI
 gX2Hr1KtDD0uYWDEgQ0Ipl+JJv6SfT7OUgtePwV+trs4I6uRgakYX8PWspWWUVBucwDAChl32Um
 RJYSIbFGRWgBslMvHbS2MX9F15ayuh/SOfzi5z+BTw6d8CQt5CzOGuzPVDqMcGROOa8z9pSCDSG
 cm6+YNt5EdJ4b3+KY6xxc10niRaNtiBejXpHHc5E+ytY9HKTpKIJ8CR8pKs0GHaOYXz49YRSfDa
 iqiwlF3lnn3D2OpkC4NVGn4d
X-Received: by 2002:a05:6000:22c6:b0:3a4:dc0a:5c0a with SMTP id
 ffacd0b85a97d-3a51dc313f1mr209952f8f.44.1748987139953; 
 Tue, 03 Jun 2025 14:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG05P8ZmTqAMqGL91GlY9Y1ZdnOa6gFSEjKz6PGEymCdavJe9jauizgWoh4RLlWquSr4fro/w==
X-Received: by 2002:a05:6000:22c6:b0:3a4:dc0a:5c0a with SMTP id
 ffacd0b85a97d-3a51dc313f1mr209935f8f.44.1748987139486; 
 Tue, 03 Jun 2025 14:45:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8ed27sm183202065e9.2.2025.06.03.14.45.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/16] rust: cell: remove support for running doctests with
 "cargo test --doc"
Date: Tue,  3 Jun 2025 23:45:13 +0200
Message-ID: <20250603214523.131185-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603214523.131185-1-pbonzini@redhat.com>
References: <20250603214523.131185-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


