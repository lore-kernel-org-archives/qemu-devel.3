Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BBFC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2024 23:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIdIm-0005q6-F6; Sat, 15 Jun 2024 19:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIdIl-0005pX-9K
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 19:59:19 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIdIj-0000sP-PP
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 19:59:19 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c315b569c8so2764347a91.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718495956; x=1719100756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QwRbPkLDVSDP4h/lqOJebwcfM7nvYiuCYzLbifpmZfU=;
 b=yJ5bV33/dYJglndMBdt51S9KCuMCaCfdkddcaVWRUfSTHxp9tpczjb6FZMQAYgiMA8
 4wBuJHaL5FwQzaFYeQIYGfAUoAu0SdhB7kxDUP1bRqBgCZd5+Y+rHi/dEdJhRIJeu9nw
 ls1ITRpODQ+crvpg8Oba3PSrX8vrSRS9sJ8n7M0cRTXV8zbbkz/EYF/m7eyGGtPTH2VD
 17C6l0NvvjH2rfbw2yOETJkD4OdM9Zexn2mB0KhwkqwaXgmVc/m9ZwFXuA6zMfq+mU1o
 mmeDKKBFattNg8qNL5CwKM9A3tsLVxGlrVEI6OIlMU2oVzfjquY4jUu/aToNSBu/cjJP
 04ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718495956; x=1719100756;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QwRbPkLDVSDP4h/lqOJebwcfM7nvYiuCYzLbifpmZfU=;
 b=ugy950bKXqRWtTXuZ8D1lJ+IQHQJuu1FASjKdzjir3Qk1//8FmeWFmfgfpPa1WCzLy
 NET4spQT9Kl6PAYdNhbuI4RRo//+Uxu8sbB4krL5Xz8BrUKaysMYzp1VXoG9/JrqH+is
 Z6hwc7JQFDyQgSU6x75YsVKxVwkcJ1J17w2YJW9sJMtC/DNzp0MHgDlkqQYOntA4EvHK
 4gRDbTjpGl/LktXHvQv021CA6Vdol+SQX3y/GzgrkScwel99tS9Cu0SU+JBBinqb1T7C
 YMV4Uk/0iGp5gKquB+Qo6PHy9g6LLH8fVu5E0onliV+KvQFeuouD5/F4M/aR4iyDNh1i
 XiRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ4X5YOSkDwPyO7JK2LgQUBiSwQWlyZcfrnVkhDWi5RptXlE7AK88eVYR8MaqE8lE6unmEh6WESx/HGKfvQcBVe7thUuU=
X-Gm-Message-State: AOJu0YwWRUrWQtJeP+7Uu86/doKokmOw8wFZ5QtHzLRu23/dt5n3w7gV
 J27F03l79TG+cnlBaLDspwbQXaxi8jMpfBfDK2OmRE7R3RMGFqB89r2NzxPMXjg=
X-Google-Smtp-Source: AGHT+IHNW881ajHV074FT/zI9IGJnnx8xHbRChJIS358sYFo8IQhYXaN2p9won18g2+jflPOujGO6w==
X-Received: by 2002:a17:90a:db06:b0:2c4:de4d:f9ad with SMTP id
 98e67ed59e1d1-2c4de4e193bmr5576904a91.1.1718495955753; 
 Sat, 15 Jun 2024 16:59:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a769beb8sm8615589a91.41.2024.06.15.16.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Jun 2024 16:59:15 -0700 (PDT)
Message-ID: <e486aaee-9c2d-4bfa-adaa-d36b6ca64435@linaro.org>
Date: Sat, 15 Jun 2024 16:59:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make TARGET_PAGE_MASK typed as target_ulong
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: jansene@google.com
References: <20240614192938.1690188-1-rkir@google.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240614192938.1690188-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 6/14/24 12:29, Roman Kiryanov wrote:
> this fixes the build warnings like
> 
> accel/tcg/cputlb.c:416:13: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
>      mask &= TARGET_PAGE_MASK | TLB_INVALID_MASK;
>              ^~~~~~~~~~~~~~~~
> include/exec/cpu-all.h:169:45: note: expanded from macro 'TARGET_PAGE_MASK'
>                              ~~~~~~~~~~~~~~~ ^
> 
> also this fixes the inconsitency in the return
> type of qemu_target_page_mask (int could be
> shorter than target_long).
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>

No, this will cause failures, because we need this value to sign-extend to when the 
context includes {u}int64_t, and target_ulong is uint32_t.

What options are you using, because this warning should not be generated with -fwrapv.


r~

