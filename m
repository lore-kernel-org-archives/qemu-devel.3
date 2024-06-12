Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F81CC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHPmH-00069L-Ri; Wed, 12 Jun 2024 11:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHPmG-000693-0T
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHPmE-0001t3-0g
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718205640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3QXZNdUYf/LHVDGJm8SdWHziQ8t+RRpon3DYbeIehwg=;
 b=cfHHeKx/KqynisB0Nst52ydUch49AStA+NeAQeKkGS2IacurgQ+bTI+qL4FqPZKbHCSLAE
 f/b/UwbeaPYPr1r7JSCDx+0SNZvHOuFDfwryf4AZOlXyxQecPVeFCtbEBjfsjjio0f9LX3
 eJaIFa05LayoposLu5lV6dpjryDIC9I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-HGlq3SmKNTmt8Op4sr1VpA-1; Wed, 12 Jun 2024 11:20:39 -0400
X-MC-Unique: HGlq3SmKNTmt8Op4sr1VpA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-421eed70e30so24342765e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718205637; x=1718810437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3QXZNdUYf/LHVDGJm8SdWHziQ8t+RRpon3DYbeIehwg=;
 b=pRNsbKYa2Jwk96l0BjGqHC8+8KEDSVwx3YV8fOxv7q7GBXvJ9r5h3YkRRwrR7pfp1R
 HmsX+9NDutEVYRK55mqBPGD2uYTtr27YgNRO3nu3IcbKb0xWKbv98kBcHWxnSRVfXS1m
 PYnxY5w1BazOpUny/nwuR54Dd0kz3P4FgVCIF8lxzx1zGlfM5fpPzNFFlnyKDcWtJtnS
 0CidOj0GUotFUIwcH2vwMz87qZ0rhtuenRq1FA294YWHKq34qY3bZHHjfRP2Sl1CSIuP
 E25OGugqTMlOs+ikq7ATwt/ze254GX35gKom4c914imcxlGa9G6U2JUgMNRTHj63zTok
 nhoQ==
X-Gm-Message-State: AOJu0YyGVUJOCTLd657JjoZzaAhmv2RlI4eHW4HzAy3lABo+qM/kR3f2
 hHM7ocR0QHWskJagHDLB/47dNPjXX24OaM8LnNEw6HRT8mBGlmnWrQDAXKJFIHcl4YboEzRGbK/
 SKp4f+o+CxMsv3DDtpKMKoR5a7OBqlrcc8pBz1k/budBcbbz9gXZyWhHv6072GzJv8CdN/1COBX
 rPTNxojyIMI/ErJivKcUfJ7Mx3QcY=
X-Received: by 2002:a05:600c:45ce:b0:421:f346:6b02 with SMTP id
 5b1f17b1804b1-422a08d3cf8mr7276925e9.27.1718205637314; 
 Wed, 12 Jun 2024 08:20:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbVNNh7nYTOiNOBIEiVXw+frXw2JTE4jxK2NgljmzNQFO19s4iLuPly8td5/NCfT6dEsiVb6FH5ZzBUeQXUH0=
X-Received: by 2002:a05:600c:45ce:b0:421:f346:6b02 with SMTP id
 5b1f17b1804b1-422a08d3cf8mr7276705e9.27.1718205636964; Wed, 12 Jun 2024
 08:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org>
In-Reply-To: <ez270.x96k6aeu0rpw@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jun 2024 17:20:24 +0200
Message-ID: <CABgObfYe_wx135QYe7W8ri5Xv-Fit6FW_YBe8U5rR=fS0Zz5wA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 12, 2024 at 4:42=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> There was consensus in the community call that we won't be writing Rust
> APIs for internal C QEMU interfaces; or at least, that's not the goal

I disagree with that. We need _some_ kind of bindings, otherwise we
have too much unsafe code, and the benefit of Rust becomes so much
lower that I doubt the utility.

If something is used by only one device then fine, but when some kind
of unsafe code repeats across most if not all devices, that is a
problem. It can be macros, it can be smart pointers, that remains to
be seen---but repetition should be a warning signal that _something_
is necessary.

