Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08595C4452B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlls7-0000m3-3z; Mon, 20 Jul 2026 07:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wlls5-0000ld-5s
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:09:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wlls3-0003xp-3D
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:09:16 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAvS412277492
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 la5KGUh8THY+lus/4Vif97itBE75uAIMxsk0vtwJ6Sc=; b=QeHUnmqBoUnxRBnB
 5Zr1IrwORZbV8m5kdChEQF1sTyethXJ1DgjdEzkF5WmKjtl432MOCmPioAsM1ehQ
 8pdFX/hF6ueJ9Wo3yAb5zxgqLVEc1nVAbcnLieSZwpAEVroApgMG+H+fCEqawm8X
 H1GyTWCFRXFrTyECOJNWR9NwCyLzdpyy2c3aPmAHy8TPi/LPCW4ownndzgQNOgMY
 R5DsQ4Sx2UtFto01e96ZjZhDr0zqOtvrAiAvs2J5iePzNly3h4w0x09nccixmy1N
 T788AagI6tOHsMzSU6+wQdhnxDq8WkFf6h1dMoO2AKO3KgBj2+rkdyT0dY4wZhSW
 u+gMPQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0c14wm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:09:13 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-81e7a45afc1so39957987b3.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784545753; cv=none;
 d=google.com; s=arc-20260327;
 b=VntXZv1z1NXxJbE2cF2EIhu3Ou6lTJohJyfkfUH2KPPQ7uNa6JwlHpr70lEwhVG2oZ
 5RHouTDvwOpz/n0HJkW8FhYGEzmv0w98/8r+zDy4X73hBYSHajSkbELB5e+fOmXNmA+a
 AcYf8cVv4HK4N8sOFSNHL1ief2BORSJJjX+KgifErKFOXqGYxmvB98R55wH4LUnqnUiG
 Imk8t18YIEgGxQ2RMMx1EWc/7HTHKO1OVvBeHJtXUV6+Hr5Qw4ZKl2/oICtoEqqx8QXW
 wl1m6vYPuVHKSUgwPVKvw0TwjEFPYNj82m+8BV/J6L7vZNt2j67qXGs1cOiKfZXg7sYW
 XfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=la5KGUh8THY+lus/4Vif97itBE75uAIMxsk0vtwJ6Sc=;
 fh=aq3JdHdUxzp3JRJNZIDFL1iwewZiQpKoc0Oc2RYp9Yo=;
 b=s0eIISyVuFeK/6W1Ci96xoQk8EWyCfBVKrAKbOKgvI4/sgkShIkqI8Qu7eg/SoBa4i
 1frdCKHWewjv1aWnCRH6WfUpWAUdO8LiQtQhVRuKT8BYnCYX1M/egXl2UK94K7E+Pz5k
 xQ5z8fq4m8GSldlIsTroirarnegos2opIQMTThLaUfZTsPwqYHRByMu+SXoYtWAG654G
 0j2+B7MZ1Zs8kmGPuYb30BRk8ui537NqmlwVuojHH1rEGeQjRiSSAj5Pz1ZZ7+XoHM60
 jpLctkD4pUMQHj0jApFO0Gfrz4CDSENPU1k+p12INOAeG19G1O7NXbvO7/havPutUWJh
 E20Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784545753; x=1785150553; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=la5KGUh8THY+lus/4Vif97itBE75uAIMxsk0vtwJ6Sc=;
 b=CUWA+UTzCSlvbiU65YjTGqp6grYAcbYDk4wHMu0BQj0yB78aUAVBiuM8whIWwx4CqC
 qPrdgLM0v9R2nvTh2tsCezi2ij42hRCwwsudvq2b3fg9U0Zfsoqxp3DhnyPYpQ6aTA5P
 5Uk84RUn609R51slmBeG5CQkU2cW77pNymFBSoqnVA2ScSOBYLwKRL12gYjxL2xkySEO
 DBiztmi8IygPwc5V/jw1H2rO/fefYBHKFtE0U25BEkGJizOjAPlFWCyTpY/8Lmv3Eefy
 dDWgeNjIHkEHrzqQdYXjeu3HbWoCG+EXdvFZNccf5+Uzia+GguvIqtw/comGfiuOStKD
 jAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784545753; x=1785150553;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=la5KGUh8THY+lus/4Vif97itBE75uAIMxsk0vtwJ6Sc=;
 b=ozIBespFNSu2FEvPpFbiph16JFL3V6dAag6x1OYBUydD6ZPyVRDfs3OhgJyt7+iNho
 7IINvyskFgAGxDM3sWat0Az4cfyZC0X+j6A3rK7heDUoacPsbULVJfhN/BVYbhUaZekT
 S9MNFOWsz+OlI8xKPJULq6dIeA9sCd5VSfWU6Km/zoQjxGneoxKQr2b95y1FPzfhfJoU
 5BJY3d2wKgHRbOW2bYasJBqiE46ERq2sD/fXZK4pTNb3+qA15JJ1F0XH6mQdVGHCOe6e
 rKgrs2wHKbJiE+1fJSEvwYYmw2S2eoGQ9qTD+hdpdbOIMiAZapZAaaZjUHJf+BR3cefi
 vEtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHXAiMyqNwzi30QODBySy0P1Md9dRwTXWKW6kU3d1PLKBcz+vk6jfu0+Tsy1Or6/2ePBl2JCNLpNcc@nongnu.org
