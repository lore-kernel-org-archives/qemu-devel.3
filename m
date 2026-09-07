Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D6BC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Z2S-0001ho-Rk; Mon, 07 Sep 2026 09:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Z2P-0001gx-BB
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:05:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Z2M-0005F5-1u
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:05:29 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687Amron3872679
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 13:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cAjzyiuILn6+OaeltpkP/1uSU4XGR9Q/WoMJDwLAAro=; b=hR94l22sgTpgYT6y
 5EnDu4EP+22zLAkWAdBInwNrvw2TOfQb/0jEMJuGZOBsQHASh1RpeR8QwmE+/hxt
 o3KTJjbbmm00YX+UtENsUL6GaMDlHre8WW4en+dOOunOSRlhkr2lg0Qa/+NXnY3R
 tdV60LRl5EJuCXCnmtN0v/o5zuiZDe41+7RwkNcYH11OpbAQYEU3pWQSGMRzkJCY
 pUaCinNn/dj+qPbzNL93Lwq/aZVpZz6LOP5LQrmt8UwHwzpnBgN5iLBRse1bRiP2
 UssN9AxB/fAqepitc3QOp0UaCRKDzx3TsEHoFrOVheyJz69iMo2Ejk+icWpnOD7/
 BoQ1ig==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghnmj246w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 13:05:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e820609d9so580417285a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788786322; x=1789391122; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cAjzyiuILn6+OaeltpkP/1uSU4XGR9Q/WoMJDwLAAro=;
 b=BYTY++cqioRscfv5By0NSDZC0YsA7BS1FV2RVBn9E993buuzS7ihM6i/5wsHGiZ02r
 BKnGAWG0FP73d7bumm5YC0OUeKtONIxT6XmHawCoybZj8SfQOHu87LcReQlo/HAG2NKM
 ehtPNlaMZDuzYamG9GU5K1PEZkD+Lyxw7XDGpCzAj1851whvovGex+QtW6PkRAJdZsjo
 EuNBURBaZPhBjkNhKpMoJzhcqu8IsB11JgZR99gPxpVhOdFnU7DfN2/U3ze2eNl+txJ4
 9irrwtTBl9i+pIZYqhV1TIJIpmWa+MB/0qqBC5P9Yk5cMlyIh1xAZcbv2kF1mbAGxqCW
 Bd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786322; x=1789391122;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cAjzyiuILn6+OaeltpkP/1uSU4XGR9Q/WoMJDwLAAro=;
 b=LTOnqDnAUxByD+xBBRz5ewU0y3GevpaO5JPmFuBz3FxuFJWx/PnV1dQQjDDn2Tt431
 Sr9SKgTqH2/iO8UaD2vmOZsAu0EOrM9s0szCFm5B+2wMXp0PnUWbBLEB7P7HiPxyESWp
 gskUdcd+hKAvq+PT+hm8tMLVs2X8uvtYPfIFRGQbXBYJtoNtj3Qw7ds12cmBbArKJTJ8
 YvG8Zulv2/qYZXNBKDSx+mvYsW5uQaNf/T0CdbIAUNkWD/MQaBTI7C/XLJNRIeK62GvO
 NdPqBLtxwlrtshu0NRXo8+sSLTHuCoqdNUjdAJo1Kg4hj9fPRQ+wz2mxBdcSNuJ0OoQr
 QXLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/LJI1Ai7/cs2bdvk5p0DFmGqKsU4R4K+FR0TiQCsJyAxloJOfOytb6gOykhWUCejQ5/qmxsH5ZryJ@nongnu.org
X-Gm-Message-State: AFuF++m6GycD3J/SvHF9MJrnBNzmTU7rNAjHGotD+oTEYgZ2JYYHMrKh
 tiql0hRyD/nuKk7QRjb6WjEULW0QkBA7LasOUXxMd+SWbQzDARjpccVffiaSr5l0CckvX+G/z7O
 5ft6xTQAJIF4UEs0ULgfIo+7853MUyjYo39iIV41XcpczHmb7exe/e/elrQ==
X-Gm-Gg: AYBFou0DlTL/K7VBjWZ4CYGayiJ7Ln7CtCIupSLBIOYb2xogw0aRQg7hUfl6nokbfSd
 S/HIO2eeZj/zWjWXfOpsfpgPLdwGMa8upDs/IDX0Us6xluyuMopfbsdHhzrcFjEXTUTK648rHyx
 dPAQkvGBkSEskGA9iJJAVxrC5IB/Ersfk0KxNkVN2EELBd4RvZvEia8qZfC0deCcHREg6wZPWrD
 sgg5ikDjC3PjJzbjsWxUtxhfrIWJD7/CfbDeP6MNIDhPc48Yswg/3MHrJt7qrV09SPiClb5uwji
 XdkJUiqZu2+lSAuQiyYfR6JcSf2MLt0G8toNOAdHmghDowStifilpMxy7b0grGQrokgTvo2R4Rv
 SQpltTvEBx45lf1MnBFEpWhWd295rfufRgkc=
