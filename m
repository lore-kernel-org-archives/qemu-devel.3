Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD718CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMPzk-0006E9-VX; Mon, 11 May 2026 08:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMPz3-00065s-FV
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:43:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMPz1-0005qK-DM
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:43:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B8I72P1850699
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 12:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gIPR3Y+KaCbWzg+QQuth98EVIhAhjyDGBJQUloYKHJ4=; b=HXpdCYLXSNeBIxBl
 vhG+uyhjoSrZa8mMcrIcWhO8y7brwviHRr/sUzx/nC3g3tMdDQuF0J+l/rETnM2u
 Atu9dP4rtytmrBucn4HLDljx5uKY7nNLY0iUHoYsFUeWHSGZn44fNX+hfyyLrc1G
 Wxaaq51+UsoW7sLp3wJ4m9AaPe0aHvFlD7U9VSaLGMcpn6sNh17X+v1HG9GHNAdu
 4Rn3PzHktLJkA24yqJyn/S/JrH2D5cga3JqWOnxMK0FFVu60ylnOYSJ4m4EYXedz
 cebxbhT2XEing8Sc6BRE955Xf0j3OF4Xu4Miv5NHGuncOJ7Uksm/ba8AruHD0Xcz
 v8t8kQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3bfvgwm0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 12:43:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-902e74da582so1092513985a.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778503416; x=1779108216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gIPR3Y+KaCbWzg+QQuth98EVIhAhjyDGBJQUloYKHJ4=;
 b=b6RtR5FlR/ju2APk7bfea3FL8xEWYaRupRHDuLrzqbEc8b4Uy+tvowpn5+5sHw/rQf
 GK9MVM/TBPD18ZvE+NuewJ+voQNWSMLCxJN7V9fDISM5Is1i4SIb02g6B4UwZB5UOV6i
 rzE0JvqQq6K6bHGtlkJEZG+pwDvFNYt2uBOciDpUUxnvWQpAYZcCQD76BBF/HnB9UwPU
 Hw53+NfBA+IDLVdDW9iN+82hFJG2X0YIAe3/xE8Ic0Ceu27BlSpr6bZ+Q/I22oILZQ/1
 3+w1oOFKiF9eFKNQbWz8+q+pYNjQMI4Up/KHIPIms0+MUbNxdSGSDlR5our4jpJMGoL7
 bmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778503416; x=1779108216;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gIPR3Y+KaCbWzg+QQuth98EVIhAhjyDGBJQUloYKHJ4=;
 b=UQZWpgxvDpFJGZVEwRurCcB9yavnJgUb7noTcTbp4LpgCC26VDj3WUoIbt3lbbSOrb
 3Lj0rndNynfxaaP7DYKldhp1x5oVQyCAUl80GT9wveWIwrtfDZCX35VFC7/EPM8tIBGk
 bP87qmGkb4s2TiNMp7b4456Nn+mBwaKq5oZstO7zgqVWG42UWrJeNmj5O3DcKDz/6ey5
 Ta6A+FEimNQRpLUtacSEwtFkJ9Iud0LILcj2Ue9DkMycRWXDIXlBouRFfYQncjtfe/LY
 DawJH80yiWfv1MX0xdZ3xu/fcOYe1xRYbjXsUkzfk4T+tKUfJtL4E15w4M78ktl4KMAi
 r87A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+X50QJpSv9HASvxmrHm6hubbfY9jv9p0ZY0hsN/9PLlTJxiN0thPbtmRuZ8z5ev+Li59+UD9tg7uxF@nongnu.org
X-Gm-Message-State: AOJu0Yzc8AtfkCQeipniQ0G3FtO3TSNEtIHEsyBavMPlZeiO7P/prVK6
 4MZz1Nc55mSxGGgGFrpvgF5hS0MSL5plcyJllJ5OEMF8nEO0nsRKwYVsf6FAQPsTHUjrXyXy13g
 gfDysFsTDt4WyezYWPWf72FtANNH7mIRs9qtBHyFdbA1kyTgszg77OnAfjA==
X-Gm-Gg: Acq92OFDem+qClGfc+6ktJWGm9fqJmHVV8+f0a4JQNRWnI/rkf2flQRenAOwUNC7rAf
 qC8gbGS5QDWjWV3+0rzmg6l9jlS6YYJ+5IY1B9wR7v6MPpJF6TwmNkxSCO9JECXWqgnNfGlaDN1
 e+zEHMAYD5hQSVwXbLbuAZs94fBdR0up1qOoWexMN+hRHiw324a3sknZxqU0ZOdivF875iVXMEu
 5jD6YtUa6PlA3AzQM170EVUK0CgoEB5j0+jA+nf6z05fP4bDQ+xZTxa3uE0nvNpOnc4KKbMMQyv
 khDvaDLWE4SZmp7bB6uhyqDju+0LqzmV1rSJ0lGmgfmnLgzA/d+sRkxyWIAgcRsPZTxR50b/BmL
 VC66mwLaSMF83m/GV9XY0OlD43VW2eqHTrFuME4OxAxtK61qKTXTNZ9H0Z/0=
