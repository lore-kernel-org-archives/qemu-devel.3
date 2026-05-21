Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7712CD5BAB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyKQ-0006Iq-IJ; Thu, 21 May 2026 04:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPyKN-0006I3-0i
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPyKK-00056o-5g
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779350419;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9p+OJqKYHgstHpmfwjfYsbpYBrkM52QfMiRCCLmoAvc=;
 b=S1KFaWxpFqu/9ZdW8MKk11HC/nhWh8oZL4G3TPCqoSKFGJGVCIM7dR42vWxYwGyFVbebVl
 qLfLfGKdjadTyVfxzJz+IB3xZ/WMUoMMmyyJkPulzTYxvRvzR2UqjdlFPhuFyu0T6Nvqnc
 JyUEx+GxOBC8BZyz5uVNGTYA/bRmPzE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-ovTiiWfFM92tL8v4WUYUVQ-1; Thu, 21 May 2026 04:00:17 -0400
X-MC-Unique: ovTiiWfFM92tL8v4WUYUVQ-1
X-Mimecast-MFC-AGG-ID: ovTiiWfFM92tL8v4WUYUVQ_1779350416
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fea6292a5so27017955e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779350416; x=1779955216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9p+OJqKYHgstHpmfwjfYsbpYBrkM52QfMiRCCLmoAvc=;
 b=MFM53V45/dVQrT2CCdzrd4WSp52p84xUiiP8QXWiGW9ik/hYfhe/DFsHqIQEoX/V2R
 by3w/MR3pqIVNGTSssMd+5f4KpMLBljQnGQOC0EWld+7H93LLhAv8Yq/wJkzQgBEsgp5
 ccppVXVzRxEp/yqt+Ej707ONOWdNUsxLfQvQDh4E9o8gBivbA6S6/uGqNJ1SzWehNA5Y
 uWHN2YYEoBa0i63a1nQYTzvnId05gmyaMKUPoc4bmUZJiyjiIBD80uUjtoiDMRhAuQQN
 p6FYJJwdMIffNeSDS+K+mgFvmxZZ2N9iX7LizIUFM0gTI2aYWv5Wwo1dQv2d9ZLT2tc6
 viNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/V0ewkZVhfrhwJVRHusV9zYOCsjFrwewqHApwglMU2GZgRehJktMwQyQRIw1geCNyPHm3u0Z4TT6jl@nongnu.org
X-Gm-Message-State: AOJu0Ywnds6yehVOi6mX/TRLDMkoIRkjCEjeTMJntXFeBM06TyNWU/xl
 9jNnOVWCA1oEqJQyBJgFkkHN5LQTbuJt5veHqJdBihbO+C3NOaqoZirCbmlSWIF6AgQ874Q9wVb
 2sakhzlS47OVxxPlvWGFDyysp2pWl5VmOzkzyV7N9C3wpkGHiELwsIn1d
X-Gm-Gg: Acq92OGNWRGscwM0vEZMhQDbsAIfCh+5qkQmA0ofbZ3I/e6qdODk7A0DtuVMhMeEl5a
 ev5fCnTYMCGTH+owTceES67rEL0mbGEXs7IItaujSGsD7RzCPaBEk4qwQNQMJzpDGKF2ZJXPIie
 4gtvmLQPsOqSFdOaGdnMjLXcY5SXKtCo8qnmC6M9ZteVAkbOOCXJIof1/zhdueijJpk0UOXVLw4
 Lnq2XaJKhFlOxqtDW1f9ktwiJpG1SFPcIMZsv4A4S0shRzpPLYYd3V3OzJKJ7FP+HfztIcnsha5
 7lDPzV2BThM4LC0JN1MC+w2XBRnVvb/7kgYI+QAHsuathqJo77886zXDibor49kjXSilBm5pp0/
 QT9TaNZWZ10HaCImxWtqmveUmo4d64B0304cQr/why1fhMJzvawgPNTMpABntn6it3qVgnA==
X-Received: by 2002:a05:600c:4d82:b0:48f:e230:8caa with SMTP id
 5b1f17b1804b1-490360ceaf7mr13596045e9.30.1779350415261; 
 Thu, 21 May 2026 01:00:15 -0700 (PDT)
