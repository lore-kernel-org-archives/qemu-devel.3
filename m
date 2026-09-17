Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A663C982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Bql-0002SP-5g; Thu, 17 Sep 2026 09:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7BpR-00024x-IC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:07:12 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7BpN-0006Wi-0f
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:07:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:86a0:0:640:75de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 1CCE08128B;
 Thu, 17 Sep 2026 16:06:54 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c2c::1:1a] (unknown
 [2a02:6bf:8080:c2c::1:1a])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id q6WUJ00b5a60-msfJCsXW; Thu, 17 Sep 2026 16:06:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789650413;
 bh=5VZ+urfwUg5tom92zJlDiSrJp5nNClHIpxii94gF8lg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Fpec02FVdPORhcPx3onIgpHKbxWPKQoQH1oq+Yb2WBkRdiEsvrWIpwfxQM8zbWe+K
 PeY3FX7gGkKpiiTg7kZoQ9FfH61Q8j8bSO0e5wwh76bFpOkRhfN9PfvptJ5RV7VXxW
 qYHHDaN6Ol9Uo2np2rx9lqnMk8iweQ8+KCsA4gMs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <77262e37-0466-466d-b7ac-f69306f2478e@yandex-team.ru>
Date: Thu, 17 Sep 2026 16:06:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] migration/cpr: support vhost-vsock devices
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de,
 den@openvz.org, clg@redhat.com, sgarzare@redhat.com,
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, mst@redhat.com,
 dongli.zhang@oracle.com, peterx@redhat.com
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
 <3e3ba3a6-1437-4b36-b1d6-8434c1005499@yandex-team.ru>
 <ed87c09d-f750-4ea1-abad-2777792564a8@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ed87c09d-f750-4ea1-abad-2777792564a8@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
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

On 17.09.26 15:32, Andrey Drobyshev wrote:
> On 9/17/26 9:03 AM, Vladimir Sementsov-Ogievskiy wrote:
>> On 15.09.26 23:59, Andrey Drobyshev wrote:
>>> v5 -> v6:
>>>
>>>     * Patch 9:
>>>       - use the device path (qdev_get_dev_path(), i.e. the device's
>>>         address on the bus) + "vhost-vsock" suffix as the CPR key instead
>>>         of the device ID;
>>>       - drop the device ID requirement altogether;
>>>       - introduce 'cpr_incoming' local here rather than in patch 14.
>>>
>>>     * Patch 14:
>>>       - lift the CPR blocker entirely instead of keeping it for ID-less
>>>         devices;
>>>       - skip RESET_OWNER in .pre_save() if the ownership was already
>>>         released by a previous failed CPR attempt;
>>>       - reword commit message.
>>>
>>> v5: https://lore.kernel.org/qemu-devel/20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com
>>>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>> Andrey Drobyshev (14):
>>>         migration/cpr: forbid saving duplicate CprFds into hash table
>>>         tests/unit: add test for duplicate keys in CPR FD table
>>>         migration: forbid snapshots in CPR migration modes
>>>         tests/qtest/migration: add test for snapshot rejection in CPR modes
>>>         vhost-vsock: block CPR migration modes
>>>         vhost: add vhost_reset_owner op
>>>         vhost-vsock: don't reset connections during CPR
>>>         vhost-vsock: fix FD leak in realize()
>>>         vhost-vsock: preserve vhost FD during CPR
>>>         vhost: factor out vhost_dev_init_backend()
>>>         vhost: make vhost_dev_cleanup() safe on a partially initialized device
>>>         vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>>>         vhost: add vhost_dev_is_initialized() helper
>>>         vhost-vsock: hand off device ownership across CPR
>>>
>>>    backends/hostmem-memfd.c          |   5 +-
>>>    backends/hostmem-shm.c            |   5 +-
>>>    backends/iommufd.c                |   4 +-
>>>    hw/vfio/container-legacy.c        |  17 ++--
>>>    hw/vfio/cpr-legacy.c              |  10 +-
>>>    hw/vfio/cpr.c                     |   6 +-
>>>    hw/vfio/pci.c                     |   5 +-
>>>    hw/virtio/vhost-kernel.c          |   6 ++
>>>    hw/virtio/vhost-vsock.c           | 193 +++++++++++++++++++++++++++++++++++---
>>>    hw/virtio/vhost.c                 |  57 ++++++++---
>>>    include/hw/vfio/vfio-cpr.h        |   6 +-
>>>    include/hw/virtio/vhost-backend.h |   2 +
>>>    include/hw/virtio/vhost-vsock.h   |   1 +
>>>    include/hw/virtio/vhost.h         |  61 ++++++++++++
>>>    include/migration/cpr.h           |   2 +-
>>>    migration/cpr.c                   |  55 +++++++----
>>>    migration/options.c               |   7 ++
>>>    system/physmem.c                  |   5 +-
>>>    tests/qtest/migration/cpr-tests.c |  36 ++++++-
>>>    tests/unit/meson.build            |   1 +
>>>    tests/unit/test-cpr.c             |  98 +++++++++++++++++++
>>>    21 files changed, 512 insertions(+), 70 deletions(-)
>>> ---
>>> base-commit: 5f664cd37aec17e8145aa117d8da68f507edc8f1
>>> change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a
>>>
>>> Best regards,
>>> --
>>> Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>
>> Hi! Don't you add a test for new functionality?
> Hi Vladimir,
> 
> You're right, there's no dedicated tests yet.  Basically there're 2
> levels of testing:
> 
> 1) Launch QEMU without a guest, with the device in question, and perform
> a CPR.  Here we just test that QEMU survives the CPR op, i.e. that FD
> and device handling is fine from the QEMU side.
> 
> 2) Actual test would be launching QEMU with a real guest, launch
> host<->guest data transfer and perform CPR during that.  That's what
> I've been testing when preparing this series.
> 
> As for the guest, AFAICT there're some functional tests which launch
> Fedora.  So this part should be doable.

If you want, look at my [PATCH 1/5] tests/functional: add test_tap_migration

https://lore.kernel.org/qemu-devel/20260914175351.393680-2-vsementsov@yandex-team.ru/

it does local migration with live guest.

>  However one requirement for
> both tests to work is the host kernel having RESET_OWNER support -
> that's added by our recent kernel series, which isn't yet merged to
> kernel master as of now.  So whichever Linux distro you run on your host
> now - it doesn't have this support and is not going to work.
> 
> I'm not sure it makes sense adding a test which nobody else'd be able to
> run unless they build their own kernel.  What do you think?
> 

But one day it (RESET_OWNER) will be merged, I assume? Would be good to
have a test at the moment.

I don't insist. My (self-serving) idea is that if I have a test, it would
be easier to experiment and try to bring a "local migration" interface
here (like in the recently merged TAP series) :). Of course, not merged
RESET_OWNER make such experiments less possible just now..

For you, the test is the only thing that protects your code from being
broken by other changes. Even if you're the only one running this test,
when it breaks, you can bisect the breaking commit and say,
"Hey, you've broken the existing test with this commit.". Without the
test — you have no guarantee and no weapon.

-- 
Best regards,
Vladimir

