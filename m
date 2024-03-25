Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B4FC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rogV6-0001Wj-Ny; Mon, 25 Mar 2024 05:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rogV4-0001Va-Sn
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rogV1-0003Wf-AS
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711358409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xUBBVKat0wVjzCF9R4YicTq0Hje1mkgKosLVi6BxG0s=;
 b=WEFfScEAqQ+1qtd3CRpYBXutXyVLffly20f1mGYLUTQ8l2O71AEA/2zf7LDJpwp5Xi6Vno
 QMNoowwg1zV9nRyBdMb5kGfgS11y0wB0Z2GypqqSEQEEVhbEWkcJjUkgf3pQORnRWSZU0X
 EbxBqsrgjPaD4V9YvK2/oBA7Fwt5OKo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-UEfnANAlPBmaVzvbzobtVQ-1; Mon, 25 Mar 2024 05:20:08 -0400
X-MC-Unique: UEfnANAlPBmaVzvbzobtVQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41467d63b1eso22694425e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 02:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711358407; x=1711963207;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUBBVKat0wVjzCF9R4YicTq0Hje1mkgKosLVi6BxG0s=;
 b=pqnrjpZwCGTpkIdyRcuW/vfjdHkecAJR6CaADbSZGUY8A1jfNztrJq2D2bE8FWVAn/
 VRSMgwRLAKljuNy6SW0IcVd2aktREhst8VRF2agTrgclmI8d3fC06Gp9C6JXhvFGxEkV
 WYDQJwzMy04yzSS823N80fJYyfxIBcKTRAnevZ74B5ci20Ok6luBQYoFKy2EN/+TQaFn
 rnTfuodUqlAEKrZn1A+uBho93t4lRfMhGop/IsZZkavw92G6loWXmG55Fl4f4Z2bQNHJ
 d103SysNctYkvajfYThChCn4G1zlgkWLhSZBCLvBlKeWwS+EpEpchqBcu0p10VE6BGuK
 QHFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzyyHlOUTgQGrxaqsZx+npVep0ZmdoBSoA1wy9gE+5ROCCwD2G9uRFBeVxgto4YYgjaKGQnywx4wPzqyT7H0UF/1U6qK8=
X-Gm-Message-State: AOJu0Yzp3+blJk4a8Ojdu7c8W+fv22nOjsUl7dgChaw0G+mvdfFNln7S
 wiw6AW+3VOQgAEIcBfy6G1RoSKM5g23cqySjTvXUnfQMKDCl9fThm1aNljvGk8ODc2x2OweIeQo
 vxuYSo4CljiY4+I7ZJJwRi/I7lluXzVu+zLF1e0SLesY0aThEmZSs
X-Received: by 2002:a05:600c:5492:b0:412:efc8:299b with SMTP id
 iv18-20020a05600c549200b00412efc8299bmr4718228wmb.39.1711358406500; 
 Mon, 25 Mar 2024 02:20:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2xfi7B4oIoqmUhogOwu/xTn9R4K3JrVgx9/G/aDrycyGQfZo8+SvloQGN8nzrGhD0IMFHKw==
X-Received: by 2002:a05:600c:5492:b0:412:efc8:299b with SMTP id
 iv18-20020a05600c549200b00412efc8299bmr4718207wmb.39.1711358406189; 
 Mon, 25 Mar 2024 02:20:06 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-176-158.web.vodafone.de.
 [109.43.176.158]) by smtp.gmail.com with ESMTPSA id
 s8-20020a05600c45c800b0041487f70d9fsm4239916wmo.21.2024.03.25.02.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 02:20:05 -0700 (PDT)
Message-ID: <b85c8451-57e0-49aa-a7c4-28ae8bf08bf9@redhat.com>
Date: Mon, 25 Mar 2024 10:20:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/34] tests/libqos: add riscv/virt machine nodes
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, Greg Kurz <groug@kaod.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
 <20240308111152.2856137-21-alistair.francis@wdc.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240308111152.2856137-21-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 08/03/2024 12.11, Alistair Francis wrote:
> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> Add a RISC-V 'virt' machine to the graph. This implementation is a
> modified copy of the existing arm machine in arm-virt-machine.c
> 
> It contains a virtio-mmio and a generic-pcihost controller. The
> generic-pcihost controller hardcodes assumptions from the ARM 'virt'
> machine, like ecam and pio_base addresses, so we'll add an extra step to
> set its parameters after creating it.
> 
> Our command line is incremented with 'aclint' parameters to allow the
> machine to run MSI tests.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Message-ID: <20240217192607.32565-7-dbarboza@ventanamicro.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

  Hi!

I noticed that "make check SPEED=slow" is now failing on the qos-test with 
both, qemu-system-riscv32 and qemu-system-riscv64. Seems like it fails with 
the virtio-9p test, when I run the qos-test manually, I get:

$ MALLOC_PERTURB_=21 V=2 QTEST_QEMU_BINARY=./qemu-system-riscv64 \
    tests/qtest/qos-test -m slow
...
# Start of local tests
# starting QEMU: exec ./qemu-system-riscv64 -qtest 
unix:/tmp/qtest-211303.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-211303.qmp,id=char0 -mon chardev=char0,mode=control 
-display none -audio none -M virt,aclint=on,aia=aplic-imsic -fsdev 
local,id=fsdev0,path='/home/thuth/tmp/qemu-build/qtest-9p-local-MBCML2',security_model=mapped-xattr 
-device virtio-9p-pci,fsdev=fsdev0,addr=04.0,mount_tag=qtest -accel qtest
ok 168 
/riscv64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/config
Received response 7 (RLERROR) instead of 73 (RMKDIR)
Rlerror has errno 17 (File exists)
**
ERROR:../../devel/qemu/tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: 
assertion failed (hdr.id == id): (7 == 73)
not ok 
/riscv64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/create_dir 
- 
ERROR:../../devel/qemu/tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: 
assertion failed (hdr.id == id): (7 == 73)
Bail out!
Aborted (core dumped)

Could you please have a look? ... or if it is too cumbersome to fix, could 
we please always skip the virtio-9p local tests on riscv ?

  Thomas


