Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A4CD10BE9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 04:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4YSf-0003Oh-75; Sat, 26 Oct 2024 00:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YSd-0003N4-5b
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:31:35 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YSa-0008HK-MU
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:31:34 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20b5affde14so19250075ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 21:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729917091; x=1730521891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vQFUT+9eznvkrzicjIRNa391H8s4Bx97SjBzilVyW4Y=;
 b=NNaan5L1aT9tjRa6A7NzW5zMcfPPZBzH3v+dJFQJeF0UsZnfl2Q6revBv9vX7thZKG
 xW2pVLjl7BudAwmg+82CIiYipoK7ki5GwZ3dG7ly2eygavMlnI92sU0pVLCGyWf6WGZU
 OwshFutelToJ2VHvEb8Uvh/UGO//y2NZ3l+YPQiGdVpk8C1Y4QPdnoo+/NqSxPueG3Gj
 DGq2Ur9gM09bEfJZT8WwnnLFQ8Dyx609EFX413K2ILTskl4ajqBxjnkl0qzc5pMTcFiV
 iOvnlh9miu3yPfnZufHWSZLCERKwsybxGQp6QU2FvSIlRQi4e5Z59n4PI72/zb0mriaO
 bpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729917091; x=1730521891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vQFUT+9eznvkrzicjIRNa391H8s4Bx97SjBzilVyW4Y=;
 b=NjQW+As6TgQaCdFfHBPVWg8q6rlPOA71VS22MpTtH8xAubb7UcTAkDIY6XzqKHgnON
 u+TuNlRSHwot7lhPIxBUddDxrizDWHy5AvQsd79mXMSjQm+/5BoMZ9xeUhZMtQUnIxB5
 w5F3NCgHhyF8//mJf3FIXVeOY7kfUVGMx7mEnwBX7fgXW0DsSheBVr/Sxi4lkdIJt/NK
 hdRQseiqZU7TS5At2MsIYBpf5heUvqH0ussYoGhGGPig8W8uLkj0JQReMPKJpNTpGfyX
 fqRJ26E9WniRraMMd9oXFz/0Yaeu/H0mNJwt6OCZtHAeWnum/BwoCXqhQJ1hoQyGkbFJ
 9Z9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaJrl9EqieasJt1qGumd1gQRllFcS64jU4U9WMkvREx9lM6INW4q3kvCM9XBqlXCJ+Bi0qAqkNUdMf@nongnu.org
X-Gm-Message-State: AOJu0YyIsYL0iJSSlcIZJMw3KQfUs6uUSeCLq5tG6Ohya0JnHBHJejYt
 M+8N2RzoGd+yqK1858iH9vWlTR1h3tiISKJcNNvlbpno/718Gw05oOojhpGM3WcSODPu03QewKy
 K
X-Google-Smtp-Source: AGHT+IFU0RXYnF5Od9msysEhanVG6XdYlrsv5dJzVCaPoDM1turQHQTLSuLEVSYTQtJwfnH4xmOwug==
X-Received: by 2002:a17:902:db0f:b0:20c:cf39:fe3c with SMTP id
 d9443c01a7336-210c6c34824mr21072615ad.41.1729917090995; 
 Fri, 25 Oct 2024 21:31:30 -0700 (PDT)
Received: from [192.168.120.226] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc01791bsm17195155ad.145.2024.10.25.21.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 21:31:30 -0700 (PDT)
Message-ID: <43863d19-30ea-4f68-a353-4cba12532ba1@linaro.org>
Date: Sat, 26 Oct 2024 01:31:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] softfloat: Remove fallback rule from pickNaN()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-22-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025141254.2141506-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 25/10/24 11:12, Peter Maydell wrote:
> Now that all targets have been converted to explicitly set a NaN
> propagation rule, we can remove the set of target ifdefs (which now
> list every target) and clean up the references to fallback behaviour
> for float_2nan_prop_none.
> 
> The "default" case in the switch will catch any remaining places
> where status->float_2nan_prop_rule was not set by the target.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-types.h  | 10 +++-------
>   fpu/softfloat-specialize.c.inc | 23 +++--------------------
>   2 files changed, 6 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


