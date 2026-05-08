Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4D9CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHkJ-0000H7-JM; Fri, 08 May 2026 05:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHkI-0000Fg-2M
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:43:46 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHkG-0005Cu-Go
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:43:45 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-3922b35e69cso14586361fa.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233423; x=1778838223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Q1+F6oz/ou7iU3INeOLsr8APRS1jZ33COubgx8vyyw=;
 b=hBLIl73zwLwHc3j6nelLAEdqoI9ebMPqgaO1vmcsVfYdamw08uYXkzdqlPhGd35err
 40Pe1y75IJAA5GHrz5Fjp10BzTJz7c7OoIPm0dDk6oc3BEmKKh1rDvSJoppJAP4sUqcC
 BGHei6nEZh96N9CH7Bc07q89oFKFJJJVVwGtY7XSTXMGz/LRAyKtM9qKhgOlzjjPkkrW
 5a7IT1GQWw7xBQHa9DjjG5wKgzYvYwAL4S4PbW2EDsmJz3ioy8NccJPLrMH1n+rX0kK/
 ZPmd6CoarCfh4Cx3G19qb0PKJBRkGk8Ibl6FbbkI+W5oEdQjk5oyXA5RIFoKku9mC2ON
 LdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233423; x=1778838223;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Q1+F6oz/ou7iU3INeOLsr8APRS1jZ33COubgx8vyyw=;
 b=DBPzelLhqaSnMN5/vlWppHo9aDCHuFPJ5TerGwQrttcHGdLya8kJTNEHQCy5R1U5W1
 QnH2/Vckdi91xii9RU7agfksuIJJNUg2MOsaoSWnDBdUmD0/6LZ3k9xbHS7eEY0dSsmO
 IUjsGdaC5JuXbt9LeT2Ywnr+y1uXuWUdWtx2P2K9pRTAcaFVSnoUd9IYtlyCACKiuVDJ
 tM6A1Liz6kNO/okVkSREghdoPk6FeIFdvewnLbUnPNYq2TkdXDEHm96u9DynP/aOe71Z
 VIte9r5ZFfFs9K+ZXbVigacojgUunrg1sVXLg1wlVa4/rvf9387yiVq+Egns0CCV80kZ
 HR5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+g3li0EN9cEoaBelNjAmkVSJ9fA1ls+SHTXuWQwtHnHMY1PR1beWHTkA9Z8Ik6vySMlimR/82sfUjR@nongnu.org
X-Gm-Message-State: AOJu0Yybccx+ZznkWsTqBakXu8aUnuH7JzUmZMAspF04Oe9dY4noxAc7
 pTs3JlCcRuuGVjggMoa5As2cjf/s3s+hpEh6J58H1PhVpJz8SiazDL7Q8T+Bkb/QZ+o=
X-Gm-Gg: Acq92OHfHYMKwiXQm+ml9p2IQyMIUwZVGUEQP0rf1ZwtLdNuPsMLAVR/PPg70kpLKXH
 FBIS8ugvSSm89zMYtcqks6022q2kfQIAihIDz3DQfamfTh6EaYfwsUiSBSLnqGXFksFefKf+eGd
 w8Ljyf/AMxwSFCKc+yf2CCV9sxBVc4LdSuIFqY25GSD2TGrWBclHcpYUizlBJUjetJxQsT+uQ0W
 rFR6jhYQHB4n/Poi41uuD9ThQnre4b/61YwLTEzCFTgDgd2SaJnhwg9XZ83vFuiIxwJKK/XKPvQ
 IZn0Dau0ohO58CWwti4p0ZtJ964POUmjcxJ9hrGosq/OevaLH9IJwvdYsRY1oF5EHy51Wvw97cZ
 p2kYETQVfsYgSLe6jFlPnBZvrWfpxDgaNMrNa1OGIgiL2x8ICzcRDqGQLQd5Pa3+OjSsmeySj+Z
 BM2oBPjz+zFmzSjNEbA3Mv9QeFkCDENX4lrX2qyEh3pDoTb8FCfomFrDBaXfB/3MBKi/BP3CvbO
 dLI3O/aXm0kZg==
X-Received: by 2002:a05:651c:e0f:b0:38e:a777:f393 with SMTP id
 38308e7fff4ca-393c41c3e71mr31453491fa.19.1778233422474; 
 Fri, 08 May 2026 02:43:42 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f5f3a2a2sm3574771fa.11.2026.05.08.02.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:43:41 -0700 (PDT)
Message-ID: <9ace5e12-9270-4902-9a4e-8122b467db42@linaro.org>
Date: Fri, 8 May 2026 11:43:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] fpu: Introduce FloatExceptionFlags
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

On 8/5/26 00:17, Richard Henderson wrote:
> We have, in the past, used any of uint8_t, uint16_t or int
> to hold the set of exception flags.  Use a typedef instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h | 6 ++++--
>   include/fpu/softfloat-types.h   | 4 +++-
>   include/fpu/softfloat.h         | 2 +-
>   fpu/softfloat.c                 | 2 +-
>   fpu/softfloat-parts.c.inc       | 7 ++++---
>   5 files changed, 13 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

