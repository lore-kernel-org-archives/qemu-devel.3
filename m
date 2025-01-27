Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2D0C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 18:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcTaR-0007s6-Qz; Mon, 27 Jan 2025 13:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tcTaC-0007qQ-1x
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 13:11:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tcTaA-0003Ff-4T
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 13:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738001493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GE00hi9qOq5/IhO9Vbw7OoAdWI6ml+3ACsrgpI2n1+4=;
 b=K+Hx587U+QIQKoNjauoCmwUczkgl5E9Hq/oCkYprbyQtRbUiDTyGcMb9Vs3McqCDb/Cc/3
 u4DCZElHIyPlKAF1PSgusa+nekiUe2HcxTvTI7mrahCpHRa/oxpseGEC3DHRCKwPYYA6J7
 dHbvCkgWxrbUw9BZcKjm5MUvTnaGjmA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-RZ7yV0lXO6KIZ5ReY_LLXA-1; Mon, 27 Jan 2025 13:11:30 -0500
X-MC-Unique: RZ7yV0lXO6KIZ5ReY_LLXA-1
X-Mimecast-MFC-AGG-ID: RZ7yV0lXO6KIZ5ReY_LLXA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385d52591d6so2019611f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 10:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738001489; x=1738606289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GE00hi9qOq5/IhO9Vbw7OoAdWI6ml+3ACsrgpI2n1+4=;
 b=Pj4dh+4D3us3EdsBTPaxp/Mw+AORZ0v57nuR3KcDdFlAAWNcLcf4bclCNrsChlna8v
 GP+Xx4d6oOOKTMs/43iSMROphtclGPDC1J6LOvubJKuy/jt2bUvxII2lBZc7oRMlSKo9
 IIQGTKZ7E4JFFy9y1EfB9DZ1BPHhWBLR82HrjQVGE1/EqycHO2yLi7F6mcr5BAY6vAoZ
 B1CcVCeSRwrATVt+pgavKMdOWHl8eiPru/VKC2OkI9bNXIzBD7qx1E22uDhqUUMfPoyH
 ERyr7K6UANpWt3wZxlvfzjrGDbrtUHpNRuojWCPufVuEox+0ylch8tFZqgF7M4wTisnU
 PuJw==
X-Gm-Message-State: AOJu0YzFNS/dMm/vIpoAoaGilRG9aFlP9Zf5/9M62l9a/rPSan+0Ckhv
 WhPTq2PqmUiU0IXPJQrH8aeOJqARD+XWhIl84nzTL+5eUA51za3GzsfkAOnKzpjrktWr+WGHPUv
 93jcPzTozHlpgzMIl02JdHiizVmnwUxkNGCVItercA9rS+DtcIeFy9Vs/FdFjWDBipsjbNkHWmd
 qTJiwmxGlT6IOOHs+DpAFBXQ07fI3hnUDwVLADLSh/
X-Gm-Gg: ASbGnct77GpUf/wb0/aKHfIznsJQFUZsljlKfFiNEuURw0FtOrAqL9cd486n5FGeYu7
 vt9nAWZycp5+PN+PI/NksbvgVUo1PXgM1yur0iIYZDZdn7ofCBPEFlBdsEAidVA==
X-Received: by 2002:a5d:6481:0:b0:38a:4184:14ec with SMTP id
 ffacd0b85a97d-38c49a1d7ebmr277817f8f.1.1738001488962; 
 Mon, 27 Jan 2025 10:11:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETfKo7oqEDrOKz2OM1g+LEv684jXBNwnXyWNJqhBu0qsVFA9fOJuJ8kKTWL4E591wzrHrOj78Aa/hS7njZOQ8=
X-Received: by 2002:a5d:6481:0:b0:38a:4184:14ec with SMTP id
 ffacd0b85a97d-38c49a1d7ebmr277805f8f.1.1738001488636; Mon, 27 Jan 2025
 10:11:28 -0800 (PST)
