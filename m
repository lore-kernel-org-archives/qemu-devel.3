Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F96CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwxV-0000jL-Is; Mon, 18 May 2026 08:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wOwxT-0000ef-Rn
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:20:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wOwxS-00067K-9q
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:20:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IBw1os1250902
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 12:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9Hks+bPBC6RjlS6n54PVTYIhSSTFCDQhJRtexyMv3Yc=; b=fNC4zFBNOWtK6s+t
 CyWt3tDFi7z5qnK8Z7nnsA6Hq2lsTLE0mJBp2JHSdYNtSbYFNEdyF0bqgwlFelhq
 KtXSR/cWV5F5ows94r4CtRLXGVkFdLwxseG6/kkaPHyRpVucX4DCu7iFH5moMigu
 2/RwmTB/faj+9zimeQu81vGcSIrTZLmIL+OSxeBqxf1/Bs/mEXUBmwQ1jukKMiaG
 znOH3uvMPcBFgAhrp+GqkFoiIzkX9YdndsXojAWA/5mR8vt86DgFrOahGOS1SyjZ
 Mp+yibklh8bKIOgqvx1EjN74Qdx3VNXhSUohPtJeA3DTYUUbyA0euJqvDH+qDuKJ
 FO3cVA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82c0g2vn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 12:20:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8c9e99fcd15so75535796d6.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 05:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779106828; x=1779711628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Hks+bPBC6RjlS6n54PVTYIhSSTFCDQhJRtexyMv3Yc=;
 b=YYNL68V/6l/AbVoUPDG0ImMP6MqeYQ8jh6KQr5QqYSMNAzIau33Xa/jwWvrSH/0TbP
 n7VmQTX+ZnZqv+6f9tN30hQb2iqgDd+6jb/61cLwaGR9xNMB08VtV40HmkqXT5g6WAk3
 0N7F09Vk5OAABr+RPmkp2vF7sdt9MZi8Crbtrz5Pu5Jgf5cvTSjv+TqottZn1NRLvK0U
 PmYJoM3Q5dT7LMJSAyNNSwX0HvwvD/ngAt2sH3MvcyfBZ079n/8xBoKDWXnvDBPJ/x8m
 rCNXr38ZgSU31a79f+MK94j3P6GFbavxv/eWjCM6h+gqc9YUrMGt17QxDBVcTPPruSwR
 K0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779106828; x=1779711628;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Hks+bPBC6RjlS6n54PVTYIhSSTFCDQhJRtexyMv3Yc=;
 b=JhkcI39yHZjgsPyWeUQJRUVAR2X1D9kOg9kdD9DKWuXv/Zmq3QPIhymqC8xPfcRBkl
 y2mky69DanxB5E0XK4JokhfGGW0fkxvO9WptWvIgS8lnHxLBolC+Igic8mmPoz1kq4on
 1Lr1MO5xsOh76am8MPZgoc8/43TPH+Tpi6fR1Y9DZfW2NTjmZywQC9+jcXeUiiFpGdZC
 I8+/LSqkoreIlNZgdqf35TR2kzVEEwIzpmn19QFqzd9SiAo4L4BUKykKkdQhWk67vTwo
 9+wtB+RfTMsztYVDdGhXcijTqI8Oeqf0Q6K9lCck7H865cDjSUU4JMcdntN/0BMLgWxM
 MDEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/B9dJxYEDcyxCTTPCDuZaXvmDflOCwBswquYmiNokwrGwBTdn+SCzjXs5erCXI/AUxaBC3afO1e35V@nongnu.org
X-Gm-Message-State: AOJu0YxgitRLebfRXeje4nK/JOHADLTEuTLO/rPK4M9ERVS+DCBZqGRR
 +2C08n/Ivi0dIYxc322bpu3HNsAvuBt5mAYEX77m1fYr+MO98cqWLgFa9p1zzGSkpMxsugYi9Hh
 MV0/65A0O2K6XpqGFlX9cNErOPHhZRq1fFsS7O5O9IDi459YMeIIdSted4Q==
X-Gm-Gg: Acq92OEDcLJ5b3MekeYv9D+zEea2/Mq3z7OYQCuifU9oZr4ucgOOO89j/5SPCeELgQI
 jyoYM/rBxwcv4DGD7hytDZs1i/f0L+MEM+g0uruYdgi2WEKkaQ3nq6C3nlXrmWF9hfZSdmedxRV
 GafAeYlj1Np4x1DmzzMavK3FBOqywqtQyS2ZYUaJxFe5En2agELJQO9bU//SSOVpC628MVnCHTW
 keWY8qPTVUIL3iUmJTr14DKwHnyL9q0xAt0/Yu5Sbm9Md14uoW2DAfIlKvpKAtECkUGDiJbJQTv
 jU7kq7at8QaSP2GEybmmEuYqw/fRje3yvKl9eIKD83GpPY/343VcLb1xY7Iir8LiULtI7Y2tOPz
 mqQlh8Fc7S02qAjutIH73s/K5JDmozWmMQuB5hFdxdYya7q8JR53pAgcOEc0=
X-Received: by 2002:ac8:5a04:0:b0:50f:9c33:af18 with SMTP id
 d75a77b69052e-5165a2673cfmr204335831cf.51.1779106827694; 
 Mon, 18 May 2026 05:20:27 -0700 (PDT)
