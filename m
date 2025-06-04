Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B34C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 07:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMiuD-0002pZ-Kq; Wed, 04 Jun 2025 03:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uMiu8-0002p0-G6
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:51:20 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uMiu6-0002nM-4l
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:51:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:420d:0:640:5081:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7CC9D60BE0;
 Wed,  4 Jun 2025 10:51:12 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:f813:3ac:d945:b70e] (unknown
 [2a02:6bf:803e:400:f813:3ac:d945:b70e])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ApWjZu4FciE0-cwRTXaow; Wed, 04 Jun 2025 10:51:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1749023472;
 bh=/Ef8/SMrTZelPVxLLlq2WPVSVYor6k1frhTwXnLLz8s=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=CZSOAGdrCRNPq9eAdbS6lr/ZiXiRqMKz6C9+wQDc1slX3xzYqODYFd12jO+ojWpDc
 +DOZ98ndQA6irSC/uKTVj3qS+OJSgXoIn1opbe8YctGQT/+bKGgmkS2rknOa+QZfwm
 TgQlfJyqmnEITMaDUX2MigTZrZht/ketbfjiTgyg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fa5f0538-9c66-46f1-b65d-d723d2006716@yandex-team.ru>
Date: Wed, 4 Jun 2025 12:51:10 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/27] Functional tests, Microblaze endianness & pc/q35
 cleanups
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
References: <20250528100507.313906-1-thuth@redhat.com>
 <CAJSP0QUpxsVEMEDT8opTZrhs6oFfFJk+jUqdR-dZL=TzQcYbWg@mail.gmail.com>
 <34256440-efd5-4395-8eab-49ca5bbe0377@redhat.com>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <34256440-efd5-4395-8eab-49ca5bbe0377@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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


On 5/29/25 01:12, Thomas Huth wrote:
> On 28/05/2025 21.23, Stefan Hajnoczi wrote:
>> On Wed, May 28, 2025 at 6:12 AM Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>   Hi!
>>>
>>> The following changes since commit 
>>> 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e:
>>>
>>>    Merge tag 'pull-aspeed-20250526' of 
>>> https://github.com/legoater/qemu into staging (2025-05-26 10:16:59 
>>> -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2025-05-28
>>>
>>> for you to fetch changes up to 
>>> 9c2da02e184fddfa7cd7d7813455c2306daae99a:
>>>
>>>    tests/unit/test-util-sockets: fix mem-leak on error object 
>>> (2025-05-28 11:59:47 +0200)
>>>
>>> ----------------------------------------------------------------
>>> * Functional tests improvements
>>> * Endianness improvements/clean-ups for the Microblaze machines
>>> * Remove obsolete -2.4 and -2.5 i440fx and q35 machine types and 
>>> related code
>>>
>>> ----------------------------------------------------------------
>>> Alexandr Moshkov (2):
>>>        tests/functional: add skipLockedMemoryTest decorator
>>>        tests/functional: add memlock tests
>>
>> Hi Thomas and Alexandr,
>> The memlock tests are failing:
>> https://gitlab.com/qemu-project/qemu/-/jobs/10181084830#L5421
>> https://gitlab.com/qemu-project/qemu/-/jobs/10181084865#L5476
>>
>> Please take a look and send a new pull request. Thanks!
>
Hello! I think Stefan forgot to CC me in his reply. Only now find this 
message)


> According to the log:
>
>  Output: qemu-system-aarch64: No machine specified, and there is no 
> default
>
> I think it likely does not make sense to run this test with the 
> aarch64 target... Alexandr, would it make sense to limit this to x86 
> only?

It looks like adding this lines to vm creation fixes all problems with 
other targets on memlock test:

self.set_machine('none')
self.vm.add_args('-nodefaults')

What's the convenient way to fix it? Resend a new patch?


Best regards,

Alexandr


