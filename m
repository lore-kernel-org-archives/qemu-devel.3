Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C94CFB456
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtkS-0001YN-6G; Mon, 07 Oct 2024 15:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxtkL-0001Y4-Sx
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:50:21 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxtkK-0007jB-91
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:50:21 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71df7632055so2052104b3a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728330618; x=1728935418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DB2owELhHAVkpAYi2YUuWUEEaGC68RFcQbhaPz/OHOQ=;
 b=HHfuhOw5ypRfWXSrsaT28PJOM0RCAiKGOXBNl92U0J9R6rTJ8bF817oydgwsElM/Hp
 fQ4BWI9naJFKEmNVGHMCImoCotLNn2CRRXc6Co0pmCNdjVI7ynUeAJ1EF44UZMwdlAI2
 TcoFIEkLGDEXgdxv599eiUNopQLc/N5disnVPWlGp/MLFuVUuRFcMjprTGbfQFW3qdSX
 v+duUPtySTjhzK/H/RY7kQiCjx9kpdBBHBB9PXxY7wby3gY+Pq7SRWeMeVca/RFFKf0o
 aMRF5VShCdOq3SlSpyESprZ66usAybpFyetnwlsq1dxLCej7X/R2egZvd/zIjckdy0Nt
 hkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728330618; x=1728935418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DB2owELhHAVkpAYi2YUuWUEEaGC68RFcQbhaPz/OHOQ=;
 b=ZTmY7hzKRj5ovxhVGXkUia6Zna5dSh2MjSjpTKurAx0gKEwM5XsN8b0SzFaFidraHi
 aa+Ktx2hRq5H9t9x0XeZgMiMun8PmN4Z2GUehsBwWsd71/Im87brFxDIVwUwuhlNFqDK
 ma0LnDKU0UTfiG1PzzqmmMeQQ9ggddlhuqBd57LdVgbo8VPaMQvLCMLRZprGPQROadzH
 uVqbC+fcTUqLjHmJbjqKWhTko1499I3YalI04M7PRCHh8Hh/q3zHWeQ/fqJa3Vm+8+W0
 GfPZ3hwLWH2fH5AnWEeFognYIA5VtKd1goz534CaZjHX/F14iyVvn6lBL2T1eZtTPYba
 hqQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7nhq+uoQk8oDzaZUx9ixx3TJNfBUKHKI/kbqTKh9x8zZwCtyRFBAb+lHFc7TzgzwNPMzm7TTU8D6g@nongnu.org
X-Gm-Message-State: AOJu0YwI7fOjRvySoH9tWsDr2C43ON3/q+jC7oKoQ3Q1EGETHq2p8XcB
 fCKhf9EBMfxlOAPYwFAO1qpqItuR19KVqqYnEu6eoYyd1kbUXkuY1ajx7Yd3HooVHfd9xygyYVW
 n
X-Google-Smtp-Source: AGHT+IHSiNgh0iaZnhn3FiORXiKa6T1N4jSmW9inleNVwDEhHTqJIE5sZnx0NDaMijojx0iSgWs5zg==
X-Received: by 2002:a05:6a00:2d97:b0:71e:2a0:b0d0 with SMTP id
 d2e1a72fcca58-71e02a0b3c9mr8001939b3a.13.1728330618200; 
 Mon, 07 Oct 2024 12:50:18 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d47a4dsm4780560b3a.118.2024.10.07.12.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 12:50:17 -0700 (PDT)
Message-ID: <e9ed68d9-1cdc-4b6c-a644-1c8cfce6eb01@linaro.org>
Date: Mon, 7 Oct 2024 16:50:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] linux-user: Fix parse_elf_properties GNU0_MAGIC
 check
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241005233343.503426-1-richard.henderson@linaro.org>
 <20241005233343.503426-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005233343.503426-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x432.google.com
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

On 5/10/24 20:33, Richard Henderson wrote:
> Comparing a string of 4 bytes only works in little-endian.
> 
> Adjust bulk bswap to only apply to the note payload.
> Perform swapping of the note header manually; the magic
> is defined so that it does not need a runtime swap.
> 
> Fixes: 83f990eb5adb ("linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2596
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


