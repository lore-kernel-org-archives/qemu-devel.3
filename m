Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D16FCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rdl-0006Zw-8O; Wed, 01 Oct 2025 03:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdd-0006Vh-AL
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdQ-00032P-JF
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBi6nmZqJdl0va4wx3o6PVk2Le5zxB7N8Bp43lI1p0c=;
 b=VwEuUVNWJTlcoJMxz2BaalPnV480a54MIemHR2uumypcj5jO7EKr4YXoiKsobRimx0uMhD
 YL2z0iXaaxLEHTHdKWtUDqRVjYdT9GBVoozGsSIQ9kd/M4Oy/hMXEuoHsKvET3+mtIaKZY
 RjncVuUtNLz0KwKwVMMUjEPRzL1ntsM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-zi8j1mjBNO2BeU7LoPPbqA-1; Wed, 01 Oct 2025 03:52:14 -0400
X-MC-Unique: zi8j1mjBNO2BeU7LoPPbqA-1
X-Mimecast-MFC-AGG-ID: zi8j1mjBNO2BeU7LoPPbqA_1759305133
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-634ab12955bso9653761a12.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305132; x=1759909932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBi6nmZqJdl0va4wx3o6PVk2Le5zxB7N8Bp43lI1p0c=;
 b=HTXiu1MzjztU5qa/7zQM5J3NPv060b7OFR8/6irKd6owpSFABixTFXCw7/liUXuqKO
 90dCGlaxRDSKY3moQOIkrQoNbXktH8hukzVS/6L8e1wVaHJ2VtF2jqbbc42X9vQzYX/H
 ICLTw9GYVM4p+esrI1MfyRXcE2ESvNQIqg9kjOwwOcvTzlXA3DedaXPe92WZYZmMqywg
 xDghiuVgePDJL8WZcrC6+yMXcaOxIh5tCqadRXsdo2QsvwouMShAmtlJiuoEfJithxBB
 SxDGupbmdhySAgy6PAatHiMXscmVa4Dac0nq+u7rF3oQ8KSoblPp46HcSe7OoL7ylJ79
 8ceg==
X-Gm-Message-State: AOJu0YyqgJPipqBzfWnn+NtuF9tB3fm7v7q/XYMSyt05tl5dMTC4oXWJ
 omuSj9qlUDMPxIFInkqeoAkkE9vC//Q6Hvax8V8nGtXpMbmGly9y5G2mFYnofvim1jL3DNtLpOt
 vhxKCwdLj1t/cjDTdh43Otr40qsEJ8fU7LKAGpGsaESg5/fhJ6U5T8FzcLpZOxhqaQ/UqMJIf25
 dlYKtm9+EXLrGJb8skYYD0iknuqAK1KL1t8Sqlr7hi
X-Gm-Gg: ASbGncs4oBhgkiOxTIL0+J0OZNtGisAg/bzBesqcvu0vCrojvIHF6TL+Kf7LXNhL32G
 dmBtblC5QiGnavt8LAq8HqQ8Ft+VrbjHkkg4IfRghQtDoW7yiFYWgFnzTWKqSDjWFdgJfiv4h71
 9as1ADMwu8aJmadnCvrEIHa8sEN7RxaJf3kB0yqOzmkhlTEcMEQvAC/GDeamA6D1LnYhJDZKV/r
 Cdw8nL3wS9fVt1ApYZWHaOrwYXxqRTX4cwOuicfauE3VSP9s2Fdd7YHeyKtDN/9xFq8zzmhNAWj
 0xlQHT0F8+/GfMIWExpAVMBE/IZ0XFZE17nwYYokXUa7753hyh+2Emk2oIkr66q0ibqHW00+xdZ
 lg/VMUigbpEoauejEeopQ/o92Ar6kfs4E+ERtSMQAoDZ893YDkdA=
X-Received: by 2002:a05:6402:27d2:b0:632:115b:6e72 with SMTP id
 4fb4d7f45d1cf-63678bfdad5mr2868588a12.9.1759305132467; 
 Wed, 01 Oct 2025 00:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8uR1LMAX/n9oJusHP1izwUZ/hRBF5IEI7+TdqgLCWp+fLkOTuPotp0hjgjhCERuGWPjZzbQ==
X-Received: by 2002:a05:6402:27d2:b0:632:115b:6e72 with SMTP id
 4fb4d7f45d1cf-63678bfdad5mr2868565a12.9.1759305132025; 
 Wed, 01 Oct 2025 00:52:12 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634d8beedf1sm7868571a12.26.2025.10.01.00.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:52:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 01/11] rust: bql: add BqlRefCell::get_mut()
Date: Wed,  1 Oct 2025 09:52:00 +0200
Message-ID: <20251001075210.1042479-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


