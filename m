Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36C5D15D98
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2t8C-0006PH-Jp; Mon, 21 Oct 2024 10:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2t8B-0006P7-Jn
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2t86-00063Z-Vy
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729519888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iMPQ9NgqACMCM8JMt0EGkhQpf0JeYc7xk0rNOTBlMCg=;
 b=YhA4b0UPiysuDhHsdhBKk60+UGDab0A0xUDf2lQtpDlePywMkqvfriB5WEqNhBWaauDyoH
 8AJGfb/KjPZHN3V5hff2cNcwqqKejdCnhW4vakHAJKWDV8Wc9+S6yHYEnrVJxf0Wz9s/X8
 2cOYSeMNpOLyPtEIcDQpYlXsbG6/Ny4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-H5Z36TMWNCSIEPVAZZmHqA-1; Mon, 21 Oct 2024 10:11:27 -0400
X-MC-Unique: H5Z36TMWNCSIEPVAZZmHqA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d43e7acd9so2490183f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 07:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729519886; x=1730124686;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iMPQ9NgqACMCM8JMt0EGkhQpf0JeYc7xk0rNOTBlMCg=;
 b=UdbbI32lttP/dquMH51PAfDF0ZDxClmkA2JQMkXEtLdP5seTss33WKPIJb3AcWSfwa
 DbbWGb6awPjgIFXHobJLbOKhB3Be2+BZ+UJwqaTFF6jqNgiylqDe1SqnakEjXx62MKSx
 53T/uefn1tNhxFm5drobOSz3En8ftxhgRrSRKoRwT82V4B0obvqI/ykKyoYxMXH83siC
 v9XAnpQJmcj67PJ59/OkOaDtXfgQkF6yA2kn4auTzXzdEzbKueYm39avvo20aP+iQouM
 QNRWrENtSoRm7n62MH0CNdn9ZNbdhnYeocK+Z/BcsSoynpg7iFjUIuoLXpQ+R9OfXuXN
 upRg==
X-Gm-Message-State: AOJu0YxhWkcCeTfAdAbvhhzJ5LwZJiF7qF9N495BE119FOJupEFlDlgJ
 Wg5xwfu70lXWmAWRb36wDGcbvLuoie9dP13OFezr7l0LyCxx3mpLg9RJlcj4d0gZ3xpeUgyOfBt
 rnNl6EW4KXmJrfuXwHkeEk1LSgHsswVll56ibV1s7s0BSfKGYOJ6O
X-Received: by 2002:a05:600c:444f:b0:431:5970:806f with SMTP id
 5b1f17b1804b1-43161691ad4mr87833715e9.34.1729519885873; 
 Mon, 21 Oct 2024 07:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0MZEorXz7oQ9vi0o8mrnJt7R++mZ2DHFy222riSdusfxskZ3YISXSv29RSRjn+dMFBUOwoQ==
X-Received: by 2002:a05:600c:444f:b0:431:5970:806f with SMTP id
 5b1f17b1804b1-43161691ad4mr87833475e9.34.1729519885436; 
 Mon, 21 Oct 2024 07:11:25 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5cc1e2sm59669165e9.42.2024.10.21.07.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 07:11:25 -0700 (PDT)
Message-ID: <9a267d01-1259-4e2a-8ad6-e963923bed2c@redhat.com>
Date: Mon, 21 Oct 2024 16:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/21] Test updates (tuxrun tests, new QTest maintainer,
 ...)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241021113500.122500-1-thuth@redhat.com>
 <CAFEAcA9VKkjfYgnv=x5kp+KUZ4rC0y9-KiCWBG+F84MBh7rxPw@mail.gmail.com>
 <a8bbb335-55f4-4c34-b56f-76482391c80e@redhat.com>
 <d5db0cb8-0ec3-4f41-a14c-7d07cbe6f4ec@redhat.com>
 <CAFEAcA8xdxdzXeX7YfZgz45sRqzEsDSWxrhkz11VOSWfVhQ3Dg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8xdxdzXeX7YfZgz45sRqzEsDSWxrhkz11VOSWfVhQ3Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On 21/10/2024 15.59, Peter Maydell wrote:
> On Mon, 21 Oct 2024 at 14:55, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 21/10/2024 15.18, Thomas Huth wrote:
>>> On 21/10/2024 15.00, Peter Maydell wrote:
>>>> On Mon, 21 Oct 2024 at 12:35, Thomas Huth <thuth@redhat.com> wrote:
>>>>>
>>>>> The following changes since commit f1dd640896ee2b50cb34328f2568aad324702954:
>>>>>
>>>>>     Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into
>>>>> staging (2024-10-18 10:42:56 +0100)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>     https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-21
>>>>>
>>>>> for you to fetch changes up to ee772a332af8f23acf604ad0fb5132f886b0eb16:
>>>>>
>>>>>     tests/functional: Convert the Avocado sh4 tuxrun test (2024-10-21
>>>>> 13:25:12 +0200)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> * Convert the Tuxrun Avocado tests to the new functional framework
>>>>> * Update the OpenBSD CI image to OpenBSD v7.6
>>>>> * Bump timeout of the ide-test
>>>>> * New maintainer for the QTests
>>>>> * Disable the pci-bridge on s390x by default
>>>>>
>>>>> ----------------------------------------------------------------
>>>>
>>>> Couple of failures on the functional-tests:
>>>>
>>>> https://gitlab.com/qemu-project/qemu/-/jobs/8140716604
>>>>
>>>> 7/28 qemu:func-thorough+func-aarch64-thorough+thorough /
>>>> func-aarch64-aarch64_tuxrun TIMEOUT 120.06s killed by signal 15
>>>> SIGTERM
>>>>
>>>> https://gitlab.com/qemu-project/qemu/-/jobs/8140716520
>>>>
>>>> 14/17 qemu:func-thorough+func-loongarch64-thorough+thorough /
>>>> func-loongarch64-loongarch64_virt TIMEOUT 60.09s killed by signal 15
>>>> SIGTERM
>>>>
>>>> I'm retrying to see if these are intermittent, but they
>>>> suggest that we should bump the timeout for these.
>>>
>>> Everything was fine with the gitlab shared runners (https://gitlab.com/
>>> thuth/qemu/-/pipelines/1504882880), but yes, it's likely the private runners
>>> being slow again...
>>>
>>> So please don't merge it yet, I'll go through the jobs of the private
>>> runners and update the timeouts of the failed jobs and the ones where it is
>>> getting close to the limit.
>>
>> Actually, looking at it again, the func-loongarch64-loongarch64_virt test is
>> not a new one, this has been merged quite a while ago already. And in
>> previous runs, it only took 6 - 10 seconds:
>>
>>    https://gitlab.com/qemu-project/qemu/-/jobs/8125336852#L810
>>    https://gitlab.com/qemu-project/qemu/-/jobs/8111434905#L740
>>
>> So maybe this was just a temporary blip in the test runners indeed? Could
>> you please try to rerun the jobs to see how long they take then?
> 
> The alpine job passed on the retry:
> https://gitlab.com/qemu-project/qemu/-/jobs/8141648479
> and the func-loongarch64-loongarch64_virt test took 5.08s.
> 
> The opensuse job failed again:
> https://gitlab.com/qemu-project/qemu/-/jobs/8141649069
> 7/28 qemu:func-thorough+func-aarch64-thorough+thorough /
> func-aarch64-aarch64_tuxrun TIMEOUT 120.04s killed by signal 15
> SIGTERM

Looking at the log files of the job, I can see in 
https://gitlab.com/qemu-project/qemu/-/jobs/8141649069/artifacts/browse/build/tests/functional/aarch64/test_aarch64_tuxrun.TuxRunAarch64Test.test_arm64be/ 
console.log:

2024-10-21 13:20:32,844: Run /sbin/init as init process
2024-10-21 13:20:34,043: EXT4-fs (vda): re-mounted. Opts: (null). Quota 
mode: none.
2024-10-21 13:20:34,350: Starting syslogd: OK
2024-10-21 13:20:34,423: Starting klogd: OK
2024-10-21 13:20:34,667: Running sysctl: OK
2024-10-21 13:20:34,739: Saving 2048 bits of non-creditable seed for next boot
2024-10-21 13:20:34,966: Starting network: blk_update_request: I/O error, 
dev vda, sector 5824 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
2024-10-21 13:20:35,028: blk_update_request: I/O error, dev vda, sector 8848 
op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
2024-10-21 13:20:35,051: OK
2024-10-21 13:20:35,088: blk_update_request: I/O error, dev vda, sector 
12936 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
2024-10-21 13:20:35,149: blk_update_request: I/O error, dev vda, sector 
17032 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
2024-10-21 13:20:35,181: Welcome to TuxTest
2024-10-21 13:20:35,882: tuxtest login: blk_update_request: I/O error, dev 
vda, sector 21128 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
2024-10-21 13:20:35,882: blk_update_request: I/O error, dev vda, sector 
25224 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
2024-10-21 13:20:35,882: blk_update_request: I/O error, dev vda, sector 
29320 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
2024-10-21 13:20:35,887: root

So this is indeed more than just a timeout setting that is too small...
I don't get the virtio errors when running the test locally, though.
I guess this needs some more investigation first ... maybe best if I respin 
the PR without this patch for now 'til this is understood and fixed.

  Thomas


