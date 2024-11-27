Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259EDD6ACEF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 16:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGKYV-00004v-Br; Wed, 27 Nov 2024 11:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tGKYP-0008W0-Ov
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:06:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tGKYN-0003iP-Pc
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732723567;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1rm5q7Jhe5OX3T1GOSaNBMS2MXoyvUvbnryuxez01A=;
 b=Kek1hndsYRSxvJ174RHg2Vcm/JdL32eANlyXMNdXp52J+KgV2hPTBMw3oWCc6nZvbktkjs
 Jgs3BEBGTLfhCrO0QogjlkPOp3AjiDDmoGnMeYfCB98dUE6kDxatUfAd3aNRsgUdJyKkF2
 eC66QEqU8r/r4nMhkxFgFcj29v4J9Ro=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-O0a1MHRgMLGUtKqy81jQ4Q-1; Wed, 27 Nov 2024 11:06:05 -0500
X-MC-Unique: O0a1MHRgMLGUtKqy81jQ4Q-1
X-Mimecast-MFC-AGG-ID: O0a1MHRgMLGUtKqy81jQ4Q
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-434a467e970so18271695e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 08:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732723564; x=1733328364;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W1rm5q7Jhe5OX3T1GOSaNBMS2MXoyvUvbnryuxez01A=;
 b=H5+0IuXQnM0juNNm1qNEB8Ia+hVFbXqBbwRfO05tGWivB8LU3jn+5ddhZFfyk/qlig
 D+GPMbhEljMManX05FA4hQhc5URbjOAzRtiJQlZaAUiCURHkLTfV7jbpCwAxGOVFFm6F
 dtfYi8bigFSd3PRWCg4ei5N4iEc8XyUXvHNPTCoheuHOoWm5GJ+jtjmQRT3AdAu0mhqb
 mc0i65ujrAE3oSX6lBVBblqcLREbtAPcX1q5/Icci/RjKHS1rKQq5ay+eqgo/AOANqFi
 g8hAtcsa08vcEoCeb2Wv5DgGKdrOi4nPjRpcdNMCgRHxqmprCXqIik7200kL4THK+af8
 KKag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKrBJ+H66MvaCY9KE5GwfEXCPGyNoPec2YLpiAphDSd4vNT/wY8FlKt92C/7C+QfkPf12O6AhH8Cik@nongnu.org
X-Gm-Message-State: AOJu0Yxjmrk/XZiL2fiuRDUEC9A08Tx9Hx2iTz/Lq3LZMw5q/yhPG1vp
 L92MR0b/Bt/0BLHc/BfR2yoK13d36S7j+uAfzK3pcAdX/rnFSDkQdE2CeM9q+G19gm7hCl9LCfe
 vjI/ip5wLDM/2JUbBwZz9mxt8Nz5e45J0icyXJHj/BkiAjXXgAVop
X-Gm-Gg: ASbGncv0prvR0F1xejOSIIa2wBYgP95fWLVhIDnlBxNkSxrVtYVSo4+ughWQpc742UX
 ERVdeaHX1edPQtoi2y+kzWlCI9/3ByIN90UlPM/1S/y7UYspFBryWa4LzwMi8bWYZFFdo9Czj6C
 wGu+DEhpwrg83Nf9vBEauObfcGnQyOw/uq6G35mRfVmXNyMdK4LKi2ybs78qtLbe5wzAXBupvs2
 oBODohHLP81nr9WgFovQdfl02bUBSOQ8t9kFqpftelLxg2rW7l7GlSA9ACticIFs/mikmQp5TC4
 ADHeWrPRvNvc+pR8D5lelA==
X-Received: by 2002:a05:6000:4007:b0:37d:50e1:b3d3 with SMTP id
 ffacd0b85a97d-385c6ebb9bamr3328791f8f.20.1732723564063; 
 Wed, 27 Nov 2024 08:06:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHPDGn8rg4XiXZ96n4hlzC1UzqkLr/bkgh2a/ksHfQ76I+9n+jqQ28o4EszZCKq24pTkKjzg==
X-Received: by 2002:a05:6000:4007:b0:37d:50e1:b3d3 with SMTP id
 ffacd0b85a97d-385c6ebb9bamr3328554f8f.20.1732723562110; 
 Wed, 27 Nov 2024 08:06:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad60c3sm17099524f8f.2.2024.11.27.08.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 08:06:01 -0800 (PST)
Message-ID: <bd4c4665-148c-427b-8717-457c584fb233@redhat.com>
Date: Wed, 27 Nov 2024 17:05:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Donald Dutile <ddutile@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
 <20241127160031.GA1253388@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20241127160031.GA1253388@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/27/24 17:00, Jason Gunthorpe wrote:
> On Wed, Nov 27, 2024 at 10:21:24AM +0000, Shameerali Kolothum Thodi wrote:
>>> For SMMUv3, NVIDIA-specific vCMDQ, it needs a parameter to state that
>>> specifically,
>>> since I'm concluding from reading the SMMUv3 version G.a spec, that
>>> ECMDQ was added
>>> to be able to assign an ECMDQ to a VM,
>> Not sure the intention of ECMDQ as per that specification is to assign
>> it to a VM. I think the main idea behind it is to have one Command Queue 
>> per host CPU to eliminate lock contention while submitting commands
>> to SMMU.
> Right
>
>> AFAIK it is not safe to assign one of the ECMDQ to guest yet. I think there is no
>> way you can associate a VMID with ECMDQ. So there is no plan to
>> support ARM ECMDQ now.
> Yep
>
>> NVIDIA VCMDQ is a completely vendor specific one. Perhaps ARM may come
>> up with an assignable CMDQ in future though.
> Yes, it is easy to imagine an ECMDQ extension that provides the same HW
> features that VCMDQ has in future. I hope ARM will develop one.
>
>>> ... and all needs to be per-instance ....
>>> ... libvirt  (or any other VMM orchestrator) will need to determine
>>> compatibility for
>>>      live migration. e.g., can one live migrate an accel=nv-vcmdq-based VM to
>>> a host with
>>>      accel=ecmdq support?  only nv-vcmdq?  what if there are version diffs of
>>> nv-vcmdq over time?
>>>      -- apologies, but I don't know the minute details of nv-vcmdq to
>>> determine if that's unlikely or not.
>> Yes. This require more thought. But our first aim is get the basic smmuv3-accel
>> support.
> Yeah, there is no live migration support yet in the SMMU qmeu driver,
> AFAIK?
the non accelerated SMMU QEMU device does support migration.

Eric
>
> When it gets done the supported options will have to be considered
>
> Jason
>


