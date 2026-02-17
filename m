Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBF5E909AE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 14:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsMVL-0004IB-K5; Tue, 17 Feb 2026 09:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vsMV4-0004FU-BW
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:56:31 -0500
Received: from k57.kb8c70eb.use4.send.mailgun.net ([204.220.184.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vsMUz-0004sR-FZ
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:56:29 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 a111505e86cd12b9d188d52514a9346ae668bf9da4be18d706fd9240e07fc0fa with SMTP id
 6994818e7965b5e30fe29514; Tue, 17 Feb 2026 14:56:14 GMT
X-Mailgun-Sending-Ip: 204.220.184.57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1771340173;
 bh=iDFNHjYCnsyIaEws6X1cAAIOa8T31eEBrgRK0yo8/EQ=;
 h=Message-ID:Date:MIME-Version:Subject:X-Mailgun-Dkim:From:To:Cc:
 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:From:
 Reply-to:Subject:Date:Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=CeN64z1FcGXKnsG6KnkybXbqw3P7NliukIfFIB63XUuOeM+Mi7jYEeGzN9wmwUwUn
 ew48UF5qoLATAP5gvTo3Qdoe1gldNbfnF4vdesZgZE5geCQeX3Odf6NvsSmVQUV5uh
 KDGhH9/ppQ24CWO5KOc/qdZiFbMcSL5YJQVRYtxxcMz5BxE80R3usZk4vA7oEV5dWR
 Kw7XyCQET/4fAjtO3jd/3JiBJomuS76Kx6gtrg+iykBWoBM9EHPJe4dbMQrPJvuB/e
 NnyYUZfsCjmq3bWKPSFm8FbA5cDfObJHFwA1R7Mn+aL+gzMFKbCbtbUV/lZsYaQM9q
 4i/BQqL6/++3g==
Message-ID: <749d684e-d4a4-43ea-af55-bd901ac7b97f@yodel.dev>
Date: Tue, 17 Feb 2026 08:56:12 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] vhost-user-bridge housekeeping and test
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260129133049.119829-1-yodel.eldar@yodel.dev>
 <cba38de0-38c0-4d99-9d50-a028fa6510e0@yodel.dev>
Content-Language: en-US
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <cba38de0-38c0-4d99-9d50-a028fa6510e0@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.57;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k57.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi,

On 09/02/2026 10:08, Yodel Eldar wrote:
> Hi,
> 
> On 29/01/2026 07:30, Yodel Eldar wrote:

...skipping...

>> Changes since v3:
>> --------------------
>> - Fix is_readable_executable_file() check of vubr for skipping test
>>
>> Link to v3:
>> -----------
>> https://lore.kernel.org/qemu-devel/20260120215021.30711-1- 
>> yodel.eldar@yodel.dev/

...skipping...

>>
>> Changes since RFCv2:
>> --------------------
>> - Promoted to PATCH
>> - Collect R-b's (thanks to Marc-André and Thomas)
>> - Add test to .../x86_64/meson.build thorough suite (Marc-André)
>> - Add encoding= args to open() (Thomas)
>> - Add pylint disable=unbalanced-tuple-unpacking on find_free_ports()
>> - Minor commit message rewording
>>
>> Changes since RFCv1:
>> --------------------
>> - Remove external host dependency (Marc-André)
>> - Use user netdev tftp feature (Thomas)
>> - Use check_http_download (Thomas)
>> - Remove wget
>> - Inherit from LinuxKernelTest instead of QemuSystemTest
>> - Use hardcoded UUIDs in files on the guest and host for data transfer
>> - Use a Popen context manager to terminate and wait on vubr
>> - Add test to MAINTAINERS under the vhost section (Michael)
>> - New patch to move from tests/ to contrib/vhost-user-bridge/ and add
>>    docs section
>> - New patch to add RX debug logging in vhost-user-bridge.c
>>
>> Links
>> -----
>> RFCv2:
>> https://lore.kernel.org/qemu-devel/20260112230127.99125-1- 
>> yodel.eldar@yodel.dev/
>> RFCv1:
>> https://lore.kernel.org/qemu-devel/20251230002604.113632-1- 
>> yodel.eldar@yodel.dev/
>>
>> Yodel Eldar (3):
>>    tests/vhost-user-bridge: Move to contrib/vhost-user-bridge/
>>    tests/functional/x86_64: Add vhost-user-bridge test
>>    contrib/vhost-user-bridge: Add UDP receive hexdump
>>
>>   MAINTAINERS                                   |   1 +
>>   contrib/vhost-user-bridge/meson.build         |   4 +
>>   .../vhost-user-bridge}/vhost-user-bridge.c    |   7 +
>>   .../devices/virtio/vhost-user-contrib.rst     |  39 +++++
>>   meson.build                                   |   1 +
>>   tests/functional/x86_64/meson.build           |   1 +
>>   .../x86_64/test_vhost_user_bridge.py          | 147 ++++++++++++++++++
>>   tests/meson.build                             |   6 -
>>   8 files changed, 200 insertions(+), 6 deletions(-)
>>   create mode 100644 contrib/vhost-user-bridge/meson.build
>>   rename {tests => contrib/vhost-user-bridge}/vhost-user-bridge.c (98%)
>>   create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py
>>
> 
> Ping?
> 
> Note: All patches have been reviewed.
> 
> Link to v4:
> https://lore.kernel.org/qemu-devel/20260129133049.119829-1- 
> yodel.eldar@yodel.dev/
> 

Ping?

> Thanks,
> Yodel
> 


