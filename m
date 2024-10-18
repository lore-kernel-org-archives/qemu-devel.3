Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C96D30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oFW-0007vp-MI; Fri, 18 Oct 2024 10:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t1oFT-0007mR-1D
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t1oFR-0002wh-4K
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dr4lak5IERRTFNRFjxYnCwZFdfA+aOpOjEHMGekPVRY=;
 b=Mc0pBvf9o8dFC17ZT1mGmFDa4oV02uKoweiXvqG0x5hXU/vAASWarPs9XouzXdOeH/1719
 jHRKOB/ZPtJKlS9o4rSCJZbiqWrmB5FYogNPEiDu7NhEzMSwz1nDAQn8OeL7nTNRg/+AB5
 YPRgdSp3gZJMToE9Q70XnKdi0Riq7Gs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-9eT_E69GP1KHIPyIgfqA1w-1; Fri, 18 Oct 2024 10:46:35 -0400
X-MC-Unique: 9eT_E69GP1KHIPyIgfqA1w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4314c6ca114so16221035e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262793; x=1729867593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dr4lak5IERRTFNRFjxYnCwZFdfA+aOpOjEHMGekPVRY=;
 b=gIFAz5VKp/aNqV7rX6BIGLriKqggAkRQQisb35Y+6pzTzRNZHl9t6CdbZaRrTRsSqe
 ZjWYz7sF1V+27Ix5aOotr20skgWinyClHr89tKkalW37UEtJYMPINoprqNsmSK+6i6OO
 1yllAMeefD8EVLTeFMA7mepEeeFFNWP15wrwxoS/eK1ELTv8hiOERQ2y58LN0pormXaI
 AnFMYHlipbdANwFlixDN5Zo4K2fIwcHUXtJ1j0HeXjPfVm+KDAFCx5GkdnAtIZPjQcuS
 5jKLAuq4H+pDgvu8VbASOlPdNNkx+3RghJznQ18w4wfDIAT9mRvFpIIyvF83bAwzqpn0
 7Ysg==
X-Gm-Message-State: AOJu0YwsEMkzLQibr0+MuVwxI7TVFxHMEJk/2Vtc+sDyQep/DMO4bBdw
 rQFUq9pyzIEfumvaFQIceyGahVzCrag8ZmkXiE80aSqXHPuZL242u8R9uxgm6EbQmWsUFL41KcI
 o6OHsVwGyk2NJzvF2SYrfsFwt8AEaIPf8Ut9d2pWpRR5NhUqrQ5v1tSnsszLT
X-Received: by 2002:a05:600c:5489:b0:431:52b7:a499 with SMTP id
 5b1f17b1804b1-4316164da71mr21633435e9.20.1729262792677; 
 Fri, 18 Oct 2024 07:46:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeqO/MQ9TzOKYw0WwNxw7r9PkbIop3OIRWctO1fsP+bHNu0jADjNYjEiOE6tNCXFtna/nHfQ==
X-Received: by 2002:a05:600c:5489:b0:431:52b7:a499 with SMTP id
 5b1f17b1804b1-4316164da71mr21633265e9.20.1729262792205; 
 Fri, 18 Oct 2024 07:46:32 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43160e445ddsm25955015e9.38.2024.10.18.07.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:46:31 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:46:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <andrew.jones@linux.dev>, <david@redhat.com>, <philmd@linaro.org>,
 <eric.auger@redhat.com>, <will@kernel.org>, <ardb@kernel.org>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <gshan@redhat.com>,
 <rafael@kernel.org>, <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>,
 <npiggin@gmail.com>, <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <shahuang@redhat.com>, <zhao1.liu@intel.com>,
 <linuxarm@huawei.com>, <gustavo.romero@linaro.org>
Subject: Re: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU
 Hotplug (on Archs like ARM)
Message-ID: <20241018164629.2939b711@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241014192205.253479-1-salil.mehta@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 14 Oct 2024 20:22:01 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> Certain CPU architecture specifications [1][2][3] prohibit changes to the=
 CPUs
> *presence* after the kernel has booted. This is because many system
> initializations depend on the exact CPU count at boot time and do not exp=
ect it
> to change afterward. For example, components like interrupt controllers t=
hat are
> closely coupled with CPUs, or various per-CPU features, may not support
> configuration changes once the kernel has been initialized.
>=20
> This requirement poses a challenge for virtualization features like vCPU
> hotplug. To address this, changes to the ACPI AML are necessary to update=
 the
