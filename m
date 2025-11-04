Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDE1CCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 09:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGDjw-0005U6-KB; Tue, 04 Nov 2025 04:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGDjr-0005Ts-D0
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:54:07 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGDjp-0002nU-8O
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:54:07 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5743380BD4;
 Tue, 04 Nov 2025 12:54:01 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:95c::1:2] (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0sg6Bd1Gn4Y0-NxejjWJN; Tue, 04 Nov 2025 12:54:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762250040;
 bh=i6DCu66pd8ajDKSJCec0oo+NuCIZV6MjG/tVZpBOKO8=;
 h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
 b=m4zXFHzYjc83XkwZfv+n5PQbAJ7Ku/grX042HKw1hK+XFYIjMyil9gIHprFq3q0D2
 ogz+v05ZQlZkKbhGmU8WKJP+LzJVEkFNgw1aE9ufCut50oK7Xur/AaqeoE1cEuoV+G
 WDxxunErF96ajU5F7Or8GBT2uKTBeHJr1czYlO9c=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <041080b6-28b7-4a3e-868a-a25459470e3d@yandex-team.ru>
Date: Tue, 4 Nov 2025 12:54:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/8] Accelerators & CPU patches for 2025-11-02
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251102181406.51160-1-philmd@linaro.org>
 <6aabcdbb-acdd-4b3a-8652-b9c1cf3ce435@linaro.org>
 <4e836608-dc06-41ea-8be0-eb34232b8b60@linaro.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <4e836608-dc06-41ea-8be0-eb34232b8b60@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 03.11.25 16:19, Philippe Mathieu-Daudé wrote:
> On 3/11/25 10:20, Richard Henderson wrote:
>> On 11/2/25 19:14, Philippe Mathieu-Daudé wrote:
>>> Vladimir Sementsov-Ogievskiy (2):
>>>    util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
>>>    tests/unit: add unit test for qemu_hexdump()
>>
>> This doesn't build:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/11947161300
>> https://gitlab.com/qemu-project/qemu/-/jobs/11947161195
>>
>> and 10 other variations.
> 
> Nice. Apologies for missing that.

Oops, my fault.

> 
> Vladimir, please repost (only) the test:
> https://lore.kernel.org/qemu-devel/20251031211518.38503-9-philmd@linaro.org/


Hmmm. But how to correctly fix it?

As I understand, the problem is that

   util_ss.add(files('hexdump.c'))

comes inside

   if have_block

block, so it miss targets without block subsystem?

Would it be more correct, to just move `util_ss.add(files('hexdump.c'))`
out of the block, so it compile always, like many other "utils"?
Actually, qemu_hexdump() itself is unrelated to block..

-- 
Best regards,
Vladimir

