Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DADC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 18:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuc1f-0004So-4f; Tue, 18 Mar 2025 14:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuc1S-0004Qg-0o
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:50:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuc1Q-0002ls-24
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:50:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so25325455e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742323838; x=1742928638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pb8edXtU/tnxak4C/Cgcr8vuawSDN9htQBMBeu74gNA=;
 b=KKZz1562T0Hn9USNiEdT6Cq4h1tOaLVUqhqITYP3ke/K03+TmHXyz8HQnvTQQugt/+
 lH72BaHukX3iWVwuIuaJ2CD7RmK+zdnkkHt8axhcI/nOfcz+DynrA8l6yLEIPHWII3eA
 7tRAdDMIRFRac6rVxvHhwhlxhDLn2FKouLXM24GQR9roKr07ePnfniFzxJYHIAutV+uE
 ItjO431DBODXMI2mgJQM0Mga11mnKAWhS+W3rpJ5A52gPWDfnT+LPQ4ya0rIdySURIj+
 9k6vKfcy56f/jeQ4DCi5PFuPXu6ww1dSybtPuoVCcSMQrnHwkfK36NNdpbTsb/tgwFr4
 w0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742323838; x=1742928638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pb8edXtU/tnxak4C/Cgcr8vuawSDN9htQBMBeu74gNA=;
 b=QsvL0oCsxTnaPWYl6ufmaW+uzKj23Oklt9H2Khpr0eYk1wlkY07DO0j/aN6f3LeXT1
 epD9awrrM4wd58699rlknn2fytyE2cBNUZ41/kHtFylPgEBbI49wvgz/uk1KVY6eS4TE
 JRHzjM0wLlSFiK7YwRmzgqGuR9s2VCvMAoZMQKvHnqariYrSo4gAubMIAN6YPfYIZw5J
 aW5IBYhQs0pZNfMX1qUNKPqagyIoX5Y+8SLr7DtkHAptnCMrx2nHHQpSpU9Gw7QOdPeR
 GZUYTMke9hY96XVyj1dFu8nx1ozRvU3ZbS703volqfIbJqx4qLpEFfqjwxnhNTmFCgUN
 CckQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQrPoo1eU41doVWXtc/0nnPNN6kVok/1kY5Sb5uMLJab8CiFblw+Fmgd+hRxXz5kR/8Smaf4m5wThh@nongnu.org
X-Gm-Message-State: AOJu0Yx2sHN5xh66xp+j9D28LGs1L5Nf5T9R6OGjkeQ18YOsF/D0Eu1t
 17UY1IAm9QuWOk0Wl3Z03Z8lhFVe/l0GVZJksruZuRqIjlT5+eobiiP5fFhLaqk=
X-Gm-Gg: ASbGncvX1Un+ZRn4dyznCugGGC/qb+ZRCiIup5qLb8FGMPgpPIVA22Hg0IjcHc0PqXz
 Vw5QybXB6kmWfBb2Szg94f8uk4LK4yuLCbyHyLN5iG6/kEQyIw6+moGFJsKBhDZCN7wmNUV5njB
 d1OQ04yANxZRzTtziXF0WnPt0HTnYQNTR3h9UBwO4T9b14rDk/ljYKXV7Thwx1BZco+ZCnqkXoV
 R7aFVbQfEY5+H4aLvMwMHS5uiV4HSjyJU7beOaBdhF5RWN4Xk1jHhCxmWFKMlKx+ums/HGG0BmA
 BWtF+OAJO1zf4wF4vaQBfHEfLN053pKbmtIzxTRx30fC+tjqU6VCwnxR1Q+oi+mUJ5Lu4OYHqk1
 FrI2TTAG7zfE1
X-Google-Smtp-Source: AGHT+IHc6bB1TMekdEnRg8WWvTC5IvU6RseA1FLMd6Is9WRWqk3FY+zcYaKlvS8rTcAwam40KfJI/A==
X-Received: by 2002:a05:600c:138c:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-43d3b97f061mr32907705e9.8.1742323838301; 
 Tue, 18 Mar 2025 11:50:38 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe524ccsm142287535e9.0.2025.03.18.11.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 11:50:37 -0700 (PDT)
Message-ID: <a88f54cb-73be-4947-b3be-aa12b120f07e@linaro.org>
Date: Tue, 18 Mar 2025 19:50:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] target/arm/cpu: define ARM_MAX_VQ once for aarch32
 and aarch64
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-10-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318045125.759259-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 18/3/25 05:51, Pierrick Bouvier wrote:
> This will affect zregs field for aarch32.
> This field is used for MVE and SVE implementations. MVE implementation
> is clipping index value to 0 or 1 for zregs[*].d[],
> so we should not touch the rest of data in this case anyway.

We should describe why it is safe for migration.

I.e. vmstate_za depends on za_needed() -> SME, not included in 32-bit
cpus, etc.

Should we update target/arm/machine.c in this same patch, or a
preliminary one?

> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.h | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 27a0d4550f2..00f78d64bd8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -169,11 +169,7 @@ typedef struct ARMGenericTimer {
>    * Align the data for use with TCG host vector operations.
>    */
>   
> -#ifdef TARGET_AARCH64
> -# define ARM_MAX_VQ    16
> -#else
> -# define ARM_MAX_VQ    1
> -#endif
> +#define ARM_MAX_VQ    16
>   
>   typedef struct ARMVectorReg {
>       uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);


