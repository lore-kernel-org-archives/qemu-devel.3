Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2338C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 12:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYP1t-0003x9-8A; Thu, 16 Jan 2025 07:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anasonov@astralinux.ru>)
 id 1tYP1l-0003wa-1L; Thu, 16 Jan 2025 07:31:13 -0500
Received: from mail-gw02.astralinux.ru ([195.16.41.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anasonov@astralinux.ru>)
 id 1tYP1i-0001Dg-QL; Thu, 16 Jan 2025 07:31:12 -0500
Received: from gca-msk-a-srv-ksmg02.astralinux.ru (localhost [127.0.0.1])
 by mail-gw02.astralinux.ru (Postfix) with ESMTP id 48AFA1F707;
 Thu, 16 Jan 2025 15:31:05 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail05.astralinux.ru
 [10.177.185.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
 Thu, 16 Jan 2025 15:31:03 +0300 (MSK)
Received: from [10.198.52.156] (unknown [10.198.52.156])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4YYhzp56n7z1c0sM;
 Thu, 16 Jan 2025 15:31:02 +0300 (MSK)
Message-ID: <90110e6f-55ec-4006-aa3a-22137dab631d@astralinux.ru>
Date: Thu, 16 Jan 2025 15:30:58 +0300
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] hw/ide: replace assert with proper error handling
Content-Language: ru
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com,
 sdl.qemu@linuxtesting.org
References: <20250116111600.2570490-1-anasonov@astralinux.ru>
 <CAFEAcA_S1COmR=_t8Q7mXoEoAwYSbxUNRSvZmp35LiH9JSbtPg@mail.gmail.com>
From: =?UTF-8?B?0JDRgNGC0LXQvCDQndCw0YHQvtC90L7Qsg==?= <anasonov@astralinux.ru>
In-Reply-To: <CAFEAcA_S1COmR=_t8Q7mXoEoAwYSbxUNRSvZmp35LiH9JSbtPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/01/16 11:17:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: anasonov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49
 28b3b64a43732373258a371bd1554adb2caa23cb, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 astralinux.ru:7.1.1; gitlab.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 190372 [Jan 16 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854,
 bases: 2025/01/16 10:48:00 #27040539
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/01/16 11:17:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
Received-SPF: pass client-ip=195.16.41.108;
 envelope-from=anasonov@astralinux.ru; helo=mail-gw02.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

16/01/25 14:32, Peter Maydell пишет:
> On Thu, 16 Jan 2025 at 11:17, Artem Nasonov <anasonov@astralinux.ru> wrote:
>> This assert was found during fuzzing and can be triggered with some qtest commands.
>> So instead of assert failure I suggest to handle this error and abort the command.
>> This patch is required at least to improve fuzzing process and do not spam with this assert.
>> RFC.
>>
>> Found by Linux Verification Center (linuxtesting.org) with libFuzzer.
>>
>> Fixes: ed78352a59 ("ide: Fix incorrect handling of some PRDTs in ide_dma_cb()")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2777
>> Signed-off-by: Artem Nasonov <anasonov@astralinux.ru>
>> ---
>>   hw/ide/core.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index f9baba59e9..baca7121ec 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -931,7 +931,10 @@ static void ide_dma_cb(void *opaque, int ret)
>>       s->io_buffer_size = n * 512;
>>       prep_size = s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size);
>>       /* prepare_buf() must succeed and respect the limit */
>> -    assert(prep_size >= 0 && prep_size <= n * 512);
>> +    if (prep_size < 0 || prep_size > n * 512) {
>> +        ide_dma_error(s);
>> +        return;
>> +    }
> Now the comment and the code disagree (the comment
> says that the callback must never do the thing that we
> now have code to handle).
>
> What's the actual situation when the prepare_buf callback hits
> this assertion? Is the problem in this code, or is it in the
> callback implementation? Which IDEDMAOps is involved?
>
> thanks
> -- PMM

Steps to reproduse are described in related issue:

https://gitlab.com/qemu-project/qemu/-/issues/2777 In this case, 
function ahci_dma_prepare_buf() from hw/ide/ahci.c stands for 
s->bus->dma->ops->prepare_buf. It is called and returns -1. This is 
because of call to ahci_populate_sglist() function, which returns -1 due 
to check if (!prdtl), where prdtl is one of the fields of AHCIDevice cmd 
header. So we have a situation: prepare_buf() must succeed, but returns 
-1 for some reason and application fails (which is harmful for fuzzing 
too). We may solve it in two ways: patch callback or patch caller. I 
don't see any possible way to handle error of populating sglist inside 
ahci_dma_prepare_buf() function: it fails to prepare buf, but has to 
return something. Since then, we should catch this error and interrupt 
operation or maybe other action. Thanks, Artem

