Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78060C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 17:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCMJR-0001qA-Cv; Tue, 06 May 2025 13:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uCMFv-00080o-2f
 for qemu-devel@nongnu.org; Tue, 06 May 2025 13:39:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uCMFk-00024U-J4
 for qemu-devel@nongnu.org; Tue, 06 May 2025 13:38:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso75642f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1746553126; x=1747157926; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LFqz7mpBGf2u2lJna0a9zLlM9jchnfzYqWJqTyBYLzY=;
 b=kA6fjIg531hST41oyd1tlGJZDZRcsVWDV9zdM0FdNGw2fpr+/evcz4GvFK9iM/DVXv
 nYb/9m2dUiLCr+qzeUMSVUJD+2bVnpsgYMBwp0psbJWlRAgE44jmz+oMQhVPb2Ouyy6z
 I+PfmbkOiCx+aLM7akG6u1btiV4YG7ltBvI26GFhSJsBMgKLN3RtKofmAFE6VXiMHVT8
 Na5RWLqmwtOOqBNXYKoZWoJNlN9EKMTkO0AsOJivHP3xvlWiVG5Qx2VTQhCzDUFDtjxB
 Tel+pZbRY3JChLsr0dKJfBbMfxQmlQgP8WRLQqMzORCdjB9HJPlcXAM2HAz2gecxT71t
 j5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746553126; x=1747157926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LFqz7mpBGf2u2lJna0a9zLlM9jchnfzYqWJqTyBYLzY=;
 b=UfHENmtUekq/mG3FZWM9chbkA+65rzaYuHzIzulausG5B34T4q0Y+4whvGph0WKUWz
 iI/Ajfpwk05K/Qf/6nITiSXv7qCnfP1OwW0TTZWquiabN3oIiDkUXJB8oGH/+BgEE5HK
 +ks3OKSlj80jItVDxmcK/NlKaBLvlnp8Kg0dO8uBah666fZx23RhCHGcIvUNQyjkS3I+
 WcaGpINWbKBrzg7zVuMjp/0dsU6JPheH8XOTlNF27iZpsMEknFfU26pJs1iWQ6hA39bs
 ktG4pRNF2PgG2FFYICA/s81iJeN883b2vuDHqf3cezvBeKlg303JPVC+Fsk50fO0bZPe
 KdYg==
X-Gm-Message-State: AOJu0YzAXctnVV24xugOAy/pon6chvmNtHpZXx1/5SvowMz0EHguF9yt
 Yyn3e6MaVEk8Oem7Vb1Jjr6AwWwqvYl1gQiEa4Y/QdlttSquCzPFmAK2s0WA2uRjIx64bX3wFU3
 ocAHf9iMPgBUpG+wCMXGLZfGbpyE=
X-Gm-Gg: ASbGncvsjCXxpinY8GBooupfFE2wt9J40yR3/6slLgMAKz3975sbXev6+UzHnFWYJys
 Uxx9gQrmd1/KCcGhyrb8OtErMe4CcOID5cl3hv9pEgHmVvPWtO7ywBrNu0C3GppmhQjKGrW/rfr
 zuiFqXau1crjv4+v9kd9IrLQ==
X-Google-Smtp-Source: AGHT+IH+OeSS3XZvja3iXglaQajAjHQMPPTw2OO6Nd/0R/5DkdcW1VWVck0EZejJuijGONNUK/iVqf16pbiib8EOM9U=
X-Received: by 2002:a05:6000:4593:b0:3a0:b207:90c with SMTP id
 ffacd0b85a97d-3a0b45402femr458731f8f.19.1746553126071; Tue, 06 May 2025
 10:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250506164602.1292446-1-62701594+WorksButNotTested@users.noreply.github.com>
 <aBo_HWA4nuY7FGul@redhat.com>
In-Reply-To: <aBo_HWA4nuY7FGul@redhat.com>
From: Jon Wilson <jonwilson030981@googlemail.com>
Date: Tue, 6 May 2025 18:38:34 +0100
X-Gm-Features: ATxdqUE3PiJlzga4PrzyNSm08vDSN1rS_xI7zDEfhZgORy3k_327aI5OzpC7ZLU
Message-ID: <CAJHT5-L9UhmaYijUH7DPgknXN6HTM4T57ZamPG55axsJvZ9xuA@mail.gmail.com>
Subject: Re: [PATCH v3] Support madvise(MADV_DONTDUMP) when creating core
 dumps for qemu-user
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a9347e06347b1672"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=jonwilson030981@googlemail.com; helo=mail-wr1-x431.google.com
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

