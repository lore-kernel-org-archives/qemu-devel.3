Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B54C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reuQ5-0007eT-Ir; Tue, 27 Feb 2024 05:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reuPm-0007Z0-NN; Tue, 27 Feb 2024 05:10:24 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reuPc-0000Ot-Pn; Tue, 27 Feb 2024 05:10:18 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e53f76898fso762159b3a.0; 
 Tue, 27 Feb 2024 02:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709028611; x=1709633411; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Io/jz9tVDBjrZy8QtHAqWdTSAkONnPaHHzmKN/lroG8=;
 b=Aaymi+vFSZtH/rarEXA0eMGKyPpouc198wMLuwQsOp7c3X3diz7dGQutYrJwlqdPek
 BPkEHwM7IMrBS9W8C/qXaCKI5OL3rS7MDO3dF6YoEQ8eBRiDUnw8A41uNv3xmBpulZDj
 nra2z6GGw9ynfxJ/AoV9X2OYhuzt7ccE6JdJToWVs9bqwQE3A5Mq3gsS5SGZ835pb0Oo
 YQQm2GiDTe91L2hD12R0UwvPccaRGexELvRC9zEBcuUKQSG4dcZQbHhM8NTPGBRYfk6z
 JwMTcfLfVp7xoR4RdFHBiM/EHNLzQhLYXtHhq+b0EHJdPl4icqtgwZsQGMPcaEVZsHyb
 vaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709028611; x=1709633411;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Io/jz9tVDBjrZy8QtHAqWdTSAkONnPaHHzmKN/lroG8=;
 b=xH/bE9OspnBOQ4fB5EI77MnRUtT5HUZQAM7Ll+BJAOVGJK0MUfEEEorlvWu0SRFN5x
 UR4ueNUeaIiK7GHfmVDH1T0j9e2E/oZtGmfXLL5ILH6DQWworxP5wPOQVZ0WlTb+SFHP
 26hW3K3vA+LtoGoirTvW+tSVpVpGhlWvRZgRky2pwFpbVXvtm14cUfxXlaQ7JyBDRZMz
 zFlhnu7zBZNXVgDHbUTKCY0HsK3Gt1v96DwLskh/Xs+2b0/BW8X+5Dk0l6jZ4THSOtmw
 jfyb2iV4QDKetZVTFj4z4UUjXV/FhljKvH/gfFUMcbDEJovB/5ycr3T4r/aoKbW2xF1A
 qkyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFw/ZxIdDdJoAnV9R5RDepOpaajp08iyzctoJhFcSxmqtACFL5Nh2Q+JP5vy4EkWtNQKgb1p4Hgz6Tg8Nkco4RMJgunKgBTPhxjXVGqS9EIN15+0GcNOCSoEQ=
X-Gm-Message-State: AOJu0Yx6iSxYF2RyNSHfQJnkSj2bqrNr/xk1wMSMrlGENoJ/ugGJNvVz
 tK+CxFsDliTzWnrQvFh2e7g6xaOuYURVGEQnbeCFSq9k79ez6n00
X-Google-Smtp-Source: AGHT+IFGDU/JQksMEV9+ydyu/Z/BT9lFamk3f9yIsyroYnVDteQo+Fx/1DmXWIUkOIg6ThMLk6H63g==
X-Received: by 2002:a05:6a00:1ca4:b0:6e3:b4a5:4b53 with SMTP id
 y36-20020a056a001ca400b006e3b4a54b53mr9345562pfw.24.1709028610889; 
 Tue, 27 Feb 2024 02:10:10 -0800 (PST)
Received: from localhost ([1.146.52.18]) by smtp.gmail.com with ESMTPSA id
 g21-20020a63dd55000000b005dc5129ba9dsm5437073pgj.72.2024.02.27.02.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 02:10:10 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 20:10:03 +1000
Message-Id: <CZFS2TVTOKU5.3ISRK1DE1O89R@wheely>
Cc: <clegoate@redhat.com>, <mikey@neuling.org>,
 <amachhiw@linux.vnet.ibm.com>, <vaibhav@linux.ibm.com>,
 <sbhat@linux.ibm.com>, <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 11/15] spapr: nested: Introduce
 H_GUEST_[GET|SET]_STATE hcalls.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-12-harshpb@linux.ibm.com>
In-Reply-To: <20240220083609.748325-12-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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
> Introduce the nested PAPR hcalls:
>     - H_GUEST_GET_STATE which is used to get state of a nested guest or
>       a guest VCPU. The value field for each element in the request is
>       ignored and on success, will be updated to reflect current state.

This is a bit hard to parse. The value fields are destinations for
values to be stored (from the point of view of the caller), which is
familiar to most get or read type APIs.

I don't think you need to say it's ignored. The value it contains is
ignored and overwritten, but the field itself is not actually ignored :)

Patch looks okay though.

>     - H_GUEST_SET_STATE which is used to modify the state of a guest or
>       a guest VCPU. On success, guest (or its VCPU) state shall be
>       updated as per the value field for the requested element(s).
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  include/hw/ppc/spapr.h        |   3 +
>  include/hw/ppc/spapr_nested.h |  23 +++
>  hw/ppc/spapr_nested.c         | 267 ++++++++++++++++++++++++++++++++++
>  3 files changed, 293 insertions(+)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 82b077bdd2..aabc32f268 100644
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
> index 492302a21d..1b7e55f12a 100644
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
>  #define GUEST_STATE_ELEMENT(i, sz, s, f, ptr, c) { \
>      .id =3D (i),                                     \
> @@ -312,6 +316,25 @@ typedef struct SpaprMachineStateNestedGuest {
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
> index faba27dd50..aba4b25da6 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -8,6 +8,7 @@
>  #include "hw/ppc/spapr_nested.h"
>  #include "mmu-book3s-v3.h"
>  #include "cpu-models.h"
> +#include "qemu/log.h"
> =20
>  void spapr_nested_init(SpaprMachineState *spapr)
>  {
> @@ -999,6 +1000,140 @@ void spapr_nested_gsb_init(void)
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
> @@ -1244,6 +1379,136 @@ static target_ulong h_guest_create_vcpu(PowerPCCP=
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
> @@ -1267,6 +1532,8 @@ void spapr_register_nested_papr(void)
>      spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
>      spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
>      spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vc=
pu);
> +    spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state=
);
> +    spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state=
);

Are these also supposed to to add unregister calls?

Thanks,
Nick


