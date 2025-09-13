Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BC3CAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLNJ-0002KA-Em; Sat, 13 Sep 2025 04:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMc-0000l6-ET
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMY-0005BQ-Vw
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xf154j2uS3gv+OhD8JPEgOnYpqedsHX6I94geXljhC0=;
 b=LRKz11iKkUY7hYu0bx64k55Uc7jRPHTlhsWd9qe22yDfLUpJWPhl8/KLJ7JnEZpnIDxrIj
 DI3on57MYDpDJTVzXNzpfH5Rg23/iWHB5PDizo+eYlXwhD9KD0UjFfa/1IkP5o2h9lZtr/
 SX7H+mCJMjly0XLUusRNZwwgwHPHQdE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-gVGeJKtdPvmBJ7Gc9a9Dnw-1; Sat, 13 Sep 2025 04:12:00 -0400
X-MC-Unique: gVGeJKtdPvmBJ7Gc9a9Dnw-1
X-Mimecast-MFC-AGG-ID: gVGeJKtdPvmBJ7Gc9a9Dnw_1757751119
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45dcf5f1239so11709135e9.2
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751118; x=1758355918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xf154j2uS3gv+OhD8JPEgOnYpqedsHX6I94geXljhC0=;
 b=q1Y6cSalDeq2AuR2QCS7UI+0yvDlzR0znLtOkUyxEvh+WGVr2EdU2p7smhfUT2a33j
 YbyvQfpmpbelL1vocp0VrddbRsHx2IECQQZ/T1y0N8aF80Xg261eAkcVToHE4isEXvO5
 tGtZKZa06oLFfWHS8O2D5Bp6y7JNAzgwl/zz6WwFOmBSZm4aEM+VLy54sbN494MYF8x4
 x53kPoHZ3AyFyuY/ET+ZaxnsmiGkYCPUFSqLDhjnxUwG76yplScQWgj+gSA5jOWTE15b
 l/LOGCYUHG5WgDW84zqeJoH3AJQdckdLI+rc6Gl/NQ3HGvBEhxvRbRUwdumkHMR5P5dV
 GDUw==
X-Gm-Message-State: AOJu0Yzh7hxm85yto339l9wfYGALAXtevVHTKJQ9ocCH7AVg9rQOOels
 em1ocamnKljz7flR5xSdVb+lMF30h7bEFEITHIlhBP53RzTczqvdD/QaQaLlEz6wOPqd0oZNZEf
 E2lToXzC/3IZ94mCycwG1FZrWbIUdC+d7GSHGLlvNMXUZDMIHqmUxTT5yizuECjMMd4XJuiuHqO
 SfxdBoY5oWfxfQcmAZczxBN4gOxePtEFQMMqBCbedj
X-Gm-Gg: ASbGncsnU2ItFJ/dTIDa5QP1NXkTQG9fRgxA+dx6hsrIag3LmNLMffLZmDh3N0WGSLQ
 bfac6OflXuszyQjIP95tRnPOy8rQsbr2ZXHcvImliGf1hCssw4MCYe1RRqv3LFGC3cvklLpyjwE
 5xep/gSVkzjZoQrc39Mu5sEAp80S+vLN+A9papKCBuT+T81zF9KqA7kjcB0KQo3EcO6+tben+Pu
 fm9DnZbhXln2EOhKNTBhzc8hXnNaNlvHzTF9SdeSzw4gExsfqSA+mC7mokEZnssycJQhXFAayac
 yz2fbDLazCildcAR9v7+dhSxYDtnuSkbg/cehDszsTKGmDtokZTA3P9esdAXLG02cVBxtjyKw6U
 2r0ScIAu/KOsmiT2+KkouRu1kISfNCd5Y1CYd298Geaw=
X-Received: by 2002:a05:6000:607:b0:3e7:5f26:f1e5 with SMTP id
 ffacd0b85a97d-3e7657c4d40mr4644184f8f.23.1757751117654; 
 Sat, 13 Sep 2025 01:11:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVt5nh59h8ek2PXoEwrc50XONu76yhoqvnC7fTXAex//7QK9J6SCCB+PNHpCLv+bA09scKnA==
X-Received: by 2002:a05:6000:607:b0:3e7:5f26:f1e5 with SMTP id
 ffacd0b85a97d-3e7657c4d40mr4644160f8f.23.1757751117276; 
 Sat, 13 Sep 2025 01:11:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e41b6dbdbsm75893125e9.22.2025.09.13.01.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 48/61] rust: re-export qemu_macros internal helper in "bits"
Date: Sat, 13 Sep 2025 10:09:29 +0200
Message-ID: <20250913080943.11710-49-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Avoid the need to import "qemu_macros".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-21-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bits/src/lib.rs | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/rust/bits/src/lib.rs b/rust/bits/src/lib.rs
index 1bc882fde18..d1141f7c882 100644
--- a/rust/bits/src/lib.rs
+++ b/rust/bits/src/lib.rs
@@ -380,14 +380,17 @@ fn from(x: $type) -> Self {
     };
 
     { $type:ty: $expr:expr } => {
-        ::qemu_macros::bits_const_internal! { $type @ ($expr) }
+        $crate::bits_const_internal! { $type @ ($expr) }
     };
 
     { $type:ty as $int_type:ty: $expr:expr } => {
-        (::qemu_macros::bits_const_internal! { $type @ ($expr) }.into_bits()) as $int_type
+        ($crate::bits_const_internal! { $type @ ($expr) }.into_bits()) as $int_type
     };
 }
 
+#[doc(hidden)]
+pub use qemu_macros::bits_const_internal;
+
 #[cfg(test)]
 mod test {
     bits! {
-- 
2.51.0


