Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB67BC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzci-0005ZJ-DY; Mon, 05 May 2025 13:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uBzcf-0005VJ-EV
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:28:58 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uBzcd-0006eI-PI
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:28:57 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4766cb762b6so54067821cf.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746466134; x=1747070934; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dt/NBmWkS5SW0IQ6dXDJKyT2czmYF9whmaW1CQaQYLA=;
 b=M+MLtZ4XBJhib7/zdcZFZeb6kqQif24zX4AiJqZuSWd/9cMUcuj07hLrjy9Ncu56/k
 qw7O+PWTlbG4m1Vlda6z0qKlGdCxSeoaUGVFGo1tXid+zPjiyzAFogeLzb2nKCOBURwZ
 ZSjdKwOKnKDGjVaIvNlgjIezHxo3bWAeGngd7kd3cPMN1/9113JCHxt3FvYLjSB6/Wqg
 1RwAM253koDfdrHmpsBN9vral3xErVgZnG5a7DS8wIzS0Bj7CgmaMVQDyCAN5+voBScp
 hKS1gMoL17PPcdqx7QoP6vxU1iQw/G0PdqW36dX2w0Qql79U/x5pxRY57N5wDtodWAhb
 eOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746466134; x=1747070934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dt/NBmWkS5SW0IQ6dXDJKyT2czmYF9whmaW1CQaQYLA=;
 b=fKO889FEOOVGVJoR0vbozX6tqWh1Y4jnB1GHPo7xM2S2JsLxfqgs5UA7GzRS3kRLhp
 U0K1SjZGSq6AuuZ6CXERJbWmOi0bOkIIGBpUc/kfJIQ47EYqnAK6XUkfEknz4Ng1pGri
 RvhF4hxmSus9y3/VOYgVEaLF8mVqG1TIjxh6XpquMF9jqyA8RJlIV4N0i74AxXAGH2Zd
 rFZl51J6PRWxpb/CczR3bwMr9EcgSWzNaEYs/udpJ04QDiNSJTTBEgVd43Ers14ND6xo
 1vq3m7sA1F8NYDdTEh3CFgBPkTumm0oP+niuRJbceo7yQ5o4PhM5YjocY5lU73W6RDiL
 HXNw==
X-Gm-Message-State: AOJu0YzMIM3ktVGQ9GbapVbeLhfzfwpsCEWuyzav3/5eqeKyZyn3ke0G
 Q8gbrg+JlmbyLbpGolMB4H0QEX/48jfAfyutevqqXl5IwFka73Avy2FcJJV2AJ78P5QV25b9cmy
 V/8L5p1ZphlQjPop8VGSQ/Pr38Ho=
X-Gm-Gg: ASbGncu2o0w8Q1KLijVkur4qJQZOfL3e6dYehpBggB7qDWsBxcBs6+ERJbiWWQo3OXB
 nooK9uLzaWH4zjqitofDz91U4u0aReEagXQlUtONLM8yubOcSFxUaJ/P8WCGX+hdljyliXG9qyZ
 1/eU7ra1/nYh6ZcSYMsVhSvj4wOnf+dLCZD5SRY2ypmBKRLRScG/66NS0=
X-Google-Smtp-Source: AGHT+IFKVvWTYdVcPzoJpdMn3nUWmngAAYfAr69lR1bVZiOnNLM3vOGFL/6Xz1bdV0zQA0pDBUSlnNECKIHaL9uri1w=
X-Received: by 2002:a05:622a:4e90:b0:48d:7cb6:c616 with SMTP id
 d75a77b69052e-490e21c87ddmr5114591cf.14.1746466134309; Mon, 05 May 2025
 10:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250326161927.15572-1-just4now666666@gmail.com>
 <CAJ+F1CKzKuO940euRhCb=tx_UQ-Ncs6k4yctipeT1v4vkinu3w@mail.gmail.com>
 <CACkyd_awBqPLTQ=ouJng8+-P4y-5qutU4BJTNZrSRxSwAeiWVw@mail.gmail.com>
In-Reply-To: <CACkyd_awBqPLTQ=ouJng8+-P4y-5qutU4BJTNZrSRxSwAeiWVw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 5 May 2025 21:28:42 +0400
X-Gm-Features: ATxdqUFjIqcj3cJI5fT3XleN0JE6nR-zzB3xuRAIaEMuEMdJ0UwZ9qL5uiDHYVs
Message-ID: <CAJ+F1C+SQ-p_rRZ0w74wUHBPve_w-JktNfmURfUQuCDc1YTf7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] util/memfd: allow allocating 0 bytes
To: Elisha Hollander <just4now666666@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Mon, May 5, 2025 at 9:03=E2=80=AFPM Elisha Hollander
<just4now666666@gmail.com> wrote:
>
> Not necessarily fdopen, can't remember why I chose it, we just need any p=
ointer as no data will be written into the buffer anyways
>

NULL should be acceptable then. You need to explain in greater details
what you are trying to solve.

>
> On Mon, May 5, 2025, 19:55 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail=
.com> wrote:
>>
>> Hi
>>
>> On Wed, Mar 26, 2025 at 8:21=E2=80=AFPM donno2048 <just4now666666@gmail.=
com> wrote:
>> >
>> > This silently fixes issues resulting from trying to allocate 0 bytes.
>> >
>> > Fixes error, for example, for writing byte 0x20 to port 0x3c0, then wo=
rd 0xf09 to port 0x3b4 when CPU is initiated, which shouldn't break.
>> >
>>
>> This is worth a test.
>>
>> > Signed-off-by: donno2048 <just4now666666@gmail.com>
>> > ---
>> >  util/memfd.c | 10 +++++++---
>> >  1 file changed, 7 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/util/memfd.c b/util/memfd.c
>> > index 07beab174d..4f2c4ea1dd 100644
>> > --- a/util/memfd.c
>> > +++ b/util/memfd.c
>> > @@ -131,9 +131,13 @@ void *qemu_memfd_alloc(const char *name, size_t s=
ize, unsigned int seals,
>> >          }
>> >      }
>> >
>> > -    ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0)=
;
>> > -    if (ptr =3D=3D MAP_FAILED) {
>> > -        goto err;
>> > +    if (size !=3D 0) {
>> > +        ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd=
, 0);
>> > +        if (ptr =3D=3D MAP_FAILED) {
>> > +            goto err;
>> > +        }
>> > +    } else {
>> > +        ptr =3D fdopen(mfd, "rw");
>>
>> I don't understand fdopen() here, it returns a FILE*
>>
>> >      }
>> >
>> >      *fd =3D mfd;
>> > --
>> > 2.30.2
>> >
>> >
>>
>>
>> --
>> Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau

