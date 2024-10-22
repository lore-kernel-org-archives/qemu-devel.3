Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C387CD1CDD0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Bqo-000572-8L; Tue, 22 Oct 2024 06:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bqm-00056Z-Ib
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bql-0004Q7-5z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9B3S4pkz/ND8ZX3LymjnObrKUjAIX6qwMdxq9Q+Q3M=;
 b=SD6ifI+tF2B+wjjveBxHO9LVNqVvoes4bd6026sKkeOW7vMtcggmn1+trHrFDAjvs9jCEp
 phS+Yjo5RPPrkUxEwvJDIla851LziXyXk3nTuxOBxU50g+ORJddZNxfCsL8JhEN+Zc1InX
 SG/WAhUlEdo1Sx+oFkS7290Bs3FiEG4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-LzABJowoNgejoB91X1AFWQ-1; Tue, 22 Oct 2024 06:10:49 -0400
X-MC-Unique: LzABJowoNgejoB91X1AFWQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4317391101aso14416645e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591847; x=1730196647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K9B3S4pkz/ND8ZX3LymjnObrKUjAIX6qwMdxq9Q+Q3M=;
 b=d3UzbLRbvCPGTxomKFsg48Mh88esiKyvBUgUQzLw6AaZAz4YlCkPAJD4ezFHskhZ6H
 GnV58MOMvVri9quRUHoA42QPPAcmpMmfYc2zaTwltPCv0VO0ceApBqFaG4XrUR/7C85f
 RoHgfE8oB2122D7CrjrKF1hwvtJ9RAtAwGEQPl2wq/SjuNSjebdRPqrX8RAqZgP6zFq5
 FK77XEQfGNYe3m7EP0kS8OAIRlvRnGKU+drR61LWJ/2EyEW39S5t122ucqDQIiExeXFS
 4UyOQRlqCPKcOChMbZulJ/7Bm4hnj+OHOmTDi+yBKvsoqascnHUX2m6mYIjmWT0C/B7q
 6QYQ==
X-Gm-Message-State: AOJu0YzguYD0QzQgksjQ7VnrAlo1iaqToJJNphMJJN7zAsWUTgkw6n/h
 8dE13K9bT/mx7u5AbvzGEsvoTuPlN4UX0KrjItdB/6eOa84C73PFCo0ValPsTG6uc5WNm102Ol2
 dtoqu8K7FIHIpv3dYhocghyl+W+I1jTHuT/1m6r+NjB0DF7shpRxJVLF8zB9AVpRrOJKqb3tkam
 mmsCPkXJc3mZlr7hwev7veB04uvHyPfHH8wq8EWE8=
X-Received: by 2002:a05:600c:1c95:b0:431:6083:cd2a with SMTP id
 5b1f17b1804b1-43161659c02mr124685855e9.15.1729591847429; 
 Tue, 22 Oct 2024 03:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDQGfliN2mrPSUog1KDj6MU2y/6FNACnBkmObU8eVnHfr3chcQmaoS/LkbMYCw8wpOebwq8A==
X-Received: by 2002:a05:600c:1c95:b0:431:6083:cd2a with SMTP id
 5b1f17b1804b1-43161659c02mr124685555e9.15.1729591846992; 
 Tue, 22 Oct 2024 03:10:46 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5c3194sm84592765e9.31.2024.10.22.03.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 13/14] rust: make rustfmt optional
Date: Tue, 22 Oct 2024 12:09:54 +0200
Message-ID: <20241022100956.196657-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022100956.196657-1-pbonzini@redhat.com>
References: <20241022100956.196657-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/meson.build b/meson.build
index d78afb79d67..5e3501750a1 100644
--- a/meson.build
+++ b/meson.build
@@ -115,6 +115,10 @@ if not bindgen.found() or bindgen.version().version_co=
mpare('<0.60.0')
   endif
 endif
=20
+if have_rust
+  rustfmt =3D find_program('rustfmt', required: false)
+endif
+
 dtrace =3D not_found
 stap =3D not_found
 if 'dtrace' in get_option('trace_backends')
@@ -3973,6 +3977,13 @@ if have_rust
     '--allowlist-file', meson.project_source_root() + '/.*',
     '--allowlist-file', meson.project_build_root() + '/.*'
     ]
+  if not rustfmt.found()
+    if bindgen.version().version_compare('<0.65.0')
+      bindgen_args +=3D ['--no-rustfmt-bindings']
+    else
+      bindgen_args +=3D ['--formatter', 'none']
+    endif
+  endif
   if bindgen.version().version_compare('<0.61.0')
     # default in 0.61+
     bindgen_args +=3D ['--size_t-is-usize']
--=20
2.46.2


