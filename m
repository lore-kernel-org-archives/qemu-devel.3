Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E96C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBY4P-0008Uf-HA; Mon, 27 May 2024 06:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBY4O-0008UU-3a
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:59:12 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBY4M-0002sT-4z
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:59:11 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f45cso2997024a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716807548; x=1717412348; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOf94eJ3W6fFEPzLoRniF7hxb30OpWzIIE5gtOSRrFs=;
 b=FU3EXF74bfP7J2K8/eE9w5/Bxcd1ii/77rte1VdxYm3wCeE59w+D5dTodX+N/vwU29
 lMFpbS5AH7AnqtE7EoHPzHqND4sC5aipRwWyO/7jHHey+sfLuKuH/FtMuW0cyE1xT9V1
 Lg+vkRfMgyMIIbx50mlVcS0l4z0dlxBpvfAXYAwjicFdCAM6vPmo9gci5x+QvWgDEGxs
 og8ba+wtk1zYH4VZE8nelGBUdlaavb2vmPRRItJp7pwOFqncLivLDUeHcihVcpk7LDu2
 RXG7XnUCPomBd74kwArp2soYpg4x2WBfyCqVN1ria+DWLSCh7pRniSk17wHrC1FT2L3l
 Ltkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716807548; x=1717412348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOf94eJ3W6fFEPzLoRniF7hxb30OpWzIIE5gtOSRrFs=;
 b=sTgr4Gptt5QA4rbq31uqNrCtQESwxsPfZXFsY0znwFgY03zrG48TalyFs7aNUSPKvH
 /Su2dGEvLwl2HxOppnn2qLZVbce+Gi+/45M7AE/CTAmDdo/+ReKwjK8LEe5vwkPss4nU
 +Ncjv505RFr7sX+mJG+E+s98ZDVate56xr6TpC8eKNbZ479LKih49nJ3xdtm5UVZzj3D
 XBF137Pnd1Ss20w+wQfL9oEv+WCd8ABGQUMVZTOWra+LOJ2NWn06ohmAD2gzvYrVt8Sg
 xPsXjkNpsGNJ7eZrqNRevIRD5DufeExtreGkYXFugiV8pCa2a/OubX4IvOW4hhgbmlUP
 MpWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAGT49deFwgxrSYVh/wk0ccSPw0TEwN58dsK1beqafUzePtos6LFh9eTBl6k789pOBbnQgYUGSWT3jUAQWhtwD2AGLKoQ=
X-Gm-Message-State: AOJu0YwPuLNyXNT6e4bkY6IhTLykucJ4p6ARQ3wu11dG6b+cMIKxa3SH
 eyMKNHz4I2OXZkHquU0Ul/GdPIbNOFxHYP/+hSl0IryiFkXJF0eG6iTWM10fmj7142sxnTDd5X7
 tAD8BeTHtEMIr8NuDjUwxWqG0J+CVkFzyZGO20A==
X-Google-Smtp-Source: AGHT+IHJ+cD9T44OKVqayhBw37O3HVvS2IqrTwMx+fTAcfidX0vpqFHSC1NaJPEEYXpoWL1wrXzc5/drA4H22oxJp8w=
X-Received: by 2002:a50:cc47:0:b0:572:6cd5:f8d with SMTP id
 4fb4d7f45d1cf-5785195cd1dmr6161900a12.22.1716807547555; Mon, 27 May 2024
 03:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
 <C875173E-4B5B-4F71-8CF4-4325F7AB7629@gmail.com>
 <72ED7A80-9EA7-4FF6-BE29-9583587985C7@gmail.com>
 <f6976b40-e3d5-4157-8597-ce7db6ceb068@linaro.org>
