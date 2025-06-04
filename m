Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DC5C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 07:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMiKb-0000fe-GO; Wed, 04 Jun 2025 03:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMiKa-0000fB-6L
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:14:36 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMiKY-0006vv-Bg
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:14:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-442f4a3a4d6so3295215e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 00:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749021272; x=1749626072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CTIFqwF+UP0AKnxn/I+DiFu7z16Af8pLsvyzHwnUy0w=;
 b=GFr0tVCW/1d0Z5mNYGd7WUzUzWYe5LtWJrbb7S3BAk/qm0iurj50Hud5S+gstno6EB
 Gj+b0gP3gR1DIDcu//JeN2paMnzK3+yzapuILD5TAfR0ouqRjvgLk2S1oT7YuqC7SE0l
 lHnJGcSzSjIdRv8rIKDM0kfAnsFQrTxjrbj/BVCAL9sHshbO/1hVVTTN6ElatV1YSMxj
 qRVv2QTF1KI4VeZD9FXAYEPK54bUFxTnKcZySEKiq5HRI81Bq+AQG7ZM879i+JqOaeHx
 o/C+/CCnXvMIJdKDJrx8iTDQ61coIWLqMfVs2R5eu/GbqoX+YN+bSql/KnLehf/V50jF
 8DpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749021272; x=1749626072;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CTIFqwF+UP0AKnxn/I+DiFu7z16Af8pLsvyzHwnUy0w=;
 b=qC0yQL8kOJtsUKMpI9QXMpyphQbPI33/khHpwGCoLFZm2/+9uWViNxug4+GSRMrLnc
 Rc24+JANueY1w5EoLPk+tDHdKnQwE82pJP8nS4Xax+IYxlPWaZDv4OFW4h36+V4hyrM6
 7gX1Wy95VYkMf7RX4UNbJ5uMH21HkVupkiglVbTHI20476G1C31l33f3ZW3vfaioZ/+h
 ddRRppUELVMLgpw83WQG+FuqwCL7sgwgu2hbAMNtJtGa8G7Qs4Rq+MVGuHGZoWC4gEk2
 aPOO6AJ4Rs6fkaB8OUpadj0Slhcwxam9B6TI4kZX+BMW0kEXd7P9FP1BZ6KbMW4aAuda
 4dAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpbV3odBEqTZGuP+YYaCCGo5vZNMiYjKjzYA+Ekbtz76E+zf7WRUzaoytx0CL5JE+jmO3HKyHjOEjU@nongnu.org
X-Gm-Message-State: AOJu0YxkFxe8/CqP7gKQS7r2Hhvd+Nde7SN6lPzQ+KJPM0j06JR9SN60
 2Sd85vgi+S3de8+yLTb+EB7ugZTWEZP4MW5MFW5V6n3g7cWkHDhXSs0NXbJ96tJeUI0=
X-Gm-Gg: ASbGncvgcssyP4tmACu7gu4nzqqY7CDcY3Qigh3K/kMFuex9ftZzCUaUuITLw1nbRMH
 BilUyEohzVHJjeUMMcjG+5lvluTpy40ZP7+4vjUU31np2J4iMyrsm5p8SPD1Vsoe/MdLl81FdPI
 KaVcStQcoPl6MChudvhex4L7GJe/abvFMaBu0RI4vCUSozl1rB0msOR2gUIWYUQKsUtT3uUYw0k
 yJXvWEHbBH+QjVghuHxnVF+7bPuvKuyAOszEKkf6OoK53Rl+1kAPuFhjMpzR0qO67rpriT+72p4
 15Q/gJKtE3Ko7BbmZzjYY4yeT1sXQNYarASmR7XHX/DZnyngTnC2Bu6u+oduXpB6vydMROA9OML
 R0yUodxf63AJPPpTo0PU=
X-Google-Smtp-Source: AGHT+IEtFgOFdJvX+4A67k/A4pPfHVUO8qMOfijlRBCNGqfnzF/+6NHSu8iGaoiMhD7D3nGwCPsOew==
X-Received: by 2002:a05:600c:8b04:b0:450:cabc:a6c6 with SMTP id
 5b1f17b1804b1-451efed6307mr14016215e9.15.1749021271677; 
 Wed, 04 Jun 2025 00:14:31 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451e505d40csm40440785e9.0.2025.06.04.00.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 00:14:30 -0700 (PDT)
Message-ID: <6a1d2339-5656-4b65-aae3-6db2cab29e79@linaro.org>
Date: Wed, 4 Jun 2025 09:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] hw/i386/pc: Remove deprecated 2.10, 2.11 and 2.12 PC
 machines
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250501223522.99772-1-philmd@linaro.org>
 <4ac8c8b0-700b-4fac-ae4c-6531fc6b682e@intel.com>
 <0c0545dc-6ce1-4580-9d21-6f31d39e0125@linaro.org>
Content-Language: en-US
In-Reply-To: <0c0545dc-6ce1-4580-9d21-6f31d39e0125@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 4/6/25 09:07, Philippe Mathieu-Daudé wrote:
> On 4/6/25 03:30, Xiaoyao Li wrote:
>> On 5/2/2025 6:35 AM, Philippe Mathieu-Daudé wrote:
>>> The versioned 'pc' and 'q35' machines up to 2.12 been marked
>>> as deprecated two releases ago, and are older than 6 years,
>>> so according to our support policy we can remove them.
>>>
>>> This series includes the 2.10 to 2.12 machines removal.
>>
>> For this series,
>>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> Thanks!
> 
>> Besides, please add more patches to remove hw_compat_2_{10,11,12}
> 
> Are you asking for this series which was posted more than one month ago?
> https://lore.kernel.org/qemu-devel/20250501230129.2596-1-philmd@linaro.org/

Actually looking for it (sorry, this was quite some time now) I realized
I did the work up to removing 4.0:

$ git log x86_deprec
commit acc32b99be93105267805d08b6803ce85d4fb997
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Tue Apr 29 17:52:38 2025 +0200

     hw/i386/pc: Remove pc_compat_4_0[] array

     The pc_compat_4_0[] array was only used by the pc-q35-4.0,
     pc-q35-4.0.1 and pc-i440fx-4.0 machines, which got removed.
     Remove it.

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

commit 659443241b5bf8266af8a2a3f2bde249564498af
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Tue Apr 29 17:51:09 2025 +0200

     hw/i386/pc: Remove deprecated pc-q35-4.0[.1] and pc-i440fx-4.0 machines

     These machines has been supported for a period of more than 6 years.
     According to our versioned machine support policy (see commit
     ce80c4fa6ff "docs: document special exception for machine type
     deprecation & removal") they can now be removed.

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

commit d21784220e5d251bc2cfe588a04e3842cde3d8f9
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Tue Apr 29 16:55:39 2025 +0200

     hw/i386/pc: Remove pc_compat_3_1[] array

     The pc_compat_3_1[] array was only used by the pc-q35-3.1
     and pc-i440fx-3.1 machines, which got removed. Remove it.

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

...

At some point I had too many series waiting for review so I stopped 
posting (otherwise having to constantly rebase / repost drains too
much energy on both author and reviewers). I might post them once
the prerequisites are all merged.

Regards,

Phil.