X-Gm-Message-State: AOJu0YzSPncaXqPNLHQXiePkSmf4DgykHuvzv1Xnmf+tqEoD0qrgweo4
 HVxh+vLrNv/Lx1nfsR9QCMfheaYWd+r+rZaqS6vng5gevTUHlE54h2vUsiYEzGxXSw26xYYV9eD
 8Z/yzTALWl+5GourAaoOygbACJQVYtGp6CY3TLmi961UrR1HLmS2KmytJ2FR4zvtn2yu6Jev04F
 1WdddwtRhz8Tam3XU0eFNSD5wMSCqwhA/1
X-Gm-Gg: AR+sD11Fczly4no3Yx9u3qTZsRonOHVL4Py1LHaZydLePdDKunn8XzGXmA1bOhJSTYF
 Ou0U+WyxvdB4L+4Z12+I9BftdcoydEuJda5cbdEJ8NmHFIBBkYlcyeLRkyAA2AmnyH25TllCV5r
 SL5YRZ7YS1TjKWt+r7J7RUI9cJwLMIqExS/kGAZN+1f1c3N1fSM+ApV1ZqLzk=
X-Received: by 2002:a05:690c:6604:b0:7ef:9eb0:a4e5 with SMTP id
 00721157ae682-81f20c4ff11mr823657b3.0.1784545752624; 
 Mon, 20 Jul 2026 04:09:12 -0700 (PDT)
X-Received: by 2002:a05:690c:6604:b0:7ef:9eb0:a4e5 with SMTP id
 00721157ae682-81f20c4ff11mr823537b3.0.1784545752240; Mon, 20 Jul 2026
 04:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-3-subrahmanya.lingappa@oss.qualcomm.com>
 <767b4e5e-7a24-4b5d-bc59-4a21006e9ed2@oss.qualcomm.com>
In-Reply-To: <767b4e5e-7a24-4b5d-bc59-4a21006e9ed2@oss.qualcomm.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:39:01 +0530
X-Gm-Features: AUfX_mxDHgIKvSVSLcIINefXrI4i8Oj3kld_5XKxrXZwtAsSu-M2904qhfV7RtM
Message-ID: <CAPxK-6fGvJkFtYDHAifRacP-Jwm1D7DZQsWuuaGGNp9S_f0Mpg@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] hw/misc: add RISC-V RPMI transport and Base
 support
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=HeYkiCE8 c=1 sm=1 tr=0 ts=6a5e01d9 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=V1jnuoLLAAAA:20 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=_IOB-gDGozFwuC063SEA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: Jkl2b1bCYciAxi6M0P9q3AhJsro66jNr
X-Proofpoint-ORIG-GUID: Jkl2b1bCYciAxi6M0P9q3AhJsro66jNr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyNCBTYWx0ZWRfXxYONgWdCeblo
 ihC32SSt1DWvOem6vC7mgMTDpRRUjOANwZZ0QmzW+isAAtotM7JT9XPDDLOvzS9mfxI3n4MbQ0O
 oZFhxAD7K+5+7QGEFY/ktOA7GXoVZfY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyNCBTYWx0ZWRfX9bkEoJDq+Vrp
 P7WMgZ19pR76Dvc+rXoBmsL1dTPeCVFIAAoUN0kGpKEaon6M0Hwaz89GDQHthBf87NviN/Q9Ecp
 fzneJIcCoBBpVejwJ7ppvaHZy++RL8HBLoIYi3h1/z/7dzA45D66Jkp4O3deBpg1YLIzW4kWyda
 IcBB2MHkSIzkYG4SXAwmjoEeINzqztYmGYAmu4vKmshqIBqZDYchDaFxe8BADNRXmmld+/XjP36
 fxY6IB2cS4P3zgjLtKI8UoKuF9O462Fy/GT9xbp41iAJrej5TzRNVQy+wQJZycCTLAR01K3ikfv
 WI2FbHH9+4LnsUPZJizm3f2cZpNS9nMKrLPUbf6LUCcW+wp7MQGP+RX2SU8nbd02fLXz6o2shGu
 l9u9X73TLlMahzPUEIAz72jhchwpvrmFkPs+PDfp0HS1CaFAzMm9Pfcid+yb69owSvb6ryZiM1e
 tHJSucjRFxSCuFcitSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200124
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 17, 2026 at 6:24=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Hi Subbu,
>
> On 7/14/2026 4:56 AM, Subrahmanya Lingappa wrote:
> > RPMI (RISC-V Platform Management Interface) is the RISC-V non-ISA
> > platform management specification. It defines a shared-memory transport=
,
> > message protocol, and service groups for platform management.
> >
> > Add the QEMU transport backend and Base service plumbing for virt using
> > librpmi.
> >
> > This implementation targets the RISC-V Platform Management Interface
> > (RPMI) Specification v1.0 Ratified:
> >
> > https://github.com/riscv-non-isa/riscv-rpmi/releases/download/v1.0/risc=
v-rpmi.pdf
> >
> > The librpmi backend is maintained at:
> >
> > https://github.com/riscv-software-src/librpmi
> >
> > Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.=
com>
> > ---
> >   MAINTAINERS                   |   2 +
> >   hw/misc/Kconfig               |   4 +
> >   hw/misc/meson.build           |   3 +
> >   hw/misc/riscv_rpmi.c          | 476 +++++++++++++++++++++++++++++++++=
+
> >   hw/misc/riscv_rpmi_internal.h |  24 ++
> >   include/hw/misc/riscv_rpmi.h  |  90 +++++++
> >   6 files changed, 599 insertions(+)
> >   create mode 100644 hw/misc/riscv_rpmi.c
> >   create mode 100644 hw/misc/riscv_rpmi_internal.h
> >   create mode 100644 include/hw/misc/riscv_rpmi.h
> >
>
> [ ... ]
>
> > +
> > +static void riscv_rpmi_class_init(ObjectClass *klass, const void *data=
)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->realize =3D riscv_rpmi_realize;
> > +    dc->unrealize =3D riscv_rpmi_unrealize;
> > +    dc->vmsd =3D &riscv_rpmi_vmstate;
> > +    device_class_set_legacy_reset(dc, riscv_rpmi_reset);
>
>
> This is something that I noticed yesterday with another work and I didn't=
 point to
> you earlier - we shouldn't use this legacy API.  In include/hw/core/qdev.=
h:
>
>
>   * device_class_set_legacy_reset(): set the DeviceClass::reset method
>   * @dc: The device class
>   * @dev_reset: the reset function
>   *
>   * This function sets the DeviceClass::reset method. This is widely
>   * used in existing code, but new code should prefer to use the
>   * Resettable API as documented in docs/devel/reset.rst.
>
>
> Unless this device has an exclusive reset procedure you can do like riscv=
-iommu-sys
> does:
>
>
>      ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>
>      rc->phases.hold =3D riscv_iommu_sys_reset_hold;
>
>
> In this case you would do
>
>
>      rc->phases.hold =3D   riscv_rpmi_reset
>
>
> You can ignore the extra ResetType argument in case you don't need it.
>
>
> The rest of the code LGTM.  Thanks,
> Daniel
>
  Fixed in v4. I switched the RPMI device reset handling to the Resettable
  API instead of device_class_set_legacy_reset().

Thanks,
subbu

>
>
>
>
>
> > +    device_class_set_props(dc, riscv_rpmi_properties);
> > +}
> > +
> > +static const TypeInfo riscv_rpmi_info =3D {
> > +    .name          =3D TYPE_RISCV_RPMI,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(RiscvRpmiState),
> > +    .instance_init =3D riscv_rpmi_init,
> > +    .instance_finalize =3D riscv_rpmi_finalize,
> > +    .class_init    =3D riscv_rpmi_class_init,
> > +};
> > +
> > +static void riscv_rpmi_register_types(void)
> > +{
> > +    type_register_static(&riscv_rpmi_info);
> > +}
> > +
> > +type_init(riscv_rpmi_register_types)
> > +
> > +DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **err=
p)
> > +{
> > +    DeviceState *dev;
> > +    RiscvRpmiState *s;
> > +
> > +    if (!cfg) {
> > +        error_setg(errp, "missing RPMI configuration");
> > +        return NULL;
> > +    }
> > +
> > +    dev =3D qdev_new(TYPE_RISCV_RPMI);
> > +    qdev_prop_set_uint64(dev, "shmem-base", cfg->shmem_base);
> > +    qdev_prop_set_uint64(dev, "shmem-size", cfg->shmem_size);
> > +    qdev_prop_set_uint32(dev, "a2p-req-size", cfg->a2p_req_size);
> > +    qdev_prop_set_uint32(dev, "p2a-req-size", cfg->p2a_req_size);
> > +
> > +    s =3D RISCV_RPMI(dev);
> > +    riscv_rpmi_configure_base(s, cfg);
> > +
> > +    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp)) {
> > +        return NULL;
> > +    }
> > +
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, cfg->doorbell_base);
> > +    return dev;
> > +}
> > diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_interna=
l.h
> > new file mode 100644
> > index 0000000000..447c0acb55
> > --- /dev/null
> > +++ b/hw/misc/riscv_rpmi_internal.h
> > @@ -0,0 +1,24 @@
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * RISC-V RPMI internal service helpers.
> > + *
> > + * Copyright (c) 2026 Qualcomm Technologies, Inc.
> > + * Author:
> > + *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> > + */
> > +
> > +#ifndef HW_MISC_RISCV_RPMI_INTERNAL_H
> > +#define HW_MISC_RISCV_RPMI_INTERNAL_H
> > +
> > +#include "qapi/error.h"
> > +#include "hw/misc/riscv_rpmi.h"
> > +#include "librpmi.h"
> > +
> > +#define RPMI_PLAT_INFO "QEMU RISC-V RPMI"
> > +
> > +extern const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops;
> > +bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
> > +                                RiscvRpmiServiceKind kind);
> > +
> > +#endif
> > diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.=
h
> > new file mode 100644
> > index 0000000000..cb2658e57e
> > --- /dev/null
> > +++ b/include/hw/misc/riscv_rpmi.h
> > @@ -0,0 +1,90 @@
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * RISC-V RPMI definitions shared by RPMI transport and FDT helpers.
> > + *
> > + * Copyright (c) 2026 Qualcomm Technologies, Inc.
> > + * Author:
> > + *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> > + */
> > +
> > +#ifndef HW_MISC_RISCV_RPMI_H
> > +#define HW_MISC_RISCV_RPMI_H
> > +
> > +#include "exec/hwaddr.h"
> > +#include "hw/core/sysbus.h"
> > +#include "qom/object.h"
> > +#include "qemu/notify.h"
> > +
> > +#define RPMI_QUEUE_SLOT_SIZE 64
> > +#define RPMI_DBREG_SIZE      0x1000
> > +
> > +#define RPMI_ALL_NUM_QUEUES 4
> > +#define RPMI_A2P_NUM_QUEUES 2
> > +#define RPMI_ALL_NUM_REGS   (RPMI_ALL_NUM_QUEUES + 1)
> > +#define RPMI_A2P_NUM_REGS   (RPMI_A2P_NUM_QUEUES + 1)
> > +
> > +#define VIRT_RPMI_A2P_REQ_SIZE (16 * RPMI_QUEUE_SLOT_SIZE)
> > +#define VIRT_RPMI_P2A_REQ_SIZE 0
> > +
> > +
> > +#define TYPE_RISCV_RPMI "riscv-rpmi"
> > +OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
> > +
> > +struct rpmi_context;
> > +struct rpmi_service_group;
> > +struct rpmi_shmem;
> > +struct rpmi_transport;
> > +
> > +typedef enum RiscvRpmiServiceKind {
> > +    RISCV_RPMI_SERVICE_INVALID =3D 0,
> > +} RiscvRpmiServiceKind;
> > +
> > +typedef struct RiscvRpmiServiceConfig {
> > +    RiscvRpmiServiceKind kind;
> > +    const char *node_name;
> > +    const char *compatible;
> > +    uint32_t service_group;
> > +    bool has_mpxy_channel;
> > +    uint32_t mpxy_channel;
> > +} RiscvRpmiServiceConfig;
> > +
> > +typedef struct RiscvRpmiConfig {
> > +    hwaddr doorbell_base;
> > +    hwaddr shmem_base;
> > +    hwaddr shmem_size;
> > +    uint32_t a2p_req_size;
> > +    uint32_t p2a_req_size;
> > +    const char *platform_info;
> > +
> > +    const uint32_t *hart_ids;
> > +    uint32_t hart_count;
> > +    const RiscvRpmiServiceConfig *services;
> > +    uint32_t service_count;
> > +} RiscvRpmiConfig;
> > +
> > +struct RiscvRpmiState {
> > +    SysBusDevice parent_obj;
> > +
> > +    MemoryRegion mmio;
> > +    MemoryRegion shmem;
> > +    uint64_t shmem_base;
> > +    uint64_t shmem_size;
> > +    uint32_t a2p_req_size;
> > +    uint32_t p2a_req_size;
> > +    char *platform_info;
> > +
> > +    uint32_t *hart_ids;
> > +    uint32_t hart_count;
> > +    const RiscvRpmiServiceConfig *services;
> > +    uint32_t service_count;
> > +    uint32_t doorbell;
> > +    struct rpmi_shmem *rpmi_shmem;
> > +    struct rpmi_transport *transport;
> > +    struct rpmi_context *context;
> > +    bool has_shmem;
> > +};
> > +
> > +DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **err=
p);
> > +
> > +#endif
>