--000000000000a9347e06347b1672
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies. I'm just fighting git. Much more used to just using github.com
and PRs, but I totally understand that different projects have their own
preferences. Hopefully v4 looks a bit better?
Is there anything else I need to do? What are the next steps? Just wait for
it to be merged?

Sorry, this workflow is all new to me. Thanks for your patience.

Best Regards.

Jon

On Tue, May 6, 2025 at 5:57=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Tue, May 06, 2025 at 05:46:02PM +0100, WorksButNotTested wrote:
> > When running applications which make large (sparsely populated) address
> ranges
> > (e.g. when using address sanitizer with LibAFL) the inability to exclud=
e
> these
> > regions from any core dump can result in very large files which fill th=
e
> disk.
> > A coredump is obvously very useful for performing a post-mortem when
> fuzzing.
> >
> > Whilst the man pages state that madvise provides only a hint (and hence
> can be
> > ignored), this patch adds support to handle MADV_DONTDUMP and set a
> > corresponding flag in the page flags, thus allowing QEMU to exclude the=
se
> > regions from the core file.
> >
> > Signed-off-by: WorksButNotTested <
> 62701594+WorksButNotTested@users.noreply.github.com>
>
> Any reason you've not used your "jonwilson030981@googlemail.com"
> address for this.
>
> This github alias rejects any mail delivery, so also should not
> be CC'd on the patch either, as that triggers failures when
> reviewers reply to this submission.
>
> > ---
> >  include/exec/page-protection.h |  6 ++++++
> >  linux-user/elfload.c           |  4 ++++
> >  linux-user/mmap.c              | 18 ++++++++++++++++++
> >  3 files changed, 28 insertions(+)
> >
> > diff --git a/include/exec/page-protection.h
> b/include/exec/page-protection.h
> > index c43231af8b..f8826d917e 100644
> > --- a/include/exec/page-protection.h
> > +++ b/include/exec/page-protection.h
> > @@ -38,4 +38,10 @@
> >   */
> >  #define PAGE_PASSTHROUGH 0x0800
> >
> > +/*
> > + * For linux-user, indicates that the page should not be included in a
> core
> > + * dump.
> > + */
> > +#define PAGE_DONTDUMP   0x1000
> > +
> >  #endif
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index fbfdec2f17..41c46da055 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -4067,6 +4067,10 @@ static size_t vma_dump_size(target_ulong start,
> target_ulong end,
> >          return 0;
> >      }
> >
> > +    if (flags & PAGE_DONTDUMP) {
> > +        return 0;
> > +    }
> > +
> >      /*
> >       * Usually we don't dump executable pages as they contain
> >       * non-writable code that debugger can read directly from
> > diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> > index f88a80c31e..016063a8cf 100644
> > --- a/linux-user/mmap.c
> > +++ b/linux-user/mmap.c
> > @@ -1247,6 +1247,24 @@ abi_long target_madvise(abi_ulong start,
> abi_ulong len_in, int advice)
> >       */
> >      mmap_lock();
> >      switch (advice) {
> > +    case MADV_DONTDUMP:
> > +        if (len > 0) {
> > +            /*
> > +             * To set the page permissons, we must OR our new flags
> with the
> > +             * existing flags. Only mark the pages as PAGE_DONTDUMP if
> the
> > +             * entire range has the same flags. If any part of the ran=
ge
> > +             * differs, we would need to process it one page at a time
> which
> > +             * might not be very performant. Since we are not obliged
> to respect
> > +             * this flag, we will support it for the most likely usage
> scenario.
> > +             * Note that we don't set PAGE_ANON, since this can only b=
e
> set with
> > +             * new mappings.
> > +             */
> > +            int flg =3D page_get_flags(start);
> > +            if (page_check_range(start, len, flg)) {
> > +                page_set_flags(start, start + len - 1, PAGE_DONTDUMP |
> (flg & ~PAGE_ANON) );
> > +            }
> > +        }
> > +        break;
> >      case MADV_WIPEONFORK:
> >      case MADV_KEEPONFORK:
> >          ret =3D -EINVAL;
> > --
> > 2.43.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000a9347e06347b1672
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Apologies. I&#39;m just fighting git. Much more used to ju=
st using <a href=3D"http://github.com">github.com</a> and PRs, but I totall=
y understand that different projects have their own preferences. Hopefully=
=C2=A0v4 looks a bit better?<div>Is there anything else I need to do? What =
are the next steps? Just wait for it to be merged?</div><div><br></div><div=
>Sorry, this workflow is all new=C2=A0to me. Thanks for your patience.</div=
><div><br></div><div>Best Regards.</div><div><br></div><div>Jon</div></div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, May 6, 2025 at 5:57=E2=80=AFPM Daniel P. Berrang=C3=
=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, M=
ay 06, 2025 at 05:46:02PM +0100, WorksButNotTested wrote:<br>
&gt; When running applications which make large (sparsely populated) addres=
s ranges<br>
&gt; (e.g. when using address sanitizer with LibAFL) the inability to exclu=
de these<br>
&gt; regions from any core dump can result in very large files which fill t=
he disk.<br>
&gt; A coredump is obvously very useful for performing a post-mortem when f=
uzzing.<br>
&gt; <br>
&gt; Whilst the man pages state that madvise provides only a hint (and henc=
e can be<br>
&gt; ignored), this patch adds support to handle MADV_DONTDUMP and set a<br=
>
&gt; corresponding flag in the page flags, thus allowing QEMU to exclude th=
ese<br>
&gt; regions from the core file.<br>
&gt; <br>
&gt; Signed-off-by: WorksButNotTested &lt;<a href=3D"mailto:62701594%2BWork=
sButNotTested@users.noreply.github.com" target=3D"_blank">62701594+WorksBut=
NotTested@users.noreply.github.com</a>&gt;<br>
<br>
Any reason you&#39;ve not used your &quot;<a href=3D"mailto:jonwilson030981=
@googlemail.com" target=3D"_blank">jonwilson030981@googlemail.com</a>&quot;=
<br>
address for this.<br>
<br>
This github alias rejects any mail delivery, so also should not<br>
be CC&#39;d on the patch either, as that triggers failures when<br>
reviewers reply to this submission.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 include/exec/page-protection.h |=C2=A0 6 ++++++<br>
&gt;=C2=A0 linux-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 4 ++++<br>
&gt;=C2=A0 linux-user/mmap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 18 ++++++++++++++++++<br>
&gt;=C2=A0 3 files changed, 28 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/exec/page-protection.h b/include/exec/page-protec=
tion.h<br>
&gt; index c43231af8b..f8826d917e 100644<br>
&gt; --- a/include/exec/page-protection.h<br>
&gt; +++ b/include/exec/page-protection.h<br>
&gt; @@ -38,4 +38,10 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #define PAGE_PASSTHROUGH 0x0800<br>
&gt;=C2=A0 <br>
&gt; +/*<br>
&gt; + * For linux-user, indicates that the page should not be included in =
a core <br>
&gt; + * dump.<br>
&gt; + */<br>
&gt; +#define PAGE_DONTDUMP=C2=A0 =C2=A00x1000<br>
&gt; +<br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
&gt; index fbfdec2f17..41c46da055 100644<br>
&gt; --- a/linux-user/elfload.c<br>
&gt; +++ b/linux-user/elfload.c<br>
&gt; @@ -4067,6 +4067,10 @@ static size_t vma_dump_size(target_ulong start,=
 target_ulong end,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (flags &amp; PAGE_DONTDUMP) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Usually we don&#39;t dump executable pages=
 as they contain<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* non-writable code that debugger can read d=
irectly from<br>
&gt; diff --git a/linux-user/mmap.c b/linux-user/mmap.c<br>
&gt; index f88a80c31e..016063a8cf 100644<br>
&gt; --- a/linux-user/mmap.c<br>
&gt; +++ b/linux-user/mmap.c<br>
&gt; @@ -1247,6 +1247,24 @@ abi_long target_madvise(abi_ulong start, abi_ul=
ong len_in, int advice)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 mmap_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (advice) {<br>
&gt; +=C2=A0 =C2=A0 case MADV_DONTDUMP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* To set the page per=
missons, we must OR our new flags with the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* existing flags. Onl=
y mark the pages as PAGE_DONTDUMP if the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* entire range has th=
e same flags. If any part of the range<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* differs, we would n=
eed to process it one page at a time which<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* might not be very p=
erformant. Since we are not obliged to respect<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* this flag, we will =
support it for the most likely usage scenario.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Note that we don&#3=
9;t set PAGE_ANON, since this can only be set with<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* new mappings.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flg =3D page_get_flags(=
start);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (page_check_range(start,=
 len, flg)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 page_set_flag=
s(start, start + len - 1, PAGE_DONTDUMP | (flg &amp; ~PAGE_ANON) );<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case MADV_WIPEONFORK:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case MADV_KEEPONFORK:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EINVAL;<br>
&gt; -- <br>
&gt; 2.43.0<br>
&gt; <br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--000000000000a9347e06347b1672--

