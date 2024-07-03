Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04F4C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 17:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP3Mp-0006Ek-Ec; Wed, 03 Jul 2024 13:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP3Mj-0006CN-LN
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:01:59 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP3MW-0002B3-5k
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:01:55 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c964f5a037so1298321a91.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720026102; x=1720630902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h6bsgl0B59OkVyL5LyduxjmUTFfa5kNoh3n9b6IEtOo=;
 b=ugew6He1B3X1+kUys9SF+O5t6w7pjfTuY/tKyPgGynIMRvtb8u8EXnJmREOwIlSWM7
 bSlHATGN1126aedDKMfAim1kuYczWSSU3vQx20im7JUKUkWC6lbEm8RMnL2NlS1O4/lE
 k29PVIv0bkeDYPzINyAOH6VId+JqYslx3pffOJJAvAlJC8BPo9Qedlt07aFcYkZCaUv2
 GYPwVgKIAhpXNL+NZFQ/iFJQHsrBc2ZSh5+x1uryJLKuZRF9kcsXcOraWBFscMNrBp9O
 DukjQOxPLyxFGmO0GJK3wYBOuXgPoPxCidxNc6GZVkqWbWx6GNC0Gn+SKvHbYt0NC2ST
 2hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720026102; x=1720630902;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h6bsgl0B59OkVyL5LyduxjmUTFfa5kNoh3n9b6IEtOo=;
 b=WkXRrgFhezJlhRdHaAlIyVbE0s8fy1ts/p47B70rpE79E4zpbpouhlAkuKQgeT4SNK
 sX4tHT0tpaDBpP6rfqK/zDeXLGTXlCfq3fO5sP/9Lx2qyJHC2mceL1rSXhBX7k2MtY2T
 ga8Ll7kchGSoIOmOJc9ETtfTsxPlTC61OLowF8DxQaNNcnZfpjVE1BKErAyLJdhdnjVB
 bPQMbY2FlCyt2vINPlO8WbLymK3mC1okmq6LGtxLxtTB6YJ1qHAVoyCqHEggRRUg1Anw
 mbh3Xmdx+e7QfUMQRRF9zcVfWHlFFxFyDZcSF2akz/iePi9VgZXM1/LELd4Ej83FN0sE
 93rA==
X-Gm-Message-State: AOJu0YxpCh4zOGD1NX/VJ+CA2+mugi6KyPhsNsMRsMlcifIVkEyrEn/M
 4yTvWMam2vL6dHEEJLKeQNFz8sZJSv5vtIZo2JqinF+pIOvHLk3oEG1g8yq7340=
X-Google-Smtp-Source: AGHT+IEkx4vyz/1jvMJRKg1Oz/lOvzIBwhxuEofWe7/eR1yjsf2JmfQR/XK2tkQixod2dVU5SATaLg==
X-Received: by 2002:a17:90b:3544:b0:2c9:6f8d:7270 with SMTP id
 98e67ed59e1d1-2c96f8d730fmr2851098a91.42.1720026102205; 
 Wed, 03 Jul 2024 10:01:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10c8ba8sm106394035ad.62.2024.07.03.10.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 10:01:41 -0700 (PDT)
Message-ID: <d18ab076-47e4-4e8a-85d5-45f14f7b7e71@linaro.org>
Date: Wed, 3 Jul 2024 10:01:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/88] virtio: features,fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <cover.1719951168.git.mst@redhat.com>
 <f0961f6f-642c-4dc8-8bf3-1457f71da500@linaro.org>
 <20240703125101-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240703125101-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 7/3/24 09:51, Michael S. Tsirkin wrote:
> On Wed, Jul 03, 2024 at 09:31:45AM -0700, Richard Henderson wrote:
>> On 7/2/24 13:15, Michael S. Tsirkin wrote:
>>> The following changes since commit 1152a0414944f03231f3177207d379d58125890e:
>>>
>>>     Merge tag 'pull-xen-20240701' ofhttps://xenbits.xen.org/git-http/people/aperard/qemu-dm  into staging (2024-07-01 09:06:25 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
>>>
>>> for you to fetch changes up to 29e45afd8d6abf7a67dab5db0ab1cfbc388daefe:
>>>
>>>     hw/pci: Replace -1 with UINT32_MAX for romsize (2024-07-02 11:27:19 -0400)
>>>
>>> ----------------------------------------------------------------
>>> virtio: features,fixes
>>>
>>> A bunch of improvements:
>>> - vhost dirty log is now only scanned once, not once per device
>>> - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
>>> - cxl gained DCD emulation support
>>> - pvpanic gained shutdown support
>>> - beginning of patchset for Generic Port Affinity Structure
>>> - s3 support
>>> - friendlier error messages when boot fails on some illegal configs
>>> - for vhost-user, VHOST_USER_SET_LOG_BASE is now only sent once
>>> - vhost-user now works on any POSIX system
>>> - sr-iov VF setup code has been reworked significantly
>>> - new tests, particularly for risc-v ACPI
>>> - bugfixes
>>>
>>> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
>>
>> Fails testing:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/7257337667
> 
> Could you give me a hint how to trigger this in CI pls?
> All tests seem to pass when I push it to gitlab.
> Any special variables to set?

In CI, FreeBSD uses travis; I'm not sure what's involved.

I replicated it locally within a FreeBSD VM.

It should be reproducible with 'make vm-build-freebsd', but I think that's more difficult 
to debug after the fact than a full vm.


r~

