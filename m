Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAB2C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOB7-00007L-G4; Tue, 04 Jun 2024 03:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEOB5-0008Mt-JJ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:01:51 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEOB3-0006fv-Sq
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:01:51 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52b82d57963so5325989e87.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717484508; x=1718089308; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onYLLgU2otqdzJpJbj41dXVqS1O4Z84VNROnkX7NwnE=;
 b=KRMVp9IW4h7HkokHE+Q3lYICGujsMrtefLWdbs3ZEEzvGjszbJ77v98XkB7SRfLkHb
 iA8VyAgydHrsy5yLh6zK0eG+DGj43zRrMcx0MTjEsjuS4t2Uxu/jj5o5Z7FOvyjy7uG0
 qOkypoOhWf4jEi+FbwXeZ+vCtDAJb1kCJWY6kDk7ELwhgIwMlWgUH+uDnDPpHHVr+9QE
 bRNDUGsoD+x9koO8+nESAoa+2yLQHTVguoCFF4QBv8R4EoaY3EiENiznkHEQoGBwMR93
 wborIjGWStS78LydQDGvIGvRDdw67nMQjyiS/jIlOQt/TAUKsPcE6JADN9Crlx1S2Crs
 WRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717484508; x=1718089308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onYLLgU2otqdzJpJbj41dXVqS1O4Z84VNROnkX7NwnE=;
 b=ldKQVwsq2htHK6k6znH2+vlg+hJFOY5Sakshq3bT87z+yCrzUi8tXqXkhtdB7dtCBF
 QSyA8I6omQD5qz2sfnKNAHv3JpG71MKgQBr/fRu4HRZvOhVS/yDv3bMuPm2ljuApn/IV
 taKv6ipWxy/6LSaETnFeaz/4EX6lkYNy/LuzOokgIdNXioa5kFf+lhhGUoAI0vd1b8lB
 u9D6bolrqquRVxDvbnU/2HYeW0kiGUuSoPD9qJJbjIu6jM8W9ulbsPAYE+pVFZ/8R6mt
 wh+OR6ZHT69DkE5tuCegzGFB0fgkO9NBQqEMqMaI7l9kSGNCn+lBvnWVuixR1Fb8B1sV
 xPjg==
X-Gm-Message-State: AOJu0YxusAVclMalgFg+sPg9Y37zXP9p2op8nayyUIkVPhO2IazjsFCR
 lWh9rWqdo+NUwCkc+0G33YRtpNPmX9d0L1ZqAV2cRaIaNO+fJY/nOPxA45OO3WHEzNm9+nwGzOP
 wJ6pTUSP71tYb1k3nIzc6zLP5AGjU26zg5olwJ/2+Hx53U7AS9ovDxmIiiw0m4X+i7JEhFXXgyM
 pLi3aNDsKjr339qpcNC6fYQIGau4RLoaAgCGJuI+qzWQ==
X-Google-Smtp-Source: AGHT+IHNHh+fz+A0oQJs5keTLcebBOgOzB2eqTJfF8JGGHbSWlpa9CYVkuzg6DaR10rEc5mZScgM6Q==
X-Received: by 2002:a05:6512:b24:b0:523:8cd3:42cb with SMTP id
 2adb3069b0e04-52b8957ff7cmr6884184e87.7.1717484507868; 
 Tue, 04 Jun 2024 00:01:47 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52b9ea8ca6asm295327e87.245.2024.06.04.00.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 00:01:47 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-2eaa80cb573so36472041fa.1; 
 Tue, 04 Jun 2024 00:01:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWTKPwIFLKfCdKEecHW+XDKFHvm+nRibq3LJUA3O8FllUgfN4JkWj9j0C9nMNXc8q68zlRiSF9ySllryJVN0dCHSRt4BNFu1sdstNeRYzUpdu2hJERPbdPys2U=
X-Received: by 2002:a2e:93d7:0:b0:2ea:a382:67cf with SMTP id
 38308e7fff4ca-2eaa3826e48mr47887901fa.24.1717484507004; Tue, 04 Jun 2024
 00:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240603055248.3928469-1-fea.wang@sifive.com>
 <20240603055248.3928469-5-fea.wang@sifive.com>
In-Reply-To: <20240603055248.3928469-5-fea.wang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 4 Jun 2024 15:01:35 +0800
X-Gmail-Original-Message-ID: <CANzO1D1O94uSp--EtCyEF1=xaxq4s2R1BYuqf_-5ri-rSKOT2w@mail.gmail.com>
Message-ID: <CANzO1D1O94uSp--EtCyEF1=xaxq4s2R1BYuqf_-5ri-rSKOT2w@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/net: Fix the transmission return size
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x130.google.com
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
> Fix the transmission return size because not all bytes could be
> transmitted successfully. So, return a successful length instead of a
> constant value.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> ---
>  hw/net/xilinx_axienet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 7d1fd37b4a..05d41bd548 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -847,7 +847,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8=
_t *buf, size_t size)
>      axienet_eth_rx_notify(s);
>
>      enet_update_irq(s);
> -    return size;
> +    return s->rxpos;
>  }
>
>  static size_t
> --
> 2.34.1
>
>

