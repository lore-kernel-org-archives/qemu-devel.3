Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25BBC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0LS-0001yW-Lp; Tue, 12 Mar 2024 07:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0LM-0001lh-7A; Tue, 12 Mar 2024 07:30:52 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0LK-0001eS-9K; Tue, 12 Mar 2024 07:30:51 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dd8d586126so13772015ad.0; 
 Tue, 12 Mar 2024 04:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710243048; x=1710847848; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtjgEMtZ12JFH/2dl+Qu9jel7j2U3MLuLUlQiEpheDk=;
 b=M+gxutFhNPq9kS99cUEkI7/9/Y9jBBP2BwztQg0vLZb+4n2Uybs4w+NviKyQmpZP4G
 lD8yl9O813ss5W/EmtCkex3S+QeeBtEQjfJfosjad400SFpaFW+B8OMdRgYzsgWTDuwd
 Ugi4Jf2v+H4rTxkWvTfK1lW+XCD3pvD2hPgKN08jwl6g+qDT7BCLx0TRi87QCJYXB2/I
 WtKl0TePI1XWxifZNlkCbFwIRaW2NLk3s4//K2I/XV/MpSSd9VmRnbIp4FZSqlEZVxgm
 ueqoT50yrtwD/MqazDMCmRNZ5VDGW+24V/N2RuuOkzrgjOykMiZo3TtCt/3CL/UAdvxR
 9u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710243048; x=1710847848;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GtjgEMtZ12JFH/2dl+Qu9jel7j2U3MLuLUlQiEpheDk=;
 b=mp2v9WrAitEPwECN5ijMSlLqXG3F1ayIVFGmkd1O3zonkkzWzqTGg8wFseBpQcjqPp
 BeKjP60e52TRFDJL4w4IztnVoVy7OdcWcpLYavcSzu0dO6IAjEah645+M5YPDfF6YNxL
 /tbHj8c7NxpuTurGJmy3cBqt51SX81J7q1Yw96cLK5ipEzJPyG4r4Cq9X6V+V9/oOPlS
 URQTLjppyc90rIolb7u1fk3dr9eKoruI2TrL1S6xZvWTzhFBnwNedqEVnGlwFY3Le7QN
 ivicgwkqc0jEX2a9y+anO4M2XlAC0QEelOH7wSoSugnhE+7MohUO/jUQce+icR/y4Fif
 x52g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhxO7+w2vwmmMZzGK4F6EywgRWPMAEvqNR5pvy/ZKIvY+V1ZRN5fQwB4IEphzSe1x8XgCIvN4jszm9KY9Sf2nx7/KDPHAW1sPwXXuJkx4Y/c0z8r0b6QNFtGo=
X-Gm-Message-State: AOJu0Yz1DPrVJLZJdcoJ/qU1A0APJRUnCvFqrVau9tXONa6q37pgNUal
 oW7g/ZvdfEzt7Uf5tnBrC0khCmpNfaewrk7eHEN2Wn/y+BRVNln3/SQoivtO5hU=
X-Google-Smtp-Source: AGHT+IHVA+8qDtXBw50w9OlrIe70X+Q7R2baaln87BSeMGkSQ6GVMbf1vHOoGN0pUzzk0vPUTiJJKw==
X-Received: by 2002:a17:902:d581:b0:1dd:a134:5699 with SMTP id
 k1-20020a170902d58100b001dda1345699mr3824887plh.28.1710243048625; 
 Tue, 12 Mar 2024 04:30:48 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 jc3-20020a17090325c300b001d74502d261sm6492570plb.115.2024.03.12.04.30.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 04:30:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 21:30:42 +1000
Message-Id: <CZRQK7DERSM1.2R2YTNGKSY68B@wheely>
Cc: <clg@kaod.org>, <mikey@neuling.org>, <amachhiw@linux.vnet.ibm.com>,
 <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 07/14] spapr: nested: Introduce
 H_GUEST_[CREATE|DELETE] hcalls.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-8-harshpb@linux.ibm.com>
In-Reply-To: <20240308111940.1617660-8-harshpb@linux.ibm.com>
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

