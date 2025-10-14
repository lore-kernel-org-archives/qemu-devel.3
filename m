Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76400CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEZ-0005wz-Hi; Tue, 14 Oct 2025 09:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEQ-0005v2-6g
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEG-00016j-7d
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBi6nmZqJdl0va4wx3o6PVk2Le5zxB7N8Bp43lI1p0c=;
 b=OonwqXN0Vb/ZuQIkI6VPZa30tQUesJ0lAeB/9wdw4FkeDujDxSlF4grcw5YCQ017SaKnk2
 WLDJzMlC/khnAW2apOjks/DyTJ98BQMmJBe6iolG5/WjrHvNxijeQ0+hHg6R7t27k97/Oc
 paMYf5kIHprf5j0esfbzUlqA1hBZsxo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-LxZcPUZeMAudoUD4ElL2vA-1; Tue, 14 Oct 2025 09:38:11 -0400
X-MC-Unique: LxZcPUZeMAudoUD4ElL2vA-1
X-Mimecast-MFC-AGG-ID: LxZcPUZeMAudoUD4ElL2vA_1760449090
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f7b5c27d41so3568922f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449089; x=1761053889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBi6nmZqJdl0va4wx3o6PVk2Le5zxB7N8Bp43lI1p0c=;
 b=maZQn18A+xPTtAdfbqYnGUJv0FDgojfoSpwIfGu4b95nEda/L8Lm+inJjQxjl6kae2
 K7pVU0rJSw+vheHIlMHABmJkHW3rrH2ZWUYO9qGodAbKISPI3R8ebRSUYkdO1vkTnfum
 wRLWGfJnQdLr7YYb5HNL9JYhUtM6+ucJDvJsKWlh45dCdQJhR54przx8Um6idq5mBkGJ
 mG+JVYrA/wYQ0KYDZ51A1rN53O29DD/EWtYGM+RHKxD9TUAkL+WMTQpouEvcqYcRVBYl
 vCcqOVc53s+E8CFv/gdR9Rf4izV+d7pr/UHK+OshN3zj5PO14OfCSwp+tJiPjhQXDbbK
 Yhew==
X-Gm-Message-State: AOJu0YyKKve83HwpBd7UbkwJWZM392Qww3aVDy1TaU77mgOAN4g6Dtzp
 3R+HdLNKvGk0AZRkSmrkKXiABwIjIuAGQFbHr6OdYY7rXzsECRNRHoID8M3oM0eDlckSGno5hbN
 cA1ngm2aHnGJbdml5SJUqNsfNojrXv8+4/mOaPHQ/3LUMS68Xcp2qzwjYjoccNSmHtFAPYmA1iz
 ItJqNj9byk4ofloBHc/RlkWQ3gYVnfNwMWmIFZEcV4
X-Gm-Gg: ASbGncu7reZI1y1VYhZ5+2yy0Jah3RAYwDM0bFCAJStJg815hpiJxPJH1+r1x2YDhDG
 UipMqaO4sVRflzTUI/EAEbckCUO1qfhJ9l6NlQII97u2uCV72yPnZR6bMIA5XFfOm5/OUmlRVvj
 n4sBd3etT6WTjCBBokqDj/xvAhAA7Wq0NREh8sQK9rwEjrfT44/znICF2JKDB2pkAwu+IEVEIMu
 KYzPQVdm/PbQwDXtKlROZizcihXnFCvfnNY+5I4tHxkZqvCr4Of38unlu7nqY7Mt4N5ep9XEPzh
 zqlBIW+3PEVchOy8s4PgsQ23qi/Y+hIOWEODTpnQ2H+ZKPGPG7PikZKPmWhKeUYXUSyAT9BY8Yx
 97DfOt35KYI0rROkaZNfVp2dvOIXvNtu8lw0dlNrx6rU=
X-Received: by 2002:a5d:5f53:0:b0:426:f4b4:f0fb with SMTP id
 ffacd0b85a97d-426f4b4f100mr42772f8f.2.1760449089230; 
 Tue, 14 Oct 2025 06:38:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExh928QlKDojRECS/IuS2gYFM/lyLxAFd/QuloiaqyyRe7Ns/6uwaNv8KHSkWFvNaaf8LvTA==
X-Received: by 2002:a5d:5f53:0:b0:426:f4b4:f0fb with SMTP id
 ffacd0b85a97d-426f4b4f100mr42406f8f.2.1760449082967; 
 Tue, 14 Oct 2025 06:38:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426e6f03a76sm8232563f8f.36.2025.10.14.06.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:38:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/28] rust: bql: add BqlRefCell::get_mut()
Date: Tue, 14 Oct 2025 15:37:04 +0200
Message-ID: <20251014133713.1103695-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This method is rarely useful in QEMU due to the pervasiveness of
shared references, but add it for when a &mut BqlRefCell<> is used.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bql/src/cell.rs | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/rust/bql/src/cell.rs b/rust/bql/src/cell.rs
index 24ab294b60d..54cfe6145c5 100644
--- a/rust/bql/src/cell.rs
+++ b/rust/bql/src/cell.rs
@@ -580,6 +580,23 @@ pub fn borrow_mut(&self) -> BqlRefMut<'_, T> {
         }
     }
 
+    /// Returns a mutable reference to the underlying data in this cell,
+    /// while the owner already has a mutable reference to the cell.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use bql::BqlRefCell;
+    ///
+    /// let mut c = BqlRefCell::new(5);
+    ///
+    /// *c.get_mut() = 10;
+    /// ```
+    #[inline]
+    pub const fn get_mut(&mut self) -> &mut T {
+        self.value.get_mut()
+    }
+
     /// Returns a raw pointer to the underlying data in this cell.
     ///
     /// # Examples
-- 
2.51.0


