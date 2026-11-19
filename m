Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DEA60A2600
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oppeNEyG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AwglXv/m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAEu-0001vv-Q5; Thu, 19 Nov 2026 17:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUAEt-0001vY-73
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:04:19 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUAEp-0003m0-5h
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:04:18 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1G8e373592
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x3KrCt+tVCIFq7hbYgNEkj7ptwrh+KdVN5hpvEfRS8s=; b=oppeNEyG9CI/HAIC
 Than3zjmkktyZSzD4QY8HWu7e/Bo9z7H0qlZeHn9dWuNopNDSIdLhU36KBYcV50v
 oBd5SqaODUIiCZMaxROWqJ9RKCCoH2FJ49lBCAnHhDACvPncK6BEiXsk1Wq63j7c
 KYGzUtNR3quG6cVWjNJaPFkgc1Ddo4LJpRbwRNJjWab4nspVm5tyKRXY2VaCdmmk
 V3fW3AAJlKZ9Cga/tP0O4d1Lth0KfWn61jNVroXIf4ptRT2nz5iDqtL9c6L4oR5q
 m8z3pvdh6Zkigo10JIm/s67cv/xRevPEzmCQC2z5glTA0MPNlNnUjk3Ll8T2LQkf
 irs/jA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xymkb4b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:04:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-949b0d322fbso44456585a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795125845; x=1795730645; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x3KrCt+tVCIFq7hbYgNEkj7ptwrh+KdVN5hpvEfRS8s=;
 b=AwglXv/mxiUeq+JJP6xHZvrDtKLGUGeypgCHXyXD6T/QIzm8KGb+l39bBWTiE/AcPL
 SFcYMIyCUdewTYlQAr2OeA5qwkrQsu1rImPUrstOfkI7sMVw7bshahxJnlJfNSoUQ+J5
 cMCSgAt9RmGeyTwyYcBTQUPTxBpMYqaErjoKKGHEzjpviK2NhRU/Ai4IPtdT+un1FwY8
 vqBazic4CT4mxZBT5sXKGBoo3/xYN5Zub5cdv5zFqrASlAdjreR1fpLPmfnUC0eG6l3q
 3dKKTu0hxhcFgek6lsRsWghrGv9F+4iTt4j9Zhy68tq+041lEhEC9E+a8IkO+zDiqqe/
 DC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795125845; x=1795730645;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x3KrCt+tVCIFq7hbYgNEkj7ptwrh+KdVN5hpvEfRS8s=;
 b=icRBrEKC/C0eq2XSOBDiwzXchzQ2PEdhFWU5bBUWUmX1QPY6EuDY5Zns9w8i4azZIm
 SPfRmhrSb26xkLbTvw8J7xyWm8S/ffVBshzkueWJc1CgXD883LzaebEmeUYtNJ9YAh6t
 rzTBRgt6kQ1WgW3zUikFgllWbJnS6UYv2QaSBLga2eqwUYTpQeVFLfW1eWj8LAfkNugr
 px3KBUr5Q9lRyZIFGOdR1A/0z2s94529ddB657KPoPq/08nylDQAn+EHVE8Wb773jXy1
 q+jUdTHFtbwf68pv2bTlJnSg0hssOP1BlnbU/czCl/GZ42N1PcN0Z2/Nwy8Vk+okQ9RK
 6uLw==
X-Forwarded-Encrypted: i=1;
 AL+hErEbBiMAffBuELRia3k9ckA4dYQySPtz/mGXBKlt5coVd0DXCj9yp19X/h4fRpc+NTDnFWvK/NRwb9Un@nongnu.org
X-Gm-Message-State: APuU4Z/o+D6gOWZhnMXWYhhemiDlq0dlNNDlAuiamDtUuEKQjEpp60+W
 0SQYENxXIIrjIyqYt6xbKbRN5hAC/mLIi/A/EM+wfu/YKeHG7bsEH2/AZh6wFgwpU9mF/w3qyZQ
 VYi1xllMswGJOQJb4AigeLijROQwqmKwBZD4sVNmwcj3uTJv4BOY2KaPnPg==
X-Gm-Gg: AYBFou2s61pntvDmO9t2SPj/lRzy3PxZnvdZvwO93QR8st7B2PNwn7IsMJG7cMtobV3
 +1Q6ozAbzhHrtNhF4zLd4nmCr9t1dTrXgHQCkSqUqMqJRoK/1fm/7019fB04KGyWtiGkHAv7L38
 RE87jpHTuubIZHw+ydwbYbg/zdKMZm/46WPpAa8T4HPGUVPC5/XPTdDt5j6yIJRxtmZY48RNxY2
 TQ27+WVtuasJaWRiBjM1ho03p5vhZq2Z5A9rGdDxq/76I+FNOWO85QZmZzb5yYe38ATuaWid7H3
 EW4C9xn0gyMD04mfIBWwf8/YEqSmPxyhzbji/iT6F0wthtjy5RIlWYbpSxmXWN/WfuhFKmB4aSF
 7bQ2YbC1qa9PbWMV8Kh8we+e5Vc5CxC35xpwpFyqSWu66ojgaiL0X2zSaZrjE9PYM7ukWjblNbL
 23WNJhdGSPxhfDBoYrsziv5uPxsX/SIvEsZW/BGg==
