Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7053FC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 20:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkV6z-0006tP-Hq; Wed, 13 Mar 2024 16:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flwu@google.com>) id 1rkV6y-0006tG-FH
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 16:22:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flwu@google.com>) id 1rkV6v-0002nR-UZ
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 16:22:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-413ef770363so1676675e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710361319; x=1710966119; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PUv4FKR1iakZ4yV/9Fop0O0x/1oCRZQ8+x/F8e3qb5o=;
 b=SYLMytshbrwKws/dbCAg2OkaWsA9W05RfhZmB5YaK4Y/wCvJSi2FnXcOavH6h7JBiS
 ptKo7pygjq+7xVbpg5a/hpKgujzSbZ47qmCq++c36jVsI4ZgjzpIWmOVybQSCV8SeuAS
 tyJx0QyZ9UGNQBfSD14GTTxSgSm92P/K0b3wBfFJlPlktIATRdGpjPATYHgoCPvSIxS/
 s7pp+07prqEn2UF4N2A9U530nR8Uoh/WIZnp7aFmAgyFUgRHDwGRBOXMPlYNnBshm0mR
 y+GO9YEBx3hHJoV+YObU9EhHQwr8BWEgQh5elaQDg9YBzk2yiOgP7FLhgbUBOGF1CNGH
 yPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710361319; x=1710966119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PUv4FKR1iakZ4yV/9Fop0O0x/1oCRZQ8+x/F8e3qb5o=;
 b=vMRStE/+IUXkzLChdILWTUN/PYxoU8cvS3N92T8vkx35KfO6lK9NYXMt+g8eHrhN/O
 A9/c3+IEKxIm33jwv29DZNcEF+clSHfB5nchMSnQa+zcOg7mUWwOK9St+sqLBq3ZColt
 ovEtAsgGnBcqSqdMYcOo685bKaQA9Tt+nZekXKIlleOrYoEkHb2pYJvHfTvTNT34Ofev
 7YGDrpqCFu7hDg2wiyE6cpShkAIKcdII3VD9Rw2lJgrGP/P0/oHPWVe1OlvuDXuHJgh8
 st0pUz0Bnftr2oUjs+kDiYfRSVIjlpKX5KdvjXNhNn+ROdTEFCptNqpbVsv9Q3UjvOOi
 eH3g==
X-Gm-Message-State: AOJu0YxVCSViByluuPpejm0vzmRFyc3yeBrEr5+KV6XyIjUmYsme0ZSP
 a1/A3XYwlQO3SZUhuK1ds96/FIdpQDvirfBN23afXhkG1GvfhN+WRBHtu1IK8C7qDofjK7YOco3
 WZuJtEa5usouSwxrTxCx+rWZtLfI3p/DZhfMj
X-Google-Smtp-Source: AGHT+IE6UlhEGPQ606WiCx+ebpXsgbDRhOtJ82DwjvdG0V3VrPbeujyBTL5WA3PQK3XC+NOZjabbWaxGK88TqboVyZI=
X-Received: by 2002:a05:600c:4591:b0:413:e8db:2c9b with SMTP id
 r17-20020a05600c459100b00413e8db2c9bmr630687wmo.40.1710361319345; Wed, 13 Mar
 2024 13:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHdnXhDZMgAKZyhucJ8QsFJHiO5xqdQq9zVn5X2SSL0-Q12-Jg@mail.gmail.com>
 <CAO=notyfoWHWDRBkdMY45_oiifX+t+9hyJfvaMhrAii3yJ7X-g@mail.gmail.com>
In-Reply-To: <CAO=notyfoWHWDRBkdMY45_oiifX+t+9hyJfvaMhrAii3yJ7X-g@mail.gmail.com>
From: Felix Wu <flwu@google.com>
Date: Wed, 13 Mar 2024 13:21:46 -0700
Message-ID: <CAJt6XFr2RQBFKNWQG3jwbc-J_QGpz6KdpP4pWeaekk3KabQtHg@mail.gmail.com>
Subject: Re: udp guestfwd
To: Louai Al-Khanji <louai.khanji@gmail.com>
Cc: qemu-devel@nongnu.org, Patrick Venture <venture@google.com>
Content-Type: multipart/alternative; boundary="000000000000e1491f0613908662"
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=flwu@google.com; helo=mail-wm1-x32d.google.com
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

