Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF36BC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpvX-0004ZG-3i; Fri, 01 Aug 2025 09:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerkolothum@gmail.com>)
 id 1uhkUT-0004vf-2K; Fri, 01 Aug 2025 03:47:45 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shameerkolothum@gmail.com>)
 id 1uhkUP-0007lg-Fi; Fri, 01 Aug 2025 03:47:44 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b7862bd22bso1684153f8f.1; 
 Fri, 01 Aug 2025 00:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754034458; x=1754639258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/hhgrDa3Rfp7nxsDDwMm7UkPb2uIpO76oF4YUs3G79I=;
 b=lje7Pk+JehsxrXGVh60mpCV8OXNpIA8Fnzp//YMnfwQBkqWU9TPo8zwEi8Weo14V/E
 sUhIzVR68q/GB/u+9s+wgoHyKhaD7aWKV3GfQ2B6uhxihtXg4fuYu7csJnn6grzI7MlW
 r9didVd2cGeP47P25Zwirx0hlUAHqhrgda8pOSZzdFIo68VXeCl3oYBX9HnugQuC4SC4
 C6m16KUzXLtje0i+TRvyci4M979gSndCLoq4RHcvwJuaA3YgC4Mp/VdUqeVyF4kkKPzL
 tBlnFRJnAlWavhMPZVd4hhSJEoqSp4UcTceno2ZUaWdfTxjPQhgwoAEz6H2XWV3CrgAq
 3P6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754034458; x=1754639258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/hhgrDa3Rfp7nxsDDwMm7UkPb2uIpO76oF4YUs3G79I=;
 b=AiyPxs2HaVj1N18IS8lzLIDX/2Uml6X5liQEUG6ew7tObB1I2LYgkyRQTRQSRmmzJQ
 6xnGo7187Mo/3ThBX6s4Dcd3k6m6CzMLtfQP4RgMnFz2zyHfvrOR/LdBOuWa7bU8n6qr
 /2ASFylBErlv9R2ZMIhV+8zhOtInYPgvlUoZAsSb2XQ7dsq2xcFXDC3HhFNPtZzu/+B9
 KOonOkWfP2yy4XERehgDT4D4qXM+RLFV66FoDCQTaVwJ8wBOKqOuTNrpq7CAGZoP/CgI
 GEMBjd6KgvhAvzKWva1mquJc9mRretbAwvcT32q54pp3B/F9qxFOnth4N4h1xN8LjDKw
 ULrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUobab8t0f14d89xCftkGiUnnRuBMbS+aygb7/4wKBVPlJWvL6RrKGdmwns485XXqusN9r2iR+kj+CL@nongnu.org
X-Gm-Message-State: AOJu0YwOdRcIunkdwlZiu312/hCC7xwJcgefKPhoy7jyWYS1M1HsTWaj
 ajfiaVaBvhfB97F3bI7cdG+X5kFkoRe8nYMj2yEV/+AnGRhJyk4Byh5R4XQIaw==
X-Gm-Gg: ASbGncv3tzp0iXZJvgUIquhAEFMFwKRLk8oqKkCAFqe3jMZQBKuvwGw2NSb4hRXUbWT
 vFRTZ/cv0gE8dJi21B2IYJgWZAQ0CTQ4cAVjGBgLeV0wO+RCprke6e/rZlCt12BEH5Rm/wNgWCX
 UBXIoq23OO+SaVgZzGITvjb9s557nOWDF21/DJNee9hBcE+XnU+nmg0+0MuNuzP/IFVhwDGTMLA
 N56ErdYVXiYA8DioDtjIUCaKDoWesdeVTRaPqgBmWDdnNFwplWN2r7Z2WHrUNpecT3tdSI1viAW
 wtfz5RXJzJbrskwLdmrId7+QiHA/kXq/6ee8Zn750NuPC/ELZzhNUQuKAzNvnKvabiFfxydADCj
 nlRpjIdKAvAT7QZLnNyac4iuR6a4kLvYXsw==
X-Google-Smtp-Source: AGHT+IH4owOernztOALW2vGnR2uBjlB5NUtvfmEK2cLbZZTXzsyXnd4c0ODp4eQ236UnpBmvW+Xp9g==
X-Received: by 2002:a05:6000:220d:b0:3b7:8ba2:9818 with SMTP id
 ffacd0b85a97d-3b79d4e3419mr4732121f8f.22.1754034458044; 
 Fri, 01 Aug 2025 00:47:38 -0700 (PDT)
Received: from shameer-ubuntu ([195.11.233.227])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453ab0sm5049185f8f.44.2025.08.01.00.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 00:47:37 -0700 (PDT)
From: Shameer Kolothum <shameerkolothum@gmail.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, berrange@redhat.com, maz@kernel.org,
 oliver.upton@linux.dev, armbru@redhat.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, salil.mehta@huawei.com,
 yangjinqian1@huawei.com, shameerkolothum@gmail.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [RFC PATCH RESEND 0/4] hw/arm/virt: Add support for Target
 Implementation CPUs
