Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04637C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcryY-0002z8-NK; Tue, 28 Jan 2025 15:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcryM-0002cI-Nn
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:14:12 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcryL-0001hu-Ao
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:14:10 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e5447fae695so10687294276.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095247; x=1738700047; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BRFdytR/7KXGSQbifQGl7f025+AufHYVQHuhopQV/h4=;
 b=aYHxycyFDy5eCYGofVvGxpN+wE7aI10YKxvS74qjv9jTQVyNeCkwmwTVvX4AXW0Cb8
 1l21TCL9+aqd7UkXVZR0ZSzg0VlSrlOpJxb1CXYV3iSMyXV/PmhI/DawG9GdckJcwBsl
 ock/qyOr0j+xkCdXyJaYl0GcseEw3Li3rKUy7nM00AuY0FFCQG+mEVwgdxhR4oxgwKPQ
 Rnk2sfQV09TTsAJSWGPbJp5QIUxl1ZKysVFvacj1OBNqCzqFSuAkXpmjpI5mEUjVxtTd
 X9iHcfEDSKwMvGcHemrBH3WzSM02vQVRv5SuCM7pO6q5zqBM/NrLhBX2KhpYp+UC4r4X
 SDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095247; x=1738700047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BRFdytR/7KXGSQbifQGl7f025+AufHYVQHuhopQV/h4=;
 b=SxcB8JVPDKFDtoW9QBM7nv6UZz9I71paKt2WKax1arPCuk13On7iWIC9AeRXANEEe4
 83PJEhj/7kYi3gcWKlc5MCwkJ7kSFkeWazo+h6Q4tUvn1J+KMLIu6o4PPDpWO4UoHfun
 ZJ0QpLEIDiT4FaLK31i6W5CiQ93MmfnI6dfa1CKW4cC9Z8zsByr8sujmpujcyvMm9G5i
 +aWeiv25QrBSUd/C9wM/3fCo1tS3HRw7xDq77jTKVubvLyqJWznEzXO71UQN3gvwp2MT
 9QUcc5j/Pj1G96a8kygjgiL3PwCYi5su9lIIP/aqvstP7DlW7L4+zQFvr95DrtR2aQtf
 O6Rg==
X-Gm-Message-State: AOJu0Yz0fKNyTtrOkXwcUsk1RxoCNowmBLvNBm5wZO0RwMGC2QQLE8U8
 nrtrcum7ZNwxGaToUEBkMD0yIF3SrrxWkyduYL8qeHZhLjnI20+t0Kj6IlNryoSILZImajV30Q7
 jyGw2fAA8+stxZkUJVq9ApnvOvdyOUcIjHDPC+w==
X-Gm-Gg: ASbGncuYK8WOlYGgiqKIFlwcTdoXywhs7eKMRz95HoNAlmARizm9I6U3oMWnjbZbTCz
 hvr1H77ssRfc8wsGHxGkRhngxYk1WAxE80kDwshk4wE6xPWP6PUi3daUqcC9twzKWLwPofahFGo
 5WaiAZh9Tl
X-Google-Smtp-Source: AGHT+IFT07Xnb8ns+/LqDwEy2XNedp2DLsr9e+vXRVV3aubLTbGsCLGJdbWInEVwZVEYS5Cw6cpHBHewZMxjwyHxO7E=
X-Received: by 2002:a05:6902:707:b0:e58:33aa:3ac7 with SMTP id
 3f1490d57ef6-e58a4bf1c42mr288415276.44.1738095246738; Tue, 28 Jan 2025
 12:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-2-peter.maydell@linaro.org>
 <e47672f6-5788-4322-aa0a-230fe1161ef4@linaro.org>
In-Reply-To: <e47672f6-5788-4322-aa0a-230fe1161ef4@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2025 20:13:55 +0000
X-Gm-Features: AWEUYZmrR3X2OUeLi3-5cvjbfd-IDKygsBqjRzWjf31t_5uukHSb1CGOeXOkNXk
Message-ID: <CAFEAcA9D8ET6BoF9M5r_TMiMh3ZftO_jZke17U=AL7v03kwY4w@mail.gmail.com>
Subject: Re: [PATCH 01/11] hw/sd/omap_mmc: Do a minimal conversion to QDev
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Tue, 28 Jan 2025 at 18:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/28/25 02:45, Peter Maydell wrote:
> > +static const TypeInfo omap_mmc_info = {
> > +    .name = TYPE_OMAP_MMC,
> > +    .parent = TYPE_SYS_BUS_DEVICE,
> > +    .instance_size = sizeof(OMAPMMCState),
> > +    .instance_init = omap_mmc_initfn,
> > +    .class_init = omap_mmc_class_init,
> > +};
> > +
> > +static void omap_mmc_register_types(void)
> > +{
> > +    type_register_static(&omap_mmc_info);
> > +}
> > +
> > +type_init(omap_mmc_register_types)
>
> Phil seems to be moving everything to DEFINE_TYPES now.

I looked at that, but it wants an array of TypeInfo,
and this is just one. So I did it this way instead.

-- PMM

