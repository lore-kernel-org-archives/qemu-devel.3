Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BC1E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 17:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vslOO-00022J-9z; Wed, 18 Feb 2026 12:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vslOE-00021I-7G
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:31:10 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vslOB-0007z6-AZ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:31:05 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C98F280873;
 Wed, 18 Feb 2026 20:30:58 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:53d::1:1b] (unknown
 [2a02:6bf:8080:53d::1:1b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vUeO6N3AsiE0-j303DMfW; Wed, 18 Feb 2026 20:30:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771435858;
 bh=6ZhKGnHAzpXlZ/8c7RBb4iqC2clBF4HooI4gkREKp5I=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=r/wlz3Cm8Z9xh4vT+wT73yoBJTefcVOjCvq1sIp4Yzd2PwICEhxakOft8bUpkeVFb
 bhVPiS3iHAdBj9dWtB9ppeqTOwXJrfIGnNl+MUz/+URI7ucb0mOhxJ/YYaAzv2C7Nz
 3yjcTVjA8zQDvXT1du/1fCRyP4JZV2sNvfycv7PM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2cde883c-3ed8-449c-8e4d-5d31bb62e3bd@yandex-team.ru>
Date: Wed, 18 Feb 2026 20:30:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] qapi: net: deprecate vhostforce option
To: Jason Wang <jasowang@redhat.com>
Cc: devel@lists.libvirt.org, eblake@redhat.com, armbru@redhat.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20251113071711.349651-1-vsementsov@yandex-team.ru>
 <CACGkMEv=UYKjc5jZRSQCzgzCe6Bdz8OGMHYA5F-5OkRVrRom9g@mail.gmail.com>
 <a8a29f4e-ebc2-40ed-ad2d-4573a007d994@yandex-team.ru>
 <CACGkMEvkV_mc8AsykSn1J_2RUG8Q2NwAucGZf6eE0eM6nnbLiw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEvkV_mc8AsykSn1J_2RUG8Q2NwAucGZf6eE0eM6nnbLiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 30.01.26 04:55, Jason Wang wrote:
> On Fri, Jan 30, 2026 at 5:21 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> On 14.11.25 04:34, Jason Wang wrote:
>>> On Thu, Nov 13, 2025 at 3:17 PM Vladimir Sementsov-Ogievskiy
>>> <vsementsov@yandex-team.ru> wrote:
>>>>
>>>> This option for tap and vhost-user netdevs doesn't make sense
>>>> since long ago (10 years!), starting from commits:
>>>>
>>>>    1e7398a140f7a6 ("vhost: enable vhost without without MSI-X")
>>>>    24f938a682d934 ("vhost user:support vhost user nic for non msi guests")
>>>>
>>>> Prior these commits, to enable kernel vhost-net, or vhost-user-net for
>>>> some specific kind of guests (that don't have MSI-X support), you should
>>>> have set vhostforce=on.
>>>>
>>>> Now guest type doesn't matter, all guests are equal for these
>>>> options logic.
>>>>
>>>> For tap the current logic is:
>>>>     vhost=on / vhost=off : vhostforce ignored, doesn't make sense
>>>>     vhost unset : vhostforce counts, enabling vhost
>>>>
>>>> So you may enable vhost for tap several ways:
>>>> - vhost=on
>>>> - vhostforce=on
>>>> - vhost=on + vhostforce=on
>>>> - and even vhost=on + vhostforce=off
>>>>
>>>> - they are all equal.
>>>>
>>>> For vhost-user we simply ignore the vhostforce option at all in the
>>>> code.
>>>>
>>>> Let's finally deprecate the extra options.
>>>>
>>>> Also, fix @vhostforce documentation everywhere to show the real picture,
>>>> and update vhost-user test to not use deprecated option.
>>>>
>>>> While updating command line options, drop "experimental" word from
>>>> "experimental in kernel accelerator". vhost-net is in production for
>>>> years.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>
>>>> v6: - update numbers 10.2 -> 11.0
>>>>       - add r-b by Markus
>>>
>>> I've queued this for 11.0.
>>>
>>> Thanks.
>>>
>>
>> Hi! Isn't this forgotten? You've recently pulled some my commits, but this one is still not in master..
> 
> Apologize, this falls through the cracks.
> 
> Thanks
> 

Ping)


-- 
Best regards,
Vladimir

