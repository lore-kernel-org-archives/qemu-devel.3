Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C504BC27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErEq-0005Mf-Rr; Wed, 05 Jun 2024 10:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sErEp-0005LU-Gq
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sErEn-00022L-1q
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717596215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y7PR6GhNAef0DuVtjtWgjtfLtJjuA5O3jhHy8g7gxVM=;
 b=TKjx9M6XqnTymvfwsV3pSerI3Py/bJHMpIzrRhkXOCM/yGFB8jtTsAE92YgjOz9ya5j1CP
 Y81jnq7UjTnuJ5ZUC2J9hzIBRSZZ+zoer4O7BQ68yI8pGnbT/54mNjCa8y4N5vfInSfodB
 W4iLvRI1GSmG2ZLXSBteTsRJI93sbz8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-K5Wf8ohBOZeP8C4KJTjDDg-1; Wed, 05 Jun 2024 10:03:34 -0400
X-MC-Unique: K5Wf8ohBOZeP8C4KJTjDDg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35dcd39c6ebso621429f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717596210; x=1718201010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y7PR6GhNAef0DuVtjtWgjtfLtJjuA5O3jhHy8g7gxVM=;
 b=YCD9UmFn/+Lp206dkv7/CYGTnyigfq3nDkybCfg8GJMAXZTI74oSrC8D7hD5/Da09/
 GQOUrfk0ldShYfOymxKesVEPZlnv3EQITZ4yPleNBm1wceHZXnGTBIj2Vy8U21HHkSst
 C8oVbVr9e5n0Y0z185FXdUrSCdc5xhmtVEYtuVDdk94V4qYxFEBx8ps023XpPk0xzxf2
 65mVHYoGZXjkiobfWXXQwBURLLzX0qsBfPddbVzsymAmDIrBZ4nN1jPef+VuztRzhzDw
 n/MHJe9Mmy/ydIYr1j7aa7gMXyNaeZtergZivr194EphhVn0JY9XHZjsmdcIrbBAKPiq
 7skg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjvj94VQsvNZvdPXsduVibSa1HlYfMAR3THEkuGDPeWkzyEkacfDlWRgAc097KUcDds6E3GuFVXZewgfAlkaGizKDEtAI=
X-Gm-Message-State: AOJu0YxZGql+2juAC4axRCKkPZsILFCzthzazctvUKf2w475Hmwfggwx
 IHa9w3dZHlRHVKTGH4pl1XC+PCCWfY6MmKTUc4awbPXy5a3K/88EXsbkDS58pNAaTNVC7WmCvIG
 oRQ4/Y27tLPKqWz6l5obOD76UTFUxZsENJWw3+7lh8xVbNj03kQp3
X-Received: by 2002:adf:ec0e:0:b0:34d:9604:3500 with SMTP id
 ffacd0b85a97d-35e7c519cfcmr5101203f8f.4.1717596209992; 
 Wed, 05 Jun 2024 07:03:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1ekB56BFWpWcPskJ8JhVBd5oDYDIHCLFQoNPCNCyPOGnvssP88NWXPo0e3tF38fX7xVB50g==
X-Received: by 2002:adf:ec0e:0:b0:34d:9604:3500 with SMTP id
 ffacd0b85a97d-35e7c519cfcmr5101167f8f.4.1717596209519; 
 Wed, 05 Jun 2024 07:03:29 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd062fe96sm14623887f8f.67.2024.06.05.07.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:03:29 -0700 (PDT)
Date: Wed, 5 Jun 2024 16:03:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, npiggin@gmail.com,
 harshpb@linux.ibm.com, linuxarm@huawei.com
Subject: Re: [PATCH V12 0/8] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <20240605160327.3c71f4ab@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240602180241-mutt-send-email-mst@kernel.org>
References: <20240529234241.205053-1-salil.mehta@huawei.com>
 <20240602180241-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sun, 2 Jun 2024 18:03:05 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, May 30, 2024 at 12:42:33AM +0100, Salil Mehta wrote:
> > Virtual CPU hotplug support is being added across various architectures=
[1][3].
> > This series adds various code bits common across all architectures:
> >=20
> > 1. vCPU creation and Parking code refactor [Patch 1]
> > 2. Update ACPI GED framework to support vCPU Hotplug [Patch 2,3]
> > 3. ACPI CPUs AML code change [Patch 4,5]
> > 4. Helper functions to support unrealization of CPU objects [Patch 6,7]
> > 5. Docs [Patch 8]
> >=20
> >=20
> > Repository:
> >=20
> > [*] https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v3.arc=
h.agnostic.v12
> >=20
> > NOTE: This series is meant to work in conjunction with Architecture spe=
cific patch-set.
> > For ARM, this will work in combination of the architecture specific par=
t based on
> > RFC V2 [1]. This architecture specific patch-set RFC V3 shall be floate=
d soon and is
> > present at below location
> >=20
> > [*] https://github.com/salil-mehta/qemu/tree/virt-cpuhp-armv8/rfc-v3-rc1
> >  =20
>=20
>=20
> Igor plan to take a look?

