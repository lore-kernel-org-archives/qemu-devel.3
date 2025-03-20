Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C120C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 11:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvEUn-0002Mv-A8; Thu, 20 Mar 2025 07:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvEUl-0002MK-Nd
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvEUi-0008TV-64
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742471727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QzVg6/xCh+WV9e1uzDmGPvWkxytjcf5d1/QumLRzrjI=;
 b=USSCjqhnn48vAlTAxYxSa+gGnsUdhIS3HlWeevz+dVderFatnFy68r/3mcuImdzy9r32gU
 K1RerqR2Vy+ITqpvqbIaB6tjDrZbyOILjSFGLf3+duiAF5ythXK7EVPy93ZuiHf2pBT9Fd
 zs6VuglAzgx1rUNlvY0h0eD1vY5Gre4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-iPVT_mN9OqW_Y2oU-_NmpA-1; Thu, 20 Mar 2025 07:55:25 -0400
X-MC-Unique: iPVT_mN9OqW_Y2oU-_NmpA-1
X-Mimecast-MFC-AGG-ID: iPVT_mN9OqW_Y2oU-_NmpA_1742471725
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912fe32b08so368636f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 04:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742471723; x=1743076523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QzVg6/xCh+WV9e1uzDmGPvWkxytjcf5d1/QumLRzrjI=;
 b=fySiGVtBvm3V8jgqH9wGmleP85RLjWs19lRr7ghDGTaR7dkO3u90RAThB/XLUg4735
 J5A4249HxxY1ECS2gzwAK1vHtJIh0cAQVL/jDEhA9DAHUoxcGlWIesYiai6lfmcvmuhf
 nzKVfk+ZvmN4DxaiI+dUKuvbCS/JL6A00IDSuyDuBPlBpgAHLmfBmCW0ZqX5b5xgtAvd
 ODlsQdU0IdP4MRIUtuRa7dBKP+asbBk4GTvGJiUTsNcSmZJfVy7otbrdp7ETf6Aql/sj
 OHbqA1yb8JR03PNbQYT3RPxFvDssFfvhSEboxmp1djPPNfeqepOJ8ffSG0XBhNLBEYG9
 +2Jg==
X-Gm-Message-State: AOJu0YwL9vn0blSPjOI7sfLC4VPTo4oxKs+qOTSVK+uk5WLgft4FZhbp
 478cz6Jmqy6gqdE34YQKQ7AQI9cy+TMQsav+wrTmc+k3ydWjMi3D6SH4TpHlCltiMmJrYTixFhX
 znVjDfX7Po+V4A5dWp3P7wGtoy0eSyQqrKZ1PrbF5+K+dkNVeKFbgmiuR2M0HMYXpPU10iO+4w4
 MoxsnnSemJ2IfNVuD9SYWVxBeD8he3HVHsxO4y
X-Gm-Gg: ASbGncuX1ESXa/WKyyx3phMU87onPa9JBnbVNWaftRFeA5CoyQnELr3Ni9/haMyAxSq
 DM57cz4LyU6NulSRn4l8XxDuGP5uvihi6NfwWB5M73YsYlgl/IVIaawrwwVxWHBlUCcJZ9uCDJ3
 yjIJYc/nR+lVZ2DwRO3Q+JgTjfvkwoeV1RBEnAy/bmwM/Xz24YCb0gyPjJGeI/ET2cH/2Fvlrbt
 QCuG6A/ww19yjq/s6emQIAifrFkvDVCD5jTA9QJqcjpU46RdpN2veYRo8Ea62kuZ13wNa0t/SfD
 LPgjOzF2ntXRDFwqmHx1
X-Received: by 2002:a5d:47c8:0:b0:38a:88ac:f115 with SMTP id
 ffacd0b85a97d-39973af8e00mr4691863f8f.34.1742471723417; 
 Thu, 20 Mar 2025 04:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw8ZCql9k9ALY9AvtPhmO+o36CMjDlXCXMtZ2CTWJ4tggQ9XKLV1Yptwys7OE58NfPl1Y0lg==
X-Received: by 2002:a5d:47c8:0:b0:38a:88ac:f115 with SMTP id
 ffacd0b85a97d-39973af8e00mr4691843f8f.34.1742471722979; 
 Thu, 20 Mar 2025 04:55:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6b2bsm23121239f8f.26.2025.03.20.04.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 04:55:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2] rust: assertions: add static_assert
Date: Thu, 20 Mar 2025 12:55:21 +0100
Message-ID: <20250320115521.808019-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Add a new assertion that is similar to "const { assert!(...) }" but can be used
outside functions and with older versions of Rust.  A similar macro is found in
Linux, whereas the "static_assertions" crate has a const_assert macro that
produces worse error messages.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Supersedes: <20250320113356.799412-1-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/assertions.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index 104dec39774..bba38cfda11 100644
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
+/// # use qemu_api::static_assert;
+/// static_assert!("abc".len() == 3);
+/// ```
+///
+/// ```compile_fail
+/// # use qemu_api::static_assert;
+/// static_assert!("abc".len() == 2); // does not compile
+/// ```
+#[macro_export]
+macro_rules! static_assert {
+    ($x:expr) => {
+        const _: () = assert!($x);
+    };
+}
-- 
2.48.1


