Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF64CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiK7-0001kC-7z; Mon, 08 Apr 2024 02:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiK2-0001g9-57
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:17:39 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiK0-0007He-O2
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:17:37 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a46a7208eedso589051266b.0
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712557055; x=1713161855; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZIrRvs1aIE/8shAMEAS1ZklgR4ayR9BEDUAx+mQnyLs=;
 b=oqp3/Mke5SZ7FW5/fYfPxAsyWhEe3UsFaW04TKIQKPA0hHu+yHwMiihcBlaJv6/xEJ
 is2ASK9/XVHgalWbyhexxs3xW41w/YR/5FkBz5x7LUriHQTrhsOxxAZQDWouOrPZ4jub
 5CC+xFdHwJVxGDRP2O/gc/Vuawb6gG2nVFEV0VXoQ1tYzNcIWh2iAWrC6qGeGj+6QEzr
 oaL0xpBlBxRdWIzA/jJDTE/PBnSjKDPpqkCZQ9cZqwcYYCIvkn2Ruz8zv5MLb2y8WzAV
 N7KFUo86CU0+wO+nZrEZuU1hrIcfJ/UKR7Fubi94NGZuQUCyP6bMRUP725yWahGS4JDG
 sFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712557055; x=1713161855;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIrRvs1aIE/8shAMEAS1ZklgR4ayR9BEDUAx+mQnyLs=;
 b=SQ5awZP78c3QmHBJ7UMui0Dw4KlGLKu6ghZgMQcSlSMT3B6Z+1s4LYxf6AJq7MJ9bf
 vueeERQe6ZaOlPVKSiFiZhgMr+rKzBqvkzqtitXNgzoMVvqpFXKTexTUoEIPUOsE8crP
 NqBZUd1eX4Vu0hVK35h5Cd/SB2c+QoMzBMA/k3ms8v1rx/yQkQg9OeqxURby9UV5bIyc
 er35f6kOExTu/bRR/EKYVH8yb8OSjmCBLfe1m+lXRLF5+xXdcs5VDnTwxr8lWnQhV6vY
 Sett7LrsZNhK0rhjiZAMk/kQIm5r/NgRELnRyDsNmzRayCj1xijmMcrZLw4lxhEoCfZH
 l1Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbIsx0yKYbOdeDFBrBhqkwkyaZPuS2OHFm/aNEIdiiimRPlrq+pHQ8K49DjKhQqxG6VbrzJ3UxwJNJQNCemlzV+6vDSuY=
X-Gm-Message-State: AOJu0YwcPW60ubcT/AqxCyvWmiWGbTH2jWHS/fCiFpKee0N+bicuVCUH
 kRvHB7sCjnlISw0WJY0Cx8UYUw1dCL0tkFvTaMBgjlZQZJDwQWHn0CnayBc7I9Q=
X-Google-Smtp-Source: AGHT+IHCx1CeaSFEJmDklmq3jEzroAPjnOyDGblSuYj0igcXlEpjqsrY9MxqvXhQxwOjORroUnJJaA==
X-Received: by 2002:a17:906:fb10:b0:a51:d611:c6b9 with SMTP id
 lz16-20020a170906fb1000b00a51d611c6b9mr874864ejb.59.1712557055409; 
 Sun, 07 Apr 2024 23:17:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 hd19-20020a170907969300b00a51bd3b432fsm2572098ejc.115.2024.04.07.23.17.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 23:17:35 -0700 (PDT)
Message-ID: <818c0c29-caf6-4c70-92d6-f051a7624e22@linaro.org>
Date: Mon, 8 Apr 2024 08:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/microblaze: Use insn_start from
 DisasContextBase
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 7/4/24 00:32, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/translate.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


