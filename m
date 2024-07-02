Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9125DC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 21:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOkvr-0001yw-1g; Tue, 02 Jul 2024 17:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOkvk-0001w0-9P
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:20:53 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOkve-000791-Es
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:20:49 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a724cd0e9c2so475608266b.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719955243; x=1720560043; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DCHLgTQ59yWpdOf5FMPOqrdVh3OR8K9SHnSPR8S7hp4=;
 b=XZBsA5Lp0FxnZIrOG3GqOi7112PmtFwvKV9HXqQ9LZzwdZi2ooMCMFMy54FW6R4cHH
 mEvnSf6TeME34F8FJc/qx8ZHEfU1M13Avy/eYkOHCumEsdqimwDDIxPEoZ1mZySAvq8r
 dre6YYl9LvjtOqlbEWr3yRGVcRSfOAyPSXEfxFA3EiW/pu4tD3Pqb8yDlu3Zkx5BTOGY
 e07yeshTmppe3hB8eA2X4kO5Qrstpq2DcGY1z/TxQllkZjn5PyiUh+zsInR7zhpm7FBA
 OO451B7mOztj2H42Z1mv5Vydy/H8jHsyDkbP6EgaiQB+bMq4+wIK0/qYd/iuXFT884XU
 IuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719955243; x=1720560043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DCHLgTQ59yWpdOf5FMPOqrdVh3OR8K9SHnSPR8S7hp4=;
 b=BPkpo4VFt1voYRKHJUU2NN4cYyfL8+TLzhgEj5TdViUF/fWsjvEADAGXsT4MlIonMr
 pGg9FNOOzx7cOrccaBg8KlUK2m6p7n9KnoSqkkCI6/8ul0IBQyCCUYpAfMAu9rrBnaAT
 bdDTz09LqTYg0T1M8gemz8f89bpTsbwrXKBrMUb5g5X/rbNeKTldtUVVQewP4XhaocDD
 bD7EDIafe2ZJHolRZiV3EC5hhV7XAraUW8Cnyt8t6qUor1pz9SS7fmXJQUArdPNCnpkW
 1kU1EZF216UG5XQp332SqNLPMVWIHcOWBtukqGMd7R3DNcUW1wDCFQZLdTk+Hd15mnVR
 gFTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyArwC/uh3k/fU2kvOzfuY2kTVPPswVqkQW+Ly/hL/7s4z0lKzenyedZYBTww5s4TEx82dJWPC98lnvqEzGNjlP5qoamY=
X-Gm-Message-State: AOJu0Yy2T6VO6IKsBYgWj9LXPLJdJurcnsKOADymnxuldUDJUJpnuetW
 kNIUgRWXIbKV2bTGPRQiw3pbdvSYmP8xNUxQ1OogiqmTmwwbQ/7hUvGtTIWW9jQWZJ2IUCAQ47e
 3dXT9/7cuYUnElVpiSzSFDGKf7g==
X-Google-Smtp-Source: AGHT+IFcYr9Hsk5TsjPr57OnOddaRnNH1cgu7/Rh6wprqzEl/cPRpMpIySrVyix5ykucc+dY6SWoYib3qwECbt4aydw=
X-Received: by 2002:a17:907:6088:b0:a6f:53a7:adaa with SMTP id
 a640c23a62f3a-a751441f079mr696588566b.11.1719955243242; Tue, 02 Jul 2024
 14:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240702210443.3060881-1-zheyuma97@gmail.com>
 <20240702170539-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240702170539-mutt-send-email-mst@kernel.org>
From: Zheyu Ma <zheyuma97@gmail.com>
Date: Tue, 2 Jul 2024 23:20:31 +0200
Message-ID: <CAMhUBjmHEx9KZN0xt9gqNbcxDytJXSZgDoMw94DntW+=PhuWRw@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/virtio-crypto: Fix op_code assignment in
 virtio_crypto_create_asym_session
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004d9a96061c4a4964"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=zheyuma97@gmail.com; helo=mail-ej1-x62e.google.com
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

--0000000000004d9a96061c4a4964
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 11:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Tue, Jul 02, 2024 at 11:04:43PM +0200, Zheyu Ma wrote:
> > The assignment of the op_code in the virtio_crypto_create_asym_session
> > function was moved before its usage to ensure it is correctly set.
> > Previously, if the function failed during the key_len check, the op_cod=
e
> > did not have a proper value, causing
> virtio_crypto_free_create_session_req
> > to not free the memory correctly, leading to a memory leak.
> >
> > By setting the op_code before performing any checks, we ensure that
> > virtio_crypto_free_create_session_req has the correct context to
> > perform cleanup operations properly, thus preventing memory leaks.
> >
> > ASAN log:
> > =3D=3D3055068=3D=3DERROR: LeakSanitizer: detected memory leaks
> > Direct leak of 512 byte(s) in 1 object(s) allocated from:
> >     #0 0x5586a75e6ddd in malloc
> llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
> >     #1 0x7fb6b63b6738 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
> >     #2 0x5586a864bbde in virtio_crypto_handle_ctrl
> hw/virtio/virtio-crypto.c:407:19
> >     #3 0x5586a94fc84c in virtio_queue_notify_vq hw/virtio/virtio.c:2277=
:9
> >     #4 0x5586a94fc0a2 in virtio_queue_host_notifier_read
> hw/virtio/virtio.c:3641:9
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>
>
> why did you send 2 copies?
>
> Sorry for disturbing you; I sent the v2 version wrongly, and now I've sen=
t
a v3 version.

