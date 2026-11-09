Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E9606D802
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=P1AiP35R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPrB-0004H8-Nl; Mon, 09 Nov 2026 08:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPr8-0004Gz-PQ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:56:19 -0500
Received: from mr-2002g-snip6-1.eps.apple.com ([2a01:b747:3000:201::4c]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPr5-00078W-KW
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:56:17 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 B4C8C1800A71; Mon, 09 Nov 2026 13:56:10 +0000 (UTC)
X-ICL-RepId: 01a1c098-5335-79d3-8b19-52d135f257b2
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0YZEFYBWFZdBU0aXBhZDxwdS1ZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXADZ4SABdACofMQA9cEADXXE2FDkLWQJGAzN/OwMpdVJ3Mn1JcxhZG0AVXRFQGVYJXhUXHkFTFx9LAFxFUBhEH10dZhxcAFYCXA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794232573; x=1825768573;
 bh=BVAopLNWYUaM4PE0yQ2tpTkWa9GbVdlTZAfjAn0MTto=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=P1AiP35Rh7KC8jVy2qR1G9zv2kmaR+0YVjvd21Boioy+GLk+VF0hdb5adDgjTdJ3iFwgSradehMsFpURR0GU9FYrPK9vX9gj+H1J7k9mdKF4oQubXoUwXkRCpi1yTYfq4jw/HLCa83qI2tSxoSldCwC7s6SzGrPagVU3BAYIAh/scSReuVrlHxvi8Y8woe2potxZDiaQcS+VM5FB7Zcz7jpB9/wXso3B8Xgbz9qdt4DmA5ZwngKyyRLprD5rsyTFPMyyvhe0Y/2X0t5fh5bNLHK4UlUGK4ven7dpiqAtAKhHPXTg8LQtJoOKg37GGKpJNMFregvY0jxLMjF5apFRpg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 E6A801800245; Mon, 09 Nov 2026 13:56:09 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] target/i386/mshv: add MshvPutState for vcpu writes
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261109123949.724711-1-magnuskulke@linux.microsoft.com>
Date: Mon, 9 Nov 2026 06:55:58 -0700
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2FA0307A-A9EC-46CF-A845-1CFC0DB9EBD1@unpredictable.fr>
References: <20261109123949.724711-1-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NSBTYWx0ZWRfX118IN3zlUHbO
 GF5pHlM9aVqqkwtIQPKu4TWbVpb6nl0o7O9Y4doyqXShr2EUdED53H2N5/mSBgNrmqegM1wXJeC
 NolC8MifcHLY0UWJVEWuVH183npsD5oebX4vfj63IOa+6nH3GZdVBCUyh929VRQOHei5QYCXrL2
 y+aMPVm9TYnjUai/gZWj68CQe4bYB8OYvmbP4zfYRyYfPFghPx9frWSADlFbmC2SHUX+YSVMS5i
 UuIcyVQozH6/9kfAbvJN963DD/lqixyJanXhd9TemgftClFRxgZwDjjzMKhKFfE259KUxLWOff0
 D7lGgZvcEFGaxiRCEO+zBzvBwqWdsqsgWoHJWXhJj6jAE86tCBbuqbSYVUmaiU=
