Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF5BC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 23:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC61a-0007Ez-Pv; Tue, 28 May 2024 19:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sC61Z-0007Ek-Rx; Tue, 28 May 2024 19:14:33 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sC61W-0000eb-Jq; Tue, 28 May 2024 19:14:33 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f47784a2adso10550605ad.1; 
 Tue, 28 May 2024 16:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716938069; x=1717542869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rgDRUApwjHELlJBi3de/ejRg84WPG/VZw+fQVa7YjoY=;
 b=iCwhgm7Ud+WA2bi62+dG70W+VS4JQjqD3QdIbXPJ9UJlG0jX8+XuntAqInRWO+u5/d
 U+3c5kNBvjRHgSvCcLk1wWw8xCrQcCdKJye+eXIC6q7N8WrT34EUYuy1KQ9IhsNyRUx7
 eJ8gWDs6CE006RjOqs2Zgna5dJhrv8kBrGq8jIe3oh/ijLgwq5zzprUYnPqQFRsFeVf4
 2bQyS+CMvKlXDYF4mCRFZY3ILpwSIDBacKzoCBU7bH3V0iQIbJuIuGKvYftI5+++kSFD
 g+5QAARnyQNVwS0pZNpDSLMrgdkQ7rPgmX4FD8KTPTe/C/yzhTj+WOMR2ods1c8r8RZT
 L3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716938069; x=1717542869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rgDRUApwjHELlJBi3de/ejRg84WPG/VZw+fQVa7YjoY=;
 b=sOLoAlxeUWjuG5ynFhsiTdsgBSp1tLSC38+wZhZChah/4zcCMZtpe5hC4GzeUQ35bU
 bN/weriWF3nhdSv6HCNK8ScwZXy5sQib4E5bPn5MRXmRmR1OXeW2GfhtejuST4OGqfSB
 Qa+nSrp578xzTxNCVh/jeHVnrMNv5xkXc8SzmFkiCkUjymA5+vVNCC8zkXUWaZv7YTcZ
 FxdX8iykXXYd80MW8r1eBYsYJOkyQqPDLjVXN8gxY3G/DE1WgxkjKExVjNmHMyUNdmdP
 fMIW1U/GjNwOM7BPFEG9SFIEjBv0aKyEY4S1ui/zPsszJergl86RUE9AtME2+QORtu+k
 dAww==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/I23jKbz7XyV8EV25xL6ehGPkIEBCMKczEAkMjU4eO19FBZDDddvsmCf25guhc2jZVBOCvMW4YtTFCA/SRXIAEg+Ua/ViInoc1o/SGZLFJNLkiDbrkvB4S/p/rg==
X-Gm-Message-State: AOJu0YziKZauFKYHNzMcFFwJ3e9+nQslvkdT4RdEHvvqPgOEHuiL7YTz
 BakRTsJFaTAeLmStimgaqraGQIPKmRw9msciJ9/4Kg6r1+GRgqnP
X-Google-Smtp-Source: AGHT+IHIGO+yqYbL5qD1Mas7pqBiI46htZGFVuGmxYKpfuABpYXd1ZXk9he3JzfHwyTOv9lkS64hsQ==
X-Received: by 2002:a17:902:e5cb:b0:1f4:71c5:c78 with SMTP id
 d9443c01a7336-1f471c50fbfmr94591975ad.39.1716938068799; 
 Tue, 28 May 2024 16:14:28 -0700 (PDT)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f471f127c2sm66271925ad.13.2024.05.28.16.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 16:14:28 -0700 (PDT)
Message-ID: <b6231f60-db8a-4dc0-a5db-b1d608059e6e@gmail.com>
Date: Wed, 29 May 2024 08:14:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/2] hw/ufs: Add support MCQ of UFSHCI 4.0
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, minwoo.im@samsung.com
References: <cover.1716876237.git.jeuk20.kim@samsung.com>
 <71a82d3f0555e65c98df129ce0e38b2aa5681ec0.1716876237.git.jeuk20.kim@samsung.com>
 <19857a64-0f57-4f7c-877e-c4d0e884c4f1@linaro.org>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <19857a64-0f57-4f7c-877e-c4d0e884c4f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 5/29/2024 2:06 AM, Richard Henderson wrote:
> On 5/27/24 23:12, Jeuk Kim wrote:
>> From: Minwoo Im <minwoo.im@samsung.com>
>>
>> This patch adds support for MCQ defined in UFSHCI 4.0.  This patch
>> utilized the legacy I/O codes as much as possible to support MCQ.
>>
>> MCQ operation & runtime register is placed at 0x1000 offset of UFSHCI
>> register statically with no spare space among four registers (48B):
>>
>>     UfsMcqSqReg, UfsMcqSqIntReg, UfsMcqCqReg, UfsMcqCqIntReg
>>
>> The maxinum number of queue is 32 as per spec, and the default
>> MAC(Multiple Active Commands) are 32 in the device.
>>
>> Example:
>>     -device ufs,serial=foo,id=ufs0,mcq=true,mcq-maxq=8
>>
>> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
>> Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> Message-Id: <20240528023106.856777-3-minwoo.im@samsung.com>
>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> ---
>>   hw/ufs/trace-events |  17 ++
>>   hw/ufs/ufs.c        | 475 ++++++++++++++++++++++++++++++++++++++++++--
>>   hw/ufs/ufs.h        |  98 ++++++++-
>>   include/block/ufs.h |  23 ++-
>>   4 files changed, 593 insertions(+), 20 deletions(-)
>
> Fails build:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/6960270722
>
> In file included from trace/trace-hw_ufs.c:5:
> ../hw/ufs/trace-events:28:24: error: format specifies type 'unsigned 
> char' but the argument has type 'uint32_t' (aka 'unsigned int') 
> [-Werror,-Wformat]
>                      , cqid, addr);
>                        ^~~~
> ../hw/ufs/trace-events:25:112: error: format specifies type 'unsigned 
> char' but the argument has type 'uint32_t' (aka 'unsigned int') 
> [-Werror,-Wformat]
>             qemu_log("ufs_err_dma_write_cq " "failed to write cq 
> entry. cqid %"PRIu8", hwaddr %"PRIu64"" "\n", cqid, addr);
> ~~~~~~~                      ^~~~
> 2 errors generated.
>
>
>
> r~


Sorry about that.

I'll fix it and send it back to you.


