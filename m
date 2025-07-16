Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DE9C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 08:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubxNs-0007jW-Rz; Wed, 16 Jul 2025 04:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ubxLp-0005Aq-Rl
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 04:18:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ubxLn-0001hp-AI
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 04:18:53 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4550709f2c1so33730645e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 01:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752653927; x=1753258727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=JN7FEf+8t7oiq29+zDIIL6o3/QvSrm2WtDIlELOr9do=;
 b=GRHb0CMtOrJYC8yHG1OHw4yixXf+Y6rz6NevBfvVYuxiCUxf+Owv1doF49M/XW3hgK
 0i5eS24216o/lUdxjWCFuAMAl5ChvrZ7vhM7M96/DAFRNHLjlfgPHDETsQrji48cd7wh
 XlarvUWr6lMuZl9CW56XsyOZ5G/DHSRx3Znm9lUoWMan00d1k+c8EBTSxYeZjfzL2hjn
 T16uf8XmNZFpqzPcc2dLD6rwOHGJSI8OVkbXUkfZh6rWtUbIwWRU2DpY1suRFykstFlE
 qdUq/xRxgPxoq9vwvqJiFKa4LZdJ4sesKR7jsYZBRGjkCwpzi8xXYpPo+0P3P8v7pGXZ
 EuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752653927; x=1753258727;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JN7FEf+8t7oiq29+zDIIL6o3/QvSrm2WtDIlELOr9do=;
 b=LIIAvljO8NyjGoo0mZJWNuXOH7vaJe4C9KlD+f2QbWDWJaj0lyashb7a5jPAyCRzXi
 +Clus4sKwMhyaQIpRusGIoqo2DwVSrE7NqDe3MHa3+i+5rjjU6OVLTe1jh9KqtwPugf2
 qFosM4G+neP+54vLaFWXzAuPqDM8HzARt+GGPNk4f0eW0ooXfmaEfw7XTBqDIJiPN0cg
 NvGinINBNaE5wwdRxfAmTQxDS/GvMu71Ng8YJni2sdE2pkA5i4bgj3IOxxx+Dr1lxedX
 o552zTBeHM+YZmbAhN9UfU9euQvs5IbmQGp+eFdqG+/R1G6nM9e8NIoz4evx6YrDTd7E
 8t1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqiihBLlXfmmWCiDaZMEDhMNNwKaTxk2pbW89G8+bpD3mhQh5eQ0Qk2Wk7jSwbglHQ5Cr3HFcudNr3@nongnu.org
X-Gm-Message-State: AOJu0YySu+fbUUv0ptdpXxEOumqRoDltm/6q7dfn/GiV/pPZV6A++ios
 +9QHIJBOBkGLHz+DFrUrIPQGqckFcQ++fDLJfppKUqd1CZb/t/JeZeZSfPKoqg==
X-Gm-Gg: ASbGnctr/QC1t/mvnw07mvduhVdAny4fFNzxZ0RxMbnWOwZ4DFZko636vTDyE3/Dzax
 aJ7U3Pc4jUoZI2kE0+3XD4PCuRve3Kbcx+P9paqXRJwwMn92RHVqoV7IR5fdOoxNa4183qJkQhd
 DzrG2TMWHKmscqg3fMxSZtQo4FvwDLbb+YJ4VvaI6yI3qv3rzDQBiPvbfu6Zy1NdJTSz/H8jtYW
 G1AFvVu4inZNJUfRQtUfxqR4iSp5vUKEY9ovV3WMGCB0rDUovE7QQlmM/x6T5K1znFxw/Mub9pg
 xeEZsnH6YjZubxFgLnPa/4XwN6ShV2ep9q1gyGigh43wBE037ZU2vKvxpuzSIaBjItUFrnM1k1Z
 ZKjHSkO/Wy8GRc2K/
X-Google-Smtp-Source: AGHT+IHWBxMY9/ImA68wMvU9e/OuhodsjNYg9RV34i9DorzI/0q1Od6LGiig0SYCJ5swlJenkKZ+YQ==
X-Received: by 2002:a05:600c:674a:b0:450:d4a6:799e with SMTP id
 5b1f17b1804b1-4562e275dedmr14873155e9.20.1752653926913; 
 Wed, 16 Jul 2025 01:18:46 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e88474fsm13476375e9.22.2025.07.16.01.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 01:18:46 -0700 (PDT)
