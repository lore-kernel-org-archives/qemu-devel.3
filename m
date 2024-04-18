Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F12C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 11:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxQ58-0007M7-6E; Thu, 18 Apr 2024 07:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rxQ50-0007LP-Rc
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 07:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rxQ4x-0003xL-RR
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 07:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713440241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PcsMBXShABVBzv1i92OczRQb6Gi/n5C3FH/kjRkOTYc=;
 b=AnXYDJiC2DvdUEmQvjJvmBrEeVRX26z2pAL1HeEGT5L/qYKVTVvvt3lylTk+C/p2ACKzPG
 agUOfSxqc4by1tAgTsCHGMGDzo+UXAFCgJwrmpercWIITLTMzWcagAFIyWyNf3OuHUJ8Pm
 Ady3QuiIQg259qUx+xN2qJpaC/cNnqo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-lvGkeBsCMFeEJERcQWkluA-1; Thu, 18 Apr 2024 07:37:20 -0400
X-MC-Unique: lvGkeBsCMFeEJERcQWkluA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2a300d6a299so1000980a91.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 04:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713440239; x=1714045039;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PcsMBXShABVBzv1i92OczRQb6Gi/n5C3FH/kjRkOTYc=;
 b=Ny3eVgK8d4A9XAeXtmi7hNDfwbU2lsGoEd7irujLaAo4/bH2WHYCF7ekMkFyoI1ER+
 6aUd1r9JPbdRNuc9GoJiOsP1nU+GsMHER1VocckTEvs/5hRDWRweP3go7tjSZcWIIAlQ
 L2G4RBCEfNaAFRirt6nSwNuiguLb6lWJfYD4rHMgyjMXMgoXkJdqtw8qQigaoYJqtYuI
 Zzoitk/UtJgS6lUF/AHw4vPZkM5O9SzPbKOG4bQuQH+ggc8q/fCas9HcNg24unDwPeJB
 NlHJl3lWiFGebsjnZLpp19mc/4Ph+TrlGpOEfLRbECMuV2yIohi8p2HvibVMlVD6cDdL
 DUNA==
X-Gm-Message-State: AOJu0Ywdwxp2B451IvlUTU4E8rEjwjd6Uu20UPkdPpYsXxU+Oe+YR25F
 mZYpbnVdpX0BXRF57EHjTGgfgyXoxL3Hw2FFq5mvuGOsBV3mDgPm6Geq7vPSOQOm8E8I0zBZnuZ
 4VToD3/J2N1kug3gYUijYg4mGyZ70C3rJIulwFRSOkh0lMqVC0OEw
X-Received: by 2002:a17:90a:d901:b0:2ab:b411:8cbc with SMTP id
 c1-20020a17090ad90100b002abb4118cbcmr2325675pjv.31.1713440239112; 
 Thu, 18 Apr 2024 04:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8IvKTqySqH5GCmq6oSSvJ2Jml9ZyF0KyoWBmQreNX+GeVM0UYyqmeckr/bcF7Qg7UpNkPTg==
X-Received: by 2002:a17:90a:d901:b0:2ab:b411:8cbc with SMTP id
 c1-20020a17090ad90100b002abb4118cbcmr2325652pjv.31.1713440238668; 
 Thu, 18 Apr 2024 04:37:18 -0700 (PDT)
Received: from smtpclient.apple ([116.73.134.11])
 by smtp.gmail.com with ESMTPSA id
 q100-20020a17090a17ed00b002abb83331afsm1359471pja.27.2024.04.18.04.37.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Apr 2024 04:37:18 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH RFC v3 00/49] Add AMD Secure Nested Paging (SEV-SNP)
 support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240320083945.991426-1-michael.roth@amd.com>
Date: Thu, 18 Apr 2024 17:07:03 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FEBC451-4001-434F-84A6-615526A8A82C@redhat.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
To: Michael Roth <michael.roth@amd.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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



> On 20 Mar 2024, at 14:08, Michael Roth <michael.roth@amd.com> wrote:
>=20
> These patches implement SEV-SNP base support along with CPUID =
enforcement
> support for QEMU, and are also available at:
>=20
>  https://github.com/amdese/qemu/commits/snp-v3-rfc
>=20
> they are based on top of the following patchset from Paolo:
>=20
>  "[PATCH 0/7] target/i386: VM type infrastructure and KVM_SEV_INIT2 =
support"
>  https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04663.html

