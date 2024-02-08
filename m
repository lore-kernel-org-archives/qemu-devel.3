Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43E9C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY93W-00084v-SC; Thu, 08 Feb 2024 13:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rY93V-00084b-JF
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:23:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rY93T-00009E-UF
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707416601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vqtGZlnaPBanzxaRtaUg7pF8Mthu78g1bIUNZU1buMc=;
 b=NBozkHdTLgHIV5sYRVCpPyFKc9JvxiGyO/3WRFYJJbVQLWAXO4ZdUlchmekzJ2R+3hs/yt
 6IGuYydb1/1DuaadpE4VXOTKM8UyZrnhfxLv5912GFx3reO1B1oNsgrmJ55455aIEYiwDY
 N+l6pIOvyIZjUGHUqUtRSGCIptFOaUM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-fggH08EUPLmraXc3hSui2A-1; Thu, 08 Feb 2024 13:23:19 -0500
X-MC-Unique: fggH08EUPLmraXc3hSui2A-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-785863ca8c4so19279385a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707416599; x=1708021399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vqtGZlnaPBanzxaRtaUg7pF8Mthu78g1bIUNZU1buMc=;
 b=VXTBv3HVmtUpifdlWz42000Z/0DBfeTaG82n+SAHiKKwXCD0pIynnGmadFPiMH/1Lx
 HVhAIHzXgSXmGS9dScWQws/7dt8AV6e1+KQ7U/1PygVtk+iLICyA/uzuzkz55s4ciytK
 +KFa+8SYrjpX1wvbTe0ydLFdAfvH4/F2qbO2swEC2mkRLVdrxNaMweRYY2xszw1z2H+p
 ZcbDPz6j2fjijxAzawy/RdMNBrQlZZ6yW8CgvQDU//00gC6756quQBST9Qp33zU307Ht
 wfAk0ZbmFVCeSg5d7b3bpqyxVxNF3KDlHbaoZX7RzkuaWEnpyij5OzZH6To9wo5i3Fd7
 V3xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0xyMOacNlNMAdSv/ZcKJit2QUrEwezsFqR8GU5b4CPFPvmwfnMHICaxWL8hj+WTivgRdo6qo5G9lOWajHYqyET+FtzsI=
X-Gm-Message-State: AOJu0YxnPmmyk6HahCtFOR9TWkVljR7MP/FOmWaMDr9JHYBqOw5AbgKS
 AeV245Ibv1IleztwvsO6RwyUf2k9FSiJWpqsXimsvbENGf5QdMCIEfikr4ydyo0Sh6oMmpJXclK
 HeIVdmvM6CpUtWVL4zoQlq9RygMu1y7P5nqj79eqJ+G2A08QHvCmB
X-Received: by 2002:a05:620a:2228:b0:785:9c70:c7fa with SMTP id
 n8-20020a05620a222800b007859c70c7famr310476qkh.1.1707416599419; 
 Thu, 08 Feb 2024 10:23:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuGjshyQxkka14Uo57lPw0cQG+5b2VcOa3gFFTui8Ewilv8Ow6eQxEhBGRLuIUmYdRR2Dhyg==
X-Received: by 2002:a05:620a:2228:b0:785:9c70:c7fa with SMTP id
 n8-20020a05620a222800b007859c70c7famr310460qkh.1.1707416599208; 
 Thu, 08 Feb 2024 10:23:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVxB5yt8DVmHh5gTQyhxvZMwBvIUcZhoi+HvKOKHWwnuE9GLac5LuR+ytD7XBk6JPiLWNmWPtFeq90FpTcef0I1jJkYLyCyib6NkGGC825uv9T2q/BbZkJ/L3Zpcy6CD+1P2+nOLkBrnKuMbs4+jv/LkULmi8O8x6ZevDm535QFJ0wcH78As2LClAY+JFTZLHtpUCxnJD0hI0x+aeQW1pcyU9SfYELZ8OJ0mTW4Kiha40UgxB8EZlnGpW+RpSpZ58cY2LkVIbp4+Kp0tA==
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 v24-20020a05620a123800b007854018044bsm45815qkj.134.2024.02.08.10.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 10:23:18 -0800 (PST)
Message-ID: <b451a263-db41-4ec2-b880-be27721ec00d@redhat.com>
Date: Thu, 8 Feb 2024 19:23:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] QEMU v7.2.0 aarch64 Nested Virtualization Support
Content-Language: en-US
To: Miguel Luis <miguel.luis@oracle.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Haibo Xu <haibo.xu@linaro.org>, Andrew Jones <drjones@redhat.com>,
 Marc Zyngier <maz@kernel.org>
