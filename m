Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7355C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJCm-0005i2-4G; Wed, 12 Mar 2025 06:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsJCP-0005dK-J9
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:20:30 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsJCN-0008Hk-0S
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:20:29 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so5139352276.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741774824; x=1742379624; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hSc1FdEuLOzToJ3GVm1p0E+JN04pUwoWYv9Pu5TzqlQ=;
 b=GMQ+//wrDHzxTM7TX+g6jqaHKuo5+qoYzni3OhDFMpgwPwX/9T23NX9ICSdHwEePHG
 gjH6aGKRYPKtqdO7/RRW+/jpNWqUdssBV8JhMYCikNsEiigwumluTcTbLUYnZElfLmnT
 I9Mk72o2rl21JBU/LgkyW8HMN1ZyEsarpaZhbdXlPfXHF/QyhGHxReqORf3EQ6IcPccs
 AirFUvy8VuVMj94yNcC9z5eEczrUHbxAUQtFgYNyUnx2ftIGj2YJeKXTJgtOPkrCeE/X
 PCPhw9L4++8fxA3AY/NjUjuTNrrxH9kYaS8xhjeepfAWghOa4xoicwYq2XOHHiAgNSZi
 hlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741774824; x=1742379624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hSc1FdEuLOzToJ3GVm1p0E+JN04pUwoWYv9Pu5TzqlQ=;
 b=pIdhXk6loxFnMQbpvFbqzgy9/RXsAhzlbiRKW6JYR33NrcjBdnj3lf/SChunFJJ3xe
 rCxPog+TPAcgkqRuE+gVgc8wU0EtMEDjLVZC9VFD4L0pMyqWE6Uyf/yqA8EgnrLi7zH7
 5VjBiN4SkO6BLrerIFdzFp8+dRJw2/QT10DQXfsEJM+8mPb2zmsJUrocBbq1OeF/RwWw
 aMvx6sY/zQ/kFExfWwto531ntpAb6K1Y/FLmRwT2nZ2/rBTuohiPOm9h07MgYiSqm3Sg
 E5Vri2Bfh0bAg0XSKRSlrHnmE4EJuYCG0/gxIC+73v909x9J+xXkVtVsYNkYzmAS6KBd
 oKZA==
X-Gm-Message-State: AOJu0Yy1OLcQOfKAkdneS5HHFd0vkywEDFgqcl3vqkKZpPxx6xhUBvlR
 OoYYN7zbBRKLxB2Kv6WWE24bCfoIb0Xf3nmZW1FByU1X5T4BxCzOne3rnAIUbS2u1FTYhuar7gc
 VOeeinx+SnyUY1OqI8B9Unkvk9bcLCXQCIiZpSQ==
X-Gm-Gg: ASbGncuLZPQvy4AYTuyV8Sk4+7jOWE0pZjU+DOvPIRIAA8AahnRD9ADjjemYOLQo4pK
 Pz+kgk7sgQ47RAYjsIwd6J645GOtlMv0PxT3+4I0f/nTGW+bU9jrUFmfVJH0e8neKkVXqbGJqeE
 Git/O/5ZCQqww2vRqBUBnLmEgx81s=
X-Google-Smtp-Source: AGHT+IFwH8GLv0PT7otbep8nFf1lgDU4NcKKhJcHtx5OMwkQ+jiML6fFrTfN4OXszhRxDsBOQC+EZjHJiA6cyvBLdNU=
X-Received: by 2002:a05:6902:2102:b0:e5b:257e:c3b1 with SMTP id
 3f1490d57ef6-e635c0f926fmr26000502276.8.1741774823899; Wed, 12 Mar 2025
 03:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
 <20250225180510.1318207-32-peter.maydell@linaro.org>
 <1cdb6643-8fcc-4bd8-93fc-fcc93589c9a3@redhat.com>
In-Reply-To: <1cdb6643-8fcc-4bd8-93fc-fcc93589c9a3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Mar 2025 10:20:12 +0000
X-Gm-Features: AQ5f1JpkzhP12lnzOg7jklias089Vc-fMoTGtcuTI87VqBZbVgQXr7TMPwaNS_0
Message-ID: <CAFEAcA-JgjX2U3wQ47X5JQ2SU1yMpx=0rWkctbj40w0Xjufpmg@mail.gmail.com>
Subject: Re: [PULL 31/43] hw/arm: Add i.MX 8M Plus EVK board
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Wed, 12 Mar 2025 at 09:40, Thomas Huth <thuth@redhat.com> wrote:
>
> On 25/02/2025 19.04, Peter Maydell wrote:
> > From: Bernhard Beschow <shentey@gmail.com>
> >
> > As a first step, implement the bare minimum: CPUs, RAM, interrupt controller,
> > serial. All other devices of the A53 memory map are represented as
> > TYPE_UNIMPLEMENTED_DEVICE, i.e. the whole memory map is provided. This allows
> > for running Linux without it crashing due to invalid memory accesses.
> >
> > Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> > Message-id: 20250223114708.1780-5-shentey@gmail.com
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > [PMM: drop 'static const' from serial_table[] definition to avoid
> >   compile failure on GCC 7.5]
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> ...
> > +static const TypeInfo fsl_imx8mp_types[] = {
> > +    {
> > +        .name = TYPE_FSL_IMX8MP,
> > +        .parent = TYPE_DEVICE,
> > +        .instance_size = sizeof(FslImx8mpState),
> > +        .instance_init = fsl_imx8mp_init,
> > +        .class_init = fsl_imx8mp_class_init,
> > +    },
> > +};
> > +
> > +DEFINE_TYPES(fsl_imx8mp_types)
>
>   Hi Bernhard, hi Peter,
>
> this device can be used to crash QEMU quite easily:
>
> $ ./qemu-system-aarch64  -M virt -device fsl-imx8mp
> **
> ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread: assertion failed:
> (n < tcg_max_ctxs)
> Bail out! ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread:
> assertion failed: (n < tcg_max_ctxs)
> Aborted (core dumped)
>
> Should it maybe be marked with "user_creatable = false" to avoid this?

The bug is that this is directly inheriting from TYPE_DEVICE,
not from TYPE_SYSBUS_DEVICE. Doing the former is almost always
wrong, because it means the device is never reset.

(It looks like we do this wrong for other fsl SoCs too,
but they're marked user_creatable = false.)

-- PMM

