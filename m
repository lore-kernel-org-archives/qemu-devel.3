Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA4DC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 12:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raapV-00045h-Li; Thu, 15 Feb 2024 07:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raapP-00044L-Md
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 07:27:01 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raapO-0007KO-2E
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 07:26:59 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33b2960ff60so1048025f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 04:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708000013; x=1708604813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rEgZfWfyRZzPd0HAEgqdaRFFYcUBEa3A75yyd0XKTL0=;
 b=lI3vYymNnqxyDroz7GPa2K9CgiezfXYXhk+ocfa18cauvYdeej9fAL5Fa+zMDXluOG
 Zi3mjbN4QqeiKR85K0JWs7vxfmqAzdZ8dGi7m1H87xW0+V4PgwWU/K7IEqQGhsGkGQLJ
 fE0/GFHWmJPL978CbsPMR6RWGuLBj7LWf0oxQrQaVQYPv6iDa3WtRyrQg4u+9Ptt7W2g
 KJxeYAbVHSXzP68jnZp9zSJWs6YLbsk5YkUZ4Gv6errqQI7KKXXrVCJOpu60RIe6vKX6
 9KpQ63o0W1vXPqjeOehlujqqIFQv4Hj58OdwKxaGza70VQnrjk+UGuE1N0pFglT44i3T
 fANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708000013; x=1708604813;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rEgZfWfyRZzPd0HAEgqdaRFFYcUBEa3A75yyd0XKTL0=;
 b=vwo/He4rEh/6bkuMlCMU3FRzaIBmHygwd2otMHwNzVy/kkHOxSac35rzPIbwdzE3zw
 oQloB5zj+W8jOU8zgx3nVGKvkbX7hEEFBhqePh6AnHEff0H0dr8DpLHt0FQ5hW4x6OH2
 0wqT6TO6hI0fTtEwRdBvvxKChRUd8jMrB9OV4wWVS/DPMOvz+onIpSmQzacknAt5jGIz
 TRWxte08aHBEVXhtsbY+UC5eyQNKk9smYLhutb8KSRvkIPA233jDlcd3kXNtGUu8MbB5
 jf7moDBa7TyqBAONPnHB+GdH0+yKyDFGQo4Ygswc3xVZAHFEh7JFDOSotnlmkKcO3Zje
 j5DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgy+XkemPiF/jFwqt3Sc418wylFSRb9/NptiBQfXrEtV/qEflh79ghF4FSz9+0fiU1D6VN+QWDP0a1kbUj9ViwwlDth4w=
X-Gm-Message-State: AOJu0YwORfs4NP2XfqRfFPjLEKl3Y2KofG78mTsgCPEDlk3TW436NLv+
 M5stqjr0c4D9VaxXhKgFt7wjMKC1cKkhCOGrnuqUAuN1EIA09iKxLXj6dG1iUTw0GI406wh+1gi
 Os7U=
X-Google-Smtp-Source: AGHT+IFo/Aa2MXxgKgrOcx55Npt7D4DKWZf4ZJQzo1Ke6RkYNdlzMMTnsn7zxRiMgTW9x9f2KCt+bw==
X-Received: by 2002:adf:fd4e:0:b0:33c:df49:9895 with SMTP id
 h14-20020adffd4e000000b0033cdf499895mr4340931wrs.30.1708000013525; 
 Thu, 15 Feb 2024 04:26:53 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a05600c4e8b00b0040fd1629443sm1858791wmq.18.2024.02.15.04.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 04:26:53 -0800 (PST)
Message-ID: <e4b13f26-ff5d-46c4-b720-ec26de3214e1@linaro.org>
Date: Thu, 15 Feb 2024 13:26:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] leon3: remove SP initialization
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
References: <20240131085047.18458-1-chigot@adacore.com>
 <20240131085047.18458-7-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240131085047.18458-7-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 31/1/24 09:50, Clément Chigot wrote:
> According to the doc (see §4.2.15 in [1]), the reset operation should
> not impact %SP.
> 
> [1] https://gaisler.com/doc/gr712rc-usermanual.pdf
> 
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/sparc/leon3.c | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


