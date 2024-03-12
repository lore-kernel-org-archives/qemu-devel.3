Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BAFC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0fE-0002Vz-J8; Tue, 12 Mar 2024 07:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0fA-0002VO-Cl; Tue, 12 Mar 2024 07:51:20 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0f6-0006Dk-42; Tue, 12 Mar 2024 07:51:17 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e66da40b18so2582828b3a.0; 
 Tue, 12 Mar 2024 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710244274; x=1710849074; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSFeAUb09gKdDgGXWSbsmWgtF2mQ7BysLkdDFCKCb94=;
 b=cKMD02TuWswbPxF1+rQvZh3PKNtUkvkskkwNs/pSII43rGSgyWPxT0G5nij58xDBnt
 l/ftlyg0V07eOeX4MdRjFR6tIiKDuAJdd5ecEvw9rxZ2IDY1VpfQJoqN2HVqx38jEjoo
 hC67I0JD72Fhd6spI5gkP4O3xaLmCME8Vn4G40TmBO/4mlNM7zyFBgKS2vCMjT3110iS
 8K66Ql3izRrx8tNrHduJ2lJ1UkNA11WTBtAPD3D3LAJf/bBQsaDF9fyT+dV0NNOYA92r
 1/EX8mqM/y/b18e0yS0JdaFpgw2OoSWSnqDE7DXbRycHMD2OBZp++0hciRQxjmGrb6m2
 WoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710244274; x=1710849074;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dSFeAUb09gKdDgGXWSbsmWgtF2mQ7BysLkdDFCKCb94=;
 b=nnjHcvwFJVRoYyubeNIEF6ytbJt5LN6tk3UeFHbgVaH01hlBM+xxieRr24Vz3GgUeo
 p1IUDpg9IxAvdUT/FjDNERyItxwHDvx8GB1UigMKOmGeXhkv6K0TPmLCmXg7387nV49M
 MgUnpAQtdkCRNsIrMb3hVtvkT7p9jK9CcPfKBbobi21RvzGysjZc3c2w/RG866FH9QhS
 2iarHp1BBHz2F3IAt4OxSIFdPdsiQFTiHZSi9XJHSEtB961ViR/W5XlLMjuEE5QThtj4
 8y3t6sqBEmd6Gpi3rejjXDwldNxt3mJArzZte3rdKzqz2hJsNupV93sr346u8oQglkFE
 UP3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWySEdoJV7rB+O1TpMTTkXVa+m0Qjhzd4JKtIohwWgmSvgo6JMAVJ3bSKMt2kVYS52bPvjCuNyywsqzLqOGYhYFHtMHbTKYhJ9WRlXjz2JzFy/+nm8pGXqnmJs=
X-Gm-Message-State: AOJu0YyPVV5aayxFe4P8sgoftfUFvPUAqItYLjz94j3yv1eguVCsdOWE
 Ze3Zvywz3lUh+23siGhLOBK+hnuX8C4iHghM3Pi9VuOF/DkhAj81
X-Google-Smtp-Source: AGHT+IFlVc/0F8TvVbcNG1rotcSqC6+jiCKwQXArLctpRVZaNKEK+FkI6km+V5DUBw92MhdckhdgRw==
X-Received: by 2002:a05:6a20:258e:b0:1a1:4d41:3570 with SMTP id
 k14-20020a056a20258e00b001a14d413570mr1673757pzd.59.1710244274257; 
 Tue, 12 Mar 2024 04:51:14 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 n2-20020a170902d2c200b001dd9da359c5sm3888949plc.4.2024.03.12.04.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 04:51:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 21:51:08 +1000
