Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C45EC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reubY-00074Y-O9; Tue, 27 Feb 2024 05:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reubX-000739-A6; Tue, 27 Feb 2024 05:22:31 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reubV-00048w-C1; Tue, 27 Feb 2024 05:22:31 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso1323869b3a.2; 
 Tue, 27 Feb 2024 02:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709029345; x=1709634145; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Td2zMcPKoxAdffuc9Elz1CyELFI/k9RLBleaCbwLZ2E=;
 b=co4Q8PrV149PjV74J+WyO0pXxMU3D/pN6tdS64eM4mRffbLQrE2yzaj9YDye6rNEaY
 B3wB7Qj9zp1cw1lxMDzTAXzHRfqqlZ9pBOBvzqFjZ8buZPDTyBYNeKPuGIPB163+BS1h
 3dVV74kZULqL01tbeiFTUQtBi3KpI7fhPLR1Aht6ttXbJKRxbILI1zSgxZh20XNwRW9d
 wNSXv2ifsGeteDdg9YPKk7Fk7w2DZIKkfWL99ly3JLtVk2HaCZAvYtyJ8aErKu41VaeR
 rCUJGS5vb08Ac2xU+P9WJ09s4N40T3+ZXRbYuReTyM7UMZzumrZdqUj82xQHYt86YKND
 /WEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709029345; x=1709634145;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Td2zMcPKoxAdffuc9Elz1CyELFI/k9RLBleaCbwLZ2E=;
 b=MrPXV5P1tAb6jkVJ51UzRWs9OrWWBH0rtDFoHZtOsHn1QJMaGGtDZKp7jf9y0XiHiM
 H4g1I+pad+sYkFaGwla3n3Xj2jW2zGyZQq66w5IHQZ/lsCqhz4v4OP1z+xMCFzdLBaMT
 rWQtwuYNL/HMBVcH8/7fc2BUJKJDyLRkQjHsh7ZQpAfEqqBmpi9IReKBKwhJk1VGEC5E
 oVBeUv6NXe7bX7OPzjyZ4bYIgKee1Bu0PY0gEg7MZw5qwYyT7+Mneo/+YXIfg8DOij6F
 Og/QhqOXGrwIbEFr/nTJO/zDK7/6QSRLHGD1HgOxxAuJqW+JLBeyodCsH1KXYgEy2enc
 8LSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRPxCo7AqRo1zdiMnzVcFsjXqCj0YdROFYgSxQq9GxW03BR0UQVdx+4Tarti6Fx+CBVyM3RpX4wHitJjXEonZnvyn3CBKTrlPAg2cGXCXHFYUtQZTYOw88gT4=
X-Gm-Message-State: AOJu0Yxb4IdQCEm9FLCIzKf8Iwl9SUD6JIB+HFqH6Efzk1bXoFgEnjm9
 ncqoDCmW770/GvrpbIYJvsjsVkwkS9GcVlu9uu0a7FPs1kfGHsb4
X-Google-Smtp-Source: AGHT+IGUNiXneWoNCVdrBS8OETTqFp0DDDPYmO1eHe4oBd8FaiTtFLvzCk3LDybokYaW99AwbDOX0w==
X-Received: by 2002:a17:902:6808:b0:1dc:bc8e:c881 with SMTP id
 h8-20020a170902680800b001dcbc8ec881mr775821plk.0.1709029345452; 
 Tue, 27 Feb 2024 02:22:25 -0800 (PST)
Received: from localhost ([1.146.52.18]) by smtp.gmail.com with ESMTPSA id
 x7-20020a1709028ec700b001d93a85ae13sm1172726plo.309.2024.02.27.02.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 02:22:24 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 20:22:17 +1000
