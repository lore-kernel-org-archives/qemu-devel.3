Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9A3E9D827
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Xf5-0002KW-6L; Sun, 05 Apr 2026 20:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Xf3-0002Gz-RX
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:17:49 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Xf1-00013h-8W
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:17:49 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c76f55b60c9so53798a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 17:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775434666; x=1776039466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AtnviJp+2muoxufXBtF0SaxTB4NWwJqF9sC+sv2x/Ig=;
 b=VgjvydGdngI5JPu49M/uM+IBVm1dNcdD8oXopA5bk4nANE0/BNwJEgJJjyumO+f6BI
 ry4A50wclOtA4TQ1h3oQeQaxxiieiZJcqd32YYvo9+M0tFuVdcvpkOaEUkEpsxx3OxFI
 04NHhlbr5JFX0zteaAxa3u6s6YFhrh7rAGR3/XjBUVLtMf7CooNi+8OYl6M6Dvn6TN5B
 hd9th0aOThNFmOVQz7Pb5PJU/eq7qYYQRSfMucsMEyIgBOCE4NVEeF1D+KoUqldfk77x
 4JGZW05u/5iqFOUVEZqArdjtOWIoTw1Lh/G4kzRvkgGft9ylsqXIMrAlDafew+34mkXp
 o3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775434666; x=1776039466;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AtnviJp+2muoxufXBtF0SaxTB4NWwJqF9sC+sv2x/Ig=;
 b=oThD+xkPAgJLgTUF6C3+rxq2Nbs5cn+0vcohmVUrfeBXD1sJwHV2JHXSfm3O3BOwhE
 VQVEVD17ozBv1JmVMdYhSa6ZSjd8bu1pMKaub7tAxYOba/DoDMsVefa+g6PzQHyckEjX
 +ZpQoobz0nPONf8y6xHvM/dtKz4QLXIRBgFm56sGl9adadEhY6lTNjTaSUiA1WX5r1XD
 NQvRNeOYtMBTeWy59fUAQbyC9OzTZTcRdlkeCZsG2D1bzSuEcOXn7/6lD1gcnUFXxZmS
 Nb73kFgmF5nywdywF6HU0Fxv4mga9BN4cpzjscB66Vnjx2wKpADFoWTSWcWUC43QYBmO
 9dWw==
X-Gm-Message-State: AOJu0Yw9coYlpXecSoKCL6YbxWb57b4i2IDQRtQGKYIeeX+MpnP/K/8+
 6pEOi94ZeeILagjVdtCNcmBHdtwxOnO1bbAvYGcQ/1OYBLDZEJ0T4+Wp8xc96ROrQx9BMLzP1d0
 hNCsV
X-Gm-Gg: AeBDietyjeSRd/Wc2P13UADWpE7G3+Amzm72bClteixbpWcw3yi7jCAdfkr7ohxjdrU
 /SjQijOME0du1Z/Ycv0wwPXSHK9d/PRFtil4iNnRGNaaDVhskR30MBS5gLHP3Ygm1augbkhtSXO
 p2gFS6KC6sljpE4BbfsWZcX7lefxlmiBmE5BmOKFLqnbdBWcJsAi5dGQQUu8Z/PrxtwLYELFKE/
 hBeLePAjsniPkQFGh2RJGCKmkyUoAyQI5dya7WPyvuliZ/rk22yJgeDM0+bSnqF18VFkwhpg1Nq
 SX+iGfKfCHxjF4Uunsc2mz0fCEzYbFgfSbqF4dCyaYg2W8BPAKtcyWTF5P7PnRQicnuDyeJs2OJ
 wFaU0l9bmuIzX5wa8JV4c+J1I2jLZ3vrjoIkLobgVDd9OGaTLlFALrgIvvlRGBS87t+TDxbIbVe
 nz56M0FRweW8YBmpmcMCTjmjwiFw6HyvCRIsoIM1a1r0Nd/FEXcnFPMtJYfKOF9F5VHybSvVD4c
 xmIkw==
X-Received: by 2002:a05:6a20:da11:b0:39f:3ca8:a315 with SMTP id
 adf61e73a8af0-39f3ca8b4c2mr9261309637.19.1775434665643; 
 Sun, 05 Apr 2026 17:17:45 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c6fdd7sm12225820b3a.48.2026.04.05.17.17.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 17:17:45 -0700 (PDT)
Message-ID: <f8294bdc-1af7-463b-b143-79fc4aafec69@linaro.org>
Date: Mon, 6 Apr 2026 10:17:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 22/35] target/arm: remove old syndrome defines
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-23-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
> Now everything is defined with registerfields we can drop the old
> defines.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index 4fbc35ce7b0..1887467b719 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -106,16 +106,6 @@ typedef enum {
>       GCS_IT_GCSPOPX = 9,
>   } GCSInstructionType;
>   
> -#define ARM_EL_EC_LENGTH 6
> -#define ARM_EL_EC_SHIFT 26
> -#define ARM_EL_IL_SHIFT 25
> -#define ARM_EL_ISV_SHIFT 24
> -#define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
> -#define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
> -
> -/* In the Data Abort syndrome */
> -#define ARM_EL_VNCR (1 << 13)
> -
>   static inline uint32_t syn_get_ec(uint32_t syn)
>   {
>       return FIELD_EX32(syn, SYNDROME, EC);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

