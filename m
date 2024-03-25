Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767B9C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojYX-0002JO-0d; Mon, 25 Mar 2024 08:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rojYV-0002IP-BT
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rojYT-0005eG-KD
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:59 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e0411c0a52so30811265ad.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711370156; x=1711974956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fI97XdXEDCdvaQoA+KSfIiFD9UwZRCBaweWdCTvgrl8=;
 b=DrLRACALH/yEmsxkVLDVQ0lcTIgiQAuKoZZyOJi0lRUO7Va1QyXEwj0ERrbczOQlsd
 MKnSlQTiEazrziKqqnGOJlkTZ7qPkawharX/VM9xqmHaOkg+AId+up1qk3B8AT3BwfQc
 4UxBfkaU8A8LkyAWtaUr/Zt2mW9oxv5cjsgteN/iLINdrLXcrP0M5QdZiyY05uH7d89V
 9UPPR+cLuMEbbeVhVMEQSXxg4Hw3edWtdXiRz6nPSgDym1+O2qLF/fWexfzH4SHwrbkf
 xU7gJE8lWn+P0JE+kQ7sBChX+jfe1GFF3J9QB9sT85jCEh9pwMFflWC6lDj5KOR6fw5H
 AP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370156; x=1711974956;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fI97XdXEDCdvaQoA+KSfIiFD9UwZRCBaweWdCTvgrl8=;
 b=toeLUN8Y+4h3rItCnIjtguFeqGnUbKOezjratqzAItpwmKqIoGAJI9n31VOlRm2twg
 pTSdoZG0Gg2XOgyi4NbCgfqCS5m1wPU3YmqnN00bQN95UttBCR2+9vLVQawGQXT6wYED
 Ffts+p/M/hjR86AvmQBzRyYlzKqAw4wrNSXUWVtzqWlCzMSCLlV08I62DS+rBHtIz/q1
 xZf9zxBnq2EgMwCTO2gThTaM9Mhi3a6Gsqm81gsCz7LwH8vwPFGCKBb2l64zEo7JfiOc
 OML6es5yy5aHlD31FV+5ImN/eAhT/ga9aFRIS0ZvUUNFYdYYkFWwX4mhUiZy+AESxbt4
 dBBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRc6wpn3UFElkWqE2g0b9FMVDUnwRvlm0IL3SpjRNNNCkN7ku4IsIda8M3t5kUa0Hff8tzxYtYYQ4+uvKpgJ/Ws9bMJo8=
X-Gm-Message-State: AOJu0YyDVs19gpD4GNN9K3UTkMqnYFstcVro0HnuGDO/B2epQ3W3YQoH
 cAvJHK46tyeYC4b4DS2VzSnAj54+vKj8OmZ1mCqf05SebA1GkcHKV+JFS4MN3Mo=
X-Google-Smtp-Source: AGHT+IGv7ZBYvvwz97T0hj9vLPV+kF+G2/6Bmak0zW5QaSjJ7ij3ZLxcxbJHCGRs9F5jXphdeSlSGw==
X-Received: by 2002:a17:902:ecc8:b0:1e0:d630:f18e with SMTP id
 a8-20020a170902ecc800b001e0d630f18emr530886plh.14.1711370156099; 
 Mon, 25 Mar 2024 05:35:56 -0700 (PDT)
Received: from [192.168.68.110] ([177.45.186.241])
 by smtp.gmail.com with ESMTPSA id
 mo12-20020a1709030a8c00b001db717d2dbbsm4575825plb.210.2024.03.25.05.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 05:35:55 -0700 (PDT)
Message-ID: <cef9c499-b258-4618-bff8-eeca8da3d184@ventanamicro.com>
Date: Mon, 25 Mar 2024 09:35:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/34] tests/libqos: add riscv/virt machine nodes
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, Greg Kurz <groug@kaod.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
 <20240308111152.2856137-21-alistair.francis@wdc.com>
 <b85c8451-57e0-49aa-a7c4-28ae8bf08bf9@redhat.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <b85c8451-57e0-49aa-a7c4-28ae8bf08bf9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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



On 3/25/24 06:20, Thomas Huth wrote:
> On 08/03/2024 12.11, Alistair Francis wrote:
>> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>
>> Add a RISC-V 'virt' machine to the graph. This implementation is a
>> modified copy of the existing arm machine in arm-virt-machine.c
>>
>> It contains a virtio-mmio and a generic-pcihost controller. The
>> generic-pcihost controller hardcodes assumptions from the ARM 'virt'
>> machine, like ecam and pio_base addresses, so we'll add an extra step to
>> set its parameters after creating it.
>>
>> Our command line is incremented with 'aclint' parameters to allow the
>> machine to run MSI tests.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>> Message-ID: <20240217192607.32565-7-dbarboza@ventanamicro.com>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
> 
>   Hi!
> 
> I noticed that "make check SPEED=slow" is now failing on the qos-test with both, qemu-system-riscv32 and qemu-system-riscv64. Seems like it fails with the virtio-9p test, when I run the qos-test manually, I get:
> 
> $ MALLOC_PERTURB_=21 V=2 QTEST_QEMU_BINARY=./qemu-system-riscv64 \
>     tests/qtest/qos-test -m slow
> ...
> # Start of local tests
> # starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-211303.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-211303.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M virt,aclint=on,aia=aplic-imsic -fsdev local,id=fsdev0,path='/home/thuth/tmp/qemu-build/qtest-9p-local-MBCML2',security_model=mapped-xattr -device virtio-9p-pci,fsdev=fsdev0,addr=04.0,mount_tag=qtest -accel qtest
> ok 168 /riscv64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/config
> Received response 7 (RLERROR) instead of 73 (RMKDIR)
> Rlerror has errno 17 (File exists)
> **
> ERROR:../../devel/qemu/tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: assertion failed (hdr.id == id): (7 == 73)
> not ok /riscv64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/create_dir - ERROR:../../devel/qemu/tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: assertion failed (hdr.id == id): (7 == 73)
> Bail out!
> Aborted (core dumped)
> 
> Could you please have a look? ... or if it is too cumbersome to fix, could we please always skip the virtio-9p local tests on riscv ?

I'll take a look.

Do we run these slow tests in the Gitlab pipeline? I don't recall this
particular test failing when I first introduced the riscv machine nodes.


Thanks,


Daniel

> 
>   Thomas
> 

