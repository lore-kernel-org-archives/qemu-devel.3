Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDF6D216A2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hQx-00022c-Vc; Tue, 15 Oct 2024 09:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hQu-00021f-1V
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hQr-0001DA-LI
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZ1Ej6J1Xip3zM5oXGhlOoK0TB4E/q4HLVZ4bLRAX5M=;
 b=cbeWAB9dl2RRXGerOjrRk2VnHp3L/VKjcyhkxRj0pjAbJHJj7Ojru9tioSx+eM3OeSYiN0
 IbHrgc+LbPo1aZNNKo2qaz6X0OxX5zhKxR+XdCsvgA1HZ79mlNjXKlsGHAkic0oR6mzShV
 xKv2RUr4RvTNjUSwas7ZqpHWg/1utRw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-5qFZKKYcPzauhScpTUSyhQ-1; Tue, 15 Oct 2024 09:17:47 -0400
X-MC-Unique: 5qFZKKYcPzauhScpTUSyhQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43058dce286so30856495e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998266; x=1729603066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZ1Ej6J1Xip3zM5oXGhlOoK0TB4E/q4HLVZ4bLRAX5M=;
 b=gk/P/b6aFQFEm43CJYVccjFiBDGqcI2s+TQu9T65iE7iyB2IVr9VsPWvF6uyMp7+MV
 E7CuKi9a/22Eb8/DywWUoBkvJ+qtDuTe9ugGIUprl+LgdRLCiWTpCiXzmgWFV97ytlF6
 jrXJVORUmJxQlX2Qf8sxJazut5rmcE5Nd9ZCBInyknbumK0mJ7Fw8eqUedvCsz/OmpB7
 cn3NwndpQTsJbDzZY8vy36wDgMIAhxSzZd9f4nl1k8jHbp7D5gSQSGyiwQyrsc5MF58J
 tBz1159ViaTrkYUQj8fG0IFGvGnPqxg91H6XP716q+AHzEJltzUzWlgyp3rPZUfOWyJV
 WJKQ==
X-Gm-Message-State: AOJu0YzU+3C4LOaDhajqJgr+IIlEU/lk3L4NTDfcA5PNKCNyblg/hwC5
 ifokZPkJwwTultM5f1vAj/DTZDBeHds75sFXmarQpk/Cex1nmiArfL3cpJepF+nfqfnzbZhavVE
 tSZf3mVL4MyUDS5u72L46MQzVIeDIaqLGTva48uWCTO429B+GNGcK8vz2zB0BONyRehivDgHs5p
 njFWmA2DO39EkKrUcqo7IQ7w39iuXYA/aS1B/OT0A=
X-Received: by 2002:a05:600c:4f07:b0:426:6308:e2f0 with SMTP id
 5b1f17b1804b1-4312560975amr99148085e9.26.1728998266147; 
 Tue, 15 Oct 2024 06:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4kEsNGdcOKLd8Oyi2NSf/W7cNeeKzwn65FhISQ1harOA53k4+e/WhViqzP16JZ05qMEslrQ==
X-Received: by 2002:a05:600c:4f07:b0:426:6308:e2f0 with SMTP id
 5b1f17b1804b1-4312560975amr99147895e9.26.1728998265746; 
 Tue, 15 Oct 2024 06:17:45 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f569933sm17908435e9.13.2024.10.15.06.17.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:17:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/16] meson: remove repeated search for rust_root_crate.sh
Date: Tue, 15 Oct 2024 15:17:20 +0200
Message-ID: <20241015131735.518771-3-pbonzini@redhat.com>
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

Avoid repeated lines of the form

Program scripts/rust/rust_root_crate.sh found: YES (/home/pbonzini/work/ups=
tream/qemu/scripts/rust/rust_root_crate.sh)

in the meson logs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index c2e736d2051..37f94ab32aa 100644
--- a/meson.build
+++ b/meson.build
@@ -3977,6 +3977,7 @@ endif
=20
=20
 feature_to_c =3D find_program('scripts/feature_to_c.py')
+rust_root_crate =3D find_program('scripts/rust/rust_root_crate.sh')
=20
 if host_os =3D=3D 'darwin'
   entitlement =3D find_program('scripts/entitlement.sh')
@@ -4078,7 +4079,7 @@ foreach target : target_dirs
     if crates.length() > 0
       rlib_rs =3D custom_target('rust_' + target.underscorify() + '.rs',
                               output: 'rust_' + target.underscorify() + '.=
rs',
-                              command: [find_program('scripts/rust/rust_ro=
ot_crate.sh')] + crates,
+                              command: [rust_root_crate, crates],
                               capture: true,
                               build_by_default: true,
                               build_always_stale: true)
--=20
2.46.2


