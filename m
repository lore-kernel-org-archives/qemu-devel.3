Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BADBC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 17:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBdx9-00037j-Np; Mon, 27 May 2024 13:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBdx5-00037J-2c
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:16:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBdx2-0004tj-Mv
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:16:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f47db642c2so45105ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716830156; x=1717434956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FttOp1HbmT484WDoscUzkAEpO768kVHLyT93uBHIhyE=;
 b=wUoRpUdH4VxMDNO6cnFghnnnWICYmbwHSHueM8GtXrCNSo4YAUHUxGtTguaxPMSNhz
 cZKA6zlZok1czxhv3op1mUYGfqXXKKFa0r2FXOAYgxwXtjoigZVZG4nEhZLBghu9E8Pg
 Kj8JN0kkdy2n4xxDAwho5J3rk/4rKKBlfAHC5rGKKA+dMAbNWlEZxDejAj5jjob0Yd8h
 R84WwjOUBsTR0JOThaHG/IZ23WKXiLIWlYMxviPGPDpbOXuSvqXzPcjdwRsZ+kecMpvM
 qtXXIppehteBJJENCMWUKGDBgkaECIUggajV0i7/dKZb7ULxPAvBvgfSCa5FlFdt5ZXm
 P/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716830156; x=1717434956;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FttOp1HbmT484WDoscUzkAEpO768kVHLyT93uBHIhyE=;
 b=PD2LwAED1vNC5ZKcQR9NyQZz7J1NF9Zg+g13UyUvasR7AxAffLuqXdr6e3lwXZRWYB
 5qm83FK2sRpqU6SezOP4yMBvAJ45eoaviCY4NgpbOib8oK4Aw2o/kNH9DEn8BuemAi9A
 CjOgMKs3aGplNmJCj4ohI2GmOwoOCGy4Z7NtELLSNk5bzd2mlOQFjp123PTURbcbCViM
 M8RQhn2QMNYaTi8iMbW5ZOHtsgmk/lplOHOAPLEmR0f7gbfcy7PWGwDC7Ye+N/elKBCJ
 yS6XrSeV20ZktNLtORrsXDqGxcwmPmW2gaKASu6EmUzeZPKuUxUDdUfe6sKoblvtEYIz
 o5Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ9Yi0VsXRWonY3hicm3yBKLrbQOJ36x3jzLZGD6AXOepmzGS4HyS9ZOBpderSDwzXDAhbjQ7HGueOIdN7Z+jmBJQepH0=
X-Gm-Message-State: AOJu0Yz1tJvNbU0CO9KzA6lrMiqbOr3CsOtDxTnVvGbm7BfVlSkNfrCl
 Y5fMOZmIugHKg3Yivv1K7G79Caj1HDDDCdHbYx0cZ/3JenqDI9TxUMQRcDlXseI=
X-Google-Smtp-Source: AGHT+IGR8lOc+oZXelVWzM+7jLPufO8kzohy9k9xthvVy182tR67FTrmOCcJMUWirF7wno8jXUIM/Q==
X-Received: by 2002:a17:902:ce92:b0:1f4:960c:a05f with SMTP id
 d9443c01a7336-1f4960ca22cmr33958045ad.31.1716830156372; 
 Mon, 27 May 2024 10:15:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f484ac6d1bsm32017735ad.243.2024.05.27.10.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 10:15:55 -0700 (PDT)
Message-ID: <e92a2201-5c58-4c4f-8ee2-17912a384224@linaro.org>
Date: Mon, 27 May 2024 10:15:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] Error reporting patches for 2024-05-27
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20240527113131.2054486-1-armbru@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240527113131.2054486-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 5/27/24 04:31, Markus Armbruster wrote:
> The following changes since commit 60b54b67c63d8f076152e0f7dccf39854dfc6a77:
> 
>    Merge tag 'pull-lu-20240526' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-05-26 17:51:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git  tags/pull-error-2024-05-27
> 
> for you to fetch changes up to 2020337239b054447d0756ea75e970b35f7a541b:
> 
>    qerror: QERR_QGA_COMMAND_FAILED is no longer used, drop (2024-05-27 13:00:12 +0200)
> 
> ----------------------------------------------------------------
> Error reporting patches for 2024-05-27

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


