Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E8ACF8842
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 11:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM2TJ-0000rq-M5; Thu, 20 Nov 2025 06:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM2TE-0000rP-Ot
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:05:01 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM2TB-0007Ji-M6
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:05:00 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so5073665e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 03:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763636695; x=1764241495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wxmpX5ymkR8ERQYzCU1wjvpFP+IO6VzFSxu3U5ml0mA=;
 b=r/5zpd3AwV+35qqCnBIKCDeiE3NB8np2mUD4PdKgkPRzX4/2N4xw8YHqwCUsoBJrGe
 oGE2mH/GXFXipnp1ufu7CcQUm4jiS8sM7emCmWxD69sxu0qjGbHFZqT6+xRAJUmtuNcr
 qbEqlh/aP1vFIJpexiGpQitXiDZljGndutTL51lv98mNz/RhLj95q3mq9mV2EveHQiRU
 to7ULzqBPJefh94FeHkAP9llifgROQtVyMmUnhxAiPsTacaJe25+KvPGagZS5NT/d+6t
 X+CPYMxaVSmNqN9/KEYmORYOcnD9oyrCfAujvcfbi+IG10cZrR95iJdHNOI5ko5SuVqv
 ADbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763636695; x=1764241495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wxmpX5ymkR8ERQYzCU1wjvpFP+IO6VzFSxu3U5ml0mA=;
 b=kO+hSWeKaS24Je9sPR01WL6Ie+BicOf1Anj86Mn3JQdfVH6GcBhFFD7Ha2PNaoNcpm
 Sa5WuhW1ftBX1KAwjg/n69ziLZkSMkoILpRy7jRppFApns9snz6cIusApIH4gtybDql7
 vmIu0grLGycROffD5qinqLbfbTZSisxViJgYGhhzIo/wrom13H6RQDxndmcIQGqiyyWD
 I9itr9Ow1/yEUUr8M3ZQB6lsB9tlrQ3ltc1qYVR635p1hcpzKbPLvWQi9gi60Ev3M8D6
 jlz+OZGvF0WNDiqvbf9NEtiUwZgfI9stF6OoJxDfWJ9vUsq4jksBqO9Z3m47KFjw7dAK
 c+Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmxgtOHMt3L+rdkVYMzf3WIDw+LaPSX0IR6OqKQhO5ZJv2Ms9sHkYo/oAFG/rjb73gO9lvsNGo+zNj@nongnu.org
X-Gm-Message-State: AOJu0YxpNpTq9ziGETDdxIJnNtheynxopqE3AXrRcedHya8FP3lwuWgF
 Me/hMaR3pvQvOQAQ2lAPqn9S6AKdzy5a26lh7k4AkwXBE45Hwjc1xq9x8F0l/Gyjla4=
X-Gm-Gg: ASbGncuI5AO2yomeWBN5tqUQnPKpL1a0sB+2QgkxvwZrWuM1wpwVxKqjjUmEy3lmvOx
 UcZdgKRyMr6wwYVN8RfQgqBG3zhtpWJwPxWC6QvUplqzxSNLRmw/m3ImyZsj2y0yYdpxhghzfVG
 RpVI8ZolmR1BlIuUHFYeCWso6S2CdmmqHy0c/RWvhiih/3heU12KlQCKAfOpIE/U6epa/8RMdgp
 rofQw3BM4zgSQhh//fB1KE1zaTXWZGpCSinOjerVUfaHuXmJwN0qWLtV4wjYlDz7a+i7Xed1OdT
 RBwMSVUWzOdJzS9zCu0zrp6H0f94iAskETK9rrcFr7yQeae/ZDC26x/haGahT+EQjt3TufyNL68
 h24Fsy3U36PD8ozW79UmikyOlwXm4yD954sdBEnmDr7BZg9ePV1SQ/X4x7DSFgj+HRU59LbRoVq
 0hYVjngTa5/hHuslBfyU5O5frm07yRRroNTjYKr1vjMLLJnwMB+KuLeQ==
X-Google-Smtp-Source: AGHT+IH4NKW1+zOl9S2bm3MKpZ9dfjiaxJ2sGNrNWhKrW7JwvgzprsHsqvpwoLA157lGFmIpAjISUQ==
X-Received: by 2002:a05:600c:17d1:b0:475:d7fd:5c59 with SMTP id
 5b1f17b1804b1-477b9ef509dmr13436225e9.16.1763636694916; 
 Thu, 20 Nov 2025 03:04:54 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b10763a9sm101448855e9.12.2025.11.20.03.04.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 03:04:54 -0800 (PST)
Message-ID: <7601933c-5518-4ecd-98dc-5f01764772d8@linaro.org>
Date: Thu, 20 Nov 2025 12:04:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] contrib/gitdm: add Nicholas to the IBM group map
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
 <20251119113953.1432303-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251119113953.1432303-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 19/11/25 12:39, Alex Bennée wrote:
> Let me know if this should be under "individual contributor".

See '2025' section of https://ozlabs.org/about.html ...

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> ---
>   contrib/gitdm/group-map-ibm | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
> index 24d8dc1b865..2d76bbe163a 100644
> --- a/contrib/gitdm/group-map-ibm
> +++ b/contrib/gitdm/group-map-ibm
> @@ -13,3 +13,4 @@ joel@jms.id.au
>   sjitindarsingh@gmail.com
>   tommusta@gmail.com
>   idan.horowitz@gmail.com
> +npiggin@gmail.com


