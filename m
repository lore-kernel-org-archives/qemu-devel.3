Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78806106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0w5x-0001Zn-6b; Fri, 13 Mar 2026 02:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0w5r-0001ZW-VE
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:33:57 -0400
Received: from p-east2-cluster6-host1-snip4-4.eps.apple.com ([57.103.76.175]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0w5p-0002Hv-Po
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:33:55 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id
 09E0C18003A5; Fri, 13 Mar 2026 06:33:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773383631; x=1775975631;
 bh=oqHJmVL5UO/+df9bvn++wiKAs8rYpOs4NmIqtnESgvE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Ha9rt60Ru9CkPAZuFOPuv3+qcol8ajvoaYcJWjZiiOxb7bhcfqfVhonHFvHbhJQ+om6H2te27fqJQisoKLvaMRaVecMxRs2/LPQNM4wqLUc/gm+BSInxaxQvTyuWcozkUnEH6AI8e0KxjdUpEb9JEEBAQnoYiOQS0LQjrduNdS66+IIf78ewDSeX+U6po6pDwOgtdZK8z90HcQukmV+lk2oCH/2XyKcBQzo6FqdXErT512LEnigZFlAp+0fCzXakaVg8ZJ22mQIxO34v1LKasGfH9jrOZBsSsFEqFQTRMtxhQ2PQ8QJim5c5mfw9yopHKvaH2kKAkPGkdJGvyYMyog==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id
 5BA581800109; Fri, 13 Mar 2026 06:33:47 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 1/3] target/arm: add AArch64 ISV=0 instruction
 emulation library
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260313021850.42379-2-lucaaamaral@gmail.com>
Date: Fri, 13 Mar 2026 07:33:35 +0100
Cc: qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,
 agraf@csgraf.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <D80C2CE1-DDA8-4627-8196-252DC8BF6BB6@unpredictable.fr>
References: <20260309214852.92545-1-lucaaamaral@gmail.com>
 <20260313021850.42379-1-lucaaamaral@gmail.com>
 <20260313021850.42379-2-lucaaamaral@gmail.com>
To: Lucas Amaral <lucaaamaral@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-ORIG-GUID: 6spvLzFyk5RvZTski4mm2ncj4mH7AQQf
X-Authority-Info-Out: v=2.4 cv=eb0wvrEH c=1 sm=1 tr=0 ts=69b3afcd
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=BgHGX5qg4qM5eV3fwTMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MSBTYWx0ZWRfXzq5OcYYF50hT
 UwYkz7p7VWADtzdtsyPi1ovY6Zg4+VaqMGw+Y4ebhroHz7SzvCGB80NOBQnRToEUbZRtenDliTy
 92B8ZKg6vmGhbLnFw4A9O6/wPk5rvUHHOPasr2dimzbMB2CtsGhcLcqR1+EmbkWNowYusuP8aHg
 0wtUgpEWHRovVVcN3pDZTuQAMZ3zstWlwZGyixK7zUEkFPm3ExvUM499iFA7Py7L5thTj9wu9uK
 RdedHQp7Tzd1vEgxOxwsLmh55A9jjUS6bdsAy/Wd9gbgf7oDLGh6F2Lp9HwmfIIT6qBDSp47ZmN
 tYEtG1nyDWp0MdED986DHxlWII/0yuQNXwa4Z75wSCNiZFM2nVG230OKehj2ow=
