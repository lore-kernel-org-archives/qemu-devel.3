Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F8FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVNM-0006OB-U9; Wed, 08 Jul 2026 12:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1whVN5-0006Mj-7m
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:43:40 -0400
Received: from smtpout9.mo537.mail-out.ovh.net ([51.210.91.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1whVN2-00036d-Ru
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:43:38 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4gwP6r2RjCz3yVN;
 Wed,  8 Jul 2026 16:43:32 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Wed,  8 Jul 2026 16:43:32 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.113.13])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gwP6r1JYKz1xy2; Wed,  8 Jul 2026 16:43:32 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 723971B43D78;
 Wed,  8 Jul 2026 16:43:29 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003ce937b0f-264b-42ef-b741-79778dfd29e4,
 2D223E717D9FA260C3726021AC4FE3AAA9F332FE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <6e33a168-4311-47e8-a153-f364a2c43bf1@kaod.org>
Date: Wed, 8 Jul 2026 18:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/qtest: aspeed_smc: Add Dual Output Read (DOR)
 test coverage
To: Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260708111544.1440761-1-clg@redhat.com>
 <20260708111544.1440761-4-clg@redhat.com>
 <CAEUhbmV0Q2xpwVLUxv9NEDbb8pMgnjdChupPngtPvCuFFedv7A@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CAEUhbmV0Q2xpwVLUxv9NEDbb8pMgnjdChupPngtPvCuFFedv7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9093893550543907885
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGszzCa6Plw9XuHTjPf67GSsxXG9dq6BPqMe7UIwYeG/RzQJ95XUz5jNa6UYUtqQn9bCg4lSCW0g42IYKKfpnZjrC8L53YD3oFzmV+0Yo29SEV6JYXBY8kRz5Y30/L84pJGrRJ7IpoUs1xrU8jRL/nNXPai4ABznUP4uiDv8Dq1KA9KO4rbrAPtJQcX62yxiCJVhR+ragqVmRwpBdhkFjPmPX81ejUrS+jk0fxy/QSmiMzKnBIO52DXvTQZmNNoM8AYUoLYmMjqMhO9hWyVwH9zTSva9ZGyp+NQoISlN60IsApmXsytqW3pqtB0qv3yYmS/i0UAt/GwWQCgVpk45mQGnViLvEEHvQ4SdDd5rGpm8AFkP8ymKJLwRjXlWeGx/ugqGAN8VvWncOnaxkezSTVzewELC8K+BoGkypyhN07lO+7slw/A/jid0ImB7tnDFac5inFGIZgZuJrUIBkZeCtqrkrWldWdmGpsFN3VjKeByueDGE/Fu6HGHggzC7Di5JyT9iaGGk7FS2cc+XNv63VX6S8tXgumon0milGtGpGAFfu3ay7zHddPKRBoCNrJPf938tZ5q+XL5RYYTODc4nqs+g2ZcCmgvlG9v377lrXGX79m7xY8kYvxbhl2MHcO1pk2FU8aXXyyeXxVZaStfGr/4rxAqcw8UOoKKTPHLETEaw
DKIM-Signature: a=rsa-sha256; bh=Ds/KL1fvt346pS+O31IxHHJuz+sSE+PgkxxmxezuTl8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1783529014; v=1;
 b=e8xj9RPX6wRnYHa6RoAurMrkye4li7sQTKbvn9c7h+keurcXId6RGvflEVhaa8H2pfOUbzjo
 ab+wMcPCNMq/XdIsdHYSzjfxipate/tFwvK1OIdVjhWIohBhlz1tywWzemxP9pccv7CB2NU9C2E
 8QWT/nykqpgjvQQAEAvKx4LG3nn+i48bbNCulDllE8N+Mf41GP/KXDH4iCO42gYe+HIGzhBgIXX
 TFYtGtXgK1exM+CZrOoaSiMKNtuczIK0V7gyyq39IW3ek5n/IS9uO7Iyrn7JARfoRVZLpJz4N8k
 GKe+aAwSwEiCcsEz8rqFSHOZ5pQArUHn/29z/i0zFXvcg==
Received-SPF: pass client-ip=51.210.91.28; envelope-from=clg@kaod.org;
 helo=smtpout9.mo537.mail-out.ovh.net
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/8/26 17:32, Bin Meng wrote:
> On Wed, Jul 8, 2026 at 7:17 PM Cédric Le Goater <clg@redhat.com> wrote:
>>
>> Add read_page_mem_dor (CTRL_FREADMODE with DOR command and dual data
>> IO mode) and write_page_dor (user-mode DOR) tests.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/qtest/aspeed-smc-utils.h |  4 +++
>>   tests/qtest/aspeed-smc-utils.c | 50 ++++++++++++++++++++++++++++++++++
>>   tests/qtest/aspeed_smc-test.c  | 16 +++++++++++
>>   tests/qtest/ast2700-smc-test.c |  4 +++
>>   4 files changed, 74 insertions(+)
>>
>> diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.h
>> index 5a86514caf35..fbfb94e831d8 100644
>> --- a/tests/qtest/aspeed-smc-utils.h
>> +++ b/tests/qtest/aspeed-smc-utils.h
>> @@ -44,6 +44,7 @@
>>   #define   CTRL_FREADMODE       0x1
>>   #define   CTRL_WRITEMODE       0x2
>>   #define   CTRL_USERMODE        0x3
>> +#define   CTRL_IO_DUAL_DATA     BIT(29)
> 
> This macro is already defined in aspeed-smc-utils.h:43

I am confused. I only see this CTRL_IO_DUAL_DATA define in
hw/ssi/aspeed_smc.c.

Thanks,

C.


