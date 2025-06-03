Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE49C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZRx-0004rJ-Nu; Tue, 03 Jun 2025 17:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZRu-0004qs-Qz
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZRs-000650-PW
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Bj5dk8C+RekJOcmSF9CtHPfWXIYUxL8JYZp8eTAP4w=;
 b=EiLgvZ5iR/xv6jAkbZAG+GbHMqpZr4Hu4zjk1+gzMCqyXZvgX7InO7vx0/b4Ovhce/cxZp
 ZT/WoFQmJ1aa6rV+oaEln4JmY6sy8mq8MMY7gpNrVeEHZgOYIHJ68I1+CyppTmBBJVGTyU
 FMH15MJQyFq4H8AQtTfSUI4aSmTW0ak=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-clvpHv3UOp-36bulYvStIA-1; Tue, 03 Jun 2025 17:45:28 -0400
X-MC-Unique: clvpHv3UOp-36bulYvStIA-1
X-Mimecast-MFC-AGG-ID: clvpHv3UOp-36bulYvStIA_1748987128
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d290d542so33211845e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987127; x=1749591927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Bj5dk8C+RekJOcmSF9CtHPfWXIYUxL8JYZp8eTAP4w=;
 b=faVzmUqs/WxbJIz7rmqPD2tCMvrs4dbM8yEi2tAUoq180oL9qMZLrxDnSfk66ZBPXC
 C3GCJ87cyyHhnopCfpfq8LwvBGKXZdPt+kb8/e54+FyZ8ZvBEZP/micy+ozu9g3xc5Ma
 ghE0pMP9cxAfGc4OVAyjZ1Lo9RHB85j5zeXAYashZvGfWv+DrzNqT/F8LyDS3GoXb6RY
 HiAXM5aV2d3OwCXOrTmxJOo3KLEygDNx0LJwIeAFyJdxlplD/aEg8d3pliIHL+87x+Wb
 oGC3xEfGn8qV9A8TEHae6Y4HFOXmjXMZ4zgYXnB2DOIfLxo7Al0K4ZS5uPLvMtcfO9x/
 F0dg==
X-Gm-Message-State: AOJu0Yyfp6GpnSzTlNe4uwfaRIYEOFJPxKFe06XrRctTx5ylx6SHuEvB
 RhaNvbBNEfQE70MPaadqyLfYsRQpUvi/HSGR2UmyJ0OKmcz/SPr36Y63WXXqEYPSp/yWDd535xB
 UEPwcyJJ6FvyjjgIuYf6TODV6ZccOefpnh7gWt1fD/EAkMb3P8f5Mz1uM1oMDaT7Z90SpGuUfne
 XXaEu2dDePCEZgLu6GyL9kDAYcUuAHX2Tv+O/bL+b0
X-Gm-Gg: ASbGnctwTYeO/9bF9T5MtII5hf9Psusb6PaecYYoK8Z/vUj8unqVFoAg1JyQdGhe6U0
 mtxZd/KEjcaURPNJSQvkFL9w+mxw0BnIz0bDw3JygFcnKhRaCqoNEXLpSHv+opTksCk+8iYvaEy
 s8n+nkSrcpd0tKYKWumowKNz2s4D8rugpEniovZ4kVABRFQV7DkUyx/yP/rACTx/pnopDDBtoxf
 P5zJqnkrg6GXHo686Nd3OlpYJwi/UMtuPOgzvHeHa2ZqyuYC8MTBOhoyXOsN32YHoRvi4mlA628
 09lfhhp8pmkhJA==
X-Received: by 2002:a05:600c:3b92:b0:445:1984:2479 with SMTP id
 5b1f17b1804b1-451f0f008bemr1779605e9.5.1748987127169; 
 Tue, 03 Jun 2025 14:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENZ0Co44rpDckc3zU0J2WczwmFHf16Gmx6jRHKRcNrNX6tigV9zetJ7GhDG8i2zHg2syJa5g==
X-Received: by 2002:a05:600c:3b92:b0:445:1984:2479 with SMTP id
 5b1f17b1804b1-451f0f008bemr1779465e9.5.1748987126670; 
 Tue, 03 Jun 2025 14:45:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8eceasm176236935e9.7.2025.06.03.14.45.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] rust: bindings: allow ptr_offset_with_cast
Date: Tue,  3 Jun 2025 23:45:08 +0200
Message-ID: <20250603214523.131185-2-pbonzini@redhat.com>
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

This is produced by recent versions of bindgen:

warning: use of `offset` with a `usize` casted to an `isize`
  --> /builds/bonzini/qemu/rust/target/debug/build/qemu_api-35cb647f4db404b8/out/bindings.inc.rs:39:21
   |
39 |         let byte = *(core::ptr::addr_of!((*this).storage) as *const u8).offset(byte_index as isize);
   |                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: try: `(core::ptr::addr_of!((*this).storage) as *const u8).add(byte_index)`
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#ptr_offset_with_cast
   = note: `#[warn(clippy::ptr_offset_with_cast)]` on by default
warning: use of `offset` with a `usize` casted to an `isize`
  --> /builds/bonzini/qemu/rust/target/debug/build/qemu_api-35cb647f4db404b8/out/bindings.inc.rs:68:13
   |
68 |             (core::ptr::addr_of_mut!((*this).storage) as *mut u8).offset(byte_index as isize);
   |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: try: `(core::ptr::addr_of_mut!((*this).storage) as *mut u8).add(byte_index)`
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#ptr_offset_with_cast

This seems to be new in bindgen 0.71.0, possibly related to bindgen
commit 33006185b7878 ("Add raw_ref_macros feature", 2024-11-22).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 3c1d297581e..057de4b6467 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -11,6 +11,7 @@
     clippy::restriction,
     clippy::style,
     clippy::missing_const_for_fn,
+    clippy::ptr_offset_with_cast,
     clippy::useless_transmute,
     clippy::missing_safety_doc
 )]
-- 
2.49.0