X-Proofpoint-GUID: 6spvLzFyk5RvZTski4mm2ncj4mH7AQQf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603130051
X-JNJ: AAAAAAABwK8V5vWXzu5iKcv5/ZWGF2n8+TABDBUsRIMw1x5M3Ir8WNVStxKjQJZWLhblGDNpoWEEwLFddzg9LLM0vKhQ23x7TDM0GiJL/tUFmu05WuN3wL07ZHdUAdhkfwx6KeELrj3PVXmb+GvJMKh924MlmV1YiO8GEZ/tTGPZf0fCi9c+x79d47duUjl9jNE0NDbCkvcBcWrLGr6yoik1O40mFmPAF3L19xwKjLdrGjW83LX1cwWkZlCKbxlNnpQDESZjVco26RnMazWsjHFPevhOo1Q2hNOnH6D4J7Dxc4CfWOKfjNvmFDPCzujLny9bH+DrT8BJfBkmvlrLne2GG/rvthC5/PXsyzUm9txU7HDy0m5FIdUCFb3BPGwYcpFkKkqRxSk5JOZ/Cd7y8gBT9GWFBDmIgVNiQd89UMklnBkYHcgAEMi0bEftDEavalAQMlXgmSvjqbKkTqz988BuJvvscIt5KahFEFaYcCK3EimXoUjVY8eUh60kp6KjLuR0T6L1XR8492m5DswqTuaj9XtdnN3PfV+tjvyCwA6CTeMabaWhTLFRfBk9g1rA7bf5p6njrgwFlVW0oisZpXCt3e8wULlI29bLcx9VPJy5xp9BNxfEIf345qyBobayEgJ+uX8Edp5OOEzAErsKlp6oRXfRgBGxMwUi9ZPo30ZN3t6zEvdekqg=
Received-SPF: pass client-ip=57.103.76.175;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 13. Mar 2026, at 03:18, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>=20
> Add a shared emulation library in target/arm/emulate/ using a
> decodetree decoder (a64-ldst.decode) and a callback-based interface
> (struct arm_emul_ops) that any hypervisor backend can implement.
>=20
> The hypervisor cannot emulate ISV=3D0 data aborts without decoding the
> faulting instruction, since the ESR syndrome does not carry the access
> size or target register.
>=20
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
[=E2=80=A6]
> +/**
> + * struct arm_emul_ops - hypervisor register/memory callbacks
> + *
> + * GPR reg 31 =3D SP (the XZR/SP distinction is handled internally).
> + * Memory callbacks use guest virtual addresses.
> + */
> +struct arm_emul_ops {
> +    uint64_t (*read_gpr)(CPUState *cpu, int reg);
> +    void (*write_gpr)(CPUState *cpu, int reg, uint64_t val);
> +
> +    /* @size: access width in bytes (4, 8, or 16) */
> +    void (*read_fpreg)(CPUState *cpu, int reg, void *buf, int size);
> +    void (*write_fpreg)(CPUState *cpu, int reg, const void *buf, int =
size);
Hello,

Can be good to have, but you should have a default implementation using =
CPUState in an arm_helpers
to not duplicate them across each backend. and then do an =
if(ctx->ops->read_gpr) { use override } else { default }
with a default implementation.

> +
> +    /* Returns 0 on success, non-zero on failure */
> +    int (*read_mem)(CPUState *cpu, uint64_t va, void *buf, int size);
> +    int (*write_mem)(CPUState *cpu, uint64_t va, const void *buf, int =
size);
> +};

A memory access - especially one that will be emulated - can span =
multiple (physical) pages under
the hood. If everything is mapped you=E2=80=99re fine, but that=E2=80=99s =
a bit depending on precious luck, especially
as the AArch64 glibc does unaligned accesses on memcpy.

On x86 side of things, was able to run Windows (NT) and Linux but not =
Haiku, (the Hurd needs more complexity that I don=E2=80=99t even handle =
yet for x86), and Win9x without handling such a fault case.

And there are memory to memory instructions on the way (FEAT_MOPS) where =
that=E2=80=99s even more likely to happen.
The downside of read_mem/write_mem is even if you return a fault code, =
you don=E2=80=99t know which one of the two pages
(or more potentially for memory-to-memory instructions) raised the =
fault.

Made a design change away to an mmu_gva_to_gpa callback and not having =
read/write ops anymore like this because of that factor (see =
target/i386/emulate/x86_mmu.c x86_write_mem_ex/x86_read_mem_ex)

Maybe you could keep a read_mem/write_mem matching those two on top of =
mmu_gva_to_gpa for your unit tests. Or run those
in a guest context as kvm-unit-tests does.

Thank you,
> +
> +/**
> + * arm_emul_insn - decode and emulate one AArch64 instruction
> + *
> + * Caller must synchronize CPU state and fetch @insn before calling.
> + */
> +ArmEmulResult arm_emul_insn(CPUState *cpu, const struct arm_emul_ops =
*ops,
> +                            uint32_t insn);
> +
> +#endif /* ARM_EMULATE_H */
> diff --git a/target/arm/emulate/meson.build =
b/target/arm/emulate/meson.build
> new file mode 100644
> index 0000000..29b7879
> --- /dev/null
> +++ b/target/arm/emulate/meson.build
> @@ -0,0 +1,16 @@
> +gen_a64_ldst =3D decodetree.process('a64-ldst.decode',
> +    extra_args: ['--static-decode=3Ddecode_a64_ldst'])
> +
> +arm_common_system_ss.add(when: 'TARGET_AARCH64', if_true: [
> +    gen_a64_ldst, files('arm_emulate.c')
> +])
> +
> +# Static library for unit testing (links emulation code + decodetree =
decoder)
> +arm_emulate_test_lib =3D static_library('arm-emulate-test',
> +    sources: [files('arm_emulate.c'), gen_a64_ldst],
> +    dependencies: [qemuutil],
> +    include_directories: include_directories('.'))
> +
> +arm_emulate_test =3D declare_dependency(
> +    link_with: arm_emulate_test_lib,
> +    include_directories: include_directories('.'))
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 6e0e504..a4b2291 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -57,6 +57,7 @@ arm_common_system_ss.add(files(
>   'vfp_fpscr.c',
> ))
>=20
> +subdir('emulate')
> subdir('hvf')
> subdir('whpx')
>=20
> --=20
> 2.52.0
>=20
>=20


