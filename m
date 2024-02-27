Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6E3C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 12:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rewSq-0006aF-LK; Tue, 27 Feb 2024 07:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rewSp-0006Zc-1T; Tue, 27 Feb 2024 07:21:39 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rewSm-0005qq-67; Tue, 27 Feb 2024 07:21:37 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e5562158a8so260b3a.3; 
 Tue, 27 Feb 2024 04:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709036494; x=1709641294; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkCS7sMvEqhguoKnYki94Kfyn8T2LKKQdJNAbymol/w=;
 b=Z1jOaGARAwHfTmalgA4AMKfchG9oi638Y0uPlSeQkWKIx6SRL5NwNxE6u2QwaDm+gf
 KcuAXBM74Xll+krWvCIZHwe8k12UZWU/6Pmc1wWHLC6eK/2h2hPrMosI7LLYJzRcj1we
 C3Le91EtBEHetzIJKJQGkeO+KaA2bnv0I3EWc+vGLAzkq/EhgsUxapOoe3QkGfQNYYhT
 uMdsrEsFANT0eOAri8OluXQuLElhRIlcznKY6c4jAZU0BiSVbwQm3Q9n78WfHaMjoAIj
 TqefyOmHvgUSFX04pMnGJaV8Uk4kpLlE/bTRtzOPKl8o5BGrf/eKv7UtBw+TvVz04IDV
 85VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709036494; x=1709641294;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lkCS7sMvEqhguoKnYki94Kfyn8T2LKKQdJNAbymol/w=;
 b=GWO0lQSVslwBetU7FU8rNfyrLtdcGFZJYm23WOFAOeCR1MreGO40gaFaqXPW9cJUo/
 T8YShqNC7yBqcsGXtQcq5Iw8qwL0hUr3iHYl6Fwdi//PY+qxc2AV/d53Tk23yZT33f0/
 TArF5XycRfHl43i4+KN+q6gkpkm4WKDRbZ7xcKft+f3IVw7JMzGdhC/nK8oexzx5CT27
 QIvDGu07u4VEO6oYadNONm4Nqw6WHtXaTi3KCCKH1WB4QvAFeh2inehDVZ05W9m2GwJp
 J3Xy3AqbzB0HtVBY4ztaPmOPoGEjtB+W5C17URD90tlD+1Ncgk61nMrfYVcvddd7q6bv
 iA4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJcnqjEjmOsy+czSpOn9lx6oNpo6/t2f54CG0DAwBJAND67HjIqiN3Z7A/f0eJZLUELGk8YBUHvFPV3K5LIXIcUumHBaQp/j+BdcgGWdz8LdpQNxKzxeCldqU=
X-Gm-Message-State: AOJu0Yx7NlLL5BmiQCT7LNPytHkOiJp5KWfiYxTuXKPz9TUzglF8b/GX
 eABKdK2g0GXKqapY+tbtWOPi2Z8k41adHrDBib4Vh8OkFqAG9pFl
X-Google-Smtp-Source: AGHT+IFNmgiJ3feZhOOuXLA64DzfU1EGlypxneaw1HY6nxX8QiMCv181QV4xZtmHoYrV6OdGfye+2g==
X-Received: by 2002:a05:6a21:3482:b0:1a1:101c:7c70 with SMTP id
 yo2-20020a056a21348200b001a1101c7c70mr991048pzb.59.1709036490010; 
 Tue, 27 Feb 2024 04:21:30 -0800 (PST)
Received: from localhost (110-175-163-154.tpgi.com.au. [110.175.163.154])
 by smtp.gmail.com with ESMTPSA id
 z25-20020a631919000000b005dc85821c80sm5567163pgl.12.2024.02.27.04.21.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 04:21:29 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 22:21:23 +1000
Message-Id: <CZFUVDPGK7OU.1CBJ2TIMJ719P@wheely>
Subject: Re: [PATCH v8 2/2] ppc: spapr: Enable 2nd DAWR on Power10 pSeries
 machine
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <clg@kaod.org>, <groug@kaod.org>
Cc: <pbonzini@redhat.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <170679876639.188422.11634974895844092362.stgit@ltc-boston1.aus.stglabs.ibm.com>
 <170679878985.188422.6745903342602285494.stgit@ltc-boston1.aus.stglabs.ibm.com>
In-Reply-To: <170679878985.188422.6745903342602285494.stgit@ltc-boston1.aus.stglabs.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

