Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325C3C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0UB-00028t-7P; Tue, 12 Mar 2024 07:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0TI-00016n-9m; Tue, 12 Mar 2024 07:39:05 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0TD-0003VI-7F; Tue, 12 Mar 2024 07:39:02 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29b73427790so3517365a91.3; 
 Tue, 12 Mar 2024 04:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710243537; x=1710848337; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vW9/sS5zyLCJs1lELzZ1g+corIgv6f2ImIgPDaMELks=;
 b=gDX9k+Cc4bmKv3XzPm1KDcb5zocwBRPi893ws9xGycLst8xyLxNH/O+2geYZ03Q/vy
 QYTLmn/3KFWTLxrsW1xsq2I2HE3e2WGRmOxDXzMty5ZVa0UNy7NapFDPucvCudRb3FVW
 D1OtWMfRJR8nipkc67Zn1ajhVqE5S/1Q8jgnnsMvdI22RuqxEfYEA+aF0C2bWFtKLXpP
 bJkSIFiFKRbdPSygxn32bs+GBUWs6p7QAGpnX6QWi1HmM1boz0EFvKaMnCPbeV1J/6MF
 KzateUzHCAzssgXi0LmQSDo9VYN9FLOisjY/TsdNh6yxrD41mW6fN7kG5VXuJ07fUd8/
 ZH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710243537; x=1710848337;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vW9/sS5zyLCJs1lELzZ1g+corIgv6f2ImIgPDaMELks=;
 b=O1p6uJTDUryQmOG7DNHLLyNhUAN8IOEXvgGBjofzzyKjdb8BqUtWi+L0K20fJxfMyG
 uPfYXckk3y1/BmoxPrbBLalPswQeaprC4s2x8G4aiZ2m8/oY9jisT5xgPWP+j/rsFMSE
 V7l1Va3oocpt3CcTj2EvopGJw/Ury0RJg53RFM66g6GS1kJjP+o+bUN3ZvU6nvzHDKiB
 6iXXKLH9fgi7V4MAcYR8dbtKzLMNLFsXHhVGN+/TO25R4qc4tywZdPnJpxQzuF+IinSp
 jq8ciK+Y2KeWWp3O/MTdGp05fWifFoTljn12EyaoARO0grqs5jpOxTxHXxWeYMu0KEdB
 yuAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYmwX692m8eNsbjYyCdxSfQzXjNyMB1t94/mPz4FBal47bR8Bj6/I48gyFbkGM93x2dPzTypZtHE09wSpOiTyIIiYRzO/jJvqqsqIWFMhaSS/O9w6YAiPpwsA=
X-Gm-Message-State: AOJu0YwnK5QmtjpxAFDx/pmXEYK59XHAkQ0cVUcfz1YqKxmq5txDdUog
 sP0Lj2g3Ugdaoz0+vEzBKF5RLZe8w8pFXmyhgg0TEmpoZkuNqaSf
X-Google-Smtp-Source: AGHT+IEbE6IrsfsLBYTyyDtZ1DSybUvLwq+fR7jn4QDI+AreDbC8SLFDw3leXEkOzAC6AoatI44PNA==
X-Received: by 2002:a17:90b:2396:b0:29a:6086:a8f8 with SMTP id
 mr22-20020a17090b239600b0029a6086a8f8mr51768pjb.16.1710243537271; 
 Tue, 12 Mar 2024 04:38:57 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 j4-20020a17090ac48400b0029bc1b21c9asm5632633pjt.9.2024.03.12.04.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 04:38:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 21:38:51 +1000
Message-Id: <CZRQQFXDP8DY.3N5XEZ8FJ3AMC@wheely>
Cc: <clg@kaod.org>, <mikey@neuling.org>, <amachhiw@linux.vnet.ibm.com>,
 <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 11/14] spapr: nested: Introduce
 H_GUEST_[GET|SET]_STATE hcalls.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-12-harshpb@linux.ibm.com>