Yep, I plan to review it

>=20
> > Revision History:
> >=20
> > Patch-set  V11 -> V12
> > 1. Addressed Harsh Prateek Bora's (IBM) comment
> >    - Changed @cpu to @vcpu_id in the kvm_unpark_vcpu protoype header/
> > 2. Added Zhao Liu's (Intel) Tested-by for whole series
> >    - Qtest does not breaks on Intel platforms now.
> > 3. Added Zhao Liu's (Intel) Reviewed-by for [PATCH V11 {1/8 - 3/8}]
> > Link: https://lore.kernel.org/qemu-devel/ZlRSPuJGBgyEUW6w@intel.com/
> > Link: https://lore.kernel.org/qemu-devel/a5f3d78e-cfed-441f-9c56-e3e78f=
a5edee@linux.ibm.com/
> >=20
> > Patch-set  V10 -> V11
> > 1. Addressed Nicholas Piggin's (IBM) comment
> >    - moved the traces in kvm_unpark_vcpu and kvm_create_vcpu at the end
> >    - Added the Reviewed-by Tag for [PATCH V10 1/8]
> > 2.  Addressed Alex Benn=C3=A9e's (Linaro) comments
> >    - Added a note explaining dependency of the [PATCH V10 7/8] on Arch =
specific patch-set
> > Link: https://lore.kernel.org/qemu-devel/D1FS5GOOFWWK.2PNRIVL0V6DBL@gma=
il.com/=20
> > Link: https://lore.kernel.org/qemu-devel/87frubi402.fsf@draig.linaro.or=
g/
> >=20
> > Patch-set  V9 -> V10
> > 1. Addressed Nicholas Piggin's (IBM) & Philippe Mathieu-Daud=C3=A9 (Lin=
aro) comments
> >    - carved out kvm_unpark_vcpu and added its trace
> >    - Widened the scope of the kvm_unpark_vcpu so that it can be used by=
 generic framework
