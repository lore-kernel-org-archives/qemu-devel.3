Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34D3C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQwY-0002Kr-6q; Mon, 10 Feb 2025 05:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwX-0002Kh-EP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwV-0000LI-Sy
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739182986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kI2fmnmJgUGnjqtQ5jhxKS9I/PiFpAzsz1KC537irc=;
 b=Phx5Een57gJ/MgMw8vgc4g5HnXgmE2CugK9IyX9z1TSjiC2BRj4D0KXAzGwle7dgLhCNrs
 4YqTPNx+NK6Z5PrycRzr7icPoH3TAHxh2flR2Fu7vnuEuGzMC168FLgPO5zxMW63pNSV72
 7HxSc5lsy+9144mMF+2Nb3VM4Jk+Acw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-hwpK8irYOrqIgdBkQBCEaQ-1; Mon, 10 Feb 2025 05:23:03 -0500
X-MC-Unique: hwpK8irYOrqIgdBkQBCEaQ-1
X-Mimecast-MFC-AGG-ID: hwpK8irYOrqIgdBkQBCEaQ
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab7a3a033b4so129709366b.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739182981; x=1739787781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3kI2fmnmJgUGnjqtQ5jhxKS9I/PiFpAzsz1KC537irc=;
 b=Rxy8YNNyY/f6VG9qUpDXVPuJv/mzaxMdWW3Bf3OoFE1IDiB3tHbZJYYq1dsTEKVBHg
 x51hX2oTaMBmkWiAjqPB+aVWXR0x5BduSUH0hwGU1VaeriOTJv30iqZyyXUhDB3Qip2v
 RMkwyhN+fZmuHRBXCE8VW5WC90MCTDnQzxu5n7nk/mqXpD/COibaElGCXIB+o6hjJ2Rd
 iB/9j2Rgf+/4UDUpZWe6r1Z1cnbJEbhhLv4Z+0Gh68hifQdP7iWXCJAgYNapf8PM86CQ
 /Wc4gqHVXwNrH00bKOf3+G7Cvr9dh5YeOe4m4s93SU+coq4zYi/+EK83sZT2wRbB3bv7
 euQQ==
X-Gm-Message-State: AOJu0Yx4yVWoCOBT2muvFn7wgEsZ1nfRlEiY0Mb7eCFEvZRyPAu/SDbn
 3gSETE08adbk3UTC0LXT0qNrWxUyp1ETQlQARuY1DQKLrpB1fcGDXAxkklzZyMQD24lZtAYz6p5
 elO/vppu5jU6bpfj9aL9uMycYRzXdQ7J+5XLAL4xKdTv3vGDo2kIjfexSsdFne343cVndXLtRSw
 3qCqcOCYKMLUBusEz1Hzx4SpmwxJmWVdGlLLXGXnA=
X-Gm-Gg: ASbGnctcEURc6Wj+jFbRGPOBPrgBppwxlUlAJkF8jThXAAKp4XEaFhSuNRPlqzhX+EB
 xmtm4+yZksFbV3HHfUBOLrytOWzsUhSZz91NGp3x4mRjaQahnLi7dmiYW/vC6aBlYhbpCTV8AHl
 RtqewMYbbgnggsVoneFAlbes7skho68lUICaePELv3dihGTsXFcchyl+WmZIkk3K+kXrTSl/hqm
 d10A8pYNI6AHjtj4S3vSSNfiDo7QumxEA75F1wjFp4+VOi9d61MYPnl9EVOlGdKaDnXvDqXdQdL
 akGqkA==
X-Received: by 2002:a17:907:1c95:b0:ab7:c94f:af87 with SMTP id
 a640c23a62f3a-ab7c94fb336mr217388566b.16.1739182981306; 
 Mon, 10 Feb 2025 02:23:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWBADpk9Vdt5YkfFx+tF4N7pRZWyo3pMmuCDIbXW1+Lyg05wle11lZt0QrgGTsG1WB4gn6/A==
X-Received: by 2002:a17:907:1c95:b0:ab7:c94f:af87 with SMTP id
 a640c23a62f3a-ab7c94fb336mr217386166b.16.1739182980771; 
 Mon, 10 Feb 2025 02:23:00 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7809a2ec4sm770242466b.116.2025.02.10.02.23.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 02:23:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] rust: include rust_version in Cargo.toml
Date: Mon, 10 Feb 2025 11:22:47 +0100
Message-ID: <20250210102255.2555097-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210102255.2555097-1-pbonzini@redhat.com>
References: <20250210102255.2555097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

Tell clippy the minimum supported Rust version for QEMU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/Cargo.toml          | 1 +
 rust/hw/char/pl011/src/device_class.rs | 1 -
 rust/qemu-api-macros/Cargo.toml        | 1 +
 rust/qemu-api/Cargo.toml               | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 2b4097864df..f2296cad58b 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -9,6 +9,7 @@ resolver = "2"
 publish = false
 keywords = []
 categories = []
+rust-version = "1.63.0"
 
 [lib]
 crate-type = ["staticlib"]
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 8a157a663fb..dbef93f6cb3 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -12,7 +12,6 @@
 
 use crate::device::{PL011Registers, PL011State};
 
-#[allow(clippy::missing_const_for_fn)]
 extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
     let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
     unsafe { state.as_ref().migrate_clock }
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
index b9b4baecddb..89dee1cfb39 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -9,6 +9,7 @@ resolver = "2"
 publish = false
 keywords = []
 categories = []
+rust-version = "1.63.0"
 
 [lib]
 proc-macro = true
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 4aa22f31986..a51dd142852 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -12,6 +12,7 @@ resolver = "2"
 publish = false
 keywords = []
 categories = []
+rust-version = "1.63.0"
 
 [dependencies]
 qemu_api_macros = { path = "../qemu-api-macros" }
-- 
2.48.1