On Fri Mar 8, 2024 at 9:19 PM AEST, Harsh Prateek Bora wrote:
> Introduce the nested PAPR hcalls:
>     - H_GUEST_CREATE which is used to create and allocate resources for
> nested guest being created.
>     - H_GUEST_DELETE which is used to delete and deallocate resources
> for the nested guest being deleted. It also supports deleting all nested
> guests at once using a deleteAll flag.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  include/hw/ppc/spapr.h        |   4 +-
>  include/hw/ppc/spapr_nested.h |   7 +++
>  hw/ppc/spapr_nested.c         | 103 ++++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 2906d59137..13416fc3d7 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -586,8 +586,10 @@ struct SpaprMachineState {
>  #define H_WATCHDOG              0x45C
>  #define H_GUEST_GET_CAPABILITIES 0x460
>  #define H_GUEST_SET_CAPABILITIES 0x464
> +#define H_GUEST_CREATE           0x470
> +#define H_GUEST_DELETE           0x488
> =20
> -#define MAX_HCALL_OPCODE         H_GUEST_SET_CAPABILITIES
> +#define MAX_HCALL_OPCODE         H_GUEST_DELETE
> =20
>  /* The hcalls above are standardized in PAPR and implemented by pHyp
>   * as well.
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index 73687e03e4..56d43e540b 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -9,8 +9,13 @@ typedef struct SpaprMachineStateNested {
>  #define NESTED_API_KVM_HV  1
>      bool capabilities_set;
>      uint32_t pvr_base;
> +    GHashTable *guests;
>  } SpaprMachineStateNested;
> =20
> +typedef struct SpaprMachineStateNestedGuest {
> +    uint32_t pvr_logical;
> +} SpaprMachineStateNestedGuest;
> +
>  /* Nested PAPR API related macros */
>  #define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
>  #define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
> @@ -20,6 +25,8 @@ typedef struct SpaprMachineStateNested {
>  #define H_GUEST_CAP_COPY_MEM_BMAP     0
>  #define H_GUEST_CAP_P9_MODE_BMAP      1
>  #define H_GUEST_CAP_P10_MODE_BMAP     2
> +#define PAPR_NESTED_GUEST_MAX         4096
> +#define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
> =20
>  /*
>   * Register state for entering a nested guest with H_ENTER_NESTED.
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 601f669060..13674c0857 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -520,6 +520,105 @@ static target_ulong h_guest_set_capabilities(PowerP=
CCPU *cpu,
>      }
>  }
> =20
> +static void
> +destroy_guest_helper(gpointer value)
> +{
> +    struct SpaprMachineStateNestedGuest *guest =3D value;
> +    g_free(guest);
> +}
> +
> +static target_ulong h_guest_create(PowerPCCPU *cpu,
> +                                   SpaprMachineState *spapr,
> +                                   target_ulong opcode,
> +                                   target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong flags =3D args[0];
> +    target_ulong continue_token =3D args[1];
> +    uint64_t guestid;
> +    int nguests =3D 0;
> +    struct SpaprMachineStateNestedGuest *guest;
> +
> +    if (flags) { /* don't handle any flags for now */
> +        return H_UNSUPPORTED_FLAG;
> +    }
> +
> +    if (continue_token !=3D -1) {
> +        return H_P2;
> +    }
> +
> +    if (!spapr->nested.capabilities_set) {
> +        return H_STATE;
> +    }
> +
> +    if (!spapr->nested.guests) {
> +        spapr->nested.guests =3D g_hash_table_new_full(NULL,
> +                                                     NULL,
> +                                                     NULL,
> +                                                     destroy_guest_helpe=
r);
> +    }
> +
> +    nguests =3D g_hash_table_size(spapr->nested.guests);
> +
> +    if (nguests =3D=3D PAPR_NESTED_GUEST_MAX) {
> +        return H_NO_MEM;
> +    }
> +
> +    /* Lookup for available guestid */
> +    for (guestid =3D 1; guestid < PAPR_NESTED_GUEST_MAX; guestid++) {
> +        if (!(g_hash_table_lookup(spapr->nested.guests,
> +                                  GINT_TO_POINTER(guestid)))) {
> +            break;
> +        }
> +    }
> +
> +    if (guestid =3D=3D PAPR_NESTED_GUEST_MAX) {
> +        return H_NO_MEM;
> +    }
> +
> +    guest =3D g_try_new0(struct SpaprMachineStateNestedGuest, 1);
> +    if (!guest) {
> +        return H_NO_MEM;
> +    }
> +
> +    guest->pvr_logical =3D spapr->nested.pvr_base;
> +    g_hash_table_insert(spapr->nested.guests, GINT_TO_POINTER(guestid), =
guest);
> +    env->gpr[4] =3D guestid;
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_guest_delete(PowerPCCPU *cpu,
> +                                   SpaprMachineState *spapr,
> +                                   target_ulong opcode,
> +                                   target_ulong *args)
> +{
> +    target_ulong flags =3D args[0];
> +    target_ulong guestid =3D args[1];
> +    struct SpaprMachineStateNestedGuest *guest;
> +
> +    /*
> +     * handle flag deleteAllGuests, if set:
> +     * guestid is ignored and all guests are deleted
> +     *
> +     */
> +    if (flags & ~H_GUEST_DELETE_ALL_FLAG) {
> +        return H_UNSUPPORTED_FLAG; /* other flag bits reserved */
> +    } else if (flags & H_GUEST_DELETE_ALL_FLAG) {
> +        g_hash_table_destroy(spapr->nested.guests);
> +        return H_SUCCESS;
> +    }
> +
> +    guest =3D g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(=
guestid));
> +    if (!guest) {
> +        return H_P2;
> +    }
> +
> +    g_hash_table_remove(spapr->nested.guests, GINT_TO_POINTER(guestid));
> +
> +    return H_SUCCESS;
> +}
> +
>  void spapr_register_nested_hv(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
> @@ -540,12 +639,16 @@ void spapr_register_nested_papr(void)
>  {
>      spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capab=
ilities);
>      spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capab=
ilities);
> +    spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
> +    spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
>  }
> =20
>  void spapr_unregister_nested_papr(void)
>  {
>      spapr_unregister_hypercall(H_GUEST_GET_CAPABILITIES);
>      spapr_unregister_hypercall(H_GUEST_SET_CAPABILITIES);
> +    spapr_unregister_hypercall(H_GUEST_CREATE);
> +    spapr_unregister_hypercall(H_GUEST_DELETE);
>  }
> =20
>  #else