> `_STA.PRES` (presence) and `_STA.ENA` (enabled) bits accordingly during g=
uest
> initialization, as well as when vCPUs are hot-plugged or hot-unplugged. T=
he
> presence of unplugged vCPUs may need to be deliberately *simulated* at th=
e ACPI
> level to maintain a *persistent* view of vCPUs for the guest kernel.

the series is peppered with *simulated* idea, which after looking at code
I read as 'fake'. While it's obvious to author why things need to be faked
at this time, it will be forgotten later on. And cause a lot swearing from
whoever will have to deal with this code down the road.

Salil, I'm sorry that review comes out as mostly negative but for me having=
 to
repeat 'simulated' some many times, hints that the there is
something wrong with design and that we should re-evaluate the approach.

ps:
see comments on 1/4 for suggestions


> This patch set introduces the following features:
>=20
> 1. ACPI Interface with Explicit PRESENT and ENABLED CPU States: It allows=
 the
>    guest kernel to evaluate these states using the `_STA` ACPI method.
>   =20
> 2. Initialization of ACPI CPU States: These states are initialized during
>    `machvirt_init` and when vCPUs are hot-(un)plugged. This enables hotpl=
uggable
>    vCPUs to be exposed to the guest kernel via ACPI.
>=20
> 3. Support for Migrating ACPI CPU States: The patch set ensures the migra=
tion of
>    the newly introduced `is_{present,enabled}` ACPI CPU states to the
>    destination VM.
>=20
> The approach is flexible enough to accommodate ARM-like architectures that
> intend to implement vCPU hotplug functionality. It is suitable for archit=
ectures
> facing similar constraints to ARM or those that plan to implement vCPU
> hotplugging independently of hardware support (if available).
>=20
> This patch set is derived from the ARM-specific vCPU hotplug implementati=
on [4]
> and includes migration components adaptable to other architectures, follo=
wing
> suggestions [5] made by Igor Mammedov <imammedo@redhat.com>.
>=20
> It can be applied independently, ensuring compatibility with existing hot=
plug
> support in other architectures. I have tested this patch set in conjuncti=
on with
> the ARM-specific vCPU hotplug changes (included in the upcoming RFC V5 [6=
]), and
> everything worked as expected. I kindly request maintainers of other
> architectures to provide a "Tested-by" after running their respective reg=
ression
> tests.
>=20
> Many thanks!
>=20
>=20
> References:
> [1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt C=
PU Hotplug on
>     architectures that don=E2=80=99t Support CPU Hotplug (like ARM64)
>     a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug=
_7OJ1YyJ.pdf
>     b. Qemu Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_i=
n_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
> [2] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU Hotp=
lug on
>     SoC Based Systems (like ARM64)
>     Link: https://kvmforum2020.sched.com/event/eE4m
> [3] Check comment 5 in the bugzilla entry
>     Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3D4481#c5
> [4] [PATCH RFC V4 00/33] Support of Virtual CPU Hotplug for ARMv8 Arch
>     Link: https://lore.kernel.org/qemu-devel/20241009031815.250096-1-sali=
l.mehta@huawei.com/T/#mf32be203baa568a871dc625b732f666a4c4f1e68
> [5] Architecture agnostic ACPI VMSD state migration (Discussion)
>     Link: https://lore.kernel.org/qemu-devel/20240715155436.577d34c5@imam=
medo.users.ipa.redhat.com/
> [6] Upcoming RFC V5, Support of Virtual CPU Hotplug for ARMv8 Arch
>     Link: https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rf=
c-v5
>=20
> Salil Mehta (4):
>   hw/acpi: Initialize ACPI Hotplug CPU Status with Support for vCPU
>     `Persistence`
>   hw/acpi: Update ACPI CPU Status `is_{present, enabled}` during vCPU
>     hot(un)plug
>   hw/acpi: Reflect ACPI vCPU {present,enabled} states in ACPI
>     _STA.{PRES,ENA} Bits
>   hw/acpi: Populate vCPU Hotplug VMSD to migrate `is_{present,enabled}`
>     states
>=20
>  cpu-target.c         patches.vcpuhp.rfc-v5.arch.agnostic.acpi          |=
  1 +
>  hw/acpi/cpu.c                  | 70 +++++++++++++++++++++++++++++++---
>  hw/acpi/generic_event_device.c | 11 ++++++
>  include/hw/acpi/cpu.h          | 21 ++++++++++
>  include/hw/core/cpu.h          | 21 ++++++++++
>  5 files changed, 119 insertions(+), 5 deletions(-)
>=20


