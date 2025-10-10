Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE84CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Em5-0000M6-6x; Fri, 10 Oct 2025 11:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Em2-0000KI-Lc
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7ElV-000492-PI
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WosTp1yK3Q8xfkSSHqzAC8nqLnmsf887SgMNENXzcxk=;
 b=YYZlNyRJCwqovNqrai+bYl8ghiY5h+N/Ydbn49Cd2mwYtcLsIpzo22iGD7T1CKDIitSXoF
 PBW9kwh3YY7JXfPN1zgPA77cGOb/ImGqft/FIFiZvik2D6pAIWLwhFEJDkwrOw1AxX+uyU
 JXpO1nQOskJKBxMz7jZZJuSrRdP7Y4Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-QplrPtytM1GX_zAYZ4Zw9w-1; Fri, 10 Oct 2025 11:10:37 -0400
X-MC-Unique: QplrPtytM1GX_zAYZ4Zw9w-1
X-Mimecast-MFC-AGG-ID: QplrPtytM1GX_zAYZ4Zw9w_1760109036
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b4626b2d07bso269963466b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109035; x=1760713835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WosTp1yK3Q8xfkSSHqzAC8nqLnmsf887SgMNENXzcxk=;
 b=t4vbPP5O3VR97kNHHXcXjAxsRsUwgDZwhNqjWgUJyioSMJvCvlURdTgW20Kz1tOg4q
 fRWGYJ1HyNmDTxS85RimDik/jlvqxrVsfE+/pYx81r7C8s1qGq4gy7fXjPSZi7+j0dob
 6Q+3RWeGKFkLJjyu4xjPiQfIYsRN9Rvs8wLpaXAemH80PzRKc2V3CVyEi2mDBSzrBQUx
 IZZzWJ3lmBowO9Q/lSdnXBk6HKGUtxd+FMvmBhKGQCQkwoqA/aPKDQjkE5sxwF8OK5bd
 a2pvLF6T9lj0uLOD33pfszE+CKxcRJvTFLk2auyh/fPlkxIKj42QzGaQ/1XEvk5nf7Pr
 46GQ==
X-Gm-Message-State: AOJu0Ywir3bBcp3ZJhaM6feMJwWkTqkCamvVPbO9xnowAFqUSaNH9ewD
 q5bI8wQQYlKzl7Xt4YNzbDC5alKC0ysGOIb1xaPITH0JrWMTlxSbql65eu+4Z/Oh9zpDK9KzyFl
 kBU1bgYvWRASLBhY3/jU0UqE6KSqS1mSVsEFklTmP31Q+WV2ax8ZqA5SokR2LDsOTZ32VERrC0w
 xklHTJbjhWNhIRIw9ENEmzgHwFXBPFEAkKWs9grrMf
X-Gm-Gg: ASbGnctPzyXjoUg20wqpRoWV/b6FveC4+u3GhyEpwmrsg9gMBcEeq9wr6tYRiMNbxTt
 MYBGZFu497+XQjHIuEwGvlMKrXu4O9HmtHSNMQYZlPNbMN7FvyEeCNOuw/6vVVA/s0ph5YKhSd/
 ijr6sO0xzZ6c04FMBY4l9991qGQXeRhQzqL0g8KEc7w4x8ehpvttk3LVQCa90pYOT1H1ADZexyz
 VVBTVCDvCyk9pF4xNv6cbpHhmygkHELoY49Y4R80boRi4V27iwCMDJUWM+DJitnUxNzZpnEFoSb
 5z78wpcrl3AddXQaDeNqQlhSeznufv0PXGB2hD9CCE2TACHeKZXKrcjQDTFCx8mVvH8PHl4CK/4
 UnVD4YCye+GV+c5cwa8cvi+XSFmCI9CpYbg9HM9LxMDqx
X-Received: by 2002:a17:907:9448:b0:b40:a71b:151f with SMTP id
 a640c23a62f3a-b50ac1c4e7cmr1338884466b.30.1760109035247; 
 Fri, 10 Oct 2025 08:10:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc8ddHlRxqc2C3ZyaFil4eELHDUpY9sAIKvOHlmzwkIB8TO55EXcYfAaz0BzMmRZARW7u7ww==
X-Received: by 2002:a17:907:9448:b0:b40:a71b:151f with SMTP id
 a640c23a62f3a-b50ac1c4e7cmr1338880766b.30.1760109034733; 
 Fri, 10 Oct 2025 08:10:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d951d210sm254257866b.74.2025.10.10.08.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 11/19] rust/qobject: add from/to JSON bindings for QObject
Date: Fri, 10 Oct 2025 17:09:56 +0200
Message-ID: <20251010151006.791038-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010151006.791038-1-pbonzini@redhat.com>
References: <20251010151006.791038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

These are used by tests.  However it could even be an idea to use
serde_json + transcoding and get rid of the C version...

Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/wrapper.h          |  1 +
 rust/util/src/qobject/mod.rs | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/rust/util/wrapper.h b/rust/util/wrapper.h
index 0907dd59142..c88820a5e5b 100644
--- a/rust/util/wrapper.h
+++ b/rust/util/wrapper.h
@@ -37,3 +37,4 @@ typedef enum memory_order {
 #include "qobject/qobject.h"
 #include "qobject/qlist.h"
 #include "qobject/qdict.h"
+#include "qobject/qjson.h"
diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index e896aba5f3a..292a3c9c238 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -23,6 +23,7 @@
 use common::assert_field_type;
 pub use deserializer::from_qobject;
 pub use error::{Error, Result};
+use foreign::prelude::*;
 pub use serializer::to_qobject;
 
 use crate::bindings;
@@ -111,6 +112,22 @@ fn refcnt(&self) -> &AtomicUsize {
         let qobj = self.0.get();
         unsafe { AtomicUsize::from_ptr(addr_of_mut!((*qobj).base.refcnt)) }
     }
+
+    pub fn to_json(&self) -> String {
+        let qobj = self.0.get();
+        unsafe {
+            let json = bindings::qobject_to_json(qobj);
+            glib_sys::g_string_free(json, glib_sys::GFALSE).into_native()
+        }
+    }
+
+    pub fn from_json(json: &str) -> std::result::Result<Self, crate::Error> {
+        let c_json = std::ffi::CString::new(json)?;
+        unsafe {
+            crate::Error::with_errp(|errp| bindings::qobject_from_json(c_json.as_ptr(), errp))
+                .map(|qobj| QObject::from_raw(qobj))
+        }
+    }
 }
 
 impl From<()> for QObject {
-- 
2.51.0