Regards,
Zheyu


> > ---
> >  hw/virtio/virtio-crypto.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> > index bbe8aa4b99..5034768bff 100644
> > --- a/hw/virtio/virtio-crypto.c
> > +++ b/hw/virtio/virtio-crypto.c
> > @@ -205,6 +205,7 @@ virtio_crypto_create_asym_session(VirtIOCrypto
> *vcrypto,
> >      int queue_index;
> >      uint32_t algo, keytype, keylen;
> >
> > +    sreq->info.op_code =3D opcode;
> >      algo =3D ldl_le_p(&sess_req->para.algo);
> >      keytype =3D ldl_le_p(&sess_req->para.keytype);
> >      keylen =3D ldl_le_p(&sess_req->para.keylen);
> > @@ -224,7 +225,6 @@ virtio_crypto_create_asym_session(VirtIOCrypto
> *vcrypto,
> >          iov_discard_front(&iov, &out_num, keylen);
> >      }
> >
> > -    sreq->info.op_code =3D opcode;
> >      asym_info =3D &sreq->info.u.asym_sess_info;
> >      asym_info->algo =3D algo;
> >      asym_info->keytype =3D keytype;
> > --
> > 2.34.1
>
>

--0000000000004d9a96061c4a4964
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 2, 2024 at 11:05=E2=80=AF=
PM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Tue, Jul 02, 2024 at 11:04:43PM +0200, Zheyu Ma wrote:<br>
&gt; The assignment of the op_code in the virtio_crypto_create_asym_session=
<br>
&gt; function was moved before its usage to ensure it is correctly set.<br>
&gt; Previously, if the function failed during the key_len check, the op_co=
de<br>
&gt; did not have a proper value, causing virtio_crypto_free_create_session=
_req<br>
&gt; to not free the memory correctly, leading to a memory leak.<br>
&gt; <br>
&gt; By setting the op_code before performing any checks, we ensure that<br=
>
&gt; virtio_crypto_free_create_session_req has the correct context to<br>
&gt; perform cleanup operations properly, thus preventing memory leaks.<br>
&gt; <br>
&gt; ASAN log:<br>
&gt; =3D=3D3055068=3D=3DERROR: LeakSanitizer: detected memory leaks<br>
&gt; Direct leak of 512 byte(s) in 1 object(s) allocated from:<br>
&gt;=C2=A0 =C2=A0 =C2=A0#0 0x5586a75e6ddd in malloc llvm/compiler-rt/lib/as=
an/asan_malloc_linux.cpp:129:3<br>
&gt;=C2=A0 =C2=A0 =C2=A0#1 0x7fb6b63b6738 in g_malloc (/lib/x86_64-linux-gn=
u/libglib-2.0.so.0+0x5e738)<br>
&gt;=C2=A0 =C2=A0 =C2=A0#2 0x5586a864bbde in virtio_crypto_handle_ctrl hw/v=
irtio/virtio-crypto.c:407:19<br>
&gt;=C2=A0 =C2=A0 =C2=A0#3 0x5586a94fc84c in virtio_queue_notify_vq hw/virt=
io/virtio.c:2277:9<br>
&gt;=C2=A0 =C2=A0 =C2=A0#4 0x5586a94fc0a2 in virtio_queue_host_notifier_rea=
d hw/virtio/virtio.c:3641:9<br>
&gt; <br>
&gt; Signed-off-by: Zheyu Ma &lt;<a href=3D"mailto:zheyuma97@gmail.com" tar=
get=3D"_blank">zheyuma97@gmail.com</a>&gt;<br>
<br>
<br>
why did you send 2 copies?<br>
<br></blockquote><div>Sorry for disturbing you; I sent the v2 version wrong=
ly, and now I&#39;ve sent a v3 version.<br><br>Regards,</div><div>Zheyu</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; ---<br>
&gt;=C2=A0 hw/virtio/virtio-crypto.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c<br>
&gt; index bbe8aa4b99..5034768bff 100644<br>
&gt; --- a/hw/virtio/virtio-crypto.c<br>
&gt; +++ b/hw/virtio/virtio-crypto.c<br>
&gt; @@ -205,6 +205,7 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vc=
rypto,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int queue_index;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t algo, keytype, keylen;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 sreq-&gt;info.op_code =3D opcode;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 algo =3D ldl_le_p(&amp;sess_req-&gt;para.algo);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 keytype =3D ldl_le_p(&amp;sess_req-&gt;para.keytyp=
e);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 keylen =3D ldl_le_p(&amp;sess_req-&gt;para.keylen)=
;<br>
&gt; @@ -224,7 +225,6 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vc=
rypto,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iov_discard_front(&amp;iov, &amp;out=
_num, keylen);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 sreq-&gt;info.op_code =3D opcode;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 asym_info =3D &amp;sreq-&gt;info.u.asym_sess_info;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 asym_info-&gt;algo =3D algo;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 asym_info-&gt;keytype =3D keytype;<br>
&gt; -- <br>
&gt; 2.34.1<br>
<br>
</blockquote></div></div>

--0000000000004d9a96061c4a4964--

