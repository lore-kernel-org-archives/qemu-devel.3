Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED51C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woN2X-0001S9-88; Mon, 27 Jul 2026 11:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1woN2U-0001Re-80
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:14:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1woN2S-000080-Hj
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:14:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDldek3895621
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 15:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DDlh4kO1/iCNr1/HlzAm1sRq4HaEw6b8LhHFtObuOf8=; b=kdTh3e9QBqGfC39t
 weg2EiJ20AnIjsMJBCm4htHOyBOyQHPnhChquumqDbsZpObbfQ+1SrJMx0Ar+5hd
 pcaa2jTyXTLrbO4JAXp5zWtgc9x5/8OnJ/uUds+pbpArKCegLryKVZ9S7chf5aii
 nGIDU3+S6soFEz6YrqfNaj30FlPTHmbY9wb17vG0kYdGpfOrFg5zdnrzuI0lY7WL
 nnOqg4VfQwShEnhBzPHzDNB2G62+UMEVB2VGEyEpApIhjliujmNCcpAWUfVnDugi
 KyWOIlqQFImgE590v+ya6Sh2yUeRRptPMF3coheMSACVmqXOr+NdEbuaZZ9LofdB
 ugsMOg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fnsxs38f7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 15:14:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-520a00c7a03so51035941cf.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785165276; x=1785770076; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DDlh4kO1/iCNr1/HlzAm1sRq4HaEw6b8LhHFtObuOf8=;
 b=Lm3LVg+XeWqBfkMQGuUYwZollpQUuvJ6ejbMyixfCfr52k1f197Qm9eLDQSkyULYi5
 +74eIcl40ljv1CXGyBKoJ2AB+ueGOhaFpoboKyQIe5rMPCSKYLy/gShOTU4jHgGRz0JM
 8lhtVFi911/j7YJIoX8QJFI2qCSgIbYqXrrYNYDzjeJHvaRENq2I3k4iP1umWZ1O5Iwt
 nwcphyq7iR0dbbEpOxrbRzHvTAkqwt/4Pr7WMU49B8AsPVmbCfWOR5tZ7Tji8k0yDkqO
 ul3yXGiRnhx+O4Ibg/suaSd7z6KmCSQTXTP0G+EU0QFCjRBWkAKjpBwccvVpx5DfCoFJ
 xhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785165276; x=1785770076;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DDlh4kO1/iCNr1/HlzAm1sRq4HaEw6b8LhHFtObuOf8=;
 b=bQZmdPhE1I3PxUs8z5RxGBNpWIqd+1SsbkbjrFCa5eQqQLW9Pl9JSgsNN8QvR44wT5
 ECufvDSTA80d97U2CyDLdeY7qffECxohl+cc6U8o4oz6Nr4N7+ZZbOcg/3hUMEF9vuBy
 diWITdaefrn5fQCFHvfiCm5DvflErpIfKvwUmoPFp+mM0yL9egFPMBPauCdQInn3lyLK
 FGEYmx+SJUGYfGap7tGW6b17axKe5eCB5l+4Oa/wC+FGslCPlDkASsnl6Qed4CwDC3S2
 4K2TCDP0KdCMF1Wehbln97wIsaoKnr8OganHnAXHHBNA2tvXGlzjEOQaHSh3NksPnmqg
 w6qw==
X-Forwarded-Encrypted: i=1;
 AHgh+Roc9VHNJY2CG60wKB3bzTbVHDde2tpcb+v6JvTGtMX0Y4gUedWGIXT4dqpXigDsSJI24Ci6u+OtTgsa@nongnu.org
X-Gm-Message-State: AOJu0Yw55aeSNo9wwtVHq0BET5LGsr3eHdvwYo/LZHw06Gjm35I+EsSh
 aym2wmAG3Xxr2cH6965fj9QzNGkhvPhWC/Um003Kv5iwdF0N1BTzOQ1gV6Zkr9k8nVB9iZn4K5v
 gVG6EOi/wePz9hLEHae12XqzaJ+u8JvsBVuUjTfg6bYSF0kxAMa5lalDqDQ==
X-Gm-Gg: AR+sD12TUyqM4eGl4/CK3+DJKjfRwORiqKWAUMESRUJyGV0Y0+5UFcCW5zJt26XHcOW
 neMT39TN7060fHA+FPhxtsbZEp+Y7fZ0tY1ueeUVyW7GIvwk3s4zOxAH9jLj110RR8xmvNLOt/a
 e0jojykpkso0uGsNSCqlcLvDmy59mGPXi8KEqvCgMD4TyZYeGwV2vVi6Yp9bBOMSci91KMinTdW
 rG4HBLXwh3gILrcWdkFodJX3Ve1g4WM5hNqX82FqYDNMugRg5y4ZJx+1jZMKAifNS2SLdiICoqu
 GOdnMrq3R7gyX51AUtn5R7SMLNeHYhQyS0QLT7/KmQeJ/WkZk3XoiGi6QMuFsmu2cgB6Y2d9wDS
 zVxbhZ4AsaD+bM/84xDvU4iZHoTvEj7n6pplpojMk7ydseLjVXyfu14XD4IOvi7D9