> >For definining new classes I think it's okay if Rust does not support
> >writing superclasses yet, only leaves.
> >
> >I would make a QOM class written in Rust a struct that only contains
> >the new fields. The struct must implement Default and possibly Drop
> >(for finalize).
>
> The object is allocated and freed from C, hence it is not Dropped. We're
> only ever accessing it from a reference retrieved from a QEMU provided
> raw pointer. If the struct gains heap object fields like Box or Vec or
> String, they'd have to be dropped manually on _unrealize.

That's my point, if you have

  struct MyDevice_Inner {
    data: Vec<u8>,
  }

  struct MyDevice {
    parent_obj: qemu::bindings::SysBusDevice,
    private: ManuallyDrop<PL011_Inner>,
  }

then the instance_finalize method can simply do

  pub instance_finalize(self: *c_void)
  {
    let dev =3D self as *mut MyDevice;
    unsafe { ManuallyDrop::drop(dev.private) }
  }

Don't do it on _unrealize, create macros that do it for you.

> >and then a macro defines a wrapper struct that includes just two
> >fields, one for the superclass and one for the Rust struct.
> >instance_init can initialize the latter with Default::default().
> >
> >  struct PL011 {
> >    parent_obj: qemu::bindings::SysBusDevice,
> >    private: PL011_Inner,
> >  }
>
> a nested struct is not necessary for using the Default trait

Agreed, but a nested struct is nice anyway in my opinion as a boundary
between the C-ish and Rust idiomatic code.

> >"private" probably should be RefCell<PL011_Inner>, avoiding the unsafe
> >
> >    state.as_mut().read(addr, size)
>
>
> RefCell etc are not FFI safe.

Why does it matter? Everything after the SysBusDevice is private.

> Also, nested fields must be visible so that the offset_of! macro works, f=
or QOM properties.

Note that QOM properties do not use offset_of; qdev properties do.
Using qdev properties is much easier because they hide visitors, but
again - not necessary, sometimes going lower-level can be easier if
the API you wrap is less C-ish.

Also, you can define constants (including properties) in contexts
where non-public fields are visible:

use std::mem;
pub struct Foo {
    _x: i32,
    y: i32,
}
impl Foo {
    pub const OFFSET_Y: usize =3D mem::offset_of!(Foo, y);
}
fn main() {
    println!("{}", Foo::OFFSET_Y);
}

Any offset needed to go past the SysBusDevice and any other fields
before MyDevice_Inner can be added via macros. Also note that it
doesn't _have_ to be RefCell; RefCell isn't particularly magic. We can
implement our own interior mutability thingy that is more friendly to
qdev properties, or that includes the ManuallyDrop<> thing from above,
or both.

For example you could have

  type PL011 =3D QOMImpl<qemu::bindings::SysBusDevice, PL011_Inner>;

and all the magic (for example Borrow<PL011_Inner>, the TypeInfo, the
instance_init and instance_finalize function) would be in QOMImpl.

My point is: let's not focus on having a C-like API. It's the easiest
thing to do but not the target.

> Finally,
>
>      state.as_mut().read(addr, size)
>
> Is safe since we receive a valid pointer from QEMU. This fact cannot be
> derived by the compiler, which is why it has an `unsafe` keyword. That
> does not mean that the use here is unsafe.

Yes, it is safe otherwise it would be undefined behavior, but there
are no checks of the kind that you have in Rust whenever you have
&mut.

state.as_mut() implies that no other references to state are in use;
but there are (you pass it as the opaque value to both the
MemoryRegionOps and the chardev frontend callbacks). This is why I
think something like RefCell is needed to go from a shared reference
to an exclusive one (interior mutability).

> >There should also be macros to define the wrappers for MMIO MemoryRegion=
s.
>
> Do you mean the MemoryRegionOps?

Yes.

> I wanted to focus on the build system integration for the first RFC
> which is why there are some macros but not in every place it makes
> sense.

Yes, absolutely. We need to start somewhere.

Paolo


