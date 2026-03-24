Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653F4F54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52hs-0003AT-Hz; Tue, 24 Mar 2026 10:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w52hX-00031m-29
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:25:49 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w52hU-0004mS-UN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:25:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-486ff3a0fc1so34572055e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774362342; x=1774967142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m/tTx04MnKP3+IW0DzP9IvJRG7ff4bR9Q3P6/VdKyQM=;
 b=XTUogMQQI48tmNti3Vxp1aA9bCi7C9nP3xZXbKnNC0z68a27qTVwP0uT0BEwlgEqyr
 CHjN2cjsxq60Pqm59qh7Sw+JoF7i8u/YfUV6cp+mHyP6Avyv/2QSa2NZipKjv53xxyCX
 W1F/hAbfNfKYQWTsgnlPZSwGIWInc6hWViqH8rkABD4YT4tt2NDTfmK6c0vU6pmmi73k
 jbB/o3e5aUGFEbtwag3QAoA24cABuw4jLYqxiFcvrP+wUx/XVsdu6LBVPVIbqNG7N2ip
 +6wMkwjwvQfoFQ0vwqfcMEQ2yeBVev2tHX1QBeYrJ20TDtaTnOeklppLUGCTIUoD8/uj
 sk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774362342; x=1774967142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m/tTx04MnKP3+IW0DzP9IvJRG7ff4bR9Q3P6/VdKyQM=;
 b=OG3s0JIxl7Lgb5vcpmZtIN9i7qwWz5kL3E7w/j+6RcjSPC1+GdJEdETZiYul5vraHj
 EhbyczwmVeNuSUMRmQJ8uoqOtOQmXEWlh9J9TJHSYPxZzFDalv1V6Qjt9YOMFs4X2Wkc
 7Fc8mgJVp8EtbTN2HKDSjZWw59/rMMoprGBxBTAUwK+HpQYOSCFRO5Nk+OBCok5yeWm2
 /XqSwVsS3cSysLah2YSIgfHII/xx1DA2v0KCu/sgmbVMy8DpUjiMxTV+6heMTbM9xOCa
 gAuO/iFRiCi17VblGpDfoDFuN/P12TozUA65iV+tphzOUizZFETCOOxj8AWW54lnZVwL
 QAkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtyDBstFKHfCUueBJawX3G4iB/xrBfI/fG/J8puoIkFa6VGVWfjJR1elJL280m58o3WW7Ve07WQAmb@nongnu.org
X-Gm-Message-State: AOJu0YyUK7ExIaCPkWD3+gcOptPn3fiQhN+/d+VqfhtROtE8ZCzmwCOU
 bX+ZdeuXq8x3snewfdojcLL/d7rAdzAk0RrPNUOlRgSmRG0CcNYOGorxwb9YFqE417Y=
X-Gm-Gg: ATEYQzy6r1Nbja8CPsQUNSzfrfecTDrPL6NoODdyEyzVyERATcGZ9dXrClzGQtxiPqi
 RPmVZE3Um1lhVTbLAmpoIPLoIyauHc74iiDOJs7IEcnvsx05MYHR3SUJ/Zvn+QObZC8gYMVxCCP
 g9ZjvY1i15hF6wpBbuPBc/04M6WoRvhevlCCi5lgO97ddCvf8z9ZRL6fsQMSaOxClFJ15ExlKuz
 t9EUCejhGQCms1hn32bUIK5GfAXZ+OCKng7b5vVRd8Fc6RSG1jQ8PZ26pOswmnY/cduBIHEun4l
 FRrssl9sMoz44rbgS/dMvkdM9uwyEyYZuWJQOLMnEUgXDdov0314GCmQfa5BiCCUN1yHHAPEhc9
 FezxlVYK3Nt3YAulljUNijCPjHPJXvBtgO6qdxfYMFA3DD/Cb8BrqDrrqFc3fLvCGHzekls1991
 ZS8cRmpsuQkVGFjOD0S62v2l8m4CTgRjCylL02+vrC+xn2fj6rSpvoMCCJQ0E8IaUhGw==
X-Received: by 2002:a05:600c:19d3:b0:487:1114:d431 with SMTP id
 5b1f17b1804b1-4871114d548mr40196815e9.18.1774362342456; 
 Tue, 24 Mar 2026 07:25:42 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48714bc9ef9sm11244255e9.5.2026.03.24.07.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 07:25:41 -0700 (PDT)
Message-ID: <8f1052be-a018-4e3e-ad5d-7a5943a0357c@linaro.org>
Date: Tue, 24 Mar 2026 15:25:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] Run pl080_run in main loop
Content-Language: en-US
To: Tao Ding <dingtao0430@163.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <cover.1774099044.git.dingtao0430@163.com>
 <97fc49242d026d0784ee31816a3561dc6b316c8e.1774099044.git.dingtao0430@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <97fc49242d026d0784ee31816a3561dc6b316c8e.1774099044.git.dingtao0430@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 21/3/26 16:46, Tao Ding wrote:
> Accessing MMIO in QEMU will trigger pl080_run. If it is a memory to memory data transfer,
> it is generally faster, so it will not significantly block vCPU. But when dealing with peripherals,
> time is uncontrollable because it is unknown when the peripherals will generate data.
> This will result in continuous blocking of vCPU.
> 
> Due to the presence of BQL in qemu, mmio access and bh callbacks are safty.
> 
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---
>   hw/dma/pl080.c         | 11 +++++++++--
>   include/hw/dma/pl080.h |  3 +++
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
> index 627ccbbd81..3596739854 100644
> --- a/hw/dma/pl080.c
> +++ b/hw/dma/pl080.c
> @@ -232,6 +232,12 @@ again:
>       pl080_update(s);
>   }
>   
> +static void pl080_run_cb(void *opaque)
> +{
> +    PL080State *s = PL080(opaque);
> +    pl080_run(s);
> +}
> +
>   static uint64_t pl080_read(void *opaque, hwaddr offset,
>                              unsigned size)
>   {
> @@ -326,7 +332,7 @@ static void pl080_write(void *opaque, hwaddr offset,
>               break;
>           case 4: /* Configuration */
>               s->chan[i].conf = value;
> -            pl080_run(s);
> +            qemu_bh_schedule(s->bh);
>               break;
>           }
>           return;
> @@ -351,7 +357,7 @@ static void pl080_write(void *opaque, hwaddr offset,
>               qemu_log_mask(LOG_UNIMP,
>                             "pl080_write: Big-endian DMA not implemented\n");
>           }
> -        pl080_run(s);
> +        qemu_bh_schedule(s->bh);

If transfers are scheduled, they need to be cancelled when the
device resets. See docs/devel/reset.rst:

   DMA capable devices are expected to cancel all outstanding DMA
   operations during either 'enter' or 'hold' phases. IOMMUs are
   expected to reset during the 'exit' phase and this sequencing
   makes sure no outstanding DMA request will fault.

>           break;
>       case 13: /* Sync */
>           s->sync = value;
> @@ -405,6 +411,7 @@ static void pl080_init(Object *obj)
>       sysbus_init_irq(sbd, &s->interr);
>       sysbus_init_irq(sbd, &s->inttc);
>       s->nchannels = 8;
> +    s->bh = qemu_bh_new(pl080_run_cb, s);
>   }