X-Proofpoint-GUID: Cz9EYU-9m6C3qIFFjuinJF8jr7Y3DA7Q
X-Proofpoint-ORIG-GUID: Cz9EYU-9m6C3qIFFjuinJF8jr7Y3DA7Q
X-Authority-Info-Out: v=2.4 cv=R7cO2NRX c=1 sm=1 tr=0 ts=6af1d0fb
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=ufr-9I5Dso90jVsVrLoA:9
 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-JNJ: AAAAAAABsW1Bedlg8U+iHG96KOqaRFUrY4ZQ7oL1VeKY/YZWl4M2sNdyORNbE5RKwMmrfw
 TRch5+s7Nwrc+wWXGvUv7KyxjhTt+BdivoRf+fAlsMoYbdXClJxuYuCzl9Afp4PAm5vPlo
 BjSXjzOaNtChpk6V2TV1Rmf8VCITC/yJM47+BI2b1zD7exfCFQIutYSK400fXhcCMpnSkP
 08s1Sju7ePJ2dipNKlfPYIv0h+sArh5cjZNIvto9cXfkc2l+3XJf0m0gUVoDrwaLdgeVhB
 9q9a9dJ5T2AF9Wk0L7e/kEZH3u8rdX327Y42k6V4I16K+06wtcmuxFk/QIROoxLF4rcoPU
 +SZxM7SxnP4nnux9gtye5hJi4ihWY3hN4rMN00m7WDVvL5n1AdajdUCwUoWWu8MMUiG+FU
 0Bhj5jNHgn4PuiUjACqz3bPOMz/w/oN7Ps2zuZ0j9OSOqU8jinBA97dIZFR1saPSXztbG3
 18vQ2Y0W6A26Pr9Pwo55ZBVJK5Nxwi4hemqDyum1FJnJKWU061t72woL/lIhxsDRxoeWfD
 ORqTbFmkuf7kbiLc19vLL3z98XmAVzH++YWyYN/VOMUBmtoTfQ8MLcdpPLZwEqWLb1gD93
 VunbGPNmpBKv+yKCc88Bwf9NJFbTjpKfTHqPE4vTsA40pCRflFqD7NJ6uGN8M9gZahpkg7
 f+haL5/5WRhLeJpWGlUS6EBEapdn6tE6c8vP5Q8DstUf0J51XQma1nLOIe21/KKrIzSE+Y
 Vo3CWuvGiL1CCI9Mvi0i5zE21yoOmHcMh4cnJjWf5TpgKRfMYetsLxevbGV4LnzM8iZEny
 uzxHXODilPfoO3CctlSK+GNMLZyet4hAT6sit4sPk9mSBLMa4gIz38mbNFrXEeVRzjoxzs
 9iUyWODsZP4g4jReSIcCfFQ0QXkVnLHEW6uVnMhZCmzcZobpCDEe7LZ5wVaFjRPdNgvvpC
 +KxcwRVjpF73B/D0eF3xVxG9+Phq9Vk4ShbeH6WaWryUcIG0GxdfxXyCo8T4mj4ndn7jeu
 /8gwI3O6ZUBj9F3RArV0h8PxHbrBDIuptPmBpEVbkg8Dpy3F3XJZvT67Vx4y98iv0O8+/S
 kMdDSk1g/8ZR+qAyulfefmGsHioflQY0FzZRl9WSsbIH3oH9AJ8w+pd9qWDEVb6DiGLaZO
 SrqcbCa7CePEh9CvUPbgkqkmbp4pxkBmlyMPF0RAN8z7tcwX6e5KSgTq3pCG0F3S8V5n4k
 IS/qi7eF49tKsVWxLJ3uzbS40vmA7094dYDPlprW4ozzxc7yn9tNj2QWW3L8Pd2aSUrlhn
 c+DubQzO9fZ+7gZgGRNl2t+im6lC960HNnMaHsjU+UMCBszPvLh3UCLOJ10UkJm/ntoNz6
 0CdsaT0fG6sLHcHzSRtwMB6EsfN+Cax8Qi3/RT56E4R8s3y4RPOR0OAAFS+4sKQWe9YRWB
 c=
