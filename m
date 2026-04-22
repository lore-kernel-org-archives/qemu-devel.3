Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59618F9B60B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV4Q-0001w8-DS; Wed, 22 Apr 2026 06:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFV3y-0000Tz-S7
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:18 -0400
Received: from p-east2-cluster5-host1-snip4-8.eps.apple.com ([57.103.79.11]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFV3v-0003Da-Ow
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:10 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-4 (Postfix) with ESMTPS id
 6CC6B1800417; Wed, 22 Apr 2026 10:44:05 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRAEwVSB11NVg1HD1geXBQXC0dDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTHpABi4EKXM1FE8HWA9GBjR4SB4vBCkAXXpJAlpyWHFDDjt2VXceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776854646; x=1779446646;
 bh=UYGshsVpXsiTJgLMvkXMm2iq6dV3ukV2xgw2p6SYvPY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=LcEs1D3V4L12SzzS6rr/YdXs/sXwHchcZ9aSZpd9u5gaY+5955olQ4K1cegS4aPjSoGy/JhoExKRN9ghVyuk7Uxcpb5ChbEgUZgo63Eea/TZJ0cjX8mmVg5xta5MlXzwpSVi1I9UbsIWJHTqjkVN7pNDn6HhjCGQGQz0zZggekLMAOmHrpiWT+Fkq27ujC+TbgPsr4cRP0S4iLaMyAYjdkp+z+t3iKGZ/jbEfWdNMn+z4lF4AfOIxGr44fD6aeehaDRmrsu5DCYG2URF+GPaPjxLiiirQwuyBAiV30i8JrhCf0RPlogaChl+ql0uqgRml5chr5pcQ+sUABxc/mA97A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-4 (Postfix) with ESMTPSA id
 88CF71800097; Wed, 22 Apr 2026 10:44:01 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2] whpx: i386, arm: do partition reset on boot CPU reset
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260421205749.55060-1-mohamed@unpredictable.fr>
Date: Wed, 22 Apr 2026 12:43:49 +0200
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C85C3BAE-7458-4DA0-B3B2-C117E3C37CE8@unpredictable.fr>
References: <20260421205749.55060-1-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=KoZAGGWN c=1 sm=1 tr=0 ts=69e8a676
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=A3C6YRHjnLZ7LpmBN_kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: JHnvgY1GcBfyXxfaVNhnI9TpW9_MBqsj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEwMiBTYWx0ZWRfXwdnAShNmmHzN
 Qj4dZ3bdjFe4uSCWH4jPKppEIV3UEVQasKC0kxg/w9oWy1Q4OwD0WsomaVU1TKLEQ0RgRG5PfrY
 mL/v2LtwGE67d8Xdu/FkzCLn3jX21hW8ATZr7xljCs8j/txue+IMTysB4ANWkmQy9+2Kahk5JJT
 S9fcJdSO9W3kDHXLZ6J6g34q8Ze2pHHnb/E9w2rz74gFeO4q2FtFjIwbVvspZkQl1Q62QZygdlT
 d4mJnJZFGxA/c90gtMvaNBLXV0dDN+fGEpv+ANh4Up8el5Db9r/eiLoAvIY19v+G2+dWmtyBKMJ
 +/qXtatGXG/7bcVwW5xuORmC48ONHOu6ZeMii5Jo09HWr5/8SvzMpSNsOdu6xM=
X-Proofpoint-ORIG-GUID: JHnvgY1GcBfyXxfaVNhnI9TpW9_MBqsj
Received-SPF: pass client-ip=57.103.79.11;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 21. Apr 2026, at 22:57, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> WHvResetPartition resets partition state, and is not supported on =
Windows 10.
>=20
> On Arm, it's supposed to be used for reboots. The prior location of =
the
> WHvResetPartition call wasn't right, as other vCPUs might still have
> been running, causing the call to fail.
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
cc qemu-stable@

I believe this one is a good candidate for qemu-stable too