X-Received: by 2002:a05:600c:4d82:b0:48f:e230:8caa with SMTP id
 5b1f17b1804b1-490360ceaf7mr13595005e9.30.1779350413771; 
 Thu, 21 May 2026 01:00:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c64beasm14114735e9.1.2026.05.21.01.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 01:00:13 -0700 (PDT)
Message-ID: <f0909a11-9bc5-47b5-a50e-b3fee4a5bdf8@redhat.com>
Date: Thu, 21 May 2026 10:00:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-18-skolothumtho@nvidia.com>
 <c0dd92b2-4ea9-45a2-afbf-b61910f71fe6@redhat.com>
 <CH3PR12MB75486D02EEBCE74D47B20834AB012@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB75486D02EEBCE74D47B20834AB012@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 5/20/26 5:47 PM, Shameer Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 20 May 2026 13:54
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>; phrdina@redhat.com
>> Subject: Re: [PATCH v5 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0
>> for CMDQV
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 5/19/26 12:36 PM, Shameer Kolothum wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> The CMDQ-V CMDQ pages provide a VM wide view of all VCMDQs, while the
>> s/CMDQ pages/VCMDQ pages - yeah that's all very confusing ;-) -
>>> VINTF pages expose a logical view local to a given VINTF. Although real
>>> hardware may support multiple VINTFs, the kernel currently exposes a
>>> single VINTF per VM.
>>>
>>> The kernel provides an mmap offset for the VINTF Page0 region during
>> for the host VINTF page0 allocated for the VM
>>
>> Actually is the whole host passthrough principle is not really explained
>> anywhere. At least that's my feeling. It would be nice to have a summary
>> for it, in the coverletter and in individual patch. Or maybe we can link
>> to another doc. Reading the kernel uapi does not really provide the full
>> picture, at least that's my own feeling.
> Fair point. A summary of operation is useful. I am thinking of adding
> it at the top of hw/arm/tegra241-cmdqv.c:
>
> /*
>    * Tegra241 CMDQV - overview
>    * ---------------------------------------
>    *...
>    */
>
> I will populate the details and share it for review before v6.
>
>> when a VM allocates a VIOMMU for the CMDQV, the kernel allocates this
>> and this resource that is then given for exclusive usage of the VM ...
>> How does it guarantee security between VMs, etc...
> Isolation is enforced by the kernel and the CMDQV hardware.
> I think the key points here are:
>
>   - Each VM has its own iommufd FD. All iommufd objects (VINTF, hw
>     queues, mmap regions) belong to that FD; one VM cannot reach
>     another VM's IDs.
>
>   - Each FD gets its own VINTF, allocated by IOMMU_VIOMMU_ALLOC. The
>     kernel writes the VM's VMID into the VINTF and the host CMDQV
s/writes/configures
>     hardware checks it on every command. 
>
>   - The kernel allocates the VINTF with HYP_OWN = 0, which restricts
>     the guest to a safe subset of commands.
>
>   - Per VINTF, the kernel programs SID_MATCH and SID_REPLACE so only
>     the VM's own vfio-pci devices can issue commands; other SIDs are
>     rejected by the hardware.
>
>   - IOMMU_HW_QUEUE_ALLOC binds each VCMDQ to one specific VINTF, so a
>     guest cannot reach a VCMDQ that belongs to another VM.
at the moment a single VCMDQ is used by VM, is that a correct understanding?

Yes this general principle explanation sound very useful to me to help
the reader understand the passthrough principle.
>
>> Furthermore, what is not straightforward in this description is the
>> sequence that will be executed
>> - viommu_alloc done on which trap event?
>> - hw_queue_alloc on which trap event?
>> - mmap on guest VINT enable
>>> vIOMMU allocation. However, the logical-to-physical association between
>>> VCMDQs and a VINTF is only established after HW_QUEUE allocation. Prior
>>> to that, the mapped Page0 does not back any real VCMDQ state.
> Ok. Will capture the sequence of operations and the surrounding behaviour
> in the same top of file comment in hw/arm/tegra241-cmdqv.c.
>
> Thanks,
> Shameer
>
Thanks

Eric


