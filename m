Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FA3C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 17:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmyJV-0000ZE-Bf; Tue, 25 Feb 2025 12:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmyIv-0000BT-Nl
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:01:14 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmyIt-0001kd-2F
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:01:09 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e5dcc3b0c77so4748744276.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 09:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740502865; x=1741107665; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4dFCZW/85o9V/rsJaCHCE4r6BgNo9NPVq5fNOazp5M=;
 b=Whhrkh0iQc5IbFbG4QL8k3X04h5ga58ns8LR0kHB01ZH2lGSGLje9bTVlxSV30IxQ4
 vOGT9AvAPH6euErFMYgtKg49Ui0px27rcyX3kRicAoennnO+FufqLrV569JiqIXQehTR
 HbfN4p9jdIRuYrKBT1YwCN/KstVbEGcT/4p5KO63qJowI7E+7CG4oD8zK+DUjpmLGLQ+
 gKRem35XWM/74+8PC2HAh1AJgTASd5lmLFl6Tbr9IvZ1QB40C0BgcsGQ8UPaEZP1BS/C
 VElnvMpeVpOGN8EN6hXCCTStNP16RmozD381hWlEoZ32KqTzXy87NSnoEqQETHtqdyaL
 VQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740502865; x=1741107665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4dFCZW/85o9V/rsJaCHCE4r6BgNo9NPVq5fNOazp5M=;
 b=E/zmySFgiSClyHHbeXd9834qZUA+rQvI2yVk0KcHmaiURMq2HhfP/w0OCDu0pXJ69r
 2vkbKYCD/cErwpM9k4QQsSXquK1M7kMaaw3FitqzuIByd2D1m2pifEnck30MluAApNWM
 ysEmmdbAmWuAuHty5+cFm5JEfnjU5tjEDpjRCXNeSlNuQTFGp6Z1Vb7so6doakCSTbea
 C0FRIRPn6pD6R/KdvBpmVAU/jgDJ1ycaTbEIN2/UwWbhHhLnGVc7re44awJbvj4jDK+r
 PyvnOLpFMr4peFR4RX2CRHSefIJZr2kERSSeCxOpXCJoETyMQxZGdngeoF/WVo5APsxs
 F9Kg==
X-Gm-Message-State: AOJu0YyolcGhMCmrqJAXOycCZYOEHkX24ymOKzP7OczhN0FrRCb9xdOd
 GDyOgQSPQsOvgAqnijzWPcG+H0OKEH6oU1GMT2HhjwH0ZkbZZgA3ARrZtCU8N4h8ksKat+OdUqF
 zpZKdIR0/iKZlNEOy/7iyJSKWij5iGf5Es1h6UQ==
X-Gm-Gg: ASbGncsXnis4Q/ZkddWw9jaFAhMTHTZfldnYDbhgYUSt+/txXoIavVTbNOQja0raq2G
 BA9ZkWOedOKfAKcdq57fGk1z1TGBKBeNHQnbIQYpC98xjlrFFMkDDI6S4KXMMqH6pyeqq8cW62K
 WmbxKKH/1J
X-Google-Smtp-Source: AGHT+IHln0UQewWfW8UTd9u+c3TWUqz/P434K/Elnot2g2l4VdJGk0x4aLPMPv7+kGVBhe7DFV06gwBOM5GcjEtvT8Y=
X-Received: by 2002:a05:6902:2484:b0:e5d:c5f3:13e1 with SMTP id
 3f1490d57ef6-e608a808b2fmr174338276.35.1740502864897; Tue, 25 Feb 2025
 09:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20250223114708.1780-1-shentey@gmail.com>
 <20250223114708.1780-5-shentey@gmail.com>
 <CAFEAcA_XJfAVEe3cgHiXgcewTL3kF3SEevrnMh-Edvfk56G6sQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_XJfAVEe3cgHiXgcewTL3kF3SEevrnMh-Edvfk56G6sQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2025 17:00:53 +0000
X-Gm-Features: AWEUYZmeg4enO--jZ7xJfwSMhYUOdjuW8NkTogc9tup8QtGuBS-XNQ-uQG3NQFE
Message-ID: <CAFEAcA9e5FBrKLZrKRsw=wPThbwx3+gyVt9rv4_vx9OKfZ8qiQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] hw/arm: Add i.MX 8M Plus EVK board
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 25 Feb 2025 at 15:42, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
> The C compiler for the OpenSUSE CI job doesn't seem to like this:
> https://gitlab.com/pm215/qemu/-/jobs/9239416833
>
> ../hw/arm/fsl-imx8mp.c: In function =E2=80=98fsl_imx8mp_realize=E2=80=99:
> ../hw/arm/fsl-imx8mp.c:382:15: error: initializer element is not constant
>              { fsl_imx8mp_memmap[FSL_IMX8MP_UART1].addr, FSL_IMX8MP_UART1=
_IRQ },
>                ^~~~~~~~~~~~~~~~~
> ../hw/arm/fsl-imx8mp.c:382:15: note: (near initialization for
> =E2=80=98serial_table[0].addr=E2=80=99)
> ../hw/arm/fsl-imx8mp.c:383:15: error: initializer element is not constant
>              { fsl_imx8mp_memmap[FSL_IMX8MP_UART2].addr, FSL_IMX8MP_UART2=
_IRQ },
>                ^~~~~~~~~~~~~~~~~
>
> This is (gcc 7.5.0 "cc (SUSE Linux) 7.5.0") apparently. That's
> a pretty old compiler, only just within the bounds of our
> version requirements (which are 7.4 or better), so I'm guessing
> it's just not as smart about figuring out that the
> initializer here really is a constant value.
>
> I'll fix this up by dropping the "const" from the serial_table[]
> etc definitions.

More specifically, you have to drop 'static const', leaving just 'struct'.
Minimal repro: https://godbolt.org/z/5css4hv67

-- PMM

