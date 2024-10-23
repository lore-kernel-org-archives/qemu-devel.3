Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AE4D2E01B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 07:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Va6-0007uE-2Z; Wed, 23 Oct 2024 03:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Va4-0007tY-KN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Va2-0005Rf-KI
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729667691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N6Z+mAffqpj0vCYJvVgbiQjgIzvTt0ld1iN/A72YdKs=;
 b=ELMbmB8lOjbfGRF5InQYt87Y61RSrOM2WNM+xK17e+e8IvAFHfacUg8Ztg0329tbrsexX7
 SirVql4XByY7mQkgNa3b2hKxc11461D8+8oYzcmRELr7UW9PkpMY7HYcpdtHn+ormzO6ML
 BsBSRe3jz4Uq19QNnYNXuzF3U8ZxPmY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-kAjzWdLsMhK63v5m61Flsg-1; Wed, 23 Oct 2024 03:14:47 -0400
X-MC-Unique: kAjzWdLsMhK63v5m61Flsg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316e2dde9eso34256045e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 00:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729667686; x=1730272486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N6Z+mAffqpj0vCYJvVgbiQjgIzvTt0ld1iN/A72YdKs=;
 b=aRSuw0ROHk7uO3PpfdoamYuDhydOb3axK29pkj/vfgvs8jHO8Oo00qQvyPHeeuyQjd
 /3Zz7Mut0W+3PVdS80i3DUhYbbTFFKYdrsYdRbYlJ9qpEukayeT91Ew3zsyVy7GQbXdw
 ToAq7Pd7nS6P75hByhwo/APx2yLkPL0UOv+uzknuK8MeUqQvDZKMV1XmOmpsz2+kravI
 ugmKPt46/oPk7fksrfb7EKBNfsCdv9SdWCAl7D9wSW1O2NUfRXiO6hiwtX9x1BIZYq55
 Kah+y9Wv4YBZdhNQ358YPSkJRsQmt6hCe7pGVleotWxwa02jfczHV8tc/iO24zJDjqBO
 tZJw==
X-Gm-Message-State: AOJu0YyrTD3hkCS50/toUTP9aZY8xn6JF8YMkgU9Y1cmhScmrOpr4H1p
 dBkVTnTqt0GUkZotEsdqfG3xKx6MwMVt0b+tEpYTCqQIZMr2onC87eC69SqGXLKnsgXebH7l1+7
 9ZrDKE9axMKUZG86lgBOxzop73tSCv/sTxG5W5OCJDxQ7j9OvIC446m9aWmLdMxOAoxoMPFS3ik
 VnSVA7GDqy81Er+wodrsTRhMqzsGc=
X-Received: by 2002:a05:600c:1d82:b0:431:5ba1:a520 with SMTP id
 5b1f17b1804b1-431841eb454mr17145285e9.3.1729667686460; 
 Wed, 23 Oct 2024 00:14:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHESdFPxso2qeEJE/VGwSQojhOOZd856x2TbQdSeLJ9hrq7nXmhUWGHwq05rcnwEbMVx9Hw2o003yBsepHhW4o=
X-Received: by 2002:a05:600c:1d82:b0:431:5ba1:a520 with SMTP id
 5b1f17b1804b1-431841eb454mr17145085e9.3.1729667686082; Wed, 23 Oct 2024
 00:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <ZxgPKjakya_FwjLu@redhat.com>
In-Reply-To: <ZxgPKjakya_FwjLu@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 Oct 2024 09:14:34 +0200
Message-ID: <CABgObfa6C17wX8d-aHRGCE1qRr_mtN0_Rv9fnoqDDLEEKp+Cag@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] rust: miscellaneous cleanups + QOM integration
 tests
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Content-Type: multipart/alternative; boundary="000000000000023e5c06251fa432"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000023e5c06251fa432
Content-Type: text/plain; charset="UTF-8"

Il mar 22 ott 2024, 22:46 Kevin Wolf <kwolf@redhat.com> ha scritto:

> Am 21.10.2024 um 18:35 hat Paolo Bonzini geschrieben:
> > This series integrates some of the observations from the MSRV patches at
> >
> https://lore.kernel.org/qemu-devel/20241015131735.518771-1-pbonzini@redhat.com/
> .
> >
> > The main changes here are two: first, build an integration test that
> > actually tries to create a QOM object that is defined by Rust code;
> > second, make the properties array immutable so that declare_properties!
> > is enforced to use only const-friendly constructs.  These are patches
> > 6-11; the others consist of small cleanups.
> >
> > Hidden in here is actually a C patch (#10) which makes the
> > bindgen-generated prototypes use "*const" instead of "*mut".
> >
> > Tested with Rust nightly and (together with more patches from the
> > RFC), with Rust 1.63.0.
> >
> > Unlike the MSRV patches, this should be ready for inclusion; the
> > changes should be mostly uncontroversial.
>
> I'm not convinced that Zeroable has sufficient justification when all it
> does is saving us a few lines of code at the expense of making things
> more implicit


Implicit zero fields are used a lot in C code, including in
VMStateDescription and various const vtable structs, so I think we need
something of equivalent brevity.

There could be other solutions, for example a more generic
ConstDefault::DEFAULT trait. For now I went for something that resembles
existing code, as well as the C code we're converting.

. But it's used correctly as far as I can tell, so:
>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>

Thanks!

Paolo


>

--000000000000023e5c06251fa432
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 22 ott 2024, 22:46 Kevin Wolf &lt;<a href=3D"ma=
ilto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; ha scritto:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Am 21.10.2024 um 18:35 hat Paol=
o Bonzini geschrieben:<br>
&gt; This series integrates some of the observations from the MSRV patches =
at<br>
&gt; <a href=3D"https://lore.kernel.org/qemu-devel/20241015131735.518771-1-=
pbonzini@redhat.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https=
://lore.kernel.org/qemu-devel/20241015131735.518771-1-pbonzini@redhat.com/<=
/a>.<br>
&gt; <br>
&gt; The main changes here are two: first, build an integration test that<b=
r>
&gt; actually tries to create a QOM object that is defined by Rust code;<br=
>
&gt; second, make the properties array immutable so that declare_properties=
!<br>
&gt; is enforced to use only const-friendly constructs.=C2=A0 These are pat=
ches<br>
&gt; 6-11; the others consist of small cleanups.<br>
&gt; <br>
&gt; Hidden in here is actually a C patch (#10) which makes the<br>
&gt; bindgen-generated prototypes use &quot;*const&quot; instead of &quot;*=
mut&quot;.<br>
&gt; <br>
&gt; Tested with Rust nightly and (together with more patches from the<br>
&gt; RFC), with Rust 1.63.0.<br>
&gt; <br>
&gt; Unlike the MSRV patches, this should be ready for inclusion; the<br>
&gt; changes should be mostly uncontroversial.<br>
<br>
I&#39;m not convinced that Zeroable has sufficient justification when all i=
t<br>
does is saving us a few lines of code at the expense of making things<br>
more implicit</blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Implicit zero fields are used a lot in C code, including in VMSta=
teDescription and various const vtable structs, so I think we need somethin=
g of equivalent brevity.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>There could be other solutions, for example a more generic ConstDefault::D=
EFAULT trait. For now I went for something that resembles existing code, as=
 well as the C code we&#39;re converting.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">. But it&#39;s used correctly a=
s far as I can tell, so:<br>
<br>
Reviewed-by: Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com" target=3D"_=
blank" rel=3D"noreferrer">kwolf@redhat.com</a>&gt;<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks!</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
</blockquote></div></div></div>

--000000000000023e5c06251fa432--


