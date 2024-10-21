Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DECD3C934
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 01:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2h0n-0003OZ-1j; Sun, 20 Oct 2024 21:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2h0m-0003O8-2E; Sun, 20 Oct 2024 21:15:08 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2h0k-0004r1-G7; Sun, 20 Oct 2024 21:15:07 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-851d6c397bbso948469241.2; 
 Sun, 20 Oct 2024 18:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729473305; x=1730078105; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lx+Pmauu0pkSGIhAZAZND03CZOjTZa08r5b8h3DxCj0=;
 b=kT6FZSuJCXDoYo/leYRm60vCPYnGfM0cq6g0YEV/pnL2216gDXiDWsBHqfzXbJNulF
 62EgJFk3m9EYYFJSplI+KcyOfBrm6G1dXIAoPIfh/OTF3hAQUPi20w46G381SQ0Qh7Zx
 C2f66FKjLT8ZR02hdJNussx3ZIJsqro83Im/Acjn+BcA5w84TahSDb3Fbvq5tRPTB1dr
 uLGmZyg5ADhCsXhaQ8A6//FqouCEiUJuMUnUdI3F6AAYNS/VqTaz4w90FlH6sjelSs5P
 38EPYXRY+rzVPiTedzxqkvqAA52gzXxslYOcxD1ZwUAAuIC3i+1R3gftpiMvkMcby1Hw
 Obbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729473305; x=1730078105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lx+Pmauu0pkSGIhAZAZND03CZOjTZa08r5b8h3DxCj0=;
 b=EUWaB9CwXeguLtb9lfI9RUzsTQbyO+L5ZxZzEVhbHZpfdHXjbQpxoJAonPiQE38D8O
 6D7JfF8w17nTH4+M621SHdibK/XCjhRutk/pfxLCHkH9IfOW7e1pS4iBpL3lLFhsDtJa
 jIvebdchQt1TM04MYCEGTGwSV9W7B/k2O6k1i33cEOJbhCafKtOVCVp5a71culVaXvCc
 w6GA9stg76SJCaiPeNOsJk3H+txN8GV8v8stiSerWxi5mLTGI1U8InwUEqkK3WhzHv7g
 eEgRk/+SIulByYtzufgHAZv6vl6ULSzef7xQUcVBe4WHxAD4doTOfEOnt9qsJRgy1Toa
 iNaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRT5nqZMjbfdY4TIloDXBwTUIobfxiVuDd35OkAT3jvVKh9PJIwnuSPm9pGaqr99dAhHFaWPlu09Xo@nongnu.org
X-Gm-Message-State: AOJu0YzxV3ZuIfqfxvBqeoKmSm1I+BRC86Wus37/N45Om0XXH+jaB8Cl
 VkvsEmMalQ3Xp1pDTD9kehnSspQEb3agadODT9ysfEWIgXnbEvrF/Bk+DYUwiHcZjWAEKccTAGi
 iBtK67t10BxqS+yFLmwBE38MSFxc=
X-Google-Smtp-Source: AGHT+IHbv6B7uMHBYD/cxRjODVqamhEenrV4nkJ5WFDcUhbynwjzMy6fLu4WHZ+Gxs/4OxpUXgeht+AkBXxrfGRSADg=
X-Received: by 2002:a05:6102:3913:b0:4a5:b0d3:cbbe with SMTP id
 ada2fe7eead31-4a5d6a8c763mr7388918137.1.1729473305000; Sun, 20 Oct 2024
 18:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241017145226.365825-1-cleger@rivosinc.com>
 <20241017145226.365825-10-cleger@rivosinc.com>
In-Reply-To: <20241017145226.365825-10-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 11:14:39 +1000
Message-ID: <CAKmqyKMGBZrQFRze-UMZ51=T=o2ROgTBTq3zrOnMENhQvS0owA@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] target/riscv: Add Smdbltrp ISA extension enable
 switch
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Oct 18, 2024 at 12:55=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> Add the switch to enable the Smdbltrp ISA extension.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 15b21e4f7d..1323effdae 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -183,6 +183,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
> +    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
> @@ -1506,6 +1507,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
>
>      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
> +    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
>      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
>      MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> --
> 2.45.2
>
>

