Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3C2C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsh7-000783-RD; Tue, 11 Aug 2026 16:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wtsh0-00077I-D5
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 16:03:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wtsgy-0000hh-6y
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 16:03:22 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BJHj4T1597823
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 20:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fIQi2pF+h48+Fm6Lq2ACR8Ivc9tcely6qtbaQu15Ob0=; b=V3YcKUkrqrr8u6pw
 cPWxIVwYph5lJqvr5acoWftbwQdrTWM7oMxAtqqVn1FWls2p1QPGfHgBM3CyicWA
 1L9JtlBcuPXGWiKpk5F/KBLm4LGlBfg+E8TKSzEnhvd5EsgULXPYg6e70csmjnEI
 ET+Qn80yrDftjHFreJH9ObjkGGg9m3eaD2Cuip79XWiZ6/7KKmny+JBLDooJteox
 YypnJNfWMq9gmnLETDgO/Q9a8yxn7/P2MJp2c2837CVEurZUtIrznwxCeGXBorI5
 +I82/KqymQHd6AHUacQ+cNjYmum8GbRL2fS0wDyP6kc1rWjAvBqawmO+F1Sd8fl9
 qRF8BA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049dhvq6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 20:03:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-904ee4473a8so2247126d6.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 13:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786478596; x=1787083396; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fIQi2pF+h48+Fm6Lq2ACR8Ivc9tcely6qtbaQu15Ob0=;
 b=QlyJfXzUipLS+/NTilc1sKe/q5m2xzE/QZusBOyBP2PRKRlZWwPsP9qnH6K7r9HD7W
 0/kD3VXzyWdlUVLsr18Ww3yqFVX+yHaU0fDvjG9PzMGzMBOnqjJclcRBPu9J7maacSd3
 9kfM9HbZT2WgvIhnElwb8MVrph3dCjSaP4soJiSmheGU7LP3qA1V1Zq60FcgMnS5SKlu
 3bsKwFu7D4Qx+rfhrSc7zJLsU4bEZxGqfO/4lSkJ0Z5/NgZ8ZujoO45b/AzRjsnEQcQw
 0el68iE2d4FhJYMR6V1pCQ0vmr7mLKy0y1u1+ibiPtvUoG0ZNUE34oeQfQBYvjRk1u4f
 6gGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786478596; x=1787083396;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fIQi2pF+h48+Fm6Lq2ACR8Ivc9tcely6qtbaQu15Ob0=;
 b=Giw9mENy4Dh1lIHP07FSbEm2wLHwuWjz4Spv+X8F+v1dinUCMWV3qfOQJMfvRaO4kO
 SAlr9LS3KgUFQv3hxxRJQFjnSA7xdk+WoWPQt3Vl44wUpjIGaBoE1rLLnDhIGiqx18FE
 D2eA3qS41Xaxq3xZOMS5oo7ZrDuFtUqqj6HqoeG9o+Udl44IaS+/GXrXk/JfytOkQ4VW
 hLacUQM+P7IOTOI9B520zHDgOx119oB0ZIlvqYQ1JjUMJldKKRZn2TRqNETF6vT1IYSQ
 k6I3w2WZBt/lSWl05mkCGHDwUgTT1Co+mccN3lkp4Z768L2T+uzCY0MgImLnymMrqlbr
 wsVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjgiQLMcN+A9yHGRlrPL3UybXgLdj8aVY85oMwPTEYcinGm38xWjIRG9OOKCf7vf6bP5rmereZW6Ym@nongnu.org
X-Gm-Message-State: AOJu0YyRvSpPhjZz1ydd44bvQ71/A8fRuJICBHQRTdaF2tYEV71rw1pj
 ggevgGxnwwRT4IFcxnm0xFenbH9jEepWjVNcVNaQqYyLkYVkWq/sKKAT0wRTvOnfUtsD2ee/ysM
 eCFFjh7a85u4BLXJLysrpA6J8e0IVAuuWYusjKAzRK7zynLTnxCDsilmHLA==
