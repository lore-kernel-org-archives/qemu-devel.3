Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B3FC61DB8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 15:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjL5B-0008OJ-6y; Wed, 28 Aug 2024 11:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanjason@google.com>)
 id 1sjL59-0008Mu-4N
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:59:39 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fanjason@google.com>)
 id 1sjL57-0000md-6Y
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:59:38 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5becd359800so7611260a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724860775; x=1725465575; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fu1tRoS05r4eE0dR7inLf9GFauP+U8QH3LR2U4xZNi4=;
 b=1ROaCXxKBGbd0asWy2VvajNXnwlMCOEISq8Rsu/nIve5KXM0YIja+LzF8whdduzI8K
 JDP/P/wEmtTeqdeL6OaoscXvqRqHArpsUPTE4Z+tMBPutqsEOm+2pdS6jsXN4rKLD+Js
 k5ggYeaPaXU4eM5py2CozxD1rFB7g/CVJqXd1WTGPzM2jKXPJXm/xp2oRZ0HCmxfGVQ8
 W4bbRDxl8XAEIz+5Id27XEgZHGMp2dhycS/VrIGHM+N95E1k33f8sOaFtoolm8cG84il
 FtHSjIR0lYfuHMpohOBawXVTYauNnEyRJt1ekw2JAKUf2i2E7911fD6xQ+2e014eR6r8
 cxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724860775; x=1725465575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fu1tRoS05r4eE0dR7inLf9GFauP+U8QH3LR2U4xZNi4=;
 b=T0GgzP5bEzb0xrssBmzMkBA+N/VkFz7d8eC33xlQRP9Ux60TN/VjnPu+1c4IMMCbfb
 NPw7ddF+ck4+83lf3E2cR6O5ZtHeCfZ73kFsNLJLKj1YJWu+vtl7C0ESunVKZgcIcHY6
 ih3jgNePWrap/V3tR24C8Sm5qvv2HCwdwxp7Zu5KP8X5RaLFVBm2RpUXjwtRY6N+9uKp
 hbRc0L87Qj6cOUY37qqPatGjNqyR8VujnvSMjmw9I2AvemKnkaZVme1XQDJKUByoTvCE
 kwqFwuSQNdQU8IRuMSXatGLAN/iCT+CdABOOHcJF44kee5CRpUoF2Eik3DMRkrWFoFZO
 J9fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvSruqgkoOxFSKFf1Gx6zxo62hUxOi6xZes7pCbi/WIHzstP08e1FpALdQm0eU+Uvu5Qj5UNELnfQo@nongnu.org
X-Gm-Message-State: AOJu0YxiwvUihD4bppx7zVjVM7iaOPDjwmxeXPLYFciVEMYmb+/YXyOn
 9SNVnyfHwT4Q7DBl/Q6bw3Tz7RXkPXvPwWfHuanWK8FXo58SRXwcBQ6hZQ2i+5msJGKVHRnw2jD
 l4T5kpUI7Sx57bgrG5LtjiohYVSMu+p3YUysq
X-Google-Smtp-Source: AGHT+IGGCMOMPxfvrIlYjf5eTpV5AQGcscWi+ijcpJTbZnwIR7V9R+rMhCY+jYE+FA+Hg8fnTp76NGTJURdByDdztG0=
X-Received: by 2002:a05:6402:51d4:b0:5bf:256a:781b with SMTP id
 4fb4d7f45d1cf-5c21ed342f6mr19624a12.5.1724860774185; Wed, 28 Aug 2024
 08:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240826204628.3541850-1-fanjason@google.com>
 <20240826204628.3541850-2-fanjason@google.com>
 <CAFEAcA_ErHypGHM_Gbh3dt35WSuAn5CworUiE5OcY9M2dDOGmA@mail.gmail.com>
In-Reply-To: <CAFEAcA_ErHypGHM_Gbh3dt35WSuAn5CworUiE5OcY9M2dDOGmA@mail.gmail.com>
From: Jason Fan <fanjason@google.com>
Date: Wed, 28 Aug 2024 08:59:22 -0700
Message-ID: <CALktSQ=+K=RJGoZ2niEgUiwCnKtsSmB7u8EzN170iGV7aFpSfA@mail.gmail.com>
Subject: Re: [PATCH 1/1] include/qemu/bitops.h: Add deposit8 for uint8_t bit
 operation
To: Peter Maydell <peter.maydell@linaro.org>
Cc: philmd@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bc24620620c071cc"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=fanjason@google.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000bc24620620c071cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Re-send this to include the original mail-list.

Hi Peter,
I am working on a i3c target model which requires bitops on the uint8_t
registers.
deposit8 can help to check incorrect length or start input for 8 bit value.
You are right that desposit32 should also work if we always pass the
correct arguments, but since the implementation seems trivial enough, I
just go ahead and create the patch.
Thank you.

