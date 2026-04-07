Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F036EFF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUm-0006ct-DF; Tue, 07 Apr 2026 14:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wABSy-0003wR-Ga
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:02 -0400
Received: from p-west2-cluster3-host9-snip4-10.eps.apple.com ([57.103.69.73]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wA7bB-0002aW-0C
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 10:40:16 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-4 (Postfix) with ESMTPS id
 B80101800503; Tue, 07 Apr 2026 14:40:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775572809; x=1778164809;
 bh=FzkGImXMGV+k4O/3F04KClwgnpiDeG4+zfVAdz0Upko=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=VYV+xZKh+zW44/kr9WjM93N72/faCK+r96GC4ldgRDy0mdNQDohGzM9z9VAindptyAj6SvCRbrLd5t7IDfdKLwovKW0v3j2ia49oFgMhCC3jIwNxQTtVy3S0CZ87GktANNbAj0ah5QEZUTKVogQFaZDK3bS3lxy8wHsZNw9m567Vws2+VtPf9vAm31DFV18FRLrrE+bxmrMPak1kHUqHxFeXdFSieChVUaF6oRfIY0PdZ8eiD9UKGMP0yOaIqbduC9MkTYBz59k0ZC76EBc0ZdwpVDL3uTrtEKhVW4R4vd3iv0KZZUwPufDzQtozQZkTBtMRBD8Y1P3gpsw7owne5g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-4 (Postfix) with ESMTPSA id
 CF1F4180053A; Tue, 07 Apr 2026 14:40:06 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v8 00/13] whpx: i386: bug fixes, feature probing and CPUID
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260407141809.16862-1-mohamed@unpredictable.fr>
Date: Tue, 7 Apr 2026 16:39:54 +0200
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5EA7BEB7-05E2-44CF-B780-3B774712BDC3@unpredictable.fr>
References: <20260407141809.16862-1-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNCBTYWx0ZWRfX3HHjnt6C4LYv
 w4wqjFodN5De4nObdD5qnqGIQOAt/SEx8H2EVCmqGHrOCUNgpqL/mLA4yVCvB6lqp+zY2CGp2d7
 G+12XGeF4X1PLZ7lMqW7M/YKSVylRVVOlJhj342+30z4woc6fnEUpvoUXorh76cRd/Iikc09ks6
 HSl1afM3zEN0XTnLtWwaGUULq5syogjxYRYY9hXl4h8b0R60r4pn14UW/G9HHei/s6YAD6JNeQ6
 sO4haHVzeK5RtmIBKesxDl3O3KhaMQElA8ZvL94w0rmj6+PJkhn14QnAkoAuh9rmZaXejGUUJHt
 yoANZXa6OgY/78PwRPX4VmHhx0+LcC2GoD9Sf+QT09EuoXs1RQnXSrxev7L7eI=
X-Authority-Info-Out: v=2.4 cv=JvD8bc4C c=1 sm=1 tr=0 ts=69d51749
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=YK75Sztqf-otMINejiUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BRkS7pCuZyEFToDkOgsZlq5o6wdUtYly
X-Proofpoint-ORIG-GUID: BRkS7pCuZyEFToDkOgsZlq5o6wdUtYly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=997 clxscore=1030
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604070134
Received-SPF: pass client-ip=57.103.69.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 7. Apr 2026, at 16:17, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> This is a supplemental update that includes
> "whpx: i386: x2apic emulation for kernel-irqchip=3Doff, feature =
probing"
> v4 unmodified.
>=20
> This might be too big for QEMU 11.0 at this point though=E2=80=A6
>=20

Hi,

For those shipping prebuilt QEMU on Windows binaries, you probably
want to cherry-pick this series especially for Windows 10 users.

This is primarily due to the advertising as VMware enlightenment
which allows Linux to grab the TSC/APIC timer frequencies duo.

Secondarily is kernel-irqchip=3Doff fixes so that modern Windows
boots in that configuration and making it have x2APIC support.

And then switching Windows 10 to kernel-irqchip=3Doff except if
the machine has the PIC disabled as we can=E2=80=99t properly emulate
it with the Hyper-V APIC.

On Windows 11, the feature addition provided here is -cpu <model>
working.


