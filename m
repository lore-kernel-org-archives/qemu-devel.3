Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3ECCAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLMO-00008F-Ak; Sat, 13 Sep 2025 04:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLM6-0008GG-GM
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLM2-00056E-5y
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+Gmr9avOyH4kcrD2JY9Se7d2/kh9aUf1Iv46OmMGuE=;
 b=XEpfPtSnSjJCmnoqXeqnNxHduNR3GTTglfi8mSAlUaLsAms7ae5Q8e2HXO2xAXmM9H0vnm
 fthFBVwQ7Rf8y6EFkRcHKYWba6yvCYaGT9ITosl16Iqo7Izf9WMNfIy81ynu6lbOSIVLjJ
 MUrb13h/rgXwo7+zuGqX8gY7NA3zER8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-CbUEkvcLOdiSq6bJIQfIDg-1; Sat, 13 Sep 2025 04:11:28 -0400
X-MC-Unique: CbUEkvcLOdiSq6bJIQfIDg-1
X-Mimecast-MFC-AGG-ID: CbUEkvcLOdiSq6bJIQfIDg_1757751087
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3df9f185b82so1007449f8f.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751086; x=1758355886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+Gmr9avOyH4kcrD2JY9Se7d2/kh9aUf1Iv46OmMGuE=;
 b=Nhsf9kNiGhwD1X7WI2+apqMZ0IBEoL5s+KwLFaHOTHsR2ar1l+wvTZtEuSv57YxlJB
 snTw5EyYcikIQAiH+HgLf2Kj76v1JqDchsbtVOlZ8nIl0A1QAebmhSqGUZz4SvJbEmak
 qZ22WdEiv/IXiH7LamVHFODw6j+1QgRUKPhhAtAZu6c13BeKm9pnMBFFwBtCE1HeHKpQ
 qSj2QsV6XmgbaZv105P5mK4uUIGE9Ur/ArVCHfvSab0sYe5w7NOZdmR6QSGPggg2f5Yl
 z+jMYCapMpEtKwglxOBMYbYawIUx9XnaL9KMs33zMD+K27mjjkqW0bVIL2r7cPow1nrA
 uQ/w==
X-Gm-Message-State: AOJu0Yy6W3dDnf9g+VFHGTmyxHFWUEn3bCC8+xGu+Hb+5sT78OKpBsMg
 1i4CmGOM7LMEpMNrf7viQkAT5eqyJlQ6DhKwa9WMpUkABL/vwCntzeMweHOz8SWLcj5HaVBQ2GR
 2jQLeRMlWH6xhvuLxO/73UNyXYYmSwYJPdYhO0UHB5ku7XBfFQW0GYFyeJ94QCNcbscd8D4xSyK
 AvIyjmt9ow4EXUcXya6zgDGzg8Y1qGerSTQUuGij5P
X-Gm-Gg: ASbGncuL9WYv9coKBVsGXnLuJ7XQc9a89NUGwG4cA5Pp14t+q4wWc4gnCa6KA4LknXw
 dg6NFwxarGg7dUu7yymL624pHJcnKxocRDvDcI2J1dzrU1R1Lo8BvKxMG6xwoYYUSzfzJCCl0Fr
 2NHHKjkopQGZVBC5Zl+QUyVJCcWOUyfULs4/kgsXW7IIt1rckoj+mVZAJHu7gwQBt9hCmTXvkw8
 kS5Z1plSCIlrwTSNcRAWhmnijyZBJMzb7eG53QA6jVJdXgMjMHYKorUdMqVyK3iyVX3ylkwtGLa
 aMNVtI+pu5jMatVsBsOz1+nUwvZY4olwC0PE4db26RB9+z/4NzGVB5ethWj2uU0Z4S6hCoCsGY0
 RXM0pINy0+bOT+bKl6lpEuYB6+sdWVwrEJiI9zWedxm8=
X-Received: by 2002:adf:e6d2:0:b0:3e8:e61:b067 with SMTP id
 ffacd0b85a97d-3e80e61b06fmr1927824f8f.13.1757751085769; 
 Sat, 13 Sep 2025 01:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSoEKuOL0agXGlVMsMDVrWHh+ro+xBFP3GxT94nryNqnq55s6fJVV6yXJad2iPMKFit/1lRA==
X-Received: by 2002:adf:e6d2:0:b0:3e8:e61:b067 with SMTP id
 ffacd0b85a97d-3e80e61b06fmr1927800f8f.13.1757751085313; 
 Sat, 13 Sep 2025 01:11:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e76078708bsm9680866f8f.15.2025.09.13.01.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 36/61] rust: make build.rs generic over various ./rust/projects
Date: Sat, 13 Sep 2025 10:09:17 +0200
Message-ID: <20250913080943.11710-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Guess the name of the subdir from the manifest directory, instead of
hard-coding it. In the following commits, other crates can then link to
this file, instead of maintaining their own copy.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-5-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/build.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 29d09456257..5654d1d5624 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -9,12 +9,14 @@
 use std::{env, fs::remove_file, io::Result, path::Path};
 
 fn main() -> Result<()> {
+    let manifest_dir = env!("CARGO_MANIFEST_DIR");
     let file = if let Ok(root) = env::var("MESON_BUILD_ROOT") {
-        format!("{root}/rust/qemu-api/bindings.inc.rs")
+        let sub = get_rust_subdir(manifest_dir).unwrap();
+        format!("{root}/{sub}/bindings.inc.rs")
     } else {
         // Placing bindings.inc.rs in the source directory is supported
         // but not documented or encouraged.
-        format!("{}/src/bindings.inc.rs", env!("CARGO_MANIFEST_DIR"))
+        format!("{manifest_dir}/src/bindings.inc.rs")
     };
 
     let file = Path::new(&file);
@@ -41,3 +43,7 @@ fn main() -> Result<()> {
     println!("cargo:rerun-if-changed=build.rs");
     Ok(())
 }
+
+fn get_rust_subdir(path: &str) -> Option<&str> {
+    path.find("/rust").map(|index| &path[index + 1..])
+}
-- 
2.51.0


