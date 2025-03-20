Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD7FC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 11:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvEAr-0004fj-OR; Thu, 20 Mar 2025 07:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvEAQ-0004bv-PQ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvE9z-0001F9-H0
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742470442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c+Rfku8bf6IzTNaEhIjF3XHdWwhB3xaIB26fo+RA7mw=;
 b=iOJjVfKSYt7bmwPRrIZcO4lWIQqHyVMGg43QHxRHTqf0Sf5jGKXCFoXUImv/7+bwwIHApi
 EAbnYFjQCxiZctar/q5QfZbIL8PypCTq4SUDO2RELevHFcf45tD/z2UVzB8fGfJsVp4XVE
 WX/7geWa/K9eJyYqL5eEKqUlzIO1XMM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-pTGSKI2WNiGHLD-OLB8vFQ-1; Thu, 20 Mar 2025 07:34:00 -0400
X-MC-Unique: pTGSKI2WNiGHLD-OLB8vFQ-1
X-Mimecast-MFC-AGG-ID: pTGSKI2WNiGHLD-OLB8vFQ_1742470439
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391459c0395so318468f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 04:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742470438; x=1743075238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c+Rfku8bf6IzTNaEhIjF3XHdWwhB3xaIB26fo+RA7mw=;
 b=EsnUxLkxpvR10BWRNeW6tX2FrXhewyKl+mIokAgxBQ5beNIMkkkFRzycq3lVWCa91U
 y8+/rA34GHfqzAkV9LfhbIocmpuTShKQrCIPovAzDXd9dRrxOr2QRGEX9rvtKmtzYQRr
 huBRKW9QLy51MLBBTeZwmlnZYD5LxmtXHvgTKaXvH0ofRMsUmFLRtL6YMZv74T/KS27S
 882Kh/8cYj5KDSzuSGYjmezDSyRSsxZGyfRyX9+4t8N8K58g1uhdYB7aYq/1nnKMuLx6
 FQSF+qLikka28BIHcWakBObn66COs0KZKoQILgkqO9dlTgztEvbVcVRbbbTtiumw+qYg
 FOMQ==
X-Gm-Message-State: AOJu0YyLOrCitKGyuINPDqp4VQMWNn3Tm685VP5bXDT2+yLUbgMkveH/
 J8qmDkKTOe36fPeHwKBUBp41PjIN4G4atTnwOpOMu7Xf0A/vt+03hCioakau9JTRPuz8EpvAFJG
 09OfdjgTVKebDEVOaWbrwtDzrWh8sKWEVMrbf/eXuCRprnFPtS6BdC/yFL0Vc/Q+prd/VWARAeD
 OKYIDpI6R7Xt+gD86VtqNp8xPje2PneRVKejrU
X-Gm-Gg: ASbGnctyX55Qy2EVSdhHOD0cAaRDuNDbtFEr8fpRCr5UF8GrvGQjGt3ip0ifddhaGSo
 2d0yN0Dkd79ce6NqQMTf/32cuPh5qsK0dsTC8tscPuGQerbbqn4nDno7VkYol1rSF49T6W/uVf/
 G/5o0bZVHZUUuGUn+CiBKorOhENxqeEysIeqBpUmbUic4vbOeeWkWxey5qLbm1ZviB8c1x1qGRl
 U510pVjcjZy9cEt2sTk7w7Wfsr8gvgZqrMfV5b+GxRvhY9zc/bwLhAEMtOxoy26tbFFysx3B2L6
 PDRpCgjFiJMk3+HWKgRG
X-Received: by 2002:a5d:6c67:0:b0:391:2e0f:efec with SMTP id
 ffacd0b85a97d-399739b45f4mr4290496f8f.7.1742470438250; 
 Thu, 20 Mar 2025 04:33:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhEOXVJklW7b0P8YsQfg/Yd8oxtXANrjsZINkKIpBb7Mw8o5asXUqiOmuO5AYjy8rTqqvd9Q==
X-Received: by 2002:a5d:6c67:0:b0:391:2e0f:efec with SMTP id
 ffacd0b85a97d-399739b45f4mr4290472f8f.7.1742470437759; 
 Thu, 20 Mar 2025 04:33:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39972df9b9esm5010041f8f.18.2025.03.20.04.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 04:33:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] rust: assertions: add const_assert
Date: Thu, 20 Mar 2025 12:33:56 +0100
Message-ID: <20250320113356.799412-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

Add a new assertion that is similar to "const { assert!(...) }" but can be used
outside functions and with older versions of Rust.  Similar in concept (but
not in code) to the homonymous macro of the "static_assertions" crate.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/assertions.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index 104dec39774..1fa3955d867 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/qemu-api/src/assertions.rs
@@ -120,3 +120,25 @@ macro_rules! assert_match {
         );
     };
 }
+
+/// Assert at compile time that an expression is true.  This is similar
+/// to `const { assert!(...); }` but it works outside functions, as well as
+/// on versions of Rust before 1.79.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::const_assert;
+/// const_assert!("abc".len() == 3);
+/// ```
+///
+/// ```compile_fail
+/// # use qemu_api::const_assert;
+/// const_assert!("abc".len() == 2); // does not compile
+/// ```
+#[macro_export]
+macro_rules! const_assert {
+    ($x:expr) => {
+        const _: [(); { const VALUE__: bool = $x; VALUE__ as usize }] = [()];
+    };
+}
-- 
2.48.1