X-Gm-Gg: AR+sD13qB07q8otsuiTRNxcNGOGDAxFNBw+H3+HKRl1c8PtFoCv/zYSRdoyRZSAhFyw
 /2uZAAGckzDJjxMrIPC4O5256kD9YC7bmMQ158yeq5SPDvQsXgA6fw4/nv/z/lR/hyH0rY99dDW
 wsX+HCsrb9GYLe6yptIfKSU76u5WESdKDZN1zwhscMm18TLHSakaNGtRxya765HpdmuGLmCqpR6
 SFS8tn2qeGO0HY9xLGyNNOOcqCzA7LJFhi7tg20YO0Noxv1qcI5swn3dycPUCn5jYSenCnd7f2T
 PTyyRErP3HjZreHYk76/mWG4u9NLr5ezTIutXVF87fKj/gEcLHFXtT1DPtB5KNw4pBJ2Y1lAQYi
 gayDd3VKbYoaZtog60tNA2kM7K5NzPUPNUoQMB9arp7S20ef8/sFBNGtnnErZ0nuO
X-Received: by 2002:ad4:5949:0:b0:8ff:6304:da9 with SMTP id
 6a1803df08f44-90a6c0b7118mr28591796d6.6.1786478596317; 
 Tue, 11 Aug 2026 13:03:16 -0700 (PDT)
X-Received: by 2002:ad4:5949:0:b0:8ff:6304:da9 with SMTP id
 6a1803df08f44-90a6c0b7118mr28591046d6.6.1786478595806; 
 Tue, 11 Aug 2026 13:03:15 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c2cdcebsm6418766d6.21.2026.08.11.13.03.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 13:03:15 -0700 (PDT)
Message-ID: <f16552dc-0f3a-40bd-bacf-b8189bade43d@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 15:03:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Hexagon (target/hexagon) Clean up disassembly of
 control and system regs
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260811032206.58501-1-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260811032206.58501-1-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE2OCBTYWx0ZWRfX5LobF+PHVha2
 J8vWMVwB3+6anli+PfoB2EElbbILNwW+fxO37ZGmwlH+jUfAs2mpd/WqKZVnPC7QyR4jaBqZLF4
 6rOq/x4jvWwUDFp5XCD88a/xpNVbqU0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE2OCBTYWx0ZWRfX2oXQ48okJvmY
 C2iCHO0U1VW4ond6gdaUFijNhIcgBHDFNmsGN7v1Ghb6PXfFO3aEB71NAAVGHhM6/RGurXIJ9gs
 yJZBxSdeo865eFNRKgL7YlY8NCFauruDTsSo2axHNH2KJa//HAFr8wGZPru1eMB+DLveBMTj80X
 PPgI/KcM1StWLWOveQMG+2hD//avLpf78aKmshqv5QjPMNY9Pun9sSxGygPh+fNnYgL0Zz0bs49
 R1D4hp0y9kZS3Yiggr5IcFzRk8MEWhbHTvrVDKHbeouqnkLZbcnohzKnqkBaB5XfHoWgEsEq1ya
 nuOGBpYsjNPx4GX2qM5ltQWrS0X/Joc46rWBJETKhg7hioLg8g6zO30fwZxZFgDkrRtXhNNog9n
 XiKd02Fa1ds2FAA4Q9zW4OJYjD5IHZog3Mf3Yvheh7AiuHJkLopyi5du5xAihXtLTN8EfttO1A1
 vI7j+TixuGd8iUoTA/w==
