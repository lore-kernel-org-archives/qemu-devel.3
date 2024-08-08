Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D756DC52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 04:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbuZ2-0000vK-TF; Thu, 08 Aug 2024 00:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sbuZ1-0000qY-Jn
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 00:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sbuYz-00033L-Lw
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 00:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723090541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5eu43Y/hqJXwDhyW+n7+B4OTDeL2qDQ9239uQTzVyU=;
 b=cID5RCab4M0/nJANp701wlgZW8krkeizLg/8Ftx6V+LIk8wqK974G9UyCIkRwSjQBZPb1P
 O97pQWQ7SlHcm3M4tCfhktqTC4B2XpX/DTVt8bQb3ox9I+tC4BS0stxOO9BgJxfEtIIHIZ
 A0VKQ1HfwGNEelVfX36Bc+kfSGVDHjQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-vL1aNo5NPVK-qT3TxZYbOA-1; Thu, 08 Aug 2024 00:15:40 -0400
X-MC-Unique: vL1aNo5NPVK-qT3TxZYbOA-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-70d1c6b7bb4so1388786b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 21:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723090539; x=1723695339;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5eu43Y/hqJXwDhyW+n7+B4OTDeL2qDQ9239uQTzVyU=;
 b=TobHnmPN7GEIlwZfV88Q7duWyzMzS1ee6xStYJxS4qnfU1XLzqROFH4wwNV4NzJc/Y
 CF30YoADjnoa+iF6BpIqAlmAPJophvNO8mfPeD5EGyzsxAWOxG7yrXsxlJyDp54Tou1k
 m85XUXUxaT1977qimTFkvcc6pm9wQ7G3+Jl4gNpt4hGrO8BK/yh5EULR9kZOPYytfdXc
 pKj1A2ixloF26IFKM+wahnBQiLV1d3hdfUh82FR0PRVjo43GzUYy2NQSwpmDZ+jMD9Lm
 M4IVKPXVU9EuYEbTp8LoTTVpHjj5yISv384SFTPrm5ySTeGS7ITZwbVyCxegxYjfgJLs
 OglA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgjjpG7+ZGyNtiWbkfZIpHrGkY3VJPaJeMAMjWeP/sTqmckd6zwfdiafPMwutKrEGACEdq0ejL5gY8shRSrtDcy3PCDXk=
X-Gm-Message-State: AOJu0YxkWW2urZKsxNBtkL1Uqnn0QQgIIL40lZh/YI9/GnucbQVDGHW3
 BuhrCMUf1HNAqi3gkvnQ7Wh8xGni+mTPcHHYGTWZ0cETSNbYRK292QATXNUPIHdaEKVlxOxX3Cw
 FRwMdCZ5lxKSkP5eJy8TwyNVbHrOFGyrhtCLH/HdNgxE6E6ryo3GQ
X-Received: by 2002:a05:6a21:998f:b0:1c0:f630:97a5 with SMTP id
 adf61e73a8af0-1c6fd524d78mr991343637.10.1723090538877; 
 Wed, 07 Aug 2024 21:15:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPpw8I1iR6oFtXcjlIS+Ke227Hj5THAxa69aAgQv2CgX8XrxLERRoDywk6RVok8bQ9dbZ6QA==
X-Received: by 2002:a05:6a21:998f:b0:1c0:f630:97a5 with SMTP id
 adf61e73a8af0-1c6fd524d78mr991283637.10.1723090538453; 
 Wed, 07 Aug 2024 21:15:38 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb2cc93asm283195b3a.104.2024.08.07.21.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 21:15:37 -0700 (PDT)
Message-ID: <f21944c4-f498-483a-9a5a-aff2def67427@redhat.com>
Date: Thu, 8 Aug 2024 14:15:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8 Arch
From: Gavin Shan <gshan@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <41fbfa5a-a10f-4ca0-8a52-e447043ff306@redhat.com>
 <ed0a5631e0674c2aa4679f2388f40127@huawei.com>
 <5843f79d-c9b7-45bf-a2b1-2ae4c7babf46@redhat.com>
 <44d06db6ec1b416d8817b7cf5043ddf8@huawei.com>
 <c2dce623-ee44-47d5-b9cb-73481a86b75f@redhat.com>
Content-Language: en-US
In-Reply-To: <c2dce623-ee44-47d5-b9cb-73481a86b75f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Hi Salil,