> Old performance (or lack thereof...) numbers:
>=20
> On a Ryzen 7 8700GE with a Windows 10 VM running with KVM in nested =
virt, with
> kernel-irqchip=3Doff for the virt Alpine Linux x86_64 ISO (3.23.3) =
with -smp cores=3D2,
> boot times as reported through dmesg:
>=20
> - QEMU 10.2: 83 seconds
> - QEMU 10.2 with a single core: 18.1 seconds
> - as of v6 of this series, x2apic forced off: 29 seconds
> - as of v6 this series, out of the box: 18 seconds
> - v6 with kernel-irqchip=3Don and EDK2: 16.5 seconds
> - v6 with kernel-irqchip=3Doff and EDK2: 9.5 seconds
> - v6, and with 1 core instead of two: 12.6 seconds
>=20
> In v7, the Windows 10 numbers are pretty much at parity with Windows =
11 now.
>=20
> And with this series on a Windows 11 VM on the same hardware:
> - kernel-irqchip=3Don: 6.5 seconds
> - kernel-irqchip=3Don, x2apic forced off: 7.6 seconds
> - kernel-irqchip=3Doff: 8.3 seconds
> - hyperv=3Doff,kernel-irqchip=3Doff: 7.6 seconds... which is faster,
> so the absence of enlightenment support on Windows 10 doesn't explain =
things...
>=20
> With kernel-irqchip=3Don on Windows 10, when booting with SeaBIOS, it =
gets stuck in
> syslinux due to PIC interrupt injection being broken there. That can =
be counted
> as an infinite boot time (?).
>=20
> checkpatch false positives:
>=20
> ERROR: spaces required around that '*' (ctx:WxV)
> +         UINT32 Ecx, WHV_CPUID_OUTPUT *CpuidOutput))
>=20
> Not a multiplication but a pointer reference.
>=20
> ERROR: space prohibited after that '&' (ctx:ExW)
> +                    & CPUID_7_0_EDX_CET_IBT) {
>                     ^
>=20
> ERROR: space prohibited after that '&' (ctx:ExW)
> +                    & CPUID_7_0_ECX_CET_SHSTK) {
>                     ^
>=20
> Because it's multiline.
>=20
> Changes in v8:
>=20
> - Interrupt priority changes are back.
> - Some CPUID fixes
> - disable enlightenments and LAPIC for isapc
>=20
> Changes in v7:
>=20
> - Exposing VMware hypervisor identification when not
> using Hyper-V enlightenments and when the VMware frequency
> CPUID leaf isn't explictly disabled.
>=20
> - Remove the interrupt priority logic as it has issues with
> PIC interrupts. Can be reintroduced later.
>=20
> - -cpu max passing through CPUID info from Hyper-V
> - fill xsave info
>=20
> - OSXSAVE CPUID leaf reporting fix.
>=20
> Changes in v6:
>=20
> - kernel-irqchip=3Doff fix: re-registering the interrupt window
> when the existing one has too low of a TPR value.
>=20
> Folded into "whpx: i386: kernel-irqchip=3Doff fixes".
>=20
> - I/O port access fast path cleanup commit added at the end
>=20
> The path relied on a side effect of whpx_get_reg instead of
> something cleaner.
>=20
> - Use the CR8 register provided by the hypervisor only when
> kernel-irqchip=3Doff. Rely on the APIC state synchronisation
> otherwise.
>=20
> This fixes some register sync errors that surfaced when setting
> the TPR values properly.
>=20
> Changes in v5/v1 with rename:
>=20
> - kernel-irqchip=3Doff fixes, notably making 64-bit Windows bootable
> - switching over Windows 10 to kernel-irqchip=3Doff by default
>=20
> Changes in v4:
>=20
> - Ugh for a revision sent quickly, unbreaking the arm64 build...
> - and making checkpatch happier to some extent
>=20
> Changes in v3:
>=20
> - Fixing CPUID intercepts so that QEMU CPU models work fine now, =
instead
> of the partial intercept that was present in QEMU 10.2
> - cleanups
>=20
> Changes in v2:
>=20
> - GCC warned when a variable name was re-used within a different (but =
overlapping)
> scope in the same function. It also warned with a =
-Werror=3Dmaybe-uninitialized for
> the MSR write case. Address those
> - make the in-KVM enlightenments path available on Windows 11 too when =
-M hyperv=3Doff.
>=20
> Mohamed Mediouni (13):
>  target/i386: emulate: include name of unhandled instruction
>  whpx: i386: x2apic emulation
>  whpx: i386: wire up feature probing
>  whpx: i386: disable TbFlushHypercalls for emulated LAPIC
>  whpx: i386: enable x2apic by default for user-mode LAPIC
>  whpx: i386: reintroduce enlightenments for Windows 10
>  whpx: i386: introduce proper cpuid support
>  whpx: i386: kernel-irqchip=3Doff fixes
>  whpx: i386: use WHvX64RegisterCr8 only when kernel-irqchip=3Doff
>  whpx: i386: disable kernel-irqchip on Windows 10 when PIC enabled
>  whpx: i386: IO port fast path cleanup
>  whpx: i386: disable enlightenments and LAPIC for isapc
>  whpx: i386: interrupt priority support
>=20
> accel/whpx/whpx-common.c       |   2 +
> include/system/whpx-common.h   |   1 +
> include/system/whpx-internal.h |  10 +
> target/arm/whpx/whpx-all.c     |   1 +
> target/i386/cpu.c              |  25 ++
> target/i386/emulate/x86_emu.c  |   4 +-
> target/i386/whpx/whpx-all.c    | 580 +++++++++++++++++++++++++++------
> target/i386/whpx/whpx-i386.h   |   4 +
> 8 files changed, 530 insertions(+), 97 deletions(-)
> create mode 100644 target/i386/whpx/whpx-i386.h
>=20
> --=20
> 2.50.1 (Apple Git-155)
>=20


