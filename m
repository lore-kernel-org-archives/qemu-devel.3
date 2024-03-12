Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A7CC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0XL-0007di-NL; Tue, 12 Mar 2024 07:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0XF-0007b7-NP; Tue, 12 Mar 2024 07:43:09 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0XC-0004Bq-QQ; Tue, 12 Mar 2024 07:43:09 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-22222357d76so238769fac.2; 
 Tue, 12 Mar 2024 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710243785; x=1710848585; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAtiZi969b2n42feT+5mPdjwS1ZIhPSpF1PSeIJpniY=;
 b=IyekFKs06vBgJNSXp0Bkkj5TRVmGGBPPRtuLtDZTeZJRqhSe0ytRcvjbL/fu0UaWGd
 S9sy6hZQIq6p+v6aNFTb/LirnvdoqALruvBY3JQEwnb6pVzIOliG21SvSb0LCH0OmR0Z
 2c33MOHY47wZ4dfpwv4UmZyTn1ddCWwDvv10wT71/U5xc1nYPROFi/6TAabzpCFWHMqw
 Fpem4FDgHaUWKQeyRE1Y4aAgPUBF/qqMumMnhKq/TW8+6hRwh+KxiXItDiKAufoyRKmJ
 etr2tgHeaG6Yj4QsmmRjMpKMLxl/8gV1NE0HPrvTFyHeGxgKW+39wseM61fju8CcQ9Q2
 HsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710243785; x=1710848585;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UAtiZi969b2n42feT+5mPdjwS1ZIhPSpF1PSeIJpniY=;
 b=lAXvOhHorCTPxuBibDCWRKT8IJtt/RpzMapi4JMRcB4fk9FvICsEDfMaTPAD5shWgS
 MrKK/9AVljIV6S/yjaANDLzT3RuVGXo2TygCduIDPjrCrrq2AABFIuT4pGucwyCYvmxe
 7+ypQr3N5yOZpcDTlkMlAjTWHDYcVk4pDadyOv/UB8NJ3KJTgjRQaHIZgx+mKnrd1Vtw
 pND1ulVk+CS8eYoiZ4Fh0uyksZvF8tPvDF60BwdHKg4THL7ZS7WQrKwZvF+mYVY3M4hp
 FmEbBAlmRYfudYRiInCYqyDmdrDulizqCKWZkJIq5fPr0vUiQAqJQvHftf9BAl4tQ7uk
 BBTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFvhNBEjSzbZrY2k8bUOJSTC/jW0bokFjtyFEZ7sPn3aQr9eaSeC8JU1P+HwUjfdLwjFs3unnM8XmBQ28J1DMjgHDo+3XxMzKQ1Jqlie7pPB8u5pcjXt0izMY=
X-Gm-Message-State: AOJu0YzJxl+wyBWBtn0XzKVNTA3lUAvdKGWZPp+iPGHjoU3x0tv3vf4P
 jdZeoMSdMJv+FeReLiBmo5X0cTTRvi44BLCO5EEnniBywdLwsDaE
X-Google-Smtp-Source: AGHT+IFOOwJyWYl0EV9tRLFK3+FW0uQxpeacPqDfs0S047ci3MZjPY7L28XosAM2GDtX/l1s/rbjHQ==
X-Received: by 2002:a05:6870:d88a:b0:21f:cd9a:35ad with SMTP id
 oe10-20020a056870d88a00b0021fcd9a35admr10387813oac.41.1710243785064; 
 Tue, 12 Mar 2024 04:43:05 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 gu17-20020a056a004e5100b006e572d86152sm6073083pfb.91.2024.03.12.04.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 04:43:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 21:42:59 +1000
Message-Id: <CZRQTLPGM7CD.28JPRAKT4G5VV@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, <mikey@neuling.org>, <amachhiw@linux.vnet.ibm.com>,
 <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 13/14] spapr: nested: Introduce H_GUEST_RUN_VCPU hcall.
