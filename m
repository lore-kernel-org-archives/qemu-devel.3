Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12367CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUtdR-0001Cg-JP; Wed, 03 Jun 2026 18:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wUtdL-0001C3-SC
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 18:00:21 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wUtdJ-0005IZ-2O
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 18:00:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E916E807C1;
 Thu, 04 Jun 2026 01:00:11 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:76a::1:36] (unknown
 [2a02:6bf:8080:76a::1:36])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id A0pQls2aOOs0-LJaBpq0d; Thu, 04 Jun 2026 01:00:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1780524011;
 bh=0Zx3vz+66aoaXSwv6ZFfinu9orTRwrIqScNaGHm2IfE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=IA+KHdHgi9bydR9JJIOYvlFRiw7fuC7AFvfoywMnk43/5gtsLTFPpgwZ1VigvSJ4T
 LEGq2Iz0wgzV06whn/hHMaFhvwOAOXPDmvbZIIlKMZ/Ig6OMZWaE0zPzqMW59MyLk4
 IizRsP6l5aBHYPUUdGBdA8UHY9K/jeoIHjJeuPZo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <21a05595-0266-4755-8a99-29a85b9da2db@yandex-team.ru>
Date: Thu, 4 Jun 2026 01:00:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <ah_4hixGcNv-CLfv@redhat.com> <aiBNXUU0xcT_UbKO@x1.local>
 <aiBhTTqSctU9lFsS@redhat.com> <87o6hr7brx.fsf@suse.de>
 <aiBrp1UJZjmC1aI1@redhat.com> <aiB2nA5bmtBRWras@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aiB2nA5bmtBRWras@x1.local>
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

On 03.06.26 21:46, Peter Xu wrote:
>> My general feeling wrt changes to the current command line is that
>> any suggestion should be desgined with a nod towards a future scenario
>> where QEMU is 100% configured with QMP. ie the full command line is
>>
>>     qemu-system-x86_64 -qmp <address>
>>

[..]

> 
> Requirements like this (allow migration parameters to be accessible during
> early stage of QEMU) is going towards the other direction of the that idea.
> That means even if we put all configs (caps/params) into QMP command
> migrate[-incoming], libvirt will still need to manage these global setup
> and making sure when invoking migrate[-incoming] QMP commands they match
> with the globals.  Say, if one start QEMU with -incomingconfig:local=on
> but then invoke "migrate-incoming,local=off" it's illegal.

Right.. And this show, that moving "local" from migrate-set-parameters to
commandline is not a clear solution for the whole problem.

We don't need cmdline argument. We need two things:

1. "local" must be set before initializing tap-device.

It not actually requires it being a cmdline parameter. Calling
migrate-set-parameters before netdev_add is also OK.

So, moving to cmdline solves this [1] point, but may be too restrictive.


2. "local" must not be changed after initializing tap-device.

And this one is not guaranteed anyway, with cmdline or with QMP.

---


So, in my series, if drop "incoming-fds" and rely on "local" instead, we
actually want "local" be immutable after first read in tap initialization
code.

Maybe, just implement this feature? So, in code it will look like:

set_migration_parameters(...) {

...

if "local" value is changing and "local" is immutable:
    fail

...

}


tap_initializaion(...) {

...

local = migrate_get_local_and_make_it_immutable(err_text="you can not change 'local' parameter value after TAP device initialization");

...


}

---

For user it should provide simple error messages

    "you can not change 'local' parameter value after TAP device initialization".

if user tries to change local when it's not allowed.


-- 
Best regards,
Vladimir