X-Received: by 2002:ac8:7c4c:0:b0:528:223c:9649 with SMTP id
 d75a77b69052e-529a888587amr92406131cf.74.1785165275723; 
 Mon, 27 Jul 2026 08:14:35 -0700 (PDT)
X-Received: by 2002:ac8:7c4c:0:b0:528:223c:9649 with SMTP id
 d75a77b69052e-529a888587amr92405731cf.74.1785165275206; 
 Mon, 27 Jul 2026 08:14:35 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529a27f68f3sm56829801cf.9.2026.07.27.08.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 08:14:34 -0700 (PDT)
Message-ID: <ca200df0-1f09-4ab4-be20-351286be0cbb@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 10:14:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/hexagon: fix machine->fdt leak in qom-test
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-4-5c9a6ce7b96a@redhat.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260725-fix2-v1-4-5c9a6ce7b96a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0MyBTYWx0ZWRfX3wMJf09M3Mdx
 BjrZ/nnIUnn+wksY5ChIqlX4Y2WB23On1JDSXKY5Ltp3vSVRzSfT2amvqA8gnVXhx4BlOgv2Ga+
 eHiYcz17XNSixCBk4/HILdSUXKjidVo1OAssnQnKHm8CeOQgExWjZL/mb2zaWbC3CtmkS18NMWz
 lgN1eL1A5EZoNF9YFNY2OzXmGGdBRbHTKED0tWkDVJXOzWv3CXem3aKdOhdXhPR+abK/vCCYgCC
 HGAobEcHQzTg/Di+eyIl0CVSG1vbcfAR9MTyCJjpqnxBaodWJwJ71B6D2V7F1br/e58MHhsoyfT
 A2BF40yr5BWl/oZmlEmNGqCkDy2TbU0eN/YJ5AxnaSMelKEDiBRCOFV4cWPQ9CrrMZ4ZZUevF9h
 rFKF5CpH/vWsCaQKiOEY008XjJaqdkP/sQO6uHq/6pyckYqgjtItwB5izEVlEDadfPG4NyVCkd8
 Kh4AtjrRRPjyCK7zoGg==
X-Authority-Analysis: v=2.4 cv=EYr4hvmC c=1 sm=1 tr=0 ts=6a6775dc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=vonYgpfw9pO0NH89MCAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: RcGYNu7aQUCOhUE8TTe-FL8WVaOD5RP1
X-Proofpoint-GUID: RcGYNu7aQUCOhUE8TTe-FL8WVaOD5RP1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0MyBTYWx0ZWRfXz+YMx+q8XXLs
 ckxsLSzPMAtgb42dIgkV07/l9UThUPyj/WXdA0bEyVOCD1SBrKi0R9AqOQy2wftbzrsZZ1YWfZ6
 KblsXbeT5HME+Zsdmwt2/U5/d+tFWSw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270143
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 7/25/2026 9:00 AM, Marc-André Lureau wrote:
> virt_instance_init() built the FDT unconditionally at QOM
> instance-init time, so simply instantiating the object (e.g. via
> qom-test's introspection, without ever realizing the machine) leaked
> the 1MB FDT blob: machine_finalize() does not free machine->fdt.
>
> Other boards (arm/virt, riscv/virt, ...) build the FDT lazily from
> their MachineClass::init callback, which only runs when the machine
> is actually selected to boot. Do the same here by moving create_fdt()
> into virt_init().
>
> Fixes: 88a8bc7f43ff ("hw/hexagon: Define hexagon "virt" machine")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   hw/hexagon/virt.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
> index a3638998b873..b75047250260 100644
> --- a/hw/hexagon/virt.c
> +++ b/hw/hexagon/virt.c
> @@ -175,13 +175,6 @@ static void fdt_add_cpu_nodes(const HexagonVirtMachineState *vms)
>   
>   
>   
> -static void virt_instance_init(Object *obj)
> -{
> -    HexagonVirtMachineState *vms = HEXAGON_VIRT_MACHINE(obj);
> -
> -    create_fdt(vms);
> -}
> -
>   void hexagon_load_fdt(const HexagonVirtMachineState *vms)
>   {
>       MachineState *ms = MACHINE(vms);
> @@ -242,6 +235,7 @@ static void virt_init(MachineState *ms)
>       DeviceState *cpu0;
>       int32_t clk_phandle;
>   
> +    create_fdt(vms);
>       qemu_fdt_setprop_string(ms->fdt, "/chosen", "bootargs", ms->kernel_cmdline);
>   
>       vms->sys = get_system_memory();
> @@ -341,7 +335,6 @@ static const TypeInfo virt_machine_types[] = { {
>       .parent = TYPE_HEXAGON_COMMON_MACHINE,
>       .instance_size = sizeof(HexagonVirtMachineState),
>       .class_init = virt_class_init,
> -    .instance_init = virt_instance_init,
>   } };
>   
>   DEFINE_TYPES(virt_machine_types)
>

