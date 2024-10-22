Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A59ED1CDA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 05:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t37G0-0000NI-LQ; Tue, 22 Oct 2024 01:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t37Fy-0000Mx-Pu
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t37Fw-0003J7-Cy
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729574190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfVL7RpZauNCOcXaXc3evqKRARVQMOaGg7gt7Ve5nA8=;
 b=Ishrsfm2ntbt4YWrfHvuil5IBRVz9oc8wSxGk9CqBRbmzFiBrcnArQhamwhsAEg/3Y6xtN
 KV0ag/4H/fIMHC0ZiDigK8IZcP91yCygU7m+a/L0FNgGkEqxq+uKWbnmPmT0R+h6Mbvm3z
 uJjm21SDgmp4KP+j/pbX/01+0kNwODE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-OqvbSSJUN1KlHBE8x0K3BA-1; Tue, 22 Oct 2024 01:16:28 -0400
X-MC-Unique: OqvbSSJUN1KlHBE8x0K3BA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4314f1e0f2bso36168185e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 22:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729574187; x=1730178987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfVL7RpZauNCOcXaXc3evqKRARVQMOaGg7gt7Ve5nA8=;
 b=Tlx1jqyoLF9snBTUmwDyNy8HJRaJlBssvdjuVZ5KdZPBIa0joJSblXFgshEwd1bGl5
 naqUSFSqA9tsvg7e15Wl1CO7+kvs3pIu07Nryl6W6su1ugtQzNm6wHmW8TfQSH/txaxv
 fqohl8w5NNEQ1Jj1ocenFpaxQj+mOJutEY2mPkE3t03RSF0KpabHy6x4r6rD306Ebfbn
 OKwDLo4ZtY3vUh0jshJ8DNTzb0ke2M47KTGkEVdhn7uCBKkJrRs60T7Z4M4D6szKwA1o
 VU8Qhyp7AYCnwx9mNEK/d1d6sdu1xN9vrYD7IlP7fUes/d5xH4frH8JwD7lGKPpMVzTC
 MyWA==
X-Gm-Message-State: AOJu0YxQge1MFzIf0K/DE+vuMOmnakw3Q0KfEKs03mZLW7IXH59QBz/o
 gioPVBhsbgXxZjlne8yvsdmf+cALir7SNl8M1vOOQXx/rCpkr9KqKtb6lI1kjMvUKxTE1Ms/rp2
 4ETZmFZ4QPIqLdO2eD/FJHDbBE/ngMDucTwztDJMhbgbhqpnkzB3GOcCmyRzWCm7Ogc5Vz6Auqe
 DMMSaqAGMQkCOT8IcSghpUqah8BV0O/7llGYNF5j2x
X-Received: by 2002:a05:600c:3b9b:b0:42c:bae0:f065 with SMTP id
 5b1f17b1804b1-431616332c3mr122099855e9.5.1729574186705; 
 Mon, 21 Oct 2024 22:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2dUagaEpfyUdbta79F7mI1CnKLl2JMmgeWH9llBCGekeDJQqurulS4MhU3wdA5IX+RnTBTFCxNQQYcQHW9wY=
X-Received: by 2002:a05:600c:3b9b:b0:42c:bae0:f065 with SMTP id
 5b1f17b1804b1-431616332c3mr122099685e9.5.1729574186280; Mon, 21 Oct 2024
 22:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-9-pbonzini@redhat.com>
 <ME0P300MB1040AEF7807BCED2866FA5F6954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <ME0P300MB1040AEF7807BCED2866FA5F6954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Oct 2024 07:16:13 +0200
Message-ID: <CABgObfZ95u+3CG92Zoobju=Sg19W4P2Dzb2YAGms=nwoydaknQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] rust: cleanup module_init!,
 use it from #[derive(Object)]
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

On Tue, Oct 22, 2024 at 4:12=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.com>=
 wrote:
>
>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > Remove the duplicate code by using the module_init! macro; at the same =
time,
> > simplify how module_init! is used, by taking inspiration from the imple=
mentation
> > of #[derive(Object)].
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
>
> One minor comment below.
>
> > ---
> >  rust/qemu-api-macros/src/lib.rs  | 33 +++-------------
> >  rust/qemu-api/src/definitions.rs | 66 ++++++++++++++------------------
> >  2 files changed, 33 insertions(+), 66 deletions(-)
> >
> <snip>
> > diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/defin=
itions.rs
> > index 3323a665d92..f180c38bfb2 100644
> > --- a/rust/qemu-api/src/definitions.rs
> > +++ b/rust/qemu-api/src/definitions.rs
> > @@ -29,51 +29,40 @@ pub trait Class {
> >
> >  #[macro_export]
> >  macro_rules! module_init {
> <snip>
> > +    ($type:ident =3D> $body:block) =3D> {
> > +        const _: () =3D {
> > +            #[used]
> > +            #[cfg_attr(
> > +                not(any(target_vendor =3D "apple", target_os =3D "wind=
ows")),
> > +                link_section =3D ".init_array"
> > +            )]
> > +            #[cfg_attr(target_vendor =3D "apple", link_section =3D "__=
DATA,__mod_init_func")]
> > +            #[cfg_attr(target_os =3D "windows", link_section =3D ".CRT=
$XCU")]
> > +            pub static LOAD_MODULE: extern "C" fn() =3D {
> > +                extern "C" fn init_fn() {
>
> init_fn() should be unsafe fn according to the signature of
> register_module_init.

I think it *can* be unsafe (which bindgen does by default). It's
always okay to pass a non-unsafe function as unsafe function pointer:

fn f() {
    println!("abc");
}

fn g(pf: unsafe fn()) {
    unsafe {
        pf();
    }
}

fn main() {
    g(f);
}

> Being unsafe fn also makes sense here because it
> is the caller, not init_fn() itself, that is responsible for the safety o=
f
> the unsafe code in the body.

Isn't it the opposite? Since the caller of module_init! is responsible
for the safety, init_fn() itself can be safe. With
unsafe_op_in_unsafe_fn it's not a big deal; but without it, an unsafe
init_fn would hide what is safe and what is not in the argument of
module_init!.

It's also relevant in this respect that init_fn is called *after*
main(), only ctor_fn() is called before main.

Thanks,

Paolo


