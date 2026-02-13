Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A26DEF99C5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqy3Q-0002lb-2F; Fri, 13 Feb 2026 13:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy3O-0002lG-I3
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:38:10 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy3N-0001VU-7q
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:38:10 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-824b32875e7so710305b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771007888; x=1771612688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dsxniZKSXRsmt3lFypn6uXPerovT/FynKt0hyd9g3hg=;
 b=pI1vyHw37n2aJEAfHq4hd+KSakjtWdkGX22N5eE3KL+JSjE9aAvOPbcoeYdL8s5nZf
 v2nGhHp/2Du5b0erS+xwdqXRuuArwq8Kf0C5eR3OTEpKEJa26yQqq5Heq9fvj6LL69/r
 lFa+HpKqfegEzkJBX/fkWQmsczunnUEYGHlgP2wU/JvMLsPcdtw4Rjec7qFbBCwEMhji
 jDUWVRL4ARiIdBx6z5cnO9z8fIloaoRsWQiGlZLc5jxEwBVdUfvVDJRLY81gALvyRdH+
 Frdmit9mbeT9qWKQpUcyrVRtq2vrPCQ/n6HPdl1T4aXZ8h6WsazhjEg56yi3GvbRn5p+
 nrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771007888; x=1771612688;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dsxniZKSXRsmt3lFypn6uXPerovT/FynKt0hyd9g3hg=;
 b=YlPhWNGuOb+uAkQHdY94pqKQyItbYw/Jfz0Xytg4q+xsBvo8GEuqT9bB3LW//gEGJP
 rx/WW4VxHn/ll5YN1agKWoJY8+si4hxEy5IAXvPvVR1BNiiXSNoyuYToj9p9hNKWEqhM
 v4Ya6DgvqEjhJPSBywJ/vFyboEohpGV10Weiz1DxU0GW9hfltVu2gRZ7pPgV3RIVLrXu
 YzszJWrxUKyBCFZjPAzaH0iwUo304jFgaOojL7+0sua6kzCw8pOOpq1c3UFHuXtq/CJN
 5PNZU3QRhWiBmn+h8ApJ5TLLZWCrBbB4N9cI8xneiJ06AF+PvVv4LxV+SbaZGzZUf/Dt
 gsqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOsF3QIsWHUNh3p31GFaK0j5EGHJ5tYnPTgKj1p2uUWADyiQLOT0f2BRs/fCq6NMfQce8hhd4sKbVa@nongnu.org
X-Gm-Message-State: AOJu0YxL0cf4SdiH/pOXUGFNsgu6mg49/gclq9f+0A5uaSPSipEV2AOm
 IG2leJToysCGHlviYGRS6DuQMJ7s7oRYAjrsxg01FiAfKzX5YvmWJ/iLbxMdhRjU45Y=
X-Gm-Gg: AZuq6aIwAUFUEjEbFaZOtx1/BZSKEUnc/zUZR56rU46hmYgUFDqoN1KOv/lcFrh5f43
 nLPPlcy1OyvtMs6WTFcofuvE/UwTRsH++Fw3FESmR3CWwUVMMP396rURv9Hmj+50nah8bzCsPrz
 IFUyKfXC4JMo9KzQL1YNARdW29d4CwLN+AJELywl3RJG993K7L1ZIq4fbzFiNkRRpV0en0+zdX5
 GpxNKwhEObUierkH3AtAlc8OYHdMcocvxtKygBRhwIHR2KlCsofwz94StIwMAjuG2caXIFxYiwS
 qP+RlFbOfJjoBe9mEBh97Pj6mghcMszbBh73H4OGAyYZSOcGlIYr7Zc4+UIRJHilyyLIJGIVrB0
 9hammDvop45c4+qWWYUpiZ7EAyvE/szxw3b1wn4TLPybgEUYOQ0vWBm44a3Ks1+8OpZYcTaqgun
 4NO2oPx6MZmciK+gTHMhp4JgPlG64fxdCRrNRD1j190x0tu05Nss5OvNYP1ciKwVjqxjSdLbS4y
 r6UWsY=
X-Received: by 2002:a05:6a00:2d92:b0:7ff:ecbb:1c28 with SMTP id
 d2e1a72fcca58-824c9517d4fmr2525220b3a.16.1771007887677; 
 Fri, 13 Feb 2026 10:38:07 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a431fesm3372078b3a.20.2026.02.13.10.38.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 10:38:07 -0800 (PST)
Message-ID: <aa1d113a-c14e-4793-be5f-46589f751f03@linaro.org>
Date: Fri, 13 Feb 2026 10:38:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] page-vary: Use target_page_bits_vary in
 set_preferred_target_page_bits
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260213182713.44924-1-philmd@linaro.org>
 <20260213182713.44924-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260213182713.44924-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 2/13/26 10:27 AM, Philippe Mathieu-Daudé wrote:
> Rather checking whether the target uses variable page sizes
> at runtime calling target_page_bits_vary().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   page-vary-target.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

