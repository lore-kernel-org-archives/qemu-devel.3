Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B10606A334
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7tX-0004Us-QW; Wed, 28 Oct 2026 13:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xM7tV-0004UY-Mc
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:57:01 -0400
Received: from st-2002c-snip6-2.eps.apple.com ([2a01:b747:3001:205::20]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xM7tS-0008Ue-P0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:57:01 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPS id
 1636818009F9; Wed, 28 Oct 2026 17:56:51 +0000 (UTC)
X-ICL-RepId: 01a183a8-5e2b-7f9f-a96e-6673afd64e72
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0ISxMFUgddTVYNRw9YHlwUFwtHQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wASAooDygBRhRJdS92RgZCCUweLwFecV0KOXFUBy8FRgg8Ayx3HlwASx1XBFQfUxJVHR0LRVUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793210215; x=1824746215;
 bh=LSTK9vy676YDV8UwA3vqC9RP/AGvkT2HMLELtHjkds8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=zhn2LBECIq4t1JkaF7Uu1GQFSCPsQbmDy4JS6aSM171tLwJkVwVvdnMLXs1rTpjYfe9RALiZzLHh3UzjrbA5Naz+o+D0rDnFlPLyteVrwVXwDP/Y9Ym9Fa5YWLBaTHk6tXW+dTX9CzrgdLniCNw9Pbt+5QlqcVfeQXUctieeVm69IzcCKJ904l8zLD0EM8xCM+01SVgkCF1o6vbgDLK1l6spRvj6MGJNqsntK+m7CLFTCN6I8I3ejO+vrlHA/VEx/YACUKrWujJPICFjYLX6BdFDfT4aY6Jw326nqAIFhgDYf5DD7NzKJGFG48hfeCxy6N82dCVwqYDKCeCWa62GZA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPSA id
 A0E6818014FA; Wed, 28 Oct 2026 17:56:49 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 3/4] target/i386/mshv: deliver legacy PIC interrupts
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261028125308.147630-4-magnuskulke@linux.microsoft.com>
Date: Wed, 28 Oct 2026 18:56:37 +0100
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <909E8C36-1FBA-4204-B65C-3AB90D761D0A@unpredictable.fr>
References: <20261028125308.147630-1-magnuskulke@linux.microsoft.com>
 <20261028125308.147630-4-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-GUID: T0tWOUf0SGxSt8tsBgUWzVztWm6lj9gP
X-Authority-Info-Out: v=2.4 cv=CLYnnBrD c=1 sm=1 tr=0 ts=6ae23765
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=1_48byShyMe1CpRlY9MA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfX+HZi1AX21/ex
 oXouR2BLzw66f2JLbL0FKa4GR/sv7z8ayej/BJn1TjP6gq956GTAK86ZeXsVb34iyMP/aBAPKBt
 cRk5Lgtbmahf8HARU49E/HOubdUKZhz67ML54TuqO7iT/+SUS51hDcjnMRmWFz69kONvoEPTAUT
 q7G2dftgdnLUpB28Y1/LV7DdWIKyBZbByhdSt4B0C7Mm1WIiprpkLBBDVOlUtDXMpyqjtRWMBO+
 Hwrr0YJcrddawMs5+Bo7WC4bBaZ5bHJwszZoeTHiJo2BDd2BEvZJB3PJFOhdPmCp4AzMJKPoAPQ
 RxwnNjLRxG4l7xTQRaAukEPdj82epPfo0ZIE9uZ4iajZRqyDMhF3nKmAXVzlLM=
