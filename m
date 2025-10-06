Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DE5CCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 07:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5fay-0007aZ-9g; Mon, 06 Oct 2025 03:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5fav-0007aD-E6
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 03:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5faj-0001fq-1A
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 03:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759735502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1oLFTcy+uLiML5LKBFEnphs607MlZnmFTJUDQT0xhMk=;
 b=ihjd1w5xjI56t2F3M9SQGMJBZa2k8Hxvm6Sjg0DTN8MgIdxxB6QqPPMH5IvLxwuNGJ4vtf
 5Z94EndQ7JQclx33qGdX6mZY/ukNpGpMSG0T2O95T0cgId9SMRM3c240E26zTPMmR8p3M4
 68uqRqMAnJbgHUGRhpM4XBooSorrl+E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-BQuAZNpEP1m3xh6c5jf0qw-1; Mon, 06 Oct 2025 03:25:00 -0400
X-MC-Unique: BQuAZNpEP1m3xh6c5jf0qw-1
X-Mimecast-MFC-AGG-ID: BQuAZNpEP1m3xh6c5jf0qw_1759735500
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b4544f46392so485192566b.0
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 00:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759735500; x=1760340300;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1oLFTcy+uLiML5LKBFEnphs607MlZnmFTJUDQT0xhMk=;
 b=CBa+j5m8tTvkC1wAqc5neywrI/nJ4G0xCFhvUzVeu5SdbprbfDJo1qUoBdMpGcAqXN
 oPzNJsPZzQwgoiiFLJmTv48LV/0znhWc7+BgVWcDvQDhJhFk3CQaYG04HY8R/XZRFdPB
 B8N86AkGbY3F8MZBWa2wY6j8fgrWhIBZJE8hHGjhLeMxQkvIr0S+yVJGsintfbT9xpEt
 F02vXMJelytObnc5o98i6he9Uy3+oFj+nyDif1AQebKcz9fW97p0M92IdcC1uycDJBgu
 gBsAvvsuNghwu+Xc3ZJHbaRzn0WfnKLkcIGu1LsUtrjOCUxK77myjwEp90UNRGDQO1mX
 HNXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3xacdcVV00DaxthjvaUicQkgACqU9hOcgNivc0he/Bhv15drWTrjYJMzx8IfDVa3EgvhgHrgotAFe@nongnu.org
X-Gm-Message-State: AOJu0YzwiEzR5BHgRNYJhWVkcDFlrJ737TbOUQ9P0vKrgUO+8TLztDem
 clmXRVEWaqvik2//mpkAjOVn0lT5H4RiZlfnuw+d2Nye3L2UksjEyVMNYOjRPojm93M0OVMOOH5
 sDDkQD/XWckICcJWTb/jI46SP2p3GMlfG3xldA75NuUgXleTPxLoWlWwRu4nd48S5
X-Gm-Gg: ASbGncsgEWi87YdOMPbfKD2y02W10Wycuov/IkadrjgQkrwdd4AJBpBNgByzyv7zc4Y
 Ar9Ac05KdcZxfL2RtNgCAc55EXf16rtOuVjE2WqcNRArr0Exv98EaIwwuOPOhzyArt9f3r28TNk
 SmrmywrrYCrGeR+NNAUpgddHIL4MRqNSowX6NWxb7QY2gcJ/GCSsueD4ccOMWeJQRchQu4SrZgk
 Vm5TYzOnKS2woCg6GzvsQFOxescSOuPtQziz64kPtLihFvPzcC3RiCcDNSEubZ6gBtugekAKoUS
 fkSw8XlBCgonvTJiCYAt5DxI+m6RlmFYqgtUv6dP9NngcEVGQjaIiHhX+kac+qYRFGGHX48WHvC
 qxlY+WxboSw==
X-Received: by 2002:a17:907:3f8d:b0:b04:4b0d:8e82 with SMTP id
 a640c23a62f3a-b49c3f71d0amr1427468566b.50.1759735499709; 
 Mon, 06 Oct 2025 00:24:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlri00/5x1TmxUdSKAOoXE76D0cZl8Qjrf/BJpjeTTr3JmVbeXCzywd1ONX6VX491E28Klvw==
