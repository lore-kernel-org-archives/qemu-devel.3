Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E90EC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCx9G-000162-0W; Fri, 31 May 2024 03:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCx9F-00015r-8v
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:58:01 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCx9D-0000Em-KU
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:58:00 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-578517c7ae9so1797335a12.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717142277; x=1717747077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0FPbme4mrDdu2AuV6STk20W9Q3AuvLzNIymDd7YoCWQ=;
 b=FQcqs2uxnzq2p1K2YDKLxLlq+epNzxjaRYqtg9SZsLpc8A0lS+67tSTuoMqSDk/Jeo
 Xxqui6Sri3j9rbKv5IYr7TXihzh9dgzOvhGEr31+0A0WzEOGPFNjS6CADhz3PL1iHzZY
 jzRrbYz8Y9zmeyra+moJzaiFHegZjOXBCD4rykeyDAad/XG7Y6Uc1Jcu5O5Hr6r6/8M3
 2lXZBk4Z/qY8RdJwsEB23AEfY8oDkueXV4FfysWQ86W2GLoMEaIJFPvjhU3fGl/E7CbX
 udaQTfYGSW58XTZwSw2S4D/th9EdH/yZ3qEESBnk8Qs3tbBEVtXAW+FSvbvL51xt2oH5
 QLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717142277; x=1717747077;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0FPbme4mrDdu2AuV6STk20W9Q3AuvLzNIymDd7YoCWQ=;
 b=IdOCsgH1IRGY20oIoklQZ3I6nB7ohMvojo7d2f9tFOZyEe5jH2mcGnhDGUYkFCh1/r
 2wDQeKkdJgLjh9ekbsUjUJotlZymLvwpxTcp3QOFoGT4H7ZUkR5jHx7Kl1b/Qw9PNV2w
 462ckIq5hMxzH72tM3oaJuNNoxnjEd/BXnO2Xt3dwQYTTrr1Sv3j4JGGL7/JYRpA9M9x
 QP4WLHh1dUfXp5sicniTMUWWEHFxwzlAHco4lXYEPvHjwJrS/Wi7aUht+rREnUIkFPY4
 C7RUEcBXuIen/uQprvTXx0+NqfsqCJM4Qjub3Wzkii1cf0bsyB4e10WSzEUCwQlkjrmh
 BQyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP7csMvrxjHDEsDQ12A3SB+lHHUr927NbMOYAGwq15gXCcIEPjN1PCIe/AJdkyanvCp+8nvWhynwwpL14y8JY3yypzkxY=
X-Gm-Message-State: AOJu0YwuT4IdD3WzZDenaRmfgiquoCuMTv7OUTrTEQYmOCQLLmH5Dzv/
 sRTPEWwUV+eIaHcTQBCVdDDWAmq9LlBK7LyG3NlGojdii5W6YUWnri8m/0u+jWA=
X-Google-Smtp-Source: AGHT+IHY3VXKRgaTsYk+86z6akC1WupRa1wyo0KTl6c+RidAH3GmU/McGM0d03APCfJ/X5LE9mBvog==
X-Received: by 2002:a50:931d:0:b0:579:fb79:309 with SMTP id
 4fb4d7f45d1cf-57a363da21cmr705373a12.10.1717142277264; 
 Fri, 31 May 2024 00:57:57 -0700 (PDT)
Received: from [192.168.69.100] (sml13-h01-176-184-15-35.dsl.sta.abo.bbox.fr.
 [176.184.15.35]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31bdfd9bsm694087a12.41.2024.05.31.00.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 00:57:56 -0700 (PDT)
Message-ID: <81f8c7f8-a4a6-4f74-894f-be3ffbf25f9d@linaro.org>
Date: Fri, 31 May 2024 09:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] osdep: Make qemu_madvise() to set errno in all
 cases
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: david@redhat.com, imammedo@redhat.com
References: <cover.1717140354.git.mprivozn@redhat.com>
 <e2250aa1d69faffcfd12b6d809d98b0c8157ce36.1717140354.git.mprivozn@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e2250aa1d69faffcfd12b6d809d98b0c8157ce36.1717140354.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Michal,

On 31/5/24 09:28, Michal Privoznik wrote:
> The unspoken premise of qemu_madvise() is that errno is set on
> error. And it is mostly the case except for posix_madvise() which
> is documented to return either zero (on success) or a positive
> error number.

Watch out, Linux:

   RETURN VALUE

      On success, posix_madvise() returns 0.  On failure,
      it returns a positive error number.

but on Darwin:

   RETURN VALUES

      Upon successful completion, a value of 0 is returned.
      Otherwise, a value of -1 is returned and errno is set
      to indicate the error.

(Haven't checked other POSIX OSes).

So we likely need more #ifdef'ry here.

> This means, we must set errno ourselves. And while
> at it, make the function return a negative value on error, just
> like other error paths do.
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   util/osdep.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/util/osdep.c b/util/osdep.c
> index e996c4744a..e42f4e8121 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -57,7 +57,12 @@ int qemu_madvise(void *addr, size_t len, int advice)
>   #if defined(CONFIG_MADVISE)
>       return madvise(addr, len, advice);
>   #elif defined(CONFIG_POSIX_MADVISE)
> -    return posix_madvise(addr, len, advice);
> +    int rc = posix_madvise(addr, len, advice);
> +    if (rc) {
> +        errno = rc;
> +        return -1;
> +    }
> +    return 0;
>   #else
>       errno = EINVAL;
>       return -1;