MIME-Version: 1.0
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-11-pbonzini@redhat.com>
 <Z5d4PTtIRhgZ0tss@intel.com>
In-Reply-To: <Z5d4PTtIRhgZ0tss@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Jan 2025 19:11:17 +0100
X-Gm-Features: AWEUYZnnoLv7xDrpkzqO_6FjOf0yKVL-LulOVMSNiz8kVn63A6XpVQuI1lbug9U
Message-ID: <CABgObfYc5ccC16=K7KVmdLP-jmvwVbxqv1L6c4Oe55MSK4ndng@mail.gmail.com>
Subject: Re: [PATCH 10/10] rust: bindings for MemoryRegionOps
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jan 27, 2025 at 12:53=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wro=
te:
> > @@ -490,20 +490,24 @@ impl PL011State {
> >      /// location/instance. All its fields are expected to hold unitial=
ized
> >      /// values with the sole exception of `parent_obj`.
> >      unsafe fn init(&mut self) {
> > +        static PL011_OPS: MemoryRegionOps<PL011State> =3D MemoryRegion=
OpsBuilder::<PL011State>::new()
> > +            .read(&PL011State::read)
> > +            .write(&PL011State::write)
> > +            .native_endian()
> > +            .impl_sizes(4, 4)
> > +            .build();
> > +
>
> Nice design. Everything was done smoothly in one go.

I hope something similar can be done with VMStateDescription too...

> > +pub struct MemoryRegionOps<T>(
> > +    bindings::MemoryRegionOps,
> > +    // Note: quite often you'll see PhantomData<fn(&T)> mentioned when=
 discussing
> > +    // covariance and contravariance; you don't need any of those to u=
nderstand
> > +    // this usage of PhantomData.  Quite simply, MemoryRegionOps<T> *l=
ogically*
> > +    // holds callbacks that take an argument of type &T, except the ty=
pe is erased
> > +    // before the callback is stored in the bindings::MemoryRegionOps =
field.
> > +    // The argument of PhantomData is a function pointer in order to r=
epresent
> > +    // that relationship; while that will also provide desirable and s=
afe variance
> > +    // for T, variance is not the point but just a consequence.
> > +    PhantomData<fn(&T)>,
> > +);
>
> Wow, it can be wrapped like this!

I like your enthusiasm but I'm not sure what you refer to. ;) Maybe
it's worth documenting this pattern, so please tell me more (after
your holidays).

> > +impl MemoryRegion {
> > +    // inline to ensure that it is not included in tests, which only
> > +    // link to hwcore and qom.  FIXME: inlining is actually the opposi=
te
> > +    // of what we want, since this is the type-erased version of the
> > +    // init_io function below.  Look into splitting the qemu_api crate=
.
>
> Ah, I didn't understand the issue described in this comment. Why would
> inlining affect the linking of tests?

If you don't inline it, do_init_io will always be linked into the
tests because it is a non-generic function. The tests then fail to
link, because memory_region_init_io is undefined.

This is ugly because do_init_io exists *exactly* to extract the part
that is not generic. (See
https://users.rust-lang.org/t/soft-question-significantly-improve-rust-comp=
ile-time-via-minimizing-generics/103632/8
for an example of this; I think there's even a procedural macro crate
that does that for you, but I can't find it right now).

> > +    pub fn init_io<T: IsA<Object>>(
> > +        &mut self,
> > +        owner: *mut T,
> > +        ops: &'static MemoryRegionOps<T>,
> > +        name: &'static str,
>
> What about &'static CStr?
>
> Then pl011 could pass `c_str!("pl011")` or `Self::TYPE_NAME`.

I think it's better to use a Rust string; there's no reason why the
name of the memory region has to match Self::TYPE_NAME; unlike the
name of the device, the name of the memory region is not visible on
the command line for example.

Thanks,

Paolo

> Otherwise,
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>
>


