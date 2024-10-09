Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06625CEE33B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 18:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sybmb-0001tH-D8; Wed, 09 Oct 2024 14:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sybma-0001t9-6K
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 14:51:36 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sybmY-0003ON-Qs
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 14:51:35 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20b0b2528d8so710185ad.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728499892; x=1729104692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VctVtNOpO5PsXlhkP4TOK+FOvZ/wMtwj0eq6AH0+fQI=;
 b=JrDp+p47RK20IQIRpi+yEbbyaWY6JTQS6qsUNOumBKalkNNsiAZicMRWP+oaOVpaiW
 yuSNGVZ6/L0H5pBGBkvw19QSKL5FyoLhGjOPdm1o9A6cprKzaSfCF3o+uTLOwIrB61C9
 DQF3gIpV0L9ysd4ZmR/olHAJb8xOA0N/DoAyDLfSn+BXtd127mTP9zCM9OAz5k/XiuJo
 5YfTubFYPjI0FNwuipRwR8CkxnPqxnv1MN4tMu6d98HAjkIn3NnVn71Mnnd/q73yJihE
 E9ell3ztMTSLUQjDgvsYhzmqf57hvR639Tn/vG7veTaQlllbGawn50JbrT6LwKlfyONa
 dvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728499892; x=1729104692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VctVtNOpO5PsXlhkP4TOK+FOvZ/wMtwj0eq6AH0+fQI=;
 b=IQTIot2wMp2j4yUYoMUeeNm9VUmjJtyZ1ufoXzfg9RuTgIOgqvJEMwQw0hm+vJqCVB
 BEMZDvRY7lDwetiwKphUqm6OcgK8XAbRjJ8qFYjpx7BjL5ZRI8rAZxNc45QiZuN9KY8A
 XB/hOOf0XUUe1/6SqyS+i5bJVsbmTbVm/hlfJV+cv3GpjFXHWMO25LvlYO+PKax6hMDs
 0JCl9qKiYzV7Z1LA2/GUgLvC4IhoQkIJsidHiK9nxICNfWt2GDGR4ePNvCTiYwb+bWTp
 vP08kKiW66+tRQOh1o3RsJycYWRtAtO23gAlwf2PO5y2ehd2aeds+jOEosheKSXuVtOb
 B1/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbc3X/zplE1olG5yM79eQnsO2UW6H7JBDHvBvZYrMDDkARCA+QLwibghmrwIIBiD06H+iLeTSKuwhS@nongnu.org
X-Gm-Message-State: AOJu0YwyrufuzR7hzpNsJcWtyG5Q9nGP70T0hfj+3XoHNUoOaqFnkb4n
 7tgghBmSjnR6w4+Or20jfeqVyOZPdXVtDfaCDvGgcpUu1zeiT4hFvH+stlgsfK817qO334NAMn7
 E
X-Google-Smtp-Source: AGHT+IGh+VIdMFH58NKRmCP6pD9qE/DET1Q3rRnB9Ae4XYDHAtZ86Vwk7yhG29rSeBCWBqKH8+UQ9w==
X-Received: by 2002:a17:902:ce88:b0:20c:7661:dce8 with SMTP id
 d9443c01a7336-20c7661de19mr28492675ad.36.1728499892549; 
 Wed, 09 Oct 2024 11:51:32 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c139893d7sm73552915ad.271.2024.10.09.11.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 11:51:31 -0700 (PDT)
Message-ID: <bcd3adbe-b9da-4633-abe2-6c0bb341067f@linaro.org>
Date: Wed, 9 Oct 2024 15:51:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/23] accel/tcg: Call cpu_ld*_code_mmu from cpu_ld*_code
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-19-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241009150855.804605-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62f.google.com
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

On 9/10/24 12:08, Richard Henderson wrote:
> Ensure a common entry point for all code lookups.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


