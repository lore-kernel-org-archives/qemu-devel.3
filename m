Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94270FF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 18:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHnIq-0000qq-Ll; Tue, 28 Apr 2026 14:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHnIn-0000qJ-Qc
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 14:36:58 -0400
Received: from pv-2003l-snip4-7.eps.apple.com ([57.103.66.40]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHnIl-0007g8-Qu
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 14:36:57 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPS id
 EE10718000AB; Tue, 28 Apr 2026 18:36:51 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwROEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAhJcStzX3YyFDwFXXRGBjZ/QB5VBlxzXQs9dSxzKXZHC0FxWXceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777401413; x=1779993413;
 bh=LYM7TvQBAlTfmBdJ/lJvShbQcD4gsjvXXoL7IvZpCzQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=aIS1pGLeLUCPenznWrwBpbu9ViOeFUi8MkpHmX71+k6qdiAjEE5RSnwvP9e5QFrid94UKdVVkJrHK+jz1QtV9fl8hzzf2m7Hx/chIxcRXQHcx0YlnGE68a1lUlx2lch/sTgDKM7fYJAhbBIL8eWW2X9Ha08IZDZnzYPj+02hhOH+qoXR/Y5yJZEc0/zEVAMWyWAiQ3zdJGcFu42cJL/IiCoP/55YUY5NW5nZFLjPVqrIV/zCOhG++mZzpYORFVcJDKntDVMZOrz1ulRA2Nqf00utcH/Ut4kbotEqJaRW1n6GwSzyjZJ74o581KEv6rd1pgmrIAT7pFX8w8tJoGtGpQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPSA id
 4B1781800591; Tue, 28 Apr 2026 18:36:50 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 0/6] target/i386/mshv: use hv_vp_register_page for fast
 register access
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
Date: Tue, 28 Apr 2026 20:36:38 +0200
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11BFD4DB-D60C-4FF8-817A-2EFADBD729B4@unpredictable.fr>
References: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
To: =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-ORIG-GUID: DhotmTqGjk9Z9rzJuLU-hB38Yc4qMjQD
X-Authority-Info-Out: v=2.4 cv=D9JK6/Rj c=1 sm=1 tr=0 ts=69f0fe44
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GaQpPoNlAAAA:8 a=yMhMjlubAAAA:8
 a=J1EvKnRYTj4A5Ngll8oA:9 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-GUID: DhotmTqGjk9Z9rzJuLU-hB38Yc4qMjQD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE4MCBTYWx0ZWRfX3mWUvabnzIQe
 BeunH1FPNDDtEIjI+AEBdi/CpsxQ+T3WNe+io6q5Hh3J+yEkxKWijeqBVCmMjyPDqx4RSl36/0K
 4Ni7MIoGKFPHkj2DA16YMqXZVSD+DcSC45kUdqOS8cBQfYmtXdkDkb8FPTiKZ11HSztXN6mhc65
 jshLTZ2DHZIXDcCYOeLM+6JOcg8Y/DObkMMPj83x1NcudNVFrdu3Df+L0reJxBsGneIa34dszT/
 6FZaddNulucL9I4C2ezN6/wv+ffd3adlq67IDePSjFdDWQ8Pi0XamtoSQOBg3zF3A8hmSPsjzsm
 KantWnDIf7OLB4S/MLJpl5fE36aUu+zTmFGHOQZuUX9KQ0Wve9Ki573xvJLuE8=
Received-SPF: pass client-ip=57.103.66.40;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 28. Apr 2026, at 15:50, Doru Bl=C3=A2nzeanu =
<dblanzeanu@linux.microsoft.com> wrote:
>=20
> This series adds support for using the hypervisor's vp register page
> in the mshv accelerator to optimize vcpu register access on mmio and =
pio
> exits.
>=20
> Currently, all register reads and write go through hypercalls =
(ioctls),
> which adds overhead on every VM exit. The VP register page is a shared
> memory page that the hypervisor populates with vcpu register state,
> allowing Qemu to read and write registers directly without hypercalls.
>=20
> The series is structured as follows:
> 1. Remove the duplicate `fetch_guest_state` function, consolidating
>  register loading into `mshv_load_regs`.
> 2. Move `mshv_arch_init_vcpu` after vcpu creation so the vcpu fd is
>  valid when we need it for mmap.
> 3. Define the `hv_vp_register_page` structure in `hvgdk_mini.h`, =
matching
>  the layout used by the Linux kernel's mshv driver.
> 4. Set up the register page by mmapping the vcpu fd at init time. If =
the
>  mmap fails, we fall back gracefully to the existing hypercall path.
> 5. Use the register page to read registers on VM exit. General purpose
>  registers, RIP, RFLAGS, segment registers, and control registers
>  (CR0, CR4, CR4, CR8, EFER) are read directly from the page. Registers
>  not present on the page (TR, LDTR, GDTR, IDTR, CR2, APIC_BASE) are =
still
>  fetched via hypercall.
> 6. Use register page to write registers on vmentry. GP registers,
>  RIP, and RFLAGS are written to the page with the appropriate dirty
>  bits set, avoiding the hypercall for the standard register store.
>=20
> The register page is only used when it has been successfully mmapped =
and
> the hypervisor has marked it as valid (`isvalid !=3D 0`). Otherwise, =
the
> existing hypercall-based path is used as a fallback.

Hello,

Some overall comments after reading this series:

- bifurcated state sync is inevitable with not syncing the full
state for most MMIO/I/O port accesses.=20

It=E2=80=99s wanted to skip some state. LDTR/GDTR are among the painful
ones and you=E2=80=99ll very much want to avoid syncing those if you =
can.

In the typical WHP emulation case, there=E2=80=99s 0 state used outside
of the shared register page and getting there made things so much
smoother than otherwise.

- but there=E2=80=99s an exception:

A pattern that causes problems:

    /* Advance RIP and update RAX */
    rip =3D info->header.rip + insn_len;
    rax =3D info->rax;

    reg_names[0] =3D HV_X64_REGISTER_RIP;
    reg_values[0] =3D rip;
    reg_names[1] =3D HV_X64_REGISTER_RAX;
    reg_values[1] =3D rax;

    ret =3D set_x64_registers(cpu, reg_names, reg_values);
    if (ret < 0) {
        error_report("Failed to set x64 registers");
        return -1;
    }

    cpu->accel->dirty =3D false;

When put together with hw/i386/vmport.c, which calls =
cpu_synchronize_state
on an I/O port read (thankfully not very frequent), you=E2=80=99ll get =
issues with
this as vmport does both read and set register values on its own.

In WHPX, was dealt with in: =
https://patchew.org/QEMU/20260422214225.2242-1-mohamed@unpredictable.fr/20=
260422214225.2242-12-mohamed@unpredictable.fr/=20
and you=E2=80=99ll probably want to do something similar.

I imagine that =E2=80=9Ccpu->accel->dirty =3D false;=E2=80=9D was =
probably an attempt to
get things to boot when faced with that.

This adds a small constraint that if additional state will be fetched in
the future, then writes have to happen either before that fetch, or on =
the
now synced state instead of the partial view.



