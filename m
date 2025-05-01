Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E027C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWTt-0001JS-TC; Thu, 01 May 2025 12:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWPJ-0005QU-NE
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:05:23 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWPG-0005Ut-LC
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:05:04 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so1192232b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746115501; x=1746720301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4SES4h4v9vWZoxb0RllESUEUDYAAfrIloD4OwgpH1lQ=;
 b=Hxbw7U7bwgL5lNntGyZA0ORNOEbFeuS+EEgW5opEXzVtKM3OU56eUxtNj9MfJfO0pB
 L7G344vW3prg+rKzBESxkdWNzh1pIvGbEuIyLGH+8naRrp5BwywZFkJ4uajEOpE02aIk
 iSHOM5JUvLcoafDMTTvyz1pqrV1APTndVFji5sNKkFY/mX26Z1DpNm/XSSIuQOu/lndm
 W/dnPFE3ThwC2zTp86MUrNvGNLdK5DJ9mZCevnlnsG9w6gePbM41itRBCtYoCW53XIYs
 LqMXFUiOgr/r/Logf263JD+/s8JfIHIOae8GM/yjkx99hqnelAg3Jfxg1Mn9atIui+9N
 1w+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746115501; x=1746720301;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4SES4h4v9vWZoxb0RllESUEUDYAAfrIloD4OwgpH1lQ=;
 b=jxSf2g1QIUkAlXMRiRNJvtb3dr1qgZOBRf8cT5+lkgyawjumDJCfU5mKwoIexO9phD
 wDmlv7PcTPbS1s8d6z1WSXM5pAHZ4DGh01b8+UVkbm0HbPeagADW5m1CVanMw9e4b41/
 rzoiXZFX5v+vgDtO33nnr3qXevDHfWa+Uy0DFPyMmVMGKoQiCyea9n/iqzGG4MAZRtr4
 rAPk40d+QseadDQOawHvOVYyQ+BlwRyAr22c6wY6qKEnXwb6YjO2DQ1ZkirSr0RAfrxU
 uVKVwRG+qWSEzyAFQ/mhqyPaUhbiUI/RjQrDC5ws0LkKkTzeSw8IXaJiCxKQokhONTjf
 vDEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8jTTJVc+4PLrquZKiTAr04p78YR+NcWzToFI7a31BuByFTVY3U7/Ii5e4IvvqvJdDW8+A+pf9dQ/o@nongnu.org
X-Gm-Message-State: AOJu0YxEYFZuAjWucEyft9ato1J/XawC5czd0KkkT4NrhRHWbN6WU2lr
 78SFlFohjcJThMWaDx1HEFu3BhegHKHYu6wCiiLjJPBLFJnUJvc1S4czlyF3ADs=
X-Gm-Gg: ASbGncubwTc8rmfjpTOa5Cei3M3x5212v17q3q7CNOendIWFWBw2dyCeMI/X8mo0ewB
 ZYEQKap0Q7/xCVgHaLQF/O7lhfl7tGo6tn/7jF0QroRmRC93BhTTVigfNZ/7cuVd/qzXtfaruOL
 2RZNJ9dlCh+KD6Yqnr3qKrPHvIjqbFpdP8dT1Xg9voxm9iX0+DVScDnxXT9akSSaK8SyE/nhoTC
 9aCpyEcPAvcqqEe5aESkwB31w5mrHs7FN6L1kst/lDO/RdaNSum48Rd59HJxjvtGS8x9Tt/om3+
 L24uqSLkS2rXD5qO4UvV16iJvQ0JAT/f5IsmLet9DIbE/n00xs9LKPeDAalnfz5+
X-Google-Smtp-Source: AGHT+IG4zU7AKbrfMlb4I7b6TrZEFM0+6EWomwmp2RNp8DdnSd+Dy0WCVNp9LQ+pWPWG3FOHndNsIQ==
X-Received: by 2002:a05:6a00:b4e:b0:736:9e40:13b1 with SMTP id
 d2e1a72fcca58-740492601d2mr4198899b3a.23.1746115501103; 
 Thu, 01 May 2025 09:05:01 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm993064b3a.93.2025.05.01.09.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:05:00 -0700 (PDT)
Message-ID: <1275ceaf-af9e-4cf8-bcaf-844875607350@linaro.org>
Date: Thu, 1 May 2025 09:04:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] accel/tcg: Avoid abi_ptr in user-exec.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250501145520.2695073-11-richard.henderson@linaro.org>
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

On 5/1/25 7:55 AM, Richard Henderson wrote:
> In page_dump/dump_region, use guest_addr_max to check the
> size of the guest address space and size the output
> appropriately.  This will change output with small values
> of -R reserved_va, but shouldn't affect anything else.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/user-exec.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


