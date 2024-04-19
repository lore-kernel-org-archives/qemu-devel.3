Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDCAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 14:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxpSF-0002Ko-Sd; Fri, 19 Apr 2024 10:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxpSE-0002Kd-3V
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 10:43:06 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxpSC-0002LF-Gd
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 10:43:05 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a51aac16b6eso96080166b.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713537783; x=1714142583; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WVpvi44kReWGomfJfcfp/Rk/QyWby+3LNyh0waSAiTA=;
 b=W2DJb8i8Kld8lXvhZx/GO+2SzuVDH5gEUgiHsAKr6JfIhx2nNV8DFB21GddmpwblqW
 dASNy2SbsQu0BVcqqgtr3mRrTtf7OY4Wx7ZxutKH0KJk5aIXFLj1R1zh66ChJbjOoluT
 CPN58KKrxOGyA8sE6T+Iwo82JmJT5KRd8sf3Fii87/+Ukg5bZDLX31LxFSTRv9ThFbfS
 K2SjhHnM3tl3CxpKfNJcw6X5Z3E0AMVI7LPXlVDSMF5vXSUrZR9srJxtrkqRgRwdC9e7
 wMS5KiKYPeBjLXjpCa5apHHwxbR3HsZ8IaXNmeRXJMo+Fp8fkwi4/SBg1Cu3HuJfpvCE
 kWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713537783; x=1714142583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WVpvi44kReWGomfJfcfp/Rk/QyWby+3LNyh0waSAiTA=;
 b=n2IurRh+tkYknn0OaYlbu0w5lQroo4nIhQdk8FG4jzB2UofNH/kAJpf3PvWP6Nl317
 TTqdUxQi1ztqLV7DeAwDCzhmcQ7jZN9mTSJ+XAzAKaV3Oc6fbP8gcbxTe9kia3PSdyJj
 h38fkeKvzLyaVg4F2tgL/g85Kkje3fFbN06r379d4HL1O8bYQHIqxjdB+BYP0l6qnuyU
 fLbt7a5y0M4GYb+UmRAk0zt4JnR9GCsnxLc3kdISgUVepkiNmYnJ5puWpb3oa0liU+Ul
 1ttWVdMM254YvkUVhvhg56l4cVcHPkvTXw8SHx4Dzpgw0ZSB+7A8ZM+VJRF7h5ak/+BK
 KKlg==
X-Gm-Message-State: AOJu0YyD3hIV8agy3Gj6KKea9zszeTHB7tw7MwWwzgig+gdtrIiVsVph
 TZtf6e9FPPR8+urQeHiXYcTOAP1WQYNZBvupI87VsDjfqmpUEl19UOGaPF3jYx+mVBD6hgVN4Yw
 7DG+zvtZLdmxfMClJNfC5MJJ0VCOiIYqPTLYKKg==
X-Google-Smtp-Source: AGHT+IEjJ2G4TS5cZ3mK5+Vy66Y/ZqEhsJbw5k9ZJ2ulvDL3umg3YJcbjcjR0XJNQZpQBCkOQfJ1fM5g8KlggsoCgPI=
X-Received: by 2002:aa7:c594:0:b0:56e:2abd:9d10 with SMTP id
 g20-20020aa7c594000000b0056e2abd9d10mr2298284edq.22.1713537782803; Fri, 19
 Apr 2024 07:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240409115301.21829-1-abelova@astralinux.ru>
 <CAFEAcA_W4qr6EPhOu-s_+d_V+MfADzddKNwd_gUzBTbajQ+xvg@mail.gmail.com>
 <5263ef36-0b82-48fe-a351-b557ead15b01@astralinux.ru>
 <CAFEAcA9LTLjMtEtCfqnR8_-WSdo2ZZCb28C-roRXgcv+ULa3ww@mail.gmail.com>
In-Reply-To: <CAFEAcA9LTLjMtEtCfqnR8_-WSdo2ZZCb28C-roRXgcv+ULa3ww@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Apr 2024 15:42:52 +0100
Message-ID: <CAFEAcA_H53jOSVBjZ5tfOd_U1++CLVqzFSBHt1=amnouFrZwJA@mail.gmail.com>
Subject: Re: [PATCH] hw/dma: prevent overflow in soc_dma_set_request
To: Anastasia Belova <abelova@astralinux.ru>
Cc: qemu-devel@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>,
 sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

On Tue, 9 Apr 2024 at 14:38, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Tue, 9 Apr 2024 at 14:32, Anastasia Belova <abelova@astralinux.ru> wro=
te:
> >
> >
> >
> > 09/04/24 15:02, Peter Maydell =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > On Tue, 9 Apr 2024 at 12:54, Anastasia Belova <abelova@astralinux.ru>=
 wrote:
> > >> ch->num can reach values up to 31. Add casting to
> > >> a larger type before performing left shift to
> > >> prevent integer overflow.
> > > If ch->num can only reach up to 31, then 1 << ch->num
> > > is fine, because QEMU can assume that integers are 32 bits,
> > > and we compile with -fwrapv so there isn't a problem with
> > > shifting into the sign bit.
> >
> > Right, thanks for your comments.
> > I didn't know about this flag before. It became more clear for me now.
>
> Yep; if you're using a static analyser you probably want to
> configure it to accept the behaviours that are
> undefined-in-standard-C and which get defined behaviour
> with -fwrapv.
>
> This code is definitely a bit dubious, though, because
> ch_enable_mask is a uint64_t, so the intention was clearly
> to allow up to 64 channels. So I think we should take this
> patch anyway, with a slightly adjusted commit message.
>
> All the soc_dma.c code will probably be removed in the
> 9.2 release, because it's only used by the OMAP board models
> which we've just deprecated, so it doesn't seem worth spending
> too much time on cleaning up the code, but in this case you've
> already written the patch.
>
> I'll put this patch on my list to apply after we've made the
> 9.0 release and restarted development for 9.1.

Now applied to target-arm.next for 9.1 (with adjustments
to the commit message); thanks.

-- PMM

