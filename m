Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC889D2169C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hRH-00026R-Nl; Tue, 15 Oct 2024 09:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRF-000267-41
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRB-0001Gx-Eg
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCwCwTmGgLCTaKNM2sPmatRSOdUjZKvsf7/Jf9mknBI=;
 b=IvCA3XEfUa7HmKBpGOiGV1CYjsC3rXkHowVdmnwKkKpxIqQARUYHGtd0GrtpWUwwErMS77
 4q5ILxvDgit8jJLrtuP/GpsjgrAiTjU3ybj3dh+/St6QGbfknkLKlYHXOzZ4P5Zpa3IVNK
 QUqaesxkh+y+YWy3rOFJxQ9YfKBw810=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-CZeSv_-YONmYnRR00n38gw-1; Tue, 15 Oct 2024 09:18:05 -0400
X-MC-Unique: CZeSv_-YONmYnRR00n38gw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42ac185e26cso33090805e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998284; x=1729603084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aCwCwTmGgLCTaKNM2sPmatRSOdUjZKvsf7/Jf9mknBI=;
 b=i/vvfx6pt+yomIcvGqYDgEwlO2pnd/+lCDiS8wIm/Ux1NMKRnZSfuR2Qhn/4WskHZy
 00CMdOxp1GzQSVNpgp4rgBbwpj7N/z8JAi08BfMiy5hxWxokCrjRtjTP8+hIPX5AVqz4
 TIdDln96nle0bTl19qNpA9ueXsVqNfF5/P8YfJ9JRzuYCJElf0fpv9uJJnFeGKAMJ+fF
 4lPFdhsxMXYIsKZgLPdxrN2RctR+bWfQa8vIVQMhpLi+gv5TKo7e6ADlqpDGkK3Dkb8q
 6VQnXkmAVJijXFRjVCAqDXYg6zbbDm/4OGNzznHnRyNaUuOiVh1goNtan/MSwhktoLSB
 8GQA==
X-Gm-Message-State: AOJu0YyhuhqYbEbQF5T/89cezIp5HY20SMdR5V8icZMKL4p28A/4aW6I
 xJLHWcvGJygwNypUVVw1nRYBMFX5CbnDggY2oFz7lRrYTtn7vFZSg7p5p53yV5WE/NO5g53KIuQ
 O2WsfF2JkvdzLyCQX7EgYilPBbMZHeMHn29AbMqs098+309EzIGj8ex80H93XjgYXL1UoonG5Hb
 uWkcOiXJPt4vNWn0/WyGaEOGINiGeWH76B4j55yoI=
X-Received: by 2002:a05:600c:4e92:b0:42c:bf79:78f7 with SMTP id
 5b1f17b1804b1-4314a3ac94cmr4982635e9.32.1728998283921; 
 Tue, 15 Oct 2024 06:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT6eHgqusATpv6TcBpSjOJQF9Sk7UimXT8ELzQXospKO18XeD917Juo2Bgp93tYo0gCuwf1Q==
X-Received: by 2002:a05:600c:4e92:b0:42c:bf79:78f7 with SMTP id
 5b1f17b1804b1-4314a3ac94cmr4982385e9.32.1728998283468; 
 Tue, 15 Oct 2024 06:18:03 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f55dec4sm17913545e9.8.2024.10.15.06.18.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:18:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/16] rust: build tests for the qemu_api crate
Date: Tue, 15 Oct 2024 15:17:26 +0200
Message-ID: <20241015131735.518771-9-pbonzini@redhat.com>
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

Fix some bitrot in tests.rs, and allow the unit tests to be run via
"meson test".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build  | 3 +++
 rust/qemu-api/src/tests.rs | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 42ea815fa5a..436e2f1e836 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -5,6 +5,7 @@ _qemu_api_rs =3D static_library(
       'src/lib.rs',
       'src/definitions.rs',
       'src/device_class.rs',
+      'src/tests.rs',
     ],
     {'.' : bindings_rs},
   ),
@@ -19,6 +20,8 @@ _qemu_api_rs =3D static_library(
   ],
 )
=20
+rust.test('rust-qemu-api-tests', _qemu_api_rs)
+
 qemu_api =3D declare_dependency(
   link_with: _qemu_api_rs,
 )
diff --git a/rust/qemu-api/src/tests.rs b/rust/qemu-api/src/tests.rs
index df54edbd4e2..f0cd4d5d716 100644
--- a/rust/qemu-api/src/tests.rs
+++ b/rust/qemu-api/src/tests.rs
@@ -43,7 +43,7 @@ pub struct DummyState {
         dummy_class_init,
         props =3D> DUMMY_PROPERTIES,
         realize_fn =3D> None,
-        reset_fn =3D> None,
+        legacy_reset_fn =3D> None,
         vmsd =3D> VMSTATE,
     }
 }
--=20
2.46.2


