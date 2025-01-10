Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432A9E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2z-0001Fy-CI; Fri, 10 Jan 2025 13:47:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK22-0000FE-BR
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1y-00016W-5X
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yyNO/JTwvXtw4mxmLChlF/whck0cJNX1PORaIe032Kw=;
 b=SnD7tT270G72zMcKXjAVvrtvzkP/jp/ryqRzVIt3aq91s8DIrFj65lcnoN4ZbbkDSMnhIH
 qoaq8PVkPq1KNDS/DtN6il2Kb1s0ci4wa3I6JUrdkKR5MKVTtXBWfzSpczrkIZSennDl04
 aO+DAR4Fd//dPghsW8V0+ElCs4FihH0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-QVZ9-NVoPSeA8xFFXH49jg-1; Fri, 10 Jan 2025 13:46:46 -0500
X-MC-Unique: QVZ9-NVoPSeA8xFFXH49jg-1
X-Mimecast-MFC-AGG-ID: QVZ9-NVoPSeA8xFFXH49jg
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aab954d1116so237129466b.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534804; x=1737139604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yyNO/JTwvXtw4mxmLChlF/whck0cJNX1PORaIe032Kw=;
 b=ho1vyIJf98SfCJIlViK0o1bXiYlgbk4ZxeUvomT1tDv4QFqcde8DjlxA/jauY1JrMe
 PJVtlUUQ4wAkbkza6OOMZWAiDga+9KHZhQv8TsrXY1xHNjwAyUDn3SumgSuA/rmylhiY
 CIccWLRM6ujpZAZ3nlryaWWOkULCZ3uL+A9/aCp6IyE+o/FcVkjv6jCve8zrC5+kQxyw
 HBoRAsTyAUEWdalD4jWFV9S5/cYLvHE9o6mPke5Nmo+QN7rrPuTNc3qOcwO6EwTlZQ6R
 1u2l5U9yROHngck0zlYuJs4sfbpzS6p0TJb01LbXBtZo3BAF7UPVZXwxYYaPtAb9rXcH
 t2iw==
X-Gm-Message-State: AOJu0Yy5xkpKSrvLfXhlHVZbDVIvTvEz9LlDgVXvA9hEfdQVr5h6QsVx
 SXGEQBIPoYRHnicLfGtRDHIbZweuyO0XOA0C1LsIOQkboXBSIi6laWvgOqpM6K804wZBfe99sXh
 wzf9nP1YVXRYCXkZRXCez/zuUvELz2Ku474/9DXUru+k9z0BW1bxYt/m0zXpFHlZqh+pWeI38Su
 yzf6XSfjy3RpD93IjBWyP/hzfTx5mEi36GY+v0j8w=
X-Gm-Gg: ASbGncucMVgupFEx/fq5VKhiO6pZCmBlJbyquo/1UVZZ5XUz4vrIfoNIVGbeMjdeY1n
 DjiOw2aoiP9cT8KgHvmvoXcN7YmXODIU7EiEy0OLcNz4RxzmAQoAMRl7i/Yh2qLpM9MyNAwF74o
 5dTd6gtYuZzLMbyB1rl3UlRmCun3CgAH9GNSAKci1ECT390tFyGQQGx0Ed102HWeK3hpo4Lnrwu
 5mi2dV3jx90YgYi7xqt8RQGA+wsxNNTfwKlLvRlOv4yePXLv32o8St9fsA=
X-Received: by 2002:a17:907:3da1:b0:aaf:3f57:9d2e with SMTP id
 a640c23a62f3a-ab2aaaf6571mr1070985866b.0.1736534804237; 
 Fri, 10 Jan 2025 10:46:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+EbD5AWg+0Aviz6NYcbc6h9WY6tyecY758T69z79KF5nM936PvF/63yBLePnhWQC3laN2hA==
X-Received: by 2002:a17:907:3da1:b0:aaf:3f57:9d2e with SMTP id
 a640c23a62f3a-ab2aaaf6571mr1070983866b.0.1736534803802; 
 Fri, 10 Jan 2025 10:46:43 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90dace5sm196437966b.60.2025.01.10.10.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 10/38] rust: qom: make INSTANCE_POST_INIT take a shared
 reference
Date: Fri, 10 Jan 2025 19:45:51 +0100
Message-ID: <20250110184620.408302-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 4 ++--
 rust/qemu-api/src/qom.rs         | 8 ++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 72a4cea042c..6792d13fb77 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -145,7 +145,7 @@ impl ObjectImpl for PL011State {
     type ParentType = SysBusDevice;
 
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
-    const INSTANCE_POST_INIT: Option<fn(&mut Self)> = Some(Self::post_init);
+    const INSTANCE_POST_INIT: Option<fn(&Self)> = Some(Self::post_init);
 }
 
 impl DeviceImpl for PL011State {
@@ -206,7 +206,7 @@ unsafe fn init(&mut self) {
         }
     }
 
-    fn post_init(&mut self) {
+    fn post_init(&self) {
         let sbd: &SysBusDevice = self.upcast();
 
         sbd.init_mmio(&self.iomem);
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index b0332ba2477..97901fb9084 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -163,11 +163,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
     // SAFETY: obj is an instance of T, since rust_instance_post_init<T>
     // is called from QOM core as the instance_post_init function
     // for class T
-    //
-    // FIXME: it's not really guaranteed that there are no backpointers to
-    // obj; it's quite possible that they have been created by instance_init().
-    // The receiver should be &self, not &mut self.
-    T::INSTANCE_POST_INIT.unwrap()(unsafe { &mut *obj.cast::<T>() })
+    T::INSTANCE_POST_INIT.unwrap()(unsafe { &*obj.cast::<T>() })
 }
 
 unsafe extern "C" fn rust_class_init<T: ObjectType + ClassInitImpl<T::Class>>(
@@ -463,7 +459,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
 
     /// Function that is called to finish initialization of an object, once
     /// `INSTANCE_INIT` functions have been called.
-    const INSTANCE_POST_INIT: Option<fn(&mut Self)> = None;
+    const INSTANCE_POST_INIT: Option<fn(&Self)> = None;
 
     /// Called on descendent classes after all parent class initialization
     /// has occurred, but before the class itself is initialized.  This
-- 
2.47.1