X-Received: by 2002:a05:620a:1d0b:b0:93f:1dbf:6cfc with SMTP id
 af79cd13be357-949ba9a0514mr170828685a.36.1795125844621; 
 Thu, 19 Nov 2026 14:04:04 -0800 (PST)
X-Received: by 2002:a05:620a:1d0b:b0:93f:1dbf:6cfc with SMTP id
 af79cd13be357-949ba9a0514mr170822985a.36.1795125844076; 
 Thu, 19 Nov 2026 14:04:04 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb3f5c31sm56976085a.30.2026.11.19.14.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 14:04:03 -0800 (PST)
Message-ID: <46626cb1-d69d-49c1-ba65-52626a10fdc4@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:04:00 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] target/hexagon: reject HMX operands outside VTCM
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
 <20261119215853.987158-5-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261119215853.987158-5-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfXxRaRq4MYSd5c
 iiKsMJpbueypVBwvEb9FP9ynL5ztdlaBmqQCgvKsuSi1V79EqavG48CTI78q4OStTk6dqvqzvmY
 hO1Eb60M/6AvK6DWisN+5M4jp/ZuIxg=
X-Proofpoint-GUID: NW9JKQiHSQB_h6ntqZehQIC0OrNrtIaO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX3WgAhprlfvZc
 vctFdJT8vUpbNR73mKiwXlMGkYqiVERB1UNKanvKIAq9SEt6Gaa9T64CqSTT5FTy9q0Ctsr4dkm
 DNmLaCp9kd700C19BRWKrz9W3SuWMFzzmNDepUBwTYtbydWj/czCll2J6nKoCoRWl4ePimzLWrP
 gUia0mQf4OOawm1K/xvyFEFw/O/taiqgEHlmfY52E+knDJympppgAqy6zOVKogNv1in6vG7DV5Y
 bi6dxkze+os1amNlluvVkGFHbdr7S1koZARoYIw194YWRE/sV8Emng0qyquYW30wWO1o/7Nq2Eb
 iaHBRImv8SHnazi9v8Qn7hdNc9DJxSD1Bnkp0DupVJqhM1cRzqGuXdsFEnCcn6uH41m1qcyZ9s7
 Vmt3juVpELreypUcnL30QFxIoYyA9otmRP7u6RnNxvmyAJWJeiLSgab8ok7Mvlxx74xUE3icSTh
 nGSy0oFe6e8HRWvaFVg==
X-Proofpoint-ORIG-GUID: NW9JKQiHSQB_h6ntqZehQIC0OrNrtIaO
X-Authority-Analysis: v=2.4 cv=WKPqzXsR c=1 sm=1 tr=0 ts=6aff7255 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pDogMYiuAl29jsfYAhoA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190088
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