--000000000000e1491f0613908662
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Louai,

Are you using IPv6 or IPv4? The IPv4 is actually broken (if you want to
send multiple requests to slirp and get them forwarded).
You can check the latest comments in following tickets:
https://gitlab.freedesktop.org/slirp/libslirp/-/issues/67
https://gitlab.com/qemu-project/qemu/-/issues/1835

If you want to use IPv6, let me know and I can create pull requests in
libslirp so you can try it.

Thanks, Felix

On Fri, Dec 8, 2023 at 9:33=E2=80=AFAM Patrick Venture <venture@google.com>=
 wrote:

>
> On Fri, Oct 27, 2023 at 11:44=E2=80=AFPM Louai Al-Khanji <louai.khanji@gm=
ail.com>
> wrote:
>
>> Hi,
>>
>> I'm interested in having the guestfwd option work for udp. My
>> understanding is that currently it's restricted to only tcp.
>>
>> I'm not familiar with libslirp internals. What would need to be changed
>> to implement this? I'm potentially interested in doing the work.
>>
>> I did a tiny amount of digging around libslirp and saw this comment in
>> `udp.c':
>>
>>         /*
>>          * XXXXX Here, check if it's in udpexec_list,
>>          * and if it is, do the fork_exec() etc.
>>          */
>>
>> I wonder whether that is related. In any case any help is much
>> appreciated.
>>
>
> Felix has been working in this space and it may take time to get the CLs
> landed in libslirp and qemu.
>
> Patrick
>
>>
>> Thanks,
>> Louai Al-Khanji
>>
>

--000000000000e1491f0613908662
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Louai,<div><br></div><div>Are you using IPv6 or IPv4? T=
he IPv4 is actually=C2=A0broken (if you want to send multiple requests to s=
lirp and get them forwarded).</div><div>You can check the latest comments i=
n following tickets:</div><div><a href=3D"https://gitlab.freedesktop.org/sl=
irp/libslirp/-/issues/67">https://gitlab.freedesktop.org/slirp/libslirp/-/i=
ssues/67</a><br></div><div><a href=3D"https://gitlab.com/qemu-project/qemu/=
-/issues/1835">https://gitlab.com/qemu-project/qemu/-/issues/1835</a><br></=
div><div><br></div><div>If you want to use IPv6, let me know and I can crea=
te pull requests in libslirp so you can try it.</div><div><br></div><div>Th=
anks, Felix</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Fri, Dec 8, 2023 at 9:33=E2=80=AFAM Patrick Venture &lt=
;<a href=3D"mailto:venture@google.com">venture@google.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri,=
 Oct 27, 2023 at 11:44=E2=80=AFPM Louai Al-Khanji &lt;<a href=3D"mailto:lou=
ai.khanji@gmail.com" target=3D"_blank">louai.khanji@gmail.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"lt=
r">Hi,<div><br></div><div>I&#39;m interested in having the guestfwd option =
work for udp. My understanding is that currently it&#39;s restricted to onl=
y tcp.</div><div><br></div><div>I&#39;m not familiar with libslirp=C2=A0int=
ernals. What would need to be changed to implement this? I&#39;m potentiall=
y interested in doing the work.</div><div><br></div><div>I did a tiny amoun=
t of digging around libslirp and saw this comment in `udp.c&#39;:<br clear=
=3D"all"><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0* XXXXX Here, check if it&#39;s in udpexec_list,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* and if it is, do the fork_exec() etc.<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br></div><div><br></div><div>I wond=
er whether that is related. In any case any help is much appreciated.</div>=
</div></div></blockquote><div><br></div><div dir=3D"ltr">Felix has been wor=
king=C2=A0in this space and it may take time to get the=C2=A0CLs landed in =
libslirp and qemu.<div><br></div></div><div>Patrick=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><div><br></div>=
<span class=3D"gmail_signature_prefix">Thanks,</span><br><div dir=3D"ltr" c=
lass=3D"gmail_signature">Louai Al-Khanji<br></div></div></div>
</blockquote></div></div>
</blockquote></div>

--000000000000e1491f0613908662--

