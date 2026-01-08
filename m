Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8EAD1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxKa-0007Pt-KR; Thu, 08 Jan 2026 16:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxKQ-0006tX-46
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:14:00 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxKO-0004wf-Q7
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:13:57 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7b852bb31d9so3197910b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906835; x=1768511635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z/Tk/nCOlgh4F3t7KhjTuQslX84ag34QR+cWUOYtv6U=;
 b=zutMUlZP3SMmgKf4YjKwQlfPxuoH5vNPITwwsTpcoXIstZD3JPizpHtmClGiZwdiKM
 uLNNAl9APZIvxm9DgQESUJPpdTFikesCkCrLuhs52r1aelei1wSFed1D05SLlj5S/DYP
 zC2TfWnYuiqr7CvwBlnNprSzIo5upIo6tpsSn2+2nVHNrzFgDK4ma6G1zZjgY9UuDLv+
 ue8WwX1Brn4qsyr60aopV4ZoRujS3aC3fsk2/C9PVKWvOg1NK3hAtp6W88yt0ahxhI7z
 dtnqIMmq3q2rrE5Knyl5HTVlBqGuxMm38DcMy+AbSgI/D8Y6mrepLVUUlDDTaovGpE16
 eFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906835; x=1768511635;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z/Tk/nCOlgh4F3t7KhjTuQslX84ag34QR+cWUOYtv6U=;
 b=eFJBwHZ/z/33FjqBxsV5U0hNs0NYiaL/AsWW0+nbJgZqeGAk/xoqWOIH1VwS6roPDj
 ad4qzvL/c1huACeuKAvGPrA3gCeRGfEZE8s2cMMLsAgOgKWhwLekdKsKyN9lqXDJIV0O
 Ey8pYaQ0vrntFaCkJ8CfK4SS3i7LZ+hplSZu9il2j8r0NydR7WSRMlcmY+S9gUXXrnvM
 Uocpjx06pbtu/fKv9+RQPN8qHz7EvfT4ExjuuIRoYsHa6uXpGyTRCcnC0O1k/jJKOjaR
 seY7+dCTntnTykd5hN3xvytmTTNDuJ4730+S7KNwcS2mfImNdB/Veesylg7TqOC2r3dI
 zrQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK/FRhhEH9FB7ep9eZeXHj3mclcaMo1LYxScXUJYcRqfDX4MN1j0gFFQoAqYT/PRblKckpTbEwrs03@nongnu.org
X-Gm-Message-State: AOJu0YwDAu6rVuGYT5H1PPf8jBUAo0XC5lxBQ04c2zDBYZML1KbTR/Uk
 D8YhwO3X8iZlsQo6E58uqYUJVzN+e2f0kP5WL8Djty9NxaligVCbDV0SX1bye1Dje21orDogljR
 wH8CL
X-Gm-Gg: AY/fxX5QuGi3kujnUugqhUGHxMklX5k33E/94lY6gCYHh0oH6crgn0y0NHv/q3ZAVWY
 3FCn8q9q6Q8WJik2mheXHKtWCx4DHTYHhhgRLAxC3lhseewf5UZUoDC1nUwQCnMBY0au/8At3Xy
 IxpK20eL/KHffTgH0ytqivEP/vREIx1jZnq7lNWSkUYT8ir30SHCPXiyoS7nNYDXqHJs5CbyZww
 ZBIwin0oWnV9LD14zCC5CIpGuo7FszKxt4UJbMRWuZeaHJM3y0bwk52uQg7nysz8aOS4KUVRhhf
 Qm3DqjbxfNHha8HMud8eCNyg6exk3YYZ6OexYRb+bYDuOWpEAXe4k/0Am5Ep8efhTYIB3VaWb6Y
 iYgYkM+NmMbQmeuwRmO8/Pmc04O2MRu22C9U+7s8BSNCfF7akjlb6W2fi6biWaMThk9UCLmUxil
 aneihd/KyxwQiwTBe8Z5kKVzlRTUGEzXXYl6fadYCmxlqmfFo93IUkCBkr8mzNyjeN0N0=
X-Google-Smtp-Source: AGHT+IF5S/AGvmKPH9CM+hpCcnLYJj9eex0jr3KW8eQh8jaWzPEBZZXE8P/WtiNjDhkv2cG7PuHV3A==
X-Received: by 2002:a05:6a21:6d8c:b0:366:581e:1a07 with SMTP id
 adf61e73a8af0-3898f9bc617mr6852055637.60.1767906835244; 
 Thu, 08 Jan 2026 13:13:55 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9004019a12.14.2026.01.08.13.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:13:54 -0800 (PST)
Message-ID: <e1855084-3fa7-473f-82a2-d6b11d07313a@linaro.org>
Date: Thu, 8 Jan 2026 13:13:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 43/50] target/m68k: Drop CONFIG_ATOMIC64 tests
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-44-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-44-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/op_helper.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