> ---
> accel/accel-system.c       |  9 +++++++++
> accel/whpx/whpx-common.c   | 13 +++++++++++++
> include/accel/accel-ops.h  |  1 +
> include/qemu/accel.h       |  3 +++
> system/runstate.c          |  5 +++++
> target/arm/whpx/whpx-all.c |  2 --
> 6 files changed, 31 insertions(+), 2 deletions(-)
>=20
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index 150af05bf5..5352ccd937 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -75,6 +75,15 @@ void accel_pre_resume(MachineState *ms, bool =
step_pending)
>     }
> }
>=20
> +void accel_reset(MachineState *ms)
> +{
> +    AccelState *accel =3D ms->accelerator;
> +    AccelClass *acc =3D ACCEL_GET_CLASS(accel);
> +    if (acc->reset_vm) {
> +        acc->reset_vm(accel);
> +    }
> +}
> +
> /* initialize the arch-independent accel operation interfaces */
> void accel_init_ops_interfaces(AccelClass *ac)
> {
> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> index 6fe44d5910..1f7b7d764d 100644
> --- a/accel/whpx/whpx-common.c
> +++ b/accel/whpx/whpx-common.c
> @@ -205,6 +205,18 @@ static void =
do_whpx_cpu_synchronize_pre_loadvm(CPUState *cpu,
>     cpu->vcpu_dirty =3D true;
> }
>=20
> +/*
> + * Partition support
> + */
> +
> +static void whpx_partition_reset(AccelState* as)
> +{
> +    struct whpx_state *whpx =3D &whpx_global;
> +    if (whp_dispatch.WHvResetPartition) {
> +        whp_dispatch.WHvResetPartition(whpx->partition);
> +    }
> +}
> +
> /*
>  * CPU support.
>  */
> @@ -622,6 +634,7 @@ static void whpx_accel_class_init(ObjectClass *oc, =
const void *data)
>     ac->name =3D "WHPX";
>     ac->init_machine =3D whpx_accel_init;
>     ac->pre_resume_vm =3D whpx_pre_resume_vm;
> +    ac->reset_vm =3D whpx_partition_reset;
>     ac->allowed =3D &whpx_allowed;
>=20
>     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
> diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
> index f46492e3fe..a1c9f3ae7b 100644
> --- a/include/accel/accel-ops.h
> +++ b/include/accel/accel-ops.h
> @@ -33,6 +33,7 @@ struct AccelClass {
>     /* system related hooks */
>     void (*setup_post)(AccelState *as);
>     void (*pre_resume_vm)(AccelState *as, bool step_pending);
> +    void (*reset_vm)(AccelState *as);
>     bool (*has_memory)(AccelState *accel, AddressSpace *as,
>                        hwaddr start_addr, hwaddr size);
>=20
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index d3638c7bfd..0e12aea7db 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -54,6 +54,9 @@ void accel_setup_post(MachineState *ms);
>=20
> void accel_pre_resume(MachineState *ms, bool step_pending);
>=20
> +/* Reset accelerator state. */
> +void accel_reset(MachineState *ms);
> +
> /**
>  * accel_cpu_instance_init:
>  * @cpu: The CPU that needs to do accel-specific object =
initializations.
> diff --git a/system/runstate.c b/system/runstate.c
> index 2d4e95a216..734e3c037c 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -564,6 +564,11 @@ void qemu_system_reset(ShutdownCause reason)
>         qapi_event_send_reset(shutdown_caused_by_guest(reason), =
reason);
>     }
>=20
> +    if (current_machine) {
> +        /* Tell the accelerator that the VM is being reset. */
> +        accel_reset(current_machine);
> +    }
> +
>     /*
>      * Some boards use the machine reset callback to point CPUs to the =
firmware
>      * entry point.  Assume that this is not the case for boards that =
support
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 4019a513aa..f345fea4fe 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -472,8 +472,6 @@ int whpx_vcpu_run(CPUState *cpu)
>             if (arm_cpu->power_state !=3D PSCI_OFF) {
>                 whpx_psci_cpu_off(arm_cpu);
>             }
> -            /* Partition-wide reset, to reset state for reboots to =
succeed. */
> -            whp_dispatch.WHvResetPartition(whpx->partition);
>             bql_unlock();
>             break;
>         case WHvRunVpExitReasonNone:
> --=20
> 2.50.1 (Apple Git-155)
>=20


