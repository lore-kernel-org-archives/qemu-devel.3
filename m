Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA63C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbk7-0000K5-OP; Thu, 01 May 2025 17:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uAbk5-0000If-OY
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:46:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uAbk2-0007Bu-Qi
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:46:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso9019155e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1746136009; x=1746740809; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3R/0ctxgo4AtoS8WNNC0LzdZXECuJFSn0hs5GjEQMeU=;
 b=VG9oMjz5H69YgM6fB4dEsEROBTdV22dani6czMv4TNq7VOfWy6C6pvo/3uhm3dET9O
 ItMLVyNrMg9BXgVaLtL+KF+IXfDTzdoyzrqCyVnyaJchmaLOytMzcYfuo9O10orLU+vg
 2TJ2jwrWUwmHnaqyOxhiX1FlgzJ0f1YSOIiRJQsIVLIPgU4UPNAzXCV1O0BKBSF+4Esf
 qD4yWaVhZFisVodX5NHKTxOxWcoS9x1JuaxKOgSwbB26P74biwv6G0bcgMy1bAzS1Knq
 zPTLwtV6xRwnwtvBMybNbWOP00J6FVE74n0BcU3qGhlxrLK4+0utpHHsBextwsZtnLMj
 Hzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746136009; x=1746740809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3R/0ctxgo4AtoS8WNNC0LzdZXECuJFSn0hs5GjEQMeU=;
 b=HpizcSKAytXzE5/ICmhMOS5uc52Ch1zIR9uGL8/jsh0edlOJxxv86rF9l0HjznpUrE
 gb2NXNvGnLpr8SUw69KLiH2Iw3kdGorm8ejf+Pg6K96GfJvWPzXm+djG7Gdg/OCzyn+u
 /qTMY0qIMy+W3XYS+HEIESwDZCnbGIBoZ+xurZ+uTiWJ3IPdIcJ8+Y4sn6qp/eWV7rih
 SCzrnkOJCQGO6+Lj/3618kBKygvycFTVY9x1+7oNe28vwPRK1wY5c2Xym9XhZKzUPoD4
 OD78pMv3NJnVMoi6Tqu0h5ih+m2dY5ILM9MU9bUsZbRDgaLyzNLqGVZOuU43ryS2ZnwW
 YJPg==
X-Gm-Message-State: AOJu0YzatvYjkFN/7QcENV70mTCxzNW94c0MYez9Bk/GpiRANUJdZEpH
 +NN9ehd8XEYofB5bgN8ATMRXcrv7Ac1LsZZlJ96/cBgdh7PpQ5PtbODxYb413VGE4hmcdx5e1gA
 X+SmCSTLWvHfFwr+qMuZbFyau5JQ=
X-Gm-Gg: ASbGnctgJB69kaeRpGJVEUFdALpqhGYxcmjWUcg+RI04G2GZP34bBRnTt0SWMwmUTrj
 5b8RC5iGMcY2MMyoWFNU3y4WKizgO3pN1cIGdmLz9tK2zhps7Wubl8CLja+onPcBk0kO6e/W3b1
 TTxShyjon0H6c4BDaG5IcvZSX3R6yztu6h
X-Google-Smtp-Source: AGHT+IHcriyM/GaycfNNBr4fnSU3ID0Xp8un7utTFmB8rqr0V7L/FSwbWJSbsKGAPKUOlrRpz0HEZO7lsZ4njEkodRM=
X-Received: by 2002:a05:600c:3b18:b0:43d:412e:8a81 with SMTP id
 5b1f17b1804b1-441bbf3d7dcmr2104475e9.28.1746136009051; Thu, 01 May 2025
 14:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250501181758.1057834-1-62701594+WorksButNotTested@users.noreply.github.com>
 <6d4308bf-5c8d-42df-a5f9-221dc1222ae2@linaro.org>
In-Reply-To: <6d4308bf-5c8d-42df-a5f9-221dc1222ae2@linaro.org>
From: Jon Wilson <jonwilson030981@googlemail.com>
Date: Thu, 1 May 2025 22:46:37 +0100
X-Gm-Features: ATxdqUF_0xwxKq53iKDuRbmHmDR30CnpxVCRZKRAckVp1ieHEgI64DH_s4w-Psc
Message-ID: <CAJHT5-+-3aJ4PqUj2G4C_aWA+WwevskMEEr0xcFotOfgqmNy3g@mail.gmail.com>
Subject: Re: [PATCH] Support madvise(MADV_DONTDUMP) when creating core dumps
 for qemu-user
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 WorksButNotTested <62701594+WorksButNotTested@users.noreply.github.com>
Content-Type: multipart/alternative; boundary="0000000000008c9196063419f8fd"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=jonwilson030981@googlemail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000008c9196063419f8fd
Content-Type: text/plain; charset="UTF-8"

Awesome. Thanks. How do I do that? Sorry I'm new to this workflow. Can you
point me at a reference?

