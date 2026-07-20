Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D5CC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlluV-0001ZG-9H; Mon, 20 Jul 2026 07:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wlluT-0001YD-Q3
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:11:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wlluR-0004Pq-Kj
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:11:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAwpsi2544961
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +ZD0mNkZRnAdKYskEXd/j75A/3bJuhn4Cn/LfhLaDV8=; b=bo7ZmcQaD+NALePa
 +0UIgo9fac6Egxcj/HRgSwMw1MHjjDhxyCdxdyhTcVywakbq0iaNRK50IqYsPadZ
 xnmT0LwgAkVL5u1I+R5BAXhrwRijvIOEDksI42DkYyhsjTDIFseJ8uN3MUUlboBD
 eKC7ABqc1kYz0jLhOMpDLV7N5yG89iPnesNwP/0zbczlz4kYcQG9JSTFvj2fSvfB
 o8u8ruQbjLenrhr8YTJZ7vuWv04i6BB4AwHr3IkhTvzvBVHeFHPdTdor++6DNufx
 5wztJ8NSVaPlI2yUe61DeS1jX+LzWy5hN79kx3GKATt1+bwT/KQ3ZU5o5CBdcEhJ
 /Re/9w==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdch0hr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:11:41 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-66584abb9d3so1273732d50.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:11:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784545901; cv=none;
 d=google.com; s=arc-20260327;
 b=RjGu08lrj0UhC0KXgHbP2rXn9lONATNie6t1PNeY5ZuahXcf+sIQIPovyU1QsH9rs7
 EvL0Ruz1asmWmAp9a3/kzWzqycvMlWv6AaqndEHV3o2eRjVWyWAbW9WFF+86HfDbTCkt
 F2RXtUMvyKejiiLDUegbq47qG7gQv44taNsmViImpihpscsTFEj7hqw5a8/RD4HOmkhA
 uGlLPmF1LSpRhK88ylymErKxSWsDhusjiChXhvJsoJwwE7VxYIRgz4ay71HBOpU6U/OD
 d+SEuA+8HVah82QzIwDNwluzbezYj8W73qXUfaJuVrhNXIWauV7l/cQwqgG8rFhwM+wm
 OyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+ZD0mNkZRnAdKYskEXd/j75A/3bJuhn4Cn/LfhLaDV8=;
 fh=95NVxLQDBufeiKWVtKu26tdE62oUdIf31EvbHj4AebY=;
 b=gPgpsbKl/i4JBI+VOtwBKOxvyVlkv0ecYDiu5FrRHo0M6BcxRWmHbByupRxSIwUKFP
 nRpwx/7ytU8asqKshLvt9bMRM5SXZR3utIIktnvb5Na8NPmbxMivU06tTmUBK//IXRSR
 zF7ffv/bsIpUUrqd4RE4w6AOwX+vG68AruUImoELdcybKAHwu6SEtmvUefmPB+ZJIjoe
 1a3aROAeSKLyOEaakL+F/taOacouEt317sU09uBZg1rofuzt/C6oZkK6tk/V0p5t+Rdr
 ImVnTF58hvwigSeQAQgPsSUt8+Y+Hj0tY1mypsTYY7vBxuyhclPrTQXP8e7LIXhycX4L
 Ck6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784545901; x=1785150701; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+ZD0mNkZRnAdKYskEXd/j75A/3bJuhn4Cn/LfhLaDV8=;
 b=ZBlLjv3tuOLYnMoM23uBiU2yi19gaE0LypQYXMU6KJklAVCCMaqT67rW8P0clb7oZN
 p+zQ9d7xGAMnxpRkAzAN426nXnB39o3Yc6GIqkdpwIX6xOxX5bMtdWpzgE8/zt3CLLUS
 0TQjz/Egq1AkfTvz9lK51Ac6PTrAFKn36B3UWNspojcaU/CA+Wm7Qk8a779/JMHNE1Em
 z0LXMtpCSR2QTZULQx4GGyWe+TQatr1yUWgMrsxjko+TdbqSirH5lYvYKjcCBh8vgoKa
 oxL6wFvuofX04igH1UoZpHKtiGSTCpwS8x1mmk9lN64aUb2JOJTJNGjgOkCsjP82miFh
 +M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784545901; x=1785150701;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+ZD0mNkZRnAdKYskEXd/j75A/3bJuhn4Cn/LfhLaDV8=;
 b=qgcEfPJ7nsicTvNrpfzc9SJrfP7CL4a6xsEL9+dLLw1U9p2SDLjrHe/Tp9DPcxif3n
 3oBNBXrHmsmFa92DAeJcyAqfCznWttFJXp6kbpL9MqnKWs5T+ux/TjBE5XAr5Zhb33Up
 HymDW5qYcE5A7RU2yhlr0fRGZQyF2MX+iWW6/uJ3uoJWDEXxEFAbbHakvMZ1P76YDFY3
 FJpSZz5QmVx9BaFqykuFlRKZmKt15zzbGm1wTWM/4NVCaN5QSmKNJaTHvtn0u6Woo/ED
 I2NjueUfJ3QAa272yXem04/hNbWeeBJutAWZr/yhlA4d8m3OONjsoflusJq/yS4ml/8d
 UXwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrF4EHwfHU7FMdu0/q18Vw9UAYUBi2nWbOYqGRQVgDaQGmPvIAAGto908fdDWUiD3J/eKf4X7ofSxlF@nongnu.org
