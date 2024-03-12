Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F2EC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0M1-0002iW-OV; Tue, 12 Mar 2024 07:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0Lj-0002PI-0L; Tue, 12 Mar 2024 07:31:16 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0LZ-0001gC-J9; Tue, 12 Mar 2024 07:31:08 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dc29f1956cso25773355ad.0; 
 Tue, 12 Mar 2024 04:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710243064; x=1710847864; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqUlLXEYkO5E5xu3upvgrjqexiwawNFT7TqAcgfRPBY=;
 b=E4WJNgGgpCEHevor2/ChQ4vYkBvjyDdHL+LtEzvLHbFWA7zoBWTW1OiWMf/RO1LwFa
 7XWtxZi6s/ks/jRAajDHoFo8f8mJBSassXmpxBcAoydf1mKKJ7jAfHq0J0HU4C3CJO8h
 dDf1+bFFZxuWuzvO/4iuuuH8B7YXXKCIM6JZP+zjg2q9VWk0cB8mX5YdhIFplOn9o6FS
 XRTPDSH8dARnpGWFDpLS4AcB2QOSJNu1y9gnwg7BtPProkNh9wK6hZUB11J+tLxY7C8G
 oQqegW8AzFOoc+EFJ5VTEAP8uiBXPoMnHppfsvWGHhp9RGjqbcD2inzB6WH5WeZxtfmR
 Q6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710243064; x=1710847864;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KqUlLXEYkO5E5xu3upvgrjqexiwawNFT7TqAcgfRPBY=;
 b=a97VFAx3SUT4etMIsZQY/1YED+PAc+pQLMYwD5YEe0S1/w2PEGgKBsBrLqdvP+F1Lw
 vvi3w+5+yTZp02tPJBdYeao6+vfZAUy+PXzejz1yyFx20DycilE3+MvjWjDEjOVSdtsm
 lpRbeNRr1IsiwL34NQt8enMwXZquEU2HH+kQpiUcfrdyw9txSt96lWqakTnL6WrW9pBq
 baTP8S4MGeGTbhdO4y2gQMVf3SIIJcizl6JBKJtmhLBZTDiZF+IrOo2yH+GONXgqOdDJ
 Zkhcq9GD0X/5+Sq/vRX3f5UbA4jhTFFxbYIXJyYdNtdFf/RZ64gxUtmPToFDsKtSqVtH
 IN6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA81GoXtk9UMnUr5fEUhNzLuNd5W2p/YQLlHbz5/wC/L7bMeOzyN1C3TnAQ40SW45gXG+61TKGa1YARBwjQQ/DynwfgcrqtPYL3XP8yO7bWs9dbAchKrC8vxg=
X-Gm-Message-State: AOJu0YxX4xgE60N9Tc0q5uY4Iv9eDngm7HqJ5Vku6eCGBv03VmkM3NH5
 klxt6PJ6dnIxEuEjsU0p3b2ZJ1pG9jlh7YI0jGQO2JsJtb9kH/IS
X-Google-Smtp-Source: AGHT+IFm7i6BRZztF36RkzEV5BNRyvmv0vaTXMhT4um0IvevS0VQsFqpNbEr3NQvMSSjO2e9bEntPQ==
X-Received: by 2002:a17:903:2349:b0:1dd:abc2:a028 with SMTP id
 c9-20020a170903234900b001ddabc2a028mr4125338plh.12.1710243063676; 
 Tue, 12 Mar 2024 04:31:03 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 12-20020a170902c10c00b001dc391cc28fsm6444068pli.121.2024.03.12.04.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 04:31:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 21:30:57 +1000
Message-Id: <CZRQKEBW7RXM.38AAGNKKYWQEC@wheely>
Cc: <clg@kaod.org>, <mikey@neuling.org>, <amachhiw@linux.vnet.ibm.com>,
 <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 08/14] spapr: nested: Introduce H_GUEST_CREATE_VCPU
 hcall.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-9-harshpb@linux.ibm.com>
