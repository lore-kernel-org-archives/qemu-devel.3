Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295A0C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 19:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raKdi-0007qT-LA; Wed, 14 Feb 2024 14:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raKdg-0007q5-Sp
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 14:09:48 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raKdd-0007hU-J6
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 14:09:48 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso551435ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 11:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707937784; x=1708542584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f0YQMb6Mr65gUF+DG98tgpFObPeA5rNsQjQhkk2SVrs=;
 b=zXthJfYO9cXYcUYt3U9KKfvWs7ep7OdRVhqIU9osi+cfrKg7K0s/cG5JS+yiwN1no7
 QoW1ABLuckzCQ54sN/yNcNqU9JxdoTyRQC5e76KKLq0QJhjXiEWc3pKj4votdYJUmBlR
 hggufK+0wnQz+ejSnqfEnW6OeSEedp/AzinPx/emOGBtDDQlSoGYKe46rbHJMCSmyyqY
 tSHHaNQMh/aj8kTSxJJ37mc1wSaVrgUMmuCffqdKGn9m7ZKWWu5PK3SF/RzY5Cj7zkQ/
 DNA4Re4BUkegphysDx3bRIcmrd4zvxN2bZBIw/nWEZcZnC1eDp1lI2YAiJdAO6NtDaoI
 t6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707937784; x=1708542584;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f0YQMb6Mr65gUF+DG98tgpFObPeA5rNsQjQhkk2SVrs=;
 b=gWzQqt0ZRX/r9k2czCJHd78LjujAslZp3NN35qjFwlx+fcVLPib06d6bMDZD8BI1jh
 Fm9lE7f3kKeT3AkE0TwskgNjqIRdA+CLWs7lEtRmjO5CEBpHtK7rCPyydOXYlaXVBXWt
 VrfEh6z4galSFK1H+fPb9ShFPyOWWXcFaNEumS4Bw7+b3SYy9mjzIeIArU/MTDF75UDp
 74AXEPPEaL29mJL/Kio8CY4tTNX67lGVyGiKBkcJ49o1rR0XFaiOGI9WzkEXzmEnQ3uM
 TZfApl/dQRu8CdH+ZXVEtb0uS+NoWMS0+bJgO5KaO+A8rT0O4chZKuLlQFtuoJvHNTC9
 BEMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTWfWsGKqKVj16YoAcAtx5xIkdG4qLoh3mdyT+C5mlgHY5ieRuzGxmCwBtc91rPhBv5EHGaYfsOAFkk8F5RnJwtY1UPmU=
X-Gm-Message-State: AOJu0YwttBz5VHAHIt2c6jxI1gYMSN9XfR4+NT1K9vyawqJyOJxB8f/1
 Rq+u4/xiWtgyI+LkA1jmKvga/kQASK/bvDJxUuwsVBnGe4xJ8XCWwuu1ZCeVbDM=
X-Google-Smtp-Source: AGHT+IHpNyl8XwJck3jUglUtwbVG5YAw/S4PQhoJQaHfe61L/bwSwMQqnlqM4+9N/9MPGaqdskXpnw==
X-Received: by 2002:a17:902:a386:b0:1db:29d1:4614 with SMTP id
 x6-20020a170902a38600b001db29d14614mr3470764pla.26.1707937784083; 
 Wed, 14 Feb 2024 11:09:44 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWNJIfj8lHyBRro6/t0SRO+V9PWadgHs8tNJZqBhbLQ5SPNEYiAn6T4O8oi0lM+bNjJDgVQrL8Ds/Kjs8erYswlfd6OTQVC9o6F8WfT0kCR/YYEfG9bL3JDZ32OSFTni9doX+89FDjuEl6DpOGCalNuxiytx3qROILVPJhlaKLqv7ipe0N89iE2wUr9DbGzl1Au7sV6nSmZIAjSzhowsOjc4MhsDaclC6L0/ZU=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 lg7-20020a170902fb8700b001d9620dd3fdsm4057461plb.206.2024.02.14.11.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 11:09:43 -0800 (PST)
Message-ID: <41539522-c05a-4c67-95f5-0ecd69fbcd8d@linaro.org>
Date: Wed, 14 Feb 2024 09:09:39 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/ppc: Move add and subf type fixed-point
 arithmetic instructions to decodetree
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org,
 harshpb@linux.ibm.com, sbhat@linux.ibm.com
References: <20240214094027.895376-1-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240214094027.895376-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 2/13/24 23:40, Chinmay Rath wrote:
> This patch moves the below instructions to decodetree specification:
> 
>          {add, subf}[c,e,me,ze][o][.]       : XO-form
>          addic[.], subfic                   : D-form
>          addex                              : Z23-form
> 
> This patch introduces XO form instructions into decode tree specification, for
> which all the four variations([o][.]) have been handled with a single pattern.
> The changes were verified by validating that the tcg ops generated by those
> instructions remain the same, which were captured with the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
> Changes v1 -> v2 :
> Reused X format for ADDEX instead of creating a new Z23_tab_cy
> format. (Richard)
> Added necessary instruction flag checks for ADDEX. (self-review)
> ---
>   target/ppc/insn32.decode                   |  26 ++++
>   target/ppc/translate.c                     | 136 ---------------------
>   target/ppc/translate/fixedpoint-impl.c.inc |  70 +++++++++++
>   3 files changed, 96 insertions(+), 136 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

