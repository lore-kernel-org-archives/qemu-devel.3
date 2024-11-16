Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69411D68BF0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2024 21:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCQff-0002A4-C6; Sat, 16 Nov 2024 16:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tCQfd-00029H-Ru
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 16:49:33 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tCQfb-0001Vu-2k
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 16:49:33 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso569413766b.1
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2024 13:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731793769; x=1732398569; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1F9zdRoKsUu5zPMH8J+dMjv84QztGXv+9RWvY9Lye2s=;
 b=YQBAqkvXtGI5VvmYP7MBCoxiBd3z+H4yY7v54SWVNKmNofOO9rgi/FhOwdV2+Ar5xi
 h2lMdQ+uGOM7Tf84GZwv5m6lquONU88F9Z/oNiS33n27Rvubve35wB0T0Dql2qUkgBiE
 cmwfMG1BZn9oekqmWE368Kg4rQwDRnbcmm5SNR2OCZrY/04KA++Xvi+cN2cqcD9UdysV
 8A49XSNCYVyMPAo+VQjHcrXALLUZBD2o37FGqdFETYSix3Zs/qv4RSPpNPmVIboyOiuT
 maiIcoDayGxFFFOx7HDia1YO9A7z2+p8P7AVmf0Wx6oIk06r/p13yHVmYOauoUBAexhu
 78Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731793769; x=1732398569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1F9zdRoKsUu5zPMH8J+dMjv84QztGXv+9RWvY9Lye2s=;
 b=wLPhcMvpL/Gu5H2wUuqS1gI7aAuHVzM7xp2tUCf96OeVzfRmBtrlgqL0GD29dBJSpb
 c6tBTEGYuPPRqCXF1ZIzE2rddS6+kF3MtT6N5n8f0ESCo4Uj9Z/o85KjJCBBV6Ve11Np
 0Gs1srX1rMbSjd+2plJjTjlOwLv3JL99o3DjNdVGIegyGaKU05ysuckDVlondFU4oiad
 X1a/Zrwy9PfVMi75aJK+mMFj9pth8oyA7j+axjR2P6iDR/Re5EZoyb3+fbGYKT1vXjER
 wB/V4cFxiD/rQajtf0MrZ2b8RJjRk1KAw4PB262DIqR8EMx7Phbx7R5DZri/bhui5xsL
 kg4w==
X-Gm-Message-State: AOJu0YwcqANggsReU2DLKYaFJmFs9kXFmlEuP8/OiT7/+zdAOQUWUGw+
 zmquKG49+LyeLiLir2vsLNUb4mZqTyJRxkuC6iYc/eJozSyypcDa1KGf1Hj+d4s9JzvVdQHpYIO
 s1r+ora18TPfd8xhVBVJoAv9sjfj2vSbUOeWdrA==
X-Google-Smtp-Source: AGHT+IGWpcdmm6OgXJahFIA8EpOPwogqZ0PduvIjW+BkVl7pq6Ur3ZXhnj2JOkaOiJYLxwQNW1DuYMZKYxYOzuy11Zk=
X-Received: by 2002:a17:906:1c0e:b0:aa4:9ab1:19d5 with SMTP id
 a640c23a62f3a-aa49ab11b5dmr212192866b.42.1731793768916; Sat, 16 Nov 2024
 13:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20241116181549.3430225-1-manos.pitsidianakis@linaro.org>
 <7d835e14-c3d4-4aba-b4a9-eeb06f56fdde@redhat.com>
