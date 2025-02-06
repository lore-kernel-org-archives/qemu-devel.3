Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBE3C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfzr1-0002Fj-SY; Thu, 06 Feb 2025 06:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfzqu-0002DJ-76
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:15:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfzqs-0003df-9s
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738840521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=m77f0bUtjRDH0qejNFTZ2BDHt8Yr4jUi+cc/tAawOcA=;
 b=YNcnTNfteApVrny04PjClkUj1itWj3/IjHw6PFqW3ZWrOSMjLTJQ5dbdytxDc5NZFFPSso
 k/riIDb/p1UbBWLkDxFggsgSbhD/ArnE4qkCR14cZUQM0Nt2HxkyzChZUdyRS056xfjBzD
 O3yvqfGYZEzUnoaXYiprPmRXKlS9m9I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-SFmQ6gcMM1CVryj6udg1yA-1; Thu, 06 Feb 2025 06:15:18 -0500
X-MC-Unique: SFmQ6gcMM1CVryj6udg1yA-1
X-Mimecast-MFC-AGG-ID: SFmQ6gcMM1CVryj6udg1yA
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5dce1b1a2b3so921477a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738840516; x=1739445316;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m77f0bUtjRDH0qejNFTZ2BDHt8Yr4jUi+cc/tAawOcA=;
 b=grOB4NBrPOvcxm5XPXh7ZXqdXTEmamroAnDI7nWPcXUevwvzIZ3hfJjLUmLPnaq+1P
 Jdvq0NlnepjQMKJRrcqsFTal96e3npODvrnG6/oddSFTF8VAj0qVTfFGQL4WtMkuglo5
 JN78MN6/eR+FwQrB5dKOBO7URzu1y9cVeia5W0PG86QCKm/X7jL0ZsB8McxZ8KUFKAFj
 zTj7QG/ExmRYTJhHRXcaSMLWT0kq/NwSca6kNypFgFW7mWPKmuDiMu/RgZ5Axc6GTD+E
 hiVzqVE479sLoZD6mJu5RhynfewIFcWywsY+ZMHaEPc5LM3nf/X1pN2Y0YD6JGGGDiV0
 OblA==
X-Gm-Message-State: AOJu0YzjHsNGnVSyM6e2v8HV1OcuVKT22auZgJytFPIXhCG067yyyt3S
 9yD/6qHXw02FJywRnWbG4gYPbbIK0PUJBgzoTJr8Qz7pK6tYawO4yOjFx7vJX1mFTu+u2tpkPXG
 qIAUzPdNxfssEid+RXK4V2hBum7sM2DlulngWgQTeZpP+GJQPZjonLG65bWLLkMPy3TqAYz2Z5/
 TE3HaHZPYLSNq81iMeBj5aOkC+qXcyr9blo8RJtKg=
X-Gm-Gg: ASbGnctSdLuIBr4Zuj7V2Ty3tQlhx8Dz3ZkRluIIvRpMQCMelnoNfPw2+EGZ9tycYHG
 J7tNJJ7t9xIfxsQYrHNhaqsxWhaw0CT4KKIJ2BKsoZt4p8rDcBMZOa8IHofpUCwNBFFf+w+lsaj
 y/ciYSGaQKfern384GKwt1l003JIWs15rKkw6TDCTZLDLfAvZFw9vozweBq2BmS67W2TqV4f4Ao
 kiLR4g+29h+C453Y52cgCnjNYk2jZ2M8/NpRDfZi1QJXIaaokVs146/PJ2SbU+hpvXUze2wjqnp
 JIjDew==
X-Received: by 2002:a05:6402:40c5:b0:5da:7f7:b9b2 with SMTP id
 4fb4d7f45d1cf-5dcdb732c11mr7703759a12.18.1738840516540; 
 Thu, 06 Feb 2025 03:15:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFXFiJfbo/Z5iMfloeMglLdqgr5BpeKwIf2TdFBqn5bf67d0vO+ehcJSOY1gfhuhCCJc8Jpw==
X-Received: by 2002:a05:6402:40c5:b0:5da:7f7:b9b2 with SMTP id
 4fb4d7f45d1cf-5dcdb732c11mr7703699a12.18.1738840516047; 
 Thu, 06 Feb 2025 03:15:16 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf1b739e2sm692506a12.14.2025.02.06.03.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 03:15:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH] rust: add --rust-target option for bindgen
Date: Thu,  6 Feb 2025 12:15:13 +0100
Message-ID: <20250206111514.2134895-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Without it, recent bindgen will give an error

   error: extern block cannot be declared unsafe

if rustc is not new enough to support the "unsafe extern" construct.

Cc: qemu-rust@nongnu.org
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meson.build b/meson.build
index 2c9ac9cfe1e..131b2225ab6 100644
--- a/meson.build
+++ b/meson.build
@@ -4054,6 +4054,9 @@ if have_rust
       bindgen_args += ['--formatter', 'none']
     endif
   endif
+  if bindgen.version().version_compare('>=0.66.0')
+    bindgen_args += ['--rust-target', '1.59']
+  endif
   if bindgen.version().version_compare('<0.61.0')
     # default in 0.61+
     bindgen_args += ['--size_t-is-usize']
-- 
2.48.1


