Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E1DC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Xy-0000b7-DB; Tue, 12 Mar 2024 08:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1Wa-0006vb-Cf; Tue, 12 Mar 2024 08:46:34 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1WU-000137-RF; Tue, 12 Mar 2024 08:46:30 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5c229dabbb6so4003020a12.0; 
 Tue, 12 Mar 2024 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710247584; x=1710852384; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHGHLoQ4pKf9EM8EGddlLuF0eZXwjM2tjqC6L82Jsjg=;
 b=XOWSatZUwwwb8HCSwMDrOKBjqpF967A9LJt3FYDVEBCNpaBFkHVeu1SUFupqOqAUQn
 XLIyLlq/yTukGOFlBYCGf/VRSWYEe+NmFppAxC3fSerT9mJpgn8D24nGjRSTA0PB9B21
 cqGpLZ7o6e/oExs8LPqwX0/l5Fa2BKk/Fq4hcJqwK5uCCDrS0e+EFOlS7PAd1UjmWmJq
 C++++L8B6+C4qXYH/DpN660cyx9yxm04UbkAe0Yx16IWZMWF3j84/qE1e/UMX7faZbeL
 Ssww3uIW1N1pTlqvnQxyPxPVdi7B+heKnGpK4gYB4ffb/id6YCag5m9vxEScJyVCIEcK
 SqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710247584; x=1710852384;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lHGHLoQ4pKf9EM8EGddlLuF0eZXwjM2tjqC6L82Jsjg=;
 b=GnD4jERvcQIXL691WsWNeJXRGu8IDtLYbUE9Gc8itM08dM8FewfTp/Mt8kBYjOiZEr
 I6bFl9RnTaXscfcOUtwHgeBLNXW9A7vpgrao5ciSpdMOHEHnMdeXOhx9Vqd3cdAFyaGa
 SzIqEEHC6p/lOOQ7SE4P1hhJNI/LZJfiYoouOZzlXK4Bf4xewCJwKyvL+nH4/Pe5io//
 ZpWhZb/YTLPvcPBJrgp3sLms/26gXGu+8nAWmGqnUDQuYS3cYdg/IFDRHGexzSIOCnni
 bPGdSmOX8gFMyfHOyfQtIxtXRf5IMLr9KGTY/K3DBj/2khIDG2Dzg+v7189jQkrZioXm
 jgnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtBjOrnUZFqEzl9bM5FraZafy5KSu6zR5EUKTEdb1X8kaG1DfV/VfNjq0uO6gvpSQPJkzIQPOYRclQF7q1iM3B9HOWp4ZTR8DBrJVvreFvvcUXbJ7zwXAlaJU=
X-Gm-Message-State: AOJu0Yzha2xKT+L7J+eSZuZwgKS4Hoon/4CrNpoW4Mr9MRuWPNcKl5xj
 BiwW5wAQ9Bhcol1NRPGR4Q8g98KwP85DdiQ0fke6BRCt0bE+Zwsg
X-Google-Smtp-Source: AGHT+IFROURfd00m1K4Tl2RoKvcNgDCNT9ucw+HxwbOuPt+OVMTJs0hbKXVsgwinr9smXS6KwLYZuQ==
X-Received: by 2002:a17:902:d58b:b0:1dd:b6b8:a689 with SMTP id
 k11-20020a170902d58b00b001ddb6b8a689mr1857815plh.6.1710247583802; 
 Tue, 12 Mar 2024 05:46:23 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 y16-20020a17090264d000b001dd5f7a9e92sm6767733pli.157.2024.03.12.05.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 05:46:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 22:46:17 +1000
Message-Id: <CZRS62SNOFMR.3J2Z3LF2BQNYB@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, <mikey@neuling.org>, <amachhiw@linux.vnet.ibm.com>,
 <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 14/14] spapr: nested: Introduce cap-nested-papr for
 Nested PAPR API
X-Mailer: aerc 0.15.2
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-15-harshpb@linux.ibm.com>
 <CZRQZUIK2SFV.1WJ6FACW9RGSQ@wheely>
 <d7ca6bc6-ffe2-461f-b6b6-b4029f04f80f@linux.ibm.com>
In-Reply-To: <d7ca6bc6-ffe2-461f-b6b6-b4029f04f80f@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x529.google.com
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