In-Reply-To: <7d835e14-c3d4-4aba-b4a9-eeb06f56fdde@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sat, 16 Nov 2024 23:49:03 +0200
Message-ID: <CAAjaMXZxcT-+iJDpbSbFWuTF_Ci1iAgOUHLSbngR8rB9w2W5qQ@mail.gmail.com>
Subject: Re: [PATCH v1] rust/pl011: Fix DeviceID reads
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Nov 16, 2024 at 10:24=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On 11/16/24 19:15, Manos Pitsidianakis wrote:
> >   impl DeviceId {
> > -    const PL011_ID_ARM: [c_uchar; 8] =3D [0x11, 0x10, 0x14, 0x00, 0x0d=
, 0xf0, 0x05, 0xb1];
> > -    const PL011_ID_LUMINARY: [c_uchar; 8] =3D [0x11, 0x00, 0x18, 0x01,=
 0x0d, 0xf0, 0x05, 0xb1];
> > +    /// Value of `UARTPeriphID0` register, which contains the `PartNum=
ber0` value.
> > +    const fn uart_periph_id0(self) -> u64 {
> > +        0x11
> > +    }
> > +
> > +    /// Value of `UARTPeriphID1` register, which contains the `Designe=
r0` and `PartNumber1` values.
> > +    const fn uart_periph_id1(self) -> u64 {
> > +        (match self {
> > +            Self::Arm =3D> 0x10,
> > +            Self::Luminary =3D> 0x00,
> > +        }) as u64
> > +    }
> >
> > +
> > +    /// Value of `UARTPeriphID2` register, which contains the `Revisio=
n` and `Designer1` values.
> > +    const fn uart_periph_id2(self) -> u64 {
> > +        (match self {
> > +            Self::Arm =3D> 0x14,
> > +            Self::Luminary =3D> 0x18,
> > +        }) as u64
> > +    }
> > +
> > +    /// Value of `UARTPeriphID3` register, which contains the `Configu=
ration` value.
> > +    const fn uart_periph_id3(self) -> u64 {
> > +        (match self {
> > +            Self::Arm =3D> 0x0,
> > +            Self::Luminary =3D> 0x1,
> > +        }) as u64
> > +    }
>
> If I understand correctly, these are two reasons why you did not go with
> the simple adjustment to the Err(v) pattern:
>
> * the separate registers match the datasheet more
>
> * given the bug that you are fixing in the write function, you want to
> avoid duplicating "Err(v) if (0xfe0..=3D0xffc).contains(&v)" between read
> and write; instead, you rely on exhaustive enums for error checking.
>
> I wonder if we can keep these improvements while making the
> implementation a bit more concise...  The eight const getter functions
> are quite verbose, and having the device type match inside each function
> is repetitive and hard to verify.  Maybe something like
>
>      const UART_PCELL_ID: [u8; 4] =3D [0x0d, 0xf0, 0x05, 0xb1];
>      const ARM_UART_PERIPH_ID: [u8; 4] =3D [0x11, 0x10, 0x14, 0x00];
>      const LUMINARY_UART_PERIPH_ID: [u8; 4] =3D [0x11, 0x00, 0x18, 0x01];
>
>      /// Value of `UARTPeriphID0` through `UARTPeriphID3` registers
>      const fn uart_periph_id(&self, idx: usize) -> u8 {
>          match self {
>              Self::Arm =3D> ARM_UART_PERIPH_ID,
>              Self::Luminary =3D> LUMINARY_UART_PERIPH_ID,
>          }[idx]
>      }
>
>      /// Value of `UARTPCellID0` through `UARTPCellID3` registers
>      const fn uart_pcell_id(idx: usize) -> u8 {
>          Self::UART_PCELL_ID[idx]
>      }
>
> could be the best of both worlds?

Eh, there's no real reason to do that though. I prefer verbosity and
static checking with symbols rather than indexing; we're not writing C
here.

>
> >           match RegisterOffset::try_from(offset) {
> > +            Ok(PeriphID0) | Ok(PeriphID1) | Ok(PeriphID2) | Ok(PeriphI=
D3) | Ok(PCellID0)
> > +            | Ok(PCellID1) | Ok(PCellID2) | Ok(PCellID3) =3D> {
> > +                // Ignore writes to read-only registers.
> > +            }
>
> This is indeed an improvement over the patches that Junjie and I had
> sent, because the writes would have gone down the eprintln! path.

I will send a v2 to print them anyway as guest errors like Peter requested.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

