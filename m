Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207F3112584D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LbF-000235-Iz; Wed, 11 Mar 2026 11:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LbD-00022D-O4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:35:51 -0400
Received: from p-east2-cluster5-host9-snip4-10.eps.apple.com ([57.103.79.113]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LbB-00075G-DG
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:35:51 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 25355180013B; Wed, 11 Mar 2026 15:35:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773243348; x=1775835348;
 bh=TzKrkDWOlhtmm7tH/mlMEMfhYilN7OwB6AE6rM9DLIg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=dIwzkzJT/l/y/bUexzpCt4Gy1fXwhcsZz0lKODA3JKcdnireLjyZStwXin6iPkXvKUIHFZrKLZr9UCZPUbzp1dUvEWG1i/P17WWeQNpDjS9eHz4pjkHjtFfjjNOM0jBUUoCOIwUoeJJCtotwUHE0pL0kdWpTgj9bWQSd/ZyIzV7i2U1MwLrNB6H8QmMdhXlP/+dApyNOpRyYINRxiFnZfM+sdrM33AVShO2GFzeIL+SjRDO4N9OV/aGs4MwMgEIFX2DYL1Io6YWsMFG+ExOjxtWuoPy2ruq47eTzTMw67yI3TGc1KUZgOLNqmX6irbuyXHvxt1jef+6CsyxyBkcQWQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 204951800A95; Wed, 11 Mar 2026 15:35:43 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 08/14] accel/mshv: Add access_vp_regs synthetic proc
 features
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-8-c31699b7bc1f@anirudhrb.com>
Date: Wed, 11 Mar 2026 16:35:31 +0100
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <199EF957-0EBD-4E14-8453-1C5FA5B14063@unpredictable.fr>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-8-c31699b7bc1f@anirudhrb.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: _vzbpcvr6Fgemkqvu5gpOCHtiox8qxuO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzMiBTYWx0ZWRfX3/yRhPc6CslZ
 ESXXOMvP7L3x3cT6TKsgOMmDDcfzylgth/mWBjttmDPe5POjzlzNU8GJ9Jf4VDU9zVGzJl12kaU
 yUVk3Svud6kRrWyfGBqQ2zywIM+Ur2eixbvgdOK+FWIl0LF8C1BWzMYzGiighcN2Mruy/syS7Vz
 5n5DhBFzFUGAYMpeLhALCnHGXAnT2U8xFdgtTwM5cf0WL9KgY8NoUud1iEZdj4PoIwkI0VSXDie
 9lxIJUjE4R+CNPH7+TrewOTSt7ekT/LGr7/3UAkc3h9eUJ4Bhc6SjK/2sR/ffmpm0xFzmhx9yFZ
 FgJQKSp51g8n9SEztEFOnXqMteDN8dA42pRNchWL1LFWBEWGAzFsOnmS9M6nrw=
X-Authority-Info-Out: v=2.4 cv=fZSgCkQF c=1 sm=1 tr=0 ts=69b18bd2
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tFGNSmrwAAAA:8 a=yMhMjlubAAAA:8
 a=G09DolKwbnnguhN-VPsA:9 a=CjuIK1q_8ugA:10 a=LpD6Tdepsyerr7eS-Jg7:22
X-Proofpoint-ORIG-GUID: _vzbpcvr6Fgemkqvu5gpOCHtiox8qxuO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=842
 phishscore=0 spamscore=0 suspectscore=0
 clxscore=1030 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110132