Received-SPF: pass client-ip=2a01:b747:3000:201::4c;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 9. Nov 2026, at 05:39, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> Currently QEMU marks a vcpu state as dirty also on merely inspectional
> reads, e.g. via "info registers", which triggers a writeback to the
> hypervisor. For MSRs that cause a side-effect when written to this is
> undesired.
>=20
> We introduce an MshvPutState flag into the writeback logic to =
differentiate
> "runtime" from "full" and "reset" writebacks that should occur e.g. =
after
> a migration or startup.
>=20
> Discrete side-effectful MSRs are excluded in runtime writebacks. So =
far
> we only mark one MSR as not runtime-safe, but probably more will be
> added eventually.
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> ---
> accel/mshv/mshv-all.c       | 10 +++++-----
> include/system/mshv_int.h   | 13 +++++++++++--
> target/i386/mshv/mshv-cpu.c | 10 ++++++++--
> target/i386/mshv/msr.c      | 21 ++++++++++++++++++++-
> 4 files changed, 44 insertions(+), 10 deletions(-)
>=20
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index d820a67b95..d64599e2e2 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -759,10 +759,10 @@ static int mshv_cpu_exec(CPUState *cpu)
>=20
>     do {
>         if (cpu->vcpu_dirty) {
> -            ret =3D mshv_arch_store_vcpu_state(cpu);
> +            ret =3D mshv_arch_store_vcpu_state(cpu, =
MSHV_PUT_RUNTIME_STATE);
>             if (ret) {
> -                error_report("Failed to put registers after init: =
%s",
> -                              strerror(-ret));
> +                error_report("Failed to put registers at runtime: =
%s",
> +                             strerror(-ret));
>                 ret =3D -1;
>                 break;
>             }
> @@ -890,7 +890,7 @@ static void mshv_start_vcpu_thread(CPUState *cpu)
> static void do_mshv_cpu_synchronize_post_init(CPUState *cpu,
>                                               run_on_cpu_data arg)
> {
> -    int ret =3D mshv_arch_store_vcpu_state(cpu);
> +    int ret =3D mshv_arch_store_vcpu_state(cpu, MSHV_PUT_FULL_STATE);
>     if (ret < 0) {
>         error_report("Failed to put registers after init: %s", =
strerror(-ret));
>         abort();
> @@ -906,7 +906,7 @@ static void =
mshv_cpu_synchronize_post_init(CPUState *cpu)
>=20
> static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
> {
> -    int ret =3D mshv_arch_store_vcpu_state(cpu);
> +    int ret =3D mshv_arch_store_vcpu_state(cpu, =
MSHV_PUT_RESET_STATE);
>     if (ret) {
>         error_report("Failed to put registers after reset: %s",
>                      strerror(-ret));
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index 1f77ffd152..b7b7c56443 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -98,6 +98,15 @@ typedef enum MshvVmExit {
>     MshvVmExitDebug    =3D 3,
> } MshvVmExit;
>=20
> +typedef enum MshvPutState {
> +    /* state subset only touched by the VCPU itself during runtime */
> +    MSHV_PUT_RUNTIME_STATE =3D 1,
> +    /* state subset modified during VCPU reset */
> +    MSHV_PUT_RESET_STATE =3D 2,
> +    /* full state set, modified during initialization or on vmload */
> +    MSHV_PUT_FULL_STATE =3D 3,
> +} MshvPutState;
> +
> void mshv_init_mmio_emu(void);
> int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
> void mshv_remove_vcpu(int vm_fd, int cpu_fd);
> @@ -107,7 +116,7 @@ int mshv_set_generic_regs(const CPUState *cpu, =
const hv_register_assoc *assocs,
>                           size_t n_regs);
> int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
>                           size_t n_regs);
> -int mshv_arch_store_vcpu_state(const CPUState *cpu);
> +int mshv_arch_store_vcpu_state(const CPUState *cpu, MshvPutState =
state);
> int mshv_arch_load_vcpu_state(CPUState *cpu);
> int mshv_arch_set_partition_msrs(const CPUState *cpu);
> int mshv_arch_set_mp_state(const CPUState *cpu);
> @@ -152,7 +161,7 @@ void mshv_log_global_stop(MemoryListener =
*listener);
> /* msr */
> int mshv_init_msrs(const CPUState *cpu);
> int mshv_get_msrs(CPUState *cpu);
> -int mshv_set_msrs(const CPUState *cpu);
> +int mshv_set_msrs(const CPUState *cpu, MshvPutState put_state);
>=20
> /* synic */
> int mshv_get_simp(int cpu_fd, uint8_t *page);
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 4df73bb497..72ef01a597 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1511,7 +1511,13 @@ static int set_synic_state(const CPUState *cpu)
>     return 0;
> }
>=20
> -int mshv_arch_store_vcpu_state(const CPUState *cpu)
> +/*
> + * The put_state param is passed to decide whether we need a full =
restoration
> + * of all registers (e.g. after a migration ) or just a subset during =
runtime
> + * (e.g after "info registers"). The latter should avoid writing =
registers that
> + * cause a side-effect.
> + */
> +int mshv_arch_store_vcpu_state(const CPUState *cpu, MshvPutState =
put_state)
> {
>     int ret;
>=20
> @@ -1541,7 +1547,7 @@ int mshv_arch_store_vcpu_state(const CPUState =
*cpu)
>         return ret;
>     }
>=20
> -    ret =3D mshv_set_msrs(cpu);
> +    ret =3D mshv_set_msrs(cpu, put_state);
>     if (ret < 0) {
>         return ret;
>     }
> diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
> index 96bd552916..a06844cc99 100644
> --- a/target/i386/mshv/msr.c
> +++ b/target/i386/mshv/msr.c
> @@ -324,6 +324,20 @@ static bool msr_supported(uint32_t name)
>     return true;
> }
>=20
> +static bool msr_is_runtime_safe(uint32_t name)
> +{
> +    switch (name) {
> +    /*
> +     * HV_X64_REGISTER_TSC will invalidate the guest's tsc_page if =
written to
> +     * while the guest's timer is not frozen.
> +     */
> +    case HV_X64_REGISTER_TSC:
> +        return false;
> +    default:
> +        return true;
> +    }
> +}
> +
> int mshv_get_msrs(CPUState *cpu)
> {
>     int ret =3D 0;
> @@ -406,13 +420,14 @@ static void load_from_env(const CPUState *cpu, =
struct hv_register_assoc *assocs,
>     load_from_env_mtrr_phys(cpu, &assocs[mtrr_offset], =
MSHV_MTRR_MSR_COUNT);
> }
>=20
> -int mshv_set_msrs(const CPUState *cpu)
> +int mshv_set_msrs(const CPUState *cpu, MshvPutState put_state)
> {
>     size_t n_assocs =3D MSHV_MSR_TOTAL_COUNT;
>     struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT] =3D { 0 };
>     int ret;
>     size_t i, j;
>     X86CPU *x86cpu =3D X86_CPU(cpu);
> +    bool runtime =3D (put_state <=3D MSHV_PUT_RUNTIME_STATE);
>=20
>     load_from_env(cpu, assocs, n_assocs);
>=20
> @@ -432,6 +447,10 @@ int mshv_set_msrs(const CPUState *cpu)
>             continue;
>         }
>=20
> +        if (runtime && !msr_is_runtime_safe(name)) {
> +            continue;
> +        }
> +
>         if (j !=3D i) {
>             assocs[j] =3D assocs[i];
>         }
> --=20
> 2.34.1
>=20
>=20