On Tue Mar 12, 2024 at 10:11 PM AEST, Harsh Prateek Bora wrote:
> Hi Nick,
>
> On 3/12/24 17:21, Nicholas Piggin wrote:
> > On Fri Mar 8, 2024 at 9:19 PM AEST, Harsh Prateek Bora wrote:
> >> Introduce a SPAPR capability cap-nested-papr which enables nested PAPR
> >> API for nested guests. This new API is to enable support for KVM on Po=
werVM
> >> and the support in Linux kernel has already merged upstream.
> >>
> >> Signed-off-by: Michael Neuling <mikey@neuling.org>
> >> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> >> ---
> >>   include/hw/ppc/spapr.h |  6 +++-
> >>   hw/ppc/spapr.c         |  2 ++
> >>   hw/ppc/spapr_caps.c    | 62 ++++++++++++++++++++++++++++++++++++++++=
++
> >>   hw/ppc/spapr_nested.c  |  8 ++++--
> >>   4 files changed, 74 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 6223873641..4aaf23d28f 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -81,8 +81,10 @@ typedef enum {
> >>   #define SPAPR_CAP_RPT_INVALIDATE        0x0B
> >>   /* Support for AIL modes */
> >>   #define SPAPR_CAP_AIL_MODE_3            0x0C
> >> +/* Nested PAPR */
> >> +#define SPAPR_CAP_NESTED_PAPR           0x0D
> >>   /* Num Caps */
> >> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_AIL_MODE_3 + 1)
> >> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_PAPR + 1)
> >>  =20
> >>   /*
> >>    * Capability Values
> >> @@ -592,6 +594,7 @@ struct SpaprMachineState {
> >>   #define H_GUEST_CREATE_VCPU      0x474
> >>   #define H_GUEST_GET_STATE        0x478
> >>   #define H_GUEST_SET_STATE        0x47C
> >> +#define H_GUEST_RUN_VCPU         0x480
> >>   #define H_GUEST_DELETE           0x488
> >>  =20
> >>   #define MAX_HCALL_OPCODE         H_GUEST_DELETE
> >> @@ -996,6 +999,7 @@ extern const VMStateDescription vmstate_spapr_cap_=
sbbc;
> >>   extern const VMStateDescription vmstate_spapr_cap_ibs;
> >>   extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
> >>   extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
> >> +extern const VMStateDescription vmstate_spapr_cap_nested_papr;
> >>   extern const VMStateDescription vmstate_spapr_cap_large_decr;
> >>   extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
> >>   extern const VMStateDescription vmstate_spapr_cap_fwnmi;
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 54fc01e462..beb23fae8f 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -2121,6 +2121,7 @@ static const VMStateDescription vmstate_spapr =
=3D {
> >>           &vmstate_spapr_cap_fwnmi,
> >>           &vmstate_spapr_fwnmi,
> >>           &vmstate_spapr_cap_rpt_invalidate,
> >> +        &vmstate_spapr_cap_nested_papr,
> >>           NULL
> >>       }
> >>   };
> >> @@ -4687,6 +4688,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
> >>       smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_WORKAROUND;
> >>       smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64k=
iB */
> >>       smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OF=
F;
> >> +    smc->default_caps.caps[SPAPR_CAP_NESTED_PAPR] =3D SPAPR_CAP_OFF;
> >>       smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CA=
P_ON;
> >>       smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_ON;
> >>       smc->default_caps.caps[SPAPR_CAP_FWNMI] =3D SPAPR_CAP_ON;
> >> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >> index e889244e52..d6d5a6b8df 100644
> >> --- a/hw/ppc/spapr_caps.c
> >> +++ b/hw/ppc/spapr_caps.c
> >> @@ -487,6 +487,58 @@ static void cap_nested_kvm_hv_apply(SpaprMachineS=
tate *spapr,
> >>               error_append_hint(errp, "Try appending -machine cap-nest=
ed-hv=3Doff "
> >>                                       "or use threads=3D1 with -smp\n"=
);
> >>           }
> >> +        if (spapr_nested_api(spapr) &&
> >> +            spapr_nested_api(spapr) !=3D NESTED_API_KVM_HV) {
> >> +            error_setg(errp, "Nested-HV APIs are mutually exclusive/i=
ncompatible");
> >> +            error_append_hint(errp, "Please use either cap-nested-hv =
or "
> >> +                                    "cap-nested-papr to proceed.\n");
> >> +            return;
> >> +        } else {
> >> +            spapr->nested.api =3D NESTED_API_KVM_HV;
> >> +        }
> >> +    }
> >> +}
> >> +
> >> +static void cap_nested_papr_apply(SpaprMachineState *spapr,
> >> +                                    uint8_t val, Error **errp)
> >> +{
> >> +    ERRP_GUARD();
> >> +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> >> +    CPUPPCState *env =3D &cpu->env;
> >> +
> >> +    if (!val) {
> >> +        /* capability disabled by default */
> >> +        return;
> >> +    }
> >> +
> >> +    if (tcg_enabled()) {
> >> +        if (!(env->insns_flags2 & PPC2_ISA300)) {
> >> +            error_setg(errp, "Nested-PAPR only supported on POWER9 an=
d later");
> >> +            error_append_hint(errp,
> >> +                              "Try appending -machine cap-nested-papr=
=3Doff\n");
> >> +            return;
> >> +        }
> >> +        if (spapr_nested_api(spapr) &&
> >> +            spapr_nested_api(spapr) !=3D NESTED_API_PAPR) {
> >> +            error_setg(errp, "Nested-HV APIs are mutually exclusive/i=
ncompatible");
> >> +            error_append_hint(errp, "Please use either cap-nested-hv =
or "
> >> +                                    "cap-nested-papr to proceed.\n");
> >> +            return;
> >> +        } else {
> >> +            spapr->nested.api =3D NESTED_API_PAPR;
> >> +        }
> >> +
> >> +    } else if (kvm_enabled()) {
> >> +        /*
> >> +         * this gets executed in L1 qemu when L2 is launched,
> >> +         * needs kvm-hv support in L1 kernel.
> >> +         */
> >> +        if (!kvmppc_has_cap_nested_kvm_hv()) {
> >> +            error_setg(errp,
> >> +                       "KVM implementation does not support Nested-HV=
");
> >> +        } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
> >> +            error_setg(errp, "Error enabling Nested-HV with KVM");
> >> +        }
> >=20
> > I'll just disable this on KVM for now. With that changed,
> >=20
> > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> >=20
>
> AFAIK, v2 api also expects this capability to be enabled on L1 kernel.
> I guess the reason is the L1 implementation has used the same capab and
> extended to be used with v2 api. So, this check is needed in L1 Qemu for
> now. We may revisit L1 implementation later to see if a change is
> appropriate.

The capability is what the pseries machine provides its software. So,
can the OS running under QEMU use the hypervisor v1 or v2 hypercalls and
run KVM. KVM does not implement the PAPR API (yet) so it does not
support this cap.

KVM can *consume* the PAPR API when it's running as an L1 on top of an
L0 that provides it. That side of it is queried via the hcalls.

Thanks,
Nick

