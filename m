Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BA9E65293
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 15:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmZ4U-0003Ab-Am; Sun, 01 Feb 2026 10:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vmZ4S-00039U-3A
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 10:09:04 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vmZ4P-0004vo-09
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 10:09:03 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C894A8070E;
 Sun, 01 Feb 2026 18:08:53 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:765::1:3b] (unknown
 [2a02:6bf:8080:765::1:3b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id q8obHU6A9W20-XFgKIduu; Sun, 01 Feb 2026 18:08:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769958533;
 bh=49B4uXJFELYsbPCPHjDf5VI22S7uyyq/wP3pe0Vene4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BQw5MaaU0Hz0XI9MUa+YTCyFH4XQvZE8SZu1E19g/DnbNWxq/GyCgYnxrVCiKpcTd
 bEfWatTzTXAl5RqPxADAVorO5d5ZQm7OyxpItB7HlJMkhHwxUcG3m2LOVC8Lut3NF5
 VvoFrkX9kroOWhC3j6pNIRJQF6J2XobKmifiGu70=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7e7f0f77-d18d-44c8-b523-3853b6644fe3@yandex-team.ru>
Date: Sun, 1 Feb 2026 18:08:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi/net: deprecate TAP fd and vhostfd options
To: Peter Krempa <pkrempa@redhat.com>
Cc: jasowang@redhat.com, pierrick.bouvier@linaro.org, eblake@redhat.com,
 armbru@redhat.com, devel@lists.libvirt.org, qemu-devel@nongnu.org
References: <20260129215338.1422004-1-vsementsov@yandex-team.ru>
 <aXyZrBIb77Gh_s7X@angien.pipo.sk>
 <97eb0bac-03a3-4edf-b3a6-2aa517ca0aac@yandex-team.ru>
 <aXy9cWMhM1uWCkyO@angien.pipo.sk>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aXy9cWMhM1uWCkyO@angien.pipo.sk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 30.01.26 17:17, Peter Krempa wrote:
> On Fri, Jan 30, 2026 at 15:23:37 +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 30.01.26 14:44, Peter Krempa wrote:
>>> On Fri, Jan 30, 2026 at 00:53:38 +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> They are the same as fds and vhostfds, except they accept only
>>>> one fd. Let's deprecate redundant options.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>
>>>> Hi all!
>>>>
>>>> after "[PATCH v2 00/12] net: refactoring and fixes" options fd
>>>> and vhostfd becomes redundant, fds and vhostfds may be used instead.
>>>>
>>>> this patch also based on
>>>> "[PATCH v6] qapi: net: deprecate vhostforce option", that's why
>>>> it's sent separately.
>>>>
>>>> Based-on: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
>>>> Based-on: <20251113071711.349651-1-vsementsov@yandex-team.ru>
>>>>
>>>>    docs/about/deprecated.rst | 6 ++++++
>>>>    qapi/net.json             | 9 +++++----
>>>>    2 files changed, 11 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>>>> index e8ff478583..9010f8ab07 100644
>>>> --- a/docs/about/deprecated.rst
>>>> +++ b/docs/about/deprecated.rst
>>>> @@ -451,6 +451,12 @@ TAP ``vhostforce`` (since 11.0)
>>>>    The ``vhostforce`` option is redundant with the ``vhost`` option.
>>>>    If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.
>>>> +TAP ``fd`` and ``vhostfd`` (since 11.0)
>>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> +
>>>> +Use ``fds`` and ``vhostfds`` correspondingly, each set with one fd
>>>> +instead of ``fd`` and ``vhsotfd``.
>>>
>>> Does this replacement apply/work on all versions supporting vhostfds/fd?
>>>
>>> I'm asking because libvirt does have code to format the singlular vs
>>> plural but none of the versions we support are lacking support for the
>>> plural forms so we could replace this unconditionally if it works with
>>> older versions.
>>>
>>
>> Unfortunately, before "[PATCH v2 00/12] net: refactoring and fixes",
>> some things will not work, if use fds/vhostfds instead of fd/vhostfd
>> for one-queue TAP. Still, probably these cases are not used in Libvirt?
> 
> In that case any caveats should IMO be documented in the deprecation
> document.

Will add.

> 
>> for one-queue TAP. Still, probably these cases are not used in Libvirt?
> 
> Note that the network stuff in libvirt isn't my specialization so I
> might be missing stuff that was not metioned explicitly.
> 
>> 1. Prior the series, tap.c code has check:
>>
>>      /* QEMU hubs do not support multiqueue tap, in this case peer is set.
>>       * For -netdev, peer is always NULL. */
>>      if (peer && (tap->has_queues || tap->fds || tap->vhostfds)) {
>>          error_setg(errp, "Multiqueue tap cannot be used with hubs");
>>          return -1;
>>      }
> 
> So if that comment is accurate we only use fd/vhostfd with -netdev so
> this won't trigger in libvirt.
> 
> 
>> This is too restrictive: obviously queues may be set to 1, and fds/vhostfds
>> may contain only one FD, but QEMU doesn't check it.
>>
>> So, this case require fd/vhostfd options, if you want to pass some fds.
>>
>> What this "hub" actually is? As I can see, it's -net cmdline option except for nic:
>>
>> static int net_client_init1(const Netdev *netdev, bool is_netdev, Error **errp)
>> {
>>      ...
>>          /* Do not add to a hub if it's a nic with a netdev= parameter. */
>>          if (netdev->type != NET_CLIENT_DRIVER_NIC ||
>>              !netdev->u.nic.netdev) {
>>              peer = net_hub_add_port(0, NULL, NULL);
>>          }
>>      ...
>> }
>>
>>
>>
>> 2. Prior the series, you may pass vhostfds only together with fds. If you want
>> to pass vhostfd for cases without fds, you have to use only vhostfd option.
> 
> So in the test data we seem to be using vhostfd only with fd (or the
> crresponding plural form) but I'm not 100% sure based on the fact that
> the formatters for the option are conditional on whether the FDs were
> opened first.
> 
> The code opening the FDs seems to open 'vhostfd' only when 'fd' are
> populated.
> 
> So if the above is the case (as in 'vhostfd' is used only with 'fd', or
> the correspondign plural) then libvirt should be able to use this
> unconditionally, right?
> 

Yes, if I didn't miss something. I'll double check.

> 
>> Even for the case when you pass queues > 0, you can't provide vhostfds but only
>> vhostfd (and QEMU will try to reuse it for all queues, which (as I understand)
>> is a bug in current QEMU.
> 
> Okay I'm not sure how this works and if it has implications on libvirt.
> 
> Specifically we don't seem to be ever passing 'queues' to -netdev in
> conjunction with fd/vhostfd or the correspondive plurals.

That's correct fd=, fds= and queues= are mutual exclusive. Still, vhostfd
may be used withuot fd.. But that's rather strange.

> Specifically
> 'queues' are only used with 'vhost-user' and 'vhost-vdpa' types, where
> fd/vhostfd or the plurals are not used.
> 
> If the above is safe to use only with 1 fd used in the plural options then
> libvirt should be safe.
> 
> Regardless of that if 'queues' *can* be used with this config but has
> such implications as you claim it IMO should be documented too in the
> deprecation document.
> 

Agree, I'll add the necessary documentation

-- 
Best regards,
Vladimir

