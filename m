Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE91CF07C4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 08:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syobi-0005Ho-Ki; Thu, 10 Oct 2024 04:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1syobg-0005HL-Cw
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 04:33:12 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1syobe-0006jw-PM
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 04:33:12 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4603f47b2c8so8371871cf.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 01:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728549189; x=1729153989; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r+tAbAgbaEO80v9lH6g9xEjpCRljsF54Bm2x6HorED4=;
 b=KhRQJtQ0K7PQ1X17wiVfA3OiQuxpu0eifHQkHl0qKXB7dJapqEOAzEqDeHyfee2xP/
 yQepHNT+YWiB20A4J0Krc0WTgu4v8TLz5bziI5XqS+cpHViWhy7mtXn/PJBNZzyOT8Ki
 0Wtas+NF31LVT1/oX6SCYMM6DHDmEoTvz1XWwBOwlhRa6VV3d6pen/Oy0WlCsd0a71GF
 Qm7WnTlv6VxI0zuOzvwoxhnp9aL5m7ye9Oi8T1DeRIPwkzuvjzE7CFtSfSY2DNjpgm86
 rfRDCq2bzPIar2oD5iOmGXBIjYMhmvrv6frU/AyhimqfKbiiO79h8dp8ai4vThAvBmZx
 9Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728549189; x=1729153989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r+tAbAgbaEO80v9lH6g9xEjpCRljsF54Bm2x6HorED4=;
 b=sl/nAwl7AavIMKpuZMa1LTEct9QR05QcUa9OcGXpnZVI9Jz/fPQP/1kTnpQ7HU/X6i
 ivHjRou2SLdBVxeJBZL2biHTIN2VnwI/x+n0eCq9SyKFah/rbNWQMovXmIiEIrEF1bWh
 g3kwdRo7BC7v2wAPNSqZUfV76oRkyKzhXj2kxZUtjWAac9e3yTSwQXaucBbD9PcbaQKx
 OEGKK3vdu1ZcAz7RDNjDHgE/eUy9iImkDUQWCWAMvXGd8bWWeSSQ6iwcVeI38uafxZah
 CRPnYg6LSQWedUOPlK9Eh5gzBl6xz2hnx9Yl5YGB6OL2jqX1nbxUyWOz93Bs/Dk6RX3Z
 6f+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnCc8WyuLXRSZ87HxooAPDZIeQpnprqHwiygt/XzSnBOJt8J7uONno/ZakKw6f/pu9RiMuDcDR0M7h@nongnu.org
X-Gm-Message-State: AOJu0Yw/w8bJMRGPiNOd7ksW/j+iI0LXi/EdVKgBlPdbIZ2bAZdX+MNT
 iwQPYLtp8jQlyUSVAs2aq0RaaVy0ocwW6vh3ejXz7KjtyD9o2DTeKbdpI8B2VI8DNo+xuzFKyxz
 wBzMMSB1aZsH7iXRYKd+hcni9Pbc=
X-Google-Smtp-Source: AGHT+IH/q+fuYVJ/eBIn/ivIyI8dcwXKOcB5N6uz3/Vie6Lvz32bbwE/skQKL242aDKIo5VGU26sCsLMK5o6b/Xa00k=
X-Received: by 2002:a05:622a:590b:b0:458:5441:362a with SMTP id
 d75a77b69052e-45fb0e84e13mr74914431cf.58.1728549189254; Thu, 10 Oct 2024
 01:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240913094604.269135-1-d-tatianin@yandex-team.ru>
 <fa326630-8304-4700-9995-d98287356c1f@yandex-team.ru>
In-Reply-To: <fa326630-8304-4700-9995-d98287356c1f@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 10 Oct 2024 12:32:57 +0400
Message-ID: <CAJ+F1CJuReS0R08QvWfgeDeDN8xD+=xYWrybBEDONvo5H-HtHQ@mail.gmail.com>
Subject: Re: [PATCH v2] chardev: introduce 'reconnect-ms' and deprecate
 'reconnect'
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, 
 devel@lists.libvirt.org, Peter Krempa <pkrempa@redhat.com>, 
 Michal Privoznik <mprivozn@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000067052f06241b386f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
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

