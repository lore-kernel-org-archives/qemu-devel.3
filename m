Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C89CE6BF06
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnXR-0004Tn-Rf; Fri, 30 Jan 2026 07:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlnXN-0004Ta-Sn
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:23:45 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlnXL-0003Ti-BD
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:23:45 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B5C3F80762;
 Fri, 30 Jan 2026 15:23:38 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:37::1:8] (unknown [2a02:6bf:8080:37::1:8])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id bNjQY06Ap0U0-hqEz1eA9; 
 Fri, 30 Jan 2026 15:23:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769775818;
 bh=oabX0SKGce24Tz+k1tpr4wdumhEh/UYjmRfkP4Zp2jQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BTq0c7JFRTyyJ02PdotGBVH8Aa7UgDmxXPAZ4IvPIpFCP8jOoXxf0TsbMd9/5+QD8
 joqlZnuhqK1vSGFIaCAzwxVdEo9X4LE+q+DIDiyMJjxp/ZCgeIZOwutDepLgBZ5URu
 sWhHhCymkWjBl3No6GDWH6WOdp7ndFpnPFzi9S4E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <97eb0bac-03a3-4edf-b3a6-2aa517ca0aac@yandex-team.ru>
Date: Fri, 30 Jan 2026 15:23:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi/net: deprecate TAP fd and vhostfd options
To: Peter Krempa <pkrempa@redhat.com>
Cc: jasowang@redhat.com, pierrick.bouvier@linaro.org, eblake@redhat.com,
 armbru@redhat.com, devel@lists.libvirt.org, qemu-devel@nongnu.org
References: <20260129215338.1422004-1-vsementsov@yandex-team.ru>
 <aXyZrBIb77Gh_s7X@angien.pipo.sk>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aXyZrBIb77Gh_s7X@angien.pipo.sk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30.01.26 14:44, Peter Krempa wrote:
> On Fri, Jan 30, 2026 at 00:53:38 +0300, Vladimir Sementsov-Ogievskiy wrote:
>> They are the same as fds and vhostfds, except they accept only
>> one fd. Let's deprecate redundant options.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>
>> Hi all!
>>
>> after "[PATCH v2 00/12] net: refactoring and fixes" options fd
>> and vhostfd becomes redundant, fds and vhostfds may be used instead.
>>
>> this patch also based on
>> "[PATCH v6] qapi: net: deprecate vhostforce option", that's why
>> it's sent separately.
>>
>> Based-on: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
>> Based-on: <20251113071711.349651-1-vsementsov@yandex-team.ru>
>>
>>   docs/about/deprecated.rst | 6 ++++++
>>   qapi/net.json             | 9 +++++----
>>   2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index e8ff478583..9010f8ab07 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -451,6 +451,12 @@ TAP ``vhostforce`` (since 11.0)
>>   The ``vhostforce`` option is redundant with the ``vhost`` option.
>>   If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.
>>   
>> +TAP ``fd`` and ``vhostfd`` (since 11.0)
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +Use ``fds`` and ``vhostfds`` correspondingly, each set with one fd
>> +instead of ``fd`` and ``vhsotfd``.
> 
> Does this replacement apply/work on all versions supporting vhostfds/fd?
> 
> I'm asking because libvirt does have code to format the singlular vs
> plural but none of the versions we support are lacking support for the
> plural forms so we could replace this unconditionally if it works with
> older versions.
> 

Unfortunately, before "[PATCH v2 00/12] net: refactoring and fixes",
some things will not work, if use fds/vhostfds instead of fd/vhostfd
for one-queue TAP. Still, probably these cases are not used in Libvirt?

1. Prior the series, tap.c code has check:

     /* QEMU hubs do not support multiqueue tap, in this case peer is set.
      * For -netdev, peer is always NULL. */
     if (peer && (tap->has_queues || tap->fds || tap->vhostfds)) {
         error_setg(errp, "Multiqueue tap cannot be used with hubs");
         return -1;
     }

This is too restrictive: obviously queues may be set to 1, and fds/vhostfds
may contain only one FD, but QEMU doesn't check it.

So, this case require fd/vhostfd options, if you want to pass some fds.

What this "hub" actually is? As I can see, it's -net cmdline option except for nic:

static int net_client_init1(const Netdev *netdev, bool is_netdev, Error **errp)
{
     ...
         /* Do not add to a hub if it's a nic with a netdev= parameter. */
         if (netdev->type != NET_CLIENT_DRIVER_NIC ||
             !netdev->u.nic.netdev) {
             peer = net_hub_add_port(0, NULL, NULL);
         }
     ...
}



2. Prior the series, you may pass vhostfds only together with fds. If you want
to pass vhostfd for cases without fds, you have to use only vhostfd option.
Even for the case when you pass queues > 0, you can't provide vhostfds but only
vhostfd (and QEMU will try to reuse it for all queues, which (as I understand)
is a bug in current QEMU.

-- 
Best regards,
Vladimir

