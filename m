Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6677C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 23:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbqHd-0005c0-AW; Wed, 07 Aug 2024 19:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sbqHa-0005Zd-Da
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sbqHY-0000N7-Jd
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723074086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OK8o6LiB64gg3rbZ44dTktT1nC/tX//oU09+DhB7ekQ=;
 b=RTmnRkO2YjLlEb/w35iLPawhFTv0r54kJQ6Xny43kfVpxeu4q6bVzyeEUO9B6PBoBABfWV
 eN5ECc4GLnl43qfb4QbqeT9LL+u3kLghyQb6h7QRPe4lOcaxdE0GDSu+3gALR2fLYkNwbv
 8fCwDcWVyz399ZgakRKSdokLnPgO1VU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-oPaNfRSOPQWhJc9MuHFJNA-1; Wed, 07 Aug 2024 19:41:24 -0400
X-MC-Unique: oPaNfRSOPQWhJc9MuHFJNA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1fc4e03a885so4067515ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 16:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723074083; x=1723678883;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OK8o6LiB64gg3rbZ44dTktT1nC/tX//oU09+DhB7ekQ=;
 b=jCT2kfAMcgoi+BATc6YlkCQ1nwXKnfMMFStyPmt6fYIJ3oz7hDSIhCbNr8EQ+C2Gdn
 QhEK3F4rzgcu08ZUH4mE6FeoAbEObJJFE3so+VIXy8FQuxBRxfpSDGNMspFrOMDrSQWr
 WjYjVqCE6Orfd8Wqk+rlsWofQuugoyW2jlmq5lbRIAtDHndB8KShh715I0A0HDjKskFH
 g2huTQMyK1dhGxiREqDofI6XPpxlwaEAEOWJY7aYijw09htKHOelbK55Sne4vSkeeAIp
 kYGNj0KsjPlZt8aj4YbxUbJWd02DzhjpCSvxym6QujYniaod0EoED1xd0M6vay8rviAp
 BPWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/AUz4lmW0QFtU/+JWSf2QUQ7XNlKrhZ2s8HJbrWMpUvWIYIUUSMCwzhXEgnvxo9hUuRElwT/J1Ya7qKEOGwv/7jkxlos=
X-Gm-Message-State: AOJu0YxGUvTnSG/UixMWmRoXsDK55F0lQnKQaosMizuwwdZnLfnvmsFj
 lUXLMipq3+yFYNDngFOx7CBAHdiDf8QelhUCvX0GSGGhq3/JDCvUNvaEGyTb+36t4lYgcBRCCHq
 VEh+/s7csHtzafHvHSXqmFDP9ko7ZOtkHDlPS9bmL002rZl8objPU
X-Received: by 2002:a17:902:ced1:b0:1fd:ac9f:4050 with SMTP id
 d9443c01a7336-200952641a4mr2890885ad.35.1723074083333; 
 Wed, 07 Aug 2024 16:41:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuwyoUsnYwAcqHP0YHHzVZTMLIOnpvQ4pbNRgi9++WdCzDOyS8IbyGr+Lw7+5vsxxg+5Z/tg==
X-Received: by 2002:a17:902:ced1:b0:1fd:ac9f:4050 with SMTP id
 d9443c01a7336-200952641a4mr2890515ad.35.1723074082876; 
 Wed, 07 Aug 2024 16:41:22 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5917a466sm111773785ad.220.2024.08.07.16.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 16:41:21 -0700 (PDT)
Message-ID: <5843f79d-c9b7-45bf-a2b1-2ae4c7babf46@redhat.com>
Date: Thu, 8 Aug 2024 09:41:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8 Arch
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ed0a5631e0674c2aa4679f2388f40127@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/7/24 11:27 PM, Salil Mehta wrote:
> 
> Let me figure out this. Have you also included the below patch along with the
> architecture agnostic patch-set accepted in this Qemu cycle?
> 
> https://lore.kernel.org/all/20240801142322.3948866-3-peter.maydell@linaro.org/
>  

