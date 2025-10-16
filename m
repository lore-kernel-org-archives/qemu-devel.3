Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7B2CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 10:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9LPF-0001SC-Ev; Thu, 16 Oct 2025 06:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9LPB-0001Rj-O7
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 06:40:21 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9LP2-0002ps-QH
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 06:40:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E0956C00BE;
 Thu, 16 Oct 2025 13:40:05 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8c::1:19] (unknown
 [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4eOKxD2FtmI0-bI7KGKCO; Thu, 16 Oct 2025 13:40:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760611205;
 bh=FQUIRy3M6ZgH3ratdVXGEurS9hX0sP6RCmqzdYjwPG4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QzLPTqBeu9WB9wbOv1nEGfSqF7y1WPcVmu08Ji/BlN5sTecJueMgozffUZXtc/j/V
 WwQMkjuH7mx6/Sz6hhzHvNgJMblRqdOU1DoXypI2e4q2eht4DwLPFMDf1t2L7Rhya4
 /8BensQUA0/PhHwlKZYrpdpH9ZB9zlt9OmFLAul4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4ab377cb-4820-439e-a425-44e7f3fe0c61@yandex-team.ru>
Date: Thu, 16 Oct 2025 13:40:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] qapi: net: deprecate vhostforce option
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, devel@lists.libvirt.org, eblake@redhat.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20251015143941.1109499-1-vsementsov@yandex-team.ru>
 <87bjm7teou.fsf@pond.sub.org>
 <239dc7b4-de5a-4e47-912d-543347d1f90b@yandex-team.ru>
 <87frbjrv0s.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87frbjrv0s.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 16.10.25 13:38, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 16.10.25 11:48, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
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
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 
>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>> index 0223ceffeb..35a70096e8 100644
>>>> --- a/qemu-options.hx
>>>> +++ b/qemu-options.hx
>>>> @@ -2882,7 +2882,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>>>   #else
>>>>       "-netdev tap,id=str[,fd=h][,fds=x:y:...:z][,ifname=name][,script=file][,downscript=dfile]\n"
>>>>       "         [,br=bridge][,helper=helper][,sndbuf=nbytes][,vnet_hdr=on|off][,vhost=on|off]\n"
>>>> -    "         [,vhostfd=h][,vhostfds=x:y:...:z][,vhostforce=on|off][,queues=n]\n"
>>>> +    "         [,vhostfd=h][,vhostfds=x:y:...:z][,queues=n]\n"
>>>>       "         [,poll-us=n]\n"
>>>>       "                configure a host TAP network backend with ID 'str'\n"
>>>>       "                connected to a bridge (default=" DEFAULT_BRIDGE_INTERFACE ")\n"
>>>> @@ -2898,9 +2898,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>>>       "                default is disabled 'sndbuf=0' to enable flow control set 'sndbuf=1048576')\n"
>>>>       "                use vnet_hdr=off to avoid enabling the IFF_VNET_HDR tap flag\n"
>>>>       "                use vnet_hdr=on to make the lack of IFF_VNET_HDR support an error condition\n"
>>>> -    "                use vhost=on to enable experimental in kernel accelerator\n"
>>>> -    "                    (only has effect for virtio guests which use MSIX)\n"
>>>> -    "                use vhostforce=on to force vhost on for non-MSIX virtio guests\n"
>>>> +    "                use vhost=on to enable in kernel accelerator\n"
>>>
>>> So the kernel's accelerator is no longer experimental?
>>
>> Reading this, I heard the first time that vhost-net is experimental.
>> It's about 15 years old, and used in production. I think "experimental"
>> is inappropriate word here)
> 
> Just double-checking :)
> 
> The text you adjust is from 2010 (commit 82b0d80ef6a).  I guess the
> accelerator was experimental back then.
> 
> Mention the correction in the commit message?
> 

Will do


-- 
Best regards,
Vladimir