X-Received: by 2002:a05:620a:c42:b0:8ef:2a7a:e6f8 with SMTP id
 af79cd13be357-904d69d8efcmr3453232385a.50.1778503416056; 
 Mon, 11 May 2026 05:43:36 -0700 (PDT)
X-Received: by 2002:a05:620a:c42:b0:8ef:2a7a:e6f8 with SMTP id
 af79cd13be357-904d69d8efcmr3453226985a.50.1778503415386; 
 Mon, 11 May 2026 05:43:35 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc2c91cd89sm3143829485a.35.2026.05.11.05.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 05:43:34 -0700 (PDT)
Message-ID: <052b8337-0f24-488a-99de-982b2c1e492c@oss.qualcomm.com>
Date: Mon, 11 May 2026 09:43:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv/pmp: Fix integer overflow in TOR and NA4
 address computation
To: Zishun Yi <vulab@iscas.ac.cn>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <7dc52ffd-97e3-4c41-8cde-e79dd4bd2485@oss.qualcomm.com>
 <20260511102627.3120140-1-vulab@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511102627.3120140-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Fa4HAp+6 c=1 sm=1 tr=0 ts=6a01cef9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7WufM6Q2AAAA:20 a=EUspDBNiAAAA:8 a=HDD6Hz0iNlxWkWEJPagA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: F_ceQaC4Lsj-RM6o-VD6BfCJWPeJgbsN
X-Proofpoint-ORIG-GUID: F_ceQaC4Lsj-RM6o-VD6BfCJWPeJgbsN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0MSBTYWx0ZWRfX+AkaKfCsCZ3t
 /6O21xPCwRyTDQNEE1F+lCMin98UbWXxoVH1r3teMRbRPVGrnpOiyg6yeFlOWtRg7N3RTgsxgv6
 vkQ3y5x0sIbLVYZ7mtgDIFKTpQR+kdAcR74ESIDTMMDr8sA4/hY2bhUR2by4hP4Leu9Isfi9yhw
 l3PxmVeqAaxEVMqraohZpWced+kPCDnwuYIFF9u03fwXWkN3Fo5splsO8/BS4VhrDzZjZomeNhi
 xBbZF674tLCMG8tGaKrlntqtuLskWJLyc6avST9Ug02TtcF4WpmQl5HWxlW41ltXk5GMLRemWKE
 5W6dprfVptzSesHI2cHBBrrhLeVfR0zcfW8aFOkxOfNOt1qFiSRJUdtEZver1sPC0pP7ScvO2ZC
 //Uzt1BcctVGWWBvOHRikfpqFaxtx57kg0k4pTg67NCzpZyCLPX/zpaSU4Q6NyTPsSl4A12Ssx1
 2bu6GnCPA3oLNl56D2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110141
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



On 5/11/2026 7:26 AM, Zishun Yi wrote:
> According to the RISC-V Privileged Manual: "The Sv32 page-based
> virtual-memory scheme described in sv32 supports 34-bit physical
> addresses for RV32, so the PMP scheme must support addresses wider than
> XLEN for RV32."
> 
> However, the current QEMU implementation uses `target_ulong` (which
> resolves to `uint32_t` on RV32) for PMP address variables.  When
> shifting these addresses left (e.g., `this_addr << 2`), an integer
> overflow occurs, truncating the high bits of the 34-bit physical
> address.
> 
> Fix this issue by changing the types of PMP address variables
> (`this_addr` and `prev_addr`) to `hwaddr`.
> 
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
> 
> Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2472/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> Changes in v2:
> - Changed the types of `this_addr` and `prev_addr` to `hwaddr` instead
>    of using inline casting, by Daniel's suggestion.
> 
>   target/riscv/pmp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 5391caa59c7d..a71091a316e0 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -227,8 +227,8 @@ static void pmp_decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
>   void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
>   {
>       uint8_t this_cfg = env->pmp_state.pmp[pmp_index].cfg_reg;
> -    target_ulong this_addr = env->pmp_state.pmp[pmp_index].addr_reg;
> -    target_ulong prev_addr = 0u;
> +    hwaddr this_addr = env->pmp_state.pmp[pmp_index].addr_reg;
> +    hwaddr prev_addr = 0u;
>       hwaddr sa = 0u;
>       hwaddr ea = 0u;
>       int g = pmp_get_granularity_g(env);


