Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC5EC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 09:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reu81-0000Us-Ao; Tue, 27 Feb 2024 04:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reu7z-0000Tc-CY; Tue, 27 Feb 2024 04:51:59 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reu7x-0004B0-D0; Tue, 27 Feb 2024 04:51:59 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dc1ff3ba1aso33752115ad.3; 
 Tue, 27 Feb 2024 01:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709027515; x=1709632315; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bY3IqdNUdS1YTBRj1pgu+pi/c/dH1RJ6k+fAtkmHOY4=;
 b=IcSTZaWoynFZcYv1VEATD6Uft1rmWICROZi6TkXwE+2V/zxbgclHmtTjD0fkLkA/Qn
 wzpT6b6y1Mn1Jpnv/CjVf7mdCbgdJoap5JWJV+eTOQJd1JUGe2FE7FF+OARlLsZ0B9uv
 IjyoHEitygr9ZDjxtUYIs2VteLKllqvivvGBmJ8E6EZUfHT3CNEofYMaf9TVyXtmIMhg
 LBJ+yVQh0IIyusFwfQW47ujW/ERk3LQtX3OZ8ErYVtjyaBvlmpSJPdmSkLqh9j5SJ1xL
 d9vsI2Po1BNLye7VyukipHHTBjo7cngo4EXx10HPDxDHnFJXlW88SoRKTNDfLILiackZ
 6ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709027515; x=1709632315;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bY3IqdNUdS1YTBRj1pgu+pi/c/dH1RJ6k+fAtkmHOY4=;
 b=oDjSBre+Xoc2IZOpibJUFOT6ruC6K8PA460M7nwcWO3YdZO691DnRA8/dE3q2UzYZZ
 UsecMHjlLs3t1cnWI9vwE1m4JD6GNdRez2koACAv5hW8N/1R/go0rVvniqJRvrlgyi1P
 wPWRsSCD8THLjOV/daGINH17p5+ca7eNAzLEUX8bEQnkIIKOwjri9hKdfgqBjT2Ew/T5
 U1/SIIJTOzgx7M+xXWViaGlqXMkinC2cbTEWE6ZJLLWuBbe/1RGPVgoeSqE53B1DxZgQ
 ivrXiLFYEMdKwotj8xv+HnUbnwuUxzOrncE81lb2JnoXry64GROzJ2bsOWAVqeLuMIIQ
 EqwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/WTedRjev+Sfo6+uCKWpDsk0Y40GfW1o+EJTgnm2OvnZ/VhdT2gOhhGYYNGI3UsB2gZOUCcWaK68vqJVd8FnRsmeRmQAPNr4dSMtyLaJp0qJJBSSYo7g7Ef0=
X-Gm-Message-State: AOJu0YyY2Uftf8rfdGgjRKNWu1qoH2tqgip4hVgeBdOi1t4+EMXGt2Z+
 /G927nDHJ0IT52S1ECpFUs6tdD70339E+gX2bg5ZlGTZnHn2Zm5z
X-Google-Smtp-Source: AGHT+IFTuGYEz+D6OzSMhE7gHd+KX7hx9EbLyNbks4FX7b4+pzbkGakxq5KxkPsaU2Vjj48fG8mlsw==
X-Received: by 2002:a17:902:dacd:b0:1dc:b320:9475 with SMTP id
 q13-20020a170902dacd00b001dcb3209475mr3525484plx.13.1709027515386; 
 Tue, 27 Feb 2024 01:51:55 -0800 (PST)
Received: from localhost ([1.146.52.18]) by smtp.gmail.com with ESMTPSA id
 kg7-20020a170903060700b001db4433ef95sm1141803plb.152.2024.02.27.01.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 01:51:55 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 19:51:48 +1000
