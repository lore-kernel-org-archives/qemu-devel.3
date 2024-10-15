Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738C7D2169C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hRV-00029u-4L; Tue, 15 Oct 2024 09:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRT-00029K-Oe
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRS-0001Ok-9I
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=guzIU8szJRoPg8gn1V5aPIVykgsXGQXnmT0CyHWL5RY=;
 b=azVZ9G8Bh0MplyhTU+8hNnlH8MTskL6RMnXnDeGiqg0M5SK6ehJoODYkBMqvC4oCbJUdK/
 fF1x+oKkVStDYR55wb2iADkTDqIqXBBAscDwKbcCgWLIEq7TWBNlPAbM6Migy7VHdNa1sB
 gIvuj9jLkjHIoIpDwnkLOmGDq1AR4d4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-Xwzp_SI9MoyoA_ah1uzquA-1; Tue, 15 Oct 2024 09:18:24 -0400
X-MC-Unique: Xwzp_SI9MoyoA_ah1uzquA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539fbf73a2fso1672283e87.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998302; x=1729603102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=guzIU8szJRoPg8gn1V5aPIVykgsXGQXnmT0CyHWL5RY=;
 b=IJS1TcGopEneu+H/dbnhVE/BeTVBW+pchSdSx142XzObpndeCAXrOZPGoTeSPtQ3KK
 N8uLhCBEnAdsbFGRpnHsrmktXFFBF6wQbruZHbk9W5NpHF7Dfy9Xnn/jA3Tlr6JqvzZq
 i/UBh05LQ4+L1yyghsQCFzjYxP6pwfQbnAZcXp4NukbzoukX/O990ipNN42yi6gsbOlq
 MXhyR5X9SDKBnkL3p7BhplRX9bPA3NsuVrHi0rTSiVVmpGStdOpBi5eX3d6sdfMmHUy+
 wyldr2dixcyw/Q6Q/1Jv8Rs94DKwx37mDTtReNF9eBYNENV8hFTcmsVifNHg0nexFVwU
 rwOg==
X-Gm-Message-State: AOJu0Yz7mX4/A/U8YaXDwi5xw2lN9+y0Ovugy2/bS3sYqJ6BOoo0eQL7
 sp/uq5ZTvKE/w2zcfatjYZkK/sZuV97S+JBky48O26wxvgxM2vdpciPa0BXNvqbtjXWlu7b3qf9
 3bRGqA/RCqMgbgeB6nvaZGlbRdJwDJILwRrfJq4W+y4zJv40xiISVpQHGfW3xrCQcjtsVqzXNqu
 gk7DZIYfO7VuAnIOyNHjgOYjyiTCF2FmLlDQeN+74=
X-Received: by 2002:a05:6512:2255:b0:539:e436:f1cc with SMTP id
 2adb3069b0e04-539e574b003mr5002506e87.52.1728998302025; 
 Tue, 15 Oct 2024 06:18:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhsSY5Q/9ZWPH6Fo3zmbC+TtIrdG3pKvpCGsctfyBz7WXqSk/GpDore8ekzA+fvsdri9guKg==
X-Received: by 2002:a05:6512:2255:b0:539:e436:f1cc with SMTP id
 2adb3069b0e04-539e574b003mr5002490e87.52.1728998301468; 
 Tue, 15 Oct 2024 06:18:21 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f569ef4sm17900355e9.18.2024.10.15.06.18.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:18:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/16] rust: do not use --no-size_t-is-usize
Date: Tue, 15 Oct 2024 15:17:32 +0200
Message-ID: <20241015131735.518771-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This not necessary, and adds an extra cast since size_of and align_of
already return the right type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                      | 1 -
 rust/qemu-api/src/definitions.rs | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 0e279d245b4..3b35fcb3feb 100644
--- a/meson.build
+++ b/meson.build
@@ -3931,7 +3931,6 @@ if have_rust and have_system
     '--merge-extern-blocks',
     '--no-doc-comments',
     '--with-derive-default',
-    '--no-size_t-is-usize',
     '--no-layout-tests',
     '--no-prepend-enum-name',
     '--allowlist-file', meson.project_source_root() + '/include/.*',
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitio=
ns.rs
index aa7cdd69c99..4eaf2a91fab 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -83,13 +83,13 @@ macro_rules! type_info {
             } else {
                 ::core::ptr::null_mut()
             },
-            instance_size: ::core::mem::size_of::<$t>() as $crate::binding=
s::size_t,
-            instance_align: ::core::mem::align_of::<$t>() as $crate::bindi=
ngs::size_t,
+            instance_size: ::core::mem::size_of::<$t>(),
+            instance_align: ::core::mem::align_of::<$t>(),
             instance_init: <$t as $crate::definitions::ObjectImpl>::INSTAN=
CE_INIT,
             instance_post_init: <$t as $crate::definitions::ObjectImpl>::I=
NSTANCE_POST_INIT,
             instance_finalize: <$t as $crate::definitions::ObjectImpl>::IN=
STANCE_FINALIZE,
             abstract_: <$t as $crate::definitions::ObjectImpl>::ABSTRACT,
-            class_size:  ::core::mem::size_of::<<$t as $crate::definitions=
::ObjectImpl>::Class>() as $crate::bindings::size_t,
+            class_size:  ::core::mem::size_of::<<$t as $crate::definitions=
::ObjectImpl>::Class>(),
             class_init: <<$t as $crate::definitions::ObjectImpl>::Class as=
 $crate::definitions::Class>::CLASS_INIT,
             class_base_init: <<$t as $crate::definitions::ObjectImpl>::Cla=
ss as $crate::definitions::Class>::CLASS_BASE_INIT,
             class_data: ::core::ptr::null_mut(),
--=20
2.46.2