There are no vCPU fd to be parked and unparked when the core dump happenes. I
tried it, but didn't help. I added more debugging messages and the core dump is
triggered in the following path. It seems 'cpu->sve_vq.map' isn't correct since
it's populated in CPU realization path, and those non-cold-booted CPUs aren't
realized in the booting stage.

# dmesg | grep "Scalable Vector Extension"
[    0.117121] CPU features: detected: Scalable Vector Extension

# start_vm
===> machvirt_init: create CPU object (idx=0, type=[host-arm-cpu])
cpu_common_initfn
arm_cpu_initfn
aarch64_cpu_initfn
aarch64_cpu_instance_init
aarch64_host_initfn
arm_cpu_post_init
===> machvirt_init: realize CPU object (idx=0)
virt_cpu_pre_plug
arm_cpu_realizefn
cpu_common_realizefn
virt_cpu_plug
===> machvirt_init: create CPU object (idx=1, type=[host-arm-cpu])
cpu_common_initfn
arm_cpu_initfn
aarch64_cpu_initfn
aarch64_cpu_instance_init
aarch64_host_initfn
arm_cpu_post_init
kvm_arch_init_vcpu: Error -22 from kvm_arm_sve_set_vls()
qemu-system-aarch64: Failed to initialize host vcpu 1
Aborted (core dumped)

Thanks,
Gavin

>>   
>>   With this series and latest upstream Linux kernel (host), I ran into core
>>   dump as below.
>>   I'm not sure if it's a known issue or not.
>>   
>>   # uname -r
>>   6.11.0-rc2-gavin+
>>   # /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64 -accel
>>   kvm \
>>      -machine virt,gic-version=host,nvdimm=on -cpu host                 \
>>      -smp maxcpus=2,cpus=1,sockets=2,clusters=1,cores=1,threads=1       \
>>      -m 4096M,slots=16,maxmem=128G                                      \
>>      -object memory-backend-ram,id=mem0,size=2048M                      \
>>      -object memory-backend-ram,id=mem1,size=2048M                      \
>>      -numa node,nodeid=0,memdev=mem0,cpus=0-0                           \
>>      -numa node,nodeid=1,memdev=mem1,cpus=1-1                           \
>>        :
>>   qemu-system-aarch64: Failed to initialize host vcpu 1 Aborted (core
>>   dumped)
>>   
>>   # gdb /var/lib/systemd/coredump/core.0
>>   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64
>>   (gdb) bt
>>   #0  0x0000ffff9eec42e8 in __pthread_kill_implementation () at
>>   /lib64/libc.so.6
>>   #1  0x0000ffff9ee7c73c in raise () at /lib64/libc.so.6
>>   #2  0x0000ffff9ee69034 in abort () at /lib64/libc.so.6
>>   #3  0x0000aaaac71152c0 in kvm_arm_create_host_vcpu
>>   (cpu=0xaaaae4c0cb80)
>>        at ../target/arm/kvm.c:1093
>>   #4  0x0000aaaac7057520 in machvirt_init (machine=0xaaaae48198c0) at
>>   ../hw/arm/virt.c:2534
>>   #5  0x0000aaaac6b0d31c in machine_run_board_init
>>        (machine=0xaaaae48198c0, mem_path=0x0, errp=0xfffff754ee38) at
>>   ../hw/core/machine.c:1576
>>   #6  0x0000aaaac6f58d70 in qemu_init_board () at ../system/vl.c:2620
>>   #7  0x0000aaaac6f590dc in qmp_x_exit_preconfig (errp=0xaaaac8911120
>>   <error_fatal>)
>>        at ../system/vl.c:2712
>>   #8  0x0000aaaac6f5b728 in qemu_init (argc=82, argv=0xfffff754f1d8) at
>>   ../system/vl.c:3758
>>   #9  0x0000aaaac6a5315c in main (argc=82, argv=0xfffff754f1d8) at
>>   ../system/main.c:47
>>   
>>   Thanks,
>>   Gavin
>>   
> 


