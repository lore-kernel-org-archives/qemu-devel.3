Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D66D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 16:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZtZ9-0004jP-S4; Sun, 28 Dec 2025 11:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtZ7-0004ih-HW
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:24:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtZ5-0000x7-Vj
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:24:21 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso76853995e9.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 08:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766939058; x=1767543858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=US1Zg0/tKv9eGHW2iM+lDucsBa4cAkR1LWKQbwFbeto=;
 b=zr2eLSYo2xlRABgo21G/t9jKkXj//E8I/9VZiHv8C3BfqD4xHyXjA7Dv+dNRnjIBzQ
 O34SOOJAdH1Psb8aB+yfVxMyT6NFt97IQlQzTN+4i8EeaQzmj9nKiY6W3HqMVoIGsV1x
 mOV0GYkwbRPdnPr9bMU9oVJkVEraK0HL9SwQo9ZsVPDj8O6BuYJ3D5xzUvUj6d7uMck2
 mkIQoM3Mjnpt2nmuVoKS37wjT7dRLwmzPgcId4yjOJ5FWMmi495AAXihmGttyYSIcIbU
 cF3SSwx5hxC/k+0wVwfruPHQ6Zs6UiA2Iu/biPobOz2nNwcXn8646mHDS2RoQ7CbA44g
 Yy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766939058; x=1767543858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=US1Zg0/tKv9eGHW2iM+lDucsBa4cAkR1LWKQbwFbeto=;
 b=ef/P1wfXI1C9xXuGsLuuMiz4YcCDLsH5UtoyXQZzb1U/pyXuCez9HWowNmj9mYav6T
 ejQcHyXY5EjWbrpb9x0v6/tKwbDpoD7+Mx6om4a3V6i9xkqT7hd6YUT/A04cM9zONGo3
 U+YybyfBdLHs2x9q22BNH+00IihPbsLVZ2zXR1WcHS+imcYlq95LZWRFK9RW+NdgrHv1
 /k372T4wblS/LnP4PO2dAv2UljBbrtPNqdq+S55yj3siwmFCsOaACfURhtP9ZNRvffnT
 uAiqs46FxPrqsPl0rV+Eu3ua934gxg1ep6PXVQQLZCPjN8VGHEoeZw8jB22mIqr7Fi48
 yp5g==
X-Gm-Message-State: AOJu0YyYxUiNdf8LFkZ2izIxa/SgcdxT4Iqi0WMbY6Kw6azKLtxNaO45
 xSKZyEJn69epkzNOcxRNqNO5cet7Ya9TayGr7XGoeTcVj3jru8Fn6peZxsVr1ZHjXP0=
X-Gm-Gg: AY/fxX4giWpvHKgF8rBfZXmG/jJSo9yRF01FPr62Or3C+q1mREHjSr9oENs+zXAOF7z
 Kh3Gz26nVAL308bVhZ1Zo8sACc20bytR2tajCd3vVj+lMZlsAjCn7jkamRpAPg+098ws5Tylh+4
 DrP4LzCDcNOv1vBPfR/z06RAWW8FP5wGvGDEjsGMkSc4VVYgd9jN2CMRZ3SkcNJH16rZGNVKOsW
 bEU0x1e/8ea/fZw0OL4W8SC01wXB1n5xQ0iJndqq8u9T8zudCoLeT9Gpnc8KaDIdBMAcw6AQKnA
 1q9fPwDGU8RS1kWFbRYERtUz2S4xvnuOFEUE58OMI1rU0g9EpD2WdzR/GyRx8OkB2EKvv/lub1z
 /sZusXD9p4z+9Bi+gh+HfsbXR4bLVkLgVyBkADizrzWEv+A+67pOD+lpGOLGLGfR3V71vJp5O7m
 k/K52BekWLQOvw0zI+GBp7XSQHdfMjHomKJ2idfdXu7VaVkPQl2eKezE9dCwA+0Q==
X-Google-Smtp-Source: AGHT+IH6tx/3xaZWXUPvJvJclEoim4T1WxOUC8lnjY12g1F35PoZsTN7o4qCVX8je6O/4HlFXGdJVw==
X-Received: by 2002:a05:600c:4e90:b0:471:1717:411 with SMTP id
 5b1f17b1804b1-47d19595f54mr348787195e9.24.1766939057969; 
 Sun, 28 Dec 2025 08:24:17 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346e48sm484644475e9.2.2025.12.28.08.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 08:24:17 -0800 (PST)
Message-ID: <4a452081-8b99-49f7-b525-3722f7a9d756@linaro.org>
Date: Sun, 28 Dec 2025 17:24:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/25] system: Allow restricting the legacy ld/st_he()
 'native-endian' API
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-17-philmd@linaro.org>
 <CABgObfa9gHpK3CR8Aa6MA4YqfaMs3bn70pba58QQ2+32+xwxzQ@mail.gmail.com>
 <e0b99887-934e-4587-9410-b090a4fcfdc8@linaro.org>
 <5e44a3e7-5eb3-4220-9193-8eb86690535c@linaro.org>
 <CABgObfaXgpdPe32ks+xkzOuNxvJMJhsfpvtjFobBJTueR1X24A@mail.gmail.com>
 <913b7541-d8f0-47b9-8523-9e1389bf4f84@linaro.org>
 <CABgObfYXW7RqZjqHVQd8T-RfZvy8oxb7-uWK0Au1W5VXzHVSNA@mail.gmail.com>
 <1b73aeb0-fa3f-4ced-9c07-5f0accebc324@linaro.org>
 <CABgObfbquY+4KqQn+o5nKhWPuFJnOB_LYTJzVCjF-GgH8VcQNg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfbquY+4KqQn+o5nKhWPuFJnOB_LYTJzVCjF-GgH8VcQNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 28/12/25 17:20, Paolo Bonzini wrote:
> Il dom 28 dic 2025, 17:00 Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> ha scritto:
> 
>     On 28/12/25 16:38, Paolo Bonzini wrote:
>      >
>      >
>      > Il dom 28 dic 2025, 16:14 Philippe Mathieu-Daudé
>     <philmd@linaro.org <mailto:philmd@linaro.org>
>      > <mailto:philmd@linaro.org <mailto:philmd@linaro.org>>> ha scritto:
>      >
>      >      > Perhaps the source of the confusion is that they are in
>     bswap.h
>      >     but they
>      >      > (quite obviously since it's host endianness) never swap?
>      >
>      >     Hmm, maybe not well named API then.
>      >
>      >
>      > The name is fine, the placement maybe a bit less; they could be
>     moved
>      > out of bswap.h but it's not really necessary to do it now.
> 
>     Indeed not needed now, but already done to figure this API ;) This
>     helped me to understand what we don't need is "DO_STN_LDN_P(he)"
>     because this is a convoluted expansion to a plain memcpy().
> 
> 
> Without having seen your code, I will note that the simple conversion to 
> memcpy() only works for little endian hosts. On big endian, you also 
> need to adjust the first byte, like
> 
>     memcpy(p, ((uint8_t*)&val) + sizeof(val) - n, n);

Thanks, this is exactly what I had in mind for few replacements.

> 
> And likewise for ldn_he_p. (Apologize if you had noticed it, just trying 
> to avoid a possible round trip over the holidays!)

Thanks for your review and help :)