X-Proofpoint-ORIG-GUID: T0tWOUf0SGxSt8tsBgUWzVztWm6lj9gP
X-JNJ: AAAAAAABhlNqElAKxlNleZDOYgjZRmD48SI3W/QkCEq0mUNifhDxnnQGfFrZ9nfKQO9tyz
 uGMk/+azM7iNVTAFJxCeHPZdqtWDSMA6fp8kJroQN4uVtkw8riyr+blMKQo5WkFs1G2nhl
 9izdaqe3Z/KHll/q69FAHbq9evTI1GQ9wJe0VCx9aQJG6OJ2yzj9LVCCA5fCWYwwrEkGkF
 61hKld38pFgAYNKTRWtda1cBK4k1c2BYj6+AyXF5zIjaiT8Q43ceNvLq8labnnGSywBQnA
 j7CGDFlSPbf6pIy/E89cbo4M9wwUa3+g0d81EIF6DsPLD6VeoTFkKCZfnaO+2wG3SIfNCv
 Brh7nTe7mrzrnR5kLS4GzHZVsGXgeSTjB2KF2SaKAL2nImZwyaiDtlgJfJ2fZUpngczX9D
 26mVhjp7Ou/DNKipG1T2Vl/dILL//qA5aI6b+DrDy9YwXKPr8Fqr/muE+wqhHENcJJyXpQ
 T+/TTD6UfHsLwdWHcw9BAmxzNxf45G28FFYRmMY2+FttaAtcB5cwg8M/FAFdjIVCbPzbGO
 4gEAul/zKVlwBXdLQO2eIzXgtnf66ZGJMN1If7n6lU7zwde17fcNPbxLbbNXYy18g3aRqs
 mQBpKHyQ/om2AIkCRWKxnKXEUEc74PX7Gc6lBviRwH6PyJuvbpMpBPzi3vRA+zz+esJewM
 mK2rtTuqDw4eedTtqh7JgtPgaI5SNJ5BOPNZBGdbwj3J8gAUEp6C0tB0Wm6C4VnT4VRs9C
 dd2uLt1H74cgcgERwycxqMsbXBoZC20B3K2akQpaR9MISmRkRl31mYn9+EgeEvY9HShx2T
 GZLoKnh068JtYlLQ/SDVm8py5bNfr3mTB4jvAyRl/GPPFw68mYj+PeM6jOeAiA6LSw9IVY
 Qecks4lT3qLi0C0zEFh38UG7PWYQAgBOUBeHw73iTXEWrR3hOHp2oZVgyFHgEaQACSktWP
 1CPEdyJpfZ6GklcpQm0rrRTY2Z2drWJDWexsurHKLsckegZcMkOTniCBpma4815sWTgWBa
 UdkVB3DMtlwYLdWLBBgIbFkn/ImW/7nWj2HvAz87KudYmQFVpVzQTVM12HqfDNHgexPBu3
 DKKoYTjOH1hhaiK8/r8uRxHsHmak9P1kz2sDGyLOtk1ejlTLzxNSU+l2Wbw9oCKl7bpCEX
 eh5VThSoI7lYwdu7rt1WjAR8TCOsGGbv29f6mheYtSLwlCB//irB2hWwfC2867X6bi2etd
 UWbnwQc7Pf4G1Z0PrMbEpJtZaf4xmF+7h+PcRWyIf6r3raxyql60fsB1yCb+rOsZgjbaFC
 bhocEfkcO6iJ56KTQ/0T+GoyV8i1fXks8otnMswvAPQGbvZv/3J3n8iORUK4Bi2g7rrwX8
 fJHPuj7ddOJnwB/fqeiSyl0xlklU01od1Pxi+hhjflTJ+5QRvH/qYDwbAXJNt+zTAy/PBD
 3AvqXm6wavYuKBwWutcCsh3sXs45Q/P0+oUO7BrbvElolquBFaSx1t0zyAUetUnhRUGnT/
 2fqi7pkRkiCPAHS6LdWaqlCyup+9foO9oi3bGB2Y
Received-SPF: pass client-ip=2a01:b747:3001:205::20;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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



> On 28. Oct 2026, at 13:53, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> To inject legacy interrupts in the MSHV accelerator, we have to =
request
> a "deliverability notification" once the PIC asserts an interrupt. =
Once
> we receive a INTERRUPTION_DELIVERABLE exit from the hypervisor we can
> proceed to acknowledge the interrupt and write to the PENDING_EVENT0
> register with EXT_INT event type and the respective vector.
>=20
> Since an interrupt is supposed to wake a vCPU stopped by HLT, we do
> clear the halt_suspend field of the INTERNAL_ACTIVITY_STATE register.

