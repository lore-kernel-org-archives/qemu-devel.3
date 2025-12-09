Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5602D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 07:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSs8p-0005Gp-Hd; Tue, 09 Dec 2025 02:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vSs8f-0005GK-37
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:28:03 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vSs8c-0006Jk-HJ
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:28:00 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id F30A8C0241;
 Tue, 09 Dec 2025 10:27:51 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:839::1:b] (unknown [2a02:6bf:8080:839::1:b])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oRHQ8D0FbqM0-d8xXW3U0; Tue, 09 Dec 2025 10:27:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1765265271;
 bh=aCeqTa66nOysG76U9auuxBNtpvrLSCEFj7AhgZcr/Zk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=L4yAgVu/+HlRv2uuPhGRa7yV1KRF63O9M6uuXzZ6rkgQrcWXYYTUvoVWpREyt/2K+
 TiXITp019IQVT/k4kclPD4cgjW/NPTAzDUbdDrCEkQEE/7dYAaPOHuinD5mGb6btHw
 sgXZJZRMwOPRofsk3eVZ3Asu5/ykFSgT3J0wn4mE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <67fc037c-ed99-472d-94d5-cd4f9b24ac58@yandex-team.ru>
Date: Tue, 9 Dec 2025 10:27:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Live update: tap and vhost
To: "Chaney, Ben" <bchaney@akamai.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Tottenham, Max" <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
 <a782e506-8e23-49dd-b8d2-d27409c99d5a@yandex-team.ru>
 <3CF77061-D885-46E8-90F0-AF3A909C233E@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <3CF77061-D885-46E8-90F0-AF3A909C233E@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 09.12.25 00:03, Chaney, Ben wrote:
> 
> 
> ﻿On 12/4/25, 7:53 AM, "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
>> [PATCH v9 0/8] virtio-net: live-TAP local migration
>> https://urldefense.com/v3/__https://patchew.org/QEMU/20251030203116.870742-1-vsementsov@yandex-team.ru <mailto:20251030203116.870742-1-vsementsov@yandex-team.ru>/__;!!GjvTz_vk!Wv8g8JpZGOl96S-RX_T81d0fwPei5C-fKhKAUqM5DJmec3xKhFaStiinE3IFLyUwrs1UQrdQgth3VU1HRlblRjjmVA$
> 
> 
>> , which bring same thing: migrate TAP device, passing FDs
>> though migration channel. The benefit is that it doesn't
>> require additional migration channel.
> 
> Hi Vladimir,
>          Thanks for sending this. I tried testing your patch
> set and I got the following errors from qemu
> 
> 2025-12-08T20:44:31.251153Z qemu-system-x86_64: 8 != 101
> 2025-12-08T20:44:31.251199Z qemu-system-x86_64: Failed to load element of type uint16 equal for max_queue_pairs: -22
> 2025-12-08T20:44:31.251492Z qemu-system-x86_64: warning: qemu_fclose: received fd 141 was never claimed
> 2025-12-08T20:44:31.251497Z qemu-system-x86_64: warning: qemu_fclose: received fd 142 was never claimed
> 2025-12-08T20:44:31.251501Z qemu-system-x86_64: warning: qemu_fclose: received fd 143 was never claimed
> 2025-12-08T20:44:31.251524Z qemu-system-x86_64: load of migration failed: Invalid argument: error while loading state for instance 0x0 of device '0000:00:03.0/virtio-net': Failed to load element of type virtio for virtio: -22
> 

Thanks for testing!

Hmm. Migration errors was never friendly enough, to understand, what's going wrong. Could you describe, how exactly are you testing it? Also, do you use exactly my commit efb5b1a9aa839619db5  ( pushed here https://gitlab.com/vsementsov/qemu.git tag up-tap-fd-migration-v9 ) ?

Also, to check that the series basically work, you may start the included test (under sudo):

    export QEMU_TEST_QEMU_BINARY=$PWD/build/qemu-system-x86_64
    export PYTHONPATH=python:tests/functional
    python3 tests/functional/x86_64/test_tap_migration.py

-- 
Best regards,
Vladimir