On Thu, 1 May 2025, 22:27 Richard Henderson, <richard.henderson@linaro.org>
wrote:

> On 5/1/25 11:17, WorksButNotTested wrote:
> > ---
> >   include/exec/page-protection.h | 6 ++++++
> >   linux-user/elfload.c           | 4 ++++
> >   linux-user/mmap.c              | 5 +++++
> >   3 files changed, 15 insertions(+)
> >
>
> Seems reasonable.  Add a patch description and a Signed-off-by, please.
>
>
> r~
>
> > diff --git a/include/exec/page-protection.h
> b/include/exec/page-protection.h
> > index c43231af8b..f8826d917e 100644
> > --- a/include/exec/page-protection.h
> > +++ b/include/exec/page-protection.h
> > @@ -38,4 +38,10 @@
> >    */
> >   #define PAGE_PASSTHROUGH 0x0800
> >
> > +/*
> > + * For linux-user, indicates that the page should not be included in a
> core
> > + * dump.
> > + */
> > +#define PAGE_DONTDUMP   0x1000
> > +
> >   #endif
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index fbfdec2f17..41c46da055 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -4067,6 +4067,10 @@ static size_t vma_dump_size(target_ulong start,
> target_ulong end,
> >           return 0;
> >       }
> >
> > +    if (flags & PAGE_DONTDUMP) {
> > +        return 0;
> > +    }
> > +
> >       /*
> >        * Usually we don't dump executable pages as they contain
> >        * non-writable code that debugger can read directly from
> > diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> > index f88a80c31e..62fc8ac921 100644
> > --- a/linux-user/mmap.c
> > +++ b/linux-user/mmap.c
> > @@ -1247,6 +1247,11 @@ abi_long target_madvise(abi_ulong start,
> abi_ulong len_in, int advice)
> >        */
> >       mmap_lock();
> >       switch (advice) {
> > +    case MADV_DONTDUMP:
> > +        if (len > 0) {
> > +            page_set_flags(start, start + len - 1, PAGE_DONTDUMP);
> > +        }
> > +        break;
> >       case MADV_WIPEONFORK:
> >       case MADV_KEEPONFORK:
> >           ret = -EINVAL;
>
>

--0000000000008c9196063419f8fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Awesome. Thanks. How do I do that? Sorry I&#39;m new to t=
his workflow. Can you point me at a reference?</div><br><div class=3D"gmail=
_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu,=
 1 May 2025, 22:27 Richard Henderson, &lt;<a href=3D"mailto:richard.henders=
on@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">On 5/1/25 11:17, WorksButNotTested wrote:<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/exec/page-protection.h | 6 ++++++<br>
&gt;=C2=A0 =C2=A0linux-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 4 ++++<br>
&gt;=C2=A0 =C2=A0linux-user/mmap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 5 +++++<br>
&gt;=C2=A0 =C2=A03 files changed, 15 insertions(+)<br>
&gt; <br>
<br>
Seems reasonable.=C2=A0 Add a patch description and a Signed-off-by, please=
.<br>
<br>
<br>
r~<br>
<br>
&gt; diff --git a/include/exec/page-protection.h b/include/exec/page-protec=
tion.h<br>
&gt; index c43231af8b..f8826d917e 100644<br>
&gt; --- a/include/exec/page-protection.h<br>
&gt; +++ b/include/exec/page-protection.h<br>
&gt; @@ -38,4 +38,10 @@<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0#define PAGE_PASSTHROUGH 0x0800<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/*<br>
&gt; + * For linux-user, indicates that the page should not be included in =
a core<br>
&gt; + * dump.<br>
&gt; + */<br>
&gt; +#define PAGE_DONTDUMP=C2=A0 =C2=A00x1000<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
&gt; index fbfdec2f17..41c46da055 100644<br>
&gt; --- a/linux-user/elfload.c<br>
&gt; +++ b/linux-user/elfload.c<br>
&gt; @@ -4067,6 +4067,10 @@ static size_t vma_dump_size(target_ulong start,=
 target_ulong end,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 if (flags &amp; PAGE_DONTDUMP) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Usually we don&#39;t dump executable page=
s as they contain<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * non-writable code that debugger can read =
directly from<br>
&gt; diff --git a/linux-user/mmap.c b/linux-user/mmap.c<br>
&gt; index f88a80c31e..62fc8ac921 100644<br>
&gt; --- a/linux-user/mmap.c<br>
&gt; +++ b/linux-user/mmap.c<br>
&gt; @@ -1247,6 +1247,11 @@ abi_long target_madvise(abi_ulong start, abi_ul=
ong len_in, int advice)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mmap_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (advice) {<br>
&gt; +=C2=A0 =C2=A0 case MADV_DONTDUMP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 page_set_flags(start, start=
 + len - 1, PAGE_DONTDUMP);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case MADV_WIPEONFORK:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case MADV_KEEPONFORK:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
<br>
</blockquote></div>

--0000000000008c9196063419f8fd--