--00000000000067052f06241b386f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vladimir

On Mon, Sep 30, 2024 at 5:17=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> Hi Mark-Andre!
>
> Could you please take a look? We have collected acks for QAPI changes,
> could this be queued?
>
>
While writing to 9.2 changelog, I realize that we should probably have
addressed a few more things:
- change -netdev stream to use reconnect-ms too, for consistency
- update the qemu documentation to use reconnect-ms
- update code and tests to use reconnect-ms

Could you look at it? thanks

On 13.09.24 12:46, Daniil Tatianin wrote:
> > The 'reconnect' option only allows to specify the time in seconds,
> > which is way too long for certain workflows.
> >
> > We have a lightweight disk backend server, which takes about 20ms to
> > live update, but due to this limitation in QEMU, previously the guest
> > disk controller would hang for one second because it would take this
> > long for QEMU to reinitialize the socket connection.
> >
> > Introduce a new option called 'reconnect-ms', which is the same as
> > 'reconnect', except the value is treated as milliseconds. These are
> > mutually exclusive and specifying both results in an error.
> >
> > 'reconnect' is also deprecated by this commit to make it possible to
> > remove it in the future as to not keep two options that control the
> > same thing.
> >
> > Reviewed-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> > Acked-by: Peter Krempa<pkrempa@redhat.com>
> > Signed-off-by: Daniil Tatianin<d-tatianin@yandex-team.ru>
>
> --
> Best regards,
> Vladimir
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000067052f06241b386f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Vladimir<br></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 30, 2024 at 5:=
17=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementsov=
@yandex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">Hi Mark-Andre!<br>
<br>
Could you please take a look? We have collected acks for QAPI changes, coul=
d this be queued?<br>
<br></blockquote><div><br></div><div>While writing to 9.2 changelog, I real=
ize that we should probably have addressed a few more things:</div><div>- c=
hange -netdev stream to use reconnect-ms too, for consistency<br></div><div=
>- update the qemu documentation to use reconnect-ms</div><div>- update cod=
e and tests to use reconnect-ms<br></div><div>=C2=A0</div><div>Could you lo=
ok at it? thanks<br></div><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
On 13.09.24 12:46, Daniil Tatianin wrote:<br>
&gt; The &#39;reconnect&#39; option only allows to specify the time in seco=
nds,<br>
&gt; which is way too long for certain workflows.<br>
&gt; <br>
&gt; We have a lightweight disk backend server, which takes about 20ms to<b=
r>
&gt; live update, but due to this limitation in QEMU, previously the guest<=
br>
&gt; disk controller would hang for one second because it would take this<b=
r>
&gt; long for QEMU to reinitialize the socket connection.<br>
&gt; <br>
&gt; Introduce a new option called &#39;reconnect-ms&#39;, which is the sam=
e as<br>
&gt; &#39;reconnect&#39;, except the value is treated as milliseconds. Thes=
e are<br>
&gt; mutually exclusive and specifying both results in an error.<br>
&gt; <br>
&gt; &#39;reconnect&#39; is also deprecated by this commit to make it possi=
ble to<br>
&gt; remove it in the future as to not keep two options that control the<br=
>
&gt; same thing.<br>
&gt; <br>
&gt; Reviewed-by: Vladimir Sementsov-Ogievskiy&lt;<a href=3D"mailto:vsement=
sov@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt;<br>
&gt; Acked-by: Peter Krempa&lt;<a href=3D"mailto:pkrempa@redhat.com" target=
=3D"_blank">pkrempa@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Daniil Tatianin&lt;<a href=3D"mailto:d-tatianin@yandex-=
team.ru" target=3D"_blank">d-tatianin@yandex-team.ru</a>&gt;<br>
<br>
-- <br>
Best regards,<br>
Vladimir<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000067052f06241b386f--

