Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C74FC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 18:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP50D-0008Dw-L9; Wed, 03 Jul 2024 14:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sP50A-0008BC-BD
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 14:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sP508-00062e-In
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 14:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720032403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H3eL37u4HdEsiYLYhvkEbBaCHJJX5a6oC3l8+Npv6CI=;
 b=K32+fViwQr41ZfX8zSEbGaYaf1ozDLLCujdK2a0C+QDIgSkESlCb2oLmPGdZ1ExXHRQeDV
 MXWKVzDlQtLXq2wXcehAvS/TBz18Ys0UrsXivJRdAhgdP8JZG3ZpwQyli/W5Gutn/5NzSI
 hU7bUNm3MxsgAwlz5ahqUYcck1/sMWo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-cl7C_V74Mzq55VR3PQoN_Q-1; Wed, 03 Jul 2024 14:46:42 -0400
X-MC-Unique: cl7C_V74Mzq55VR3PQoN_Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36793373454so541614f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 11:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720032401; x=1720637201;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H3eL37u4HdEsiYLYhvkEbBaCHJJX5a6oC3l8+Npv6CI=;
 b=jUci4JaDaZnySoO8Vi2mScZiK79N5U1YYJLyr6uLHiV4zqE8rRyxa0lSpG6lTCS9N0
 rnv7Ktmz/5pBdBzURpLk2T9hpOlb/UlhQPfl1NEAN4zD8rYU27/Q8m0kMfqTmMeC/6Zb
 P5+6SxiPnJtYJykh1/C4lf7teJn8QTVI+a0qDilsvAEAqguznl314K/EiCEAD4nbcvnQ
 x+4hD6KiTRm0gof68h7yX4fViaob4P1iwtpw00HUkzgAUkP/MLP1HvsMlxp8A0EPeo2E
 f9ZKsh8Uh400jamoXrl5W/kVWyGfQJ3YA4YaFgIlhZpd+qjRoULiyWxK2M3UUrWe/9Eq
 ztPw==
X-Gm-Message-State: AOJu0YzI1zrrD0S/KIsf8TJDbfZI5VS2EqGcoX7tPDU67g3r/R59lCUD
 aUiqZXLEHxxyBfg1x1FmvDYpOba44hKEuYthFBO61jRWVv9AEjxkzNIcmNQdOIm6qO1EXUjmuKC
 akehThnrJ6ha7vlO8qwkM4aNkST09fqThaiI0xgNo8+FHyIToQg37
X-Received: by 2002:a5d:5983:0:b0:367:94ff:6835 with SMTP id
 ffacd0b85a97d-36794ff68a9mr1759137f8f.18.1720032400833; 
 Wed, 03 Jul 2024 11:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG35POgI6sYawsmkQuMQvqjfr0XSpiLIu71ikg5mPoZ3ry8FkeW3KL212EpSJiRftGE4JzU9Q==
X-Received: by 2002:a5d:5983:0:b0:367:94ff:6835 with SMTP id
 ffacd0b85a97d-36794ff68a9mr1759130f8f.18.1720032400426; 
 Wed, 03 Jul 2024 11:46:40 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-82.web.vodafone.de.
 [109.43.176.82]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a104dbdsm16579905f8f.113.2024.07.03.11.46.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 11:46:40 -0700 (PDT)
Message-ID: <54f9b0f4-d638-4273-935a-bb9bd129701b@redhat.com>
Date: Wed, 3 Jul 2024 20:46:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/88] virtio: features,fixes
To: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <cover.1719951168.git.mst@redhat.com>
 <f0961f6f-642c-4dc8-8bf3-1457f71da500@linaro.org>
 <20240703125101-mutt-send-email-mst@kernel.org>
 <d18ab076-47e4-4e8a-85d5-45f14f7b7e71@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d18ab076-47e4-4e8a-85d5-45f14f7b7e71@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 03/07/2024 19.01, Richard Henderson wrote:
> On 7/3/24 09:51, Michael S. Tsirkin wrote:
>> On Wed, Jul 03, 2024 at 09:31:45AM -0700, Richard Henderson wrote:
>>> On 7/2/24 13:15, Michael S. Tsirkin wrote:
>>>> The following changes since commit 
>>>> 1152a0414944f03231f3177207d379d58125890e:
>>>>
>>>>     Merge tag 'pull-xen-20240701' 
>>>> ofhttps://xenbits.xen.org/git-http/people/aperard/qemu-dm  into staging 
>>>> (2024-07-01 09:06:25 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>     https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
>>>>
>>>> for you to fetch changes up to 29e45afd8d6abf7a67dab5db0ab1cfbc388daefe:
>>>>
>>>>     hw/pci: Replace -1 with UINT32_MAX for romsize (2024-07-02 11:27:19 
>>>> -0400)
>>>>
>>>> ----------------------------------------------------------------
>>>> virtio: features,fixes
>>>>
>>>> A bunch of improvements:
>>>> - vhost dirty log is now only scanned once, not once per device
>>>> - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
>>>> - cxl gained DCD emulation support
>>>> - pvpanic gained shutdown support
>>>> - beginning of patchset for Generic Port Affinity Structure
>>>> - s3 support
>>>> - friendlier error messages when boot fails on some illegal configs
>>>> - for vhost-user, VHOST_USER_SET_LOG_BASE is now only sent once
>>>> - vhost-user now works on any POSIX system
>>>> - sr-iov VF setup code has been reworked significantly
>>>> - new tests, particularly for risc-v ACPI
>>>> - bugfixes
>>>>
>>>> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
>>>
>>> Fails testing:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/7257337667
>>
>> Could you give me a hint how to trigger this in CI pls?
>> All tests seem to pass when I push it to gitlab.
>> Any special variables to set?
> 
> In CI, FreeBSD uses travis; I'm not sure what's involved.

s/travis/cirrus-ci/

See .gitlab-ci.d/cirrus/README.rst for information how to enable it in your 
private gitlab repo.

> I replicated it locally within a FreeBSD VM.
> 
> It should be reproducible with 'make vm-build-freebsd', but I think that's 
> more difficult to debug after the fact than a full vm.

Just use "make vm-build-freebsd DEBUG=1" and you should get a shell prompt 
for interactive debugging, so that's likely the best way to tackle such issues.

  HTH,
   Thomas


