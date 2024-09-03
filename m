Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B5ECD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 09:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slPih-0008Mw-Co; Tue, 03 Sep 2024 05:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slPiZ-0008JK-Ne
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 05:21:00 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slPiX-0003vY-C2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 05:20:55 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53349d3071eso6728828e87.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725355250; x=1725960050; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlyPlv8NDt/sIcafW5MZoI6cCy074VTWfgoEBl6f+bQ=;
 b=NZa3Emczn448Y9zfsi06Wmxj5Jl9RhiImkRKVsEdhm4QMhgc2lreaGgbto/KDCjLEu
 Lce0DI2e4iPsDtyiTkTqrxBiKgynNmTCt3ZrvKQksSoZIoXpH+rRYgNbys1oCDvAbuWV
 ocO5GIY/36TmWgoyxi7H6kNap3gbGgrYPidNO/fBQOwJ8c5MLzuNgma7bRLOsK8WegJ4
 W1mhKXmK/vfAoAOPxsIfTLQr878K3XKZ3QXIAEc2CKsOVbUFoldvWcF+Q/DMuReW/tcc
 wowIx9AmJywp2KwdLcP5k0LvMfGqa1iK7SWNmYLeEjKys1FVCbGtwqJKf8BKdXw1mMAS
 DIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725355250; x=1725960050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LlyPlv8NDt/sIcafW5MZoI6cCy074VTWfgoEBl6f+bQ=;
 b=L2CDomPinAt2np8Nj1XOWad1gZrmSwf1NCzWHTEEhlcQOdYiarEeffmn+VvawSVWYc
 /7Wes67ZFtV1sQJEeNivlV6K5ylQmb63EQrX+fVubPk3UWKKiPOKAB4Gm0+gkJDwQGpN
 IVe2EaO0iZouCQ+5uSDOmsmn8/pl+Ca+DVjvqROAdO8+kkIfsmTI8SsjYloSn2W5f4ry
 +mHUOq6pO5DmckmkOjKLZBnlR5r7lTYmw7q1FkYCryqU6RG2CN8hgjmkHh+a2HjeyuNR
 mNnd9IBR9BEXU+CFHcVfj2UDo6o41AvMOATEtwmiCB75Aq1HT/gz4Ruog7hjCVi4jB0C
 4lyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzLc27R9587Tfyx9HUmaIYxIzqXvktjf/9jFq/i9TFg01IXAAYQWxDjoAAeAtnSzGq7ehosvI0lFNW@nongnu.org
X-Gm-Message-State: AOJu0YzWk0RiKwkGCp4wZxiiOLN2EBAF3i+b7Ect3YLs4IekvYw0RdCm
 M5Mmv/PnAa7CCchaivUeEp1R0DN5Zd21VjaQhiZ8U0Dz+wFXbEtGu16cc0bWnFPT8V+yhDuUuJk
 hv8oUHsyXvoVrqOht6zbtJbRWd+GhWnNzfCTKPw==
X-Google-Smtp-Source: AGHT+IERZ1LAqyx0epLV3gOPAhlbxsQRxV/gTmN3DmdqHPMxbc4hvKxSb7RR8TVRhGywqp3tMNDyVydUCTHYvQUH4l4=
X-Received: by 2002:a05:6512:3b11:b0:52c:e054:4149 with SMTP id
 2adb3069b0e04-53546b052fdmr9501323e87.15.1725355249406; Tue, 03 Sep 2024
 02:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240830105304.2547406-1-changbin.du@huawei.com>
 <7c67704e-a067-4b6e-8acb-51b33cf17ee0@linaro.org>
 <6c9429e2-90c0-423a-812f-33f98fe1bdc8@linaro.org>
In-Reply-To: <6c9429e2-90c0-423a-812f-33f98fe1bdc8@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2024 10:20:37 +0100
Message-ID: <CAFEAcA_TyjZMcQ+_aCKQvHVow7hB0Q_nZKzRSxPUA2S5EEyBFA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/boot: Report error msg if loading elf/dtb failed
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Changbin Du <changbin.du@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Mon, 2 Sept 2024 at 21:00, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 2/9/24 21:55, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Changbin,
> >
> > On 30/8/24 12:53, Changbin Du via wrote:
> >> Print errors before exit. Do not exit silently.
> >>
> >> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> >>
> >> ---
> >> v2: remove msg for arm_load_dtb.
> >> ---
> >>   hw/arm/boot.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> >> index d480a7da02cf..e15bf097a559 100644
> >> --- a/hw/arm/boot.c
> >> +++ b/hw/arm/boot.c
> >> @@ -839,6 +839,7 @@ static ssize_t arm_load_elf(struct arm_boot_info
>
> Note that header error is also silently ignored and could be logged:
>
>      load_elf_hdr(info->kernel_filename, &elf_header, &elf_is64, &err);
>      if (err) {
> -        error_free(err);
> +        error_report_err(err);
>          return ret;
>      }
>
> (untested)

This one is deliberate -- if the file is not an ELF file
we want to silently fall back to trying it as a uimage or an
AArch64 Image file or as last resort a bare raw binary.

-- PMM

