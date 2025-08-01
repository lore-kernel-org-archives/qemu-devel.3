Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABEFC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 21:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhxY8-0003nP-Ei; Fri, 01 Aug 2025 17:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uhxY6-0003gI-3l
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 17:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uhxY3-0002Tp-Ca
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 17:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754084658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12wxw3/rWfRba2ZZotj60xqsBSJ603sJqUj3XJ20ehM=;
 b=R+UTReKEDD7UgrIaE/pLn+KbDBtgK6mq8RS93uJfNb/lFZiNAYBHwgxQ/vi46lg5DcW0Tw
 h1foC6Ux/ZN0vUWa0pzrsVapIUpLNAdiGSbof6ie73R2JUovxXJ+9GCk0MUpbeLIeOFT8a
 rjrmyYRfGACE2iWWLhzyxBSGOJuQ3KQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-yxGMXVuZMZyk3Pqt8geVwA-1; Fri, 01 Aug 2025 17:44:15 -0400
X-MC-Unique: yxGMXVuZMZyk3Pqt8geVwA-1
X-Mimecast-MFC-AGG-ID: yxGMXVuZMZyk3Pqt8geVwA_1754084654
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45600d19a2aso8359645e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 14:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754084654; x=1754689454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=12wxw3/rWfRba2ZZotj60xqsBSJ603sJqUj3XJ20ehM=;
 b=uxOhvSmpfFq53XSQgqGChrvwWEAupWv078zs+ECEG/Vo+jG7q0seKaxJy0LabDoVun
 It1gZeARaDdyQqqFccS33egUXu4vvs/mN0kY5RTTgOP3V+1f+yKHRPJ4TDlBh9cvNT1L
 dhHglpimB8dHRkCjCifXaxQyjKPOwmvDAAzoQU9JBcWiKBB2LWOjI+3zk5+EzKv5/xSp
 JZIJkurumd/LO5kSMojDziW9/ccfrd0uG+6NysGnlkZ/MkPNEngo+TQCU2S+SE8tJPmY
 RBWI4ppysmnAoZe6wPcB5bL0E5w2L6KwHJV2C50YWwsojo+lmxa9s/BXfYSblKBPW0/V
 QnqA==
X-Gm-Message-State: AOJu0YxPe3Xb6EqGwojXGp0tRMjLFx4giIeZE4GfP0jNEUhI2BzK/tOW
 K/9ZOIh2og5HlR3440UmgWgEA6X1v1O0rU0NDm8VNrusS7ynWsl2nis5NjS0CMISXxfIB8N6Koz
 dDA6b65uOFrlYgs66Ah0G33EHxCiuC0JG13p3qZNENOr6VcKROWOp3Mc8P+euP3sgG2zSi44G00
 PL5GNQCBZZX9HaI5Qpdzi04Fv8FrA2KZk=
X-Gm-Gg: ASbGnctz4q80wW8uDrx3DKa5KnV8YRrE0ahI3gO1gdxwcQ5tn/DscV6++cJ5KjCcRZV
 9Cgg7/ovRna8aaCCmzGzGbzWOY16Fl48GK1Rtw2/Pb5+9NwRfoAdfaeVly3Ww6b6cq8r/RpWMlZ
 FwQNuVUPoHCTtRrmaGTfU=
X-Received: by 2002:a05:600c:354e:b0:453:6ca:16b1 with SMTP id
 5b1f17b1804b1-458b6b47baemr5554525e9.26.1754084653956; 
 Fri, 01 Aug 2025 14:44:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4j2c5Zso93zLjo9wLRJEbuFVABpKHEaKmrYwCT0reLDiRhy9EqgjrmXpO6SWVxQ43m62+dYhMNOWm5UjLoFA=
X-Received: by 2002:a05:600c:354e:b0:453:6ca:16b1 with SMTP id
 5b1f17b1804b1-458b6b47baemr5554385e9.26.1754084653445; Fri, 01 Aug 2025
 14:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1754060086.git.mkletzan@redhat.com>
 <ad68bd5bdf4148770e3750fca4f14d0ae794538d.1754060086.git.mkletzan@redhat.com>
In-Reply-To: <ad68bd5bdf4148770e3750fca4f14d0ae794538d.1754060086.git.mkletzan@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 1 Aug 2025 23:44:03 +0200
X-Gm-Features: Ac12FXxdRq0WPnrA2-rhlkWKllK-nslzu-t1ulVvtHYN_SWFAG8OAiCvE1IspA8
Message-ID: <CABgObfYBVF3aCOBtX-eQcm4M-WNAHxbMcjsUKiY3rLkinGe1qA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add antoher variant for impl_vmstate_struct!
 macro
To: Martin Kletzander <mkletzan@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000acc2c8063b54a8c5"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000acc2c8063b54a8c5
Content-Type: text/plain; charset="UTF-8"

Il ven 1 ago 2025, 17:00 Martin Kletzander <mkletzan@redhat.com> ha scritto:

> From: Martin Kletzander <mkletzan@redhat.com>
>
> In some cases (e.g. in vmstate_tests.rs) the second argument to
> impl_vmstate_struct! is actually an existing struct which is then
> copied (since VMStateDescription implements Copy) when saved into the
> static VMSD using .get().  That is not a problem because it is part of
> the data segment and the pointers are not being free'd since they point
> to static data.  But it is a problem when tests rely on comparing the
> VMState descriptions as pointers rather than contents.  And it also
> wastes space, more or less.
>
> Introduce second variant of the macro which can, instead of the
> expression, take an identifier or what looks like a reference.  This
> second variant is added before the current variant so that it has
> preference, and only references the existing static data from it.
>
> This way tests are fixed and space is saved.
>
> And now that the VMStateDescription checking is fixed we can also check
> for the right value in test_vmstate_struct_varray_uint8_wrapper().
>
> Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
> ---
> I'm not sure whether this is caused by different utility on my system or
> bash
> version or whatever, but without this patch these three tests fail for me
> and
> this patch fixes it.
>

I found something similar, though I wasn't sure if it was broken in master
as well or only in the rust-next branch.

If that works in master as well, I would remove completely the possibility
of using &FOO, and always use .as_ref(). It's more efficient as you said,
and there's no reason that I know to use the less efficient one.

Paolo

 rust/qemu-api/src/vmstate.rs         | 11 +++++++++++
>  rust/qemu-api/tests/vmstate_tests.rs |  1 +
>  2 files changed, 12 insertions(+)
>
> diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
> index b5c6b764fbba..716e52afe740 100644
> --- a/rust/qemu-api/src/vmstate.rs
> +++ b/rust/qemu-api/src/vmstate.rs
> @@ -449,6 +449,17 @@ macro_rules! vmstate_validate {
>  /// description of the struct.
>  #[macro_export]
>  macro_rules! impl_vmstate_struct {
> +    ($type:ty, $(&)?$vmsd:ident) => {
> +        unsafe impl $crate::vmstate::VMState for $type {
> +            const BASE: $crate::bindings::VMStateField =
> +                $crate::bindings::VMStateField {
> +                    vmsd: $vmsd.as_ref(),
> +                    size: ::core::mem::size_of::<$type>(),
> +                    flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
> +                    ..$crate::zeroable::Zeroable::ZERO
> +                };
> +        }
> +    };
>      ($type:ty, $vmsd:expr) => {
>          unsafe impl $crate::vmstate::VMState for $type {
>              const BASE: $crate::bindings::VMStateField = {
> diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/
> vmstate_tests.rs
> index 2c0670ba0eed..7d3180e6c2ea 100644
> --- a/rust/qemu-api/tests/vmstate_tests.rs
> +++ b/rust/qemu-api/tests/vmstate_tests.rs
> @@ -320,6 +320,7 @@ fn test_vmstate_struct_varray_uint8_wrapper() {
>          b"arr_a_wrap\0"
>      );
>      assert_eq!(foo_fields[5].num_offset, 228);
> +    assert_eq!(foo_fields[5].vmsd, VMSTATE_FOOA.as_ref());
>      assert!(unsafe { foo_fields[5].field_exists.unwrap()(foo_b_p, 0) });
>
>      // The last VMStateField in VMSTATE_FOOB.
> --
> 2.50.1
>
>

--000000000000acc2c8063b54a8c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 1 ago 2025, 17:00 Martin =
Kletzander &lt;<a href=3D"mailto:mkletzan@redhat.com">mkletzan@redhat.com</=
a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">From: Martin Kletzander &lt;<a href=3D"mailto:mkletzan@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">mkletzan@redhat.com</a>&gt;<br>
<br>
In some cases (e.g. in <a href=3D"http://vmstate_tests.rs" rel=3D"noreferre=
r noreferrer" target=3D"_blank">vmstate_tests.rs</a>) the second argument t=
o<br>
impl_vmstate_struct! is actually an existing struct which is then<br>
copied (since VMStateDescription implements Copy) when saved into the<br>
static VMSD using .get().=C2=A0 That is not a problem because it is part of=
<br>
the data segment and the pointers are not being free&#39;d since they point=
<br>
to static data.=C2=A0 But it is a problem when tests rely on comparing the<=
br>
VMState descriptions as pointers rather than contents.=C2=A0 And it also<br=
>
wastes space, more or less.<br>
<br>
Introduce second variant of the macro which can, instead of the<br>
expression, take an identifier or what looks like a reference.=C2=A0 This<b=
r>
second variant is added before the current variant so that it has<br>
preference, and only references the existing static data from it.<br>
<br>
This way tests are fixed and space is saved.<br>
<br>
And now that the VMStateDescription checking is fixed we can also check<br>
for the right value in test_vmstate_struct_varray_uint8_wrapper().<br>
<br>
Signed-off-by: Martin Kletzander &lt;<a href=3D"mailto:mkletzan@redhat.com"=
 target=3D"_blank" rel=3D"noreferrer">mkletzan@redhat.com</a>&gt;<br>
---<br>
I&#39;m not sure whether this is caused by different utility on my system o=
r bash<br>
version or whatever, but without this patch these three tests fail for me a=
nd<br>
this patch fixes it.<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">I found something similar, though I wasn&#39;t sure if =
it was broken in master as well or only in the rust-next branch.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">If that works in master as well, I=
 would remove completely the possibility of using &amp;FOO, and always use =
.as_ref(). It&#39;s more efficient as you said, and there&#39;s no reason t=
hat I know to use the less efficient one.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
=C2=A0rust/qemu-api/src/<a href=3D"http://vmstate.rs" rel=3D"noreferrer nor=
eferrer" target=3D"_blank">vmstate.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 11 +++++++++++<br>
=C2=A0rust/qemu-api/tests/<a href=3D"http://vmstate_tests.rs" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">vmstate_tests.rs</a> |=C2=A0 1 +<br>
=C2=A02 files changed, 12 insertions(+)<br>
<br>
diff --git a/rust/qemu-api/src/<a href=3D"http://vmstate.rs" rel=3D"norefer=
rer noreferrer" target=3D"_blank">vmstate.rs</a> b/rust/qemu-api/src/<a hre=
f=3D"http://vmstate.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">vms=
tate.rs</a><br>
index b5c6b764fbba..716e52afe740 100644<br>
--- a/rust/qemu-api/src/<a href=3D"http://vmstate.rs" rel=3D"noreferrer nor=
eferrer" target=3D"_blank">vmstate.rs</a><br>
+++ b/rust/qemu-api/src/<a href=3D"http://vmstate.rs" rel=3D"noreferrer nor=
eferrer" target=3D"_blank">vmstate.rs</a><br>
@@ -449,6 +449,17 @@ macro_rules! vmstate_validate {<br>
=C2=A0/// description of the struct.<br>
=C2=A0#[macro_export]<br>
=C2=A0macro_rules! impl_vmstate_struct {<br>
+=C2=A0 =C2=A0 ($type:ty, $(&amp;)?$vmsd:ident) =3D&gt; {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsafe impl $crate::vmstate::VMState for $type=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const BASE: $crate::bindings::VM=
StateField =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $crate::bindings::=
VMStateField {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmsd=
: $vmsd.as_ref(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size=
: ::core::mem::size_of::&lt;$type&gt;(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag=
s: $crate::bindings::VMStateFlags::VMS_STRUCT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ..$c=
rate::zeroable::Zeroable::ZERO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 };<br>
=C2=A0 =C2=A0 =C2=A0($type:ty, $vmsd:expr) =3D&gt; {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsafe impl $crate::vmstate::VMState for =
$type {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const BASE: $crate::binding=
s::VMStateField =3D {<br>
diff --git a/rust/qemu-api/tests/<a href=3D"http://vmstate_tests.rs" rel=3D=
"noreferrer noreferrer" target=3D"_blank">vmstate_tests.rs</a> b/rust/qemu-=
api/tests/<a href=3D"http://vmstate_tests.rs" rel=3D"noreferrer noreferrer"=
 target=3D"_blank">vmstate_tests.rs</a><br>
index 2c0670ba0eed..7d3180e6c2ea 100644<br>
--- a/rust/qemu-api/tests/<a href=3D"http://vmstate_tests.rs" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">vmstate_tests.rs</a><br>
+++ b/rust/qemu-api/tests/<a href=3D"http://vmstate_tests.rs" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">vmstate_tests.rs</a><br>
@@ -320,6 +320,7 @@ fn test_vmstate_struct_varray_uint8_wrapper() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b&quot;arr_a_wrap\0&quot;<br>
=C2=A0 =C2=A0 =C2=A0);<br>
=C2=A0 =C2=A0 =C2=A0assert_eq!(foo_fields[5].num_offset, 228);<br>
+=C2=A0 =C2=A0 assert_eq!(foo_fields[5].vmsd, VMSTATE_FOOA.as_ref());<br>
=C2=A0 =C2=A0 =C2=A0assert!(unsafe { foo_fields[5].field_exists.unwrap()(fo=
o_b_p, 0) });<br>
<br>
=C2=A0 =C2=A0 =C2=A0// The last VMStateField in VMSTATE_FOOB.<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div></div></div>

--000000000000acc2c8063b54a8c5--


