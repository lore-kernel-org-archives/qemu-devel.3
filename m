Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B13CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN8i-0005jv-T3; Wed, 07 Oct 2026 04:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xEI5Q-0001M8-GL
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:12:56 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@yandex-team.ru>) id 1xEI57-0001NV-Bg
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:12:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:b81a:0:640:473f:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 7668280F5B;
 Tue, 06 Oct 2026 13:01:22 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:55a::1:27] (unknown
 [2a02:6bf:8080:55a::1:27])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id L1J12I0XYa60-EUeFhZ58; Tue, 06 Oct 2026 13:01:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1791280881;
 bh=NxuYy7wrOpxNIGE5NrsabHK631ofgeA6+ov0e1QAGfI=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=PFfQ06fp385957nkT777Bdjb5i8qWp8Y4DuOaza3m5U31nR7Zxc6HRXCiK/hehKm7
 0F0QkuRVWMLZbd8/JjB7TyTQ7LFIJ17X7YoxDZg/3tlpTxYg6y/oL4v80JlAi3M9ml
 GC2rA/IzxkiSnkN2QSASVMFPR0QgI1pqshUDAFT4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <76177f9f-a67f-412e-a38d-d1110b95320d@yandex-team.ru>
Date: Tue, 6 Oct 2026 13:01:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] virtio-net: live-TAP local migration follow-up
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, Jason Wang <jasowangio@gmail.com>
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, peterx@redhat.com,
 farosas@suse.de, qemu-devel@nongnu.org
References: <20260914175351.393680-1-vsementsov@yandex-team.ru>
 <603c0809-d21d-4a00-abdb-2d2f63e208e3@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <603c0809-d21d-4a00-abdb-2d2f63e208e3@yandex-team.ru>
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

ping

On 16.09.26 09:15, Vladimir Sementsov-Ogievskiy wrote:
> [add new Jason's address]
> 
> On 14.09.26 20:53, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> Here is a test (with some fixes and changes, so r-b dropped),
>> and several small fixes to recently merged live-TAP local migration
>> series.
>>
>> Vladimir Sementsov-Ogievskiy (5):
>>    tests/functional: add test_tap_migration
>>    net/tap: tap_post_load(): poll only on success
>>    hw/net: finish backend initialization earler for local migration
>>    net/tap: move vmstate initialization to new_tap()
>>    net/tap: net_init_tap_one(): fix failure path
>>
>>   hw/net/virtio-net.c                           |  40 +-
>>   net/tap.c                                     |  11 +-
>>   tests/functional/x86_64/meson.build           |   1 +
>>   tests/functional/x86_64/test_tap_migration.py | 425 ++++++++++++++++++
>>   4 files changed, 448 insertions(+), 29 deletions(-)
>>   create mode 100755 tests/functional/x86_64/test_tap_migration.py
>>
> 
> 


-- 
Best regards,
Vladimir

