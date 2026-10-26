Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD29606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 18:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLPNp-0004J9-0u; Mon, 26 Oct 2026 14:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xLPNm-0004FG-JR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 14:25:18 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xLPNk-0006Np-C2
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 14:25:18 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xLPNP-00000007LVn-1qHN; Mon, 26 Oct 2026 19:24:55 +0100
Message-ID: <05d6cf1f-7e20-4ee6-838d-1e455720df76@maciej.szmigiero.name>
Date: Mon, 26 Oct 2026 19:24:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/22] migration/cpr: support vhost-vsock devices
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com,
 mst@redhat.com, sgarzare@redhat.com, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org,
 dongli.zhang@oracle.com, farosas@suse.de, peterx@redhat.com,
 dwmw2@infradead.org, philmd@oss.qualcomm.com
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
 <35dd9653-bde5-42d8-bcc6-20b692010eb1@virtuozzo.com>
 <e5fbac0c-b4d0-4e8f-8865-23791057c570@virtuozzo.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <e5fbac0c-b4d0-4e8f-8865-23791057c570@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26.10.2026 08:58, Andrey Drobyshev wrote:
> On 10/20/26 1:55 PM, Andrey Drobyshev wrote:
>> On 10/12/26 1:28 PM, Andrey Drobyshev wrote:
>>> v15 -> v16:
>>>
>>>    * Patch 15:
>>>      - replace the errno filtering in vhost_dev_try_release_owner() with
>>>        a new 'owner_handed_over' flag in struct vhost_dev.  Release the
>>>        ownership only if it was handed over to us, and report any failure;
>>>
>>>    * Patch 19:
>>>      - set 'owner_handed_over' in .post_load() on the CPR target;
>>>      - drop the redundant 'owner_reset' flag, use vhost_dev.owner instead;
>>>      - drop Stefano's R-b because of that.
>>>
>>> v15: https://lore.kernel.org/qemu-devel/20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com
>>>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>> Andrey Drobyshev (22):
>>>        migration/cpr: forbid saving duplicate CprFds into hash table
>>>        tests/unit: add test for duplicate keys in CPR FD table
>>>        migration: forbid snapshots in CPR migration modes
>>>        migration: forbid snapshots under Xen
>>>        tests/qtest/migration: add test for snapshot rejection in CPR modes
>>>        vhost-vsock: block CPR migration modes
>>>        vhost: add vhost_reset_owner op
>>>        vhost-vsock: don't reset connections during CPR
>>>        vhost-vsock: fix FD leak in realize()
>>>        vhost-vsock: preserve vhost FD during CPR
>>>        vhost: factor out vhost_dev_init_backend()
>>>        vhost: make vhost_dev_cleanup() safe on a partially initialized device
>>>        vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>>>        vhost: add vhost_dev_is_initialized() helper
>>>        vhost: release ownership in vhost_dev_cleanup()
>>>        migration: add MIG_EVENT_INCOMING_FAILED
>>>        vhost: release ownership when the incoming migration fails
>>>        vhost: release ownership on exit
>>>        vhost-vsock: hand off device ownership across CPR
>>>        tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
>>>        tests/functional: add vhost-vsock CPR test with a live guest
>>>        tests/functional: cover a cpr-transfer target going away with vhost-vsock
>>>
>>>   backends/hostmem-memfd.c                        |   5 +-
>>>   backends/hostmem-shm.c                          |   5 +-
>>>   backends/iommufd.c                              |   4 +-
>>>   hw/vfio/container-legacy.c                      |   7 +-
>>>   hw/vfio/cpr-legacy.c                            |  29 +-
>>>   hw/vfio/cpr.c                                   |   6 +-
>>>   hw/vfio/pci.c                                   |   5 +-
>>>   hw/virtio/vhost-kernel.c                        |   6 +
>>>   hw/virtio/vhost-vsock.c                         | 193 ++++++++++++-
>>>   hw/virtio/vhost.c                               | 136 +++++++++-
>>>   include/hw/vfio/vfio-cpr.h                      |   7 +-
>>>   include/hw/virtio/vhost-backend.h               |   2 +
>>>   include/hw/virtio/vhost.h                       |  80 ++++++
>>>   include/migration/cpr.h                         |   2 +-
>>>   include/migration/misc.h                        |   5 +
>>>   migration/cpr.c                                 |  64 +++--
>>>   migration/migration.c                           |  10 +
>>>   migration/options.c                             |  13 +
>>>   system/physmem.c                                |   5 +-
>>>   tests/functional/x86_64/meson.build             |   2 +
>>>   tests/functional/x86_64/test_vhost_vsock_cpr.py | 347 ++++++++++++++++++++++++
>>>   tests/qtest/migration/cpr-tests.c               | 133 ++++++++-
>>>   tests/unit/meson.build                          |   1 +
>>>   tests/unit/test-cpr.c                           |  98 +++++++
>>>   24 files changed, 1084 insertions(+), 81 deletions(-)
>>> ---
>>> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
>>> change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a
>>>
>>> Best regards,
>>> --
>>> Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>
>>
>> Friendly ping
> 
> Ping

I wrote at v3 that I am fine with these patches CPR-wise,
so if/once vsock maintainers are okay with them too it's
only a question of which tree this should get into: vhost,
migration or CPR?

Thanks,
Maciej


