Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D6DD1CDCF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Bqf-000520-Nl; Tue, 22 Oct 2024 06:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bqc-0004vG-K2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bqa-0004PU-SM
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PBRhOELsRn9xQQiWxQ4MS4Iao+woVuEtGdzYywQ/DGE=;
 b=dx3RbDRXRWrW6XfS7FdVBurOht5OK9uDrLYVcuJe83ZQEcmDl6rS0O/l7ScYvYuRopx1/l
 DJGvKALZrEwDMvNF8vkPfslKvX1VlbnrBwsRjYAeHlvA2/WKMOewpDEBx8zlkAzkzlLZbp
 lQsQ+iJC2tMqgTR9xjZ1KBXalgiXPf8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-oYG8AMCJMEi8EQj7rbhQ_Q-1; Tue, 22 Oct 2024 06:10:38 -0400
X-MC-Unique: oYG8AMCJMEi8EQj7rbhQ_Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d49887a2cso3024991f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591837; x=1730196637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBRhOELsRn9xQQiWxQ4MS4Iao+woVuEtGdzYywQ/DGE=;
 b=mTGBcSk6/qNaFqVWLG7YF+Wzro343smYVnKErSi8B5Zo5VKN2qjcQDadcRKjvnIzOp
 m0bIdvQs5wylvyftA5ES4OGeb84Igqv+sz4me0G3Xpel7tV/5oF2QlfPFLwCU4mtCEug
 snTSoc/pnoanBqOMztU0+tI1gMKOCopyQGXqXZyCNZlCBjcuO/1C3P6BW8kasWhzdqjq
 FuwGQFQSIIGtyAuszWN5dokM8w12/1qzdiM2LtN4onkF7ZQCvP9FmlCVazDXbNyh8Hgx
 DuE1zZ8zP+crmHt5omitaPOy2PzqBTTjFGOVk0zt/tsE7jIR1xq+RF5p97TLZsc/1ev7
 R+0g==
X-Gm-Message-State: AOJu0YyrdrUmmzhKuco3MsrMbn6xDLyBDvkEnX/rLckWZyQcLyEUf/+6
 gp0l6V+LFEmCu/dY/5eJ5Lo31NAS2frFlxM5qRVp5McGZohXaRvZqO6UkHUNxh7xyf/jHnjr8QQ
 z3BHQlg1tUV3shcOlKQuBPv/hv6d9H/UYcLzQY/+ZHTLU7w24y05lhMmc7Gn8AmiskexMNO1QfG
 xJhyDWhhNNLzbT1M+FD47g+/PQTnOlCjtXwgx/L/g=
X-Received: by 2002:adf:e54c:0:b0:371:6fc7:d45d with SMTP id
 ffacd0b85a97d-37ef1263b35mr1699932f8f.2.1729591837111; 
 Tue, 22 Oct 2024 03:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMglMYBxnOmMQKOThNtR81vbuaOXQHUSglgnAY0h0XMLxiJLA1jMKp4WiYGoFYzWmn9H79nw==
X-Received: by 2002:adf:e54c:0:b0:371:6fc7:d45d with SMTP id
 ffacd0b85a97d-37ef1263b35mr1699916f8f.2.1729591836675; 
 Tue, 22 Oct 2024 03:10:36 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a487bdsm6312221f8f.32.2024.10.22.03.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 10/14] rust: allow version 1.63.0 of rustc
Date: Tue, 22 Oct 2024 12:09:51 +0200
Message-ID: <20241022100956.196657-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022100956.196657-1-pbonzini@redhat.com>
References: <20241022100956.196657-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

All constructs introduced by newer versions of Rust have been removed.

Apart from Debian 12, all other supported Linux distributions have
rustc 1.75.0 or newer.  This means that they only lack c"" literals
and stable offset_of!.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index e411a8ae567..9c57d7e5c6d 100644
--- a/meson.build
+++ b/meson.build
@@ -89,11 +89,12 @@ have_rust =3D have_rust and add_languages('rust', nativ=
e: true,
     required: get_option('rust').disable_auto_if(not have_system))
 if have_rust
   rustc =3D meson.get_compiler('rust')
-  if rustc.version().version_compare('<1.80.0')
+  if rustc.version().version_compare('<1.63.0')
     if get_option('rust').enabled()
-      error('rustc version ' + rustc.version() + ' is unsupported: Please =
upgrade to at least 1.80.0')
+      error('rustc version ' + rustc.version() + ' is unsupported. Please =
upgrade to at least 1.63.0')
     else
-      warning('rustc version ' + rustc.version() + ' is unsupported: Disab=
ling Rust compilation. Please upgrade to at least 1.80.0 to use Rust.')
+      warning('rustc version ' + rustc.version() + ' is unsupported, disab=
ling Rust compilation.')
+      message('Please upgrade to at least 1.63.0 to use Rust.')
       have_rust =3D false
     endif
   endif
--=20
2.46.2


