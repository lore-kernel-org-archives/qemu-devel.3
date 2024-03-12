Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68BBC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0LP-0001rg-Vj; Tue, 12 Mar 2024 07:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0LM-0001lg-6z; Tue, 12 Mar 2024 07:30:52 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0LJ-0001e0-7L; Tue, 12 Mar 2024 07:30:51 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so4632582a12.1; 
 Tue, 12 Mar 2024 04:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710243041; x=1710847841; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IylOsFJTsb5sFqI/NsMJpSuIbfdVzBdKA73QzDAXcPQ=;
 b=M06ZiHLz5j6vsfhTNFv1XRpVrhWH3YBZXrWwrh26kkDs5ZwxSU/9qh10ske1xbOyv3
 qiM3pfg1LEheVsIFpLczEP45JJtNq3iH/ee9k4DUl52WaiE8KvYCIhvFqw+SdrFbs8b0
 /1lao7nV5/Nk9ti6z04t/u/vU6V1diDA0lK0dx2PbNoVLZYlg9xeM6nYFbqHOxwYQLBR
 2nCRuQ2E4MGFAiKmWF6cuvrtliQ7EBpLa7oBvD7h7BAv5dE/UHxe4LQkkKhq1tfQX1Kt
 EemsDKO5k2XY3DnLZ7ON5tWzPOFiStpZ8HOBgq5W81rfIlZ5dV7QwGF6zMcPN7qQEcEF
 dSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710243041; x=1710847841;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IylOsFJTsb5sFqI/NsMJpSuIbfdVzBdKA73QzDAXcPQ=;
 b=SITo14oTC/ywRNNZYTkGN9Sh1zd+rf2tC6d7cvk5oT4OW29RySvKgUHf6ANAglPxp1
 DDf2Va/7NqrM1yyNlPihnGhGKwhchIGxZTuUR2c59Uwi8I75J/2td06sbYNfXvNWn0mg
 DD5luh8rgTE3n9Jf/6uC8k9hrKfmgCNr6HEY95OvML6ouT/Ixv2jl17AsWAVmDMihs6/
 xRX6ywmUBkGTWn0MqhwN7kV10z6HxrerGy8/PeshSnA3w363a4rO5/3DHP/L0jwYolFt
 0KkDtuCkevILYjaEmmpLotMnQfDP8UVooMFxDW5L8ZHtwXV6kqDsXd6L6rTscLFGKM+B
 77gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwupUpvHpdJt9lxqiLgusDBcV/BvEvU/wwac22e89/SZs7MlqpsZWu0c6YyHB/1dH+JVbW2T89SSNszWcoTvq6wnL8reUxBlQZEq3bQBZlZoyOHltllEat89Q=
X-Gm-Message-State: AOJu0YyLmXbbghEg+879fRovBtGE3yv5Ms4qQoAam7QY5a97e/jqcMbQ
 zWUGOkNO+M4oKnBCngNMMfg4JdaHRNQNPAdsvpk3p8NXEcAx2awr
X-Google-Smtp-Source: AGHT+IHFWNrRAxFNAVmzY2GNa1xwoRwyAkDMerS7S2xhDLs9kDKoLachk3Y/Y73TWrTWlrSr8s/1rQ==
X-Received: by 2002:a05:6a20:e120:b0:1a1:1f2b:ea1a with SMTP id
 kr32-20020a056a20e12000b001a11f2bea1amr11800333pzb.2.1710243041078; 
 Tue, 12 Mar 2024 04:30:41 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 z18-20020aa785d2000000b006e6288ef4besm5879776pfn.54.2024.03.12.04.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 04:30:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 21:30:35 +1000
Message-Id: <CZRQK3ZILE6U.2MQ419VUUQ8T9@wheely>
Cc: <clg@kaod.org>, <mikey@neuling.org>, <amachhiw@linux.vnet.ibm.com>,
 <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 06/14] spapr: nested: Introduce
 H_GUEST_[GET|SET]_CAPABILITIES hcalls.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-7-harshpb@linux.ibm.com>
