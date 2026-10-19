Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5ED606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QPGVtaHF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bDJ6Cr4v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIt31-0002ci-Sy; Mon, 19 Oct 2026 15:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIt2t-0002Rh-4V
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:29:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIt2q-0003OU-Hs
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:29:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJxcB549443
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oBMHgj9o6soaZAEj5lS6N5zAHKISk/Nq17wHlDgJ/bo=; b=QPGVtaHFO1XtbAc7
 fUEYz7TdR1LUo4he337pqpNlXerN947NMgJV630zGPrML6bnckDCMJZLrAWT7LLa
 XjkRspU69UPKSd4baU3bANJpJTvbSubnuo3QJ+YyMdBkxDr0tzQwG9A2CqUpum6x
 q4lwL+v7tZ/raYregZ88Ks4hllvS4GPvjtAFTNSxufcVMtRJLPCy93jihuvZGpgq
 sWuulRMzRLwlpjoXqT0bbRKT+FA59hzK5iIied4/JNTn1Qa3Ez8CeXvkvJ7iib0p
 cszOSMOVPgvoerdNY4rvKwpRUFhuUHsxQCQqIpiZMTw/Gb4TpAj3xzRljs3ZhMkh
 wHyHsQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47jyq6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:29:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ae8e7e546so541009985a.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792438152; x=1793042952; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oBMHgj9o6soaZAEj5lS6N5zAHKISk/Nq17wHlDgJ/bo=;
 b=bDJ6Cr4v5G1cc4DJLYkYfBVDFX9KJkzqmTu6XoQc/F1qPY30ZQ+8FzxIPTZ3lKICJK
 u7DWsVItJ5WTO5lRsKLoSJ4ypCzosUV8N+s5m3wVQ19GyyIy0DUI2HLTjAUTYqQ8cP1d
 2K4QI2WQncY0qFiSrwoa6OsmlXGgK0vcBzkHD0x1l0B1cNE1VYxKpVvWhS2w8XLsEuEz
 OYNSWUM4VvAgDHBtBTnDB2q+vQNdltGF/bQNekTG8viz59S8B6iTpKzmyJpG8THv24fF
 z4qKK9183vDM9LuA2mDVDa9z/aR6DUNDfUKs7w8XmtPwHMWn8uB+ns1yS88fhZe1mOcX
 aphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792438152; x=1793042952;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oBMHgj9o6soaZAEj5lS6N5zAHKISk/Nq17wHlDgJ/bo=;
 b=FGoPVn5Erf93AmKoEiwOCK67KzVxYrNZ4H4mx7qWnBsu69j2OA0I0DBktngK6azy01
 OFy1azifUkEUM+cxLgPDb47a+0QPmSOAJOSiNMz8hGaj1rcLWCgcLAE8y4ywqiVK4HZo
 cfnx0tI5z6KHCaVdobIVqPntVkcwAcLBrvJC6B/n3BMtvDoVri75LvWIaqC8/Fk/kuxD
 AHsiWNXh0k5ClErCGRrjfUoHePo8BT0mVGIpEaueB9V6hJI0aSY2Rdv/YgSZiLBhJYBZ
 /JeSoS9l3Oe6ylEcG2VnIIRBjh8zAAHZmv2wjAQxGxKijz2nyLkmfqjJ9XkX6lIVkB0O
 j7mw==
X-Forwarded-Encrypted: i=1;
 AKwUvByq1GFMDG/DF/d8F3xHj378qlZwue22T3VSSFY7UE+inxXp8fWu7VFbaa/WsUB4doYxFqjLIPfYPzAw@nongnu.org
X-Gm-Message-State: AFq9FYK5Lv79HcCDEgdwaJn+7JJo5YURa4T0CIVHTpKbqejH1ehBoT4a
 dZMhdImIgXr9nFvYftZkgcT8jZcTJVTEFIXrIPV1vjSC8gvHUZfoLVATdPHA2M60aRSpU+STWBE
 b4vrSjLHyJG/E1wUsN827S8tzpO2xFfDIpOKYYB/AIY2DNX+GssDKODaKEg==
X-Gm-Gg: AYBFou0p6LnpXuSiKoQSXzs4v/Pg21oiktz6/NeTofIZ4Wn+5v/0o9hGHrF64GiyytG
 XYyOYiaU/KZPdRytLre6MbdcTIN5FeE2+ijoeXleMU7IONZsS0e+esgdWPTRoqPJvRMW6vEKrPK
 WjJTu48VfTsIB4NNC+H5RQR2h9njJ6SklHfvgzIHA56p7UpK8impvzxGWwh/8NbkLJ5Ok0gQIfi
 RIJdhxfd+oUV5oW16ucVTTIkGLxnCWxr9ZxkECZP5j8vBSj7hpIlsO6MBrqL7V+ETyQMaph5fkM
 XqjHiPp5krqMJ6XYilvRCUBifhPA7AXZltw/Jt4c7f2VwdM/woTAUglJyQxL+HZWr5YO34Kf2vc
 NRET/2z/GkExbmt6mVUB+y7nkLjctWrFtIbq0ZptAR61oXPMlf3dQycpJpLhcPsm+
