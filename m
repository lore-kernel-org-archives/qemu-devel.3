Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A612D2CE12
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 17:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3J51-0001V8-Az; Tue, 22 Oct 2024 13:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3J4y-0001Px-Ov
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 13:54:00 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3J4w-00062V-V8
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 13:54:00 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3e6010a3bbfso2523740b6e.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729619637; x=1730224437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p3uMnWDIiCjds2g/ucxtwOkwaCQa9ZxfO1sNUKKjtrk=;
 b=Rt+/MImO0EG3kdkhpscDkQ/CO8vPlVGKbERNvft4CuiQBVoyFDRUQYqpEo+aIrKlAG
 eozkFMKHgXWcF4+durVLe9ebRoHsENU7Z0qVbNL13gxAkL5ZZDS08AD54W6oU/76W5Er
 nbowEhTH9SSE0KbQwi+TVMxTDLuB8qw+PxDpb4hq042BtdnJnJZx55EsuZo/T+XbbUWN
 xM3QoqGhFUfKI0nd/yKrLPKB+P3K2Sr2aEZfaha3pUouZqxxibn9wWXmDNfoEhwp2R7T
 kgZShA4N99MNCP7Jk6AtoCNPPfdIGEdKf3OfWRgXWmsMlGceXXTETeJ44xoU1xs4IV59
 Sxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729619637; x=1730224437;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p3uMnWDIiCjds2g/ucxtwOkwaCQa9ZxfO1sNUKKjtrk=;
 b=a2DrNGB+ZXBrPnTYXCV0jvipTXyzYCZ/PPyGXCVGp4syLIfnpO7c1W2qLDcnnIe+Kl
 xZe8sDNB6bAg923/LeEaFiJO7LpU8/gcgYBlxM/ZMy/Hliz5e24yrj1GP9CUO+BbOIHL
 x3fX0fL/ci9cAATElLyL8HMfNfcSFk3VP/kaYUjzR8UXYnH4csJr0YjcBu0e0ZPFyUEc
 z7G4WXjYQwCyANSGlIuJuXrixIR7MUSIBUO6DF+SxMIxmNe08Gh44T+qB7Nnza0RoemC
 SJxqfuVA3nzKikMXW0UfmrXtzPz402eOyCSSo5Ynh/Pg+JXSJzKAanNxojiMMAjrL9SV
 lHPw==
X-Gm-Message-State: AOJu0YwtkCkZ2PkswFp9uZFhgM0OsHlIiaFvwKfNa63+VNjewPn8qO5b
 9PlYMmGz/eCx3LdF8yp4RLjwXsDbh7awmYqSI+lbuZD/E2pREd1xqXFqPEQCHn8=
X-Google-Smtp-Source: AGHT+IE57+K3bg+qoSDWMV7XdXw2/HPBBBKXBZccW5n+MIUMdmzeezxsx2Yqfa8uvRrqZi/qSaz4tg==
X-Received: by 2002:a05:6870:b521:b0:287:34a7:af9a with SMTP id
 586e51a60fabf-28ccb486fc4mr72699fac.12.1729619637361; 
 Tue, 22 Oct 2024 10:53:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeab581b1sm5382000a12.45.2024.10.22.10.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 10:53:57 -0700 (PDT)
Message-ID: <2af51996-ffdd-42b6-9f9c-751448e4287c@linaro.org>
Date: Tue, 22 Oct 2024 10:53:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Trace rt_sigprocmask's sigsets
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
References: <20241022102726.18520-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241022102726.18520-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

On 10/22/24 03:26, Ilya Leoshkevich wrote:
> Add a function for formatting target sigsets. It can be useful for
> other syscalls in the future, so put it into the beginning of strace.c.
> For simplicity, do not implement the strace's ~[] output syntax.
> 
> Add a rt_sigprocmask return handler.
> 
> Example outputs:
> 
>      753914 rt_sigprocmask(SIG_BLOCK,[SIGCHLD SIGTSTP SIGTTIN SIGTTOU],0x00007f80fddfe380,8) = 0 (oldset=[SIGTTOU])
>      753914 rt_sigprocmask(SIG_SETMASK,[SIGCHLD],NULL,8) = 0
>      753914 rt_sigprocmask(SIG_BLOCK,NULL,0x00007f80fddff3c0,8) = 0 (oldset=[])
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> v1: https://lore.kernel.org/qemu-devel/20241017091449.443799-1-iii@linux.ibm.com/
> v1 -> v2: Do not split operands across syscall completion (Richard).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and queued.


r~

