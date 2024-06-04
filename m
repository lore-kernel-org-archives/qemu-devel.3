Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07583C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOAU-0007AY-4s; Tue, 04 Jun 2024 03:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEOAM-0006vc-BQ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:01:11 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEOAJ-0005i7-Ia
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:01:06 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52b976b5d22so2214892e87.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717484462; x=1718089262; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEd2aHyq//5kCa93gnoLSFnczPLMT6qnXjplmrHppI8=;
 b=Ku2vn66ux5hFg0lhlKr1Tv9Fu2M2HIcwrF6XGUxKnPhlvWl60xp9vJbvGbIkX56x2N
 dRmKlqVG12gBMiBAux92AQnyxPf+rArtDgA5tadYZnZFhadXf54YEXjyxp1rM5MI6c0J
 5cX0w4lsbHI89HYiLvaMWSet7w1sFCalBUZZ40Zh38cGR22IE30ilrK3bhrggv/PuUcF
 Ab2w0G66i42Wl7E3gyHaOePU4j7tF5lQtx+L8SEMdmI1W7nE2vlqUqz5eonKj43Dn96e
 svyya4OTl2TI4MSPC+suXHZ5WnsRfciZZ4+a7tgnlBifAXEcZPHx+zNUF1ot9ZJimlzs
 kKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717484462; x=1718089262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEd2aHyq//5kCa93gnoLSFnczPLMT6qnXjplmrHppI8=;
 b=ZkuvNv2OutWjf4M99MONMX87tsp6zvXHNzKLMCtDEcKtkFLt9SZt/+UP/bbqvo7wcs
 zq4fpF1Mnw8ePe1TK+DdlbKYC0mxgQyajhNsJTz1kmYGTSFti/5jcJtvdxsRcKn0ZokJ
 lsNJAgvwlyJxwcICm44lUKLvZHWHV9W+OT7A5PETmtVq7NEn5j5qpbq+2QWqEneVYkZ/
 x8h/eCMZDbYvzNCVRBYW0D5S9Rpef0vqcBzh7aHVdvsvdFgtOeKbeCwSc4nnP8CtuQYJ
 iDVRt17yrhe9CZN+z8H69mpwNTzMXC60bU0yTVyqacebTfpsDd0PQLnxiKMxlQMaqkfa
 CWjg==
X-Gm-Message-State: AOJu0YwQix241jkgTMMmLqxgZko4+wioRYGAvoBorzfndDqo0GDSJV/7
 nR34zMAFiRUMri0Hi+kURpZ+MXhY0Zb2OOK+1WKCwyTOaGrrcRAYT+2Kgyw7mGTHKJ/39hfwwPz
 UJS5+3H0GBG7AO/BFhhLIunUNc3oKg5Tn/2YH0gKdpjdwKSk2WeDxsmUdDXUd2kcpliL1QE9bzg
 7bFxzoTJNg86qJEy4vbg5smrS45fbcTfdJPYjhVaf+Yw==
X-Google-Smtp-Source: AGHT+IEC6z3TDDwJiYPuT9rChZssilc53+zDsESYoZQK2/4dtE3EL5wY6Ljzli+8c5NfJ3AIIdbX/w==
X-Received: by 2002:a05:6512:3b25:b0:52a:d87f:60e3 with SMTP id
 2adb3069b0e04-52b896f7eebmr9616137e87.57.1717484461608; 
 Tue, 04 Jun 2024 00:01:01 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52b9b812641sm441130e87.39.2024.06.04.00.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 00:01:01 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-2eaa80cb573so36462941fa.1; 
 Tue, 04 Jun 2024 00:01:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUYqttBAhF1umPjV0M8XmmpnObEaNLc56xaiqLqxNfpMDZeTlUTkri3JQYgUSvvYTzYEhHGfLWoHi69XblA2Tszi6rvvAL8F1jpcHZa88gL88XRXsTX43mtAEg=
X-Received: by 2002:a05:651c:233:b0:2ea:aca0:2769 with SMTP id
 38308e7fff4ca-2eaaca02a6fmr34880401fa.1.1717484460050; Tue, 04 Jun 2024
 00:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240603055248.3928469-1-fea.wang@sifive.com>
 <20240603055248.3928469-3-fea.wang@sifive.com>
In-Reply-To: <20240603055248.3928469-3-fea.wang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 4 Jun 2024 15:00:48 +0800
X-Gmail-Original-Message-ID: <CANzO1D0LK82JxLnARyamRTW0xd7sY-bYga=d8kqnuBzJ5fYEGg@mail.gmail.com>
Message-ID: <CANzO1D0LK82JxLnARyamRTW0xd7sY-bYga=d8kqnuBzJ5fYEGg@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/dma: Break the loop when loading descriptions fails
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Frank Chang <frank.chang@sifive.com>

Fea.Wang <fea.wang@sifive.com> =E6=96=BC 2024=E5=B9=B46=E6=9C=883=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> When calling the loading a description function, it should be noticed
> that the function may return a failure value. Breaking the loop is one
> of the possible ways to handle it.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> ---
>  hw/dma/xilinx_axidma.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 4b475e5484..b8ab5a423d 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -291,7 +291,9 @@ static void stream_process_mem2s(struct Stream *s, St=
reamSink *tx_data_dev,
>      }
>
>      while (1) {
> -        stream_desc_load(s, s->regs[R_CURDESC]);
> +        if (MEMTX_OK !=3D stream_desc_load(s, s->regs[R_CURDESC])) {
> +            break;
> +        }
>
>          if (s->desc.status & SDESC_STATUS_COMPLETE) {
>              s->regs[R_DMASR] |=3D DMASR_HALTED;
> @@ -348,7 +350,9 @@ static size_t stream_process_s2mem(struct Stream *s, =
unsigned char *buf,
>      }
>
>      while (len) {
> -        stream_desc_load(s, s->regs[R_CURDESC]);
> +        if (MEMTX_OK !=3D stream_desc_load(s, s->regs[R_CURDESC])) {
> +            break;
> +        }
>
>          if (s->desc.status & SDESC_STATUS_COMPLETE) {
>              s->regs[R_DMASR] |=3D DMASR_HALTED;
> --
> 2.34.1
>
>

