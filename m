Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCF6C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8bw-0007MO-E5; Wed, 03 Jul 2024 18:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP8bn-0007Lh-Am
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:37:52 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP8bk-0003Ql-Tp
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:37:50 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fb1ff21748so6494505ad.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720046267; x=1720651067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1QrBiPbK/owVlQpEZ77NbA688DkMtAcqX+mYwuLKYlU=;
 b=P2QLHJEjEwuNXFEquC7EQvTBDw0B4Igpnx0WgtaeYhKMLa8EDUic3ljHcAjoZ/AFSz
 MDpSdx4mBRn1lPx5h386cIz+jt3ZKWoEQzOO3mhHEZFgLTdAMRuxeYWkdUDFv4xjQU6J
 bkLgF5U1dP1owojC0dOpBxzr7sOhVDXDiU2M574BO2JBFmCn+ldRt+bp81HvQ0L4qI29
 v8+VQI0KFO27BIzONuVfsx8CfXT7noFXJu1qT/YQTrnov2senNV8X39fO9osjmYozTfO
 cqIC1euTNwqpn2rhyAOuQ5ogKrjQDz9CUAoaw62ux0+CcL4gCMUkNxhpKyYvlpDJqtoD
 yBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046267; x=1720651067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1QrBiPbK/owVlQpEZ77NbA688DkMtAcqX+mYwuLKYlU=;
 b=o1OLIq9fRRr/cjfIBB1SrMkqOwOPVgxPNp8B3rscL86uKJdhVsOOUhyP8WWRWLxK/x
 LsH2nF1KpQoMcgGLgDyhUiImxajhmUYxS/16cZEfq/C4naQFARpO0o3IrdV2wMfB2hMY
 TL7pBWu8gWNfbccAW+MhLOgShx0s+GnSyvRbNBs/hHl+3kZKJc/lnMf1GOihV/ESBQeg
 5S++R+Cozf20jhMLzXMfrtx6ewFNI4LXIYHYdigcaeHluTUTH1Mv8P8AkJKOYG9Ypra0
 9jyq2kK+52pmsfOduzdyJiL9bB77wZR2e2E9PV7Z0noa40wAD8aCESfW/7a7sG8jwedO
 I9UQ==
X-Gm-Message-State: AOJu0YzpdI7K2yRTNENo5RJ2moeBzc2JwFR99a6+G4ttVbVWJxqz01oP
 rYCeAWC6XNJoDNqd1BdZisCc+O2PGkcN958S3dJtG+neXBqix3635/re1qVo73Y=
X-Google-Smtp-Source: AGHT+IHi4pjGFx11x3t840n65oQP24gzuonlJf750eO2UIeV3H/WqrtzBHRYV+chpGjnvf0IGug+jg==
X-Received: by 2002:a17:90a:c58d:b0:2c9:63e9:8463 with SMTP id
 98e67ed59e1d1-2c963e98819mr4469380a91.2.1720046266100; 
 Wed, 03 Jul 2024 15:37:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fafc3a645fsm37511425ad.6.2024.07.03.15.37.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 15:37:45 -0700 (PDT)
Message-ID: <95648f85-d4b2-4ceb-bccf-888114e0fe03@linaro.org>
Date: Wed, 3 Jul 2024 15:37:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/88] virtio: features,fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <cover.1719951168.git.mst@redhat.com>
 <f0961f6f-642c-4dc8-8bf3-1457f71da500@linaro.org>
 <20240703125101-mutt-send-email-mst@kernel.org>
 <d18ab076-47e4-4e8a-85d5-45f14f7b7e71@linaro.org>
 <54f9b0f4-d638-4273-935a-bb9bd129701b@redhat.com>
 <20240703162544-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240703162544-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/3/24 13:26, Michael S. Tsirkin wrote:
> On Wed, Jul 03, 2024 at 08:46:38PM +0200, Thomas Huth wrote:
>> On 03/07/2024 19.01, Richard Henderson wrote:
>>> On 7/3/24 09:51, Michael S. Tsirkin wrote:
>>>> On Wed, Jul 03, 2024 at 09:31:45AM -0700, Richard Henderson wrote:
>>>>> On 7/2/24 13:15, Michael S. Tsirkin wrote:
>>>>>> The following changes since commit
>>>>>> 1152a0414944f03231f3177207d379d58125890e:
>>>>>>
>>>>>>      Merge tag 'pull-xen-20240701'
>>>>>> ofhttps://xenbits.xen.org/git-http/people/aperard/qemu-dm
>>>>>> into staging (2024-07-01 09:06:25 -0700)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>>      https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
>>>>>>
>>>>>> for you to fetch changes up to 29e45afd8d6abf7a67dab5db0ab1cfbc388daefe:
>>>>>>
>>>>>>      hw/pci: Replace -1 with UINT32_MAX for romsize
>>>>>> (2024-07-02 11:27:19 -0400)
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> virtio: features,fixes
>>>>>>
>>>>>> A bunch of improvements:
>>>>>> - vhost dirty log is now only scanned once, not once per device
>>>>>> - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
>>>>>> - cxl gained DCD emulation support
>>>>>> - pvpanic gained shutdown support
>>>>>> - beginning of patchset for Generic Port Affinity Structure
>>>>>> - s3 support
>>>>>> - friendlier error messages when boot fails on some illegal configs
>>>>>> - for vhost-user, VHOST_USER_SET_LOG_BASE is now only sent once
>>>>>> - vhost-user now works on any POSIX system
>>>>>> - sr-iov VF setup code has been reworked significantly
>>>>>> - new tests, particularly for risc-v ACPI
>>>>>> - bugfixes
>>>>>>
>>>>>> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
>>>>>
>>>>> Fails testing:
>>>>>
>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/7257337667
>>>>
>>>> Could you give me a hint how to trigger this in CI pls?
>>>> All tests seem to pass when I push it to gitlab.
>>>> Any special variables to set?
>>>
>>> In CI, FreeBSD uses travis; I'm not sure what's involved.
>>
>> s/travis/cirrus-ci/
>>
>> See .gitlab-ci.d/cirrus/README.rst for information how to enable it in your
>> private gitlab repo.
>>
>>> I replicated it locally within a FreeBSD VM.
>>>
>>> It should be reproducible with 'make vm-build-freebsd', but I think
>>> that's more difficult to debug after the fact than a full vm.
>>
>> Just use "make vm-build-freebsd DEBUG=1" and you should get a shell prompt
>> for interactive debugging, so that's likely the best way to tackle such
>> issues.
>>
>>   HTH,
>>    Thomas
> 
> Thanks!
> As a side, is there some way to persist the stuff fetched over the
> network so it does not happen each time I re-run make?

That's why I use a proper vm install of freebsd.


r~


