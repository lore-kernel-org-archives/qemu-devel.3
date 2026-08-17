Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BD8C5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuPn-0007Xu-MO; Mon, 17 Aug 2026 06:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1wvuPj-0007XR-HO
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:17:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1wvuPg-000651-6J
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:17:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9ddej1931805
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=3tVk7u8NrARFmqAmxU/6AXzHLjkbKWtLp4wJNSI8bd0=; b=n0
 8nXnPm2/YCxv/XRWJpvtW4OepG8EC7n5+HJNAxVVGgV2bX9h7MbC2fuuCnUpE0Zt
 LHG7iKY5Q2hMoipHNmgZS5OPPXG5jqgN83LGAaKiK2k3bEHaWZ9e0DK6T1PjthZU
 uELHY8BBKMGIVg2sfLDJLz8ZwXfLC5X++mdl8Jozv9W+vtOAyJBeYf2b+5NgDr4A
 OQD4kIt7d7d26OkKs/1NPJSQMqYBMSKjjJG+Fm6w+ciCR0zs1LwupTju3bFXE6Te
 jNDrZwRWnaGYqB2pIHmwnsVoKExnqbzJmYHH8xwfcCYaksWBvt+asV7PQfi1X8Fl
 xy59MneXkP+esQGNiUXg==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3txy9bqj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:17:49 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66c70cfe719so5007193d50.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786961868; cv=none;
 d=google.com; s=arc-20260327;
 b=lMhVaIAs6A3aNlI39exlbZJycHRpr2ttNv1nZBaAm5pZaWGQ7TWrv/FaxdVwpTB5mK
 NqJSK+GfLhqSEshWkRDeoagzHUpiPsHvnutU9Yd2CQ2ECuNNp4iuQB+RoSvS4k4W1QmS
 j0DHyxjlg9zgjtBDLlySXdhQWvA2vUqsCv+ilz+3PrDVdvoOZ4ghwah85oWsUmWpdlU6
 KILcTUFLvfPuT1sK+S1fN2DVr61JYgIIcGumrLVJuzTugcsWbE8IHhuYkkvk27776yI/
 YwkthxOgM7e0XFtQ8IYoqte+roXkRWc/uPERNnscTmhc7nNFJVNsMOk1p06OqcHvpEmM
 sdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=3tVk7u8NrARFmqAmxU/6AXzHLjkbKWtLp4wJNSI8bd0=;
 fh=/lhV1M1fQ+XcAHWl7F3Frol+OuCyeE9wz/jhza5qa40=;
 b=nywpQm/OlIbwkwBp0uvBeJRmYDmr5fyIhdyECClXyjNhkan2+hqjJJ5LqYgpC/RAWp
 ruoDGVjwjo4+yK2ZPF3+V+qwa/NIV/laxqDf5jp6b7ftwr1PpqGvs4RBaN2DVXZyu4yP
 jgPst0U1j+fiwvR/997C7RSc4HurqmqxJm7Xg2Orjbsli+2bIYNmaAm9qF1aqdwcSXpf
 NOkA51YoSs78IeiPXLleSp9GiVlpBq7Jd4fFvKsdsFJw2uOExZ132IT2ESbUjfHn7Y8h
 dufn8LdsGp9G0RriqysLQRFJSAOiC/Ekn96ek5seimFHQ64fDvnHsLhIFXpUEu/SlcNj
 J/Yg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786961868; x=1787566668; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3tVk7u8NrARFmqAmxU/6AXzHLjkbKWtLp4wJNSI8bd0=;
 b=LxyybLinJcell27RLAMHCnkPSU8firKoBIpnoCRzA7oqGslgHDh93DpOXj82j47Xu+
 hfAbaBsvK46CIHvvz900uqLkI2g24+F/fdU3df0K5JK3WY5Ufy38p/7BNGU6Gw+QPMIp
 Y2uUa/bvHol6p0UGid3bA0VuO0e1qF4M4yFkx+L9HiF6dpvsouBoev5XUun7DEIfEkjZ
 84X5nWLKQeP8gICW0dSH+hOJF3BKaLVi5UJr8u5sPvlk+5Zg38h5wHIbLE++evb5ggtx
 kyoNmzqpdPODfxYN9ooY4Zi6zdRuYCzENOg0yDxMjYriSqc+3Yd1UYqn+OOBBFu3CC+y
 TaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786961868; x=1787566668;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3tVk7u8NrARFmqAmxU/6AXzHLjkbKWtLp4wJNSI8bd0=;
 b=eAaIIbHB4jLL7CRZjC+d9k0KcqgwgQPQBC8CYdwvfBIjf7RUAoN+59trtKjy+1c94Z
 UMQLLdvCXoFnDtsQGygINBwOHrm862QrZ2f63nQKAaTeK7cDqYecO4G+HuhN32aGuzYJ
 ZRUWiZlhdNJrXckixOa1dM+t/HC0e/T5/jansn6jPaB/Un5rXPao5qNB8ZMd72nzcCMC
 nqBYSgWynC8tYbQ5U7GfxevYtynOjFJLAT6jRti7bJV9TWzI1bQ5twH7r1NEpgrC+843
 FoxkdnHpANTbrBeNh+IHwhCrphnuUXv/r0giYqTXZoEjy47MI1e7hQ+twJI6t7QNKQgr
 BGqg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMmelavBhBpClI2TxmwN+ZzBVsLgHo+3ZcMeNh/62ZGi6ISOdS2htmll8L22NTVIljBJRHLIu5DIHk@nongnu.org
X-Gm-Message-State: AOJu0YxSG2GALgeqHjyJ+2vOrAh7u5DQG/oPYYIU4pKQqZKrZKcr6C15
 r9ZurO+6rgMOU7XL8O+o6WWekGDiLGPqb+ObYPiPrWIw6J2GaLtn5FIoxuPYWVAKZ6UPdRRUza/
 FGSUk798FNdL/zvbvw2GUS4M4toA1fB1+mhUPFcDmpdYEE/UKF0/c2vcxc8TZp+exLY5YCWldLM
 FfPrC4eUpbBV6apcQrkDh590ttfjYUnhhz
X-Gm-Gg: AR+sD11gJhOyadiTQZX3xUGIHkXt7PdfZi3sJZk8aopaxmPb3Kd/FSOwuQx6OfPKKXf
 ZpVCNWhH7oS3XIdvYW3VOhoSnYEOFLePCiMjsY85aNXoy478VlwDz5qnl3s7YnEA5FxGcwLRH84
 mHtJ46porPG0gUisjfAjtT9AvlEOa/WVsh1JXBCAjjs3rn9G5Vof9ekYoA/lE=
X-Received: by 2002:a05:690e:4195:b0:668:99d0:8a91 with SMTP id
 956f58d0204a3-66c72d2b252mr7008176d50.39.1786961868462; 
 Mon, 17 Aug 2026 03:17:48 -0700 (PDT)
X-Received: by 2002:a05:690e:4195:b0:668:99d0:8a91 with SMTP id
 956f58d0204a3-66c72d2b252mr7008160d50.39.1786961867996; Mon, 17 Aug 2026
 03:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260814045315.3416169-6-subrahmanya.lingappa@oss.qualcomm.com>
In-Reply-To: <20260814045315.3416169-6-subrahmanya.lingappa@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 15:47:36 +0530
X-Gm-Features: AcwNN1VQWkG30PPty4cAV9KT4hpIcfxKDL8cWxeu2RNDzs5GEULXtnB6zohyflQ
Message-ID: <CAB19ukFFcQ_TpA=gtQHQN7M3KfVHEetGffcdns-nkzkgo+npjQ@mail.gmail.com>
Subject: Re: [PATCH v8 05/10] riscv: add RPMI system reset service
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA3NiBTYWx0ZWRfX6c8qtBYymqVJ
 REU9UHqBzg6maXqKSO8AXpGchk7/pfzrlE7Br3puLklZT1rkHcnv2vIG8j8hWlre/Jw+ywp/aRD
 cyHJ7KIhqN1J2IXOi879LG9Rn574Gi4=
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a82dfcd cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=1Ldq5WiWTmoEiJJNZDEA:9
 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA3NiBTYWx0ZWRfX1Gff5g526Nap
 25Iz3W+oHO9J/I+yAD6uJq19WW/U3EeCaqU+fEpBGKLT3kNaiP4PnCKn+Micu39OLIu24Wgur90
 mXYj/1+XpcUoS1mcBmd8KII9ztFyFWXpmv406sZjLmBD0+kClvSGcZNYuTsyLmgapGUbf7EgmLM
 vA8YcIHLYKwfeBkml6qqYbGMKkICrXJeC807logRgm66EM/ubHwIj1pAsRv0wFkoXAjeXyNgqZv
 y9MfSVTp3tdWZntqB3SwhHUq5D++3YcPfHt08YigB4HJArsucwW5BccltZBP8Xj/9dnB4CIP32b
 OhCmc79B5tIVErj5gZ8331YdD2oc1N7vfCzOmIFPi9TduPB3CJNsnA6xtTvbK9QMYKjXc6Iw+MI
 +7vZZBNWVMYDGWSOYM7mNbVXuD36yIc4K//daAmZ8ZKt3vbUO9ApjTg3n/jd2GJG2jfnomd1kOm
 Ew6chiFX+7+Kc5Y/v5Q==
X-Proofpoint-GUID: Rb5iMDAZU-U335dERPo7NeuUukJXQNXr
X-Proofpoint-ORIG-GUID: Rb5iMDAZU-U335dERPo7NeuUukJXQNXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
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
Reply-To: sunilvl@oss.qualcomm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 14, 2026 at 10:24=E2=80=AFAM Subrahmanya Lingappa
<subrahmanya.lingappa@oss.qualcomm.com> wrote:
>
> Add a QEMU implementation of the RPMI System Reset service group.
>
> The service advertises shutdown and cold reboot reset types, validates
> guest requests, and dispatches accepted requests through the machine
> reset and shutdown callbacks. This lets firmware use RPMI reset commands
> while keeping the board-specific reset policy in the RISC-V virt machine.
>
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.co=
m>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>  hw/misc/meson.build           |   1 +
>  hw/misc/riscv_rpmi.c          |  70 +++++++++++-
>  hw/misc/riscv_rpmi_internal.h |  12 +-
>  hw/misc/riscv_rpmi_sysreset.c | 206 ++++++++++++++++++++++++++++++++++
>  hw/riscv/virt.c               |  51 ++++++++-
>  include/hw/misc/riscv_rpmi.h  |  15 +--
>  include/hw/riscv/rpmi-fdt.h   |  11 ++
>  7 files changed, 349 insertions(+), 17 deletions(-)
>  create mode 100644 hw/misc/riscv_rpmi_sysreset.c
>
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 92c9cd6064..482f56504e 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -170,4 +170,5 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files=
('sbsa_ec.c'))
>  system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
>  system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
>    'riscv_rpmi.c',
> +  'riscv_rpmi_sysreset.c',
>  ), librpmi], if_false: files('riscv_rpmi-stub.c'))
> diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
> index 54a790fc7c..9575cd3a8d 100644
> --- a/hw/misc/riscv_rpmi.c
> +++ b/hw/misc/riscv_rpmi.c
> @@ -171,10 +171,37 @@ static bool riscv_rpmi_transport_indices_valid(Risc=
vRpmiState *s)
>                                            s->a2p_req_size);
>  }
>
> +typedef struct RiscvRpmiServiceOps {
> +    uint32_t service_group;
> +    bool (*add)(RiscvRpmiState *s, Error **errp);
> +    void (*remove)(RiscvRpmiState *s);
> +} RiscvRpmiServiceOps;
> +
> +static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] =3D {
> +    {
> +        .service_group =3D RISCV_RPMI_SRVGRP_SYSTEM_RESET,
> +        .add =3D riscv_rpmi_sysreset_add,
> +        .remove =3D riscv_rpmi_sysreset_remove,
> +    },
> +};
> +
> +static const RiscvRpmiServiceOps *riscv_rpmi_service_ops_by_group(
> +    uint32_t service_group)
> +{
> +    for (uint32_t i =3D 0; i < ARRAY_SIZE(riscv_rpmi_service_ops); i++) =
{
> +        if (riscv_rpmi_service_ops[i].service_group =3D=3D service_group=
) {
> +            return &riscv_rpmi_service_ops[i];
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
>  static void riscv_rpmi_configure_base(RiscvRpmiState *s,
>                                        const RiscvRpmiConfig *cfg)
>  {
>      s->platform_info =3D g_strdup(cfg->platform_info);
> +    s->machine_ops =3D cfg->machine_ops;
>      s->services =3D cfg->services;
>      s->service_count =3D cfg->service_count;
>
> @@ -211,7 +238,9 @@ static void riscv_rpmi_reset_hold(Object *obj, ResetT=
ype type)
>
>  static void riscv_rpmi_cleanup(RiscvRpmiState *s)
>  {
> -
> +    for (uint32_t i =3D ARRAY_SIZE(riscv_rpmi_service_ops); i > 0; i--) =
{
> +        riscv_rpmi_service_ops[i - 1].remove(s);
> +    }
>
>      if (s->context) {
>          rpmi_context_destroy(s->context);
> @@ -234,12 +263,12 @@ static void riscv_rpmi_cleanup(RiscvRpmiState *s)
>      }
>  }
>
> -bool riscv_rpmi_service_enabled(RiscvRpmiState *s, RiscvRpmiServiceKind =
kind)
> +bool riscv_rpmi_service_enabled(RiscvRpmiState *s, uint32_t service_grou=
p)
>
Could you squash this change with the original commit introducing
this? Also, I think it is better to have the framework changes in a
separate commit and then machine specific code to enable the service
in another.

Thanks,
Sunil

