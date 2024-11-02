Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2927EE677E8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 17:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ICV-0007eF-Gh; Sat, 02 Nov 2024 13:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t7ICU-0007dl-1q
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 13:46:14 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t7ICN-0004rm-RP
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 13:46:13 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e983487a1so2544951b3a.2
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 10:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730569564; x=1731174364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=83qvjAOJZ51I+JlkGTqYXn7h8AI1DUMZm0iJTg2Jb0E=;
 b=WOZkRgIIk0+Us0IiwhKlPW7VEGpDwEzjtmGBpzy2g7URv9iqXP2WEyns5RCXCPNS63
 D8rAOLsN6/OJOa7+gbc/LK0qJOk3ckbKJA6exKr5/a8HoFFUbDqgl5DctiCUxEtgkAwH
 9jdQrG0UzFlpLOfykIVGSQo/4fFJR2F3u8ufQ+xfDuvUk4yAT5GqqvjDPgghVjSwLXtU
 hWrAzDmWlrAU3kBiouIPbfw4uiIGVhiKyQFARyXkuEBylTTUsaRnWy02AqijTVR6a+3y
 JPg6u5xHz2K+TGoZAXtU72sioIhNK+IX0YyVvoYrUy1/c7/sbC9hhyiIDl4p0gv7wJXT
 ldJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730569564; x=1731174364;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=83qvjAOJZ51I+JlkGTqYXn7h8AI1DUMZm0iJTg2Jb0E=;
 b=bkSDIg+uFvPvk2V19xPmwI7RMfMBtlRdLC1k8SZQVcDt67CfvAfbxu+yUToHsOKf4d
 EE0f+Bo9nqKX67+jXpDP01Kd3FdiUHTM1QyGJFnoV3JLJQkYdq5vePp4c48HKi5cZ+24
 D0J++hCOJTIscpVv8B/dlVKk0esyo6Vkzt1i+NzZb78mzvXI2q8G73pOVzLiZBLlEcgp
 oxyFAiKtiPjwVpQvpkDYs689KAtNJNaFekD834PyrvDcpble1lucP2KKZAlKb6w9Xc93
 QLoMEV7QJRHMXikk0oW8wXKMzLItS+aC4T2YtnEhpurnQS+b9Z7Usp11fbJdLDPfFdfa
 ZrKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCn1L7lycIMPne3S9AJei5A0JQGQhUQbcqVMMtDrmGbIoDENh4bo2goHOBLL8pp5DIhxO6cyxzAhJm@nongnu.org
X-Gm-Message-State: AOJu0Yz0QqpNu24AjOnvdkibdiYQ7eNrtplRkIw0RpxbOz9/euDlZD85
 oEKkpoX5zjTJfinuoDCir0NLFUbg9+6Ioo6pR3XfhQwp1X39Nq+kCRGMeTShtVC4+alaSNBLV3R
 D
X-Google-Smtp-Source: AGHT+IG6Ik3BaNq+G4GIYuArwqRs3BTSy/IniPHZcGDtoDlZvsSj9SHHBn0reXiaWi1/S+wcqc0yxA==
X-Received: by 2002:a05:6a00:3c96:b0:71d:f4ef:6b3a with SMTP id
 d2e1a72fcca58-720b9db22bfmr15700358b3a.21.1730569564301; 
 Sat, 02 Nov 2024 10:46:04 -0700 (PDT)
Received: from [192.168.0.102] (200-207-104-238.dsl.telesp.net.br.
 [200.207.104.238]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc313b55sm4362909b3a.186.2024.11.02.10.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Nov 2024 10:46:03 -0700 (PDT)
Message-ID: <8becca82-a708-4a19-9f67-92b4a418b6a3@linaro.org>
Date: Sat, 2 Nov 2024 14:46:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disas: Fix build against Capstone v6 (again)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241022013047.830273-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20241022013047.830273-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Richard,

Sorry, I've missed that one and just found it when doing a
check before the soft freeze :)

On 10/21/24 22:30, Richard Henderson wrote:
> Like 9971cbac2f3, which set CAPSTONE_AARCH64_COMPAT_HEADER,
> also set CAPSTONE_SYSTEMZ_COMPAT_HEADER.  Fixes the build
> against capstone v6-alpha.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/disas/capstone.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/disas/capstone.h b/include/disas/capstone.h
> index a11985151d..c43033f7f6 100644
> --- a/include/disas/capstone.h
> +++ b/include/disas/capstone.h
> @@ -4,6 +4,7 @@
>   #ifdef CONFIG_CAPSTONE
>   
>   #define CAPSTONE_AARCH64_COMPAT_HEADER
> +#define CAPSTONE_SYSTEMZ_COMPAT_HEADER
>   #include <capstone.h>
>   
>   #else


Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

@Peter, would you mind adding this to your queue?


Cheers,
Gustavo

