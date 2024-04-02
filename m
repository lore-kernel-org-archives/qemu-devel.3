Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA8EC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rraiK-000722-Pk; Tue, 02 Apr 2024 05:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rraiI-0006xM-DA
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:45:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rraiF-0001Rc-SU
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:45:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3417a3151c4so4578591f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 02:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712051137; x=1712655937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GOWe2GyGcx+3ZHOdTKNj7ifgRnGfQ5+tBRUCfkJcg/0=;
 b=Rxt4ZcBxbBAZ46XSc4tKxfJSbsul+6d77I7XNewnnpyA1qtjANonLcw+YlRi2CNls7
 GIsVeEwkJzMHvpK27/vlyOcfS8GWTjpg0RykEq+JSeLOAmiym87uBvrpaOn3hJn8tglu
 21GnPs3hYm5MKFJTw0GgiLGXP9rttnb5KYHywlW2mhxnMfZl9NkoeTwsw2kUrQJcpGy1
 qE2IqldCrCLxc9Lo/2MUEjChRMdaAprtkoDWUcBw3kO6p7x8DI65MBbbIkT789o8MGS2
 K0v2wJw0IXrBjMzAJ6uAf3gYZ9iWMNvc6Om4IULQJCkjDiTCWEjI7IBdTMk1FTvlQkgO
 up9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712051137; x=1712655937;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GOWe2GyGcx+3ZHOdTKNj7ifgRnGfQ5+tBRUCfkJcg/0=;
 b=vC2n2PuZIDjFNn0slqju/YPOUfnow0GUzPZNDr005Ko1ZBmkrelE5XSZiHYKKvwSwN
 wYF9jz7XMyr2JpbEA2q0kP3AjXOaLRoy4crPWdSz9xXxnnOe2oGQjWfh4Eow7kKFXeGv
 YeaNdYMLjSSARm+AHnD2pPTnNYTtYAPJVThxyAV/0aiCjAzs9oweYp3/mwFkHyeu0Onh
 cwBeS1CjAv96/KW7PAONa4/vlIv8ko57S8a99pA+tPuSpPx5FRn6iXd/iiQtvyvTicsI
 PlKdCL9oQio7ywr6pDbgOaINJ65Gy5FTcZlt0NzeoF7sO+lHPsVXIPO1L/vqmNk6oLYD
 yCWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4sWflCzFDcOV9GMHvNRN0yMMgS+m9RQWzBHrQMP9yLQsWX0Bnkwhjn9zUS1fMcszSC1UidpC/YY1Nu57sZH3f5owwUk0=
X-Gm-Message-State: AOJu0YzCU4OEf7ccMX9zKprTFmONMIBoSjkk/UBpRiqBoadBkYM1Bfwr
 Fhz1ErSq77I8JXIBPBRVSSMUr7XnxbVdqRXhZFBUqUUmdCtJAw9jAh7bfYUFVaM=
X-Google-Smtp-Source: AGHT+IEq6AUGFjUWyzDjQBCQgpzax2RQwTwzQkL9GlBDklja6VhQFImLV3CMs625z7qemrajJVYwUw==
X-Received: by 2002:a5d:614f:0:b0:341:dedd:9726 with SMTP id
 y15-20020a5d614f000000b00341dedd9726mr1010350wrt.3.1712051137008; 
 Tue, 02 Apr 2024 02:45:37 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a056000194b00b00341c6b53358sm13643480wry.66.2024.04.02.02.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 02:45:36 -0700 (PDT)
Message-ID: <75fb6e9f-5b89-4218-aabf-2f5bc0173701@linaro.org>
Date: Tue, 2 Apr 2024 11:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsi53c895a: avoid out of bounds access to s->msg[]
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>
References: <20240331181730.150860-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240331181730.150860-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 31/3/24 20:17, Paolo Bonzini wrote:
> If no bytes are there to process in the message in phase,
> the input data latch (s->sidl) is set to s->msg[-1].  Just
> do nothing since no DMA is performed.
> 
> Reported-by: Chuhong Yuan <hslester96@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/scsi/lsi53c895a.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


