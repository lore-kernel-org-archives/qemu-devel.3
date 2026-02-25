Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F1EFD45E2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 19:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvKkp-0000se-Dl; Wed, 25 Feb 2026 14:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvKkX-0000UW-Fb
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:40:45 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvKkI-0002Bh-Bg
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:40:44 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so108646b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 11:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772048424; x=1772653224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QdPCqf+ZgvZyaMYq7z8u2nsVi2kkVmJgqOcGRdKnmy0=;
 b=mcPfh2WqC2/DhEDViENFJuzxfeNQU1TFjKxBDd1TV6QaRzAK3vj0NSE+7sY/DyKuup
 Zefdor0KHpQB7w1mlzLLdJmm+F/WQ2H4oa1iJkwK5IMs1tvwf+G4qmdgIIc1Dc1AnxMK
 xbrLq9X2QlDGQRmuL+ei3fwfOb9OwPIhuNF5ylQ9MSl9laOopiktAG8gZT2OGD58/fOE
 59k2nJDxk91gOonUUX9pbFS4CDU8HaQLMgEYkZm2DCtJGEgQCyYl9mMWD7/gtLvTHook
 hl+WZ9l47sN/sd7qQhBga5p44Hpy/ibAekia5LE4yjzzUVR+I+xgdm3sxclfkJdXU3l1
 KiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772048424; x=1772653224;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QdPCqf+ZgvZyaMYq7z8u2nsVi2kkVmJgqOcGRdKnmy0=;
 b=nx9zoD1j8NgWxcYzqlsrgk14nK08gsz6Y83ZhBCBDx11M4UCQVerN+A/lDLAIptor7
 HqwGFsdnNMSUdIEotrxm23ZpHV1WCGXiSe7sIyy3iIZB0spaLa8vS3pVdvHBqHnNJq0j
 pgXo/VQFz67aQsarqhq9ohcdPBrgL0DgtK3Sn7FhbAs9Vkd8Ij2rSWO/b2ZXrn8ltTCm
 FylnAudvgvb+bnqj8vzxAY4ACpeM36okqbezSOIkeVH+djZhUZbyd+geIA/6XdTGNvJq
 QUoFBflpfrnLHKIkB9pXU0VvQ6AU1qTli8ELo9wMgdazjK1VEQ6/TCawydWpfxhFnCui
 dUUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvKGCmTjjNYbc55xIWjpkIB9jyM4AyQr6pgsfuUC9rJ1qU/bq0NtWFWGg6Erk5asTus5lqggiPzqjI@nongnu.org
X-Gm-Message-State: AOJu0YwTkJR8hwf18JkNoyx1No2lik+M22JCJGluSetqNOzhDpAyGI+D
 xc6EEqsgZJxwnVDswfyEWv+k688woDHCREfE+HqIf+q31oMJE9+USc35nD5L/LcxXt0=
X-Gm-Gg: ATEYQzzgsisR8WYDj9j2iUoqwLbHTrI9kS47+3vy1d+FG0hqPtaD+MnT6Wip2tdafAs
 3ygW6W5kKUw29ckxG3EsKYLAeQtSvtDSmll2NjgvM8I8Ng7duDXxmQEd5qnpQo28w3B/N+RVX9q
 ZpEfTAbdNVd5z76SLOPjWMNyDCQvcbzKn7UKxhr7y0Zejqf5KTIFvWMYyWx76qQszcc4IDk5I2p
 OUAPXDjJh6EqDUTn9jI+2IDYLXfGyYbD/ru9FIEW6PwKbwOHG4uuRoKn2cyYLnIUkdeDH3jXCuH
 tbrJBvS2GWTNjyUxH1kaFezzHT4QQwl8hkmqvkYoviHfW7x2zfKggzy602Wn9Cv2cP5r7C8MeIC
 tSLEghJwC6NF5YZL4GLb0Mq/kiTRIJ6wTPbQjwZlnU3K2zDQwEoIa4gzYoaWy6K2D0dadiK0yjy
 IurgSHXP6mRqoHq5ZXeh2JI/rlhVhSGz8jb+1PMx6UxD9oQ2/dgUxvzE/q4dO4gLv/xEV9
X-Received: by 2002:a05:6a00:2e11:b0:81f:50ea:5da1 with SMTP id
 d2e1a72fcca58-826da8bd871mr16961315b3a.2.1772048423601; 
 Wed, 25 Feb 2026 11:40:23 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739dabd43sm46995b3a.25.2026.02.25.11.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 11:40:23 -0800 (PST)
Message-ID: <9dab95ec-f4f0-4e5d-bec7-b773edddb3cd@linaro.org>
Date: Wed, 25 Feb 2026 11:40:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] accel/mshv: Forward-declare mshv_root_hvcall structure
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel@lists.xenproject.org,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>
References: <20260225051303.91614-1-philmd@linaro.org>
 <20260225051303.91614-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260225051303.91614-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 2/24/26 9:13 PM, Philippe Mathieu-Daudé wrote:
> Forward-declare the target-specific mshv_root_hvcall structure
> in order to keep 'system/mshv_int.h' target-agnostic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/mshv_int.h | 5 ++---
>   accel/mshv/mshv-all.c     | 2 +-
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