In-Reply-To: <20240308111940.1617660-7-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
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
> Introduce the nested PAPR hcalls:
>  - H_GUEST_GET_CAPABILITIES which is used to query the capabilities
>    of the API and the L2 guests it provides.
>  - H_GUEST_SET_CAPABILITIES which is used to set the Guest API
>    capabilities that the Host Partition supports and may use.
>
> [amachhiw: support for p9 compat mode and return register bug fixes]
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.vnet.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  include/hw/ppc/spapr.h        |   7 ++-
>  include/hw/ppc/spapr_nested.h |  12 ++++
>  hw/ppc/spapr_nested.c         | 112 ++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 0eb01ea6fd..2906d59137 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -364,6 +364,7 @@ struct SpaprMachineState {
>  #define H_NOOP            -63
>  #define H_UNSUPPORTED     -67
>  #define H_OVERLAP         -68
> +#define H_STATE           -75
>  #define H_UNSUPPORTED_FLAG -256
>  #define H_MULTI_THREADS_ACTIVE -9005
> =20
> @@ -583,8 +584,10 @@ struct SpaprMachineState {
>  #define H_RPT_INVALIDATE        0x448
>  #define H_SCM_FLUSH             0x44C
>  #define H_WATCHDOG              0x45C
> +#define H_GUEST_GET_CAPABILITIES 0x460
> +#define H_GUEST_SET_CAPABILITIES 0x464
> =20
> -#define MAX_HCALL_OPCODE        H_WATCHDOG
> +#define MAX_HCALL_OPCODE         H_GUEST_SET_CAPABILITIES
> =20
>  /* The hcalls above are standardized in PAPR and implemented by pHyp
>   * as well.
> @@ -1033,5 +1036,7 @@ void spapr_watchdog_init(SpaprMachineState *spapr);
>  void spapr_register_nested_hv(void);
>  void spapr_unregister_nested_hv(void);
>  void spapr_nested_reset(SpaprMachineState *spapr);
> +void spapr_register_nested_papr(void);
> +void spapr_unregister_nested_papr(void);
> =20
>  #endif /* HW_SPAPR_H */
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index bf3a7b8d89..73687e03e4 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -7,8 +7,20 @@ typedef struct SpaprMachineStateNested {
>      uint64_t ptcr;
>      uint8_t api;
>  #define NESTED_API_KVM_HV  1
> +    bool capabilities_set;
> +    uint32_t pvr_base;
>  } SpaprMachineStateNested;
> =20
> +/* Nested PAPR API related macros */
> +#define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
> +#define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
> +#define H_GUEST_CAPABILITIES_P10_MODE 0x2000000000000000
> +#define H_GUEST_CAP_VALID_MASK        (H_GUEST_CAPABILITIES_P10_MODE | \
> +                                       H_GUEST_CAPABILITIES_P9_MODE)
> +#define H_GUEST_CAP_COPY_MEM_BMAP     0
> +#define H_GUEST_CAP_P9_MODE_BMAP      1
> +#define H_GUEST_CAP_P10_MODE_BMAP     2
> +
>  /*
>   * Register state for entering a nested guest with H_ENTER_NESTED.
>   * New member must be added at the end.
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 12fdbe2aba..601f669060 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -7,6 +7,7 @@
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/ppc/spapr_nested.h"
>  #include "mmu-book3s-v3.h"
> +#include "cpu-models.h"
> =20
>  void spapr_nested_reset(SpaprMachineState *spapr)
>  {
> @@ -16,6 +17,7 @@ void spapr_nested_reset(SpaprMachineState *spapr)
>          spapr_register_nested_hv();
>      } else {
>          spapr->nested.api =3D 0;
> +        spapr->nested.capabilities_set =3D false;
>      }
>  }
> =20
> @@ -432,6 +434,92 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>      }
>  }
> =20
> +static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
> +                                             SpaprMachineState *spapr,
> +                                             target_ulong opcode,
> +                                             target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong flags =3D args[0];
> +
> +    if (flags) { /* don't handle any flags capabilities for now */
> +        return H_PARAMETER;
> +    }
> +
> +    /* P10 capabilities */
> +    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0,
> +        spapr->max_compat_pvr)) {
> +        env->gpr[4] |=3D H_GUEST_CAPABILITIES_P10_MODE;
> +    }
> +
> +    /* P9 capabilities */
> +    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> +        spapr->max_compat_pvr)) {
> +        env->gpr[4] |=3D H_GUEST_CAPABILITIES_P9_MODE;
> +    }
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_guest_set_capabilities(PowerPCCPU *cpu,
> +                                             SpaprMachineState *spapr,
> +                                             target_ulong opcode,
> +                                              target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong flags =3D args[0];
> +    target_ulong capabilities =3D args[1];
> +    env->gpr[4] =3D 0;
> +
> +    if (flags) { /* don't handle any flags capabilities for now */
> +        return H_PARAMETER;
> +    }
> +
> +    if (capabilities & H_GUEST_CAPABILITIES_COPY_MEM) {
> +        env->gpr[4] =3D 1;
> +        return H_P2; /* isn't supported */
> +    }
> +
> +    /* If there are no capabilities configured, set the R5 to the index =
of
> +     * the first supported Power Processor Mode
> +     */
> +    if (!capabilities) {
> +        env->gpr[4] =3D 1;
> +
> +        /* set R5 to the first supported Power Processor Mode */
> +        if(ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0,
> +                            spapr->max_compat_pvr)) {
> +            env->gpr[5] =3D H_GUEST_CAP_P10_MODE_BMAP;
> +        }
> +        else if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> +                                  spapr->max_compat_pvr)) {
> +            env->gpr[5] =3D H_GUEST_CAP_P9_MODE_BMAP;
> +        }
> +
> +        return H_P2;
> +    }
> +
> +    /* If an invalid capability is set, R5 should contain the index of t=
he
> +     * invalid capability bit
> +     */
> +    if (capabilities & ~H_GUEST_CAP_VALID_MASK) {
> +        env->gpr[4] =3D 1;
> +
> +        /* Set R5 to the index of the invalid capability */
> +        env->gpr[5] =3D 63 - ctz64(capabilities);
> +
> +        return H_P2;
> +    }
> +
> +    if (!spapr->nested.capabilities_set) {
> +        spapr->nested.capabilities_set =3D true;
> +        spapr->nested.pvr_base =3D env->spr[SPR_PVR];
> +        return H_SUCCESS;
> +    } else {
> +        return H_STATE;
> +    }
> +}
> +
>  void spapr_register_nested_hv(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
> @@ -447,6 +535,19 @@ void spapr_unregister_nested_hv(void)
>      spapr_unregister_hypercall(KVMPPC_H_TLB_INVALIDATE);
>      spapr_unregister_hypercall(KVMPPC_H_COPY_TOFROM_GUEST);
>  }
> +
> +void spapr_register_nested_papr(void)
> +{
> +    spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capab=
ilities);
> +    spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capab=
ilities);
> +}
> +
> +void spapr_unregister_nested_papr(void)
> +{
> +    spapr_unregister_hypercall(H_GUEST_GET_CAPABILITIES);
> +    spapr_unregister_hypercall(H_GUEST_SET_CAPABILITIES);
> +}
> +
>  #else
>  void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>  {
> @@ -468,4 +569,15 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spa=
pr, PowerPCCPU *cpu,
>  {
>      return false;
>  }
> +
> +void spapr_register_nested_papr(void)
> +{
> +    /* DO NOTHING */
> +}
> +
> +void spapr_unregister_nested_papr(void)
> +{
> +    /* DO NOTHING */
> +}
> +
>  #endif


