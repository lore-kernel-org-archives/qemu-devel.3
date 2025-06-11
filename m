Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D7BC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 10:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPIwj-0001Sr-Tj; Wed, 11 Jun 2025 06:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPIwh-0001Rx-Jq
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPIwg-0001qJ-4p
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749638676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a3biw5Hv7V/UqjmZl5nf7Vojns2ZYwZifrL781Rftxk=;
 b=DWyRrzidRGE5ePOnZi+c0CAHvbgbDMgzDbI9BtwTeV4IASaWckBVujwkpEVwnbhZIlrSY9
 k6U/p/u6I8VxtDmUPLYjeUn3U0c1P9poa+ehiOuZrZmvqhATTYmmM3Ivjn9ad4xRLSrlwx
 g2Uf7sPOTzBsZeNHLbCmB/YyJAxZozE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Qy2nQt38MoW3iM0LbePT2g-1; Wed, 11 Jun 2025 06:44:35 -0400
X-MC-Unique: Qy2nQt38MoW3iM0LbePT2g-1
X-Mimecast-MFC-AGG-ID: Qy2nQt38MoW3iM0LbePT2g_1749638674
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450eaae2934so57981015e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 03:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749638674; x=1750243474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a3biw5Hv7V/UqjmZl5nf7Vojns2ZYwZifrL781Rftxk=;
 b=cgG3UzibCV01JxyjiYTqW2LpMEAZERVwGBz0EAljSv0gdB8RfYkZ2TNWTAPw1iikEt
 Bge7ZUkTDFjkou53Atn0pZgrC2s9PS8TE6ow5GB97GvEyVicj1GyaZkjx4VATGDgaOOY
 ssNZU4ah+g/b+iclIfoRpbClgNgqMP+j9J3PeOyA8if2AYYzR2rbWnL796hqkwIY+3y8
 odmzJop4IE/yEEGfuN062dyHzzN7kh4ageIqsVcfUOjdwrZpqh1fwIR7lKhsPbUQyVr7
 1Gi1w3h/qshdQMjgzkJpQ8eedGp8KCJoZV+yjAIvHiK+n7aEC4Af9YZvHTMUs4Tlicwr
 2lmw==
X-Gm-Message-State: AOJu0YywftZLL5hpNsR05+bG1A4qEXThsumJ/InwwZDs+s6DbI2q/ITF
 ub+SeQioJB+hXslrpVRyOzN6vjRYUrl1My1MH69lKdZIaxsJz39g1YSkwBdCdRJBETWXY605Z5E
 lA6QiSXg+2vXBPb+Cr3c3cPHtxTXwbSITkrQvyK+gkR52g//SXeHpcP61aHzybtCLROIUk/Awqq
 PDDeZ2jtZpNsbHfSSYPSWOyggje+6XkIs=
X-Gm-Gg: ASbGncsgrij0rQHKZ2S8DIGlEccxcHZQ4ZxV5dst13ytQtPTp7mqYEfKNJTyo40ixhf
 sAie05gmsn2/FRIH11aNrv393lm9nQBszhdVexq+oHKPuXpFcTGmEqZTTghHg+9oLyhasC/qtXb
 WgCA==
X-Received: by 2002:a05:600c:3496:b0:453:8a6:d8de with SMTP id
 5b1f17b1804b1-4532907de44mr3803555e9.1.1749638674203; 
 Wed, 11 Jun 2025 03:44:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm7zHOvxzgU6boxcJBHAn2mBU78PB1FfApLX+OCzVkf+COwbw2uOhBZvk1Klh1SbutU9WBOJEhnS0PO/QupQ0=
X-Received: by 2002:a05:600c:3496:b0:453:8a6:d8de with SMTP id
 5b1f17b1804b1-4532907de44mr3803355e9.1.1749638673876; Wed, 11 Jun 2025
 03:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250610202110.2243-1-shentey@gmail.com>
 <20250610202110.2243-2-shentey@gmail.com>
 <e14ce991-7cd5-4875-bd99-5dc27a22be78@redhat.com>
 <03F26AC2-B53A-458E-9343-0254516F26DF@gmail.com>
In-Reply-To: <03F26AC2-B53A-458E-9343-0254516F26DF@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jun 2025 12:44:22 +0200
X-Gm-Features: AX0GCFshyBONw3RhKthSKMlZckvCXg496Y-Nh35230zX3gtZ3_6Y7i-sgVNcvtc
Message-ID: <CABgObfZgPh1VnJR9BrpFn322sO8_S0+tUGznj7soohOVjLqpkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust/qemu-api: Add initial logging support based
 on C API
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a45dfb0637497f0a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

--000000000000a45dfb0637497f0a
Content-Type: text/plain; charset="UTF-8"

Il mer 11 giu 2025, 12:21 Bernhard Beschow <shentey@gmail.com> ha scritto:

> Am 11. Juni 2025 07:56:23 UTC schrieb Paolo Bonzini <pbonzini@redhat.com>:
> >Clippy complains that it wants `` around the function name.
>
> Will fix in v3.
>

While at it, please run it through rustfmt and add a "//!" comment at the
top, such as "Bindings for QEMU's logging infrastructure".

You can build the documentation with "ninja rustdoc" so you can check the
result of the doc comments.

Thanks,

Paolo


> >
> >Paolo
> >
>
>

--000000000000a45dfb0637497f0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 11 giu 2025, 12:21 Bernha=
rd Beschow &lt;<a href=3D"mailto:shentey@gmail.com">shentey@gmail.com</a>&g=
t; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">A=
m 11. Juni 2025 07:56:23 UTC schrieb Paolo Bonzini &lt;<a href=3D"mailto:pb=
onzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com=
</a>&gt;:<br>
&gt;Clippy complains that it wants `` around the function name.<br>
<br>
Will fix in v3.<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">While at it, please run it through rustfmt and add a &quot;/=
/!&quot; comment at the top, such as &quot;Bindings for QEMU&#39;s logging =
infrastructure&quot;.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Yo=
u can build the documentation with &quot;ninja rustdoc&quot; so you can che=
ck the result of the doc comments.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Thanks,</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=
</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quo=
te gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt;<br>
&gt;Paolo<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000a45dfb0637497f0a--


