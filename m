Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29FFD44172
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 15:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDQ3m-0001nE-MW; Tue, 19 Nov 2024 10:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDQ3k-0001n3-VM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:22:33 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDQ3j-0006Zv-C0
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:22:32 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4315c1c7392so31255335e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 07:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732029749; x=1732634549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6nlVt9VTKo3k9XhDxjO2RtOZjFzSTzxXt3u6F7QVO2c=;
 b=vy0c8jamDYPHS4bgnT5WAWKd95jIonlTr5cb53ptQTFWH6VXT+G+SLT/lp0tJfx9H8
 y4VuMk46HXESEsaiUEhVfD5UjVR15axOQokig82+LxRj2ps3ebi+0JcpYToR+56mIeF7
 A3QKhOr8SOexembP/y+YUZBMEUi+ZtSpAnfGuOGBvHMWMwZk3id7oFZzBjBjXX8/m+Tr
 F1Bsue3k/xzG2xT6n9bGS7qgKUwHhMl3cRcfaw2r+pqHI0lxZ6DOIZLgxipd70kOOLzF
 zMJ7Mzs45zDl1xRFD2dGzDbg9CPYtYMye4+tpjIS5ViYhb0rhd8/Ppy75RsZEcR8JD6g
 gZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732029749; x=1732634549;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6nlVt9VTKo3k9XhDxjO2RtOZjFzSTzxXt3u6F7QVO2c=;
 b=rSciJ9dgxrXllbl2kdrQlUCjFqSJbH14AUI4QhfSQTvd0Low2bxG7/2n84L8O0eqq2
 926wi74dAUAz1ddOasvHX1ta8njursT44MpgjKP/YY6c7JG9VbPFF/v4pzE2hBQUEBzA
 kOxHvBD0xrpyvzIRbekK467dX7gD/gqZlWLCknZQR0R91YxxFjZsYF55bAVO+kspfbzI
 cp0lLxxqW3w0NQOcsxZw7os+XBUrom24qFBKIw8d9hnWHbNvUMxGkicBinRh2Kz+B2P9
 dILIzmqgWPj24OIayMayIcaygCgj3puOixhbpLukOvDvfR7ZD2IFUlJFLhV5uFgWjjzA
 JYzQ==
X-Gm-Message-State: AOJu0YyYNyT1XsNZm3fXIM9liG1t6r4/tYEX6nHgt6m+lu+TcOo/LQp9
 u0QorQpuduz8U0OMMaa6s5UBCXlZtE7zymP0UB7rZi6Td/Pel+8Ml/QN+1jNsuM=
X-Google-Smtp-Source: AGHT+IH2nwetaj7OIhM+6XL9yxVyjFVajCO2HbqpCOykDvVtqRomzlHKYDTQQkVB4HyTzMc3dWK7rw==
X-Received: by 2002:a05:600c:468d:b0:431:57e5:b251 with SMTP id
 5b1f17b1804b1-432df78f4bemr121579795e9.28.1732029749180; 
 Tue, 19 Nov 2024 07:22:29 -0800 (PST)
Received: from [192.168.69.197] (sto95-h01-176-184-18-155.dsl.sta.abo.bbox.fr.
 [176.184.18.155]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac0ae04sm194201295e9.33.2024.11.19.07.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 07:22:28 -0800 (PST)
Message-ID: <95858d43-0cae-489b-89a0-46dd21476313@linaro.org>
Date: Tue, 19 Nov 2024 16:22:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 9.2 1/2] hw/core/machine-smp: Initialize caches_bitmap
 before reading
To: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241110150901.130647-1-zhao1.liu@intel.com>
 <20241110150901.130647-2-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241110150901.130647-2-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 10/11/24 16:09, Zhao Liu wrote:
> The caches_bitmap is defined in machine_parse_smp_cache(), but it was
> not initialized.
> 
> Initialize caches_bitmap by clearing all its bits to zero.
> 
> Resolves: Coverity CID 1565389
> Fixes: 4e88e7e3403d ("qapi/qom: Define cache enumeration and properties for machine")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/core/machine-smp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 640b2114b429..b87637c78f6f 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -290,6 +290,7 @@ bool machine_parse_smp_cache(MachineState *ms,
>       const SmpCachePropertiesList *node;
>       DECLARE_BITMAP(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);

Alternatively:

      DECLARE_BITMAP(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX) = { };

>   
> +    bitmap_zero(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);
>       for (node = caches; node; node = node->next) {
>           /* Prohibit users from repeating settings. */
>           if (test_bit(node->value->cache, caches_bitmap)) {

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