X-Gm-Message-State: AOJu0YzB5GDrBLrctP5ul2m6OK4M+1wrUiCSDk1N6e6FRGERCHAmenrJ
 +r9DmPnXYmK9pSTxkvJAsS4jnN5UoqMOjNc151pNB/wERo4v5pGZ8GgkktSjr1AM4JdQkS6JJ5Q
 tPevGAnW0xzc2g82MKQBmQOZeyBNz1ctKD4SLT07Z39EyqHgoNcIBf8rcYoRsfblo9aZA7C8URp
 Q8pEEKUQJUY/XeXz52bQA9sAksYcgHkztJ
X-Gm-Gg: AR+sD10MKbdjpZfeDqcttR+ikSMqSDorzO51bWXIVHiQDjppewPaNMSbkklmPSZa22+
 dF1upbcaukMcZP6Kv3ezrpx/8rDaim2KydYWWcZDTimncPM8YGx38XauIKUR4bFqEoqmLQcBvyl
 WGE1yLLpg0jUXSojTVTvkRFhDRElnd4l2KX3kIS27K7+xvRedSY6x6afH0gfU=
X-Received: by 2002:a05:690c:9d:b0:81d:45a:977b with SMTP id
 00721157ae682-81f20f65da9mr589167b3.4.1784545900930; 
 Mon, 20 Jul 2026 04:11:40 -0700 (PDT)
X-Received: by 2002:a05:690c:9d:b0:81d:45a:977b with SMTP id
 00721157ae682-81f20f65da9mr589087b3.4.1784545900494; Mon, 20 Jul 2026
 04:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-5-subrahmanya.lingappa@oss.qualcomm.com>
 <f767ff53-911c-4f9b-923c-09d09f0e107a@oss.qualcomm.com>
In-Reply-To: <f767ff53-911c-4f9b-923c-09d09f0e107a@oss.qualcomm.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:41:27 +0530
X-Gm-Features: AUfX_myYWz_19lQujjBXQKydN_ctH0sZoGR-Ax-6OSgz8Tp3E_MRp7m3lv1UAPo
Message-ID: <CAPxK-6f9UG8C8avzthiRc3=hj=K9_=wDqEUa1t9KxVND7Gi93w@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] hw/riscv/virt: add opt-in RPMI base support
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: UsvLjhyxnO-TutpHZ0NyLI4XlMty7HDr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyNSBTYWx0ZWRfX2Owjr1vkUUi4
 mGAkI7PBhJrDllGuudcktFcohmbDuL0SP3eiWXMEwugOLNgy7tkrL3PQ/EjfHxBHifshfxsboTF
 Y5JaALNk+Fz49OeC1HV/VIy02/XSdO0gp41RIuTUv3B++0/x0/+4TQnboQKogpJkV176VUTQneU
 qx3wV/EoBZU43PDz/B12sWl6wMk+/GsL7hqUgkuDnOj+n7U5Q6ZN9EieJYde+ECuzu9z/4mig+R
 IxZchfI7FOC5yexWdyeC8iPYCKsKshQvZ8mq+N73HnbbD9EkhDidMFVU4MYi6vdFMNPEfMHOeFq
 4CRQf1gpHsOtzX1yFr5lLr3OeWKGFENjBcEYdyJD+Mc7uTs2LzSIJ768ctYo4VHg9MR0c/CaDQ0
 cPnM1vIW5NsGDL8F/OS5qMsOcpuXhLmMr5pif4A3AjXobOWrEOLFT621nkd3acqrgCoj8eg2Qzb
 Whm6ilo36EB9IvdK2VQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyNSBTYWx0ZWRfXwz8iS3bFsJ0O
 DYpjySKZpxmEUsXJfaPpiXhoNrkh98aOozhregtzsn6hM6Zhm21vetXJnaIRCVUF0dSW7WCb/HK
 l3cySi1Dm9u0EbY+5ifuBKJ8+vX3xZY=