X-Received: by 2002:a05:620a:870d:20b0:939:6df9:1278 with SMTP id
 af79cd13be357-939804c0ce4mr1904643485a.51.1788786322422; 
 Mon, 07 Sep 2026 06:05:22 -0700 (PDT)
X-Received: by 2002:a05:620a:870d:20b0:939:6df9:1278 with SMTP id
 af79cd13be357-939804c0ce4mr1904632785a.51.1788786321946; 
 Mon, 07 Sep 2026 06:05:21 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939b871742esm10173285a.39.2026.09.07.06.05.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 06:05:21 -0700 (PDT)
Message-ID: <ce444959-912c-47e2-867c-db011473d806@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 10:05:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/riscv: extract check_sfence_vma() from
 helper_tlb_flush()
To: Trevor Gamblin <tgamblin@baylibre.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
 <20260904-riscv_tlb_page_flush-v2-1-defec3f29312@baylibre.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260904-riscv_tlb_page_flush-v2-1-defec3f29312@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0NCBTYWx0ZWRfX8pMQpmaAwWT4
 pYL/4yyAcFm3XRzL3Yasz6CvBUtE2nS36x2xcgkN7Sc8BFlZbfMeOKAfBU/2/ZNMzuiTzOgmBj+
 B7xpjqdBhnQPasP6Je8a7FBqwqUGeycWdAglFLCYjaZWR07Ppmu97FlO1I/xsxw/90FFBza0ZoR
 mS+bgjgjMN6naYOAcnkczYO81CMKfX6GI7g3/dMjh1OXbOGXpIMPxeZ+3SN4nNFE/0E5mOYrZBR
 yTYTD1GqBLP0lev16ND2eS50OyCuxNChRBEf5Dp8Xb4wDWRhZVCLZ6UYVrIUtkx/txbvH5IZFTG
 8IOfvntvKkmfuyA+wURRsJKuzEjQxDZyW/gaEtDEQarpEma3QoYTAIw9lOMG0py6cAtPN16RIcM
 EoLUXbKpkL0kd+AwY+vvzghiDqKHK2c7GGMDU0YcBm+5DhkF8xx7tHMoOO9l84XiNXz0EgTakir
 PQlxe5wVMlQBGMd3Qlw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0NCBTYWx0ZWRfX2MJn/u5wcQqY
 sVtfSvPesFzyyINKa8OLzNAjPVbQIKaqK1/FQ51qZVQ/hjXZGrzvlQAavU34SfUrvzYncKyeGzy
 EojdZVhCuJa26t2Y3yRPAt/1MTR2aEM=
X-Proofpoint-ORIG-GUID: m0Wpo23xZqnYs4O6JB31Qi0pkHtYu06Q
X-Proofpoint-GUID: m0Wpo23xZqnYs4O6JB31Qi0pkHtYu06Q
X-Authority-Analysis: v=2.4 cv=LZYMLDfi c=1 sm=1 tr=0 ts=6a9eb693 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=fIT3gf-4d1xXVelyxpkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070144
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 9/4/2026 3:43 PM, Trevor Gamblin wrote:
> Create a new function to encapsulate the privilege/hypervisor checks
> performed inside helper_tlb_flush(). The idea is to pass GETPC() as an
> argument directly to it inside the helper_tlb_flush() function. We'll
> use this function in the following patch for helper_tlb_flush_page().
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/op_helper.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index 3e94005d2b..7f63f3ada5 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -588,21 +588,25 @@ void helper_wrs_nto(CPURISCVState *env)
>       }
>   }
>   
> -void helper_tlb_flush(CPURISCVState *env)
> +static void check_sfence_vma(CPURISCVState *env, uintptr_t ra)
>   {
> -    CPUState *cs = env_cpu(env);
>       if (!env->virt_enabled &&
>           (env->priv == PRV_U ||
>            (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)))) {
> -        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
>       } else if (env->virt_enabled &&
>                  (env->priv == PRV_U || get_field(env->hstatus, HSTATUS_VTVM))) {
> -        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
> -    } else {
> -        tlb_flush(cs);
> +        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, ra);
>       }
>   }
>   
> +void helper_tlb_flush(CPURISCVState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    check_sfence_vma(env, GETPC());
> +    tlb_flush(cs);
> +}
> +
>   void helper_tlb_flush_all(CPURISCVState *env)
>   {
>       CPUState *cs = env_cpu(env);
> 


