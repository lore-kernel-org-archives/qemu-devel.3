Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C67C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 14:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvIFe-0006Nf-TM; Fri, 12 Apr 2024 10:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvIFd-0006ND-4A
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:51:37 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvIFa-0007te-TM
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:51:36 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6eaf9565e6bso824022b3a.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712933492; x=1713538292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JxMIdEMEIJb6gwo6CrMzE/TyI1JfqOeYi8xaE90MHSI=;
 b=Y9K2PUyBbCsmw/RS7ZLvvJjNjm85W5VJCaZ7rw/OMuPkEyA2Na3zb2pqKbinWU7oEb
 BCHZs0VMq6MCNnVdWA/bWAXEAvWYlCL77Vr9lp5krGdV8Nh9AOCArtuLKTtY/6+jjUon
 6UaLa2IZvp/INMBGMhdmZb+42wUoKofqn/pOthRkv86L04HOYtTg41W30YdA6QTPdcL0
 IXGvEaCbnuw2+elKbF/4DqwynQ4UrvkXJfE3WZupEX9GxnU5y4kCkEPMLetCxESfp5wD
 uKYOmsiI4pvrGO+TZi4J6I5RWA1KAOfTGklrZFZ2Pr6b/w4XqIQqAFwl0oNyqc3tJWDW
 P5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712933492; x=1713538292;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JxMIdEMEIJb6gwo6CrMzE/TyI1JfqOeYi8xaE90MHSI=;
 b=srJX8Adr3H6jrZJuXTMf09Wl3UDZRteZmvRzczKpOjtGZUpqrUuHnZ8U47rfpqvEoM
 ylIxF/s7E9zbWJoGjEybnhCQ6YMBryWp9NNpNhaZr/Y7V2T1ZfxTMwubWiB2qoK62Ild
 wqfwKqXI7YqJg+6Zpjvo44TYd4NRGjzTLddpMG69SpFMY/47hpwT3fUxGGCIZfN7JSDW
 0dEOzQt1vZxKp0tvIsizr1LtoUz7cvGiR6sqpIcAns1al5MYO/7euPQmf4AS9ZiYK9ND
 tRMZOhV5PlUf3WYTXXJ9/4qdKjKeqfQqflcLTZuggLsMpGOtGGRGBJN8ThE9nfuIZXhK
 vYGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHU6Sa19nV970xr0nEUPyYh5NYDKSxH1LtpF9/XOfUXw6CTFlHOsagKnPe552YlPq3iEN1Oma6TgUZs1klyR1kPRNqJi0=
X-Gm-Message-State: AOJu0YzMNRkSzWz8lNHlFCjxZXZ/ct0o+bsi5lmOTngh3sBN9Ihjx6Z1
 0gKwDFLJTT9SMfQ0wRMT6SMtb3IC/V4oVyo+Vbp3pImXRSDPbgS3KZZtRXBgyaim80H2M9YHusk
 F
X-Google-Smtp-Source: AGHT+IFpIpcFQXDPOTa1d0XmIcX/WyEr5oJEuZZUpa8qQaP45R8XH/PvIyM1YHoISYpHHRtNirEolw==
X-Received: by 2002:a05:6a21:999e:b0:1a3:64e8:eb8f with SMTP id
 ve30-20020a056a21999e00b001a364e8eb8fmr3717906pzb.11.1712933491759; 
 Fri, 12 Apr 2024 07:51:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a056a00080300b006ecfc3a8d6csm2950683pfk.124.2024.04.12.07.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 07:51:31 -0700 (PDT)
Message-ID: <015bc53a-fadd-4d3d-b755-73b0f5d140bc@linaro.org>
Date: Fri, 12 Apr 2024 07:51:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/27] hw/net/rocker: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-25-richard.henderson@linaro.org>
 <897eeeb8-d97e-4309-83df-d2828916b5be@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <897eeeb8-d97e-4309-83df-d2828916b5be@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 4/12/24 03:58, Philippe Mathieu-Daudé wrote:
> On 12/4/24 09:33, Richard Henderson wrote:
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
>> resulting in painful developper experience. Use snprintf() instead.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Message-Id: <20240411104340.6617-7-philmd@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   hw/net/rocker/rocker.c | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> 
>>           switch (offset) {
>>           case ROCKER_DMA_DESC_ADDR_OFFSET:
>> -            sprintf(buf, "Ring[%s] ADDR", ring_name);
>> +            snprintf(buf, sizeofbuf), "Ring[%s] ADDR", ring_name);
> 
> Ideally we should convert the DEBUG_FOO guards to trace events,
> to avoid to maintain dead code.

Grr, I knew there was another of these that needed fixing up.


r~