Date: Fri,  1 Aug 2025 08:47:26 +0100
Message-ID: <20250801074730.28329-1-shameerkolothum@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shameerkolothum@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 01 Aug 2025 09:35:50 -0400
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

(This is my third attempt to send this series to qemu-devel / qemu-arm.
Previous attempts failed with the following errors:

qemu-arm@nongnu.org: connect to eggs.gnu.org[209.51.188.92]:25: Connection timed out  
qemu-devel@nongnu.org: connect to eggs.gnu.org[209.51.188.92]:25: Connection timed out  

I'm not sure if the issue is related to my setup, so I'm now trying to send the
patches via my Gmail account.

Apologies if you’ve already received this series individually, and thank you
for your patience.)

Hi,

On ARM64 platforms, many errata workarounds are based on CPU identification
registers, particularly MIDR_EL1 and REVIDR_EL1. Some of these errata
require corresponding fixes in the guest kernel as well. This becomes a
challenge during guest migration between hosts with different MIDR/REVIDR
values, even when the VMM provides a common baseline feature set using
the recently introduced writable ID register support.

To address this, the Linux kernel now provides:

 -A mechanism to expose implementation CPU data to guests via KVM
  hypercalls [0]:

  ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_VER_FUNC_ID
  ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_CPUS_FUNC_ID

 -A way to override implementation ID registers (MIDR, REVIDR, AIDR),
  which were previously treated as invariant [1].

What this RFC does:

This RFC enables the virt machine to specify Target Implementation CPUs
via QEMU command-line, exposing them to the guest via KVM hypercalls.

Example use case (hosts with differing MIDRs):

./qemu-system-aarch64 -machine virt,gic-version=3 \
  -enable-kvm \
  -bios QEMU_EFI.fd \
  -m 1G -smp cpus=4,maxcpus=4 \
  -cpu host \
  -M impl-cpu.0.midr=0x481fd010,impl-cpu.0.revidr=0,impl-cpu.0.aidr=0x551,\
   impl-cpu.1.midr=0x481fd011,impl-cpu.1.revidr=0,impl-cpu.1.aidr=0x551 \
  -kernel Image-6.16-rc2 \
  -initrd rootfs-iperf.cpio \
  -append "rdinit=init console=ttyAMA0 root=/dev/vda rw earlycon=pl011,0x9000000 kpti=off" \
  -net none \
  -nographic

Highlights and Notes:

 -This is based on Connie’s series[2] “kvm/arm: Introduce a customizable
  aarch64 KVM host model”.
  
 -Currently, no validation is performed on user-specified implementation CPU
  data. It’s assumed that one of the entries reflects the actual host CPU.
  If needed, a check can be added to enforce this. All other target CPU
  definitions are treated as user-driven with no internal verification.

 -For now, only the DISCOVER_IMPL_* hypercalls are supported on the QEMU side.
  See patches 1 and 3 for implementation details. These are loosely inspired
  by Salil's vCPU hotplug series patch here [3]. This may require a more
  generic approach if we have to support other SMCCC hyper calls.

 -This series uses macros and definitions from the kernel's
  include/linux/arm-smccc.h. I am not sure whether these should be duplicated 
  in QEMU or moved to a UAPI header in the kernel. For now I am carrying
  it in the test branch here,
  https://github.com/hisilicon/qemu/commit/8f583c76a2a5f60cf0f9616d61d0863e524ef388

This is lightly tested on HiSilicon ARM platforms. A complete test branch
can be found here,
https://github.com/hisilicon/qemu/tree/arm-cpu-model-rfcv3-tgt-impl-cpu-rfcv1

Please take a look and let me know.

Thanks,
Shameer

[0] https://lore.kernel.org/all/20250221140229.12588-1-shameerali.kolothum.thodi@huawei.com/
[1] https://lore.kernel.org/all/20250225005401.679536-1-oliver.upton@linux.dev/
[2] https://lore.kernel.org/qemu-devel/20250414163849.321857-1-cohuck@redhat.com/
[3] https://lore.kernel.org/qemu-devel/20240614001510.202991-1-salil.mehta@huawei.com/

Shameer Kolothum (4):
  target/arm/kvm: Introduce helper to check target impl CPU support
  target/arm/kvm: Add QAPI struct ArmTargetImplCPU
  target/arm/kvm: Handle KVM Target Imp CPU hypercalls
  hw/arm/virt: Add Target Implementation CPU support

 hw/arm/virt.c         |  66 +++++++++++++++
 include/hw/arm/virt.h |   3 +
 qapi/machine.json     |  34 ++++++++
 target/arm/kvm.c      | 187 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h  |  20 +++++
 5 files changed, 310 insertions(+)

-- 
2.34.1


