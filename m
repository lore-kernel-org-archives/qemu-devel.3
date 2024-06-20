Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188ECC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 19:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKN9q-0008Dm-Vf; Thu, 20 Jun 2024 15:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKN9p-0008DM-S5
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:09:17 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKN9o-0001Ho-Cf
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:09:17 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57d0f929f79so1120946a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718910554; x=1719515354; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5nVyXDg0lnuM8PhwcEGIj1IPhGbZVZ9uPKkh932dzY=;
 b=FCb8PCt1XV7wYDd4pOTNKh2YNI5w9UROZV91HapuKT0ovf6p9mfBBjpT97/X1R8AJM
 ad+ooyEZilnqLghchdq1HE79QZ5ZRYqmWlWi9SPoS9AJsRi8JHTRrv6xBZ6uL1qd6T5h
 qDYowv8iRfsarzIUCKZJNltCyd3Ld1RsOGkTjN9SpAWM+mAuRg22nGm7PMB2LJdJoA7Q
 HNYbwmVmD9MNTsKZm7OfYWgLd/ik9sPx35HQ3rxL4Qgc+DmcGYqPkKMNPB31bpk7voYr
 YEuLhVTSlK/OmSYLJvZ7bOsrd4+VZHicTG1kjgOS/DzTZmksqEF2UOLnRoqoTHFDwiEj
 NYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718910554; x=1719515354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P5nVyXDg0lnuM8PhwcEGIj1IPhGbZVZ9uPKkh932dzY=;
 b=LyCCPmmbrROJnczBsN4nbKTPQszQq4hCIjiAKiuLx1gT3O1kvp7KiJW50nUQZGnxrA
 uNLxGPmxHTk7C/pkiPegQtm9reidfnpOAEAmGRU3k7+j23+y6FDGtHowrvM6/2nN4cgL
 H/3YjpXZYqGu70weeCUP5ZrmUf2ar42ibCpWO1Q1JpYID8uJ3DD2DbKtE03m8BmDJ/lQ
 vP0J8p2SyhT2KGI3G2ZUjgv+vLHYG94vWVBNxsUFtRuQ+Mpwtz1n/NWAYsw3VxBVWnJ8
 HP/woGaUDlp/GqDsKQoJSrb/3UNoMcDAnHX/u1jMPBm7pU6+WV7JP1qmzkbquOCEAkGW
 k/5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgqE1I0QSymjWLEPv2nJJpuRQnBc6EgkAHIGjgmQD+EJURDk7xC8KWI8qO44vMg/Otq6oripu8bCuz1v6fCQZbkDDl+V4=
X-Gm-Message-State: AOJu0YwQCPnYMsMs6yFbH4vqFPh0DJR0Uc4sHIm4pZzaU/AOyw7pjGrn
 94JNBUk+/jtmsNiY76xMLfacMqb6dcpJEbUJeFQ7lKZ3KWPqIfFiBWQmpl4w9H2hcV2Uil6JDwz
 SRpnza+2bbJpl45SF3+vTeZHKDpr5tHVi8z41sQ==
X-Google-Smtp-Source: AGHT+IFlxX3kOwZ6lXFRf59jmk8JpY9xvQmTH517K1mSEdadeGjlBQpdAS1gTJXvXmq1BwrblFNQhOIUo74tEgBzeIU=
X-Received: by 2002:a50:9e6c:0:b0:57c:713c:cdbf with SMTP id
 4fb4d7f45d1cf-57d07ec59b0mr4255927a12.38.1718910554432; Thu, 20 Jun 2024
 12:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240618224604.879275-1-rkir@google.com>
 <495d3ddc-ce73-4ef5-badd-16ed61f9a5aa@linaro.org>
 <ZnKRLj3usYxmAIOE@redhat.com> <87le2zbqfx.fsf@draig.linaro.org>
 <CAOGAQeov7kwbopVPyVZwS3mYvWqMb_0=K4te09ENdtg-P7M23g@mail.gmail.com>
In-Reply-To: <CAOGAQeov7kwbopVPyVZwS3mYvWqMb_0=K4te09ENdtg-P7M23g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jun 2024 20:09:03 +0100
Message-ID: <CAFEAcA-Mh-kVB57jWWwS_0RexnvFzNLLiHjxZJKOm49YHwXSgQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] exec: use char* for pointer arithmetic
To: Roman Kiryanov <rkir@google.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 jansene@google.com, mett@google.com, jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 20 Jun 2024 at 17:24, Roman Kiryanov <rkir@google.com> wrote:
>
> Hi Daniel and Alex,
>
> On Thu, Jun 20, 2024 at 8:10=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
> >
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> > > NB, QEMU is explicitly *NOT* targetting the C standard, we are
> > > targetting the C dialect supported by GCC and CLang only. IOW,
> > > if they have well defined behaviour for arithmetic on void *,
> > > then we are free to use it.
> >
> > It looks like GNU C does support it:
>
> GCC does support void* pointer arithmetic as an extension. But if you
> decide to use other compilers, you might not have the same luck. We
> (and maybe other developers) would like to use the QEMU headers with a
> C++ compiler where this extension is not available.

I think this is the point where I would say "you're making the
code worse for upstream and the only benefit is to your out-of-tree
downstream code". If you want to build QEMU, use one of the compilers
that QEMU supports. There are lots and lots of places where we
assume the GCC-or-clang feature set over and above plain C.

thanks
-- PMM