X-Received: by 2002:a17:907:3f8d:b0:b04:4b0d:8e82 with SMTP id
 a640c23a62f3a-b49c3f71d0amr1427467266b.50.1759735499325; 
 Mon, 06 Oct 2025 00:24:59 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486606bd5csm1078764666b.44.2025.10.06.00.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 00:24:58 -0700 (PDT)
Message-ID: <b5b739a9-28ef-4d0c-b82b-878e9aee103c@redhat.com>
Date: Mon, 6 Oct 2025 09:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
 <b5cb30d8-65a2-4bf7-b66f-5bfe61e19835@redhat.com>
 <8fb3351e-f1a1-4a1e-9650-33f0d4ee6d44@redhat.com>
 <bb7801f1-67d3-47d7-b5bd-39b1113ea9e0@linaro.org>
 <8d89f02e-9e5b-4cdd-9a54-d55bea8967bc@linaro.org>
 <30fec60e-b0e8-408c-b577-e4875d8bb133@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <30fec60e-b0e8-408c-b577-e4875d8bb133@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Hi Gustavo!

On 03/10/2025 17.07, Gustavo Romero wrote:
> Hi Thomas,
> 
> On 10/3/25 11:38, Gustavo Romero wrote:
>> Hi Thomas,
>>
>> On 10/3/25 10:30, Gustavo Romero wrote:
>>> Hi Thomas,
>>>
>>> On 10/2/25 14:52, Thomas Huth wrote:
>>>> On 02/10/2025 18.53, Thomas Huth wrote:
>>>>> On 02/10/2025 04.04, Gustavo Romero wrote:
>>>>>> The goal of this series is to remove Avocado as a dependency for running
>>>>>> the reverse_debugging functional test.
>>>>>>
>>>>>> After several rounds of discussions about v1 and v2, and experiments
>>>>>> done by Daniel and Thomas (thanks for all the experiments and comments
>>>>>> so far), I've taken a new approach and moved away from using a runner
>>>>>> for GDB. The changes, I believe, are much simpler now.
>>>>>
>>>>>   Hi Gustavo,
>>>>>
>>>>> unfortunately, this still seems to be broken on Fedora. After applying 
>>>>> your series, I get:
>>>>>
>>>>> stderr:
>>>>> Traceback (most recent call last):
>>>>>    File "/home/thuth/devel/qemu/tests/functional/reverse_debugging.py", 
>>>>> line 100, in reverse_debugging
>>>>>      self.reverse_debugging_run(vm, port, gdb_arch, last_icount)
>>>>>      ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>    File "/usr/lib64/python3.13/unittest/case.py", line 156, in 
>>>>> skip_wrapper
>>>>>      raise SkipTest(reason)
>>>>> unittest.case.SkipTest: Missing env var(s): QEMU_TEST_GDB
>>>>
>>>> Looks like it's required to explicitly use the --gdb=... parameter of 
>>>> configure to make it work, and it does not work without that paramter? 
>>>> Could you please have a look whether it works without --gdb with the 
>>>> auto-detected gdb for you?
...
> I've just tried it on Fedora 42 and GDB is correctly detected:
> 
> $ ../configure --target-list=aarch64-softmmu --disable-docs
 > $ make -j check-functional-aarch64

I just tried it again, and it just seems to be broken in my build folder 
where I do incremental builds. It works when I build QEMU in a new folder 
from scratch - quite weird.

> I have installed:
> 
> gromero@gromero13:~/git/qemu/build$ dnf info gdb
> Updating and loading repositories:
> Repositories loaded.
> Installed packages
> Name            : gdb
> Epoch           : 0
> Version         : 16.3
> Release         : 1.fc42
> Architecture    : x86_64
> Installed size  : 455.3 KiB
> Source          : gdb-16.3-1.fc42.src.rpm

I've got the very same package installed here.

>> Are you sure GDB is installed in your test env?
>>
>> Do mind checking if:
>>
>> gromero@gromero0:/mnt/git/qemu_$ gdb_bin=$(command -v "gdb-multiarch" || 
>> command -v "gdb")
>> gromero@gromero0:/mnt/git/qemu_$ echo $gdb_bin
>> /usr/bin/gdb
>>
>> works in your env and if QEMU_TEST_GDB is in:
>>
>> $ ./pyvenv/bin/meson test  --verbose --no-rebuild -t 1 --setup thorough  
>> --suite func-thorough  func-aarch64-reverse_debug
>>
>> output?

$ echo $gdb_bin
/usr/bin/gdb

  Thomas


