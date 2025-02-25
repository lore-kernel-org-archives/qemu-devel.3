Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3BAC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmwNj-0000Nb-B3; Tue, 25 Feb 2025 09:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmwNg-0000NQ-TM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:57:56 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmwNe-0002Tb-VF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:57:56 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f1e8efe84so2130247f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740495473; x=1741100273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+ykW2H8fOQHHaIK/G75uKxDgyRvAQilnX9kLMcMhxuk=;
 b=AD0rRDJQl2muQjrpmIdAC+9QGJ0erAa8HtV3ZWqNyEibE3+mltEdnac3BQ2dvL/6yq
 GSPOqi8Hjsbxhycv+hAXKVKZVAGYfzUJqaqoKxkvjUvv8DqHX0WNaZqHAxP/UsgI1hxE
 vc+cac9pid+7o3EWwKy5DR4bdb5lzm41lcm3heqJBKGnz0o/VKo4l60RVNDEhyW6Ad59
 hDLjBjiX+StZln+cvqq/gkORBZz9fD0dC4yRmcl4gRkyemegHggKORkT1VpEctfmrm0Y
 0c//jdiOkv4IjRQV5gj+4fnrNpt1O8UeEAyvY5SUqYiymynae0zSU8nzn3v5cAlwwmqE
 4log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740495473; x=1741100273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ykW2H8fOQHHaIK/G75uKxDgyRvAQilnX9kLMcMhxuk=;
 b=Kqgj7XaV5qw6iEgmwyST0MrMYzWkhR+OpuP4bjT621NWwdpXq0eJiPi+jl9/ec71qh
 ZHx5aSAgoFKylzl3GWw9w9jHHArMtm6dNcWUPvy1bL9rvyVIVUUdClqhGBXguimWXyxj
 /TvcmR/Y4LPvup4V0Wxr8IBZ1Vhvc7+b3O6VQQla1BocCtEOg4/2bMmt5uJtSyXSCofa
 swcpRqV0GbamtltjzN9+vBhenQ2p2xo/Jx+mlsXKDPvKYHD2LxxLOyRD6Dk7MlpMIBKC
 BYfY0KtF9qOXfaEyO5qxlqFmf+bHnWF2MsMGILO0JIt/ciePvOE40iG9icN1MWrxvkc2
 KpUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUydIhd45/z/lQU3t18h1mGX90PnHCW086AcmL6j9rMOc4F73KqmLesGtnfMgGY+Vxf0QLiXSQYNe40@nongnu.org
X-Gm-Message-State: AOJu0Yx9EMgHWXqrPn8P9Oq/yU67K1BF90qAFJZvNLrM1IXq5FsStOJ5
 T/1SWYrNPrIXybmGRw90IyuDvSXHdyp6A2ocR9uikOtLoOlVM6m2mt13UeYXkUk=
X-Gm-Gg: ASbGnctzapS/DTfNwJP2gdOBHKd4xrzL0r4nvSRIWiGsrSydxHaHB2cdqxMxLNfmjFt
 EBhIpExeoDybTrp7tyaLbi+JCg2hu9nR1z2uZst5xRGq8JAjuZo6JvdrBdUj2J+hjXNf4aDkVHM
 ku9NIU9xvj0qO0t8F2sx+5TEDYFF1xMTjahQXwfVhAYx7IwH9gU83+1mje1I9X/u+/YgzKMzlQO
 qGq1cHxGBh9BLSlP+LmSOVIfB92XLkNgt29Va3KgvfxsNXuzyEEPO5os/XoCol/Q4wFz8HiLYpg
 TmS0HDlbRXM/NGklSDsZ+uKv1dwmopDGSlV3uL18jdnD/tCqA6IfahAJlm/fsyd3rvDVHA==
X-Google-Smtp-Source: AGHT+IEB5TIgpkhg53SeDPuE7QP/y5YHXgR0OpoYuUfUTpTNK0SfL0rxPHRqMDxhUiUY1aRRXsprLw==
X-Received: by 2002:a5d:64ce:0:b0:38f:4b15:32f1 with SMTP id
 ffacd0b85a97d-38f6f0b8642mr16707600f8f.54.1740495472713; 
 Tue, 25 Feb 2025 06:57:52 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86ca0asm2608815f8f.32.2025.02.25.06.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 06:57:52 -0800 (PST)
Message-ID: <4432876c-0182-4d2a-8cbd-0f4ff5243ca9@linaro.org>
Date: Tue, 25 Feb 2025 15:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] plugins/api: use tcg_ctx to get TARGET_PAGE_MASK
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
 <20250225110844.3296991-2-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250225110844.3296991-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 25/2/25 12:08, Alex Bennée wrote:
> Requiring TARGET_PAGE_MASK to be defined gets in the way of building
> this unit once. As tcg_ctx has the value lets use it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   plugins/api.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