On 11/19/2026 3:58 PM, Marco Liebel wrote:
> Check activation and weight addresses against the machine VTCM range
> before executing packet instructions. An invalid operand raises the
> precise coprocessor VMEM address error and prevents packet commit.
> HMX arithmetic remains unimplemented.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   hw/hexagon/hex-subsys.c      |  4 ++++
>   include/hw/hexagon/hexagon.h |  2 ++
>   target/hexagon/cpu.c         |  2 ++
>   target/hexagon/cpu.h         |  2 ++
>   target/hexagon/translate.c   | 26 ++++++++++++++++++++++++++
>   target/hexagon/translate.h   |  4 ++++
>   6 files changed, 40 insertions(+)
>
> diff --git a/hw/hexagon/hex-subsys.c b/hw/hexagon/hex-subsys.c
> index 52ec0cadac..d2e095bb91 100644
> --- a/hw/hexagon/hex-subsys.c
> +++ b/hw/hexagon/hex-subsys.c
> @@ -181,6 +181,8 @@ void hex_subsys_create(HexagonCommonMachineState *hms,
>                              sizeof(m_cfg->cfgtable), m_cfg->cfgbase,
>                              &address_space_memory);
>   
> +    hms->vtcm_base = (uint64_t)m_cfg->cfgtable.vtcm_base << 16;
> +    hms->vtcm_size = (uint64_t)m_cfg->cfgtable.vtcm_size_kb << 10;
>       if (m_cfg->cfgtable.vtcm_size_kb > 0) {
>           memory_region_init_ram(&hms->vtcm, NULL, "vtcm.ram",
>                                  m_cfg->cfgtable.vtcm_size_kb * 1024,
> @@ -204,6 +206,8 @@ void hex_subsys_add_cpu(HexagonCommonMachineState *hms, DeviceState *cpu)
>       Object *hmx;
>   
>       object_property_add_child(OBJECT(hms->cluster), "cpu[*]", OBJECT(cpu));
> +    qdev_prop_set_uint64(cpu, "vtcm-base", hms->vtcm_base);
> +    qdev_prop_set_uint64(cpu, "vtcm-size", hms->vtcm_size);
>       object_property_set_link(OBJECT(cpu), "global-regs",
>                                OBJECT(hms->glob_regs), &error_fatal);
>       object_property_set_link(OBJECT(cpu), "tlb", OBJECT(hms->tlb),
> diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
> index 2ca4a518db..a856651fba 100644
> --- a/include/hw/hexagon/hexagon.h
> +++ b/include/hw/hexagon/hexagon.h
> @@ -187,6 +187,8 @@ struct HexagonCommonMachineState {
>       MemoryRegion cfgtable_rom;
>       uint32_t cfgtable_data[HEXAGON_CFGSPACE_ENTRIES];
>       MemoryRegion vtcm;
> +    uint64_t vtcm_base;
> +    uint64_t vtcm_size;
>       DeviceState *cluster;
>       DeviceState *l2vic;
>       DeviceState *qtimer;
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 3575b31d19..effa95534b 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -69,6 +69,8 @@ static const Property hexagon_cpu_properties[] = {
>       DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
>                        HexagonTLBState *),
>       DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 0xffffffff),
> +    DEFINE_PROP_UINT64("vtcm-base", HexagonCPU, vtcm_base, 0),
> +    DEFINE_PROP_UINT64("vtcm-size", HexagonCPU, vtcm_size, 0),
>       DEFINE_PROP_LINK("l2vic", HexagonCPU, l2vic,
>                        TYPE_HEX_L2VIC_INTERFACE, HexL2VicInterface *),
>       DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 5739254f1f..1eb6c7d8bf 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -248,6 +248,8 @@ struct ArchCPU {
>       HexagonHMXContextState *hmx_ctx;
>       HexagonTLBState *tlb;
>       uint32_t boot_addr;
> +    uint64_t vtcm_base;
> +    uint64_t vtcm_size;

This is semantically clearer as hwaddr.

Also - IMO better to qualify the size to make the units more explicit 
s/vtcm_size/vtcm_size_bytes/

>       HexagonGlobalRegState *globalregs;
>       uint32_t htid;
>       HexL2VicInterface *l2vic;
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 10ed73590c..3601c4e9f3 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -149,6 +149,20 @@ void gen_precise_exception(int cause, uint32_t PC)
>                                  tcg_constant_i32(PC));
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +static void gen_hmx_check_address(DisasContext *ctx, TCGv_i32 address)
> +{
> +    TCGv_i64 offset = tcg_temp_new_i64();
> +    TCGLabel *valid = gen_new_label();
> +
> +    tcg_gen_extu_i32_i64(offset, address);
> +    tcg_gen_subi_i64(offset, offset, ctx->vtcm_base);
> +    tcg_gen_brcondi_i64(TCG_COND_LTU, offset, ctx->vtcm_size, valid);
> +    gen_precise_exception(HEX_CAUSE_COPROC_LDST, ctx->pkt.pc);
> +    gen_set_label(valid);
> +}
> +#endif
> +
>   static void gen_exec_counters(DisasContext *ctx)
>   {
>       tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_PKT_CNT],
> @@ -946,6 +960,16 @@ static void gen_start_packet(DisasContext *ctx)
>           gen_precise_exception(HEX_CAUSE_NO_COPROC2_ENABLE, ctx->pkt.pc);
>           ctx->hmx_check_emitted = true;
>       }
> +    if (ctx->pkt.pkt_has_hmx) {
> +        for (i = 0; i < ctx->pkt.num_insns; i++) {
> +            Insn *insn = &ctx->pkt.insn[i];
> +            if (GET_ATTRIB(insn->opcode, A_HMX) &&
> +                (GET_ATTRIB(insn->opcode, A_PAIR_1OF2) ||
> +                 GET_ATTRIB(insn->opcode, A_PAIR_2OF2))) {
> +                gen_hmx_check_address(ctx, hex_gpr[insn->regno[0]]);
> +            }
> +        }
> +    }
>   #endif
>   }
>   
> @@ -1583,6 +1607,8 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
>       ctx->hlx_coproc_enabled = hex_cpu->hlx != NULL &&
>                                 hex_cpu->hlx->contexts_bitmap != 0;
>       ctx->hlx_check_emitted = false;
> +    ctx->vtcm_base = hex_cpu->vtcm_base;
> +    ctx->vtcm_size = hex_cpu->vtcm_size;
>   #endif
>       ctx->branch_cond = TCG_COND_NEVER;
>       ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index c988c85f33..aaafcb0954 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -114,6 +114,10 @@ typedef struct DisasContext {
>       DECLARE_BITMAP(lregs_updated_tmp, NUM_LREGS);
>       bool hmx_coproc_enabled;
>       bool hmx_check_emitted;
> +#ifndef CONFIG_USER_ONLY
> +    uint64_t vtcm_base;
> +    uint64_t vtcm_size;
> +#endif
>   } DisasContext;
>   
>   bool is_gather_store_insn(DisasContext *ctx);

