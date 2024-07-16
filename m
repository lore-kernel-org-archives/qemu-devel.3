Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE78C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjPz-0001XU-LU; Tue, 16 Jul 2024 10:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTjPx-0001Kz-Nu
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:44:37 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTjPf-0003AT-EG
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:44:37 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-58d24201934so2382002a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721141054; x=1721745854; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rzLZmf8wi3VJrCA9+xiQjVWImQTbreBpuPWfZU1qY4=;
 b=ejPZ+WUMRG+zUnrqRJr5YCo2iUX8oe/tHFv9tgYikez02z+7msW7Ast23OQ0qdMieD
 fwQIRVwqkOCFBUUMe8FWB2Uc2mjNlnmAqtpatzf0+sFDjm7zlfZJ7BMMnQn3o4Gf0/KX
 nNVSqm8yj5bWqCm+7WwYcREDycZnUhXAR/k27Tn1zuR9VrcHgchzyXhc120u4E+eiMfr
 dQRaSFjAbDR0oAPjshi/d7J6vOp57OLz1iKP3tDT/rji7MxCendY2zgrjB71R/NRiyI7
 nat5TDBdTFwlgaJmErxeXfmzqeVgZXsfefb1eucxLKX80WJBqzAKSjfeSq7qhy6b3kpK
 4aIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721141054; x=1721745854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9rzLZmf8wi3VJrCA9+xiQjVWImQTbreBpuPWfZU1qY4=;
 b=kfEklig4u9BndDJJDJFCUeOaoPzBLN0uMieg+zFxIu9i1C9vrXQhqQk9bLGAbPrS3D
 URagcycrUmUtWiQ/iFXTRTGt+nzfEs81y+fqWsjTFixjGzDjtrkivvlpKWgcw5AJtXff
 qd1BNswQMijxt2kc4dr9gUBD3XsIWJ6kYeEyXV/HWWsjT11oHsUXP2hQM00NW2cHmYW3
 dArXubSdVhAyGIOQUGfGFQjdFdRJeHCHGRdeFNXVFEuC38k1gPFUx1TZtz+L3CFXZ1Np
 TbEwznNFAMcG6icmUIakmLh1mQnp5OOtjL509an0TATQ6v22oTcwgiTfLfrhpzBenCZP
 XEFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyukBBCal5YWhuwnye2fLdfNGyFY3HIUqgKXi3Nr+4pidRP19cU4a4hUCvqfMXlh9cfA8Or6WER+t3E+DlGvkeb8MrdDU=
X-Gm-Message-State: AOJu0Yx3koAbbsnGj0XVHjtk77c97tjtasVmhLmXLCawjF0ZyzNxN9Ks
 FOIpXbcOXqk1/cX7REWPr23vEI68tyQBcGaUjQsEBySU+dnH5cMTJXDDc/XrevIwl6pxOUQLnow
 dNckuWcaOaGIMm/VLplwVt7Vyim0byAQefNAqVem2n/xkCyfW
X-Google-Smtp-Source: AGHT+IH+pfyzhanmtTgdevkSavrsq2jJEwGbbZH1+Byxa3hOocfhpE2M0MSLdPAmHe8xZbLhKTyn1Qk3Wrwr2BE0vSQ=
X-Received: by 2002:a05:6402:3594:b0:58b:bb69:763e with SMTP id
 4fb4d7f45d1cf-59f0ac09412mr2071906a12.7.1721141053847; Tue, 16 Jul 2024
 07:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240713160353.62410-1-me@samjakob.com>
 <CAFEAcA82m+8K8rWDMBehPp=NGUezHZPn1LVoyU3DJ3LWq+ZnAw@mail.gmail.com>
 <3e35a80c-fa0f-41f5-8a63-30a873fb3bad@linaro.org>
In-Reply-To: <3e35a80c-fa0f-41f5-8a63-30a873fb3bad@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2024 15:44:02 +0100
Message-ID: <CAFEAcA_jA9BnBRYZK8b15ibp7SFw0PNKb7H=-xs4p=ttOesahg@mail.gmail.com>
Subject: Re: [PATCH] hw/display/bcm2835_fb: fix fb_use_offsets condition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: SamJakob <me@samjakob.com>, qemu-trivial@nongnu.org, 
 "open list:Raspberry Pi" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 16 Jul 2024 at 15:37, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 16/7/24 12:35, Peter Maydell wrote:
> > On Sat, 13 Jul 2024 at 17:04, SamJakob <me@samjakob.com> wrote:
> >>
> >>          It is common practice when implementing double-buffering
> >>          on VideoCore to do so by multiplying the height of the
> >>          virtual buffer by the number of virtual screens desired
> >>          (i.e., two - in the case of double-bufferring).
> >>
> >>          At present, this won't work in QEMU because the logic in
> >>          fb_use_offsets require that both the virtual width and
> >>          height exceed their physical counterparts.
> >>
> >>          This appears to be unintentional/a typo and indeed the
> >>          comment states; "Experimentally, the hardware seems to
> >>          do this only if the viewport size is larger than the
> >>          physical screen". The viewport/virtual size would be
> >>          larger than the physical size if either virtual dimension
> >>          were larger than their physical counterparts and not
> >>          necessarily both.
> >>
> >> Signed-off-by: SamJakob <me@samjakob.com>
> >
> > Thanks for this bugfix; I've applied it to my target-arm.next
> > queue and it should get upstream within a week or so.
>
> Since I'm seeing 2 times the same patch, adding R-b again on
> this one:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> (BTW Peter the commit description is mis-aligned, if you
> don't mind, correcting it while applying would be appreciated!)

Yep, I already picked up your r-by and rewrapped the commit
message.

-- PMM

