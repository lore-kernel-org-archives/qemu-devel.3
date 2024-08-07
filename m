Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455B3C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 09:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbdMy-00049M-D4; Wed, 07 Aug 2024 05:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sbdMw-00047p-F5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sbdMu-0003v1-Vd
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723024445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4rEUNvnBbG0xbJ2RrHigmSaZpS34ff5WQDm5mZqVP0=;
 b=WOBAZ6dSg8uK6KtKkrNCY8ANIQ5zmUnE8qsJKi+v4akmAuFHuwZ+6QwJHgbtxXnV4qu977
 bv74rt2Y01gFbLbbgT8+BbG8n+brAjkJsPoOc/iXWUUky74F3KhGgDSyuNAdDsnwZp52hN
 wzU7k7pBEt6iyH8zT4NmvMy+6mOm/+Q=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Kil8Ag2QMCyXrjaJB4G9zw-1; Wed, 07 Aug 2024 05:54:03 -0400
X-MC-Unique: Kil8Ag2QMCyXrjaJB4G9zw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7b544c7f7b3so1579799a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 02:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723024443; x=1723629243;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c4rEUNvnBbG0xbJ2RrHigmSaZpS34ff5WQDm5mZqVP0=;
 b=s72Tid51eQc7JVvnWdsnbkAuQFi/OxbHDXNb9ywt6Cna8F1/TNYLL9cp11D7AG4oR2
 q9H1Oq+Ttxk3kRa+RCk/jkSdOEU9aGbGhrMd14IhkI6BdqhzUKirpfD0lUNt26B3YVA7
 80dEokU3m6Rjy2UDQFVfuhTwnXGAQ4LLwdP4EYpTbaEstRdX0xxgCgcSRZYYoUYefc0v
 4kLqGuGWX1lGEPtF1IqwT3kAUz5SE45BIvBl9kfuivs23PMmu58tOI1VrwK72XTZ5Q/N
 tBIja4I4BthzSqyl6fJxjvRnQJziWegvQNlSXY3HIltK1ciokzIKojXBPRKS8Oc9+yKz
 BS8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg1kSlZVPGO6ux8ZHo1gwwSg5E1gZTs77pUU4HphLmvfirDYSYwQJc+zorQQ51kEvCo1Ilaf7oVdgOPiS+Eh9agErrZvA=
X-Gm-Message-State: AOJu0Yxz0vcIaDPiDY5STMUS0hkoOFH2xh2lPNLgJEtm2PeuENMJ95uW
 j7O+DF4qEIBWsAIFhCfOHYD7+L2phb1rC9DMfhUwWUDFkqY74EKy5vCwfUdnDxLBCo7oEFnyrlC
 m1108Rm0F7Cv+eFqECVK62sU9rEDXoCfNV7gZQvUgT4BKbL+aYMGL
X-Received: by 2002:a05:6a21:7881:b0:1c4:a5fe:321b with SMTP id
 adf61e73a8af0-1c6995820ccmr25736545637.18.1723024442656; 
 Wed, 07 Aug 2024 02:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrxY7oThqUer/XGccL9k8b/SIvL3kCEP7q+irjg7xBFLpFqzsRmBXPKOv9eqH5JTf2YOnO9Q==
X-Received: by 2002:a05:6a21:7881:b0:1c4:a5fe:321b with SMTP id
 adf61e73a8af0-1c6995820ccmr25736524637.18.1723024442176; 
 Wed, 07 Aug 2024 02:54:02 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed30840sm8061372b3a.210.2024.08.07.02.53.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 02:54:01 -0700 (PDT)
Message-ID: <41fbfa5a-a10f-4ca0-8a52-e447043ff306@redhat.com>
Date: Wed, 7 Aug 2024 19:53:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8 Arch
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com,
 zhao1.liu@intel.com, linuxarm@huawei.com
References: <20240613233639.202896-1-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240613233639.202896-1-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

With this series and latest upstream Linux kernel (host), I ran into core dump as below.
I'm not sure if it's a known issue or not.

# uname -r
6.11.0-rc2-gavin+
# /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64 -accel kvm \
   -machine virt,gic-version=host,nvdimm=on -cpu host                 \
   -smp maxcpus=2,cpus=1,sockets=2,clusters=1,cores=1,threads=1       \
   -m 4096M,slots=16,maxmem=128G                                      \
   -object memory-backend-ram,id=mem0,size=2048M                      \
   -object memory-backend-ram,id=mem1,size=2048M                      \
   -numa node,nodeid=0,memdev=mem0,cpus=0-0                           \
   -numa node,nodeid=1,memdev=mem1,cpus=1-1                           \
     :
qemu-system-aarch64: Failed to initialize host vcpu 1
Aborted (core dumped)

# gdb /var/lib/systemd/coredump/core.0 /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64
(gdb) bt
#0  0x0000ffff9eec42e8 in __pthread_kill_implementation () at /lib64/libc.so.6
#1  0x0000ffff9ee7c73c in raise () at /lib64/libc.so.6
#2  0x0000ffff9ee69034 in abort () at /lib64/libc.so.6
#3  0x0000aaaac71152c0 in kvm_arm_create_host_vcpu (cpu=0xaaaae4c0cb80)
     at ../target/arm/kvm.c:1093
#4  0x0000aaaac7057520 in machvirt_init (machine=0xaaaae48198c0) at ../hw/arm/virt.c:2534
#5  0x0000aaaac6b0d31c in machine_run_board_init
     (machine=0xaaaae48198c0, mem_path=0x0, errp=0xfffff754ee38) at ../hw/core/machine.c:1576
#6  0x0000aaaac6f58d70 in qemu_init_board () at ../system/vl.c:2620
#7  0x0000aaaac6f590dc in qmp_x_exit_preconfig (errp=0xaaaac8911120 <error_fatal>)
     at ../system/vl.c:2712
#8  0x0000aaaac6f5b728 in qemu_init (argc=82, argv=0xfffff754f1d8) at ../system/vl.c:3758
#9  0x0000aaaac6a5315c in main (argc=82, argv=0xfffff754f1d8) at ../system/main.c:47

Thanks,
Gavin


