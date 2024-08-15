Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3F1C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 09:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seWZ5-00033l-W2; Thu, 15 Aug 2024 05:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seWZ4-00030U-5x
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 05:14:38 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seWZ1-0003ga-J3
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 05:14:37 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7d89bb07e7so93403966b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 02:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723713273; x=1724318073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tPQeJ0x7VxSs4zGhRcbAQtigvLk6ak6daA0+FK466dw=;
 b=bTMeKt2D/qjKhmLFpERXsNvAV9P9CG2cRetCXdYkWUQF0DnSUzoa9Dhu0hvZTcQnze
 flYlvXwqJMQOLQb0OA/8cCOtW83H9A731A3r/D6ZyLJ7V7XzbkinxYQ7zhyPTz56kiaI
 15zJOISQIOWupMjNzDp2s7Wpnjd4soDKdRr6chX72J8HxUN6Q50Z8v3HJLkpEsCZzgEI
 Vyxfj3X278QHcIV3IHsVP+/8oYVj78LUhZ6pFgMUtPiO5WN1rWSBQcg5nGuzEiVfYjIG
 3YxcfS+Ph9b3+p5rurJQZCGgQhMOa81N8YRsb7nOHMRGYC5we7PLjbuRyUqDFNnQBYHe
 hmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723713273; x=1724318073;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tPQeJ0x7VxSs4zGhRcbAQtigvLk6ak6daA0+FK466dw=;
 b=j4EiJXkg71uGfo/PrwZoMRXCAGw+JBIwO4cQWUfk91EipAfBX32NnwJFvFFx40fL/f
 aYI4ndT+rzEbU2kfNWL7v0w0ZjHrgg/WAmPq2Gc8IVH6mKlCsip1iEruKjlCXhm4Jnen
 fKJjUAxMvAdB4KK9Cc9zWFm0zuo8NFPjQPa8iFPGfFrGpyeW4cR9Ei/bE97BBtK+q1rP
 BkYJO/vZUIBvLDlyLhDfhaonwfMMYxcQvbTCW8fzzOIUGfm2MHiIVRS/fyxu4sS8lWZw
 bJlYiNPqnIIb/paZvClGcz2ZpDNx7FUSXjwKM96PpDcxxVrVAyv+zPeGWW4siEmafFr1
 r1OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVysKGb+tS9yxrpJOxJqIwsYC2JW7E1z5l4aUfCo54NuywjcDV4uPl9C5XIeuhcDogXVRwUHL2Ev28GDYcRyI+tAu8xEtY=
X-Gm-Message-State: AOJu0YwTXBaoFjV9gHK+6HZBvoMTqosvwgXlhQCcAoSASRWF+7TGwT5H
 ZdsRnasq4F6MkBfe334mPONpvz6WQ5z8x3jbpcn50Qhp/MONZRgfX19EH//MrRwItL9JVXFoW5V
 LJnM=
X-Google-Smtp-Source: AGHT+IFHv0nWBsjIfF4wvtFNGKH767izxdvW5jyDB2SnuVMlXb79DH8DjB2aB5Ub0hDBgoMZc/BBSQ==
X-Received: by 2002:a17:907:f1cb:b0:a7a:afe8:1020 with SMTP id
 a640c23a62f3a-a8366d43fa2mr390734866b.31.1723713272704; 
 Thu, 15 Aug 2024 02:14:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c7444sm71570666b.6.2024.08.15.02.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 02:14:32 -0700 (PDT)
Message-ID: <b22b9c7e-ea66-403a-9e26-a481afc613da@linaro.org>
Date: Thu, 15 Aug 2024 11:14:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] linux-user: Preserve NULL hit in target_mmap
 subroutines
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240815010556.535100-1-richard.henderson@linaro.org>
 <20240815010556.535100-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240815010556.535100-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 15/8/24 03:05, Richard Henderson wrote:
> Do not pass guest_base to the host mmap instead of zero hint.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2353
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

FTR per 
https://lore.kernel.org/qemu-devel/6d425bd0-efd0-42ee-af3e-d7b5c3379d55@linaro.org/:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   linux-user/mmap.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)


