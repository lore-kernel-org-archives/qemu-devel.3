Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA8EC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pob-00080A-Bn; Fri, 18 Apr 2025 13:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5poM-0007xB-B0
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:47:40 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5poK-0002WW-Dw
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:47:33 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-225477548e1so22007995ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744998451; x=1745603251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rsgQgeFchpKQUBrZWr4WGFaX71tXDArmbhLXVEngyWY=;
 b=FRBPerjEVnxetXctq0JIsmAvhTpshH6stw57DTyLQ93sAe/0e9c17uYppU4PFxmKCX
 EsvVfbBBuyhPpbuia1RdGYFriGUKCMKzuHYj+WMBl6mVVElOa9/dpbDIF0erxTNUp9YM
 B01KNH7WNm1cgFPid+Pl1kx6+ibr3Elzdi0Ez/jU462zF0oyIED0E6L+Jz2f0mER2X7m
 dpQYMiRkNXianb/TA8wJLae/vtVrFqATvEXVS88fUPoGo2tbCkY1hWkxj9RH4KqVH8c8
 Ll+/Z5h3efEI44zK7hfEEhl+90FQM+ktwFWPBzvfi/mzg/yep1y/IAi/QCgmFV7ATR6U
 YxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744998451; x=1745603251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rsgQgeFchpKQUBrZWr4WGFaX71tXDArmbhLXVEngyWY=;
 b=m31UI3s4mlY8QkyOli3tkZlxRVwWXEFD6OBAWrrnhsZMDvwSvX7+24x+4nzBCZT767
 AdzjeQQ5G1XhUtcPbFyYjwbPDAdD2vTdTj6khySDNSscjea6DfM/zxQCRAQYUfEgqTBv
 gF/2+SDhgn0VUc0n9u2mlk5ong2t5W1zQmTifEyVvyMF5NTuZFEHAuBbrNJMF+9CX0hg
 Qt4ecbeotRPTkC/mH4n0zzcYnONUqHSYfWtqq/WmfzcACt9Z8sHddt5FcGIViyeJYkZZ
 fgKGkDah3B8NIDspD5qkr9hzW9wGKbs+pZR60UyWckmzw9/od0O/pe4vXOTD0VlnpPNM
 JsYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYM4t8vLgnDL1ux+RVv/6RbSp21mme2L6yN14Pl5S/HuiCmx7nhKWVX97WCnS4jbu2qWGMg5AjSzB0@nongnu.org
X-Gm-Message-State: AOJu0YwJoa3jpl7p5jGhCwS7c0LJf8J8DgHFeYoLm3SYQtuTumji3/aV
 uJDKp4E6LzvsygCjAfAXTz42naWB447QQJrsBTVx1KATYQazLGtkoWx4M2dSeNk=
X-Gm-Gg: ASbGncunYuXAUAUE7L+EMKzaXVebRZfgsMhQi+jRNZrSL/rBhU/5sK51r37G5NCiZh0
 uw5iI8DnaVue8Rg0wVXjG7d3B2dZy0GxLxZ+Q0FSAPUYC9oVDFjyobWELuSRDi5L2+JSYQtTOew
 npS4UUDA+XxBDTftLTllYuVh85dRjR3WlZp+fEn+uGRnHCkbMwd1akldL/TxxZR7jb208n03QOW
 JHIM9SujW8+sFIOEh2SWEh3EtQvVAmiZrZRfvpXiVcDB3r1sq7D/IMpzI5R799R3lP8aujI8v+z
 Asc5zNMu2bfU6CZly6AQ49Zt9uXQiPMetLlFvv+c9zBFip6qaH0uCEePYnGmbH/EzlTKpQdCfIf
 pYcTu/40=
X-Google-Smtp-Source: AGHT+IGT47lbr46i7bcVvkLK4sI2gjtoIWi0uVOJVk8bivE74xOtvkmDNuzUINiHuCm1ssD6jhPcmw==
X-Received: by 2002:a17:902:e54a:b0:224:216e:3342 with SMTP id
 d9443c01a7336-22c53619db2mr49654045ad.43.1744998451064; 
 Fri, 18 Apr 2025 10:47:31 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bd9bd4sm19812675ad.51.2025.04.18.10.47.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:47:30 -0700 (PDT)
Message-ID: <8ec52d32-9706-4102-b33e-58eb9522ba44@linaro.org>
Date: Fri, 18 Apr 2025 10:47:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] accel/kvm: Use target_needs_bswap()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250417131004.47205-1-philmd@linaro.org>
 <20250417131004.47205-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250417131004.47205-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/17/25 06:09, Philippe Mathieu-Daudé wrote:
> Check whether we need to swap at runtime using
> target_needs_bswap().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/kvm/kvm-all.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

