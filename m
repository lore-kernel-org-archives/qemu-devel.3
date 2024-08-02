Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027D0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 16:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZvAy-0006nN-E7; Fri, 02 Aug 2024 12:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZvAw-0006ml-0k
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:30:42 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZvAs-0000Fr-6D
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:30:40 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so19814185e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 09:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722616235; x=1723221035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FauIog5avRzm7YUZ5fsTocW4KZAu02y7gZH7TU94rxs=;
 b=idFrx1xwnu2hS5ajgST17oFV6r77hsFBDA1ggINiN+xcE6R9BI0Wyd2g5O4UoS8Ldk
 EXVMwKshLXH3hb5oKYjkAnJtP9TJ8QOX69DTlnhx8IymsYVEwJ9/J7FooP9t3P+gwOGF
 o3XlC+sxGBY/iTpXeaCB0lX3fRTuBhYGcqWctUaahErxeDHUonBdP1UDdPyc7VJyk/Sc
 KK85YxnLB55+Nf7j+uUGpD5ZAtKh+N8xHQxJJHrAS6UKrAfDnMEhnJ3+7IPvg+lStVv8
 /AGIL0sWWAiZq1OZYu2c53DSndyKDjPdlNWrWmsxsCU3cL8dBN2uOLFiHqBafcW61fE/
 GvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722616235; x=1723221035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FauIog5avRzm7YUZ5fsTocW4KZAu02y7gZH7TU94rxs=;
 b=FhXp/ADfqrm8N3QuFCzZFPQbOcDDxZIFqbQGHcJ49VVmq1kJE0tYbslu5P4V004/Qb
 gQNGlpp1DOT3INFHC6WvBq0HCmvAL0vC7wv33usqbZSEmrXQD13hJJX6AWSV1Ve5SZZE
 ybmMNzCB12VoMDF4qrWNHtCj7X6FfKA+SToJppfymaekD6bHMmSblhdco/ZQElNOaizW
 +fk4YbtOv1w/27yi0VhSrNJR+MNyoHXUxhOYvKJBfq+LmYBGrxo5Fn8u1SWH8nE9oBnE
 lupDiVl98qNkDjTuVKfzklDfv7WFZRgAlUnzcE5VodxerFWD7k6plM7FuJVKF0tMGoeU
 tbfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFIsMfJv3VbwJI0MnHtnIHGY3R8nmSXy50T/UPEmwh4Jf8ntOO+q6q2Z4PF2abnkTMK71+gYwZ+2n/XUgbIF5WpfzqGCA=
X-Gm-Message-State: AOJu0YxvXM15lIOdLY4qYVUGyuet2fwqmnSQZqHbmtshuJZvylBGEvzY
 31r7xn150zkcT5YMJH88vc8u9G8iON3fz76dtaL5jPXgvmMu1evKtGXR45Sw4Zo=
X-Google-Smtp-Source: AGHT+IE0MOmk4BC+mplTVDTkqZNLhpzCHQlFmLzj4t8LE/b6sQzAgJAPJ2ZEHAsg5Z6MbU2X3ob/GQ==
X-Received: by 2002:a05:600c:138e:b0:424:71f7:77f2 with SMTP id
 5b1f17b1804b1-428e47a0825mr49634255e9.16.1722616235406; 
 Fri, 02 Aug 2024 09:30:35 -0700 (PDT)
Received: from [192.168.69.100] (cvl92-h01-176-184-49-210.dsl.sta.abo.bbox.fr.
 [176.184.49.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428ec84e5c5sm13980025e9.36.2024.08.02.09.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 09:30:34 -0700 (PDT)
Message-ID: <2527dd5b-91b1-4cd4-a330-eeb5fb7ecb25@linaro.org>
Date: Fri, 2 Aug 2024 18:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/19] Reconstruct loongson ipi driver
To: gaosong <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bibo Mao <maobibo@loongson.cn>, QEMU devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20240718133312.10324-1-philmd@linaro.org>
 <c7e11721-812f-4ca5-9115-1ae060b4ff25@app.fastmail.com>
 <7c2c14e9-d6eb-4a8d-bb87-57ec289756d4@linaro.org>
 <1ca32405-41e1-423e-81e3-07e8569911c1@linaro.org>
 <c41baa5b-dc9f-7838-1c23-0a7ad9a9fb8c@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c41baa5b-dc9f-7838-1c23-0a7ad9a9fb8c@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 2/8/24 05:07, gaosong wrote:
> 在 2024/7/23 下午6:19, Philippe Mathieu-Daudé 写道:
>> On 19/7/24 15:04, Philippe Mathieu-Daudé wrote:
>>> On 19/7/24 14:56, Jiaxun Yang wrote:

>>>> For the whole series:
>>>>
>>>> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>> Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>
>>> Yeah!
>>>
>>>> Thanks! Tested on MIPS loongson3-virt with 2, 4 CPUs, all working fine.
>>>>
>>>> I'll get this covered by CI later.
>>>
>>> Thanks,
>>>
>>> I'm queuing this series.
>>
>> Due to pre-existing bug I have to drop this series :(
>>
>> See 
>> https://lore.kernel.org/qemu-devel/492e9968-a05d-44b2-b374-1d839e49b6e3@linaro.org/.
> Hi,  Philippe
> 
> This series is not merged, the bug still exists, if you don't want to 
> merge this series for 9.1, can you fix this bug first?

I haven't forgotten, I tried but I'm still getting a failure when
testing. Since I'm probably too tired to spot the mistake, I'll
post and let someone else help finding it.


