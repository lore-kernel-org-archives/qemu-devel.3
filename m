Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF823E9D826
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Wtb-0007GC-KS; Sun, 05 Apr 2026 19:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9WtY-0007Ev-Rq
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:28:45 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9WtV-0003aM-Ny
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:28:44 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35d971fbcddso1987292a91.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 16:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775431719; x=1776036519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sqJbMnERw4O5quG7FAOz+Iw/qKFIMiFLkqAoe2kSYqg=;
 b=t2x4Fu+IpHdfLZIFDLJ3YvXpXtcAyFuo816YlR9eCFwo0LPoKKormaiCfk7F255klu
 ywemPkWP8t2oTFOVMHlH/YQXJluMlaoPHfnGGJoznBpq+SrYfYPFl2o3rp3fG04WUJuz
 bkexNBlX2bkkfScOTBHGsqiVXSyHFpntU8D5GWTohG+d8z1v1MxMVDAEN1gbDGhP+Yh2
 4jMCr8DffhW+fQUFCkpsHuRTKTbW0K2AMYYfC/nlZLNP1FS3gsFRd87kDdRN1FdmdNoU
 ean4mWr8PQBBuOws4FOEyi4l8rEQSiNktUW/DCNZN1EDlDuzqU/Vgg4CJmXkLJz8NH3o
 Ph9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775431719; x=1776036519;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sqJbMnERw4O5quG7FAOz+Iw/qKFIMiFLkqAoe2kSYqg=;
 b=B5Oc0Ca1ZB6mPs+8BNSqN0iB4hP8iJs+aJTxGqnEcvuw3xrl92GkAuq5Gu3HjcX1Fb
 usgM7GEne6ivPhToCf8V94WHlLpU6PG6PSGnIu3R3hkNqxPeTHXaZfwVtq/EaCQNX1Vi
 eh+6pQZlv12mhkoEDIofgoCl3qa8XD609gdeo87Uz/md6Do3PGDKnAuMiM9rIqyxF3TQ
 7LgVW7saWDMcRNTAq+UhPVo8OUaZ1KGIvR28KMng8yOvfpqKAW1QbdTw87B1Mt0xy1W6
 K7aMdg2KpXuD7wnMMcMG+auMzZj2yvA8xuMrjBlTAHnUXCmtM74Usu12hu2k6OiYLTcQ
 BGow==
X-Gm-Message-State: AOJu0YwPaSGa8iBK5d54yJ8KyT3tGVCkMSe8Ycc9CoirhcDGm20IDEYQ
 iIDZYAYzhBcOViX4TSIBSFVdiFJ5+i+R0TjapKwp3NO4C0wW7DezA2mAyoR1jgNmcIYpczsM+3U
 qE1eX
X-Gm-Gg: AeBDieuKTLafgogxeV72WXl+Zm+dRwAcafh73LMuYuBHHs8085QT3QWu1bc4y59hfe5
 sEYRQobPNs7bd9NudziKEiqf7M5fwz7GEs83cTDRuhuJ9BshIiNwdq2jQe956Un0JCxi/G3QGtS
 PFX6i60WvOa6oHTQ91hPUKjcRcpkD5bd6x2zTCiUCKz+/nZ1L/fFK3Jl2feqv07zS3+01vy8waX
 +lzAhpTU8H5NCSok9QwNSkLs5pveH2sXiiCZrmbfYIuxyXEhUtoifK7bpKTk2ud4UqOG5GRIzue
 UaXqkLOHbHgoWcvMoUj+9IS3PplAn3Eb0xMWdq1GHuHjPKvB6LQ3K7LQXsLYnXmbeMt0Ff1DSKK
 Yl727iFsQ4yYm/obFNcqZaYm5OMjkk3tralrpEljpCHBn1V5itHQq3eXvElRRS2EVtb0sqwmfQH
 QKfxjjzQy/7As38AoNRlneaeeWIt2e0MhruQqw1oQghXK3SCemToArlTu15Uf0hOcLxz4=
X-Received: by 2002:a17:90b:2ec5:b0:35b:9e53:e2df with SMTP id
 98e67ed59e1d1-35dd67263f9mr12598199a91.2.1775431719556; 
 Sun, 05 Apr 2026 16:28:39 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c657e703sm10517142a12.22.2026.04.05.16.28.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 16:28:39 -0700 (PDT)
Message-ID: <041ddc08-b65a-46ee-8b6e-e1fd0ee5ad95@linaro.org>
Date: Mon, 6 Apr 2026 09:28:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/35] target/arm: migrate BTI trap syndromes to
 registerfields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index 19c7659fb4f..0520e51a686 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -426,9 +426,18 @@ static inline uint32_t syn_pactrap(void)
>       return res;
>   }
>   
> +/*
> + * ISS encoding for an exception from a Branch Target Identification
> + * instruction.
> + */
> +FIELD(BTI_ISS, BTYPE, 0, 2)
> +
>   static inline uint32_t syn_btitrap(int btype)
>   {
> -    return (EC_BTITRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL | btype;
> +    uint32_t res = syn_set_ec(0, EC_BTITRAP);
> +    res = FIELD_DP32(res, SYNDROME, IL, 1);
> +    res = FIELD_DP32(res, BTI_ISS, BTYPE, btype);
> +    return res;
>   }
>   
>   static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

