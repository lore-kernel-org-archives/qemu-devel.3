Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C4FFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 17:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHmZX-00006J-BW; Tue, 28 Apr 2026 13:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHmZF-0008Vn-Ss
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:49:54 -0400
Received: from pv-2004d-snip4-11.eps.apple.com ([57.103.65.211]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHmZB-0000J2-Sa
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:49:53 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-7 (Postfix) with ESMTPS id
 288901800B17; Tue, 28 Apr 2026 17:49:34 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwROEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTHtJcV4CXwZCFEADKAFGBkJ7TB5UcVIFXQBBdygOUwRGAEpwVHceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777398576; x=1779990576;
 bh=qobqHpRSJ1F450uGsl5kSV0cQ2DFQoDst55k0y+Yj0E=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=H8vofbnvzyP2YSLbIYp7mOkTk+opd7vyOFJYu1YRS2qBRa51mFG4R0yqA7Gr8PDGvH+Gwl3uK2kUPTFNlllt4yJYryKl1g4dpSzSA0hRdGnu+KQUWQjGFXm/MVogzXQ9lyY/0KEGkbEdDbICku6CG+60nEig4wpy/l8fm7lMgWkgdoj/s3wFKeECflIBpjwo+1hOA/+He4kCsh0rfw5AzECU87mI7LMzKdYB7WGRdGl6Tlrm5/7TOl5drPeM7pcU/WkHRz486oJ9dN3k/A0CWrd5mmiJ5pRAzRKatJFqhOi/eeuSYpcC+Zx1xKJ1neWRhnWFclNI3lNKC88R2uHmiQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-7 (Postfix) with ESMTPSA id
 7815A1800B0F; Tue, 28 Apr 2026 17:49:33 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 4/6] target/i386/mshv: hv_vp_register_page setup for the
 vcpu
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260428135053.251200-5-dblanzeanu@linux.microsoft.com>
Date: Tue, 28 Apr 2026 19:49:21 +0200
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1B35442-80E6-42B4-9F97-99DE986692C9@unpredictable.fr>
References: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
 <20260428135053.251200-5-dblanzeanu@linux.microsoft.com>
To: =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE3MiBTYWx0ZWRfXztQmE7Hdjd5C
 ptVln8nok1Qm5/HFF8VpHfquVbfQwO2lBXWX/q0kcIlqrQNbAo4Fcy0CUs3GEEntbHp4VGKRNgB
 W9hWjsvpLYOkH1y2OUuMG0IzpZxXs1mwcubuW7YKMYGCWfKswQvsvpUyXVRomH0/rAdNpGsorDh
 RABuW5TT934h2GJfzzdfqoo4oyk1lhu1/kS9ITtAKO9MrKsg+kMI3dKviGv5kNhlOyOaMQrnMi/
 c75jOH2Rxbvj47witEXMTuQAipmm8MszWurPQk8TuYqwSfzJarlHMbR4nvsb76kvlYJcGqQq8YY
 UtnstcCigApFMBfr+ExwjjOF0WsXDF7zLbTTM8mK2JTWiEauylfH0SeYeq3Mm4=
X-Proofpoint-ORIG-GUID: ZY78yl0Wl_-SZBHUO2RL8jgEVOAPfYbX
X-Authority-Info-Out: v=2.4 cv=BvuQAIX5 c=1 sm=1 tr=0 ts=69f0f32f
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=ADczPIEOeSqyNKhzclwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZY78yl0Wl_-SZBHUO2RL8jgEVOAPfYbX
Received-SPF: pass client-ip=57.103.65.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 28. Apr 2026, at 15:50, Doru Bl=C3=A2nzeanu =
<dblanzeanu@linux.microsoft.com> wrote:
>=20
> When the vcpu is created, call mmap to configure access to the =
register page.
>=20
> Update CPUArchState to store a pointer to the mmapped =
hv_vp_register_page.
>=20
> Signed-off-by: Doru Bl=C3=A2nzeanu <dblanzeanu@linux.microsoft.com>
> ---
> target/i386/cpu.h           |  3 +++
> target/i386/mshv/mshv-cpu.c | 18 ++++++++++++++++++
> 2 files changed, 21 insertions(+)
>=20
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 0b539155c4..0108e2157b 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2016,6 +2016,9 @@ typedef struct CPUArchState {
>     uint64_t msr_bndcfgs;
>     uint64_t efer;
>=20
> +    /* Shared register page */
> +    struct hv_vp_register_page *regs_page;
> +
>     /* Beginning of state preserved by INIT (dummy marker).  */
>     struct {} start_init_save;
>=20
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 9defd05db6..42b6fb1912 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1595,6 +1595,19 @@ void mshv_arch_init_vcpu(CPUState *cpu)
>                       + sizeof(hv_input_get_vp_registers)
>> HV_HYP_PAGE_SIZE));
>=20
> +
> +    /* mmap the registers page */
> +    void *rp =3D mmap(NULL, page, PROT_READ | PROT_WRITE,
> +                    MAP_SHARED, mshv_vcpufd(cpu),
> +                    MSHV_VP_MMAP_OFFSET_REGISTERS * page);
> +    if (rp =3D=3D MAP_FAILED) {
> +        warn_report("register page mmap failed, falling back to =
hypercalls: %s",
> +                    strerror(errno));
Hi,

I think it=E2=80=99s better to make this fatal tbh, the perf hit is just =
way
too big imo.

Otherwise,

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> +        env->regs_page =3D NULL;
> +    } else {
> +        env->regs_page =3D (struct hv_vp_register_page *) rp;
> +    }
> +
>     state->hvcall_args.base =3D mem;
>     state->hvcall_args.input_page =3D mem;
>     state->hvcall_args.output_page =3D (uint8_t *)mem + page;
> @@ -1608,6 +1621,11 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
>     CPUX86State *env =3D &x86_cpu->env;
>     AccelCPUState *state =3D cpu->accel;
>=20
> +    /* Unmap the register page */
> +    if (env->regs_page) {
> +        munmap(env->regs_page, HV_HYP_PAGE_SIZE);
> +        env->regs_page =3D NULL;
> +    }
>     g_free(state->hvcall_args.base);
>     state->hvcall_args =3D (MshvHvCallArgs){0};
>     g_clear_pointer(&env->emu_mmio_buf, g_free);
> --=20
> 2.53.0
>=20
>=20