X-Proofpoint-GUID: Nb8giTCzOVIo4xHvV66pnUsMLJ2z_TTZ
X-Authority-Analysis: v=2.4 cv=CbA4Irrl c=1 sm=1 tr=0 ts=6a7b8005 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=P6N1_u7826NKKFm3RkMA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: Nb8giTCzOVIo4xHvV66pnUsMLJ2z_TTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110168
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 8/10/2026 10:22 PM, Taylor Simpson wrote:
> Change disassembly of control regs from C{num}/{name} to {name}
> Change disassembly of system regs from S{num}/r{num} to {name}
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>   target/hexagon/printinsn.c      | 99 +++++++++++++++++++++++++++++++--
>   target/hexagon/gen_printinsn.py | 14 +++--
>   2 files changed, 101 insertions(+), 12 deletions(-)
>
> diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
> index a7e46f4bcd..1673e95421 100644
> --- a/target/hexagon/printinsn.c
> +++ b/target/hexagon/printinsn.c
> @@ -23,18 +23,105 @@
>   #include "internal.h"
>   #include "decode.h"
>   
> -static const char *sreg2str(unsigned int reg)
> +/*
> + * Used when there is some sort of error and we can't figure out the real
> + * system register name
> + */
> +static const char *const generic_sreg_names[256] = {
> +    "S000", "S001", "S002", "S003", "S004", "S005", "S006", "S007",
> +    "S008", "S009", "S010", "S011", "S012", "S013", "S014", "S015",
> +    "S016", "S017", "S018", "S019", "S020", "S021", "S022", "S023",
> +    "S024", "S025", "S026", "S027", "S028", "S029", "S030", "S031",
> +    "S032", "S033", "S034", "S035", "S036", "S037", "S038", "S039",
> +    "S040", "S041", "S042", "S043", "S044", "S045", "S046", "S047",
> +    "S048", "S049", "S050", "S051", "S052", "S053", "S054", "S055",
> +    "S056", "S057", "S058", "S059", "S060", "S061", "S062", "S063",
> +    "S064", "S065", "S066", "S067", "S068", "S069", "S070", "S071",
> +    "S072", "S073", "S074", "S075", "S076", "S077", "S078", "S079",
> +    "S080", "S081", "S082", "S083", "S084", "S085", "S086", "S087",
> +    "S088", "S089", "S090", "S091", "S092", "S093", "S094", "S095",
> +    "S096", "S097", "S098", "S099", "S100", "S101", "S102", "S103",
> +    "S104", "S105", "S106", "S107", "S108", "S109", "S110", "S111",
> +    "S112", "S113", "S114", "S115", "S116", "S117", "S118", "S119",
> +    "S120", "S121", "S122", "S123", "S124", "S125", "S126", "S127",
> +    "S128", "S129", "S130", "S131", "S132", "S133", "S134", "S135",
> +    "S136", "S137", "S138", "S139", "S140", "S141", "S142", "S143",
> +    "S144", "S145", "S146", "S147", "S148", "S149", "S150", "S151",
> +    "S152", "S153", "S154", "S155", "S156", "S157", "S158", "S159",
> +    "S160", "S161", "S162", "S163", "S164", "S165", "S166", "S167",
> +    "S168", "S169", "S170", "S171", "S172", "S173", "S174", "S175",
> +    "S176", "S177", "S178", "S179", "S180", "S181", "S182", "S183",
> +    "S184", "S185", "S186", "S187", "S188", "S189", "S190", "S191",
> +    "S192", "S193", "S194", "S195", "S196", "S197", "S198", "S199",
> +    "S200", "S201", "S202", "S203", "S204", "S205", "S206", "S207",
> +    "S208", "S209", "S210", "S211", "S212", "S213", "S214", "S215",
> +    "S216", "S217", "S218", "S219", "S220", "S221", "S222", "S223",
> +    "S224", "S225", "S226", "S227", "S228", "S229", "S230", "S231",
> +    "S232", "S233", "S234", "S235", "S236", "S237", "S238", "S239",
> +    "S240", "S241", "S242", "S243", "S244", "S245", "S246", "S247",
> +    "S248", "S249", "S250", "S251", "S252", "S253", "S254", "S255",
> +};
> +
> +static const char *sreg2str(uint8_t reg)
>   {
> -    if (reg < TOTAL_PER_THREAD_REGS) {
> -        return hexagon_regnames[reg];
> +#ifndef CONFIG_USER_ONLY
> +    if (reg < NUM_SREGS) {
> +        return hexagon_sregnames[reg];
>       } else {
> -        return "???";
> +        return generic_sreg_names[reg];
>       }
> +#else
> +    return generic_sreg_names[reg];
> +#endif
>   }
>   
> -static const char *creg2str(unsigned int reg)
> +/*
> + * Used when there is some sort of error and we can't figure out the real
> + * control register name
> + */
> +static const char *const generic_creg_names[256] = {
> +    "C000", "C001", "C002", "C003", "C004", "C005", "C006", "C007",
> +    "C008", "C009", "C010", "C011", "C012", "C013", "C014", "C015",
> +    "C016", "C017", "C018", "C019", "C020", "C021", "C022", "C023",
> +    "C024", "C025", "C026", "C027", "C028", "C029", "C030", "C031",
> +    "C032", "C033", "C034", "C035", "C036", "C037", "C038", "C039",
> +    "C040", "C041", "C042", "C043", "C044", "C045", "C046", "C047",
> +    "C048", "C049", "C050", "C051", "C052", "C053", "C054", "C055",
> +    "C056", "C057", "C058", "C059", "C060", "C061", "C062", "C063",
> +    "C064", "C065", "C066", "C067", "C068", "C069", "C070", "C071",
> +    "C072", "C073", "C074", "C075", "C076", "C077", "C078", "C079",
> +    "C080", "C081", "C082", "C083", "C084", "C085", "C086", "C087",
> +    "C088", "C089", "C090", "C091", "C092", "C093", "C094", "C095",
> +    "C096", "C097", "C098", "C099", "C100", "C101", "C102", "C103",
> +    "C104", "C105", "C106", "C107", "C108", "C109", "C110", "C111",
> +    "C112", "C113", "C114", "C115", "C116", "C117", "C118", "C119",
> +    "C120", "C121", "C122", "C123", "C124", "C125", "C126", "C127",
> +    "C128", "C129", "C130", "C131", "C132", "C133", "C134", "C135",
> +    "C136", "C137", "C138", "C139", "C140", "C141", "C142", "C143",
> +    "C144", "C145", "C146", "C147", "C148", "C149", "C150", "C151",
> +    "C152", "C153", "C154", "C155", "C156", "C157", "C158", "C159",
> +    "C160", "C161", "C162", "C163", "C164", "C165", "C166", "C167",
> +    "C168", "C169", "C170", "C171", "C172", "C173", "C174", "C175",
> +    "C176", "C177", "C178", "C179", "C180", "C181", "C182", "C183",
> +    "C184", "C185", "C186", "C187", "C188", "C189", "C190", "C191",
> +    "C192", "C193", "C194", "C195", "C196", "C197", "C198", "C199",
> +    "C200", "C201", "C202", "C203", "C204", "C205", "C206", "C207",
> +    "C208", "C209", "C210", "C211", "C212", "C213", "C214", "C215",
> +    "C216", "C217", "C218", "C219", "C220", "C221", "C222", "C223",
> +    "C224", "C225", "C226", "C227", "C228", "C229", "C230", "C231",
> +    "C232", "C233", "C234", "C235", "C236", "C237", "C238", "C239",
> +    "C240", "C241", "C242", "C243", "C244", "C245", "C246", "C247",
> +    "C248", "C249", "C250", "C251", "C252", "C253", "C254", "C255",
> +};
> +
> +static const char *creg2str(uint8_t reg)
>   {
> -    return sreg2str(reg + HEX_REG_SA0);
> +    uint8_t gpr = reg + HEX_REG_SA0;
> +    if (gpr < TOTAL_PER_THREAD_REGS) {
> +        return hexagon_regnames[gpr];
> +    } else {
> +        return generic_creg_names[reg];
> +    }
>   }
>   
>   static void snprintinsn(GString *buf, Insn *insn)
> diff --git a/target/hexagon/gen_printinsn.py b/target/hexagon/gen_printinsn.py
> index d5f969960a..cf1a12adbc 100755
> --- a/target/hexagon/gen_printinsn.py
> +++ b/target/hexagon/gen_printinsn.py
> @@ -28,13 +28,14 @@
>   ##     Generate data for printing each instruction (format string + operands)
>   ##
>   def regprinter(m):
> -    str = m.group(1)
> -    str += ":".join(["%d"] * len(m.group(2)))
> -    str += m.group(3)
>       if ("S" in m.group(1)) and (len(m.group(2)) == 1):
> -        str += "/%s"
> +        str = "%s"
>       elif ("C" in m.group(1)) and (len(m.group(2)) == 1):
> -        str += "/%s"
> +        str = "%s"
> +    else:
> +        str = m.group(1)
> +        str += ":".join(["%d"] * len(m.group(2)))
> +        str += m.group(3)
>       return str
>   
>   
> @@ -142,11 +143,12 @@ def main():
>                       else:
>                           regno = ri
>                       if len(b) == 1:
> -                        f.write(f", insn->regno[{regno}]")
>                           if "S" in a:
>                               f.write(f", sreg2str(insn->regno[{regno}])")
>                           elif "C" in a:
>                               f.write(f", creg2str(insn->regno[{regno}])")
> +                        else:
> +                            f.write(f", insn->regno[{regno}]")
>                       elif len(b) == 2:
>                           f.write(f", insn->regno[{regno}] + 1" f", insn->regno[{regno}]")
>                       else:

