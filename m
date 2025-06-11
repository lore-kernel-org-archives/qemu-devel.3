Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FC5C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 08:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPHHH-0007Cf-SU; Wed, 11 Jun 2025 04:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPHGy-00079t-9N
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPHGv-00061a-LQ
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749632245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VwSqeagJdHqyzvBzdyMVHRSNhDU9Mdg/o2cFiRC2H8Q=;
 b=FULn/mVBy1ZvgwUyBEdRFfq46QIQNux3f1y3PhBZl+xWdz937upE6+9LfLwwOH7fIckvG8
 DjtBfdqxYZCTgmLVg9OdT7T2MpFAtJDo131oCuTFM8/Vhx7s4L8TsAzj6JTZSfr+skyIqb
 Pb2nutzBjaz0TTNvqpcgGwdJQnV0/2I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-G8rsLh63MROHdN425j_95w-1; Wed, 11 Jun 2025 04:57:23 -0400
X-MC-Unique: G8rsLh63MROHdN425j_95w-1
X-Mimecast-MFC-AGG-ID: G8rsLh63MROHdN425j_95w_1749632242
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so37918605e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 01:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749632242; x=1750237042;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VwSqeagJdHqyzvBzdyMVHRSNhDU9Mdg/o2cFiRC2H8Q=;
 b=YBG5V1mjSLwziS7NrSJgimTWL2jodPM4Z9qYZJu6aN3f2KFF9lrpIDam1gBkPC92nu
 7+kHGfETvlgaHnVSsO0z/CSK31vS6rxn6k7mABc6cJGJC21e74BkjvllPxabtNW/4lZi
 eN/eaSWlbzLsOH8Eo+WWkPy9fP6JlZNslKqu9tIMDyPcYUC4+cIS5hBI/AhNSNNHZSDn
 tCAMnmDqe2g9qajh1i93bEsqzE/YyA3VWlBnnTwSCQU80WsOrGicEMn0gDh5IvHe8DbB
 PYxTVhJ+Fr4GzItd5f52EaifFOmbiOuCeCtisitLjMO0t/hnk5L+UmmgMFE9YvAY3Z9D
 Wa4g==
X-Gm-Message-State: AOJu0Yw76MJJyx69f2acOdlwjqkHpyA8FLRlg9YiGIZi6LLNX64Isq/k
 Vlv+TzPA8l1OL0imbhvDAgoP1mcvQIPtdhYEELxExa2IeFQ3+++0m05x02CcTj3lQpDUsGBcAMM
 zPnCWWEHHwala8v2d+rbxeit1X4FpLhPpUogktt35vULm+rvCcRj694TEvYSmz506oeA1f52EVN
 vXj3utER+AgCETApRQP4nBBSJNQn3Qtic=
X-Gm-Gg: ASbGncuZvlj3Qt1Ks4DW1W1dHYLgd5nTZPm6YtkZ7p9n3ZmiU2HDgaBN5UE1AJhs/uA
 aXTnzNceNtOWzmMktdJfP/yJUrwEjOvAcEiXF1MOHVKlAJueFtgRAlIxDCIGzIlkrwY9ih0ecIT
 7JTw==
X-Received: by 2002:a05:600c:34c3:b0:451:dee4:cd08 with SMTP id
 5b1f17b1804b1-453248ca2aamr16750275e9.23.1749632242074; 
 Wed, 11 Jun 2025 01:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2eiartmQNKiq9xsqsqi3TvMfueW5amW0c0N1ZS3LLLPGzVq9kqHv+qqQgiU/ICjYdnmRJtebhYz16YLC2ikY=
X-Received: by 2002:a05:600c:34c3:b0:451:dee4:cd08 with SMTP id
 5b1f17b1804b1-453248ca2aamr16750125e9.23.1749632241715; Wed, 11 Jun 2025
 01:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250605101124.367270-1-pbonzini@redhat.com>
 <aEk6vdosWZgyQGXD@intel.com>
In-Reply-To: <aEk6vdosWZgyQGXD@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jun 2025 10:57:10 +0200
X-Gm-Features: AX0GCFv0EcUIZeqKJPaVoQlHr5lSsJ8bG-F3nJZYa2Jf8ifZpWcXp653Ano99QU
Message-ID: <CABgObfaK8h3GE4GWbPrn22JshYcCFdXsxWHWuAPVC4pRb7GZ0A@mail.gmail.com>
Subject: Re: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org, 
 armbru@redhat.com, mkletzan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 11, 2025 at 9:52=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> As patch 3 did, qapi will generate Rust types:
>
> - char* is mapped to String, scalars to there corresponding Rust types
> - enums are simply aliased from FFI
> - has_foo/foo members are mapped to Option<T>
> - lists are represented as Vec<T>

Yep, so far so good.

> - structures have Rust versions, with To/From FFI conversions

The conversion part is not included in this minimal series. The raw
structure (the `type Foreign` as you point out) could be generated by
either bindgen or qapi-gen. Marc-Andr=C3=A9 chose the latter for his old
prototype, I'm ambivalent.

> It seems we still need some raw bindings (generated by bindgen) as the
> `type Foreign`, and then implement Foreign traits for the Rust
> structures generated by this patch.

Yes. If using serde the implementation of the traits is very small,
and basically the same for all types. If not using serde, it would
need some (or most) of the infrastructure in Marc-Andr=C3=A9's original
series.

> For this example, UefiVariable is generated by qapi (patch 3) and
> bindings::UefiVariable is generated by bindgen. Ah! I feel I'm wrong,
> could you please correct me?

You're not wrong. :)

Paolo

> On Thu, Jun 05, 2025 at 12:11:21PM +0200, Paolo Bonzini wrote:
> > Date: Thu,  5 Jun 2025 12:11:21 +0200
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
> > X-Mailer: git-send-email 2.49.0
> >
> > This is just an extremely minimal extraction from the patches at
> > https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redh=
at.com/,
> > limited to generating structs and enums from the QAPI schema.
> > It does not include them in any crate and does not compile them.
> >
> > While I'm not going to work on this, I was curious how much work it
> > was to produce *some* kind of Rust QAPI struct, which could be a first
> > step towards using serde as an interface to C visitors, like this:
> >
> > trait QapiType: FreeForeign {
> >     unsafe fn visit(v: bindings::Visitor, name: *const c_char, obj: *mu=
t <Self as FreeForeign>::Foreign, errp: *mut *mut bindings::Error);
> > }
> >
> > fn to_c<T: QapiType>(obj: &T) -> *mut <T as FreeForeign>::Foreign {
> >     let mut ptr =3D libc::calloc(...);
> >     let mut ser =3D QapiSerializer::<T>::new(ptr);
> >     obj.serialize(&mut ser).unwrap();
> >     ptr.cast()
> > }
> >
> > unsafe fn from_c<T: QapiType>(obj: *const <T as FreeForeign>::Foreign) =
-> T {
> >     let mut de =3D QapiDeserializer::new(T::visit, obj as *const c_void=
);
> >     let value =3D de::Deserialize::deserialize(&mut de).unwrap();
> >     de.end().unwrap();
> >     value
> > }
> >
> > /* Generated code below: */
> >
> > impl QapiType for UefiVariable {
> >     unsafe fn visit(v: bindings::Visitor, name: *const c_char, obj: *mu=
t bindings::UefiVariable, errp: *mut *mut bindings::Error) {
> >         unsafe extern "C" visit_type_UefiVariable(v: bindings::Visitor,=
 name: *const c_char, obj: *mut bindings::UefiVariable, errp: *mut *mut bin=
dings::Error) {
> >         unsafe { visit_type_UefiVariable(v, name, obj, errp); }
> >     }
> > }
> >
> > impl FreeForeign for UefiVariable {
> >     type Foreign =3D bindings::UefiVariable;
> >     unsafe fn free_foreign(p: *mut bindings::UefiVariable) {
> >         unsafe extern "C" qapi_free_UefiVariable(p: *mut bindings::Uefi=
Variable);
> >         unsafe { qapi_free_UefiVariable(p); }
> >     }
> > }
> >
> > impl CloneToForeign for UefiVariable {
> >     fn clone_to_foreign(&self) -> OwnedPointer<Self> {
> >         OwnedPointer::new(qapi::to_c(self))
> >     }
> > }
> >
> > impl FromForeign for UefiVariable {
> >     unsafe fn cloned_from_foreign(obj: *const bindings::UefiVariable) -=
> Self {
> >         qapi::from_c(obj)
> >     }
> > }


