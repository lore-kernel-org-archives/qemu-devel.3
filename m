Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A109C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 04:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMK2N-0001se-3v; Wed, 26 Jun 2024 00:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sMK2L-0001pV-Hv
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 00:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sMK2J-0005v6-M2
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 00:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719375213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVkf9f84Zg6rObRBIBlD+ENxvLeBAxG6a+dRUvuJd1s=;
 b=IQEZCUtjPAPZamPA48TL0/IKD5Zlc2EdtRVqW7BJZOUKz1VxyNXoGXg5GlMMv/RJzOlrX7
 qPUZLW/ZC0Ozxe9SAYjxURyKyhQhe7TGjKTWAZTCeZuFFQKPylW6w7+jXILkGW6ZaGWfD2
 JKuTp3stJDZIxPjeOqz4mboD8D5T4bc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-fTBFi-xUN_-LzOAgVd6K4Q-1; Wed, 26 Jun 2024 00:13:31 -0400
X-MC-Unique: fTBFi-xUN_-LzOAgVd6K4Q-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-6c7e13b6a62so8196433a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 21:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719375210; x=1719980010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tVkf9f84Zg6rObRBIBlD+ENxvLeBAxG6a+dRUvuJd1s=;
 b=O0h4q1wIRh+OBKnvV2tSfKx0xgNn5TnpPk8JL0IpAuc3BP0JqtWY3CBaSbhWOEnDvc
 /1v880uDM3aUJdshU8xpZsR2CkNMkxsOdsAiRpKy8M3rjkX6abWjG8osuzTecF5uP03n
 DWsT8mOor6XqDcH8OKG70W16SfUYY47HV4Ngjvm6GTVLD6rcpnw9+dUnUR1mERF0D2/V
 VdnFrlwpv3LyyrHrRlRS8MYckpqr5ZzZiR/bTW2AjFxeSokFJyt6fu75MRxDC5IL0ua1
 GVj7yWeEoH/8zSMIZoa7ilAezz3Mh2b5iLs8y48riv73I8KPZjLbcKdNm/JBBa8/MRLv
 nfEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDtr3GoXC/zlBrnYS63WMqbkGkX2l8W/GRRNIkNNhA46S6K6M8jg1JaEpatN+CM5BeROUBoSjnolWOABaR3B1PR7iIxgk=
X-Gm-Message-State: AOJu0YzbJQYHfgwJ80dVm84j85OA3obLtCHOOJuyMoHEb+ax7DScg237
 knfTfjqSXs4tVhCCJBYdKVupASFQjBM5DqnXPI8i3OfSp30wyvodC9Xosi29bS/2AG8XzW65QvK
 v/7UgIxAlvIUhzvcbF+RZyMWI2E5iZ5xLcoyYcZ+I2ssDq1fJ0u8c
X-Received: by 2002:a05:6a20:daa2:b0:1bc:b15a:49ff with SMTP id
 adf61e73a8af0-1bcf7ff1344mr10389556637.47.1719375210288; 
 Tue, 25 Jun 2024 21:13:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjIF1fc9YxLRMOgyTvEpvCWoUQX3bzmHsEqnr6n3JwcrqyzRkOFQSgBH2x+SrTXwoYo/4S7g==
X-Received: by 2002:a05:6a20:daa2:b0:1bc:b15a:49ff with SMTP id
 adf61e73a8af0-1bcf7ff1344mr10389535637.47.1719375209856; 
 Tue, 25 Jun 2024 21:13:29 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.224])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc7cbesm89583745ad.298.2024.06.25.21.13.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 21:13:29 -0700 (PDT)
Message-ID: <b36e0d64-9653-4d48-b72a-00a1aee86629@redhat.com>
Date: Wed, 26 Jun 2024 14:13:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 0/8] Add architecture agnostic code to support vCPU
 Hotplug
To: Salil Mehta <salil.mehta@opnsrc.net>, Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 will@kernel.org, rafael@kernel.org, alex.bennee@linaro.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, npiggin@gmail.com,
 harshpb@linux.ibm.com, linuxarm@huawei.com
References: <20240529234241.205053-1-salil.mehta@huawei.com>
 <20240602180241-mutt-send-email-mst@kernel.org>
 <20240605160327.3c71f4ab@imammedo.users.ipa.redhat.com>
 <CAJ7pxeYehVhPWfbEqRMMSCVHk31JQhtQhRSM_4e1WqBhqv0UHQ@mail.gmail.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CAJ7pxeYehVhPWfbEqRMMSCVHk31JQhtQhRSM_4e1WqBhqv0UHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Salil and Igor,

On 6/26/24 9:51 AM, Salil Mehta wrote:
> On Wed, Jun 5, 2024 at 3:03 PM Igor Mammedov <imammedo@redhat.com <mailto:imammedo@redhat.com>> wrote:
>     On Sun, 2 Jun 2024 18:03:05 -0400
>     "Michael S. Tsirkin" <mst@redhat.com <mailto:mst@redhat.com>> wrote:
> 
>      > On Thu, May 30, 2024 at 12:42:33AM +0100, Salil Mehta wrote:
>      > > Virtual CPU hotplug support is being added across various architectures[1][3].
>      > > This series adds various code bits common across all architectures:
>      > >
>      > > 1. vCPU creation and Parking code refactor [Patch 1]
>      > > 2. Update ACPI GED framework to support vCPU Hotplug [Patch 2,3]
>      > > 3. ACPI CPUs AML code change [Patch 4,5]
>      > > 4. Helper functions to support unrealization of CPU objects [Patch 6,7]
>      > > 5. Docs [Patch 8]
>      > >
>      > >
>      > > Repository:
>      > >
>      > > [*] https://github.com/salil-mehta/qemu.git <https://github.com/salil-mehta/qemu.git> virt-cpuhp-armv8/rfc-v3.arch.agnostic.v12
>      > >
>      > > NOTE: This series is meant to work in conjunction with Architecture specific patch-set.
>      > > For ARM, this will work in combination of the architecture specific part based on
>      > > RFC V2 [1]. This architecture specific patch-set RFC V3 shall be floated soon and is
>      > > present at below location
>      > >
>      > > [*] https://github.com/salil-mehta/qemu/tree/virt-cpuhp-armv8/rfc-v3-rc1 <https://github.com/salil-mehta/qemu/tree/virt-cpuhp-armv8/rfc-v3-rc1>
>      > >
>      >
>      >
>      > Igor plan to take a look?
> 
>     Yep, I plan to review it
> 
> 
> A gentle reminder on this.
> 

Since the latest revision for this series is v13, so I guess Igor needs
to do the final screening on v13 instead?

v13: https://lists.nongnu.org/archive/html/qemu-arm/2024-06/msg00129.html

Thanks,
Gavin