X-Proofpoint-GUID: UsvLjhyxnO-TutpHZ0NyLI4XlMty7HDr
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5e026e cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=XkPAdn7Tc9k1gLx8h8AA:9
 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200125
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel,

On Fri, Jul 17, 2026 at 6:47=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 7/14/2026 4:56 AM, Subrahmanya Lingappa wrote:
> > Add the virt machine rpmi=3Don/off option and wire the initial RPMI Bas=
e
> > transport into machine realization.
> >
> > The option remains disabled by default and requires TCG plus librpmi.
> > Invalid accelerator/build combinations fail during machine
> > initialization. When enabled, virt allocates the RPMI shared-memory
> > transport, creates the RPMI device, configures Base service metadata,
> > and emits the corresponding device-tree nodes for firmware discovery.
> >
> > Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.=
com>
> > ---
> >   hw/riscv/Kconfig             |  1 +
> >   hw/riscv/virt.c              | 96 +++++++++++++++++++++++++++++++++++=
+
> >   include/hw/misc/riscv_rpmi.h | 10 ++++
> >   include/hw/riscv/virt.h      |  3 ++
> >   4 files changed, 110 insertions(+)
> >
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index 54e41a6afc..4e25be113a 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -49,6 +49,7 @@ config RISCV_VIRT
> >       imply VIRTIO_VGA
> >       imply TEST_DEVICES
> >       imply TPM_TIS_SYSBUS
> > +    imply RISCV_RPMI
> >       select DEVICE_TREE
> >       select RISCV_NUMA
> >       select GOLDFISH_RTC
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index 33775a61fd..e52ccfae1f 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -45,6 +45,8 @@
> >   #include "hw/intc/riscv_aplic.h"
> >   #include "hw/intc/sifive_plic.h"
> >   #include "hw/misc/sifive_test.h"
> > +#include "hw/misc/riscv_rpmi.h"
> > +#include "hw/riscv/rpmi-fdt.h"
> >   #include "hw/core/platform-bus.h"
> >   #include "chardev/char.h"
> >   #include "system/device_tree.h"
> > @@ -97,6 +99,8 @@ static const MemMapEntry virt_memmap[] =3D {
> >       [VIRT_UART0] =3D        { 0x10000000,         0x100 },
> >       [VIRT_VIRTIO] =3D       { 0x10001000,        0x1000 },
> >       [VIRT_FW_CFG] =3D       { 0x10100000,          0x18 },
> > +    [VIRT_RPMI_SHMEM] =3D   { 0x10200000,       0x20000 },
> > +    [VIRT_RPMI_DOORBELL] =3D { 0x10230000,        0x1000 },
> >       [VIRT_FLASH] =3D        { 0x20000000,     0x4000000 },
> >       [VIRT_IMSIC_M] =3D      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
> >       [VIRT_IMSIC_S] =3D      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> > @@ -1002,6 +1006,40 @@ static void create_fdt_iommu(RISCVVirtState *s, =
uint16_t bdf)
> >       s->pci_iommu_bdf =3D bdf;
> >   }
> >
> > +
> > +static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
> > +                                        const uint32_t *hart_ids,
> > +                                        uint32_t hart_count)
> > +{
> > +    return (RiscvRpmiConfig) {
> > +        .doorbell_base =3D s->memmap[VIRT_RPMI_DOORBELL].base,
> > +        .shmem_base =3D s->memmap[VIRT_RPMI_SHMEM].base,
> > +        .shmem_size =3D s->memmap[VIRT_RPMI_SHMEM].size,
> > +        .a2p_req_size =3D VIRT_RPMI_A2P_REQ_SIZE,
> > +        .p2a_req_size =3D VIRT_RPMI_P2A_REQ_SIZE,
> > +        .platform_info =3D "QEMU RISC-V virt RPMI",
> > +        .hart_ids =3D hart_ids,
> > +        .hart_count =3D hart_count,
> > +    };
> > +}
> > +
> > +static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
> > +                            uint32_t msi_phandle)
> > +{
> > +    RiscvRpmiConfig rpmi_cfg =3D virt_rpmi_config(s, NULL, 0);
> > +    uint32_t rpmi_mbox_handle;
> > +    RiscvRpmiFdtMboxConfig cfg =3D {
> > +        .shmem_base =3D rpmi_cfg.shmem_base,
> > +        .doorbell_base =3D rpmi_cfg.doorbell_base,
> > +        .a2p_req_size =3D rpmi_cfg.a2p_req_size,
> > +        .p2a_req_size =3D rpmi_cfg.p2a_req_size,
> > +        .doorbell_size =3D s->memmap[VIRT_RPMI_DOORBELL].size,
> > +    };
> > +
> > +    riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,
> > +                            &rpmi_mbox_handle);
> > +}
> > +
> >   static void finalize_fdt(RISCVVirtState *s)
> >   {
> >       uint32_t phandle =3D 1, irq_mmio_phandle =3D 1, msi_pcie_phandle =
=3D 1;
> > @@ -1021,6 +1059,10 @@ static void finalize_fdt(RISCVVirtState *s)
> >       create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
> >                       iommu_sys_phandle);
> >
> > +    if (s->have_rpmi) {
> > +        create_fdt_rpmi(s, &phandle, msi_pcie_phandle);
> > +    }
> > +
> >       create_fdt_reset(s, &phandle);
> >
> >       create_fdt_uart(s, irq_mmio_phandle);
> > @@ -1410,6 +1452,18 @@ static void virt_machine_init(MachineState *mach=
ine)
> >           exit(1);
> >       }
> >
> > +
> > +    if (s->have_rpmi) {
> > +#ifndef CONFIG_LIBRPMI
> > +        error_report("RISC-V RPMI support is not compiled in");
> > +        exit(1);
> > +#else
> > +        if (kvm_enabled()) {
> > +            error_report("RISC-V RPMI support is not available with KV=
M");
> > +            exit(1);
> > +        }
> > +#endif
> > +    }
> >       /* Initialize sockets */
> >       mmio_irqchip =3D virtio_irqchip =3D pcie_irqchip =3D NULL;
> >       for (i =3D 0; i < socket_count; i++) {
> > @@ -1552,6 +1606,25 @@ static void virt_machine_init(MachineState *mach=
ine)
> >       /* SiFive Test MMIO device */
> >       sifive_test_create(s->memmap[VIRT_TEST].base);
> >
> > +    if (s->have_rpmi) {
> > +        MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> > +        const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_i=
ds(machine);
> > +        g_autofree uint32_t *rpmi_hart_ids =3D
> > +            g_new0(uint32_t, machine->smp.cpus);
> > +        RiscvRpmiConfig rpmi_cfg;
> > +        Error *local_err =3D NULL;
> > +
> > +        for (i =3D 0; i < machine->smp.cpus; i++) {
> > +            rpmi_hart_ids[i] =3D possible_cpus->cpus[i].arch_id;
> > +        }
> > +
> > +        rpmi_cfg =3D virt_rpmi_config(s, rpmi_hart_ids, machine->smp.c=
pus);
> > +        if (!riscv_rpmi_create(&rpmi_cfg, &local_err)) {
> > +            error_report_err(local_err);
> > +            exit(1);
> > +        }
> > +    }
> > +
> >       /* VirtIO MMIO devices */
> >       for (i =3D 0; i < VIRTIO_COUNT; i++) {
> >           sysbus_create_simple("virtio-mmio",
> > @@ -1636,6 +1709,7 @@ static void virt_machine_instance_init(Object *ob=
j)
> >
> >       s->oem_id =3D g_strndup(ACPI_BUILD_APPNAME6, 6);
> >       s->oem_table_id =3D g_strndup(ACPI_BUILD_APPNAME8, 8);
> > +    s->have_rpmi =3D false;
> >       s->acpi =3D ON_OFF_AUTO_AUTO;
> >       s->iommu_sys =3D ON_OFF_AUTO_AUTO;
> >   }
> > @@ -1710,6 +1784,21 @@ static void virt_set_aclint(Object *obj, bool va=
lue, Error **errp)
> >       s->have_aclint =3D value;
> >   }
> >
> > +
> > +static bool virt_get_rpmi(Object *obj, Error **errp)
> > +{
> > +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> > +
> > +    return s->have_rpmi;
> > +}
> > +
> > +static void virt_set_rpmi(Object *obj, bool value, Error **errp)
> > +{
> > +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> > +
> > +    s->have_rpmi =3D value;
> > +}
> > +
> >   bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
> >   {
> >       return s->iommu_sys =3D=3D ON_OFF_AUTO_ON;
> > @@ -1831,6 +1920,13 @@ static void virt_machine_class_init(ObjectClass =
*oc, const void *data)
> >                                             "enable/disable emulating "
> >                                             "ACLINT devices");
> >
> > +
> > +    object_class_property_add_bool(oc, "rpmi", virt_get_rpmi,
> > +                                   virt_set_rpmi);
> > +    object_class_property_set_description(oc, "rpmi",
> > +                                          "Set on/off to enable/disabl=
e "
> > +                                          "RISC-V RPMI devices");
> > +
> >       object_class_property_add_str(oc, "aia", virt_get_aia,
> >                                     virt_set_aia);
> >       object_class_property_set_description(oc, "aia",
> > diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.=
h
> > index cb2658e57e..b5d8a32f9b 100644
> > --- a/include/hw/misc/riscv_rpmi.h
> > +++ b/include/hw/misc/riscv_rpmi.h
> > @@ -85,6 +85,16 @@ struct RiscvRpmiState {
> >       bool has_shmem;
> >   };
> >
> > +#ifdef CONFIG_LIBRPMI
> >   DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **er=
rp);
> > +#else
> > +static inline DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cf=
g,
> > +                                             Error **errp)
> > +{
> > +    (void)cfg;
> > +    (void)errp;
> > +    return NULL;
> > +}
>
> I think you can do:
>
> static inline DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg G=
_GNUC_UNUSED,
>                                               Error **errp G_GNUC_UNUSED)
> {
>      return NULL;
> }
>
> Instead of using the args as void to not get warnings.
>
>
> Everything else LGTM.  Thanks,
> Daniel
>
  Fixed in v4. I replaced the explicit unused-parameter casts in the
  no-librpmi inline stub with G_GNUC_UNUSED.

Thanks,
Subbu

>
> > +#endif
> >
> >   #endif
> > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > index 18a2a323a3..f7c48613bf 100644
> > --- a/include/hw/riscv/virt.h
> > +++ b/include/hw/riscv/virt.h
> > @@ -55,6 +55,7 @@ struct RISCVVirtState {
> >
> >       int fdt_size;
> >       bool have_aclint;
> > +    bool have_rpmi;
> >       RISCVVirtAIAType aia_type;
> >       int aia_guests;
> >       char *oem_id;
> > @@ -79,6 +80,8 @@ enum {
> >       VIRT_UART0,
> >       VIRT_VIRTIO,
> >       VIRT_FW_CFG,
> > +    VIRT_RPMI_SHMEM,
> > +    VIRT_RPMI_DOORBELL,
> >       VIRT_IMSIC_M,
> >       VIRT_IMSIC_S,
> >       VIRT_FLASH,
>

