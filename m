Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AA4C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 13:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI5bs-0006jf-Dk; Thu, 22 May 2025 09:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI5bo-0006hk-V2
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI5bg-00053w-Il
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747919104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0/QH8qomFqNVkb3MuqYfVIqNMmbJBfNFCOslIv9lB2A=;
 b=ZgGMQ2athH58aLJzQMRqn3xJMASfnwC6KsBPwrnKURnMt3SfY1V5Bs1dTykRpVT5uh0Br3
 Y9ldcfEiyKhuvDFVmbuH5FNxqXf1y0GBzA7MpYSEbHzOrP2LiLTNaSNDuFlL01WvCV1GO4
 SpMjKqqs89B3dYjVIekkLsuUORlT3Cc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-rb15DUNTOHmfqWH63f95wQ-1; Thu, 22 May 2025 09:05:02 -0400
X-MC-Unique: rb15DUNTOHmfqWH63f95wQ-1
X-Mimecast-MFC-AGG-ID: rb15DUNTOHmfqWH63f95wQ_1747919101
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a363beb5ebso3793227f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 06:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747919101; x=1748523901;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0/QH8qomFqNVkb3MuqYfVIqNMmbJBfNFCOslIv9lB2A=;
 b=E6VsXAGWzpi0zt7ptubs5Bmki4+omLsCNy6Sd3+J4W/iIQkqZlmT5oSWz0+vX6/zJV
 BBMnH72ZFa+MgFu/L3cxkDLto5AtZAMUb9CuUoKcYafQeIkoWbBe1U82EYpFXJUDj3wg
 iQTeOGJrXrMUAItNLdNrz4TKl6ymTZTYKTUD/c26Hyqru5OliYUrA+Tqor0yvvvrUCXf
 LW3DlFCMIADW+4r9qnSJEPrpVYPzNhDIBBR1z6l1jVoHEJ5VcFO4THV+7WS3d97/PKhX
 HPXVZTE8gfHfUVc8KeWiHbWxwqGfqPLylZGac8rziyPLA7jDUsPv8/DTEUd9J/z6NsSp
 HuAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB+mmyNgFBmL2420LpBVldcMOckHfiVFI+T58PuS/F9iOKLNBFJfxTp3J9qRm3PmMyNuCHZFCQfQRV@nongnu.org
X-Gm-Message-State: AOJu0Ywfa19yoeNENAvamYvfXR61Ik1pqtqzy/bbk3yCUTlpXVOY6Epf
 uTFf+RHx9/fw9QdlQbScuIN0xPtaMgvN2Fly6nSF82gPt2OjCIW77zw1zqutwimlSOrHO4cWw62
 oXgJMC2f3i6iRFzqEyd9uRGOTfDn3O5BcO9EfbClpq1wj/o2FRuv6t5Na
X-Gm-Gg: ASbGncsv5CO73JmnvDYQ1nMnRvsBn9GBPdMO0UJrOPkh4svze/toYBGXHcvdVLxaHJO
 lK5Sg0u6vvMUU9Fzy/Ikn1B7zV+zDESibLGWJi3ks3dwwm9G1LDjJLbPjAWE7vzPfN0Hy7s5jWw
 W5xdhcImg1WaV6SR1qj710EuUEPJgifoSNM70wSDIBv0B9p/BB0+Vtb+G+dILPspU3LvtFoNSYV
 6cs1rPu+88+2AB/ZwsUu7KgQ0ZnlliGJKjBpTmOHwHvLUrq0ZEejmwWdOffTN3iDHBGr57MB/51
 SCX8vtlmvjAW0X25N8QGW2S2uXBzSA0UYPzdLgvQwOg=
X-Received: by 2002:a5d:5848:0:b0:3a1:4343:f834 with SMTP id
 ffacd0b85a97d-3a35fe5c5e9mr24080405f8f.2.1747919101242; 
 Thu, 22 May 2025 06:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC2ve6rMuVRNeW0hFx/YwtvlTckd9i3ArDfOACOa4zxd8uW120BabL+18Vzz30d3ZmBxeeXw==
X-Received: by 2002:a5d:5848:0:b0:3a1:4343:f834 with SMTP id
 ffacd0b85a97d-3a35fe5c5e9mr24080348f8f.2.1747919100748; 
 Thu, 22 May 2025 06:05:00 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d204sm23358780f8f.10.2025.05.22.06.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 06:05:00 -0700 (PDT)
Message-ID: <63351e86-d703-4d89-b9b4-f289b6f29f7d@redhat.com>
Date: Thu, 22 May 2025 15:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] tests/functional: add memlock tests
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250521135522.11180-1-dtalexundeer@yandex-team.ru>
 <20250521135522.11180-3-dtalexundeer@yandex-team.ru>
 <430eaa84-5695-4fc2-90d5-d488a204e999@redhat.com>
 <af6b28bd-44cf-4540-b5f8-49d8b2781e13@yandex-team.ru>
 <aC8G9aXYQVWxuP1z@redhat.com>
 <616ffb7f-1b23-49af-a75a-13d1a1f85ea0@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <616ffb7f-1b23-49af-a75a-13d1a1f85ea0@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 22/05/2025 14.40, Alexandr Moshkov wrote:
> 
> On 5/22/25 16:13, Daniel P. Berrangé wrote:
>> On Thu, May 22, 2025 at 01:51:44PM +0500, Alexandr Moshkov wrote:
>>> On 5/22/25 12:49, Thomas Huth wrote:
>>>> On 21/05/2025 15.55, Alexandr Moshkov wrote:
>>>>> Add new tests to check the correctness of the `-overcommit memlock`
>>>>> option (possible values: off, on, on-fault) by using
>>>>> `/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked fields of
>>>>> anonymous segments:
>>>>>
>>>>> * if `memlock=off`, then Locked = 0 on every anonymous smaps;
>>>>> * if `memlock=on`, then Size, Rss and Locked values must be equal for
>>>>> every anon smaps where Rss is not 0;
>>>>> * if `memlock=on-fault`, then Rss and Locked must be equal on every anon
>>>>> smaps and anonymous segment with Rss < Size must exists.
>>>>>
>>>>> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>>>>> ---
>>>> ...
>>>>> diff --git a/tests/functional/test_memlock.py
>>>>> b/tests/functional/test_memlock.py
>>>>> new file mode 100755
>>>>> index 0000000000..a090e7f9ad
>>>>> --- /dev/null
>>>>> +++ b/tests/functional/test_memlock.py
>>>>> @@ -0,0 +1,107 @@
>>>>> +#!/usr/bin/env python3
>>>>> +#
>>>>> +# Functional test that check overcommit memlock options
>>>>> +#
>>>>> +# Copyright (c) Yandex Technologies LLC, 2025
>>>>> +#
>>>>> +# Author:
>>>>> +#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>>>>> +#
>>>>> +#
>>>>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>>>>> +# later.  See the COPYING file in the top-level directory.
>>>> I just noticed: New file need a SPDX identifier nowadays to keep
>>>> scripts/check_patch.pl happy.
>>> Hello, thanks for reply, i fix that in a moment!
>>>
>>>> Anyway, I now also tested the patch, but for me, it's not working: After
>>>> setting ulimit -l to 2G and running the test, I get:
>>>>
>>>> $ ~/devel/qemu/tests/functional/test_memlock.py
>>>> TAP version 13
>>>> ok 1 test_memlock.MemlockTest.test_memlock_off
>>>> Traceback (most recent call last):
>>>>    File "~/devel/qemu/tests/functional/test_memlock.py", line 60, in
>>>> test_memlock_on
>>>>      self.assertTrue(smap['Size'] == smap['Rss'] == smap['Locked'])
>>>>      ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> AssertionError: False is not true
>>>>
>>>> not ok 2 test_memlock.MemlockTest.test_memlock_on
>>>> Traceback (most recent call last):
>>>>    File "~/devel/qemu/tests/functional/test_memlock.py", line 70, in
>>>> test_memlock_onfault
>>>>      self.assertTrue(smap['Rss'] == smap['Locked'])
>>>>      ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> AssertionError: False is not true
>>>>
>>>> not ok 3 test_memlock.MemlockTest.test_memlock_onfault
>>>>
>>>> I added two print statements right in front of the asserts to see the
>>>> values, and for the first one it shows (after many successfully
>>>> comparisons):
>>>>
>>>> line 60: 4 == 4 == 0
>>>>
>>>> And similar for the second one:
>>>>
>>>> line 70: 4 == 0
>>>>
>>>> FWIW, this is on Fedora 41.
>>>>
>>>> Looking at the smaps file, it seems like this comes from a shared
>>>> library:
>>>>
>>>> 7ff16c7c9000-7ff16c7ca000 r--p 00000000 00:2a 29149631
>>>> /usr/lib64/spa-0.2/support/libspa-support.so
>>>> Size:                  4 kB
>>>> KernelPageSize:        4 kB
>>>> MMUPageSize:           4 kB
>>>> Rss:                   4 kB
>>>> Pss:                   0 kB
>>>> Pss_Dirty:             0 kB
>>>> Shared_Clean:          4 kB
>>>> Shared_Dirty:          0 kB
>>>> Private_Clean:         0 kB
>>>> Private_Dirty:         0 kB
>>>> Referenced:            4 kB
>>>> Anonymous:             0 kB
>>>> KSM:                   0 kB
>>>> LazyFree:              0 kB
>>>> AnonHugePages:         0 kB
>>>> ShmemPmdMapped:        0 kB
>>>> FilePmdMapped:         0 kB
>>>> Shared_Hugetlb:        0 kB
>>>> Private_Hugetlb:       0 kB
>>>> Swap:                  0 kB
>>>> SwapPss:               0 kB
>>>> Locked:                0 kB
>>>> THPeligible:           0
>>>> ProtectionKey:         0
>>>>
>>>> So maybe you've got to ignore the mappings of .so files in your test?
>>> Oh, this segments are already ignored in _parse_anonymous_smaps(), so this
>>> segment should not have returned from it.
>>>
>>> Maybe it comes from another segment? Or i have bug in anon segments
>>> parsing.. I'll take a closer look, thanks.
>> It is strange that smaps reports regioons as not locked, despite
>> being resident, as mlockall() claims that it locks *everything*.
> 
> Yes it is. Maybe its just segment from mlock=off test case?

I've taken it from a QEMU that I ran like this:

  ./qemu-system-x86_64 -overcommit mem-lock=on -display none

By the way, the information from the status file looks like this:

VmSize:	 1580432 kB
VmLck:	 1580404 kB

So looks like almost all got locked, except for some few kilobytes.
I guess your test likely just has to take into account some wiggle room...?

  Thomas


