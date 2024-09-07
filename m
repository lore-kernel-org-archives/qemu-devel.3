Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC3AE6FE47
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 04:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smnPo-0000aJ-8n; Sat, 07 Sep 2024 00:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smnPm-0000Zj-QU
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:51:14 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smnPl-0005Ts-4O
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:51:14 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a89c8db505bso360566066b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 21:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725684671; x=1726289471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=10XIhpDYlQu0+93AnyPoFf9zsekjxr6uAe061b2gcVg=;
 b=BLyX/FKQAQz4qL5hPqOQug3ysYevlxYNMPcK7O8wDoBOJo9faAmFnVJSUOK/5OfAcm
 D0uVPakM4xVc9WrHnsFH+Tr7Ot46buIfNz3yjk/KRBVbXvr/b7oNV459wLus6HQ9/y0b
 YRkMTKbwm+1qjrRtpsS1ugymFzFKt/UjV1LUjLoQIZi1YdjJypnN0rbPsag8BLspKPKG
 RKXAtaU3yRtdYQ5/jbOUUEei/z5FyUsB2vN4CZocVsp+7cCdGOV1vaGqfc7rWs2zYERH
 GAyohhODuJK5KrxPZ82MsFg5dw5hoPBl4SziPd8+YugqEQogignI1lmFXLBtcpfVRD/T
 HZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725684671; x=1726289471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=10XIhpDYlQu0+93AnyPoFf9zsekjxr6uAe061b2gcVg=;
 b=t0uZ9vs2padDiKq5YAt7ZUar4GI5cOa2aUDmBApMLuTY8bC7KNZKpby6fwrLM78ALE
 132hh9NUs+4422+72nKcIxYDkyTonePmh+eNdOi2pciBobNK4Sodyf2gIgOeNYrqolUv
 fmQkp43xfn9ggW9pvEEVl249DRUeFLEBidc2rO9gXdHs0O7k/QAZmcLmS6ry3yi07qZ2
 2w4nvQVXmhPakJLSqp5vlRQ0gXeO+bHyx2Et9NTMbcIIy0NmXsvt8ZkY3fBdF2HbXV5v
 VNYVYfK+8lqtjQU81PusHo1EPJBayjN5/AAdWO7JsfXja8N+IWhb0XmfQuQgA1QD5koa
 HYSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyX2DVp2Q3Ps5FoZf+ZN5IlkWkD99FuR5OV2VXL/+JqwN4N2K6enBMJr0oyFcDIvqhtMPKPMGtnMvq@nongnu.org
X-Gm-Message-State: AOJu0YxtAPV7sBK9WUfbTtfZKNBXH5auFC084EtQyDIO9oaj7vlPlIUs
 DVEiZAMXaOmJ+7LSROGsaYvwQLGhuUe/YfAHPPvMYVqyitIi0ki+4ry3l+NbHRQ=
X-Google-Smtp-Source: AGHT+IH0bYyj6TP+7eaeKsy5JiKbK/thYPktyQrfsHxLOeHVq6uAiTXiQOMloYWank2X/B2JjzGnpw==
X-Received: by 2002:a17:907:25ca:b0:a86:8196:e04d with SMTP id
 a640c23a62f3a-a8a88669353mr419144766b.39.1725684671071; 
 Fri, 06 Sep 2024 21:51:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25979fa3sm26972066b.71.2024.09.06.21.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 21:51:10 -0700 (PDT)
Message-ID: <2945e4bc-d271-4e9f-8c49-95b95e3eb199@linaro.org>
Date: Sat, 7 Sep 2024 06:51:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] fifo8: add fifo8_peek(), fifo8_peek_buf() and tests
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair.Francis@wdc.com, tavip@google.com, qemu-devel@nongnu.org
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <c9fb3811-fb75-44fd-a177-7ed67d43d55a@linaro.org>
 <beb00701-7ad4-4575-87ec-ae641c4a07b1@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <beb00701-7ad4-4575-87ec-ae641c4a07b1@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 6/9/24 22:51, Mark Cave-Ayland wrote:
> On 06/09/2024 14:14, Philippe Mathieu-Daudé wrote:
> 
>> Hi Mark,

>> I'm OK to queue it but took some notes while reviewing:
>> https://lore.kernel.org/qemu-devel/20240906131217.78159-1-philmd@linaro.org/
>> If you can have a look, I'll queue both together.
> 
> Thanks Phil!
> 
> I've just spotted a few minor issues with the series which I've just 
> replied to: would you like me to send a v2, or is it easier just for you 
> to correct them yourself?

Fixed locally (and wrapped to 72 columns), thanks!