In-Reply-To: <f6976b40-e3d5-4157-8597-ce7db6ceb068@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 May 2024 11:58:54 +0100
Message-ID: <CAFEAcA-BD1TmaBB_5ephnRoNsOCWsS4w3C_oj0P_182+fOLPUQ@mail.gmail.com>
Subject: Re: [PULL 17/20] target/arm: Do memory type alignment check when
 translation disabled
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 27 May 2024 at 03:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/25/24 13:50, Bernhard Beschow wrote:
> >
> >
> > Am 25. Mai 2024 13:41:54 UTC schrieb Bernhard Beschow <shentey@gmail.co=
m>:
> >>
> >>
> >> Am 5. M=C3=A4rz 2024 13:52:34 UTC schrieb Peter Maydell <peter.maydell=
@linaro.org>:
> >>> From: Richard Henderson <richard.henderson@linaro.org>
> >>>
> >>> If translation is disabled, the default memory type is Device, which
> >>> requires alignment checking.  This is more optimally done early via
> >>> the MemOp given to the TCG memory operation.
> >>>
> >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>> Reported-by: Idan Horowitz <idan.horowitz@gmail.com>
> >>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >>> Message-id: 20240301204110.656742-6-richard.henderson@linaro.org
> >>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1204
> >>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >>
> >> Hi,
> >>
> >> This change causes an old 4.14.40 Linux kernel to panic on boot using =
the sabrelite machine:
> >>
> >> [snip]
> >> Alignment trap: init (1) PC=3D0x76f1e3d4 Instr=3D0x14913004 Address=3D=
0x76f34f3e FSR 0x001
> >> Alignment trap: init (1) PC=3D0x76f1e3d8 Instr=3D0x148c3004 Address=3D=
0x7e8492bd FSR 0x801
> >> Alignment trap: init (1) PC=3D0x76f0dab0 Instr=3D0x6823 Address=3D0x7e=
849fbb FSR 0x001
> >> Alignment trap: init (1) PC=3D0x76f0dab2 Instr=3D0x6864 Address=3D0x7e=
849fbf FSR 0x001
> >> scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 A=
NSI: 5
> >> fsl-asoc-card sound: ASoC: CODEC DAI sgtl5000 not registered
> >> imx-sgtl5000 sound: ASoC: CODEC DAI sgtl5000 not registered
> >> imx-sgtl5000 sound: snd_soc_register_card failed (-517)
> >> Alignment trap: init (1) PC=3D0x76eac95a Instr=3D0xf8dd5015 Address=3D=
0x7e849b05 FSR 0x001
> >> Alignment trap: not handling instruction f8dd5015 at [<76eac95a>]
> >> Unhandled fault: alignment exception (0x001) at 0x7e849b05
> >> pgd =3D 9c59c000
> >> [7e849b05] *pgd=3D2c552831, *pte=3D109eb34f, *ppte=3D109eb83f
> >> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x00000=
007
> >>
> >> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x00000007
> >>
> >> As you can see, some alignment exceptions are handled by the kernel, t=
he last one isn't. I added some additional printk()'s and traced it down to=
 this location in the kernel: <https://github.com/torvalds/linux/blob/v4.14=
/arch/arm/mm/alignment.c#L762> which claims that ARMv6++ CPUs can handle up=
 to word-sized unaligned accesses, thus no fixup is needed.
> >>
> >> I hope that this will be sufficient for a fix. Let me know if you need=
 any additional information.
> >
> > I'm performing a direct kernel boot. On real hardware, a bootloader is =
involved which probably enables unaligned access. This may explain why it w=
orks there but not in QEMU any longer.
> >
> > To fix direct kernel boot, it seems as if the "built-in bootloader" wou=
ld need to be adapted/extended [1]. Any ideas?
>
> I strongly suspect a kernel bug.  Either mmu disabled or attempting unali=
gned access on
> pages mapped as Device instead of Normal.

The MMU surely must be enabled by this point in guest boot.
This change doesn't affect whether we do alignment checks based
on SCTLR.A being set, so it's not a simple "the bootloader was
supposed to clear that and it didn't" (besides, A=3D0 means no
checks, so that's the default anyway). So the failure is kind
of weird.

-- PMM