X-Received: by 2002:a05:620a:40ca:b0:93f:1e3c:4a3d with SMTP id
 af79cd13be357-93f29d54238mr1477300685a.46.1792438151928; 
 Mon, 19 Oct 2026 12:29:11 -0700 (PDT)
X-Received: by 2002:a05:620a:40ca:b0:93f:1e3c:4a3d with SMTP id
 af79cd13be357-93f29d54238mr1477295785a.46.1792438151365; 
 Mon, 19 Oct 2026 12:29:11 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f4b059cbasm37062885a.7.2026.10.19.12.29.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 12:29:10 -0700 (PDT)
Message-ID: <190ba0c4-8207-4008-b53e-9f66bf126d81@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:29:09 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hexagon: add V73NC_1 machine
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com
References: <20261019191459.300112-1-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261019191459.300112-1-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KAzYSc4CW1b7MGtmP9vnCpLc6xQ2Q5k5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NyBTYWx0ZWRfX7P2DE/lEdAJ3
 l6aDFZXHoXQZZVy8VG+i7AaonJI9CQAPdD8EGI5GKnuvttJvI6OG2W037hD2WW7LiIA6nXDEsP/
 tmZAWdwj3BLE0ZhuwBdITclVc0Fhl9DkzV+ULsb6tyuaW0JibRThNQYE8A0ge/Iu/I4W0ntChmT
 yyNL3BtvN313OmfPS3JSPsXb94zCBEz6R2ygIdx/XoDjkrbdQZpm1d4sTK+S8gHsy/2KjrRt/SL
 IhvlW3c3h/XxT1kcwrDrIOCAB82us5tx8P78bjx26COv5KX6eaiKkQoEB9rBdcu7+gTA7iBw3ws
 q32wpF3GICHV3B2U8v0Yt8WpMYHTcYm1uu7jenp8hlkp1hMdMyStV9suvcQJ0Nnr5c377iqSSn0
 IrPJYpdfBjctnfTzP26JCs2wNvxg09O7gLnALLBgUcUJvVHLAOzYnqoKm1ym/HbgxNiDZCfY2ny
 wnigOqYiPN0kqAa7/JQ==
X-Proofpoint-GUID: KAzYSc4CW1b7MGtmP9vnCpLc6xQ2Q5k5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NyBTYWx0ZWRfX/BBNpInu44Rb
 ppXqoC3hWWJparRu3AxDqVPncW+1Xf7k3yyXeof/MxZT3u+e3VuyXf7poCm3u4+qxYs7ZTQP08W
 S70hBgxChau/mpFpn7L4Ml1W3/eJENk=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad66f89 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=qF4GV4gejPVUg4V7NnUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190077
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/19/2026 2:14 PM, Marco Liebel wrote:
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   hw/hexagon/hexagon_dsp.c             | 22 +++++++++
>   hw/hexagon/machine_cfg_v73nc_1.h.inc | 73 ++++++++++++++++++++++++++++
>   include/hw/hexagon/hexagon.h         |  1 +
>   3 files changed, 96 insertions(+)
>   create mode 100644 hw/hexagon/machine_cfg_v73nc_1.h.inc


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


I'll queue this for the next PR - thanks.


> diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
> index 8824fe10a5..d904d5afa1 100644
> --- a/hw/hexagon/hexagon_dsp.c
> +++ b/hw/hexagon/hexagon_dsp.c
> @@ -30,6 +30,7 @@
>   
>   #include "machine_cfg_v66g_1024.h.inc"
>   #include "machine_cfg_v68n_1024.h.inc"
> +#include "machine_cfg_v73nc_1.h.inc"
>   #include "machine_cfg_v81dgb_1.h.inc"
>   #include "machine_cfg_v81qa_1.h.inc"
>   
> @@ -200,6 +201,22 @@ static void v68n_1024_init(ObjectClass *oc, const void *data)
>       mc->default_cpus = 6;
>   }
>   
> +static void v73nc_1_config_init(MachineState *machine)
> +{
> +    hexagon_common_init(machine, v73nc_1_rev, &v73nc_1);
> +}
> +
> +static void v73nc_1_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "Hexagon V73NC_1";
> +    mc->init = v73nc_1_config_init;
> +    init_mc(mc);
> +    mc->default_cpu_type = TYPE_HEXAGON_CPU_V73;
> +    mc->default_cpus = 6;
> +}
> +
>   static void v81dgb_1_config_init(MachineState *machine)
>   {
>       hexagon_common_init(machine, v81dgb_1_rev, &v81dgb_1);
> @@ -258,6 +275,11 @@ static const TypeInfo hexagon_machine_types[] = {
>           .parent = TYPE_HEXAGON_DSP_MACHINE,
>           .class_init = v68n_1024_init,
>       },
> +    {
> +        .name = MACHINE_TYPE_NAME("V73NC_1"),
> +        .parent = TYPE_HEXAGON_DSP_MACHINE,
> +        .class_init = v73nc_1_init,
> +    },
>       {
>           .name = MACHINE_TYPE_NAME("V81DGB_1"),
>           .parent = TYPE_HEXAGON_DSP_MACHINE,
> diff --git a/hw/hexagon/machine_cfg_v73nc_1.h.inc b/hw/hexagon/machine_cfg_v73nc_1.h.inc
> new file mode 100644
> index 0000000000..729e48975c
> --- /dev/null
> +++ b/hw/hexagon/machine_cfg_v73nc_1.h.inc
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +static const struct hexagon_machine_config v73nc_1 = {
> +    .cfgbase =             0xd8180000,
> +    .l2tcm_size =          0x00000000,
> +    .l2vic_base =          0xfc910000,
> +    .l2vic_size =          0x00001000,
> +    .csr_base =            0xfc900000,
> +    .qtmr_region =         0xfc921000,
> +    .cfgtable = {
> +        .l2tcm_base = 0x0000d800,
> +        .reserved0 = 0x00000000,
> +        .subsystem_base = 0x00002000,
> +        .etm_base = 0x0000d819,
> +        .l2cfg_base = 0x0000d81a,
> +        .reserved1 = 0x00000000,
> +        .l1s0_base = 0x0000d900,
> +        .axi2_lowaddr = 0x00003000,
> +        .streamer_base = 0x00000000,
> +        .reserved2 = 0x00000000,
> +        .fastl2vic_base = 0x0000d81e,
> +        .jtlb_size_entries = 0x00000080,
> +        .coproc_present = 0x00000001,
> +        .ext_contexts = 0x00000002,
> +        .vtcm_base = 0x0000d900,
> +        .vtcm_size_kb = 0x00000800,
> +        .l2tag_size = 0x00000400,
> +        .l2ecomem_size = 0x00000400,
> +        .thread_enable_mask = 0x0000003f,
> +        .eccreg_base = 0x00000000,
> +        .l2line_size = 0x00000080,
> +        .tiny_core = 0x00000000,
> +        .l2itcm_size = 0x00000000,
> +        .l2itcm_base = 0x0000d800,
> +        .reserved3 = 0x00000000,
> +        .dtm_present = 0x00000000,
> +        .dma_version = 0x00000002,
> +        .hvx_vec_log_length = 0x00000007,
> +        .core_id = 0x00000000,
> +        .core_count = 0x00000000,
> +        .coproc2_reg0 = 0x00000040,
> +        .coproc2_reg1 = 0x00000020,
> +        .v2x_mode = 0x00000001,
> +        .coproc2_reg2 = 0x00000001,
> +        .coproc2_reg3 = 0x00000000,
> +        .coproc2_reg4 = 0x00000000,
> +        .coproc2_reg5 = 0x00000000,
> +        .coproc2_reg6 = 0x00000000,
> +        .coproc2_reg7 = 0x00000000,
> +        .acd_preset = 0x00000000,
> +        .mnd_preset = 0x00000000,
> +        .l1d_size_kb = 0x00000010,
> +        .l1i_size_kb = 0x00000020,
> +        .l1d_write_policy = 0x00000002,
> +        .vtcm_bank_width = 0x00000080,
> +        .reserved4 = 0x00000001,
> +        .reserved5 = 0x00000000,
> +        .reserved6 = 0x00000000,
> +        .coproc2_cvt_mpy_size = 0x0000000a,
> +        .consistency_domain = 0x000000e0,
> +        .capacity_domain = 0x00000080,
> +        .axi3_lowaddr = 0x00004000,
> +        .coproc2_int8_subcolumns = 0x00000002,
> +        .corecfg_present = 0x00000001,
> +        .coproc2_fp16_acc_exp = 0x00000000,
> +        .AXIM2_secondary_base = 0x00004000,
> +        .AXIM_data_width = 0x00000000,
> +        .l1d_ways = 0x00000000,
> +        .l1i_ways = 0x00000000,
> +        .l2way_num = 0x00000000,
> +        .dma_jtlb_entries = 0x00000000,
> +    },
> +};
> diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
> index 9b5d33ffc3..a01cf5cb3b 100644
> --- a/include/hw/hexagon/hexagon.h
> +++ b/include/hw/hexagon/hexagon.h
> @@ -27,6 +27,7 @@ typedef enum {
>       v71_rev = 0x8c71,
>       v73_rev = 0x8c73,
>       v73m_rev = 0xcc73,
> +    v73nc_1_rev = 0x8b73,
>       v81_rev = 0x8781,
>       v81dgb_1_rev = 0xcc81,
>   } Rev_t;