Keeping this bug on the Hyper-V side is a bit unfortunate. But oh =
well...
>=20
> We also need to consider pending EXT_INT events in migration,
> splitting the mapping of pending_exc into two discrete EXCEPTION and
> EXT_INT event types.
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> hw/i386/x86-cpu.c              |   9 +-
> include/hw/hyperv/hvgdk_mini.h |  42 ++++++++-
> include/system/mshv_int.h      |   1 +
> meson.build                    |   1 +
> target/i386/mshv/mshv-cpu.c    | 155 +++++++++++++++++++++++++++++++--
> target/i386/mshv/trace-events  |   7 ++
> target/i386/mshv/trace.h       |   2 +
> 7 files changed, 200 insertions(+), 17 deletions(-)
> create mode 100644 target/i386/mshv/trace-events
> create mode 100644 target/i386/mshv/trace.h
>=20
> diff --git a/hw/i386/x86-cpu.c b/hw/i386/x86-cpu.c
> index fba313376c..7b9299272a 100644
> --- a/hw/i386/x86-cpu.c
> +++ b/hw/i386/x86-cpu.c
> @@ -46,12 +46,8 @@ static void pic_irq_request(void *opaque, int irq, =
int level)
>=20
>     trace_x86_pic_interrupt(irq, level);
>=20
> -    if (mshv_irqchip_in_kernel()) {
> -        return;
> -    }
> -
>     if (cpu_is_apic_enabled(cpu->apic_state) && =
!kvm_irqchip_in_kernel() &&
> -        !whpx_irqchip_in_kernel()) {
> +        !mshv_irqchip_in_kernel() && !whpx_irqchip_in_kernel()) {
>         CPU_FOREACH(cs) {
>             cpu =3D X86_CPU(cs);
>             if (apic_accept_pic_intr(cpu->apic_state)) {
> @@ -77,7 +73,8 @@ int cpu_get_pic_interrupt(CPUX86State *env)
>     X86CPU *cpu =3D env_archcpu(env);
>     int intno;
>=20
> -    if (!kvm_irqchip_in_kernel() && !whpx_irqchip_in_kernel()) {
> +    if (!kvm_irqchip_in_kernel() && !mshv_irqchip_in_kernel() &&
> +        !whpx_irqchip_in_kernel()) {
>         intno =3D apic_get_interrupt(cpu->apic_state);
>         if (intno >=3D 0) {
>             return intno;
> diff --git a/include/hw/hyperv/hvgdk_mini.h =
b/include/hw/hyperv/hvgdk_mini.h
> index 0983e3a58d..e585661b2c 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -30,10 +30,11 @@ typedef enum hv_register_name {
>     HV_REGISTER_INTERNAL_ACTIVITY_STATE =3D 0x00000004,
>=20
>     /* Pending Interruption Register */
> -    HV_REGISTER_PENDING_INTERRUPTION =3D 0x00010002,
> -    HV_REGISTER_INTERRUPT_STATE      =3D 0x00010003,
> -    HV_REGISTER_PENDING_EVENT0       =3D 0x00010004,
> -    HV_REGISTER_PENDING_EVENT1       =3D 0x00010005,
> +    HV_REGISTER_PENDING_INTERRUPTION         =3D 0x00010002,
> +    HV_REGISTER_INTERRUPT_STATE              =3D 0x00010003,
> +    HV_REGISTER_PENDING_EVENT0               =3D 0x00010004,
> +    HV_REGISTER_PENDING_EVENT1               =3D 0x00010005,
> +    HV_REGISTER_DELIVERABILITY_NOTIFICATIONS =3D 0x00010006,
>=20
>     /* X64 User-Mode Registers */
>     HV_X64_REGISTER_RAX     =3D 0x00020000,
> @@ -313,6 +314,21 @@ union hv_x64_pending_exception_event {
>     };
> };
>=20
> +#define HV_X64_PENDING_EVENT_EXCEPTION 0
> +#define HV_X64_PENDING_EVENT_EXT_INT   5
> +
> +union hv_x64_pending_ext_int_event {
> +    uint64_t as_uint64[2];
> +    struct {
> +        uint64_t event_pending:1;
> +        uint64_t event_type:3;
> +        uint64_t reserved0:4;
> +        uint64_t vector:8;
> +        uint64_t reserved1:48;
> +        uint64_t reserved2;
> +    };
> +};
> +
> union hv_x64_pending_virtualization_fault_event {
>     uint64_t as_uint64[2];
>     struct {
> @@ -443,6 +459,17 @@ union hv_x64_interrupt_state_register {
>     };
> };
>=20
> +union hv_x64_deliverability_notifications_register {
> +    uint64_t as_uint64;
> +    struct {
> +        uint64_t nmi_notification:1;
> +        uint64_t interrupt_notification:1;
> +        uint64_t interrupt_priority:4;
> +        uint64_t reserved:42;
> +        uint64_t sints:16;
> +    };
> +};
> +
> union hv_intercept_suspend_register {
>     uint64_t as_uint64;
>     struct {
> @@ -469,6 +496,7 @@ typedef union hv_register_value {
>     union hv_x64_pending_interruption_register pending_interruption;
>     union hv_x64_msr_npiep_config_contents npiep_config;
>     union hv_x64_pending_exception_event pending_exception_event;
> +    union hv_x64_pending_ext_int_event pending_ext_int_event;
>     union hv_x64_pending_virtualization_fault_event
>         pending_virtualization_fault_event;
>     union hv_x64_register_sev_control sev_control;
> @@ -715,6 +743,12 @@ struct hv_x64_intercept_message_header {
>     uint64_t rflags;
> } QEMU_PACKED;
>=20
> +struct hv_x64_interruption_deliverable_message {
> +    struct hv_x64_intercept_message_header header;
> +    uint32_t deliverable_type;
> +    uint32_t reserved;
> +} QEMU_PACKED;
> +
> union hv_x64_io_port_access_info {
>     uint8_t as_uint8;
>     struct {
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index 1f77ffd152..d527cd8d77 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -45,6 +45,7 @@ typedef struct MshvHvCallArgs {
> struct AccelCPUState {
>     int cpufd;
>     MshvHvCallArgs hvcall_args;
> +    bool pic_interrupt_window;
> };
>=20
> typedef struct MshvMemoryListener {
> diff --git a/meson.build b/meson.build
> index bbef9d9c29..24caec97a9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3686,6 +3686,7 @@ if have_system or have_user
>     'target/hppa',
>     'target/i386',
>     'target/i386/kvm',
> +    'target/i386/mshv',
>     'target/i386/whpx',
>     'target/loongarch',
>     'target/mips/tcg',
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index e3c155da2e..7032e0f6ac 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -771,6 +771,7 @@ static int get_vcpu_events(CPUState *cpu)
>     union hv_x64_pending_interruption_register pending_int;
>     union hv_x64_interrupt_state_register int_state;
>     union hv_x64_pending_exception_event pending_exc;
> +    union hv_x64_pending_ext_int_event pending_ext_int;
>     int ret;
>=20
>     ret =3D mshv_get_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
> @@ -782,6 +783,7 @@ static int get_vcpu_events(CPUState *cpu)
>     pending_int.as_uint64 =3D assocs[0].value.reg64;
>     int_state.as_uint64 =3D assocs[1].value.reg64;
>     pending_exc =3D assocs[2].value.pending_exception_event;
> +    pending_ext_int =3D assocs[2].value.pending_ext_int_event;
>=20
>     /* Clear previous state. injected ints/excs are blanked w/ -1 */
>     env->interrupt_injected    =3D -1;
> @@ -841,14 +843,25 @@ static int get_vcpu_events(CPUState *cpu)
>         env->hflags2 &=3D ~HF2_NMI_MASK;
>     }
>=20
> -    /* HV_REGISTER_PENDING_EVENT0: pending exception not yet injected =
*/
> +    /* HV_REGISTER_PENDING_EVENT0: event not yet injected */
>     if (pending_exc.event_pending) {
> -        env->exception_pending     =3D 1;
> -        env->exception_nr          =3D pending_exc.vector;
> -        env->has_error_code        =3D =
pending_exc.deliver_error_code;
> -        env->error_code            =3D pending_exc.error_code;
> -        env->exception_has_payload =3D =
(pending_exc.exception_parameter !=3D 0);
> -        env->exception_payload     =3D =
pending_exc.exception_parameter;
> +        switch (pending_exc.event_type) {
> +        case HV_X64_PENDING_EVENT_EXCEPTION:
> +            env->exception_pending     =3D 1;
> +            env->exception_nr          =3D pending_exc.vector;
> +            env->has_error_code        =3D =
pending_exc.deliver_error_code;
> +            env->error_code            =3D pending_exc.error_code;
> +            env->exception_has_payload =3D =
pending_exc.exception_parameter !=3D 0;
> +            env->exception_payload     =3D =
pending_exc.exception_parameter;
> +            break;
> +        case HV_X64_PENDING_EVENT_EXT_INT:
> +            env->interrupt_injected =3D pending_ext_int.vector;
> +            break;
> +        default:
> +            error_report("unknown pending event type %u",
> +                         pending_exc.event_type);
> +            return -EINVAL;
> +        }
>     }
>=20
>     /*
> @@ -2091,6 +2104,119 @@ static int handle_exception_interrupt(CPUState =
*cpu,
>     return 0;
> }
>=20
> +static int set_pic_interrupt_window(CPUState *cpu, bool enabled)
> +{
> +    union hv_x64_deliverability_notifications_register notifications =
=3D { 0 };
> +    struct hv_register_assoc assoc =3D { 0 };
> +    AccelCPUState *cpu_state =3D cpu->accel;
> +    int ret;
> +
> +    notifications.interrupt_notification =3D enabled;
> +
> +    assoc.name        =3D HV_REGISTER_DELIVERABILITY_NOTIFICATIONS;
> +    assoc.value.reg64 =3D notifications.as_uint64;
> +
> +    /* we are already waiting for a PIC interrupt window */
> +    if (cpu_state->pic_interrupt_window =3D=3D enabled) {
> +        return 0;
> +    }
> +
> +    trace_mshv_set_pic_interrupt_window(cpu->cpu_index, enabled);
> +
> +    ret =3D mshv_set_generic_regs(cpu, &assoc, 1);
> +    if (ret < 0) {
> +        error_report("failed to set deliverability notifications =
register");
> +        return ret;
> +    }
> +
> +    cpu_state->pic_interrupt_window =3D enabled;
> +    return 0;
> +}
> +
> +static inline int request_pic_interrupt_window(CPUState *cpu)
> +{
> +    return set_pic_interrupt_window(cpu, true);
> +}
> +
> +static inline int clear_pic_interrupt_window(CPUState *cpu)
> +{
> +    return set_pic_interrupt_window(cpu, false);
> +}
> +
> +static int handle_interrupt_deliverable(CPUState *cpu,
> +                                        const struct hyperv_message =
*msg)
> +{
> +    CPUX86State *env =3D &X86_CPU(cpu)->env;
> +    struct hv_x64_interruption_deliverable_message info;
> +    union hv_x64_pending_ext_int_event event =3D { 0 };
> +    struct hv_register_assoc assocs[2] =3D { 0 };
> +    struct hv_register_assoc *event_assoc =3D &assocs[0],
> +                             *activity_assoc =3D &assocs[1];
> +    union hv_internal_activity_register activity;
> +    bool is_suspended;
> +    int ret, vector;
> +
> +    memcpy(&info, msg->payload, sizeof(info));
> +    if (info.deliverable_type !=3D MSHV_HV_INTERRUPTION_TYPE_EXT_INT) =
{
> +        error_report("unexpected deliverable interruption type %u",
> +                     info.deliverable_type);
> +        return -1;
> +    }
> +
> +    ret =3D clear_pic_interrupt_window(cpu);
> +    if (ret < 0) {
> +        error_report("failed to clear PIC interrupt window");
> +        return -1;
> +    }
> +
> +    bql_lock();
> +    cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
> +    vector =3D cpu_get_pic_interrupt(env);
> +    bql_unlock();
> +
> +    /* vector =3D=3D -1 means the PIC has no longer a pending =
interrupt */
> +    if (vector < 0) {
> +        return 0;
> +    }
> +
> +    trace_mshv_pic_interrupt(cpu->cpu_index, vector);
> +
> +    /* we check whether the vcpu is halted first */
> +    activity_assoc->name =3D HV_REGISTER_INTERNAL_ACTIVITY_STATE;
> +    ret =3D mshv_get_generic_regs(cpu, activity_assoc, 1);
> +    if (ret < 0) {
> +        error_report("failed to read activity state before PIC =
delivery");
> +        return -1;
> +    }
> +
> +    event.event_pending =3D 1;
> +    event.event_type    =3D HV_X64_PENDING_EVENT_EXT_INT;
> +    event.vector        =3D vector;
> +
> +    event_assoc->name                        =3D =
HV_REGISTER_PENDING_EVENT0;
> +    event_assoc->value.pending_ext_int_event =3D event;
> +
> +    /*
> +     * If the vcpu was hlt suspended we clear the suspend bit, =
otherwise we
> +     * only set the pending event.
> +     */
> +    activity =3D activity_assoc->value.internal_activity;
> +    is_suspended =3D activity.halt_suspend;
> +    if (is_suspended) {
> +        activity.halt_suspend =3D 0;
> +        activity_assoc->value.internal_activity =3D activity;
> +    }
> +
> +    ret =3D mshv_set_generic_regs(cpu, assocs, is_suspended ? 2 : 1);
> +    if (ret < 0) {
> +        error_report("failed to set pending event%s",
> +                     is_suspended ? " and activity state" : "");
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> /*
>  * Flip RFLAGS.TF like WHPX. Set it only on the live register, not =
env->eflags,
>  * so a later store won't put it back.
> @@ -2139,6 +2265,14 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, =
hv_message *msg, MshvVmExit *exit)
>         }
>     }
>=20
> +    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
> +        ret =3D request_pic_interrupt_window(cpu);
> +        if (ret < 0) {
> +            error_report("failed to request PIC interrupt window");
> +            return -1;
> +        }
> +    }
> +
>     ret =3D ioctl(cpu_fd, MSHV_RUN_VP, msg);
>     if (ret < 0) {
>         if (errno =3D=3D EINTR) {
> @@ -2185,6 +2319,13 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, =
hv_message *msg, MshvVmExit *exit)
>             return -1;
>         }
>         return 0;
> +    case HVMSG_X64_INTERRUPTION_DELIVERABLE:
> +        ret =3D handle_interrupt_deliverable(cpu, msg);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        *exit =3D MshvVmExitIgnore;
> +        return 0;
>     default:
>         break;
>     }
> diff --git a/target/i386/mshv/trace-events =
b/target/i386/mshv/trace-events
> new file mode 100644
> index 0000000000..347ce040ab
> --- /dev/null
> +++ b/target/i386/mshv/trace-events
> @@ -0,0 +1,7 @@
> +# Authors: Magnus Kulke <magnuskulke@microsoft.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +mshv_run_vcpu_eintr(uint32_t cpu) "cpu_index=3D%d"
> +mshv_set_pic_interrupt_window(uint32_t cpu, bool enabled) =
"cpu_index=3D%d enabled=3D%d"
> +mshv_pic_interrupt(uint32_t cpu, uint8_t vector) "cpu_index=3D%d =
vector=3D0x%x"
> diff --git a/target/i386/mshv/trace.h b/target/i386/mshv/trace.h
> new file mode 100644
> index 0000000000..81b6b655c7
> --- /dev/null
> +++ b/target/i386/mshv/trace.h
> @@ -0,0 +1,2 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#include "trace/trace-target_i386_mshv.h"
> --=20
> 2.34.1
>=20
>=20