References: <20230227163718.62003-1-miguel.luis@oracle.com>
 <5ede0197-4587-43e8-976f-d3001f42b8b9@redhat.com>
 <69C2ABCA-577B-419D-A0B4-52923BE59842@oracle.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <69C2ABCA-577B-419D-A0B4-52923BE59842@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Miguel,

On 2/8/24 18:33, Miguel Luis wrote:
> Hi Eric,
> 
>> On 8 Feb 2024, at 15:55, Eric Auger <eauger@redhat.com> wrote:
>>
>> Hi Miguel,
>>
>> On 2/27/23 17:37, Miguel Luis wrote:
>>> This series adds ARMv8.3/8.4 nested virtualization support in KVM mode.
>>>
>>> To enable nested virtualization for a guest, the host must expose EL2
>>> support via QEMU command line switches:
>>>
>>> -machine virt,accel=kvm,virtualization=on
>>>
>>> Inspired on Haibo Xu's previous work [0][1], Marc Zyngier's kvmtool branch [2]
>>> and kernel patches [3] on nested virtualization for aarch64, this has been
>>> tested on an Ampere implementation.
>>>
>>> This series adapts previous work on top of v7.2.0, it considers comments given
>>> at the time and preserves authorship of the original patches.
>>>
>>> [0]: https://lore.kernel.org/qemu-devel/cover.1616052889.git.haibo.xu@linaro.org/
>>> [1]: https://lore.kernel.org/qemu-devel/cover.1617281290.git.haibo.xu@linaro.org/
>>> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/maz/kvmtool.git/log/?h=arm64/nv-5.16
>>> [3]: https://lore.kernel.org/linux-arm-kernel/20230131092504.2880505-1-maz@kernel.org/
>>
>> I rebased the series on top of v8.2. I was able to boot some L2 guests
>> with it, although it still does not work with guests featuring edk2.
>>
>> Do you plan to send a respin or may I do?
>>
> 
> I do not have a short-term respin planned.
> Please, feel free to do.

OK thanks. I will send it tomorrow.

Eric
> 
> Thanks
> 
> Miguel
> 
>> Thanks
>>
>> Eric
>>>
>>> Miguel Luis (5):
>>>  linux-headers: [kvm,arm64] add the necessary definitions to match host
>>>    kernel
>>>  hw/intc/gicv3: add support for setting KVM vGIC maintenance IRQ
>>>  target/arm/kvm: add helper to detect EL2 when using KVM
>>>  target/arm: enable feature ARM_FEATURE_EL2 if EL2 is supported
>>>  arm/virt: provide virtualization extensions to the guest
>>>
>>> hw/arm/virt.c                      |  8 +++++++-
>>> hw/intc/arm_gicv3_common.c         |  1 +
>>> hw/intc/arm_gicv3_kvm.c            | 25 +++++++++++++++++++++++++
>>> include/hw/intc/arm_gicv3_common.h |  1 +
>>> linux-headers/asm-arm64/kvm.h      |  2 ++
>>> linux-headers/linux/kvm.h          |  1 +
>>> target/arm/cpu.h                   |  2 +-
>>> target/arm/kvm64.c                 | 21 +++++++++++++++++++++
>>> target/arm/kvm_arm.h               | 12 ++++++++++++
>>> 9 files changed, 71 insertions(+), 2 deletions(-)
> 
> 


