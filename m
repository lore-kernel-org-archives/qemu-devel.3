Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FB4CFB421
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 16:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx84d-0002FP-BF; Sat, 05 Oct 2024 12:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx84U-0002Eq-Kk
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 12:56:02 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx84Q-00030r-8n
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 12:55:56 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71dfc78d6ddso139669b3a.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728147349; x=1728752149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XbpekZFMDuJM/kqKd3t1NOuoXoBPdvnQzAvZj3UcJpc=;
 b=Ai3ibbilqCSnlPuwC+4t/u7QN33LaxOjJNIra0/f3p4BkFo6mn6DG2b+mpiZWdkmXq
 TrdV5Gzp9L6YRElOW7J904ZOcnPwVbGU2bN2aSOYUxlSCVUfj2wRyiv4XMOxaTgUCWs0
 xuOZXFITp1XZunPe2YdANiRPqEW+dpY/w8bz2tnt0X28AvRXdq2BKhYV33k01u+3qLoh
 eSJDAWid8RyPWQW94zjMyxI8ceKwqsZeDhIBLisycJrf+XcnBwKdTMKOhKxhaeqzvAyk
 L0/ZE3S1ZC4sBuKg7+slQ+7j1b6aS/en3UFrViB25T+TaXfFtNMrNnRvkqB4tKn4W1/K
 Od+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728147349; x=1728752149;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XbpekZFMDuJM/kqKd3t1NOuoXoBPdvnQzAvZj3UcJpc=;
 b=NasxUaSX9HwnPZ0PtDOBQf4Te/GJ14AAiuj1R6JqaEeHcZCQeKhCXb7ctpudJVspNr
 B3AbV7yONSGvjJqonT/Je9ZtsvXkDHKbzOyzfl2G/ytYipIR+pU6n+umrni/SLZV+zyg
 fsDpMgJ3jBHvec+BspJ7A8Xafn0B+7X28EnG18MljQTxnznHqsYapiMGV/530qODzyB7
 9sEEKXxOtpX0b1PCXRkk+/FzBnLlFroEi3yj1wyPMEp8lSLcQPPWbrvNYb0xlPMTTsQs
 8tpplGLb3gaqF0dz1wQYEYdNkMRz/G7ejz9yiFnB1G47azRN1hDbrmxMftogzi5p7kI3
 0zGg==
X-Gm-Message-State: AOJu0YykcYVGy2F9hwMTdrVqrvbAT1HASAg3O3fdczTf5Sk8buGMSpW4
 xxFagM1KoS4zVV/2lCe0ZEymlQMZz55K55kJrU0lokATXEhEPeQdsp0VJh3eLcU4UtY4iCf2aKJ
 h
X-Google-Smtp-Source: AGHT+IGyO1IYVhPdhi55RlYsq9gxduEAvQgnIY5+p+NDqB9y/Y7uxg71YFcMhS7N7OB6zYo1UURzpA==
X-Received: by 2002:a05:6a20:c886:b0:1cf:6d20:4d6 with SMTP id
 adf61e73a8af0-1d6dfa34c23mr10867889637.16.1728147349331; 
 Sat, 05 Oct 2024 09:55:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0ccc4b2sm1680505b3a.45.2024.10.05.09.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 09:55:48 -0700 (PDT)
Message-ID: <9bfbfa32-9e23-48c6-8386-a611898ef306@linaro.org>
Date: Sat, 5 Oct 2024 09:55:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: {PATCH] accel/tcg: Fix CPU specific unaligned behaviour
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, linux-parisc@vger.kernel.org
References: <Zvyx1kM4JljbzxQW@p100> <87cykimsb9.fsf@draig.linaro.org>
 <c05823ff-47dd-40b1-a363-0c4b9cb47713@linaro.org>
Content-Language: en-US
In-Reply-To: <c05823ff-47dd-40b1-a363-0c4b9cb47713@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 10/4/24 07:24, Richard Henderson wrote:
> I was hoping for a reorg of the target hooks that could allow the target to see 
> misalignment and permission check simultaneously, then the target chooses the order in 
> which the two faults are presented.  Given how complicated tlb_fill is though, I don't see 
> that being an easy job.
> 
> I'll play around with something and report back.
Careful review of exception priorities shows that this cannot be done without expanding 
tlb_fill, because of how the alignment fault must be prioritized in between other faults.


r~