Message-Id: <CZFSC6VAMZY1.3ULCR8539CKCF@wheely>
Cc: <clegoate@redhat.com>, <mikey@neuling.org>,
 <amachhiw@linux.vnet.ibm.com>, <vaibhav@linux.ibm.com>,
 <sbhat@linux.ibm.com>, <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 14/15] spapr: nested: Introduce cap-nested-papr for
 Nested PAPR API
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-15-harshpb@linux.ibm.com>
In-Reply-To: <20240220083609.748325-15-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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
> Introduce a SPAPR capability cap-nested-papr which enables nested PAPR
> API for nested guests. This new API is to enable support for KVM on Power=
VM
> and the support in Linux kernel has already merged upstream.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  include/hw/ppc/spapr.h |  6 ++++-
>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_caps.c    | 56 ++++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_nested.c  | 19 ++++++++++++--
>  4 files changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 036a7db2bc..1b1d37123a 100644
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
> @@ -994,6 +996,7 @@ extern const VMStateDescription vmstate_spapr_cap_sbb=
c;
>  extern const VMStateDescription vmstate_spapr_cap_ibs;
>  extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
>  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
> +extern const VMStateDescription vmstate_spapr_cap_nested_papr;
>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>  extern const VMStateDescription vmstate_spapr_cap_fwnmi;
> @@ -1041,5 +1044,6 @@ void spapr_watchdog_init(SpaprMachineState *spapr);
>  void spapr_register_nested_hv(void);
>  void spapr_unregister_nested_hv(void);
>  void spapr_register_nested_papr(void);
> +void spapr_unregister_nested_papr(void);
> =20
>  #endif /* HW_SPAPR_H */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3453b30a57..cb556ae6a8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2120,6 +2120,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_fwnmi,
>          &vmstate_spapr_fwnmi,
>          &vmstate_spapr_cap_rpt_invalidate,
> +        &vmstate_spapr_cap_nested_papr,
>          NULL
>      }
>  };
> @@ -4688,6 +4689,7 @@ static void spapr_machine_class_init(ObjectClass *o=
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
> index 721ddad23b..9a29ce1872 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -487,12 +487,58 @@ static void cap_nested_kvm_hv_apply(SpaprMachineSta=
te *spapr,
>              error_append_hint(errp, "Try appending -machine cap-nested-h=
v=3Doff "
>                                      "or use threads=3D1 with -smp\n");
>          }
> +        if (spapr->nested.api) {
> +            warn_report("nested.api already set as %d, re-init to kvm-hv=
",
> +                        spapr->nested.api);
> +        }

Does this warning trigger when you reset the machine?

It's trying to catch both caps enabled? I would make that an error and
fail and tell user to enable only one or the other.

(In a future patch I think we should try permit both to be enabled at
the same time, but for now restricting it is fine)

>          spapr->nested.api =3D NESTED_API_KVM_HV;
>          spapr_unregister_nested_hv(); /* reset across reboots */
>          spapr_register_nested_hv();
>      }
>  }
> =20
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
> +    }
> +    if (spapr->nested.api) {
> +        warn_report("nested.api already set as %d, re-init to nested-pap=
r",
> +                    spapr->nested.api);
> +    }
> +    spapr->nested.api =3D NESTED_API_PAPR;
> +    spapr->nested.capabilities_set =3D false;
> +    spapr_unregister_nested_papr(); /* reset across reboots */
> +    spapr_register_nested_papr();
> +    spapr_nested_gsb_init();
> +}
> +
>  static void cap_large_decr_apply(SpaprMachineState *spapr,
>                                   uint8_t val, Error **errp)
>  {
> @@ -738,6 +784,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
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
> @@ -922,6 +977,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
>  SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> +SPAPR_CAP_MIG_STATE(nested_papr, SPAPR_CAP_NESTED_PAPR);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>  SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index db1c59a8f5..6e6a90616e 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -13,8 +13,6 @@
>  void spapr_nested_init(SpaprMachineState *spapr)
>  {
>      spapr->nested.api =3D 0;
> -    spapr->nested.capabilities_set =3D false;
> -    spapr_nested_gsb_init();
>  }
> =20
>  uint8_t spapr_nested_api(SpaprMachineState *spapr)
> @@ -1821,6 +1819,18 @@ void spapr_register_nested_papr(void)
>      spapr_register_hypercall(H_GUEST_RUN_VCPU        , h_guest_run_vcpu)=
;
>  }
> =20
> +void spapr_unregister_nested_papr(void)
> +{
> +    spapr_unregister_hypercall(H_GUEST_GET_CAPABILITIES);
> +    spapr_unregister_hypercall(H_GUEST_SET_CAPABILITIES);
> +    spapr_unregister_hypercall(H_GUEST_CREATE);
> +    spapr_unregister_hypercall(H_GUEST_DELETE);
> +    spapr_unregister_hypercall(H_GUEST_CREATE_VCPU);
> +    spapr_unregister_hypercall(H_GUEST_SET_STATE);
> +    spapr_unregister_hypercall(H_GUEST_GET_STATE);
> +    spapr_unregister_hypercall(H_GUEST_RUN_VCPU);
> +}

Oh they all came at once here.

And... you're not doing the same thing with the register_hypercall I
guess because then you have function defined but not used warnings?
I would just add the unregister in the same patches that add the
register.

Thanks,
Nick