On Fri Feb 2, 2024 at 12:46 AM AEST, Shivaprasad G Bhat wrote:
> As per the PAPR, bit 0 of byte 64 in pa-features property
> indicates availability of 2nd DAWR registers. i.e. If this bit is set, 2n=
d
> DAWR is present, otherwise not. Use KVM_CAP_PPC_DAWR1 capability to find
> whether kvm supports 2nd DAWR or not. If it's supported, allow user to se=
t
> the pa-feature bit in guest DT using cap-dawr1 machine capability.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  hw/ppc/spapr.c         |    7 ++++++-
>  hw/ppc/spapr_caps.c    |   36 ++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_hcall.c   |   25 ++++++++++++++++---------
>  include/hw/ppc/spapr.h |    6 +++++-
>  target/ppc/kvm.c       |   12 ++++++++++++
>  target/ppc/kvm_ppc.h   |   12 ++++++++++++
>  6 files changed, 87 insertions(+), 11 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e8dabc8614..91a97d72e7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -262,7 +262,7 @@ static void spapr_dt_pa_features(SpaprMachineState *s=
papr,
>          0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
>          /* 54: DecFP, 56: DecI, 58: SHA */
>          0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
> -        /* 60: NM atomic, 62: RNG */
> +        /* 60: NM atomic, 62: RNG, 64: DAWR1 (ISA 3.1) */
>          0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
>      };
>      uint8_t *pa_features =3D NULL;
> @@ -303,6 +303,9 @@ static void spapr_dt_pa_features(SpaprMachineState *s=
papr,
>           * in pa-features. So hide it from them. */
>          pa_features[40 + 2] &=3D ~0x80; /* Radix MMU */
>      }
> +    if (spapr_get_cap(spapr, SPAPR_CAP_DAWR1)) {
> +        pa_features[66] |=3D 0x80;
> +    }
> =20
>      _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_si=
ze)));
>  }
> @@ -2138,6 +2141,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_fwnmi,
>          &vmstate_spapr_fwnmi,
>          &vmstate_spapr_cap_rpt_invalidate,
> +        &vmstate_spapr_cap_dawr1,
>          NULL
>      }
>  };
> @@ -4717,6 +4721,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_FWNMI] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_RPT_INVALIDATE] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_DAWR1] =3D SPAPR_CAP_OFF;
> =20
>      /*
>       * This cap specifies whether the AIL 3 mode for
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index e889244e52..677f17cea6 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -655,6 +655,32 @@ static void cap_ail_mode_3_apply(SpaprMachineState *=
spapr,
>      }
>  }
> =20
> +static void cap_dawr1_apply(SpaprMachineState *spapr, uint8_t val,
> +                               Error **errp)
> +{
> +    ERRP_GUARD();
> +
> +    if (!val) {
> +        return; /* Disable by default */
> +    }
> +
> +    if (!ppc_type_check_compat(MACHINE(spapr)->cpu_type,
> +                               CPU_POWERPC_LOGICAL_3_10, 0,
> +                               spapr->max_compat_pvr)) {
> +        warn_report("DAWR1 supported only on POWER10 and later CPUs");
> +    }

Should this be an error?

Should the dawr1 cap be enabled by default for POWER10 machines?

> +
> +    if (kvm_enabled()) {
> +        if (!kvmppc_has_cap_dawr1()) {
> +            error_setg(errp, "DAWR1 not supported by KVM.");
> +            error_append_hint(errp, "Try appending -machine cap-dawr1=3D=
off");
> +        } else if (kvmppc_set_cap_dawr1(val) < 0) {
> +            error_setg(errp, "Error enabling cap-dawr1 with KVM.");
> +            error_append_hint(errp, "Try appending -machine cap-dawr1=3D=
off");
> +        }
> +    }
> +}
> +
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
>          .name =3D "htm",
> @@ -781,6 +807,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "bool",
>          .apply =3D cap_ail_mode_3_apply,
>      },
> +    [SPAPR_CAP_DAWR1] =3D {
> +        .name =3D "dawr1",
> +        .description =3D "Allow 2nd Data Address Watchpoint Register (DA=
WR1)",
> +        .index =3D SPAPR_CAP_DAWR1,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
> +        .apply =3D cap_dawr1_apply,
> +    },
>  };
> =20
>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
> @@ -923,6 +958,7 @@ SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECRE=
MENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>  SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
>  SPAPR_CAP_MIG_STATE(rpt_invalidate, SPAPR_CAP_RPT_INVALIDATE);
> +SPAPR_CAP_MIG_STATE(dawr1, SPAPR_CAP_DAWR1);
> =20
>  void spapr_caps_init(SpaprMachineState *spapr)
>  {
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index fcefd1d1c7..34c1c77c95 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -814,11 +814,12 @@ static target_ulong h_set_mode_resource_set_ciabr(P=
owerPCCPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> -static target_ulong h_set_mode_resource_set_dawr0(PowerPCCPU *cpu,
> -                                                  SpaprMachineState *spa=
pr,
> -                                                  target_ulong mflags,
> -                                                  target_ulong value1,
> -                                                  target_ulong value2)
> +static target_ulong h_set_mode_resource_set_dawr(PowerPCCPU *cpu,
> +                                                     SpaprMachineState *=
spapr,
> +                                                     target_ulong mflags=
,
> +                                                     target_ulong resour=
ce,
> +                                                     target_ulong value1=
,
> +                                                     target_ulong value2=
)

Did the text alignment go wrong here?

Aside from those things,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