Message-Id: <CZFROUOXN7EA.3OBIZUXJPUNH5@wheely>
Cc: <clegoate@redhat.com>, <mikey@neuling.org>,
 <amachhiw@linux.vnet.ibm.com>, <vaibhav@linux.ibm.com>,
 <sbhat@linux.ibm.com>, <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 08/15] spapr: nested: Introduce H_GUEST_CREATE_VCPU
 hcall.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-9-harshpb@linux.ibm.com>
In-Reply-To: <20240220083609.748325-9-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

On Tue Feb 20, 2024 at 6:36 PM AEST, Harsh Prateek Bora wrote:
> Introduce the nested PAPR hcall H_GUEST_CREATE_VCPU which is used to
> create and initialize the specified VCPU resource for the previously
> created guest. Each guest can have multiple VCPUs upto max 2048.
> All VCPUs for a guest gets deallocated on guest delete.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  include/hw/ppc/spapr.h        |  2 +
>  include/hw/ppc/spapr_nested.h | 10 ++++
>  hw/ppc/spapr_nested.c         | 96 +++++++++++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index c4a79a1785..82b077bdd2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -365,6 +365,7 @@ struct SpaprMachineState {
>  #define H_UNSUPPORTED     -67
>  #define H_OVERLAP         -68
>  #define H_STATE           -75
> +#define H_IN_USE          -77
>  #define H_UNSUPPORTED_FLAG -256
>  #define H_MULTI_THREADS_ACTIVE -9005
> =20
> @@ -587,6 +588,7 @@ struct SpaprMachineState {
>  #define H_GUEST_GET_CAPABILITIES 0x460
>  #define H_GUEST_SET_CAPABILITIES 0x464
>  #define H_GUEST_CREATE           0x470
> +#define H_GUEST_CREATE_VCPU      0x474
>  #define H_GUEST_DELETE           0x488
> =20
>  #define MAX_HCALL_OPCODE         H_GUEST_DELETE
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index f282479275..24e87bca08 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -14,6 +14,8 @@ typedef struct SpaprMachineStateNested {
> =20
>  typedef struct SpaprMachineStateNestedGuest {
>      uint32_t pvr_logical;
> +    unsigned long vcpus;
> +    struct SpaprMachineStateNestedGuestVcpu *vcpu;
>  } SpaprMachineStateNestedGuest;
> =20
>  /* Nested PAPR API related macros */
> @@ -27,6 +29,7 @@ typedef struct SpaprMachineStateNestedGuest {
>  #define H_GUEST_CAP_P10_MODE_BMAP     2
>  #define PAPR_NESTED_GUEST_MAX         4096
>  #define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
> +#define PAPR_NESTED_GUEST_VCPU_MAX    2048
> =20
>  /*
>   * Register state for entering a nested guest with H_ENTER_NESTED.
> @@ -118,8 +121,15 @@ struct nested_ppc_state {
>      uint64_t ppr;
> =20
>      int64_t tb_offset;
> +    /* Nested PAPR API */
> +    uint64_t pvr;
>  };
> =20
> +typedef struct SpaprMachineStateNestedGuestVcpu {
> +    bool enabled;
> +    struct nested_ppc_state state;
> +} SpaprMachineStateNestedGuestVcpu;
> +
>  void spapr_exit_nested(PowerPCCPU *cpu, int excp);
>  typedef struct SpaprMachineState SpaprMachineState;
>  bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 09c4a35908..3cc704adda 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -428,6 +428,41 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>      }
>  }
> =20
> +static
> +SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *=
spapr,
> +                                                     target_ulong guesti=
d)
> +{
> +    SpaprMachineStateNestedGuest *guest;
> +
> +    guest =3D g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(=
guestid));
> +    return guest;
> +}
> +
> +static bool spapr_nested_vcpu_check(SpaprMachineStateNestedGuest *guest,
> +                                    target_ulong vcpuid)
> +{
> +    struct SpaprMachineStateNestedGuestVcpu *vcpu;
> +    /*
> +     * Perform sanity checks for the provided vcpuid of a guest.
> +     * For now, ensure its valid, allocated and enabled for use.
> +     */
> +
> +    if (vcpuid >=3D PAPR_NESTED_GUEST_VCPU_MAX) {
> +        return false;
> +    }
> +
> +    if (!(vcpuid < guest->vcpus)) {
> +        return false;
> +    }
> +
> +    vcpu =3D &guest->vcpu[vcpuid];
> +    if (!vcpu->enabled) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
>                                               SpaprMachineState *spapr,
>                                               target_ulong opcode,
> @@ -518,6 +553,7 @@ static void
>  destroy_guest_helper(gpointer value)
>  {
>      struct SpaprMachineStateNestedGuest *guest =3D value;
> +    g_free(guest->vcpu);
>      g_free(guest);
>  }
> =20
> @@ -613,6 +649,65 @@ static target_ulong h_guest_delete(PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
> +                                        SpaprMachineState *spapr,
> +                                        target_ulong opcode,
> +                                        target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    struct nested_ppc_state *l2_state;
> +    target_ulong flags =3D args[0];
> +    target_ulong guestid =3D args[1];
> +    target_ulong vcpuid =3D args[2];
> +    SpaprMachineStateNestedGuest *guest;
> +
> +    if (flags) { /* don't handle any flags for now */
> +        return H_UNSUPPORTED_FLAG;
> +    }
> +
> +    guest =3D spapr_get_nested_guest(spapr, guestid);
> +    if (!guest) {
> +        return H_P2;
> +    }
> +
> +    if (vcpuid < guest->vcpus) {
> +        return H_IN_USE;
> +    }

Linear allocation isn't really a constraint of the API right? I
would add an UNIMP log message to say what the problem is otherwise
hypervisor developer might struggle to understand the problem.

> +
> +    if (guest->vcpus >=3D PAPR_NESTED_GUEST_VCPU_MAX) {
> +        return H_P3;
> +    }
> +
> +    if (guest->vcpus) {
> +        SpaprMachineStateNestedGuestVcpu *vcpus;
> +        vcpus =3D g_try_renew(struct SpaprMachineStateNestedGuestVcpu,
> +                            guest->vcpu,
> +                            guest->vcpus + 1);
> +        if (!vcpus) {
> +            return H_NO_MEM;
> +        }
> +        memset(&vcpus[guest->vcpus], 0,
> +               sizeof(SpaprMachineStateNestedGuestVcpu));
> +        guest->vcpu =3D vcpus;
> +    } else {
> +        guest->vcpu =3D g_try_new0(SpaprMachineStateNestedGuestVcpu, 1);
> +        if (guest->vcpu =3D=3D NULL) {
> +            return H_NO_MEM;
> +        }
> +    }

g_try_renew works with NULL AFAIKS, so no need for the branch. I would
also create a local variable for the new nested guest vcpu created
here so you only have to index it once.

> +    l2_state =3D &guest->vcpu[guest->vcpus].state;
> +    guest->vcpus++;
> +    assert(vcpuid < guest->vcpus); /* linear vcpuid allocation only */

Target can trigger this assert if using a smaller vcpu id number than
already allocated? I would check above that it is exactly equal to
vcpus, and remove it from here.

> +    /* Set L1 PVR as L2 default */
> +    l2_state->pvr =3D env->spr[SPR_PVR];

Why is this here and not in H_GUEST_CREATE? I think you can use pcc->pvr
for this?

> +    guest->vcpu[vcpuid].enabled =3D true;
> +
> +    if (!spapr_nested_vcpu_check(guest, vcpuid)) {
> +        return H_PARAMETER;
> +    }

This doesn't clean up on failure. Just remove "sanity" checks if they
are already checked in the same function. Any useful ones should be
properly hanlded or done before cleanup is needed.

If you're respinning could you call vcpus nr_vcpus, then call vcpu
(the array of vcpus) vcpus.

Thanks,
Nick