X-Mailer: aerc 0.15.2
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-14-harshpb@linux.ibm.com>
In-Reply-To: <20240308111940.1617660-14-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri Mar 8, 2024 at 9:19 PM AEST, Harsh Prateek Bora wrote:
> The H_GUEST_RUN_VCPU hcall is used to start execution of a Guest VCPU.
> The Hypervisor will update the state of the Guest VCPU based on the
> input buffer, restore the saved Guest VCPU state, and start its
> execution.
>
> The Guest VCPU can stop running for numerous reasons including HCALLs,
> hypervisor exceptions, or an outstanding Host Partition Interrupt.
> The reason that the Guest VCPU stopped running is communicated through
> R4 and the output buffer will be filled in with any relevant state.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/cpu.h      |   2 +
>  hw/ppc/ppc.c          |  10 ++
>  hw/ppc/spapr_nested.c | 334 ++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 316 insertions(+), 30 deletions(-)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 4cffd46c79..95b7c86eb3 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1584,6 +1584,8 @@ uint64_t cpu_ppc_load_atbl(CPUPPCState *env);
>  uint32_t cpu_ppc_load_atbu(CPUPPCState *env);
>  void cpu_ppc_store_atbl(CPUPPCState *env, uint32_t value);
>  void cpu_ppc_store_atbu(CPUPPCState *env, uint32_t value);
> +void cpu_ppc_increase_tb_by_offset (CPUPPCState *env, int64_t offset);
> +void cpu_ppc_decrease_tb_by_offset (CPUPPCState *env, int64_t offset);
>  uint64_t cpu_ppc_load_vtb(CPUPPCState *env);
>  void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value);
>  bool ppc_decr_clear_on_delivery(CPUPPCState *env);
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index fadb8f5239..55860b9a83 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -633,6 +633,16 @@ void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t =
value)
>                       ((uint64_t)value << 32) | tb);
>  }
> =20
> +void cpu_ppc_increase_tb_by_offset (CPUPPCState *env, int64_t offset)
> +{
> +    env->tb_env->tb_offset +=3D offset;
> +}
> +
> +void cpu_ppc_decrease_tb_by_offset (CPUPPCState *env, int64_t offset)
> +{
> +    env->tb_env->tb_offset -=3D offset;
> +}
> +
>  uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
>  {
>      ppc_tb_t *tb_env =3D env->tb_env;
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index e0b234c786..597dba7fdc 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -200,14 +200,28 @@ static void nested_save_state(struct nested_ppc_sta=
te *save, PowerPCCPU *cpu)
>          save->sier =3D env->spr[SPR_POWER_SIER];
>          save->vscr =3D ppc_get_vscr(env);
>          save->fpscr =3D env->fpscr;
> +    } else if (spapr_nested_api(spapr) =3D=3D NESTED_API_KVM_HV) {
> +        save->tb_offset =3D env->tb_env->tb_offset;
>      }
> +}
> =20
> -    save->tb_offset =3D env->tb_env->tb_offset;
> +static void nested_post_load_state(CPUPPCState *env, CPUState *cs)
> +{
> +    /*
> +     * compute hflags and possible interrupts.
> +     */
> +    hreg_compute_hflags(env);
> +    ppc_maybe_interrupt(env);
> +    /*
> +     * Nested HV does not tag TLB entries between L1 and L2, so must
> +     * flush on transition.
> +     */
> +    tlb_flush(cs);
> +    env->reserve_addr =3D -1; /* Reset the reservation */
>  }
> =20
>  static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *=
load)
>  {
> -    CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> =20
> @@ -285,22 +299,9 @@ static void nested_load_state(PowerPCCPU *cpu, struc=
t nested_ppc_state *load)
>          env->spr[SPR_POWER_SIER] =3D load->sier;
>          ppc_store_vscr(env, load->vscr);
>          ppc_store_fpscr(env, load->fpscr);
> +    } else if (spapr_nested_api(spapr) =3D=3D NESTED_API_KVM_HV) {
> +        env->tb_env->tb_offset =3D load->tb_offset;
>      }
> -
> -    env->tb_env->tb_offset =3D load->tb_offset;
> -
> -    /*
> -     * MSR updated, compute hflags and possible interrupts.
> -     */
> -    hreg_compute_hflags(env);
> -    ppc_maybe_interrupt(env);
> -
> -    /*
> -     * Nested HV does not tag TLB entries between L1 and L2, so must
> -     * flush on transition.
> -     */
> -    tlb_flush(cs);
> -    env->reserve_addr =3D -1; /* Reset the reservation */
>  }
> =20
>  /*
> @@ -315,6 +316,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
>  {
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>      CPUPPCState *env =3D &cpu->env;
> +    CPUState *cs =3D CPU(cpu);
>      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
>      struct nested_ppc_state l2_state;
>      target_ulong hv_ptr =3D args[0];
> @@ -413,6 +415,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
>       * Switch to the nested guest environment and start the "hdec" timer=
.
>       */
>      nested_load_state(cpu, &l2_state);
> +    nested_post_load_state(env, cs);
> =20
>      hdec =3D hv_state.hdec_expiry - now;
>      cpu_ppc_hdecr_init(env);
> @@ -444,6 +447,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
>  static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
>  {
>      CPUPPCState *env =3D &cpu->env;
> +    CPUState *cs =3D CPU(cpu);
>      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
>      struct nested_ppc_state l2_state;
>      target_ulong hv_ptr =3D spapr_cpu->nested_host_state->gpr[4];
> @@ -465,6 +469,7 @@ static void spapr_exit_nested_hv(PowerPCCPU *cpu, int=
 excp)
>       */
>      assert(env->spr[SPR_LPIDR] !=3D 0);
>      nested_load_state(cpu, spapr_cpu->nested_host_state);
> +    nested_post_load_state(env, cs);
>      env->gpr[3] =3D env->excp_vectors[excp]; /* hcall return value */
> =20
>      cpu_ppc_hdecr_exit(env);
> @@ -542,19 +547,6 @@ static void spapr_exit_nested_hv(PowerPCCPU *cpu, in=
t excp)
>      address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>  }
> =20
> -void spapr_exit_nested(PowerPCCPU *cpu, int excp)
> -{
> -    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> -    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> -
> -    assert(spapr_cpu->in_nested);
> -    if (spapr_nested_api(spapr) =3D=3D NESTED_API_KVM_HV) {
> -        spapr_exit_nested_hv(cpu, excp);
> -    } else {
> -        g_assert_not_reached();
> -    }
> -}
> -
>  SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *=
spapr,
>                                                       target_ulong guesti=
d)
>  {
> @@ -1539,6 +1531,286 @@ static target_ulong h_guest_get_state(PowerPCCPU =
*cpu,
>      return h_guest_getset_state(cpu, spapr, args, false);
>  }
> =20
> +static void exit_nested_store_l2(PowerPCCPU *cpu, int excp,
> +                                 SpaprMachineStateNestedGuestVcpu *vcpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +    target_ulong now, hdar, hdsisr, asdr;
> +
> +    assert(sizeof(env->gpr) =3D=3D sizeof(vcpu->state.gpr)); /* sanity c=
heck */
> +
> +    now =3D cpu_ppc_load_tbl(env); /* L2 timebase */
> +    now -=3D vcpu->tb_offset; /* L1 timebase */
> +    vcpu->state.dec_expiry_tb =3D now - cpu_ppc_load_decr(env);
> +    cpu_ppc_store_decr(env, spapr_cpu->nested_host_state->dec_expiry_tb =
- now);
> +    /* backup hdar, hdsisr, asdr if reqd later below */
> +    hdar   =3D vcpu->state.hdar;
> +    hdsisr =3D vcpu->state.hdsisr;
> +    asdr   =3D vcpu->state.asdr;
> +
> +    nested_save_state(&vcpu->state, cpu);
> +
> +    if (excp =3D=3D POWERPC_EXCP_MCHECK ||
> +        excp =3D=3D POWERPC_EXCP_RESET ||
> +        excp =3D=3D POWERPC_EXCP_SYSCALL) {
> +        vcpu->state.nip =3D env->spr[SPR_SRR0];
> +        vcpu->state.msr =3D env->spr[SPR_SRR1] & env->msr_mask;
> +    } else {
> +        vcpu->state.nip =3D env->spr[SPR_HSRR0];
> +        vcpu->state.msr =3D env->spr[SPR_HSRR1] & env->msr_mask;
> +    }
> +
> +    /* hdar, hdsisr, asdr should be retained unless certain exceptions *=
/
> +    if ((excp !=3D POWERPC_EXCP_HDSI) && (excp !=3D POWERPC_EXCP_HISI)) =
{
> +        vcpu->state.asdr =3D asdr;
> +    } else if (excp !=3D POWERPC_EXCP_HDSI) {
> +        vcpu->state.hdar   =3D hdar;
> +        vcpu->state.hdsisr =3D hdsisr;
> +    }
> +}
> +
> +static int get_exit_ids(uint64_t srr0, uint16_t ids[16])
> +{
> +    int nr;
> +
> +    switch (srr0) {
> +    case 0xc00:
> +        nr =3D 10;
> +        ids[0] =3D GSB_VCPU_GPR3;
> +        ids[1] =3D GSB_VCPU_GPR4;
> +        ids[2] =3D GSB_VCPU_GPR5;
> +        ids[3] =3D GSB_VCPU_GPR6;
> +        ids[4] =3D GSB_VCPU_GPR7;
> +        ids[5] =3D GSB_VCPU_GPR8;
> +        ids[6] =3D GSB_VCPU_GPR9;
> +        ids[7] =3D GSB_VCPU_GPR10;
> +        ids[8] =3D GSB_VCPU_GPR11;
> +        ids[9] =3D GSB_VCPU_GPR12;
> +        break;
> +    case 0xe00:
> +        nr =3D 5;
> +        ids[0] =3D GSB_VCPU_SPR_HDAR;
> +        ids[1] =3D GSB_VCPU_SPR_HDSISR;
> +        ids[2] =3D GSB_VCPU_SPR_ASDR;
> +        ids[3] =3D GSB_VCPU_SPR_NIA;
> +        ids[4] =3D GSB_VCPU_SPR_MSR;
> +        break;
> +    case 0xe20:
> +        nr =3D 4;
> +        ids[0] =3D GSB_VCPU_SPR_HDAR;
> +        ids[1] =3D GSB_VCPU_SPR_ASDR;
> +        ids[2] =3D GSB_VCPU_SPR_NIA;
> +        ids[3] =3D GSB_VCPU_SPR_MSR;
> +        break;
> +    case 0xe40:
> +        nr =3D 3;
> +        ids[0] =3D GSB_VCPU_SPR_HEIR;
> +        ids[1] =3D GSB_VCPU_SPR_NIA;
> +        ids[2] =3D GSB_VCPU_SPR_MSR;
> +        break;
> +    case 0xf80:
> +        nr =3D 3;
> +        ids[0] =3D GSB_VCPU_SPR_HFSCR;
> +        ids[1] =3D GSB_VCPU_SPR_NIA;
> +        ids[2] =3D GSB_VCPU_SPR_MSR;
> +        break;
> +    default:
> +        nr =3D 0;
> +        break;
> +    }
> +
> +    return nr;
> +}
> +
> +static void exit_process_output_buffer(PowerPCCPU *cpu,
> +                                       SpaprMachineStateNestedGuest *gue=
st,
> +                                       target_ulong vcpuid,
> +                                       target_ulong *r3)
> +{
> +    SpaprMachineStateNestedGuestVcpu *vcpu =3D &guest->vcpus[vcpuid];
> +    struct guest_state_request gsr;
> +    struct guest_state_buffer *gsb;
> +    struct guest_state_element *element;
> +    struct guest_state_element_type *type;
> +    int exit_id_count =3D 0;
> +    uint16_t exit_cause_ids[16];
> +    hwaddr len;
> +
> +    len =3D vcpu->runbufout.size;
> +    gsb =3D address_space_map(CPU(cpu)->as, vcpu->runbufout.addr, &len, =
true,
> +                            MEMTXATTRS_UNSPECIFIED);
> +    if (!gsb || len !=3D vcpu->runbufout.size) {
> +        address_space_unmap(CPU(cpu)->as, gsb, len, true, len);
> +        *r3 =3D H_P2;
> +        return;
> +    }
> +
> +    exit_id_count =3D get_exit_ids(*r3, exit_cause_ids);
> +
> +    /* Create a buffer of elements to send back */
> +    gsb->num_elements =3D cpu_to_be32(exit_id_count);
> +    element =3D gsb->elements;
> +    for (int i =3D 0; i < exit_id_count; i++) {
> +        type =3D guest_state_element_type_find(exit_cause_ids[i]);
> +        assert(type);
> +        element->id =3D cpu_to_be16(exit_cause_ids[i]);
> +        element->size =3D cpu_to_be16(type->size);
> +        element =3D guest_state_element_next(element, NULL, NULL);
> +    }
> +    gsr.gsb =3D gsb;
> +    gsr.len =3D VCPU_OUT_BUF_MIN_SZ;
> +    gsr.flags =3D 0; /* get + never guest wide */
> +    getset_state(guest, vcpuid, &gsr);
> +
> +    address_space_unmap(CPU(cpu)->as, gsb, len, true, len);
> +    return;
> +}
> +
> +static
> +void spapr_exit_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu, i=
nt excp)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    CPUState *cs =3D CPU(cpu);
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +    target_ulong r3_return =3D env->excp_vectors[excp]; /* hcall return =
value */
> +    target_ulong lpid =3D 0, vcpuid =3D 0;
> +    struct SpaprMachineStateNestedGuestVcpu *vcpu =3D NULL;
> +    struct SpaprMachineStateNestedGuest *guest =3D NULL;
> +
> +    lpid =3D spapr_cpu->nested_host_state->gpr[5];
> +    vcpuid =3D spapr_cpu->nested_host_state->gpr[6];
> +    guest =3D spapr_get_nested_guest(spapr, lpid);
> +    assert(guest);
> +    spapr_nested_vcpu_check(guest, vcpuid, false);
> +    vcpu =3D &guest->vcpus[vcpuid];
> +
> +    exit_nested_store_l2(cpu, excp, vcpu);
> +    /* do the output buffer for run_vcpu*/
> +    exit_process_output_buffer(cpu, guest, vcpuid, &r3_return);
> +
> +    assert(env->spr[SPR_LPIDR] !=3D 0);
> +    nested_load_state(cpu, spapr_cpu->nested_host_state);
> +    cpu_ppc_decrease_tb_by_offset(env, vcpu->tb_offset);
> +    env->gpr[3] =3D H_SUCCESS;
> +    env->gpr[4] =3D r3_return;
> +    nested_post_load_state(env, cs);
> +    cpu_ppc_hdecr_exit(env);
> +
> +    spapr_cpu->in_nested =3D false;
> +    g_free(spapr_cpu->nested_host_state);
> +    spapr_cpu->nested_host_state =3D NULL;
> +}
> +
> +void spapr_exit_nested(PowerPCCPU *cpu, int excp)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +
> +    assert(spapr_cpu->in_nested);
> +    if (spapr_nested_api(spapr) =3D=3D NESTED_API_KVM_HV) {
> +        spapr_exit_nested_hv(cpu, excp);
> +    } else if (spapr_nested_api(spapr) =3D=3D NESTED_API_PAPR) {
> +        spapr_exit_nested_papr(spapr, cpu, excp);
> +    } else {
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void nested_papr_load_l2(PowerPCCPU *cpu,
> +                                CPUPPCState *env,
> +                                SpaprMachineStateNestedGuestVcpu *vcpu,
> +                                target_ulong now)
> +{
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +    target_ulong lpcr, lpcr_mask, hdec;
> +    lpcr_mask =3D LPCR_DPFD | LPCR_ILE | LPCR_AIL | LPCR_LD | LPCR_MER;
> +
> +    assert(vcpu);
> +    assert(sizeof(env->gpr) =3D=3D sizeof(vcpu->state.gpr));
> +    nested_load_state(cpu, &vcpu->state);
> +    lpcr =3D (env->spr[SPR_LPCR] & ~lpcr_mask) |
> +           (vcpu->state.lpcr & lpcr_mask);
> +    lpcr |=3D LPCR_HR | LPCR_UPRT | LPCR_GTSE | LPCR_HVICE | LPCR_HDICE;
> +    lpcr &=3D ~LPCR_LPES0;
> +    env->spr[SPR_LPCR] =3D lpcr & pcc->lpcr_mask;
> +
> +    hdec =3D vcpu->hdecr_expiry_tb - now;
> +    cpu_ppc_store_decr(env, vcpu->state.dec_expiry_tb - now);
> +    cpu_ppc_hdecr_init(env);
> +    cpu_ppc_store_hdecr(env, hdec);
> +
> +    cpu_ppc_increase_tb_by_offset(env, vcpu->tb_offset);
> +}
> +
> +static void nested_papr_run_vcpu(PowerPCCPU *cpu,
> +                                 uint64_t lpid,
> +                                 SpaprMachineStateNestedGuestVcpu *vcpu)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    CPUPPCState *env =3D &cpu->env;
> +    CPUState *cs =3D CPU(cpu);
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +    target_ulong now =3D cpu_ppc_load_tbl(env);
> +
> +    assert(env->spr[SPR_LPIDR] =3D=3D 0);
> +    assert(spapr->nested.api); /* ensure API version is initialized */
> +    spapr_cpu->nested_host_state =3D g_try_new(struct nested_ppc_state, =
1);
> +    assert(spapr_cpu->nested_host_state);
> +    nested_save_state(spapr_cpu->nested_host_state, cpu);
> +    spapr_cpu->nested_host_state->dec_expiry_tb =3D now - cpu_ppc_load_d=
ecr(env);
> +    nested_papr_load_l2(cpu, env, vcpu, now);
> +    env->spr[SPR_LPIDR] =3D lpid; /* post load l2 */
> +
> +    spapr_cpu->in_nested =3D true;
> +    nested_post_load_state(env, cs);
> +}
> +
> +static target_ulong h_guest_run_vcpu(PowerPCCPU *cpu,
> +                                     SpaprMachineState *spapr,
> +                                     target_ulong opcode,
> +                                     target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong flags =3D args[0];
> +    target_ulong lpid =3D args[1];
> +    target_ulong vcpuid =3D args[2];
> +    struct SpaprMachineStateNestedGuestVcpu *vcpu;
> +    struct guest_state_request gsr;
> +    SpaprMachineStateNestedGuest *guest;
> +    target_ulong rc;
> +
> +    if (flags) /* don't handle any flags for now */
> +        return H_PARAMETER;
> +
> +    guest =3D spapr_get_nested_guest(spapr, lpid);
> +    if (!guest) {
> +        return H_P2;
> +    }
> +    if (!spapr_nested_vcpu_check(guest, vcpuid, true)) {
> +        return H_P3;
> +    }
> +
> +    if (guest->parttbl[0] =3D=3D 0) {
> +        /* At least need a partition scoped radix tree */
> +        return H_NOT_AVAILABLE;
> +    }
> +
> +    vcpu =3D &guest->vcpus[vcpuid];
> +
> +    /* Read run_vcpu input buffer to update state */
> +    gsr.buf =3D vcpu->runbufin.addr;
> +    gsr.len =3D vcpu->runbufin.size;
> +    gsr.flags =3D GUEST_STATE_REQUEST_SET; /* Thread wide + writing */
> +    rc =3D map_and_getset_state(cpu, guest, vcpuid, &gsr);
> +    if (rc =3D=3D H_SUCCESS) {
> +        nested_papr_run_vcpu(cpu, lpid, vcpu);
> +    } else {
> +        env->gpr[3] =3D rc;
> +    }
> +    return env->gpr[3];
> +}
> +
>  void spapr_register_nested_hv(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
> @@ -1564,6 +1836,7 @@ void spapr_register_nested_papr(void)
>      spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vc=
pu);
>      spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state=
);
>      spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state=
);
> +    spapr_register_hypercall(H_GUEST_RUN_VCPU        , h_guest_run_vcpu)=
;
>  }
> =20
>  void spapr_unregister_nested_papr(void)
> @@ -1575,6 +1848,7 @@ void spapr_unregister_nested_papr(void)
>      spapr_unregister_hypercall(H_GUEST_CREATE_VCPU);
>      spapr_unregister_hypercall(H_GUEST_SET_STATE);
>      spapr_unregister_hypercall(H_GUEST_GET_STATE);
> +    spapr_unregister_hypercall(H_GUEST_RUN_VCPU);
>  }
> =20
>  #else


