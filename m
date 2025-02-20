Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE62C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 10:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl3Uy-0005rc-3P; Thu, 20 Feb 2025 05:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl3Uw-0005r6-HK
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:09:38 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl3Ut-0002Jt-MM
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:09:38 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-439a4fc2d65so4293395e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 02:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740046174; x=1740650974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hAjSZUUyU29KVGVzun9YGNpepIdHWY4Z/VoDRliVovg=;
 b=lvK2fb5hHyQQMbQiSQ0vAJkFWueA4IYdp2LbHaNwVsPFb+aC1/uUSYPzEjRawsj6e8
 hkXtNHnENNcmG761Lik7e/Ejs+iOq+pPyPDvRoJ1li1b6JiUSSzxfCVCSK/AsYR3hVlo
 4QTstYwYNVAJwoGeKe/pPeZE0wKyYnW7WZ8RGusQA26YBhTpytPe4HHjbNWhlpfs2QJe
 C8wF6Dy7iXvwJ1HjTId0sqrMfBszz8+QTD4YWuSqjYcw0HLzbfaz8pFY6q7TWIm/FX+h
 dd4qj8wF7M9TlAiKlZnr+xUedKwo5e5lrgwWk9ZoxdEXZL0tQBYV3g3RgkA9oMyaevIC
 iT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740046174; x=1740650974;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hAjSZUUyU29KVGVzun9YGNpepIdHWY4Z/VoDRliVovg=;
 b=ntRdZ5PDBz1vXok1x4oWnOZKkw7NU56B6+Z8yf6HZx1fGDfqvyzNZnj1eXexb0p0Sq
 5XBfSuecf242IyYBXzueKYwa0J7Y/qZm/RWBGlaoeiKXqV6d+S3+XzapJ6Exvp/sj8zx
 /ty8LWyGB49IDdptYAG+lydP0MWxts47kGAoTw/e01MBO7cmITQHI2XoaII3S9udf4Js
 r2r1MxA5CrbxLRxhE3vETal4/emdilH/hYid6FRulGmd0Dxc963ukwOGPKbl1hFeKnG7
 ro8fxSo773LOBbBoRc655GSbC4S4IvsmJc4t9gMMY4UUFvps+8pmHitOJS81oP3bilaL
 PImA==
X-Gm-Message-State: AOJu0YymIQ2yms9Zq4CeMThXf6GJbfIjfYGbNDdViCILagziXOBpm8iD
 uZlvBZYbUkYjRqu82pRUl7rLyD1roJOnZO0ftkffNHI+dPPgabJ2AlVVPR0BtXXmxQpHXDLI5x3
 1Cd0=
X-Gm-Gg: ASbGnctLoLR4qS1tf9uemm3rpN+kZ+S1QSbsww72tODC8CFjAAItXL8JoEtLkS2HWTB
 P+HUZMAOsWk2y9ZAKTTIsqmgfoK2kt6DQ/9dVQgqGHyEo/q2nr5QkI0Mw2ZAxAnayqjK8HiUNUf
 w784wR0NfFJ59Fb4u0nkP2Sb99jwv6GMPgi4/hzXEHyht1an5CqnGiZi0Twrd+2ULYUkV9o8lWF
 xYSrlclDGoQd/0yoFHzs3YBiVl7YYwWzlvTVylq4fkM6FjeqmCSAbMBDtZLmDhmI1a2rgCedQpb
 JhRVLuDWnK7kGovUIshY2ApYSqgDXkKve1BdnUPWrpZSI6CPvT5GpZ1JKns=
X-Google-Smtp-Source: AGHT+IGCBxy6iz5Bzb5eyppUKGTnbVqXTzKHAOPWImAhgjvBKxjSKR2TZY+DIDRiC18wwVqyJi+cmQ==
X-Received: by 2002:a05:600d:8:b0:439:86c4:a8ec with SMTP id
 5b1f17b1804b1-43986c4ac03mr158799955e9.15.1740046173978; 
 Thu, 20 Feb 2025 02:09:33 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa779sm236248915e9.30.2025.02.20.02.09.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 02:09:33 -0800 (PST)
Message-ID: <e4b98b6a-db8b-4406-8471-44f93a1ca90f@linaro.org>
Date: Thu, 20 Feb 2025 11:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Qemu-devel] [PATCH v2 00/11] chardev: Convert IO handlers to use
 unsigned type
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20181012002217.2864-1-philmd@redhat.com>
 <20181012082011.GS16720@redhat.com>
 <9f92521c-419d-498f-813c-083f3728617f@linaro.org>
Content-Language: en-US
In-Reply-To: <9f92521c-419d-498f-813c-083f3728617f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 20/2/25 11:07, Philippe Mathieu-Daudé wrote:
> On 12/10/18 10:20, Daniel P. Berrangé wrote:
>> On Fri, Oct 12, 2018 at 02:22:06AM +0200, Philippe Mathieu-Daudé wrote:
>>> Hi Paolo,
>>>
>>> Here are the changes you suggested in
>>> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02294.html
> 
> 
>>>    chardev: Simplify IOWatchPoll::fd_can_read as a GSourceFunc
>>>    chardev: Assert backend's chr_can_read() is positive
>>>    chardev: Let chr_sync_read() use unsigned type
>>>    chardev: Let chr_write use unsigned type
>>>    chardev: Let IOReadHandler use unsigned type
>>>    chardev: Let IOCanReadHandler use unsigned type
>>>    chardev: Let qemu_chr_fe_* use unsigned type
>>>    chardev: Let qemu_chr_be_* use unsigned type
>>>    chardev: FDChardev::max_size be unsigned
>>
>> s/unsigned/size_t/ in all these commit messages, as it looked
>> like you meant 'unsigned int' with the current commit msg.
> 
> Sure.
> 
> Paolo, any blocking comment before I fix the bitrotten places?

Doh, I just noticed your comments in the last patch:
https://lore.kernel.org/qemu-devel/786ca1d4-f874-e643-b85a-20652f1c84d8@redhat.com/