Date: Wed, 16 Jul 2025 08:13:09 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] meson: Add most 3rd-party includes as system includes
In-Reply-To: <aHZbZN4MIKL7-pu6@redhat.com>
References: <20250617203435.41490-1-shentey@gmail.com>
 <CAFEAcA_cfg5je7Nx-qsQoB=cY7KRYan1+wXhWztoLydnjpg15Q@mail.gmail.com>
 <aHDuyBl4rc4eWvIn@redhat.com> <aHZbZN4MIKL7-pu6@redhat.com>
Message-ID: <29215B68-1090-4D85-A710-67CBB3317430@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
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



Am 15=2E Juli 2025 13:45:08 UTC schrieb "Daniel P=2E Berrang=C3=A9" <berra=
nge@redhat=2Ecom>:
>On Fri, Jul 11, 2025 at 12:00:24PM +0100, Daniel P=2E Berrang=C3=A9 wrote=
:
>> On Fri, Jul 11, 2025 at 11:45:08AM +0100, Peter Maydell wrote:
>> > On Tue, 17 Jun 2025 at 21:35, Bernhard Beschow <shentey@gmail=2Ecom> =
wrote:
>> > >
>> > > When compiling QEMU against fuse3-3=2E17=2E1 with --enable-werror t=
he build fails
>> > > with:
>> > >
>> > >   In file included from =2E=2E/src/block/export/fuse=2Ec:33:
>> > >   /usr/include/fuse3/fuse=2Eh:959:5: error: redundant redeclaration=
 of =E2=80=98fuse_main_real_versioned=E2=80=99 [-Werror=3Dredundant-decls]
>> > >     959 | int fuse_main_real_versioned(int argc, char *argv[],
>> > >         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> > >   /usr/include/fuse3/fuse=2Eh:885:5: note: previous declaration of =
=E2=80=98fuse_main_real_versioned=E2=80=99 with type =E2=80=98int(int,  cha=
r **, const struct fuse_operations *, size_t,  struct libfuse_version *, vo=
id *)=E2=80=99 {aka =E2=80=98int(int,  char **, const struct fuse_operation=
s *, long unsigned int,  struct libfuse_version *, void *)=E2=80=99}
>> > >     885 | int fuse_main_real_versioned(int argc, char *argv[],
>> > >         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> > >   cc1: all warnings being treated as errors
>> > >
>> > > That is, a fuse header triggers a warning within itself=2E Since QE=
MU adds the
>> > > fuse3 include path via `-I`, the compiler thinks that the header is=
 part of the
>> > > QEMU project, and thus raises a warning=2E The compiler can be told=
 to ignore
>> > > warnings within 3rd party headers by adding these paths via `-isyst=
em`=2E Fix the
>> > > above build failure by marking fuse as system dependency=2E While a=
t it mark
>> > > every 3rd-party dependency as system dependency to prevent similar =
issues in the
>> > > future but skip glib since that results in glib include paths to be=
 omitted from
>> > > bindgen in case of a Rust build=2E
>> >=20
>> > The problem with this is that -isystem does not only do "suppress
>> > warnings in these headers" -- it also alters the search order
>> > for includes, in a way that can sometimes cause problems:
>> > https://gcc=2Egnu=2Eorg/bugzilla/show_bug=2Ecgi?id=3D70129
>> > So this isn't completely risk-free, though I think meson tries to
>> > avoid some of this by doing something a bit more complex than a
>> > pure 's/-I/-isystem/'=2E
>> >=20
>> > We would also lose the warnings about e=2Eg=2E use of deprecated
>> > functions in our dependencies=2E
>> >=20
>> > All that said, this might still be the best tradeoff=2E
>>=20
>> FWIW, the actual bug mentioned here is a clear regression & mistake in
>> libfuse3 3=2E17=2E1 only, that they really should fix=2E I've filed thi=
s:
>>=20
>>   https://github=2Ecom/libfuse/libfuse/issues/1282
>>=20
>> and will likely send a PR too later=2E
>
>The issue turned out to already be fixed in libfuse git master=2E So give=
n
>that the problem only appears in one single release, IMHO, the best thing
>is to ignore it=2E Any distro which ships the broken libfuse should eithe=
r
>update it, or cherry-pick the trivial header file bugfix from git=2E

The idea of this patch is also to insulate ourselves from similar issues i=
n the future=2E Moreover,  `-isystem` might be helpful in other ways, such =
as for static analysis tools=2E For example, clang-tidy ignores any issues =
caused by headers included via -isystem=2E So IMO this patch is still worth=
 for consideration (but I'm not attached to it)=2E

Best regards,
Bernhard

>
>
>With regards,
>Daniel