On Tue, Aug 27, 2024 at 2:23=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Mon, 26 Aug 2024 at 22:01, Jason Fan <fanjason@google.com> wrote:
> >
> > Signed-off-by: Jason Fan <fanjason@google.com>
> > ---
> >  include/qemu/bitops.h | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> > index 2c0a2fe751..d01c4b42f2 100644
> > --- a/include/qemu/bitops.h
> > +++ b/include/qemu/bitops.h
> > @@ -459,6 +459,32 @@ static inline int64_t sextract64(uint64_t value,
> int start, int length)
> >      return ((int64_t)(value << (64 - length - start))) >> (64 - length=
);
> >  }
> >
> > +/**
> > + * deposit8:
> > + * @value: initial value to insert bit field into
> > + * @start: the lowest bit in the bit field (numbered from 0)
> > + * @length: the length of the bit field
> > + * @fieldval: the value to insert into the bit field
> > + *
> > + * Deposit @fieldval into the 8 bit @value at the bit field specified
> > + * by the @start and @length parameters, and return the modified
> > + * @value. Bits of @value outside the bit field are not modified.
> > + * Bits of @fieldval above the least significant @length bits are
> > + * ignored. The bit field must lie entirely within the 8 bit word.
> > + * It is valid to request that all 8 bits are modified (ie @length
> > + * 8 and @start 0).
> > + *
> > + * Returns: the modified @value.
> > + */
> > +static inline uint8_t deposit8(uint8_t value, int start, int length,
> > +                               uint8_t fieldval)
> > +{
> > +    uint8_t mask =3D 0xFF;
> > +    assert(start >=3D 0 && length > 0 && length <=3D 8 - start);
> > +    mask =3D (mask >> (8 - length)) << start;
> > +    return (value & ~mask) | ((fieldval << start) & mask);
> > +}
>
> What's the use case for this? Where would you need this
> and not be able to use "deposit32" instead?
>
> thanks
> -- PMM
>

--000000000000bc24620620c071cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Re-send=C2=A0this to include the original mail-list.<=
/div><div><br></div>Hi Peter,=C2=A0<div>I am working on a i3c target model =
which requires bitops on the uint8_t registers.<br><div>deposit8 can help t=
o check incorrect length or start input for 8 bit value.=C2=A0</div><div>Yo=
u are right that desposit32 should also work if we always pass the correct =
arguments, but since the implementation seems trivial enough, I just go ahe=
ad and create the patch.</div><div>Thank you.</div></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 27, 20=
24 at 2:23=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@lin=
aro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Mon, 26 Aug 2024 at 22:01, Jason Fan &l=
t;<a href=3D"mailto:fanjason@google.com" target=3D"_blank">fanjason@google.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt; Signed-off-by: Jason Fan &lt;<a href=3D"mailto:fanjason@google.com" ta=
rget=3D"_blank">fanjason@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/qemu/bitops.h | 26 ++++++++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 26 insertions(+)<br>
&gt;<br>
&gt; diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h<br>
&gt; index 2c0a2fe751..d01c4b42f2 100644<br>
&gt; --- a/include/qemu/bitops.h<br>
&gt; +++ b/include/qemu/bitops.h<br>
&gt; @@ -459,6 +459,32 @@ static inline int64_t sextract64(uint64_t value, =
int start, int length)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return ((int64_t)(value &lt;&lt; (64 - length - st=
art))) &gt;&gt; (64 - length);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +/**<br>
&gt; + * deposit8:<br>
&gt; + * @value: initial value to insert bit field into<br>
&gt; + * @start: the lowest bit in the bit field (numbered from 0)<br>
&gt; + * @length: the length of the bit field<br>
&gt; + * @fieldval: the value to insert into the bit field<br>
&gt; + *<br>
&gt; + * Deposit @fieldval into the 8 bit @value at the bit field specified=
<br>
&gt; + * by the @start and @length parameters, and return the modified<br>
&gt; + * @value. Bits of @value outside the bit field are not modified.<br>
&gt; + * Bits of @fieldval above the least significant @length bits are<br>
&gt; + * ignored. The bit field must lie entirely within the 8 bit word.<br=
>
&gt; + * It is valid to request that all 8 bits are modified (ie @length<br=
>
&gt; + * 8 and @start 0).<br>
&gt; + *<br>
&gt; + * Returns: the modified @value.<br>
&gt; + */<br>
&gt; +static inline uint8_t deposit8(uint8_t value, int start, int length,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t fieldval)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint8_t mask =3D 0xFF;<br>
&gt; +=C2=A0 =C2=A0 assert(start &gt;=3D 0 &amp;&amp; length &gt; 0 &amp;&a=
mp; length &lt;=3D 8 - start);<br>
&gt; +=C2=A0 =C2=A0 mask =3D (mask &gt;&gt; (8 - length)) &lt;&lt; start;<b=
r>
&gt; +=C2=A0 =C2=A0 return (value &amp; ~mask) | ((fieldval &lt;&lt; start)=
 &amp; mask);<br>
&gt; +}<br>
<br>
What&#39;s the use case for this? Where would you need this<br>
and not be able to use &quot;deposit32&quot; instead?<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000bc24620620c071cc--

