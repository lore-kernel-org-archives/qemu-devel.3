Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B750AC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 16:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSJJR-0005YM-OJ; Fri, 12 Jul 2024 12:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSJJQ-0005Sz-41
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:40:00 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSJJN-0005Sq-DC
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:39:58 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-595712c49ebso2787793a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720802396; x=1721407196; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAmL+2WJFU64d9q5El3dV1ssxDBVGOCQ1wKocizxaPI=;
 b=WS17ZJXQ3BKffkMMeGTL+jvlVJcTCwtHWePXjBpvBjTtmK0z4LUf+bp6fP8M2ERJBy
 3Z1NHJ+sfr3XYGyKKBUMOsd4zrdg6IFSwUiWfchBTSPIgQk/ghg51PaWwTiA0XVR4pBn
 Wfp4qGLzf2SsjI22Las6sMivpK6Tmt4sRctdysJIsZbUs+f1Zxn27OCeUyapsiLbLDrt
 ZB0ySL6j01whDOxyS/frQhlPeIuvQOw6YTBPrtrjRcyIy3aMiSU+et5oCwvFWcTHVBHU
 MmE1zq7GRt7Q00mGSlLiM2Hn/+w+WmdXJGOzgxhQYD/s1P9wuO/ltK0wJ1bmjtR6abfE
 u8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720802396; x=1721407196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAmL+2WJFU64d9q5El3dV1ssxDBVGOCQ1wKocizxaPI=;
 b=cnPyVQq1NxU1QG5gVVRnhJ36vMEVUGTK7zV2YsOIoPBRud6B9Qk3BTEy3L/fsvUJSv
 v45h3M9BAW4mhnCGffvh3lMZoBXC9Zxkbv1BL5YPWPdvSCHi70N/o6cTubYUgBnOk2xc
 8lqWDjXoarisrS9mFU7vnjGXCRPST39ts9ilGIioVwgBlMSja31TYuWDOEMa0nSl5Pvy
 cbVnvdXuL9iQkF2dVGwRnk44t4Zhf+rxGD0x8GstswcxcI7Vo3Puxbg87ocGm94Lha8F
 O95hSge69MmaAEGfZ7OS/VnxaY/WEGwD3g1af9BYt8N9yMiv2fkC0GifHTAZu8ZlWcso
 AxWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkzYkp29HcR+iEX+yojO7aEHSJLAeN7z7sW4SduO98CnGj3w6weDmLzwrmTpTQpItZGS0H9oFiisbqrRBFqMt16yBidYo=
X-Gm-Message-State: AOJu0YyEF7W5ilkWNWdWQBKW08gsa2KFfmnreWJfY13MC4RgDKj3AGMC
 PbtdhHeFb4IMEs1vfLs9XTf+pCBz76J/SpLk3b24rz+90t3HbLSW1Grx0YRyignE+UDmEKeV2wt
 p0++DOSkPeTJdm9ZwF0CpkL/OfJN/qqvENNPEbA==
X-Google-Smtp-Source: AGHT+IGsV7xA6MEZXkt0q8TELJNqgyUGwslZxfYcn67ih4qrpXMHKvnkUgWRTUQ2VtZvZLRRTI1iouJD7E9p7Qk8VIs=
X-Received: by 2002:a05:6402:33d8:b0:58c:f5bd:eb65 with SMTP id
 4fb4d7f45d1cf-594bb674df7mr7079634a12.22.1720802395551; Fri, 12 Jul 2024
 09:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240712163619.1734214-1-clg@redhat.com>
In-Reply-To: <20240712163619.1734214-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2024 17:39:44 +0100
Message-ID: <CAFEAcA8_UVRG5ihnSPzzA=hVmkqOO+ifOzrfECm07ebp3gU9Og@mail.gmail.com>
Subject: Re: [PATCH] aspeed/smc: Fix possible integer overflow
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 12 Jul 2024 at 17:36, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> Coverity reports a possible integer overflow because routine
> aspeeed_smc_hclk_divisor() has a codepath returning 0, which could
> lead to an integer overflow when computing variable 'hclk_shift' in
> the caller aspeed_smc_dma_calibration().
>
> The value passed to aspeed_smc_hclk_divisor() is always between 0 and
> 15 and, in this case, there is always a matching hclk divisor. Remove
> the return 0 and use g_assert_not_reached() instead.
>
> Fixes: Coverity CID 1547822
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/ssi/aspeed_smc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index b79815c2b8aa..7fd63669c10e 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -842,8 +842,7 @@ static uint8_t aspeed_smc_hclk_divisor(uint8_t hclk_m=
ask)
>          }
>      }
>
> -    aspeed_smc_error("invalid HCLK mask %x", hclk_mask);
> -    return 0;
> +    g_assert_not_reached();
>  }
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

