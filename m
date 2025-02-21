Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4867EC021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRz-0008S9-R1; Fri, 21 Feb 2025 12:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRw-0008Ck-NA
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRu-0001Xe-64
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gITORNAi3idPJ7f7HHnX56O6J1H0hwCpHvwebA0yrfA=;
 b=TWqImNhRgjI0EEqsovcpEuJtdP9sxKfHpFb8AP3k24iU5kYbNqg1pRXzXMD4JG/bh7ZvNB
 r1RflNVCGAnjcKcs4/iJzATKVcBc9KKhAlZbzpYevDYFoFTGj8NEvAmvOiVUWMGoQYfJhj
 ARsiqOJ2ADx6wJrnsHR2558P+87/qro=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-YyB2QBF7OkGk8KTeyiTe_w-1; Fri, 21 Feb 2025 12:04:24 -0500
X-MC-Unique: YyB2QBF7OkGk8KTeyiTe_w-1
X-Mimecast-MFC-AGG-ID: YyB2QBF7OkGk8KTeyiTe_w_1740157463
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab7f6f6cd96so64125966b.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157462; x=1740762262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gITORNAi3idPJ7f7HHnX56O6J1H0hwCpHvwebA0yrfA=;
 b=kXmUnNO0+VK9GtRo9xmxRfX64XOC4YS55cr+HM+WlskNjM4/CLKNno72ZU8J5Qh3Z2
 UGQWbR9d51J+m8wQYU3m6iWWspbCLR573uiwtX5fhU5HwcrGPByAbesP1JJ5rrFEqFk2
 XAhGnuio6uTTVXA64+jBcj1+Tb2CpmyqvFk09AWYEAJK2X/zZAkIKT9bwOHvoNyLYk8I
 wbOeEdkZ+3O/4Em45LOSyl46cjtKNhdnujyX6kik+Lx/s2AcpKgSgR5FIftBDTVpDnd3
 XujwhyW2IcemG3LLQoihTMSIGI2XynpzWw1i6ezLZ3HD+/bTiK3burakwKLGfX745VXM
 cIiA==
X-Gm-Message-State: AOJu0Yy6/DfL8pNMkgLVAScB/hZTpkAiMeFXR4lD1kEJzfcjuPsw3Lz/
 5QLe90fs6f6vp2FcQe7GbVz0oFuyXXywyucYEAy2cgxXu+Lni/SljQnB4xcLEcLv8Qz9hYKNpBG
 MbOfwubET/rTPZGsZXQWLAXTIZPOu6A4rZnOY3aQCETgWTTyH7VTddgC+2Od0XKktwwFP6rEo4b
 G0sZasSKT/DvWpyByXJKxosE5HHTPHMrWju2A+sZs=
X-Gm-Gg: ASbGnct1JTupu8y7k4jnRksSBar+W93t8REbxunlj15+eDt1igJ9ivJs+GEtTZPjC40
 F+r6xD3AGVGuINpc81aykNT7Dtf8oJfAE6r3Hs3XsJo/eZtHVBSgiJ5HBmlgx1YMLjwPeUdeGWf
 Sf6fNXCxbEsGfDrkdJapcDkC7WyYAAHIomYQFd2KRYqJby7LFZYkauAyTCsABB7SraK4DKdRCe0
 U6MUuMQDoo44Uijan4AVus4NEp8mDmGVsaczUid6JoU57Pa15MxsURGNOGMcHHoZSmiz0ZWCn+V
 J7LDBcl+wd1zKNjNWG8=
X-Received: by 2002:a17:907:d204:b0:ab9:63bd:91be with SMTP id
 a640c23a62f3a-abc099b3911mr472630166b.3.1740157462312; 
 Fri, 21 Feb 2025 09:04:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHh3OiPvtScaPUKA6oR2syBGUS8aeCMOzQAoTZ6jAjPhsuT4a36zKEOsBZELst31y+ZScBTgg==
X-Received: by 2002:a17:907:d204:b0:ab9:63bd:91be with SMTP id
 a640c23a62f3a-abc099b3911mr472617766b.3.1740157461568; 
 Fri, 21 Feb 2025 09:04:21 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abbda707e3dsm535043666b.106.2025.02.21.09.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:04:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 14/15] rust: chardev: wrap Chardev with Opaque<>
Date: Fri, 21 Feb 2025 18:03:41 +0100
Message-ID: <20250221170342.63591-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170342.63591-1-pbonzini@redhat.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs | 3 ---
 rust/qemu-api/src/chardev.rs  | 8 ++++++--
 rust/qemu-api/src/qdev.rs     | 1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 26cc8de0cf2..c3f36108bd5 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -31,9 +31,6 @@ unsafe impl Sync for BusState {}
 unsafe impl Send for CharBackend {}
 unsafe impl Sync for CharBackend {}
 
-unsafe impl Send for Chardev {}
-unsafe impl Sync for Chardev {}
-
 unsafe impl Send for ObjectClass {}
 unsafe impl Sync for ObjectClass {}
 
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index 74cfb634e5f..a35b9217e90 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -6,9 +6,13 @@
 
 use std::ffi::CStr;
 
-use crate::{bindings, prelude::*};
+use crate::{bindings, cell::Opaque, prelude::*};
+
+/// A safe wrapper around [`bindings::Chardev`].
+#[repr(transparent)]
+#[derive(qemu_api_macros::Wrapper)]
+pub struct Chardev(Opaque<bindings::Chardev>);
 
-pub type Chardev = bindings::Chardev;
 pub type ChardevClass = bindings::ChardevClass;
 
 unsafe impl ObjectType for Chardev {
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index ed5dce08216..1ff6c1ca7c2 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -334,6 +334,7 @@ fn init_clock_out(&self, name: &str) -> Owned<Clock> {
     fn prop_set_chr(&self, propname: &str, chr: &Owned<Chardev>) {
         assert!(bql_locked());
         let c_propname = CString::new(propname).unwrap();
+        let chr: &Chardev = chr;
         unsafe {
             bindings::qdev_prop_set_chr(
                 self.upcast().as_mut_ptr(),
-- 
2.48.1


