Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11215C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 17:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFFh-00041t-P1; Thu, 06 Mar 2025 12:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqFFe-00041b-5o
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 12:43:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqFFX-0005lR-FY
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 12:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741282989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U5qgqzuNvOM4NYa2y8tkFs7hHYJipPufd3yw/DM0gtI=;
 b=IHKa8GHorgkeH3F1n4HmlIJ/m+XlcqpYOKeIxYDuJJRibhoK7UhuCvZLJPwqQdgfAGhhPG
 GA5qGHjftcJGCd+TSq/Izk2bq9scXi8ICvivetJPFaBGqJ7vgBWJMmZiiQQ8iFpU/cojbE
 mHQ59eVsfr8hztCiPNS4toCXE2bJz8M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-rPi_ywxyOu-39-0HA_SxXw-1; Thu, 06 Mar 2025 12:43:02 -0500
X-MC-Unique: rPi_ywxyOu-39-0HA_SxXw-1
X-Mimecast-MFC-AGG-ID: rPi_ywxyOu-39-0HA_SxXw_1741282981
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391079c9798so510161f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 09:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741282981; x=1741887781;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U5qgqzuNvOM4NYa2y8tkFs7hHYJipPufd3yw/DM0gtI=;
 b=qqPXQAM74Unmo+CKfUhHI/m1f+5u4zlTrGidjvghNJi3IkhBTcnHw79nxVpc+Z5uCz
 LkiZhS/0L7P4NztcYtRWqQN/ODou+EQ06Nyq8i2bh9bT/r0lhD+3kGwoc6lChsbPriOi
 XkdfZcCyLpLkt8Ots9cdFcseu8urYdwyKY0AI4yx7zrGVCB+JK/mdZTKVD8ORaBkoE3v
 skJgVU1uq8dbUJQinnTYcMVbnNCjr5CjaZNh7DzZZ0frCe74VqK6CxN8eAKYHE9mJR3l
 E9Ds4FuqnbEOOULfD67o+UXlH6AKUkCTq2s0IUprh+U2Uw+x8WxwiyjpGnRX4kU9gnDg
 v7hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHW9xHurTgTzoCBBnjmY1M2vWHqqmd682m3BRwYB21uLev8syrIOc1aMFBKDZbtb7wb4Orlmt4TUQQ@nongnu.org
X-Gm-Message-State: AOJu0Yy0UevRFscDSHWvwN2ER7Bh2jakBxtmb1ORXOz6vYSQ4WlqsjE9
 8N4wcp4kt8YBHPXBC/QKcJo0Y94FwMeRWkz8WPnjZrLYwuQ2mpsoeQkEcC69vYbc8UQiWuVKLrz
 PgaafuTIjAn1pE3yJqQR+1wUwjckbX4k9jPWXWrrO8dXmKbqii12m
X-Gm-Gg: ASbGncsBKRuYP/HMjqvtWikjRxmvyiVCbc1H3VJBSRtWA05pHM/Ki0K8zNeNrkvUsUD
 yE5mNu0BwtVdv5USXLseTiq/tEiravadGrIJXrvAE7MsjdV5547zdjKEAJoVmhqZwrerQSJ6fNo
 bmDgG33+L+XC662EbL2WVbJGllHgw/eHWeWwoigHoPm/HKz/4a87ESEiRJ8/Ss8RmXlWpzhk0Jv
 QWQq2o+9GikAgtBPJy8C9B+9ZkRyd4N3R6Aae5LEuM5sHOgr2hmfoij+QHe4zBJbPCGp8Waz33y
 QMxZkYRdWCCukmqQQkBAqJXJtLhdpbkjdcXAa5+mIwn7Lms=
X-Received: by 2002:a05:6000:381:b0:391:4ca:490 with SMTP id
 ffacd0b85a97d-39132d76e70mr28652f8f.29.1741282981364; 
 Thu, 06 Mar 2025 09:43:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7mXsvK9YxPimfzDftmXbuJ7gVWPWTDPYB+dLDvHPV8065HG4jd05UqoiXfEMNqobQEk8JlA==
X-Received: by 2002:a05:6000:381:b0:391:4ca:490 with SMTP id
 ffacd0b85a97d-39132d76e70mr28640f8f.29.1741282980878; 
 Thu, 06 Mar 2025 09:43:00 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f10sm2681269f8f.65.2025.03.06.09.42.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 09:43:00 -0800 (PST)
Message-ID: <d06be182-b6f2-4031-91af-50475fae554c@redhat.com>
Date: Thu, 6 Mar 2025 18:42:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: fix race in virtio balloon test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20250304183340.3749797-1-berrange@redhat.com>
 <5b5bcdd3-f102-4f32-967a-a352cd1803ed@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5b5bcdd3-f102-4f32-967a-a352cd1803ed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 05/03/2025 13.25, Philippe Mathieu-Daudé wrote:
> Hi Daniel,
> 
> On 4/3/25 19:33, Daniel P. Berrangé wrote:
>> There are two race conditions in the recently added virtio balloon
>> test
>>
>>   * The /dev/vda device node is not ready
>>   * The virtio-balloon driver has not issued the first stats refresh
>>
>> To fix the former, monitor dmesg for a line about 'vda'.
>>
>> To fix the latter, retry the stats query until seeing fresh data.
>>
>> Adding 'quiet' to the kernel command line reduces serial output
>> which otherwise slows boot, making it less likely to hit the former
>> race too.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   tests/functional/test_virtio_balloon.py | 24 +++++++++++++++++++-----
>>   1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/functional/test_virtio_balloon.py b/tests/functional/ 
>> test_virtio_balloon.py
>> index 67b48e1b4e..308d197eb3 100755
>> --- a/tests/functional/test_virtio_balloon.py
>> +++ b/tests/functional/test_virtio_balloon.py
>> @@ -32,7 +32,7 @@ class VirtioBalloonx86(QemuSystemTest):
>>           'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0')
>>       DEFAULT_KERNEL_PARAMS = ('root=/dev/vda1 console=ttyS0 net.ifnames=0 '
>> -                             'rd.rescue')
>> +                             'rd.rescue quiet')
>>       def wait_for_console_pattern(self, success_message, vm=None):
>>           wait_for_console_pattern(
>> @@ -47,6 +47,9 @@ def mount_root(self):
>>           prompt = '# '
>>           self.wait_for_console_pattern(prompt)
>> +        # Synchronize on virtio-block driver creating the root device
>> +        exec_command_and_wait_for_pattern(self, "while ! (dmesg -c | grep 
>> vda:) ; do sleep 1 ; done", "vda1")
>> +
>>           exec_command_and_wait_for_pattern(self, 'mount /dev/vda1 /sysroot',
>>                                             prompt)
>>           exec_command_and_wait_for_pattern(self, 'chroot /sysroot',
>> @@ -65,10 +68,21 @@ def assert_initial_stats(self):
>>               assert val == UNSET_STATS_VALUE
>>       def assert_running_stats(self, then):
>> -        ret = self.vm.qmp('qom-get',
>> -                          {'path': '/machine/peripheral/balloon',
>> -                           'property': 'guest-stats'})['return']
>> -        when = ret.get('last-update')
>> +        # We told the QEMU to refresh stats every 100ms, but
>> +        # there can be a delay between virtio-ballon driver
>> +        # being modprobed and seeing the first stats refresh
>> +        # Retry a few times for robustness under heavy load
>> +        retries = 10
>> +        when = 0
>> +        while when == 0 and retries:
>> +            ret = self.vm.qmp('qom-get',
>> +                              {'path': '/machine/peripheral/balloon',
>> +                               'property': 'guest-stats'})['return']
>> +            when = ret.get('last-update')
>> +            if when == 0:
>> +                retries = retries - 1
>> +                time.sleep(0.5)
>> +
>>           now = time.time()
>>           assert when > then and when < now
> 
> Unfortunately I'm still getting a timeout:
> https://gitlab.com/philmd/qemu/-/jobs/9318095233
> 
> 2025-03-05 12:09:55,360 - DEBUG: Console interaction: success_msg='Entering 
> emergency mode.' failure_msg='Kernel panic - not syncing' send_string='None'
> 2025-03-05 12:09:55,360 - DEBUG: Opening console socket
> 2025-03-05 12:10:32,722 - DEBUG: Console interaction: success_msg='# ' 
> failure_msg='Kernel panic - not syncing' send_string='None'
> 2025-03-05 12:10:32,823 - DEBUG: Console interaction: success_msg='vda1' 
> failure_msg='None' send_string='while ! (dmesg -c | grep vda:) ; do sleep 
> 1 ; done
> 
> 2025-03-05 12:10:30,534: Warning: /dev/vda1 does not exist
> 2025-03-05 12:10:30,535:
> 2025-03-05 12:10:30,598: Generating "/run/initramfs/rdsosreport.txt"
> 2025-03-05 12:10:32,720:
> 2025-03-05 12:10:32,721:
> 2025-03-05 12:10:32,722: Entering emergency mode.
> 2025-03-05 12:10:32,724: Exit the shell to continue.
> 2025-03-05 12:10:32,726: Type "journalctl" to view system logs.
> 2025-03-05 12:10:32,727: You might want to save "/run/initramfs/ 
> rdsosreport.txt" to a USB stick or /boot
> 2025-03-05 12:10:32,728: after mounting them and attach it to a bug report.
> 2025-03-05 12:10:32,729:
> 2025-03-05 12:10:32,731:
> 2025-03-05 12:10:32,823: :/#

Same for me, it always seems to hang when being run with the gitlab shared 
runners:

  https://gitlab.com/thuth/qemu/-/jobs/9333926038#L612
  https://gitlab.com/thuth/qemu/-/jobs/9333926046#L625

... no clue what's still going wrong, though ...

  Thomas