In-Reply-To: <20240308111940.1617660-9-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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
> Introduce the nested PAPR hcall H_GUEST_CREATE_VCPU which is used to
> create and initialize the specified VCPU resource for the previously
> created guest. Each guest can have multiple VCPUs upto max 2048.
> All VCPUs for a guest gets deallocated on guest delete.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  include/hw/ppc/spapr.h        |  2 ++
>  include/hw/ppc/spapr_nested.h |  8 +++++
>  hw/ppc/spapr_nested.c         | 61 +++++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 13416fc3d7..070135793a 100644
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
> index 56d43e540b..2ac3076fac 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -14,6 +14,8 @@ typedef struct SpaprMachineStateNested {
> =20
>  typedef struct SpaprMachineStateNestedGuest {
>      uint32_t pvr_logical;
> +    unsigned long nr_vcpus;
> +    struct SpaprMachineStateNestedGuestVcpu *vcpus;
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
> @@ -120,6 +123,11 @@ struct nested_ppc_state {
>      int64_t tb_offset;
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
> index 13674c0857..4c0e2e91e1 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -8,6 +8,7 @@
>  #include "hw/ppc/spapr_nested.h"
>  #include "mmu-book3s-v3.h"
>  #include "cpu-models.h"
> +#include "qemu/log.h"
> =20
>  void spapr_nested_reset(SpaprMachineState *spapr)
>  {
> @@ -434,6 +435,16 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
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
>  static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
>                                               SpaprMachineState *spapr,
>                                               target_ulong opcode,
> @@ -524,6 +535,7 @@ static void
>  destroy_guest_helper(gpointer value)
>  {
>      struct SpaprMachineStateNestedGuest *guest =3D value;
> +    g_free(guest->vcpus);
>      g_free(guest);
>  }
> =20
> @@ -619,6 +631,53 @@ static target_ulong h_guest_delete(PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
> +                                        SpaprMachineState *spapr,
> +                                        target_ulong opcode,
> +                                        target_ulong *args)
> +{
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
> +    if (vcpuid < guest->nr_vcpus) {
> +        qemu_log_mask(LOG_UNIMP, "vcpuid %ld already in use, return.", v=
cpuid);
> +        return H_IN_USE;
> +    }
> +    /* linear vcpuid allocation only */
> +    assert(vcpuid =3D=3D guest->nr_vcpus);
> +
> +    if (guest->nr_vcpus >=3D PAPR_NESTED_GUEST_VCPU_MAX) {
> +        return H_P3;
> +    }
> +
> +    SpaprMachineStateNestedGuestVcpu *vcpus, *curr_vcpu;
> +    vcpus =3D g_try_renew(struct SpaprMachineStateNestedGuestVcpu,
> +                        guest->vcpus,
> +                        guest->nr_vcpus + 1);
> +    if (!vcpus) {
> +        return H_NO_MEM;
> +    }
> +    guest->vcpus =3D vcpus;
> +    curr_vcpu =3D &vcpus[guest->nr_vcpus];
> +    memset(curr_vcpu, 0, sizeof(SpaprMachineStateNestedGuestVcpu));
> +
> +    curr_vcpu->enabled =3D true;
> +    guest->nr_vcpus++;
> +
> +    return H_SUCCESS;
> +}
> +
>  void spapr_register_nested_hv(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
> @@ -641,6 +700,7 @@ void spapr_register_nested_papr(void)
>      spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capab=
ilities);
>      spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
>      spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
> +    spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vc=
pu);
>  }
> =20
>  void spapr_unregister_nested_papr(void)
> @@ -649,6 +709,7 @@ void spapr_unregister_nested_papr(void)
>      spapr_unregister_hypercall(H_GUEST_SET_CAPABILITIES);
>      spapr_unregister_hypercall(H_GUEST_CREATE);
>      spapr_unregister_hypercall(H_GUEST_DELETE);
> +    spapr_unregister_hypercall(H_GUEST_CREATE_VCPU);
>  }
> =20
>  #else


