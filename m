Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930CAD1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxHO-0003Tg-GB; Thu, 08 Jan 2026 16:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxHM-0003QU-Tr
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:10:48 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxHL-0004f1-F6
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:10:48 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so25334285ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906646; x=1768511446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8yP5uNYW7nIEwrfc3EvsDrK4AQeA5AYFBexT3EhSF+0=;
 b=nQbl1NI4NPHScojUtjbLZfwwh9rjbbc+rvaGaKGVbiD9Lxw0HAebIiWPRRh+t9yXuu
 Vk+5NPn+ynDLi1zoR8l/wfxE/vK0dPAYsDyQEF4LPb81pZU2ga4mn4M0/M1AX3gCUX8P
 QeYh0KTZV/Su5gnAh4HoDE5FxqXi6Kyk1ifDYDYwzjdHhPqNtmIjc02xl1wSA8hbDRBA
 1uRTlEFSgrQVprlEcC4EGj0PHBb/5a66sUfOjhkDdCwgKg0iSwg/Kl9qVdpNrxZ2EVPj
 hT5bNY/vIGYGaG6LSMoW0W8vPy4WxQiSROHQNlyYSpgSBLOekUvqpUJPYUqDmSwYfxiC
 fiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906646; x=1768511446;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8yP5uNYW7nIEwrfc3EvsDrK4AQeA5AYFBexT3EhSF+0=;
 b=Dz0FBWcfrSsO9JCibjNJdw/7R4xl3BN1LRvDHYOeqr7LElOtew4AsPrdVTPiI5XDrK
 SYIDw2pD2L5OJJSb1KrmkAVysGdx50S5HirYLrEqXAj5YBSZt1hijmp8V5Fdpl+/5stY
 SXY5uEUdLJYt+EUQeDB73PYnM8O6E1ML412yD5Y4Yh+fH/aC3WWP73BZxYErOHzXC4vQ
 9lb8qyJQkvlgviqc1SkKXHIoWF4bTEuDdvy/worMfDN/Cvakf6AWApmjX+BIXmQj625x
 Tj4UE9klusvovp8CXElVQ8DBkIb5Oei10ne5Yw4yQVhcvQZn0SNxra1Q6fU9/cr2jIE3
 1+SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw9w4cvjR7dVI2aei3tqwAaYDXAMpIaHkLLici8TUmYcDBUYDTUsGp8UErqKjwwir70YLs+6IbPdB/@nongnu.org
X-Gm-Message-State: AOJu0YyGKkKjqWRmo5AAdC+QyOylI6/lN7zzNb+jj1yezKM/MyuRlioP
 dvHRRUQckfMEzmSHPCrzX6kX1ZfHId1ysdnICpCQSjMI5QkXu043gkGdPzMGluZKXOSj0rO+guU
 Yj0I0
X-Gm-Gg: AY/fxX7K8TeJuZwNHGkMMt/4eZPLsAuc1OLPNFHn/ls1xH0YEExB2eBY/u37DhQ3mT7
 WwacOvJUxDkFJGRifsBn/AEuKgTXMixYuNb44rYYWww1i37V1SYLKfs3Q3KxdQYjVo4BytNA+7Y
 q873MbeqmMKnuDg9m49gpQsasEPSRIYlTfQz3gAsWet+kwMR2ucYhoYs+Tyi61QWtUW//IUyZPt
 EteyGfz4DK2TN433YdBCnyulUC+LEOBcb2uGBhlO9CfVUBFHI+KgwRs/jgIT6G7EaCcbk9P+zro
 uiwYQRC8JmKmUCmUMkcGdOWKVqKF9HXDu61yWACa6ExFc7/nz/DMXi0bbiE5Fnlkm+s3w+gWppC
 yQEgL9ZyRuezTVoW427yP8H+SVG6pfAZWAB/t9AFktX37QHUtjJiV/tbRAf1Rqqutu91jZj0iAM
 xRPHfPOuE30NvHGXiXv2P5pjjSDMBoTZ9vYfleH6OBv4L0NUvEHnjOjn8GEX7UTWy8eQ8=
X-Google-Smtp-Source: AGHT+IH/jnmkZ2Nt6H9Gf+8TbiuBqYki4i+X0mNNGXYwqeEwDUgnOyRLzX5WcN7slrCNK9352urIzA==
X-Received: by 2002:a17:903:198c:b0:2a1:243:94a9 with SMTP id
 d9443c01a7336-2a3ee4bfd40mr61817545ad.53.1767906646038; 
 Thu, 08 Jan 2026 13:10:46 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c48c0asm87797355ad.31.2026.01.08.13.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:10:45 -0800 (PST)
Message-ID: <55529100-85af-40ae-8ac9-68c2966c298d@linaro.org>
Date: Thu, 8 Jan 2026 13:10:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/50] tcg: Unconditionally define atomic64 helpers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-37-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
> CONFIG_ATOMIC64 is a configuration knob for 32-bit hosts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-runtime.h             | 16 ----------------
>   include/accel/tcg/cpu-ldst-common.h |  9 ---------
>   accel/tcg/cputlb.c                  |  2 --
>   accel/tcg/user-exec.c               |  2 --
>   tcg/tcg-op-ldst.c                   | 17 ++++++-----------
>   accel/tcg/atomic_common.c.inc       | 12 ------------
>   6 files changed, 6 insertions(+), 52 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

