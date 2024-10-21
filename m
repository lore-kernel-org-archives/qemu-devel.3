Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263B8D0E6FA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qpC-000104-8m; Mon, 21 Oct 2024 07:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2qp9-0000vJ-Tr
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2qp7-0002RJ-Mb
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729511025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvbTdqaEaf4wXZnu3ff1Qc4CfxzGOCroOxwxcythHLo=;
 b=jWZjVIREEkxDMJzPBDGWoJkbGPn3rAFwKzdQYvpDgug8+Gpw+uSaFpt70KUt6wULxQHlOz
 FGOVH+VIBKkm84tf++pzcP/f2UUStGiWTUcw4nnwhVXFCwSE8l2YnQhSq+9Wm/CJZv8g/5
 YwmJnhkNFCzTsWa28GZaKx4e/MKFvSU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-RbeVYON1NZ6uj6V9nG1LkQ-1; Mon, 21 Oct 2024 07:43:41 -0400
X-MC-Unique: RbeVYON1NZ6uj6V9nG1LkQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43159603c92so30636585e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 04:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729511020; x=1730115820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvbTdqaEaf4wXZnu3ff1Qc4CfxzGOCroOxwxcythHLo=;
 b=ZItXhRMY5EVNu98ZcEOjjU6V4rz32u6HAIR00w3U/Z+AZ8109hR2EB2C9cQKCXv682
 DDITWPL+zm2brv0A0ZB3WmGYm7tlLmkYlHxiCQrNieF2KNqlWUPgbiUvfCl+VGboA0Y6
 jjn4SwgXO/6VyZjzJqVGq6HTiGO3iy7eziDFKtx1yGBDgP9592/y/YAUwvP2cEbT2L3E
 5k96SJ6xTFAQcceYZi6iqa/1qr5D2EtNNgZeksPDVszCEfstOpu2TqvNtA3waOegjPur
 RnE3PVzQhWqEa0gz3cESTgs/LPkAo0GRWBQpVC9lRRYvuWIRz1/vTRPg8uzmCBVFZKBK
 JyRA==
X-Gm-Message-State: AOJu0YyZh4J+twxtfbMwMDJIKwQvFP35dPITmuhVtX9hA7ExKcQPo/m1
 q8hw6IXyBiKMu+CZthLGDCtJ6mnI4GHBpibRtWHlvo9nFHlS7o9qL1PSOtCPWq+QFwkZsAXBX46
 uAqmURjCJjki5/V6I7IVat71jcyEQkbyYV8fw6+v3SXpLnJHfzoLE1YQUhQu0eKAO9IAPYSHscw
 L1hHPNsTtQMLn9kyGM600vwepd5uA=
X-Received: by 2002:a05:600c:4fd4:b0:431:5533:8f0c with SMTP id
 5b1f17b1804b1-431616ad341mr88933465e9.29.1729511020400; 
 Mon, 21 Oct 2024 04:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyu/Vx7m7UiGxR4PA7vRoWq4jKJPvHlSpkXesB3kPvcmyzqZaNzJ2rU87emEiUSojHPWdeCBmKV7ojR9PiyGg=
X-Received: by 2002:a05:600c:4fd4:b0:431:5533:8f0c with SMTP id
 5b1f17b1804b1-431616ad341mr88933305e9.29.1729511020055; Mon, 21 Oct 2024
 04:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-9-pbonzini@redhat.com>
 <SY0P300MB10265D6A0FEDF3DE07F2220395432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB10265D6A0FEDF3DE07F2220395432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Oct 2024 13:43:27 +0200
Message-ID: <CABgObfbUWFf_Mr+PR5_TZ0A6n29sZwdJ3umJFdTHgPHiVZrU4Q@mail.gmail.com>
Subject: Re: [PATCH 08/13] rust: build integration test for the qemu_api crate
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Oct 21, 2024 at 1:35=E2=80=AFPM Junjie Mao <junjie.mao@hotmail.com>=
 wrote:
>
>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > Adjust the integration test to compile with a subset of QEMU object
> > files, and make it actually create an object of the class it defines.
> >
> > Follow the Rust filesystem conventions, where tests go in tests/ if
> > they use the library in the same way any other code would.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  meson.build                  | 10 ++++-
> >  rust/qemu-api/meson.build    | 20 +++++++--
> >  rust/qemu-api/src/tests.rs   | 49 ----------------------
> >  rust/qemu-api/tests/tests.rs | 78 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 104 insertions(+), 53 deletions(-)
> >  delete mode 100644 rust/qemu-api/src/tests.rs
> >  create mode 100644 rust/qemu-api/tests/tests.rs
> <snip>
> > diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> > index 42ea815fa5a..d24e0c0725e 100644
> > --- a/rust/qemu-api/meson.build
> > +++ b/rust/qemu-api/meson.build
> > @@ -14,11 +14,25 @@ _qemu_api_rs =3D static_library(
> >      '--cfg', 'MESON',
> >      # '--cfg', 'feature=3D"allocator"',
> >    ],
> > -  dependencies: [
> > -    qemu_api_macros,
> > -  ],
> >  )
> >
> >  qemu_api =3D declare_dependency(
> >    link_with: _qemu_api_rs,
> > +  dependencies: qemu_api_macros,
> >  )
> > +
> > +# Rust executable do not support objects, so add an intermediate step.
> > +rust_qemu_api_objs =3D static_library(
> > +    'rust_qemu_api_objs',
> > +    objects: [libqom.extract_all_objects(recursive: false),
> > +              libhwcore.extract_all_objects(recursive: false)])
> > +
> > +rust.test('rust-qemu-api-integration',
> > +     static_library(
> > +         'rust_qemu_api_integration',
> > +         'tests/tests.rs',
> > +         override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'=
],
> > +         link_whole: [rust_qemu_api_objs, libqemuutil]),
> > +
> > +     dependencies: [qemu_api, qemu_api_macros],
> > +     suite: ['unit', 'rust'])
>
> I met the following error when trying to build the test:

It works for me, but I'll switch to your meson.build code just to be safe.

Paolo

> test('rust-qemu-api-integration',
>     executable(
>         'rust_qemu_api_integration',
>         'tests/tests.rs',
>         override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
>         rust_args: [
>             '--test',
>         ],
>         install: false,
>         dependencies: [qemu_api, qemu_api_macros],
>         link_whole: [rust_qemu_api_objs, libqemuutil]),
>     args: [
>         '--test',
>         '--format', 'pretty',
>     ],
>     protocol: 'rust',
>     suite: ['unit', 'rust'])
>
> --
> Best Regards
> Junjie Mao
>


