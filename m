Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5BBC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 08:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd4PU-0001Ec-UN; Thu, 22 Feb 2024 03:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rd4PT-0001EQ-Hg
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 03:26:27 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rd4PQ-0001QV-Sc
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 03:26:27 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2998950e951so2679985a91.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 00:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1708590383; x=1709195183; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzX11SSTNtC0MD/Nn+Slk+ady1zproF8O6ueCQSzB8Q=;
 b=AMF1L8J1VVrY0aShpr+EygUlwKeOCvyBuIJ/mFwwJQIY/sR+J36fEoI8NpIXRSdHtC
 gfk7LUBr/HtpwqvTjEefNwOEI0PxZtDzJX2qQCnq2IoLsf4cBHCyLUkM8Hxy99VvkFwo
 uHSo4gqEvjpPb2tNcGVGPZD6RJ5zTKPVZeHWWw8MjB7nvtkLg3tF/jnJ1ZZusQkIC3L1
 3925tci0C8MZ2r3hWLychhFsN3cvCfh0j4Z8PPJikuzETc1aIWZjvGusY7xOHpUO0pdl
 tO4o2FoZf/VN1N9SlVbWv31XgDva7mz6o5/USpi1ml6lnL2lnsukuVCQRiHyWokQ3kxO
 jtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708590383; x=1709195183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GzX11SSTNtC0MD/Nn+Slk+ady1zproF8O6ueCQSzB8Q=;
 b=NC11oBylrtQuUx32SRmscZv5CAABjn7p5kUHIEgWHLxvAL89U8rx4BBH5cGnCbeAJP
 RpHkVMH3CY9L52nlCYpiAxezDLYSlpctVe8nGViFbL/kXeC4AkhloLivnr3M+NxGG4V4
 sDlACTN6ZldSk0+O1MQg6xjkY454DXfDVSUDd+g8XhSsK6XDF68oOg+muUENCX0xsnXe
 tFSF2HoITkc5/4IYyyx5jxHcUC3kCsIy3O9gOaGmk0szFmpGLcP67nkV2DMykHEsbE+N
 /gC4KjsupCcbOHrK66kniHd6aF8meNNrug2hWy8WdL5KnJLtzXNBQtIuk/WHCWsx/k80
 D3zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPxU/iVXjyQIS7BB6CfkEY/7/aRIdCZUlqe8bHrf24r8/lZEFOG5eDgRa6H4+fNpOcRRhK5JAev75oVK5u2ctaWx4tllU=
X-Gm-Message-State: AOJu0YwtRZyEhEbRpZUfo396U+187sjR58si7JiGWCj1BQvx4c02draQ
 1AdrJ47P2rEt5rOub9soBSF0Kc9Kxa+e0gXamUJAutxeCelPoGHEMN2PsIWb8U3puuS8mIpOIbX
 EAnmru45rJpVHbu9sCCeIonDSekjQCRT3D1wv
X-Google-Smtp-Source: AGHT+IGNWbFS0j/JOee9aLikllEEWXGMkmR1o3qCiwQiqZVNDxagr9ZHKIqT2xR3NvLzTEZo0/KCLa9WmXRFcHGLyw4=
X-Received: by 2002:a17:90a:e645:b0:299:11ae:d507 with SMTP id
 ep5-20020a17090ae64500b0029911aed507mr15340100pjb.1.1708590383404; Thu, 22
 Feb 2024 00:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20240221180751.190489-1-thuth@redhat.com>
 <99813a8e-45ec-460e-a944-c696eb853b75@linaro.org>
 <1ed3ee21-20ff-4503-98ea-de00c490b83a@linaro.org>
 <0a37899f-ca73-4749-8f6f-2b61b92cb560@linaro.org>
In-Reply-To: <0a37899f-ca73-4749-8f6f-2b61b92cb560@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Thu, 22 Feb 2024 09:26:12 +0100
Message-ID: <CAJ307Ei8-VE1Jsy_uZzLa_2=t76qB_eykZx-=0hNoaogGsUQaA@mail.gmail.com>
Subject: Re: [PATCH] hw/sparc/leon3: Fix wrong usage of DO_UPCAST macro
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Frederic Konrad <konrad.frederic@yahoo.fr>,
 qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=chigot@adacore.com; helo=mail-pj1-x102f.google.com
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

Hi Philippe, Thomas

Thanks for handling that !
And I do confirm that it does not trigger any obvious regression on our sid=
e.

Thanks,
Cl=C3=A9ment

On Thu, Feb 22, 2024 at 8:46=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 21/2/24 19:49, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 21/2/24 19:47, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 21/2/24 19:07, Thomas Huth wrote:
> >>> leon3.c currently fails to compile with some compilers when the -Wvla
> >>> option has been enabled:
> >>>
> >>>   ../hw/sparc/leon3.c: In function =E2=80=98leon3_cpu_reset=E2=80=99:
> >>>   ../hw/sparc/leon3.c:153:5: error: ISO C90 forbids variable length
> >>> array
> >>>    =E2=80=98offset_must_be_zero=E2=80=99 [-Werror=3Dvla]
> >>>     153 |     ResetData *s =3D (ResetData *)DO_UPCAST(ResetData,
> >>> info[id], info);
> >>>         |     ^~~~~~~~~
> >>>   cc1: all warnings being treated as errors
> >>>
> >>> Looking at this code, the DO_UPCAST macro is indeed used in a wrong w=
ay
> >>> here: DO_UPCAST is supposed to check that the second parameter is the
> >>> first entry of the struct that the first parameter indicates, but sin=
ce
> >>> we use and index into the info[] array, this of course cannot work.
> >>>
> >>> The intention here was likely rather to use the container_of() macro
> >>> instead, so switch the code accordingly.
> >
> > Fixes: d65aba8286 ("hw/sparc/leon3: implement multiprocessor")
> >
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>> ---
> >>>   hw/sparc/leon3.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>
>
> Patch queued!
>

