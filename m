Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FD7CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQri-0004t9-G0; Fri, 22 Aug 2025 08:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrg-0004sY-Aw
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQra-0002Pz-Qr
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yj+kfrLiuiDWbk6juZvmPOCKZLi0c1ZQ9KC3luFFDEA=;
 b=RTN1tXWVwVpX42LTEYXkov0NBuYJQpoKsymTY63Y16Oo7T4oUOdVTY0sWnUclaKqHWNVMp
 rn5Ajl1cYr2UXSwNujpD/T4OvnAsAdUztAYTW3NOgiJspsf6JDhl0WqLN/tQGEAip6WSsC
 oemguX2JWfGpgLE6E7EL6xio/ZlabgQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-51oPsfeVOHWgnP3TbMqgsw-1; Fri, 22 Aug 2025 08:27:20 -0400
X-MC-Unique: 51oPsfeVOHWgnP3TbMqgsw-1
X-Mimecast-MFC-AGG-ID: 51oPsfeVOHWgnP3TbMqgsw_1755865639
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b4e345ce4so6990055e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865638; x=1756470438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yj+kfrLiuiDWbk6juZvmPOCKZLi0c1ZQ9KC3luFFDEA=;
 b=jX6FN7BEZMmF+hue3DgDe+7WSsF8Ya9YzC5x2jSgqvfOA3rgwJiXe4yexVc548hUzu
 JlXH8ou8uvT5D+DRADq/RPIukit94f8mEIg9fNHxw2hCTjcdMy6e64hI5ndsoXbei1Q1
 4/vOhSxOzNlthaE/t6Ytj19IW2Icl+hdQOPYPV6fIXHVRfDnIqwNHtqtWRGdP3KlI2Uq
 v/Q1Q1VBrDKodmcf/YscyxOpTPCf2z2t2F1l1VGKxJ5XsPqcYQVWoDbmurercwExPanO
 gCYaTOmVK5g+J4u2dPVQjpNYTe5etwzle5H7Tw5cf4nZ+hAyFAe5bmThBqWWB0fJxA4O
 nrkw==
X-Gm-Message-State: AOJu0YzwG5yIlVhFO4vkmQCJsxPjg1bRrdM9QW/evj9Vt2Nc4JnvEQcC
 FcBuEGnFf6ky2pOFdxQXtwbCl9yx04XudK1Ctkj1xsp+RBTHrxXFJQxKWB/RUcNSfU4uRo7BxTe
 a/ma09EC1MCV8qkX8u3TOi2ysvRCbFtSDyMZhHp3tEV/CJQW0s8V1EAeB3f8BEkHGCSwspJNpO6
 qcrLesRArXbpMs5zEeSE2W8OI+sYX1nnKn5nNE7TMi
X-Gm-Gg: ASbGncvJo3M1N7xFb+qxQwIayTCjXVqQiU46SPyC9w2kWYuROId5PBSr9lUL2jHYczV
 MYgZ2GcqSHd23wEYRwZ43vAnMuQ6ESlk1TdWayHgluyAKmBz2UXLcOcgXxALMSXMPVK6jQkUdmB
 XR/6eTiVJ6rIWTrWCaUuMjxWhCEqP1cgm8WwVWfFVvmzDVSB2RpUi0IyQt+pJlvFH/MOCabXBkl
 DcY0tJSGix9xbo/ZDgL3b+tACYSS88PTS0U491DmYDSGVSA8mhxWVngFQDaHmGaZNKr3mClokaW
 0WHfx4YqiHdp71WskegqjQXU3Ki6c0rJUkGBcCAGfmudeXD1IYs39vPjtG6nU2+EWnttHN6hW2X
 VB2awVV41qgP3lr70Zd5MOsFcFIwMUp8ANps/y51lYg==
X-Received: by 2002:a05:600c:a09:b0:459:dde3:1a55 with SMTP id
 5b1f17b1804b1-45b517c2f63mr23563665e9.24.1755865637761; 
 Fri, 22 Aug 2025 05:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj2TFJTEiJscJeyZaS+ZB9nDDkBxcfzO8aeV7sJkh0kGMN2KpNTH6dfo/vW1aa1st6QVW18A==
X-Received: by 2002:a05:600c:a09:b0:459:dde3:1a55 with SMTP id
 5b1f17b1804b1-45b517c2f63mr23563335e9.24.1755865637280; 
 Fri, 22 Aug 2025 05:27:17 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b50dcea8esm37285705e9.8.2025.08.22.05.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:27:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 08/14] rust: qdev: add minimal clock bindings
Date: Fri, 22 Aug 2025 14:26:49 +0200
Message-ID: <20250822122655.1353197-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822122655.1353197-1-pbonzini@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add the minimal support that is needed by pl011's event and tracepoint.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qdev.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 6d619661ba4..64b961136b2 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -449,6 +449,39 @@ fn init_gpio_out(&self, pins: &[InterruptSource]) {
 
 impl<R: ObjectDeref> DeviceMethods for R where R::Target: IsA<DeviceState> {}
 
+impl Clock {
+    pub const PERIOD_1SEC: u64 = bindings::CLOCK_PERIOD_1SEC;
+
+    pub const fn period_from_ns(ns: u64) -> u64 {
+        ns * Self::PERIOD_1SEC / 1_000_000_000
+    }
+
+    pub const fn period_from_hz(hz: u64) -> u64 {
+        if hz == 0 {
+            0
+        } else {
+            Self::PERIOD_1SEC / hz
+        }
+    }
+
+    pub const fn period_to_hz(period: u64) -> u64 {
+        if period == 0 {
+            0
+        } else {
+            Self::PERIOD_1SEC / period
+        }
+    }
+
+    pub const fn get(&self) -> u64 {
+        // SAFETY: Clock is returned by init_clock_in with zero value for period
+        unsafe { &*self.0.as_ptr() }.period
+    }
+
+    pub const fn get_hz(&self) -> u64 {
+        Self::period_to_hz(self.get())
+    }
+}
+
 unsafe impl ObjectType for Clock {
     type Class = ObjectClass;
     const TYPE_NAME: &'static CStr =
-- 
2.50.1


