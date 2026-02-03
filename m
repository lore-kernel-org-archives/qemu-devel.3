Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1C7E83072
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 09:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDA1-0001tR-Vw; Tue, 03 Feb 2026 04:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnD9z-0001t3-Os
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 04:57:27 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnD9x-0003Vt-9B
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 04:57:27 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id F171982854;
 Tue, 03 Feb 2026 12:57:17 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:435::1:2c] (unknown
 [2a02:6bf:8080:435::1:2c])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Gvk9pL0A5Cg0-huu4LyE8; Tue, 03 Feb 2026 12:57:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770112637;
 bh=b8W3U4qJ2bjvfQ3kXVpmgJ62HO7cvXHuWAhpp1jenyA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=vcnMgIWeswTQeiZnRN5eQms9J95pvKwAusaY4ozSTzxKolvLeT8C2SxzIC2CEAJXm
 K7b2tt08C2ltJNf3S8oqoPAGPYeXCDCHFnm1+zSYiMfGqPBnqIRc5sMEAymwshlsJh
 w/DPdYSss3HDuxkYcgTaY3suE7W7ws/WPjs8q/IE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <38db7222-bf35-43d4-9ab9-52810c9727e9@yandex-team.ru>
Date: Tue, 3 Feb 2026 12:57:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Live update: tap and vhost
To: "Chaney, Ben" <bchaney@akamai.com>, Peter Xu <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Tottenham, Max" <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
 <4b4e5317-9bbe-45c3-8c10-41cc448c5d22@yandex-team.ru>
 <aYCvexnciB7THTkr@x1.local> <8EFA386D-E593-4CC9-908D-75CFD74A53A5@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <8EFA386D-E593-4CC9-908D-75CFD74A53A5@akamai.com>
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

On 02.02.26 18:42, Chaney, Ben wrote:
> 
> 
> ﻿On 2/2/26, 9:07 AM, "Peter Xu" <peterx@redhat.com <mailto:peterx@redhat.com>> wrote:
> 
>>> The latest version was
>>>
>>> [PATCH v9 0/8] virtio-net: live-TAP local migration
>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20251030203116.870742-1-vsementsov@yandex-team.ru <mailto:20251030203116.870742-1-vsementsov@yandex-team.ru>/__;!!GjvTz_vk!T9a83fcFgNhv7DgAAfFINb-FE6knVp53t5c7XkCrY76jAhmGxZz42YqHIlPt-eV_hh7V-OksMeBMsw$
>>>
>>> and I plan to post v10 soon.
> 
> 
>> Yes, thanks for re-raising this. If we have similar features being
>> proposed, we should always discuss whether we should stick with one of them
>> if that'll work for all.
> 
> 
>> IIUC Vladimir's solution looks indeed superior in that it has less
>> constraints, and also works for CPR mode.
> 
> 
> This was previously discussed here: https://lore.kernel.org/all/ef7fd47a-f7c0-4bca-823c-07005c5f1959@yandex-team.ru/
> 
> My impression from that discussion is that
> 
> 1. Vladimir's solution has some extra complexity
> 2. We are trying to standardize cpr as the primary method for local migration,

I believe, that we may do local migration of devices with FDs natively,
through one migration channel, without CPR.

In my opinion, CPR breaks migration architecture, creating additional
state, which owns mixed pieces of different devices (and sometimes,
not only FDs, I heard).

Instead we can keep device state all in device state description,
including FDs if needed.

Also, second migration channel, and the fact that on target we can't
access QMP until we say "migrate" on source seems to me an unnecessary
load on the user and management software, we can avoid this.

Next, as I understand, the only point, why we use CPR for devices, is
avoiding rework of initialization code of some devices, which wants to
have FDs at early stage. But that approach can't be applied
everywhere. An example is vhost-user-blk: you have to rework
initialization code anyway, as if you simple pass FDs to the target in
CPR state, when source is still running, target will simple break the
source, touching the FDs. And, if we can't touch FDs until source stop
- it's actually a usual migration, and we can pass FDs through main
migration channel, doing necessary things in pre-save and post-load,
as usual.

Hmm, looking at patch 01 here, I understand, that virtio-net/TAP does
suffer from same problem? That we actually must not use passed FDs on
target, when source is still running? But stopping source earlier
means increase freeze-time. I think, if we can avoid it (and we can)
we should avoid it.

> so the benefit of supporting non-cpr local transfers is slightly double edged
> 

So, I think, if we plan that there would be more and more devices,
supporting FDs local migration, and we have any change of fitting them
into the "old" migration architecture (without CPR), we should try it.

--

Hm, I don't have a full picture of CPR, it's not only device migration,
but also some other things? Interesting, how much feasible is to move
all these things into main migration channel. That's the question I
can't answer now. But even if keep CPR for some non-device things, it
seems still good to keep the whole state description for a device in
one place - in device code, like it was historically.

-- 
Best regards,
Vladimir

