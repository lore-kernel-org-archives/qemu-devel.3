Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C6CCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUoHn-0000Ta-1t; Wed, 03 Jun 2026 12:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wUoHk-0000TP-JB
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:17:40 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wUoHh-00011i-PR
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:17:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0B8F2C01FF;
 Wed, 03 Jun 2026 19:17:31 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:76a::1:36] (unknown
 [2a02:6bf:8080:76a::1:36])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id THjeMw2Zca60-ldPW3hcI; Wed, 03 Jun 2026 19:17:30 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1780503450;
 bh=fXxcyg3AJJKs0sDUcACSq5gyxV8JlDbtQEriFOYnK4Q=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=1kyLhF5AkRJBYCSnVXkTJqoYNDh90QsztfM/lnuMXCnX5+AhcZOslP74iTXJL7E8q
 Hxjy/IN4PrvUqv06S9kqvagkc+kbB4eMHBZ6u2pM+2XEkWQOT439FoWXiTFl31khfr
 7NMkLLD9Ta0x/xBHIGUa/3yiZZpbCyIhlh8scxMk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c9bfe3c9-6ed6-4f65-a6ba-f3ee2fa2da1e@yandex-team.ru>
Date: Wed, 3 Jun 2026 19:17:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/10] virtio-net: live-TAP local migration
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, jasowang@redhat.com,
 mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru
References: <20260527191150.250333-1-vsementsov@yandex-team.ru>
 <78b9e565-1853-4aee-8eb5-b28c4b650037@nutanix.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <78b9e565-1853-4aee-8eb5-b28c4b650037@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 03.06.26 18:24, Mark Cave-Ayland wrote:
>> Open terminal A, and run:
>>
>>      $QEMU \
>>          -name source \
>>          -machine q35 \
>>          -accel kvm \
>>          -m 1G \
>>          -object memory-backend-file,id=ram0,size=1G,mem-path=/dev/shm/qemu_migration_test,share=on \
>>          -machine memory-backend=ram0 \
>>          -drive file=/tmp/alpine.iso,media=cdrom,format=raw \
>>          -device pcie-pci-bridge,id=pci.1,bus=pcie.0 \
>>          -netdev tap,id=netdev.1,ifname=tap0,queues=4,vnet_hdr=on,script=no,downscript=no,local-migration-supported=on \
> 
> Looks like local-migration-supported is no longer required?

Yes in new Machine Type. So, specifying -machine q35, with current (actually not yet finished/published 11.1) qemu make local-migration-supperted to be true by default.

If you specify older machine tipe, like -machine pc-q35-11.0, local-migration-supported will be false by default.

-- 
Best regards,
Vladimir

