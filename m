Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCFFE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 11:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUlfu-0004Fb-AU; Mon, 06 Jan 2025 06:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tUlfs-0004FI-Od
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:53:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tUlfq-0006Cp-Pg
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736164412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrJf0OZJlWd3exazIEc9JY4LwQ2ngv0zCiOY5QT4+lA=;
 b=EG2MrhVptQ3PYzBEKdMMcBjrh4heZ8gQ5IKPZvi/QPKPoVhOyE+N5WtDOEN6UL9o/kI1r8
 Zo/WentvQy0k7zTv24eyQ6hlBD13w5eS623VnNePnp8AXBLiWzJPiMXWzslFV2jO+dHQT8
 Cwxu10xBm/D/RgMES1KXPhWeaLpgYrQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-GsByHptLMO26LuWmcSF2Bg-1; Mon, 06 Jan 2025 06:53:31 -0500
X-MC-Unique: GsByHptLMO26LuWmcSF2Bg-1
X-Mimecast-MFC-AGG-ID: GsByHptLMO26LuWmcSF2Bg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43628594d34so41094665e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 03:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736164410; x=1736769210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lrJf0OZJlWd3exazIEc9JY4LwQ2ngv0zCiOY5QT4+lA=;
 b=qv806TLUGBRW7IKJYe1B6NZQjiphyKM9p8EculMPNDthJzq4HTZV6qkVgQVdgLhW+O
 ox7qR7OtYT6ahewwiJO+M9lgipNlJxLw0KUUSY0RkLVumv++S+uDem4OskK+FaszKeys
 OkIoJ3zRiNTR3x9Mqjgr0nj3cEg2/pR/fXOUxPE3HtL7FxnlvI91PebvYWesCvB1Hryf
 GBrZyXpNtTqAGuY+pcb4Ie1xAEfQktJwuOf46nHbbFGRxFbVgu8BgeoauapgkT9oQHdx
 zzG98ZVjZfiVRSnAUAhhGJK7wTZfACSSYDaRX6Yl+zmKXXEFORf6a7oCGAkzwjTc8hQ4
 0o5g==
X-Gm-Message-State: AOJu0YzAvp7iJtBDEoUDZQOJRWuzwacPM9g8MIlTBqV1RagjrXRGijJ0
 8kOakHjXf9gHBGheMf/SZijQFRkLhLecexqqUAvH4QHbVIZq4cWA2KvqZTktxSh9+gUuUFlCjaF
 n6k5QP46Z294BZ5ZsbU77S+OOaQlnN9tqN2Eb/0jy3CHinbCOchTg/ZRgJ1PlWBQ01eiQPzU4FU
 RDwrrHKaROGxyVflrKzJi4kXcjTOI=
X-Gm-Gg: ASbGnct12aoGAsAvGlUAL/xcMXkdfOdkQWYtmfz6O61zhJ1/yPBRx4P4SJDgXVvnlTN
 yp3yfVHBQWKQCNztSzQ/o2Ir2Uq9IK8FMun6JFA==
X-Received: by 2002:a05:600c:350c:b0:434:fdaf:af2d with SMTP id
 5b1f17b1804b1-43668b7850emr503577905e9.30.1736164409774; 
 Mon, 06 Jan 2025 03:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDEZ1FGompk//dN3WUnBX/k7KaupB8KjNk+sNifa/NAmzMSM+29G9fgKu7Xakedb9srOy5Qr20KvgyKlZD30I=
X-Received: by 2002:a05:600c:350c:b0:434:fdaf:af2d with SMTP id
 5b1f17b1804b1-43668b7850emr503577755e9.30.1736164409496; Mon, 06 Jan 2025
 03:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20241219083228.363430-1-pbonzini@redhat.com>
 <20241219083228.363430-26-pbonzini@redhat.com>
 <daea6757-a67b-45d5-bf2a-807fd9569a70@linaro.org>
In-Reply-To: <daea6757-a67b-45d5-bf2a-807fd9569a70@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 6 Jan 2025 12:53:17 +0100
Message-ID: <CABgObfYMP5-9uN9cLofPT6DzBS_o1CVfbHbY8pwn9xjdOXOqgw@mail.gmail.com>
Subject: Re: [PULL 25/41] rust: qom: put class_init together from multiple
 ClassInitImpl<>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e67628062b0846ac"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--000000000000e67628062b0846ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 2 gen 2025, 18:04 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> ha
scritto:

> > +            unsafe {
> > +                bindings::device_class_set_legacy_reset(dc,
> Some(rust_reset_fn::<T>));
>
> Pre-existing, but since it appears on this patch, Rust device models
> should not implement this legacy interface. If a non-Rust parent
> implements it, I think we should convert the non-Rust parent before
> adding a Rust child. No clue how to check a parent don't implement
> this interface in Rust.
>
> Generally, we shouldn't access legacy API from Rust IMHO.
>

I disagree that device_class_set_legacy_reset() should not be used.
Three-phase reset is only needed for buses, and requires more code in order
to implement the Resettable interface. Devices gain nothing compared to
using device_class_set_legacy_reset().

In fact, perhaps it should have been named something like
device_class_set_simple_reset()...

Paolo

--000000000000e67628062b0846ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 2 gen 2025, 18:04 Philipp=
e Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro=
.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsafe {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bindings::dev=
ice_class_set_legacy_reset(dc, Some(rust_reset_fn::&lt;T&gt;));<br>
<br>
Pre-existing, but since it appears on this patch, Rust device models<br>
should not implement this legacy interface. If a non-Rust parent<br>
implements it, I think we should convert the non-Rust parent before<br>
adding a Rust child. No clue how to check a parent don&#39;t implement<br>
this interface in Rust.<br>
<br>
Generally, we shouldn&#39;t access legacy API from Rust IMHO.<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I disagree tha=
t device_class_set_legacy_reset() should not be used. Three-phase reset is =
only needed for buses, and requires more code in order to implement the Res=
ettable interface. Devices gain nothing compared to using device_class_set_=
legacy_reset().</div><div dir=3D"auto"><br></div><div dir=3D"auto">In fact,=
 perhaps it should have been named something like device_class_set_simple_r=
eset()...</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></d=
iv>

--000000000000e67628062b0846ac--