Can you please also CC me on future revisions of this patchset?=20

Thanks!


>=20
>=20
> Patch Layout
> ------------
>=20
> 01-05: Various changes needed to handle new header files in kvm-next =
tree
>       and some hacks to get a functional header sync in place for =
building
>       this series.
> 06-18: These are patches directly plucked from Xiaoyao's TDX v5 =
patchset[1]
>       that implement common dependencies between SNP/TDX like base
>       guest_memfd, KVM_EXIT_MEMORY_FAULT handling (with a small =
FIXUP), and
>       mechanisms to disable SMM. We would've also needed some of the =
basic
>       infrastructure for handling specifying VM types for KVM_CREATE, =
but
>       much of that is now part of the sevinit2 series this patchset is =
based
>       on. Ideally all these patches, once stable, could be maintained =
in a
>       common tree so that future SNP/TDX patchsets can be more easily
>       iterated on/reviewed.
> 19-20: Patches introduced by this series that are  possible candidate =
for a
>       common tree.
>       shared/private pages when things like VFIO are in use.
> 21-32: Introduction of sev-snp-guest object and various configuration
>       requirements for SNP.
> 33-36: Handling for various KVM_EXIT_VMGEXIT events that are handled =
in
>       userspace.
> 37-49: Support for creating a cryptographic "launch" context and =
populating
>       various OVMF metadata pages, BIOS regions, and vCPU/VMSA pages =
with
>       the initial encrypted/measured/validated launch data prior to
>       launching the SNP guest.
>=20
>=20
> Testing
> -------
>=20
> This series has been tested against the following host kernel tree, =
which
> is a snapshot of the latest WIP SNP hypervisor tree at the time of =
this
> posting. It will likely not be kept up to date afterward, so please =
keep an
> eye upstream or official AMDESE github if you are looking for the =
latest
> some time after this posting:
>=20
>  https://github.com/mdroth/linux/commits/snp-host-v12-wip40/
>=20
> A patched OVMF is also needed due to upstream KVM no longer supporting =
MMIO
> ranges that are mapped as private. It is recommended you build the =
AmdSevX64
> variant as it provides the kernel-hashing support present in this =
series:
>=20
>  https://github.com/mdroth/edk2/commits/apic-mmio-fix1c/
>=20
> A basic command-line invocation for SNP would be:
>=20
> qemu-system-x86_64 -smp 32,maxcpus=3D255 -cpu EPYC-Milan-v2
>  -machine q35,confidential-guest-support=3Dsev0,memory-backend=3Dram1
>  -object memory-backend-memfd,id=3Dram1,size=3D4G,share=3Dtrue,reserve=3D=
false
>  -object sev-snp-guest,id=3Dsev0,cbitpos=3D51,reduced-phys-bits=3D1,id-a=
uth=3D
>  -bios =
/home/mroth/ovmf/OVMF_CODE-upstream-20240228-apicfix-1c-AmdSevX64.fd
>=20
> With kernel-hashing and certificate data supplied:
>=20
> qemu-system-x86_64 -smp 32,maxcpus=3D255 -cpu EPYC-Milan-v2
>  -machine q35,confidential-guest-support=3Dsev0,memory-backend=3Dram1
>  -object memory-backend-memfd,id=3Dram1,size=3D4G,share=3Dtrue,reserve=3D=
false
>  -object =
sev-snp-guest,id=3Dsev0,cbitpos=3D51,reduced-phys-bits=3D1,id-auth=3D,cert=
s-path=3D/home/mroth/cert.blob,kernel-hashes=3Don
>  -bios =
/home/mroth/ovmf/OVMF_CODE-upstream-20240228-apicfix-1c-AmdSevX64.fd
>  -kernel /boot/vmlinuz-6.8.0-snp-host-v12-wip40+
>  -initrd /boot/initrd.img-6.8.0-snp-host-v12-wip40+
>  -append "root=3DUUID=3Dd72a6d1c-06cf-4b79-af43-f1bac4f620f9 ro =
console=3DttyS0,115200n8"
>=20
> Any comments/feedback would be very much appreciated.
>=20
> [1] https://github.com/amdese/linux
>    https://github.com/amdese/amdsev/tree/snp-latest
>=20
> Changes since rfc2:
>=20
> - reworked on top of guest_memfd support
> - added handling for various KVM_EXIT_VMGEXIT events
> - various changes/considerations for PCI passthrough support
> - general bugfixes/hardening/cleanups
> - qapi cmdline doc fixes/rework (Dov, Markus)
> - switch to qbase64_decode, more error-checking for cmdline opts (Dov)
> - unset id_block_en for 0 input (Dov)
> - use error_setg in snp init (Dov)
> - report more info in trace_kvm_sev_init (Dov)
> - rework bounds-checking for kvm_cpuid_info, rework existing checks =
for readability, add additional checks (Dov)
> - fixups for validated_ranges handling (Dov)
> - rename 'policy' field to 'snp-policy' in query-sev when sev-type is =
SNP
>=20
> Changes since rfc1:
>=20
> - rebased onto latest master
> - drop SNP config file in favor of a new 'sev-snp-guest' object where =
all
>   SNP-related params are passed as strings/integers via command-line
> - report specific error if BIOS reports invalid address/len for
>   reserved/pre-validated regions (Connor)
> - use Range helpers for handling validated region overlaps (Dave)
> - simplify error handling in sev_snp_launch_start, and report the =
correct
>   return code when handling LAUNCH_START failures (Dov)
> - add SEV-SNP bit to CPUID 0x8000001f when SNP enabled
> - updated query-sev to handle differences between SEV and SEV-SNP
> - updated to work against v5 of SEV-SNP host kernel / hypervisor =
patches
>=20
> ----------------------------------------------------------------
> Brijesh Singh (5):
>      i386/sev: Introduce 'sev-snp-guest' object
>      i386/sev: Add the SNP launch start context
>      i386/sev: Add handling to encrypt/finalize guest launch data
>      hw/i386/sev: Add function to get SEV metadata from OVMF header
>      i386/sev: Add support for populating OVMF metadata pages
>=20
> Chao Peng (2):
>      kvm: Enable KVM_SET_USER_MEMORY_REGION2 for memslot
>      kvm: handle KVM_EXIT_MEMORY_FAULT
>=20
> Dov Murik (4):
>      qapi, i386: Move kernel-hashes to SevCommonProperties
>      i386/sev: Extract build_kernel_loader_hashes
>      i386/sev: Reorder struct declarations
>      i386/sev: Allow measured direct kernel boot on SNP
>=20
> Isaku Yamahata (2):
>      pci-host/q35: Move PAM initialization above SMRAM initialization
>      q35: Introduce smm_ranges property for q35-pci-host
>=20
> Michael Roth (30):
>      Revert "linux-headers hack" from sevinit2 base tree
>      scripts/update-linux-headers: Add setup_data.h to import list
>      scripts/update-linux-headers: Add bits.h to file imports
>      [HACK] linux-headers: Update headers for 6.8 + kvm-coco-queue + =
SNP
>      [TEMP] hw/i386: Remove redeclaration of struct setup_data
>      RAMBlock: Add support of KVM private guest memfd
>      [FIXUP] "kvm: handle KVM_EXIT_MEMORY_FAULT": drop =
qemu_host_page_size
>      trace/kvm: Add trace for page convertion between shared and =
private
>      kvm: Make kvm_convert_memory() obey =
ram_block_discard_is_enabled()
>      trace/kvm: Add trace for KVM_EXIT_MEMORY_FAULT
>      i386/sev: Introduce "sev-common" type to encapsulate common SEV =
state
>      i386/sev: Add a sev_snp_enabled() helper
>      target/i386: Add handling for KVM_X86_SNP_VM VM type
>      i386/sev: Skip RAMBlock notifiers for SNP
>      i386/sev: Skip machine-init-done notifiers for SNP
>      i386/sev: Set ms->require_guest_memfd for SNP
>      i386/sev: Disable SMM for SNP
>      i386/sev: Don't disable block discarding for SNP
>      i386/cpu: Set SEV-SNP CPUID bit when SNP enabled
>      i386/sev: Update query-sev QAPI format to handle SEV-SNP
>      i386/sev: Don't return launch measurements for SEV-SNP guests
>      kvm: Make kvm_convert_memory() non-static
>      i386/sev: Add KVM_EXIT_VMGEXIT handling for Page State Changes
>      i386/sev: Add KVM_EXIT_VMGEXIT handling for Page State Changes =
(MSR-based)
>      i386/sev: Add KVM_EXIT_VMGEXIT handling for Extended Guest =
Requests
>      i386/sev: Set CPU state to protected once SNP guest payload is =
finalized
>      i386/sev: Add support for SNP CPUID validation
>      hw/i386/sev: Add support to encrypt BIOS when SEV-SNP is enabled
>      hw/i386/sev: Use guest_memfd for legacy ROMs
>      hw/i386: Add support for loading BIOS using guest_memfd
>=20
> Xiaoyao Li (6):
>      HostMem: Add mechanism to opt in kvm guest memfd via MachineState
>      trace/kvm: Split address space and slot id in =
trace_kvm_set_user_memory()
>      kvm: Introduce support for memory_attributes
>      physmem: Introduce ram_block_discard_guest_memfd_range()
>      kvm/memory: Make memory type private by default if it has guest =
memfd backend
>      memory: Introduce memory_region_init_ram_guest_memfd()
>=20
> accel/kvm/kvm-all.c                                |  241 ++-
> accel/kvm/trace-events                             |    4 +-
> accel/stubs/kvm-stub.c                             |    5 +
> backends/hostmem-file.c                            |    1 +
> backends/hostmem-memfd.c                           |    1 +
> backends/hostmem-ram.c                             |    1 +
> backends/hostmem.c                                 |    1 +
> docs/system/i386/amd-memory-encryption.rst         |   78 +-
> hw/core/machine.c                                  |    5 +
> hw/i386/pc.c                                       |   13 +-
> hw/i386/pc_q35.c                                   |    2 +
> hw/i386/pc_sysfw.c                                 |   25 +-
> hw/i386/pc_sysfw_ovmf.c                            |   33 +
> hw/i386/x86.c                                      |   46 +-
> hw/pci-host/q35.c                                  |   61 +-
> include/exec/cpu-common.h                          |    2 +
> include/exec/memory.h                              |   26 +-
> include/exec/ram_addr.h                            |    2 +-
> include/exec/ramblock.h                            |    1 +
> include/hw/boards.h                                |    2 +
> include/hw/i386/pc.h                               |   31 +-
> include/hw/i386/x86.h                              |    2 +-
> include/hw/pci-host/q35.h                          |    1 +
> include/standard-headers/asm-x86/bootparam.h       |   17 +-
> include/standard-headers/asm-x86/kvm_para.h        |    3 +-
> include/standard-headers/linux/ethtool.h           |   48 +
> include/standard-headers/linux/fuse.h              |   39 +-
> include/standard-headers/linux/input-event-codes.h |    1 +
> include/standard-headers/linux/virtio_gpu.h        |    2 +
> include/standard-headers/linux/virtio_snd.h        |  154 ++
> include/sysemu/hostmem.h                           |    1 +
> include/sysemu/kvm.h                               |    7 +
> include/sysemu/kvm_int.h                           |    2 +
> linux-headers/asm-arm64/kvm.h                      |   15 +-
> linux-headers/asm-arm64/sve_context.h              |   11 +
> linux-headers/asm-generic/bitsperlong.h            |    4 +
> linux-headers/asm-loongarch/kvm.h                  |    2 -
> linux-headers/asm-mips/kvm.h                       |    2 -
> linux-headers/asm-powerpc/kvm.h                    |   45 +-
> linux-headers/asm-riscv/kvm.h                      |    3 +-
> linux-headers/asm-s390/kvm.h                       |  315 +++-
> linux-headers/asm-x86/kvm.h                        |  372 ++++-
> linux-headers/asm-x86/setup_data.h                 |   83 +
> linux-headers/linux/bits.h                         |   15 +
> linux-headers/linux/kvm.h                          |  719 +--------
> linux-headers/linux/psp-sev.h                      |   71 +
> qapi/misc-target.json                              |   71 +-
> qapi/qom.json                                      |   96 +-
> scripts/update-linux-headers.sh                    |    5 +-
> system/memory.c                                    |   30 +
> system/physmem.c                                   |   47 +-
> target/i386/cpu.c                                  |    1 +
> target/i386/kvm/kvm.c                              |    4 +
> target/i386/sev-sysemu-stub.c                      |    2 +-
> target/i386/sev.c                                  | 1631 =
++++++++++++++++----
> target/i386/sev.h                                  |   13 +-
> target/i386/trace-events                           |    3 +
> 57 files changed, 3272 insertions(+), 1146 deletions(-)
> create mode 100644 linux-headers/asm-x86/setup_data.h
> create mode 100644 linux-headers/linux/bits.h
>=20
>=20
>=20
>=20