> >      being thought out
> > Link: https://lore.kernel.org/qemu-devel/20240519210620.228342-1-salil.=
mehta@huawei.com/
> > Link: https://lore.kernel.org/qemu-devel/e94b0e14-efee-4050-9c9f-08382a=
36b63a@linaro.org/
> >=20
> > Patch-set  V8 -> V9
> > 1. Addressed Vishnu Pajjuri's (Ampere) comments
> >    - Added kvm_fd to trace in kvm_create_vcpu
> >    - Some clean ups: arch vcpu-id and sbd variable
> >    - Added the missed initialization of cpu->gdb_num_regs
> > 2. Addressed the commnet from Zhao Liu (Intel)
> >    - Make initialization of CPU Hotplug state conditional (possible_cpu=
_arch_ids!=3DNULL)
> > Link: https://lore.kernel.org/qemu-devel/20240312020000.12992-1-salil.m=
ehta@huawei.com/
> >=20
> > Patch-set V7 -> V8
> > 1. Rebased and Fixed the conflicts
> >=20
> > Patch-set  V6 -> V7
> > 1. Addressed Alex Benn=C3=A9e's comments
> >    - Updated the docs
> > 2. Addressed Igor Mammedov's comments
> >    - Merged patches [Patch V6 3/9] & [Patch V6 7/9] with [Patch V6 4/9]
> >    - Updated commit-log of [Patch V6 1/9] and [Patch V6 5/9]    =20
> > 3. Added Shaoqin Huang's Reviewed-by tags for whole series.
> > Link: https://lore.kernel.org/qemu-devel/20231013105129.25648-1-salil.m=
ehta@huawei.com/
> >=20
> > Patch-set  V5 -> V6
> > 1. Addressed Gavin Shan's comments
> >    - Fixed the assert() ranges of address spaces
> >    - Rebased the patch-set to latest changes in the qemu.git
> >    - Added Reviewed-by tags for patches {8,9}
> > 2. Addressed Jonathan Cameron's comments
> >    - Updated commit-log for [Patch V5 1/9] with mention of trace events
> >    - Added Reviewed-by tags for patches {1,5}
> > 3. Added Tested-by tags from Xianglai Li
> > 4. Fixed checkpatch.pl error "Qemu -> QEMU" in [Patch V5 1/9]=20
> > Link: https://lore.kernel.org/qemu-devel/20231011194355.15628-1-salil.m=
ehta@huawei.com/
> >=20
> > Patch-set  V4 -> V5
> > 1. Addressed Gavin Shan's comments
> >    - Fixed the trace events print string for kvm_{create,get,park,destr=
oy}_vcpu
> >    - Added Reviewed-by tag for patch {1}
> > 2. Added Shaoqin Huang's Reviewed-by tags for Patches {2,3}
> > 3. Added Tested-by Tag from Vishnu Pajjuri to the patch-set
> > 4. Dropped the ARM specific [Patch V4 10/10]
> > Link: https://lore.kernel.org/qemu-devel/20231009203601.17584-1-salil.m=
ehta@huawei.com/
> >=20
> > Patch-set  V3 -> V4
> > 1. Addressed David Hilderbrand's comments
> >    - Fixed the wrong doc comment of kvm_park_vcpu API prototype
> >    - Added Reviewed-by tags for patches {2,4}
> > Link: https://lore.kernel.org/qemu-devel/20231009112812.10612-1-salil.m=
ehta@huawei.com/
> >=20
> > Patch-set  V2 -> V3
> > 1. Addressed Jonathan Cameron's comments
> >    - Fixed 'vcpu-id' type wrongly changed from 'unsigned long' to 'inte=
ger'
> >    - Removed unnecessary use of variable 'vcpu_id' in kvm_park_vcpu
> >    - Updated [Patch V2 3/10] commit-log with details of ACPI_CPU_SCAN_M=
ETHOD macro
> >    - Updated [Patch V2 5/10] commit-log with details of conditional eve=
nt handler method
> >    - Added Reviewed-by tags for patches {2,3,4,6,7}
> > 2. Addressed Gavin Shan's comments
> >    - Remove unnecessary use of variable 'vcpu_id' in kvm_par_vcpu
> >    - Fixed return value in kvm_get_vcpu from -1 to -ENOENT
> >    - Reset the value of 'gdb_num_g_regs' in gdb_unregister_coprocessor_=
all
> >    - Fixed the kvm_{create,park}_vcpu prototypes docs
> >    - Added Reviewed-by tags for patches {2,3,4,5,6,7,9,10}
> > 3. Addressed one earlier missed comment by Alex Benn=C3=A9e in RFC V1
> >    - Added traces instead of DPRINTF in the newly added and some existi=
ng functions
> > Link: https://lore.kernel.org/qemu-devel/20230930001933.2660-1-salil.me=
hta@huawei.com/
> >=20
> > Patch-set V1 -> V2
> > 1. Addressed Alex Benn=C3=A9e's comments
> >    - Refactored the kvm_create_vcpu logic to get rid of goto
> >    - Added the docs for kvm_{create,park}_vcpu prototypes
> >    - Splitted the gdbstub and AddressSpace destruction change into sepa=
rate patches
> >    - Added Reviewed-by tags for patches {2,10}
> > Link: https://lore.kernel.org/qemu-devel/20230929124304.13672-1-salil.m=
ehta@huawei.com/
> >=20
> > References:
> >=20
> > [1] https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.meh=
ta@huawei.com/
> > [2] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.c=
om/
> > [3] https://lore.kernel.org/qemu-devel/cover.1695697701.git.lixianglai@=
loongson.cn/
> >=20
> >=20
> >=20
> > Salil Mehta (8):
> >   accel/kvm: Extract common KVM vCPU {creation,parking} code
> >   hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header file
> >   hw/acpi: Update ACPI GED framework to support vCPU Hotplug
> >   hw/acpi: Update GED _EVT method AML with CPU scan
> >   hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
> >   physmem: Add helper function to destroy CPU AddressSpace
> >   gdbstub: Add helper function to unregister GDB register space
> >   docs/specs/acpi_hw_reduced_hotplug: Add the CPU Hotplug Event Bit
> >=20
> >  accel/kvm/kvm-all.c                    | 95 +++++++++++++++++---------
> >  accel/kvm/kvm-cpus.h                   | 23 +++++++
> >  accel/kvm/trace-events                 |  5 +-
> >  docs/specs/acpi_hw_reduced_hotplug.rst |  3 +-
> >  gdbstub/gdbstub.c                      | 13 ++++
> >  hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++
> >  hw/acpi/cpu.c                          | 33 ++++++---
> >  hw/acpi/generic_event_device.c         | 21 ++++++
> >  hw/core/cpu-common.c                   |  1 -
> >  hw/i386/acpi-build.c                   |  3 +-
> >  include/exec/cpu-common.h              |  8 +++
> >  include/exec/gdbstub.h                 |  6 ++
> >  include/hw/acpi/cpu.h                  |  5 +-
> >  include/hw/acpi/cpu_hotplug.h          |  4 ++
> >  include/hw/acpi/generic_event_device.h |  4 ++
> >  include/hw/core/cpu.h                  |  1 +
> >  system/physmem.c                       | 29 ++++++++
> >  17 files changed, 212 insertions(+), 48 deletions(-)
> >=20
> > --=20
> > 2.34.1 =20
>=20


