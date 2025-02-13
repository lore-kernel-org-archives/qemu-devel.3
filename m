Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88A8C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibfK-00015R-2u; Thu, 13 Feb 2025 11:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibf7-00010q-9i
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibf5-0005cA-Eb
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahr6D3HUwH5Ls6hZQSV3hmahhoExY6Sc6jHH3fVS+DM=;
 b=GOsZv6EAT6tKR5w0tQFwIt518cajyqyQu/k8ip2fDzBxbqehj3OHs8pOG5sKZ6jbiX32YH
 5XpH42QgSxi33v/C6LlAtu83jMAYyTXS/IBQ2W1p1CfjRo5E0FVdSqPzv/+Wlle38w9j7S
 1ADTGXsccxmNeWPZ4zIV8blr3Zyv/4A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-lvsxE0-JM0yqr6Uy7HQ-Uw-1; Thu, 13 Feb 2025 11:01:56 -0500
X-MC-Unique: lvsxE0-JM0yqr6Uy7HQ-Uw-1
X-Mimecast-MFC-AGG-ID: lvsxE0-JM0yqr6Uy7HQ-Uw_1739462515
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab39f65dc10so129435166b.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462514; x=1740067314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahr6D3HUwH5Ls6hZQSV3hmahhoExY6Sc6jHH3fVS+DM=;
 b=Vw/77RgbqvReO07kyZUYNpvP9LycpJS12izD/oBloYABl/DxqHBPZOHcYVe0gy/d9i
 QPrBlTxQv/nySsCWOXRfLhKsjCqRgCKeD4DJkngndsTMj2dj/7Mo86Csddx4eiuqyfdD
 pS4AcNoaDk9yzJkRd1A7tKnUqUt7GxObywrt3Zrgjc99MQlhxqIHDkCzBKgIfKkfQTmP
 g0BQ8k6W5I7j+2Oya95TycJltkLc3GCsksTCScV9pWr+W+F1A4qTahgRaoIRy/O0Cpg3
 X3+gelMBB+ECEbMTx7erEeG2P+jqikb8ALn4k0F1y4eYjALwKF7pB1aoY8QOFlp+mwAe
 apTA==
X-Gm-Message-State: AOJu0YyN0cTGHsxn4RjJDkXvvMEHOoUq20iQKutezetW4lCWFA2FMDDW
 FdhLPgbTfW8hpOOhmTVDkRthwjY6E3y49fYKMKAV9DK9e2wGLO+6fgzTTcRrwQRzpX7f+W2hjWN
 eCk7ur/+62669dFxtuB7ifDWgnV7Ya68jFhVPLYzXbqG6sdvYEYhYJ5YObR5r1mKDuLRvnCug+8
 yRsYx/jg4qJ5IUaizWME83NgMiASDzFs674sqpbRA=
X-Gm-Gg: ASbGncvwHPuvUch5YbGUKCy4fIsEUK4Rx2dId2/XUbPfKQQjEaMV4uk8zJD7h8zg7SQ
 wrHem6cwSdP4pOcQouFeJG3MQnYIevnKBP+PqFIIW8cij7WOp8nciHd5LzDxe7pMJd90V5PrsGx
 fcRgfcTWggQaEaBXidITHwl0tSPvNj72iVopNA8FscjvSTSCWs2eF4lRWn6v8FBqQYhKAQHEmSl
 a6SJWsDa97ZCmP48t9sagSgH8KZZSOc4LbSGpOVd1tPRO/Q/6cKXc0lI4lCjiU6xvUzz4bH/y3G
 XlH+a/u3+YC61eQcGIHnwdu9soQC7wXE12ax4cBrXBLzAA==
X-Received: by 2002:a17:907:2d11:b0:ab7:e451:4834 with SMTP id
 a640c23a62f3a-aba4ebabfc9mr346470166b.19.1739462502956; 
 Thu, 13 Feb 2025 08:01:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNvV97dF43opM9yfLujDXJ6CvLH+bFhvdySbv+SmPuX/q+COo5fvb83yYz/+ReN62RjvIVXQ==
X-Received: by 2002:a17:907:2d11:b0:ab7:e451:4834 with SMTP id
 a640c23a62f3a-aba4ebabfc9mr346414666b.19.1739462498935; 
 Thu, 13 Feb 2025 08:01:38 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4396180f7d6sm21327345e9.17.2025.02.13.08.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 16/27] rust/irq: Add a helper to convert [InterruptSource] to
 pointer
Date: Thu, 13 Feb 2025 17:00:43 +0100
Message-ID: <20250213160054.3937012-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

From: Zhao Liu <zhao1.liu@intel.com>

This is useful when taking an InterruptSource slice and passing it to C
function.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250210030051.2562726-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/irq.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 835b027d5e5..672eec1430f 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -83,6 +83,12 @@ pub fn set(&self, level: T) {
     pub(crate) const fn as_ptr(&self) -> *mut *mut IRQState {
         self.cell.as_ptr()
     }
+
+    #[allow(dead_code)]
+    pub(crate) const fn slice_as_ptr(slice: &[Self]) -> *mut *mut IRQState {
+        assert!(!slice.is_empty());
+        slice[0].as_ptr()
+    }
 }
 
 impl Default for InterruptSource {
-- 
2.48.1


