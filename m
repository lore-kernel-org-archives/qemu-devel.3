Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E658C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wsu-00061l-Mp; Wed, 23 Apr 2025 05:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Wst-00061P-0Q
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:59:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Wsr-0001mb-1v
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:59:14 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso47079605e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745402351; x=1746007151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b4RnAiJadDYdQbmNtoEN0s03apMluTLDVrhBOuuHr3E=;
 b=FduAT1l43zAZqKQoi7H39ZV+AE/QXhJaB5GzStpg9oeEbUs76kX4q58VPMO9VRu9po
 4drAVMKidOIFpDBDQ5sgBjOvg0LDxjZ9qG1N+hIkv6reM//nDgbpWC1KbVAIPJIf1xw9
 gros6iEIRNWtqWxHDJEgSCmYKlUccWd+AFns88cVStzasYEVigwecjWoPgZxxKVi6em5
 iCNq0q0bJf1pQ7fno1+hnnrjy6/bY2pHsheKlSptfbiPAf6HGEbcfSUoOJegO1Ahx1rJ
 OXumESMRsGD6T7s66d8ZfU79KTn38HStWSFOWIm48d78HRlNCOok7YBTpxAFECis9sIl
 0zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745402351; x=1746007151;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b4RnAiJadDYdQbmNtoEN0s03apMluTLDVrhBOuuHr3E=;
 b=f9Pw8DawiiXWK3v3jTw4oa4iMh1nmpv45hmfARy3xrlPRHc6sDWeDxDNOFINudsS79
 1IZcmuA0uH2KJKzJMRWbSQvDD7S6Jh7UYbJVbZdU2rMjtAoqoX2RLi6vO94W5irIZfWX
 gtGRniJ+mzqqI645IV27GkUvBQkI8gjnAynf46V6YuR3Lk4XLcME3ksKH+wAlLjqUkoL
 UCxCKBusewVkjI7TNCqZ/cXaTnpzuNyxMfwhTl2IP0NmDZ0AtOPHlPHGEhGL4mWFlm8h
 Nq2FW8hRnY+AbK4ib/kbhmy5BEdNMfiAp/HvQssKZT/lzapgT0giksq0PTCyTWDePTcB
 r7gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIYGmHIjj2H5DEivCVM+TxgnbgZR6M9ybEaGsoQQy28C7628eVuOfi7QmFTNCIdSWO6U+z6qqR5phJ@nongnu.org
X-Gm-Message-State: AOJu0YxbaB10vj4mHsxy47xMdk5E++OhK6pokZi6Z7XKNoLGDbmYSGN0
 BYTSEsDzepH8MWtRpGMDpMcvbvaQNMMRg7FtKdUOv2dEP9wmtEek6+N0gOqFtDle8xsp0rCDrRQ
 l
X-Gm-Gg: ASbGncuN9zW6XYoZmiMujQ0n8KhWt7+YugzwmXO3qAxblVLmZHvftmNhEHB60YUP2cr
 5peIdTn+xniSbibmJdHC++ChTMYq2TkMxaocmy1MiAalRIM5B+rdpTc/dM8r7cedkF6v8PyYZTe
 s73JxZnre0VphqnSA2ncQ4AWQIFmoNN/3jd6VtntWO7XhlkXJy88CPccYvswY8waM2IjLggrgTq
 iFfL98klv9i2aJMEFae/C08LjsDudk1oRJp/8qBt/lCWRlDzAKNkt2NQy7Nheg/MQDIJuqP1oJj
 hFNIU+UAj7Za+g5YWF6NpNAYWTPnPQhI9hEnA7XrJby/OD56ouNnWyoTW29afUtKInGU8QiaDJk
 j3yoUnunczPBdP6fLpFk=
X-Google-Smtp-Source: AGHT+IFapo4EaJ8ctnLR/6vimf/4rQJaN1dEVBINc7anCyMPX5MMw7brZDlDFEJnigCGF0gq9EpXUg==
X-Received: by 2002:a05:600c:4688:b0:43c:eea9:f45d with SMTP id
 5b1f17b1804b1-4406abb2cd0mr175385315e9.18.1745402351426; 
 Wed, 23 Apr 2025 02:59:11 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4cd0sm18667668f8f.90.2025.04.23.02.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:59:10 -0700 (PDT)
Message-ID: <bec12bbc-2a73-4486-852d-b0c89b59e1d9@linaro.org>
Date: Wed, 23 Apr 2025 11:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 063/147] accel/tcg: Fix argument types of tlb_reset_dirty
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-64-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-64-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> The arguments to tlb_reset_dirty are host pointers.
> The conversion from ram_addr_t was done in the sole
> caller, tlb_reset_dirty_range_all.
> 
> Fixes: e554861766d ("exec: prepare for splitting")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cputlb.h | 2 +-
>   accel/tcg/cputlb.c    | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


