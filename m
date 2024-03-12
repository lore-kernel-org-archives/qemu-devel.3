Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21D4C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 10:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzS7-00019m-Rc; Tue, 12 Mar 2024 06:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjzS6-00019R-5B; Tue, 12 Mar 2024 06:33:46 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjzS4-0006KY-JN; Tue, 12 Mar 2024 06:33:45 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5e4f79007ffso2433848a12.2; 
 Tue, 12 Mar 2024 03:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710239623; x=1710844423; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4vzvB3V6mxsrECxmxmV48wiKZxduzEMho864nZo0f8=;
 b=gpCKiCBky0ltwVlJ6NKnwKgXN54UoK/+Ppm0a50dzqksYLEaRHpIwonivO9tN6nqyw
 8yW3zAkaOj00bfvc3IfXAQnHICQOBup8RHT1ZKo0JR4ooIO0g+/4+bhYZr36xs09luAX
 EtrXi9uGdSBo0Bv4gGVa0RPBp2gaSgyKOgvi9q6rL4iacRpatqbwj12bhTiz8/MjwIIa
 Gst1ph3x1VxezJpX/u/am8/LHfgjxZp4itrWm2xliZxtoxEspZiNZLcQ1Xf96MDChWay
 zTbHPG2HCgQosXSLF7suJ5KS5JTTDHPmtwY6TJ7dAXKhOM0gEg0BSwYwHkamXGXKwL4U
 wXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710239623; x=1710844423;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T4vzvB3V6mxsrECxmxmV48wiKZxduzEMho864nZo0f8=;
 b=M6Z8wxmHs8gZIHcH9aBtgmBGoRrpwZswIhIBue7ELeRS318rSFHoo0F+/YcD78Sl7a
 37n6oo7MClRyoE22tSCsXUxEci5MRyIDeCVh2NNdxDY3ygknrNzzIXhnmyY7d0075YAy
 b5xTaWVW2JzTrqM43OwNhLx2vz3VcHHMD8qCHfaY1xF1+O4gd0ETETzKQiN+6atyTTcJ
 TaizoWKSuWbxGC0afjx0bp4QAHjZlxq5STiIUPS+FNXvZcbjclMuu3KJg1wbujd9WwRy
 sxZPOZ3V3t1SCeJIe8OcEyOsm239OklqYkzoEWXO7BRrt1bqhB8z5RAXv9V0a/j9N+vQ
 19GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv9w3yyE0xMEYznY5QCDdGWsxU0sHSAac10TO7r/X+cxgcuV5aFvCPfLqtN3P4BzFNhR60Gih3MLIM/jGUtQatLpurg1doc5t8qZwkaozAze3lbmwvWIwm0uY=
X-Gm-Message-State: AOJu0Yw63hvffLfxhAqIcVjIzE3lebdOF0jCUO4fxgntYNkEk0N8BJUQ
 ORXHai29Y6RW7OvkW23EOcD9SdRf9u+MXLRngmixodbPt7KJBP/L
X-Google-Smtp-Source: AGHT+IGP2oL4yaJKPxJhxeWRX14JpEXtvJ/H7D9S3XJsByJr/NUbj6e6B7z9NuYRb8b4VMaYwhDWrA==
X-Received: by 2002:a05:6a21:3a81:b0:1a3:1972:450e with SMTP id
 zv1-20020a056a213a8100b001a31972450emr5240887pzb.50.1710239622685; 
 Tue, 12 Mar 2024 03:33:42 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 fa11-20020a056a002d0b00b006e583a649b4sm5723553pfb.210.2024.03.12.03.33.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 03:33:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 20:33:36 +1000
Message-Id: <CZRPCHNB3S83.1VJ8G0807KUPS@wheely>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "David Gibson" <david@gibson.dropbear.id.au>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Benjamin Gray"
 <bgray@linux.ibm.com>
Subject: Re: [PATCH 06/13] ppc/spapr: Add pa-features for POWER10 machines
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-7-npiggin@gmail.com>
 <020a53d8-3b90-4b30-b0c7-862951fbef43@linaro.org>
 <ef4c48d1-9e11-d6af-d4cc-3ae6c567f098@eik.bme.hu>
 <CZRI248HGG4Y.2KVSZ18AGD6CA@wheely>
 <17ed9bd3-61ed-a7f4-4ecb-5990ab585539@eik.bme.hu>
In-Reply-To: <17ed9bd3-61ed-a7f4-4ecb-5990ab585539@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue Mar 12, 2024 at 7:59 PM AEST, BALATON Zoltan wrote:
> On Tue, 12 Mar 2024, Nicholas Piggin wrote:
> > On Tue Mar 12, 2024 at 7:07 AM AEST, BALATON Zoltan wrote:
> >> On Mon, 11 Mar 2024, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> On 11/3/24 19:51, Nicholas Piggin wrote:
> >>>> From: Benjamin Gray <bgray@linux.ibm.com>
> >>>>
> >>>> Add POWER10 pa-features entry.
> >>>>
> >>>> Notably DEXCR and and [P]HASHST/[P]HASHCHK instruction support is
> >>>> advertised. Each DEXCR aspect is allocated a bit in the device tree,
> >>>> using the 68--71 byte range (inclusive). The functionality of the
> >>>> [P]HASHST/[P]HASHCHK instructions is separately declared in byte 72,
> >>>> bit 0 (BE).
> >>>>
> >>>> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> >>>> [npiggin: reword title and changelog, adjust a few bits]
> >>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>>> ---
> >>>>   hw/ppc/spapr.c | 34 ++++++++++++++++++++++++++++++++++
> >>>>   1 file changed, 34 insertions(+)
> >>>>
> >>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>> index 247f920f07..128bfe11a8 100644
> >>>> --- a/hw/ppc/spapr.c
> >>>> +++ b/hw/ppc/spapr.c
> >>>> @@ -265,6 +265,36 @@ static void spapr_dt_pa_features(SpaprMachineSt=
ate
> >>>> *spapr,
> >>>>           /* 60: NM atomic, 62: RNG */
> >>>>           0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> >>>>       };
> >>>> +    /* 3.1 removes SAO, HTM support */
> >>>> +    uint8_t pa_features_31[] =3D { 74, 0,
> >>>
> >>> Nitpicking because pre-existing, all these arrays could be static con=
st.
> >>
> >> If we are at it then maybe also s/0x00/   0/ because having a stream o=
f
> >> 0x80 and 0x00 is not the most readable.
> >
> > Eh, it's more readable because it aligns colums.
>
> Not sure it you've noticed the 3 spaces before the 0 replacing 0x0 that=
=20
> would keep alignment.

Oh, yeah I guess that would be a more obvious zero rather than hunting
for 8s. You're right.

> But it's not something that needs to be changed just=20
> commented on it as it came up but I don't expect it to be done now on the=
=20
> day of the freeze. It's more important to get the already reviewed and=20
> queued patches in a pull request to not miss the release. So this comment=
=20
> is just for the fuuture.

Yeah we should rework it completely. Anyway thanks for taking a look.

Thanks,
Nick