X-Received: by 2002:ac8:5a04:0:b0:50f:9c33:af18 with SMTP id
 d75a77b69052e-5165a2673cfmr204330461cf.51.1779106822787; 
 Mon, 18 May 2026 05:20:22 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca3619dbc2sm54250826d6.38.2026.05.18.05.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 05:20:21 -0700 (PDT)
Message-ID: <093e35f7-8d0b-4bd6-9229-c54168c6da7e@oss.qualcomm.com>
Date: Mon, 18 May 2026 09:20:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/intc: riscv_aplic: Add reset API to APLIC
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, "Fea . Wang" <fea.wang@sifive.com>
References: <20260428160103.3551125-1-jim.shu@sifive.com>
 <20260428160103.3551125-3-jim.shu@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260428160103.3551125-3-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDExOSBTYWx0ZWRfXwGaVbH9fhtyU
 2KsTGRntK5XKObHInD4DAOhk+sxGNzKmd93GPI00RRUOmy4JpIBkqH4AaJViv+Hn12yanqrlHiv
 D4Vgv+JFzGAbzPBUJxQPqrI2c4e67KmVu/bglJIanSs8GkdAeLiBvBoo7+H0NBmeUrnIf/7glKA
 NvSIbszqittYu7+/+L/LwJnl4XDvgX7uU64fm5PCnTC5R37uwLgn5QwKPtKEepuqeJX/9lIrAKC
 r5Gsvi3D3SY2FoIGuDfFAgRGI8lx+GNl+WaEB9on6GrB3UnJdCNb8HM7y3xGjPC+1cbhG3Wnl5e
 V0N20lrvlSvWQ5s0sc3GwtZdYlm30yFO/ivzLmCJz6KIEx/9CqhMHYtq4SEZiG9cRXONxqtZc6P
 aWagIRaGtntfvh/TnLcsNNlxFevrIsPUzZkbVkMQW2GFDVRk+QAE7XwDrF9+rYTWtMjo/K44qU/
 W3VzIXi1NTDs7e5SIzA==
X-Authority-Analysis: v=2.4 cv=A5Jc+aWG c=1 sm=1 tr=0 ts=6a0b040c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=sWJxxScTxLTsTb5j_mMA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: fq85z9LZOOEoV6CpAEm4w0qzTT4gR131
X-Proofpoint-ORIG-GUID: fq85z9LZOOEoV6CpAEm4w0qzTT4gR131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180119
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 4/28/2026 1:01 PM, Jim Shu wrote:
> Clearing APLIC registers and qemu_irq in the reset function
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/intc/riscv_aplic.c | 45 ++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 791e0b01b96..a04e0e1a898 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -892,6 +892,44 @@ static const MemoryRegionOps riscv_aplic_ops = {
>       }
>   };
>   
> +static void riscv_aplic_reset_enter(Object *obj, ResetType type)
> +{
> +    RISCVAPLICState *aplic = RISCV_APLIC(obj);
> +    int i;
> +
> +    aplic->domaincfg = 0;
> +    memset(aplic->sourcecfg, 0, sizeof(uint32_t) * aplic->num_irqs);
> +    memset(aplic->target, 0, sizeof(uint32_t) * aplic->num_irqs);
> +    if (!aplic->msimode) {
> +        for (i = 0; i < aplic->num_irqs; i++) {
> +            aplic->target[i] = 1;
> +        }
> +    }
> +
> +    for (i = 0; i < aplic->num_irqs ; i++) {
> +        riscv_aplic_set_enabled_raw(aplic, i, false);
> +    }
> +
> +    /* Need to unlock [ms]msicfgaddrh.L */
> +    aplic->mmsicfgaddr = 0;
> +    aplic->mmsicfgaddrH = 0;
> +    aplic->smsicfgaddr = 0;
> +    aplic->smsicfgaddrH = 0;
> +
> +    if (!aplic->msimode) {
> +        /* Reset IDC registers only in non-MSI mode */
> +        for (i = 0; i < aplic->num_harts; i++) {
> +            aplic->idelivery[i] = 0;
> +            aplic->iforce[i] = 0;
> +            aplic->ithreshold[i] = 0;
> +        }
> +
> +        for (i = 0; i < aplic->num_harts; i++) {
> +            qemu_irq_lower(aplic->external_irqs[i]);
> +        }
> +    }
> +}
> +
>   static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>   {
>       uint32_t i;
> @@ -925,11 +963,6 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>           aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
>           aplic->state = g_new0(uint32_t, aplic->num_irqs);
>           aplic->target = g_new0(uint32_t, aplic->num_irqs);
> -        if (!aplic->msimode) {
> -            for (i = 0; i < aplic->num_irqs; i++) {
> -                aplic->target[i] = 1;
> -            }
> -        }
>           aplic->idelivery = g_new0(uint32_t, aplic->num_harts);
>           aplic->iforce = g_new0(uint32_t, aplic->num_harts);
>           aplic->ithreshold = g_new0(uint32_t, aplic->num_harts);
> @@ -1014,9 +1047,11 @@ static const VMStateDescription vmstate_riscv_aplic = {
>   static void riscv_aplic_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>   
>       device_class_set_props(dc, riscv_aplic_properties);
>       dc->realize = riscv_aplic_realize;
> +    rc->phases.enter = riscv_aplic_reset_enter;
>       dc->vmsd = &vmstate_riscv_aplic;
>   }
>   


