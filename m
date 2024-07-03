Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB47C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 12:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOzZ5-0006Lh-7z; Wed, 03 Jul 2024 08:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOzZ3-0006LO-G7
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:58:25 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOzZ1-00014b-SX
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:58:25 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-444fa363d1aso4333591cf.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720011503; x=1720616303; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+tUdbdsCoWmmO3SinWLIL5nhi+ze3e8SOYE62xhCNIk=;
 b=aOhjonP8QOQ3n/bnc6s2NzodRUngHHq80QTOIEBpT2OdVrQBiqqeM6VVyroV7BhYB6
 yo0B0QmOWP/boRHqarcas+4m/4jAIgJ2v6D10xFHEjFYwBkBanac1EETFLF0j9RTtRBX
 PoYIFhe6yrjDY/4BhE+ZPTx9LUHH6budWZ1QQVnqAcYN1CvVUcjdZXGy+SBr3BFV1Juy
 SxY2Dr7VgESJhvyEZ2pVHYPwkqudFRS1VSjsk1RLpi89PyFMvfzD3otjVxtZAi4almbd
 6DNo87PWUMMPaalN30k7pT1XJpt0ZTmDjZn1xyRh3JmQm5dVIqdV+aggj60oK/mHyRSW
 2leA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720011503; x=1720616303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+tUdbdsCoWmmO3SinWLIL5nhi+ze3e8SOYE62xhCNIk=;
 b=SR24S2jV2cis+z2WfKgBg9U3pnmnSnJJ5n53/AYdoQkVg2xJ68fg/xZTQa+TnC5f5r
 6OBMp91c97OZ4IKfjL9wMoC8HQXJfvhW4uXo6yrJcXyFSnlvNiflhb2FDUQO7rOG/Cdg
 Bp9p6jelq2+4Qt7UA+LV5vpq0MDNDweuftkNNGhzhnwZcXxDcPvXZjKLyQys8nEIPGCi
 qN8bP4Orvm7edwjgxTgkix/JzrHzN/A82yvdp9O8JDf/WwqDfiwu7y1XbzsnQfHY0ahd
 7NfRaOVyv9fymgdfNr+As9lt+V3+ADfFPUDjnqKtXG++xAdcexGIQnEJHJdyWjlf/Yfm
 JrLw==
X-Gm-Message-State: AOJu0YxvNdqqF8J+57wuqhDZkhQ5gmignB6hjdanuAMoSy+NczB1Igfj
 sBIbIFlp4bTunysb9cqXya6ZNYvhsu2Tb8ahD6JUSRv0ZXc1EdW9Uk868Bfx27csgy3kKpNO7KY
 XliTG3IQ1fspamlsWCfxqIlurPHA=
X-Google-Smtp-Source: AGHT+IH35hYRK4zf7MKHHARf50/xmmGZcQ/xzTTxnQfu9j6GNC9C9NW076m0O6NfDyEZjDEGzp2o/0w+o/lCj2VhfNk=
X-Received: by 2002:ac8:578b:0:b0:446:59db:9184 with SMTP id
 d75a77b69052e-447bf8e2f81mr24385421cf.22.1720011502790; Wed, 03 Jul 2024
 05:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240701145853.1394967-1-pbonzini@redhat.com>
 <20240701145853.1394967-4-pbonzini@redhat.com>
 <CAJ+F1C+__WX3EUFw-XdsqtXbwFtH0JZJdNH3WDvFazkNnecAbw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+__WX3EUFw-XdsqtXbwFtH0JZJdNH3WDvFazkNnecAbw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 3 Jul 2024 16:58:11 +0400
Message-ID: <CAJ+F1C+V+Z2e+o8LCJBiXw=R=ZactZhhUwjeN7kStrJG7pxOXw@mail.gmail.com>
Subject: Re: [PATCH 03/14] rust: define traits and pointer wrappers to convert
 from/to C representations
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?Sebastian_Dr=C3=B6ge?= <slomo@circular-chaos.org>
Content-Type: multipart/alternative; boundary="000000000000a232f7061c576213"
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000a232f7061c576213
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jul 3, 2024 at 4:48=E2=80=AFPM Marc-Andr=C3=A9 Lureau <marcandre.lu=
reau@gmail.com>
wrote:

> Hi
>
> (adding Sebastian, one of the glib-rs developers in CC)
>
> On Mon, Jul 1, 2024 at 7:02=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
>> The qemu::util::foreign module provides:
>>
>> - A trait for structs that can be converted to a C ("foreign")
>> representation
>>   (CloneToForeign)
>>
>> - A trait for structs that can be built from a C ("foreign")
>> representation
>>   (FromForeign), and the utility IntoNative that can be used with less
>> typing
>>   (similar to the standard library's From and Into pair)
>>
>> - Automatic implementations of the above traits for Option<>, supporting
>> NULL
>>   pointers
>>
>> - A wrapper for a pointer that automatically frees the contained data.  =
If
>>   a struct XYZ implements CloneToForeign, you can build an
>> OwnedPointer<XYZ>
>>   and it will free the contents automatically unless you retrieve it wit=
h
>>   owned_ptr.into_inner()
>>
>
> [...] Also, you don't offer the equivalent of "to_glib_none" which uses a
> temporary stash and is quite useful, as a majority of functions don't tak=
e
> ownership.
>

I realize this may be somewhat offered by OwnedPointer (although not
mentioned explicitly in the doc). Its usage seems unsafe, as you have to
handle the foreign pointer lifetime manually...


--=20
Marc-Andr=C3=A9 Lureau

--000000000000a232f7061c576213
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 3, 2024 at 4:48=E2=80=
=AFPM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.c=
om">marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div=
><div><br></div><div>(adding Sebastian, one of the glib-rs developers in CC=
)</div><div><br></div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Mon, Jul 1, 2024 at 7:02=E2=80=AFPM Paolo Bonzini &lt;<a hre=
f=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The q=
emu::util::foreign module provides:<br>
<br>
- A trait for structs that can be converted to a C (&quot;foreign&quot;) re=
presentation<br>
=C2=A0 (CloneToForeign)<br>
<br>
- A trait for structs that can be built from a C (&quot;foreign&quot;) repr=
esentation<br>
=C2=A0 (FromForeign), and the utility IntoNative that can be used with less=
 typing<br>
=C2=A0 (similar to the standard library&#39;s From and Into pair)<br>
<br>
- Automatic implementations of the above traits for Option&lt;&gt;, support=
ing NULL<br>
=C2=A0 pointers<br>
<br>
- A wrapper for a pointer that automatically frees the contained data.=C2=
=A0 If<br>
=C2=A0 a struct XYZ implements CloneToForeign, you can build an OwnedPointe=
r&lt;XYZ&gt;<br>
=C2=A0 and it will free the contents automatically unless you retrieve it w=
ith<br>
=C2=A0 owned_ptr.into_inner()<br></blockquote><div><br></div><div>[...] Als=
o, you don&#39;t offer the equivalent of &quot;to_glib_none&quot; which use=
s a temporary stash and is quite useful, as a majority of functions don&#39=
;t take ownership.<br></div></div></div></blockquote><div><br></div><div>I =
realize this may be somewhat offered by OwnedPointer (although not mentione=
d explicitly in the doc). Its usage seems unsafe, as you have to handle the=
 foreign pointer lifetime manually...<br></div></div><br clear=3D"all"><br>=
<span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=
=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000a232f7061c576213--

