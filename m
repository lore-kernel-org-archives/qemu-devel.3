Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A695C5DF96
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxQyb-0002u8-7S; Fri, 21 Aug 2026 11:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxQyZ-0002tj-Ks
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 11:16:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxQyU-0003YM-GA
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 11:16:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-499b57cf2f3so6514495e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787325365; x=1787930165; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rnCcntW189FI4fRGNjSqBhA/1GR19fLfb5qkgt5DD+4=;
 b=H9ALR5nstBwFWkm18MyHp4fzFLYxBZWJ8NowrWwJ9PyAFvG7vI6NZpbGGS9dGw2Mrz
 91FEsWo8O0UC01igWuesjLByp+ql82v3JtFDk3zGhIPy7RAgiiWeQZoPhBf55OBAEikv
 3KADfMG5Tf14jMm3W/fniSBlM3NVhhA1eQe4ldBUwyjCS3dHfknoA2Uj+F4AIJAmP37l
 ZHadiXZoleHCm5K6Y6yEU50BD7+KWy9ZzNFbS08cZjF3vz9sJeI3rvafIDFV1/oDUMNU
 kcUTFKIGQI1Tlz3WUurpueghGtdiNvtGWrNr/dKanYZzrGGQO6xPGDeebRpyLvjsB/Ro
 SBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787325365; x=1787930165;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rnCcntW189FI4fRGNjSqBhA/1GR19fLfb5qkgt5DD+4=;
 b=nJERzRabWZkRjzvIgbr1af2o8Xd9sbdxdAHd0CUz4POTFc/F7XA1vTGx3RFMD4YuBu
 lKLGHIrtSgrbLjl2ROvhXuiwbWvoMo5jJyM9xvseKCuyl1I9v6jvv2ka+fMmwVVl4hml
 ZGlNjit6dRLCgKygdwpWUl10BrI7xDvgnpA2bp/jyQiIV39GbsyhzFxgjdWmF/3QU++H
 DKtjHcDc93Hj7kNebQU/3JX0yWj5SUtaJGfMQUlVb2ejFBm5e2Q/kFYdl2NB1+ceNSWC
 63Dn1ZWc+/F7eoRwSBUi2L6n4dN+ZPtV7fYDDPzvshlcHcbkyqgOoueTXuNTCsTP/n0M
 S2MQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Roid1SGg6vvR6CcffCa5GZVvAYftycrfayjnxVelTqbTgngQohX4diU6Rexi1mq4JFXZ1tt6Xtewkwd@nongnu.org
X-Gm-Message-State: AOJu0YxgXXquYiVT+VgbXWCvxvWwcvXeVB0QYWee9fsAlaZiEMFjEm6N
 xd3/moHalZgTi/dKKXAGm9HvbncP4NJ+nNPSO+Gm5cWTSE3BiGHk0bzBo48V6CjT2Tc=
X-Gm-Gg: AR+sD10q3iFxVxecuVMG2LqOAk7M8xkMJL7HVVCekGaZ4lRw7IBzWa6czGMBhnDqnoL
 OFF2dbNPj082b9vztROEUBDyRap9W2HZneDnsdNihfOb6RkrVljyEdo75igMIC836MTWzRwhS04
 0RuqE4vjNc6IoAsVPLd81yjXDEZL0FlOh4YrkPnhYZPvOvDbIvRH3PXGJYBSuoYIjv/kg/r0N2E
 CFii5xGs0D8DWD4h0xC9JzGOOKk1LqgtrCZIYX4uYGAEMHRNqWL3PfHGPrIGyQyZAtIKUcbKY6U
 mBWH/cERVioRINLRI1xZo72nEBhBgrjlurwM7b06Prr3svrgC2AliWsbs2u16eR7nJj8pmxTnIj
 FRMjzXdguykEW7e/d3LBoJs++QyQp9mV7fHsU3bx695x1nWLiaiGAh0gyljl6dzaeN9p1M85jYw
 MzI/pVl6jrzEQ7CyPykcxVboLqWxFf8vLd9xUhrSp4wlvXqa7SE6azuTzm695GZew=
X-Received: by 2002:a05:600c:4688:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-499b91ad940mr63148695e9.7.1787325364889; 
 Fri, 21 Aug 2026 08:16:04 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:fa47:b339:78a1:d4c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b9bb47b3sm15211855e9.3.2026.08.21.08.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:16:04 -0700 (PDT)
Date: Fri, 21 Aug 2026 16:16:02 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>
Subject: Re: [RFC v5 10/28] hw/arm/smmuv3: Store CD NSCFG in TT info
Message-ID: <aohrsotM6aA417l3@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162446.2806393-5-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162446.2806393-5-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32a.google.com
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

On Fri, Aug 14, 2026 at 12:24:46AM +0800, Tao Tang wrote:
> With NSCFG definitions in place, record the per-table NSCFG bits
> in SMMUTransTableInfo during CD decode for later use.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3.c              | 1 +
>  include/hw/arm/smmu-common.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index a01175cc672..6b34f76f11b 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -881,6 +881,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>              tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
>          }
>  
> +        tt->nscfg = CD_NSCFG(cd, i);
>          tt->had = CD_HAD(cd, i);
>          trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
>      }
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index bd83648b14c..1aa4e3208da 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -83,6 +83,7 @@ typedef struct SMMUTransTableInfo {
>      uint8_t tsz;               /* input range, ie. 2^(64 -tsz)*/
>      uint8_t granule_sz;        /* granule page shift */
>      bool had;                  /* hierarchical attribute disable */
> +    int nscfg;                 /* Non-secure attribute of Starting-level TT */
>  } SMMUTransTableInfo;
>  
>  typedef struct SMMUTLBEntry {
> -- 
> 2.34.1
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