On 8/8/24 10:29 AM, Gavin Shan wrote:
> On 8/8/24 9:48 AM, Salil Mehta wrote:
> 
> However, I'm unable to hot-add a vCPU and haven't get a chance to look
> at it closely.
> 
> (qemu) device_add host-arm-cpu,id=cpu,socket-id=1
> (qemu) [  258.901027] Unable to handle kernel write to read-only memory at virtual address ffff800080fa7190
> [  258.901686] Mem abort info:
> [  258.901889]   ESR = 0x000000009600004e
> [  258.902160]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  258.902543]   SET = 0, FnV = 0
> [  258.902763]   EA = 0, S1PTW = 0
> [  258.902991]   FSC = 0x0e: level 2 permission fault
> [  258.903338] Data abort info:
> [  258.903547]   ISV = 0, ISS = 0x0000004e, ISS2 = 0x00000000
> [  258.903943]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> [  258.904304]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  258.904687] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000b8e24000
> [  258.905258] [ffff800080fa7190] pgd=10000000b95b0003, p4d=10000000b95b0003, pud=10000000b95b1003, pmd=00600000b8c00781
> [  258.906026] Internal error: Oops: 000000009600004e [#1] PREEMPT SMP
> [  258.906474] Modules linked in:
> [  258.906705] CPU: 0 UID: 0 PID: 29 Comm: kworker/u8:1 Not tainted 6.11.0-rc2-gavin-gb446a2dae984 #7
> [  258.907338] Hardware name: QEMU KVM Virtual Machine, BIOS edk2-stable202402-prebuilt.qemu.org 02/14/2024
> [  258.908009] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> [  258.908401] pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [  258.908899] pc : register_cpu+0x140/0x290
> [  258.909195] lr : register_cpu+0x128/0x290
> [  258.909487] sp : ffff8000817fba10
> [  258.909727] x29: ffff8000817fba10 x28: 0000000000000000 x27: ffff0000011f9098
> [  258.910246] x26: ffff80008167b1b0 x25: 0000000000000001 x24: ffff80008153dad0
> [  258.910762] x23: 0000000000000001 x22: ffff0000ff7de210 x21: ffff8000811b9a00
> [  258.911279] x20: 0000000000000000 x19: ffff800080fa7190 x18: ffffffffffffffff
> [  258.911798] x17: 0000000000000000 x16: 0000000000000000 x15: ffff000005a46a1c
> [  258.912326] x14: ffffffffffffffff x13: ffff000005a4632b x12: 0000000000000000
> [  258.912854] x11: 0000000000000040 x10: 0000000000000000 x9 : ffff8000808a6cd4
> [  258.913382] x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefefefefefeff
> [  258.913906] x5 : ffff0000053fab40 x4 : ffff0000053fa920 x3 : ffff0000053fabb0
> [  258.914439] x2 : ffff000000de1100 x1 : ffff800080fa7190 x0 : 0000000000000002
> [  258.914968] Call trace:
> [  258.915154]  register_cpu+0x140/0x290
> [  258.915429]  arch_register_cpu+0x84/0xd8
> [  258.915726]  acpi_processor_add+0x480/0x5b0
> [  258.916042]  acpi_bus_attach+0x1c4/0x300
> [  258.916334]  acpi_dev_for_one_check+0x3c/0x50
> [  258.916689]  device_for_each_child+0x68/0xc8
> [  258.917012]  acpi_dev_for_each_child+0x48/0x80
> [  258.917344]  acpi_bus_attach+0x84/0x300
> [  258.917629]  acpi_bus_scan+0x74/0x220
> [  258.917902]  acpi_scan_rescan_bus+0x54/0x88
> [  258.918211]  acpi_device_hotplug+0x208/0x478
> [  258.918529]  acpi_hotplug_work_fn+0x2c/0x50
> [  258.918839]  process_one_work+0x15c/0x3c0
> [  258.919139]  worker_thread+0x2ec/0x400
> [  258.919417]  kthread+0x120/0x130
> [  258.919658]  ret_from_fork+0x10/0x20
> [  258.919924] Code: 91064021 9ad72000 8b130c33 d503201f (f820327f)
> [  258.920373] ---[ end trace 0000000000000000 ]---
> 

The fix [1] is needed by the guest kernel. With this, I'm able to hot add
vCPU and hot remove vCPU successfully.

[1] https://lkml.org/lkml/2024/8/8/155

Thanks,
Gavin