Message-Id: <CZRQZUIK2SFV.1WJ6FACW9RGSQ@wheely>
Cc: <clg@kaod.org>, <mikey@neuling.org>, <amachhiw@linux.vnet.ibm.com>,
 <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 14/14] spapr: nested: Introduce cap-nested-papr for
 Nested PAPR API
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-15-harshpb@linux.ibm.com>
In-Reply-To: <20240308111940.1617660-15-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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
> Introduce a SPAPR capability cap-nested-papr which enables nested PAPR
> API for nested guests. This new API is to enable support for KVM on Power=
VM
> and the support in Linux kernel has already merged upstream.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  include/hw/ppc/spapr.h |  6 +++-
>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_caps.c    | 62 ++++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_nested.c  |  8 ++++--
>  4 files changed, 74 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 6223873641..4aaf23d28f 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -81,8 +81,10 @@ typedef enum {
>  #define SPAPR_CAP_RPT_INVALIDATE        0x0B
>  /* Support for AIL modes */
>  #define SPAPR_CAP_AIL_MODE_3            0x0C
> +/* Nested PAPR */
> +#define SPAPR_CAP_NESTED_PAPR           0x0D
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_AIL_MODE_3 + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_PAPR + 1)
> =20
>  /*
>   * Capability Values
> @@ -592,6 +594,7 @@ struct SpaprMachineState {
>  #define H_GUEST_CREATE_VCPU      0x474
>  #define H_GUEST_GET_STATE        0x478
>  #define H_GUEST_SET_STATE        0x47C
> +#define H_GUEST_RUN_VCPU         0x480
>  #define H_GUEST_DELETE           0x488
> =20
>  #define MAX_HCALL_OPCODE         H_GUEST_DELETE
> @@ -996,6 +999,7 @@ extern const VMStateDescription vmstate_spapr_cap_sbb=
c;
>  extern const VMStateDescription vmstate_spapr_cap_ibs;
>  extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
>  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
> +extern const VMStateDescription vmstate_spapr_cap_nested_papr;
>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>  extern const VMStateDescription vmstate_spapr_cap_fwnmi;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 54fc01e462..beb23fae8f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2121,6 +2121,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_fwnmi,
>          &vmstate_spapr_fwnmi,
>          &vmstate_spapr_cap_rpt_invalidate,
> +        &vmstate_spapr_cap_nested_papr,
>          NULL
>      }
>  };
> @@ -4687,6 +4688,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_WORKAROUND;
>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB *=
/
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_NESTED_PAPR] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON=
;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_FWNMI] =3D SPAPR_CAP_ON;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index e889244e52..d6d5a6b8df 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -487,6 +487,58 @@ static void cap_nested_kvm_hv_apply(SpaprMachineStat=
e *spapr,
>              error_append_hint(errp, "Try appending -machine cap-nested-h=
v=3Doff "
>                                      "or use threads=3D1 with -smp\n");
>          }
> +        if (spapr_nested_api(spapr) &&
> +            spapr_nested_api(spapr) !=3D NESTED_API_KVM_HV) {
> +            error_setg(errp, "Nested-HV APIs are mutually exclusive/inco=
mpatible");
> +            error_append_hint(errp, "Please use either cap-nested-hv or =
"
> +                                    "cap-nested-papr to proceed.\n");
> +            return;
> +        } else {
> +            spapr->nested.api =3D NESTED_API_KVM_HV;
> +        }
> +    }
> +}
> +
> +static void cap_nested_papr_apply(SpaprMachineState *spapr,
> +                                    uint8_t val, Error **errp)
> +{
> +    ERRP_GUARD();
> +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (!val) {
> +        /* capability disabled by default */
> +        return;
> +    }
> +
> +    if (tcg_enabled()) {
> +        if (!(env->insns_flags2 & PPC2_ISA300)) {
> +            error_setg(errp, "Nested-PAPR only supported on POWER9 and l=
ater");
> +            error_append_hint(errp,
> +                              "Try appending -machine cap-nested-papr=3D=
off\n");
> +            return;
> +        }
> +        if (spapr_nested_api(spapr) &&
> +            spapr_nested_api(spapr) !=3D NESTED_API_PAPR) {
> +            error_setg(errp, "Nested-HV APIs are mutually exclusive/inco=
mpatible");
> +            error_append_hint(errp, "Please use either cap-nested-hv or =
"
> +                                    "cap-nested-papr to proceed.\n");
> +            return;
> +        } else {
> +            spapr->nested.api =3D NESTED_API_PAPR;
> +        }
> +
> +    } else if (kvm_enabled()) {
> +        /*
> +         * this gets executed in L1 qemu when L2 is launched,
> +         * needs kvm-hv support in L1 kernel.
> +         */
> +        if (!kvmppc_has_cap_nested_kvm_hv()) {
> +            error_setg(errp,
> +                       "KVM implementation does not support Nested-HV");
> +        } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
> +            error_setg(errp, "Error enabling Nested-HV with KVM");
> +        }

I'll just disable this on KVM for now. With that changed,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>      }
>  }
> =20
> @@ -735,6 +787,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "bool",
>          .apply =3D cap_nested_kvm_hv_apply,
>      },
> +    [SPAPR_CAP_NESTED_PAPR] =3D {
> +        .name =3D "nested-papr",
> +        .description =3D "Allow Nested HV (PAPR API)",
> +        .index =3D SPAPR_CAP_NESTED_PAPR,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
> +        .apply =3D cap_nested_papr_apply,
> +    },
>      [SPAPR_CAP_LARGE_DECREMENTER] =3D {
>          .name =3D "large-decr",
>          .description =3D "Allow Large Decrementer",
> @@ -919,6 +980,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
>  SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> +SPAPR_CAP_MIG_STATE(nested_papr, SPAPR_CAP_NESTED_PAPR);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>  SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 597dba7fdc..8db9dc19e3 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -13,13 +13,15 @@
>  void spapr_nested_reset(SpaprMachineState *spapr)
>  {
>      if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV)) {
> -        spapr->nested.api =3D NESTED_API_KVM_HV;
>          spapr_unregister_nested_hv();
>          spapr_register_nested_hv();
> -    } else {
> -        spapr->nested.api =3D 0;
> +    } else if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_PAPR)) {
>          spapr->nested.capabilities_set =3D false;
> +        spapr_unregister_nested_papr();
> +        spapr_register_nested_papr();
>          spapr_nested_gsb_init();
> +    } else {
> +        spapr->nested.api =3D 0;
>      }
>  }
> =20