In-Reply-To: <20240308111940.1617660-12-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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
>     - H_GUEST_GET_STATE which is used to get state of a nested guest or
>       a guest VCPU. The value field for each element in the request is
>       destination to be updated to reflect current state on success.
>     - H_GUEST_SET_STATE which is used to modify the state of a guest or
>       a guest VCPU. On success, guest (or its VCPU) state shall be
>       updated as per the value field for the requested element(s).
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  include/hw/ppc/spapr.h        |   3 +
>  include/hw/ppc/spapr_nested.h |  23 +++
>  hw/ppc/spapr_nested.c         | 268 ++++++++++++++++++++++++++++++++++
>  3 files changed, 294 insertions(+)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 070135793a..6223873641 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -366,6 +366,7 @@ struct SpaprMachineState {
>  #define H_OVERLAP         -68
>  #define H_STATE           -75
>  #define H_IN_USE          -77
> +#define H_INVALID_ELEMENT_VALUE            -81
>  #define H_UNSUPPORTED_FLAG -256
>  #define H_MULTI_THREADS_ACTIVE -9005
> =20
> @@ -589,6 +590,8 @@ struct SpaprMachineState {
>  #define H_GUEST_SET_CAPABILITIES 0x464
>  #define H_GUEST_CREATE           0x470
>  #define H_GUEST_CREATE_VCPU      0x474
> +#define H_GUEST_GET_STATE        0x478
> +#define H_GUEST_SET_STATE        0x47C
>  #define H_GUEST_DELETE           0x488
> =20
>  #define MAX_HCALL_OPCODE         H_GUEST_DELETE
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index 433d93c480..bd43c6b6ef 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -224,6 +224,10 @@ typedef struct SpaprMachineStateNestedGuest {
>  #define HVMASK_MSR                    0xEBFFFFFFFFBFEFFF
>  #define HVMASK_HDEXCR                 0x00000000FFFFFFFF
>  #define HVMASK_TB_OFFSET              0x000000FFFFFFFFFF
> +#define GSB_MAX_BUF_SIZE              (1024 * 1024)
> +#define H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE 0x8000000000000000
> +#define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
> +#define GUEST_STATE_REQUEST_SET              0x2
> =20
>  /* As per ISA v3.1B, following bits are reserved:
>   *      0:2
> @@ -321,6 +325,25 @@ typedef struct SpaprMachineStateNestedGuest {
>  #define GSE_ENV_DWM(i, f, m) \
>      GUEST_STATE_ELEMENT_MSK(i, 8, f, copy_state_8to8, m)
> =20
> +struct guest_state_element {
> +    uint16_t id;
> +    uint16_t size;
> +    uint8_t value[];
> +} QEMU_PACKED;
> +
> +struct guest_state_buffer {
> +    uint32_t num_elements;
> +    struct guest_state_element elements[];
> +} QEMU_PACKED;
> +
> +/* Actual buffer plus some metadata about the request */
> +struct guest_state_request {
> +    struct guest_state_buffer *gsb;
> +    int64_t buf;
> +    int64_t len;
> +    uint16_t flags;
> +};
> +
>  /*
>   * Register state for entering a nested guest with H_ENTER_NESTED.
>   * New member must be added at the end.
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 07dc294c5a..ca99805ce8 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -1028,6 +1028,140 @@ void spapr_nested_gsb_init(void)
>      }
>  }
> =20
> +static struct guest_state_element *guest_state_element_next(
> +    struct guest_state_element *element,
> +    int64_t *len,
> +    int64_t *num_elements)
> +{
> +    uint16_t size;
> +
> +    /* size is of element->value[] only. Not whole guest_state_element *=
/
> +    size =3D be16_to_cpu(element->size);
> +
> +    if (len) {
> +        *len -=3D size + offsetof(struct guest_state_element, value);
> +    }
> +
> +    if (num_elements) {
> +        *num_elements -=3D 1;
> +    }
> +
> +    return (struct guest_state_element *)(element->value + size);
> +}
> +
> +static
> +struct guest_state_element_type *guest_state_element_type_find(uint16_t =
id)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(guest_state_element_types); i++)
> +        if (id =3D=3D guest_state_element_types[i].id) {
> +            return &guest_state_element_types[i];
> +        }
> +
> +    return NULL;
> +}
> +
> +static void log_element(struct guest_state_element *element,
> +                        struct guest_state_request *gsr)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR, "h_guest_%s_state id:0x%04x size:0x%0=
4x",
> +                  gsr->flags & GUEST_STATE_REQUEST_SET ? "set" : "get",
> +                  be16_to_cpu(element->id), be16_to_cpu(element->size));
> +    qemu_log_mask(LOG_GUEST_ERROR, "buf:0x%016lx ...\n",
> +                  be64_to_cpu(*(uint64_t *)element->value));
> +}
> +
> +static bool guest_state_request_check(struct guest_state_request *gsr)
> +{
> +    int64_t num_elements, len =3D gsr->len;
> +    struct guest_state_buffer *gsb =3D gsr->gsb;
> +    struct guest_state_element *element;
> +    struct guest_state_element_type *type;
> +    uint16_t id, size;
> +
> +    /* gsb->num_elements =3D 0 =3D=3D 32 bits long */
> +    assert(len >=3D 4);
> +
> +    num_elements =3D be32_to_cpu(gsb->num_elements);
> +    element =3D gsb->elements;
> +    len -=3D sizeof(gsb->num_elements);
> +
> +    /* Walk the buffer to validate the length */
> +    while (num_elements) {
> +
> +        id =3D be16_to_cpu(element->id);
> +        size =3D be16_to_cpu(element->size);
> +
> +        if (false) {
> +            log_element(element, gsr);
> +        }
> +        /* buffer size too small */
> +        if (len < 0) {
> +            return false;
> +        }
> +
> +        type =3D guest_state_element_type_find(id);
> +        if (!type) {
> +            qemu_log_mask(LOG_GUEST_ERROR,"Element ID %04x unknown\n", i=
d);
> +            log_element(element, gsr);
> +            return false;
> +        }
> +
> +        if (id =3D=3D GSB_HV_VCPU_IGNORED_ID) {
> +            goto next_element;
> +        }
> +
> +        if (size !=3D type->size) {
> +            qemu_log_mask(LOG_GUEST_ERROR,"Size mismatch. Element ID:%04=
x."
> +                          "Size Exp:%i Got:%i\n", id, type->size, size);
> +            log_element(element, gsr);
> +            return false;
> +        }
> +
> +        if ((type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY) &&
> +            (gsr->flags & GUEST_STATE_REQUEST_SET)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,"trying to set a read-only Ele=
ment "
> +                          "ID:%04x.\n", id);
> +            return false;
> +        }
> +
> +        if (type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE) {
> +            /* guest wide element type */
> +            if (!(gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a guest wi=
de "
> +                              "Element ID:%04x.\n", id);
> +                return false;
> +            }
> +        } else {
> +            /* thread wide element type */
> +            if (gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a thread w=
ide "
> +                              "Element ID:%04x.\n", id);
> +                return false;
> +            }
> +        }
> +next_element:
> +        element =3D guest_state_element_next(element, &len, &num_element=
s);
> +
> +    }
> +    return true;
> +}
> +
> +static bool is_gsr_invalid(struct guest_state_request *gsr,
> +                                   struct guest_state_element *element,
> +                                   struct guest_state_element_type *type=
)
> +{
> +    if ((gsr->flags & GUEST_STATE_REQUEST_SET) &&
> +        (*(uint64_t *)(element->value) & ~(type->mask))) {
> +        log_element(element, gsr);
> +        qemu_log_mask(LOG_GUEST_ERROR, "L1 can't set reserved bits i"
> +                      "(allowed mask: 0x%08lx)\n", type->mask);
> +        return true;
> +    }
> +    return false;
> +}
> +
>  static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
>                                               SpaprMachineState *spapr,
>                                               target_ulong opcode,
> @@ -1261,6 +1395,136 @@ static target_ulong h_guest_create_vcpu(PowerPCCP=
U *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong getset_state(SpaprMachineStateNestedGuest *guest,
> +                                 uint64_t vcpuid,
> +                                 struct guest_state_request *gsr)
> +{
> +    void *ptr;
> +    uint16_t id;
> +    struct guest_state_element *element;
> +    struct guest_state_element_type *type;
> +    int64_t lenleft, num_elements;
> +
> +    lenleft =3D gsr->len;
> +
> +    if (!guest_state_request_check(gsr)) {
> +        return H_P3;
> +    }
> +
> +    num_elements =3D be32_to_cpu(gsr->gsb->num_elements);
> +    element =3D gsr->gsb->elements;
> +    /* Process the elements */
> +    while (num_elements) {
> +        type =3D NULL;
> +        /* log_element(element, gsr); */
> +
> +        id =3D be16_to_cpu(element->id);
> +        if (id =3D=3D GSB_HV_VCPU_IGNORED_ID) {
> +            goto next_element;
> +        }
> +
> +        type =3D guest_state_element_type_find(id);
> +        assert(type);
> +
> +        /* Get pointer to guest data to get/set */
> +        if (type->location && type->copy) {
> +            ptr =3D type->location(guest, vcpuid);
> +            assert(ptr);
> +            if (!~(type->mask) && is_gsr_invalid(gsr, element, type)) {
> +                return H_INVALID_ELEMENT_VALUE;
> +            }
> +            type->copy(ptr + type->offset, element->value,
> +                       gsr->flags & GUEST_STATE_REQUEST_SET ? true : fal=
se);
> +        }
> +
> +next_element:
> +        element =3D guest_state_element_next(element, &lenleft, &num_ele=
ments);
> +    }
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong map_and_getset_state(PowerPCCPU *cpu,
> +                                         SpaprMachineStateNestedGuest *g=
uest,
> +                                         uint64_t vcpuid,
> +                                         struct guest_state_request *gsr=
)
> +{
> +    target_ulong rc;
> +    int64_t len;
> +    bool is_write;
> +
> +    len =3D gsr->len;
> +    /* only get_state would require write access to the provided buffer =
*/
> +    is_write =3D (gsr->flags & GUEST_STATE_REQUEST_SET) ? false : true;
> +    gsr->gsb =3D address_space_map(CPU(cpu)->as, gsr->buf, (uint64_t *)&=
len,
> +                                 is_write, MEMTXATTRS_UNSPECIFIED);
> +    if (!gsr->gsb) {
> +        rc =3D H_P3;
> +        goto out1;
> +    }
> +
> +    if (len !=3D gsr->len) {
> +        rc =3D H_P3;
> +        goto out1;
> +    }
> +
> +    rc =3D getset_state(guest, vcpuid, gsr);
> +
> +out1:
> +    address_space_unmap(CPU(cpu)->as, gsr->gsb, len, is_write, len);
> +    return rc;
> +}
> +
> +static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
> +                                         SpaprMachineState *spapr,
> +                                         target_ulong *args,
> +                                         bool set)
> +{
> +    target_ulong flags =3D args[0];
> +    target_ulong lpid =3D args[1];
> +    target_ulong vcpuid =3D args[2];
> +    target_ulong buf =3D args[3];
> +    target_ulong buflen =3D args[4];
> +    struct guest_state_request gsr;
> +    SpaprMachineStateNestedGuest *guest;
> +
> +    guest =3D spapr_get_nested_guest(spapr, lpid);
> +    if (!guest) {
> +        return H_P2;
> +    }
> +    gsr.buf =3D buf;
> +    assert(buflen <=3D GSB_MAX_BUF_SIZE);
> +    gsr.len =3D buflen;
> +    gsr.flags =3D 0;
> +    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
> +        gsr.flags |=3D GUEST_STATE_REQUEST_GUEST_WIDE;
> +    }
> +    if (flags & !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
> +        return H_PARAMETER; /* flag not supported yet */
> +    }
> +
> +    if (set) {
> +        gsr.flags |=3D GUEST_STATE_REQUEST_SET;
> +    }
> +    return map_and_getset_state(cpu, guest, vcpuid, &gsr);
> +}
> +
> +static target_ulong h_guest_set_state(PowerPCCPU *cpu,
> +                                      SpaprMachineState *spapr,
> +                                      target_ulong opcode,
> +                                      target_ulong *args)
> +{
> +    return h_guest_getset_state(cpu, spapr, args, true);
> +}
> +
> +static target_ulong h_guest_get_state(PowerPCCPU *cpu,
> +                                      SpaprMachineState *spapr,
> +                                      target_ulong opcode,
> +                                      target_ulong *args)
> +{
> +    return h_guest_getset_state(cpu, spapr, args, false);
> +}
> +
>  void spapr_register_nested_hv(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
> @@ -1284,6 +1548,8 @@ void spapr_register_nested_papr(void)
>      spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
>      spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
>      spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vc=
pu);
> +    spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state=
);
> +    spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state=
);
>  }
> =20
>  void spapr_unregister_nested_papr(void)
> @@ -1293,6 +1559,8 @@ void spapr_unregister_nested_papr(void)
>      spapr_unregister_hypercall(H_GUEST_CREATE);
>      spapr_unregister_hypercall(H_GUEST_DELETE);
>      spapr_unregister_hypercall(H_GUEST_CREATE_VCPU);
> +    spapr_unregister_hypercall(H_GUEST_SET_STATE);
> +    spapr_unregister_hypercall(H_GUEST_GET_STATE);
>  }
> =20
>  #else