X-JNJ: AAAAAAABfjKIMR0gd9gr0RB7x5hxfJIwN2XkXznlBEA9/4Tv8WPMsAuB5APInyoNyuSFaeMYTo4n/uBR28FpQ8gT6AAluuNQjergdRyhz9wPY0JppnwlTscGq8d10x7gnVsKImT6M4w8lsWcT/KSpyTywFQ0DCDSfvEHwN4Wl1T9U/b/XkPh/p2wvVXlHxwnupcoEjEN25UTKshzIGLMzJTEWAuM8MF825eQQzABdMJ9qwlmwok0WbkThVT9WLciVUEGZdVno2J8KcdSkKqlnJdtsPlHknKLIBOqjdtMSLXHnwflW9Et/AideCA3E3pZMlCVFlszuulCIMrfQGuT969/T4X0oJl+xcAYFkpK/ktD7PJTc4q5gwNQGwhoIpKY4t5eH6vp1d0htoqtDDTTpapusiwdy/miqdmClzAsXRUJULfgeCAGms2At5Hxyi/cTpBtORctv5aHoQ2OsfuXjWarZb29reGiNdZjT1vS+hqzgik0oGwU/Dc/bwlEGMDaEs5G66b/4KGGzmAi/88kgEi5Pbo6W/NDPBAVfjUbA6rzU6268qNfhkCNvDQaPWZ6JT22ojhITti62sVfdXzU4bwQQgOsCB/bWhMM9dbqXkmhilkeLE3v75mZW9+BhPqmif0pa3/6tPlkqH5TekiMSJV1nzkkiKvzH1Kd2XmD5KdIrVSOiuD7WQuChF3usSvVqWpkJ/Jvckx3LN8j4JW6V8ncJFnxEqPWpuEt7H7yI+8ehKSPsdVF8elGGP3kg2qkk7El+zeB7B3U5P/M8aZxUncCZhi/2Ne2o04h0IId2XbrygBNr/c=
Received-SPF: pass client-ip=57.103.79.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 11. Mar 2026, at 16:15, Anirudh Rayabharam <anirudh@anirudhrb.com> =
wrote:
>=20
> From: Aastha Rawat <aastharawat@linux.microsoft.com>
>=20
> Enable access_vp_regs feature for regs. In arm64, this feature bit
> allows the guest to set VP registers using hypercall. This wasn't
> required for x86 because such registers are set using wrmsr instead of
> hypercall.
>=20
Hello,

Could you split this into two patches? With the hvhdk.h changes in =
another patch.

> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> ---
> accel/mshv/mshv-all.c     |  1 +
> include/hw/hyperv/hvhdk.h | 87 =
+++++++++++++++++++++++++++++++++++++++++++++--
> 2 files changed, 85 insertions(+), 3 deletions(-)
>=20
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index d63b3a53bf..563599ef6a 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -199,6 +199,7 @@ static int set_synthetic_proc_features(int vm_fd)
>     features.tb_flush_hypercalls =3D 1;
>     features.synthetic_cluster_ipi =3D 1;
>     features.direct_synthetic_timers =3D 1;
> +    features.access_vp_regs =3D 1;
>=20
>     mshv_arch_amend_proc_features(&features);
>=20
> diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
> index 2e1ef80972..38af01f8ea 100644
> --- a/include/hw/hyperv/hvhdk.h
> +++ b/include/hw/hyperv/hvhdk.h
> @@ -94,11 +94,15 @@ union hv_partition_synthetic_processor_features {
>          */
>         uint64_t access_partition_reference_tsc:1;
>=20
> -        /*
> -         * Partition has access to the guest idle reg. Corresponds to
> +#if defined(__x86_64__)
> +
> +        /* Partition has access to the guest idle reg. Corresponds to
>          * access_guest_idle_reg privilege.
>          */
>         uint64_t access_guest_idle_reg:1;
> +#else
> +        uint64_t reserved_z10:1;
> +#endif
>=20
>         /*
>          * Partition has access to frequency regs. corresponds to
> @@ -110,11 +114,16 @@ union hv_partition_synthetic_processor_features =
{
>         uint64_t reserved_z13:1; /* Reserved for =
access_root_scheduler_reg */
>         uint64_t reserved_z14:1; /* Reserved for =
access_tsc_invariant_controls */
>=20
> +#if defined(__x86_64__)
> +
>         /*
>          * Extended GVA ranges for HvCallFlushVirtualAddressList =
hypercall.
>          * Corresponds to privilege.
>          */
>         uint64_t =
enable_extended_gva_ranges_for_flush_virtual_address_list:1;
> +#else
> +        uint64_t reserved_z15:1;
> +#endif
>=20
>         uint64_t reserved_z16:1; /* Reserved for access_vsm. */
>         uint64_t reserved_z17:1; /* Reserved for access_vp_registers. =
*/
> @@ -161,13 +170,85 @@ union hv_partition_synthetic_processor_features =
{
>         /* HvCallRetargetDeviceInterrupt is supported. */
>         uint64_t retarget_device_interrupt:1;
>=20
> +#if defined(__x86_64__)
>         /* HvCallRestorePartitionTime is supported. */
>         uint64_t restore_time:1;
>=20
>         /* EnlightenedVmcs nested enlightenment is supported. */
>         uint64_t enlightened_vmcs:1;
>=20
> -        uint64_t reserved:30;
> +        uint64_t nested_debug_ctl:1;
> +        uint64_t synthetic_time_unhalted_timer:1;
> +        uint64_t idle_spec_ctrl:1;
> +
> +#else
> +        uint64_t reserved_z31:1;
> +        uint64_t reserved_z32:1;
> +        uint64_t reserved_z33:1;
> +        uint64_t reserved_z34:1;
> +        uint64_t reserved_z35:1;
> +#endif
> +
> +#if defined(__aarch64__)
> +        /* Register intercepts supported in V1. As more registers are =
supported in future
> +         * releases, new bits will be added here to prevent migration =
between incompatible hosts.
> +         *
> +         * List of registers supported in V1:
> +         * 1. TPIDRRO_EL0
> +         * 2. TPIDR_EL1
> +         * 3. SCTLR_EL1 - Supports write intercept mask.
> +         * 4. VBAR_EL1
> +         * 5. TCR_EL1 - Supports write intercept mask.
> +         * 6. MAIR_EL1 - Supports write intercept mask.
> +         * 7. CPACR_EL1 - Supports write intercept mask.
> +         * 8. CONTEXTIDR_EL1
> +         * 9. PAuth keys (total 10 registers)
> +         * 10. HvArm64RegisterSyntheticException
> +         */
> +        uint64_t register_intercepts_v1:1;
> +#else
> +        uint64_t reserved_z36:1;
> +#endif
> +
> +        /* HvCallWakeVps is supported */
> +        uint64_t wake_vps:1;
> +
> +        /* HvCallGet/SetVpRegisters is supported.
> +         * Corresponds to AccessVpRegisters privilege.
> +         * This feature only affects exo partitions.
> +         */
> +        uint64_t access_vp_regs:1;
> +
> +#if defined(__aarch64__)
> +        /* HvCallSyncContext/Ex is supported. */
> +        uint64_t sync_context:1;
> +#else
> +        uint64_t reserved_z39:1;
> +#endif /* __aarch64__ */
> +
> +        /* Management VTL synic support is allowed.
> +         * Corresponds to the ManagementVtlSynicSupport privilege.
> +         */
> +        uint64_t management_vtl_synic_support:1;
> +
> +#if defined(__x86_64__)
> +        /* Hypervisor supports guest mechanism to signal pending =
interrupts to paravisor. */
> +        uint64_t proxy_interrupt_doorbell_support:1;
> +#else
> +        uint64_t reserved_z41:1;
> +#endif
> +
> +#if defined(__aarch64__)
> +        /* InterceptSystemResetAvailable is exposed. */
> +        uint64_t intercept_system_reset:1;
> +#else
> +        uint64_t reserved_z42:1;
> +#endif
> +
> +        /* Hypercalls for host MMIO operations are available. */
> +        uint64_t mmio_hypercalls:1;
> +
> +        uint64_t reserved:20;
>     };
> };
>=20
>=20
> --=20
> 2.43.0
>=20
>=20


