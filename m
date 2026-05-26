Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDBDCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 21:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRysd-0003sm-Ve; Tue, 26 May 2026 17:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wRysR-0003s3-LR
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:59:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wRysP-00083f-Tl
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:59:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QH0rTV3463896
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 20:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wvN8nkLLt1bUhXxjmlPS9eMIcJG3a7nVNnnr+Ei4jeA=; b=Ff+eAWeMdGydDBMN
 GrdSNzAp+F4M5o++C0V3sk3+6yGxR22N4zBbOE8GF1JpPH4S+M1+MoVQz5kqNg+3
 nHWxB6qMq1TvPI+VberUwbWJCGAplGlgw0WRSQeMPOoJ0hxq4Nz+/v5fzZ2sYebe
 lXpu0FRHkOc4+9PwHRI2G1C6V3qrQjc5ThPZvxdKv0XTEfMFiYma1GxaVeZgvOlZ
 xZNTUSn5sp9t06QQlSeYp/LslTutyTUpnOJgkFGsvbYEWBgulVIwsn8Ogel/GNV7
 7bDLGxCdMzca5B92prxmpyK2y4OWbR1yP5XrZcRXGZ/I7i+DQ7GaCuiWN+NGXtfO
 q99F4Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edenth4ne-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 20:59:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-516d09e77e6so110513431cf.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779829187; x=1780433987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wvN8nkLLt1bUhXxjmlPS9eMIcJG3a7nVNnnr+Ei4jeA=;
 b=Q2UKgkM8WKPvSHK7m8J6rYcsXftZJ4DDP+ICQ59PBr1wPRE8mPo72+LuuLB9Rmv1dF
 /RyQRP2TsThEJnzspC+CSWprTEAJ7M1f84hL1vtHlVaQrBu2D17B3njs0Is+D4jGI7o3
 YOTVWZz+IZp8/y3jZZ5VBOFnszkq9Km1EOxBeMdu/tGrxGs65/L2qRaKogQHrR83Emn1
 F3ODJTqicErz3UJfKTAd2Bl0FKLkOIclmqYkUyRvW44IWg1XSaSGzVwokNNYVx+BnlBJ
 QIwZt5sI90YNCT57qM/BTb2aPw19t2e4+QPUYEWWiwKCI+gmTYWFcr8C/7uRwOAfCfnZ
 MVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779829187; x=1780433987;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wvN8nkLLt1bUhXxjmlPS9eMIcJG3a7nVNnnr+Ei4jeA=;
 b=BlHKazokpZ6tJDKQDJlOh7If+JwAePOLs9LNnPaiA1e++E6vFGlrys5/DdqaBejZP5
 AwEoVLhIYAS2cAwy1y9/Z5CeSFuSQSxWBmnb3c8LCnHCvksKZCfD/1i1gxBp6UwcMDtQ
 fBau+56Sq1Iod84nk/fauLvs/9baPKrZPFgF7F9I4M1V3duVjTBglEFdoWpGzkE0tbP1
 Aauh6IM8ClrZiuyh0fzVrYeEKFI6QsP3C0c/Lfy7O+W+bMbJYnmLUQCJaKOGuGAX36BA
 SAaNnxtjklPU2MWJOLaGYRfC04JXicwOOmxrJs++1hjCKFAnn0egr9twDrPhjA41CnXd
 hcJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oKnvHyDucNMeFC5OMjbDKbYGNGMjM6sR/nMqOWiMdgCPOkOP5wQ2vF46KjsRrDiNXlNNO8KOP1dsH@nongnu.org
X-Gm-Message-State: AOJu0YxupKrtSdJwEyGuKsLDcChN0EbVoPjyCjQahf63QCBOUYRhcwgv
 F/mHNZNFyGOvmhXbuMH0R/d00M+QGHamRZab8ftItQY/5WOzU8cuZ1TLkAU1CVDi/uh9Ctbd+DO
 1LLQIzIFnCXe+KISQ9JkWZTtifvJX8Ai2GqF3GzHPO66WMCr6hDqBA/ikbA==
X-Gm-Gg: Acq92OF2ITdHEbW4nyTiT0wWmdvVU4A1oZxReqmZe0FaK+WbeGqhvpYmoQaSxcVf4rl
 TXa3Fk6sTkFVji8duamA3ahicIGjTaipUNfCwa20alOwDO/NEsdZ/0B1tdzA2BdukuDnJ23VONo
 rn94JgaykhwQrywRZp5EkTtkK8qevngJGDVbICJC+XIK9662ZPi15i+7dx1wkwOJPsnZPTtm2Ys
 j9ajakGBId8+Ziby24AKJ9yOhZ6qNdVQ3fLeMarn94DT8niMki8aRx5sDkx1iATy2UYyoE5GSRz
 OiJlSnol/vBwr6iZEp3pZ3B/pcjVrdwSkD48uRUrmmmasRdVCuesI3Bs0rb4l0Nz9H38K6wN6/f
 E/j8zwEFLlx8g+10vGB0cZXE7bo2KkUOgpkEuUWquIPTOSrspiHKK4TiNvOdNNvggm/v7AA==
X-Received: by 2002:a05:620a:a49c:b0:914:bfca:7d2e with SMTP id
 af79cd13be357-914bfca88ddmr1681005885a.60.1779829187353; 
 Tue, 26 May 2026 13:59:47 -0700 (PDT)
X-Received: by 2002:a05:620a:a49c:b0:914:bfca:7d2e with SMTP id
 af79cd13be357-914bfca88ddmr1681001285a.60.1779829186684; 
 Tue, 26 May 2026 13:59:46 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f881b620sm304980585a.42.2026.05.26.13.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 13:59:46 -0700 (PDT)
Message-ID: <ab46907d-167b-4793-b095-21ba0a661ba2@oss.qualcomm.com>
Date: Tue, 26 May 2026 17:59:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/riscv/spike: Use 'max' CPU type by default
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260526095731.63525-1-philmd@linaro.org>
 <20260526095731.63525-2-philmd@linaro.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260526095731.63525-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ja+Ma0KV c=1 sm=1 tr=0 ts=6a1609c3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kyYUaycaKFZj5IB2jSoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DF5owgFeiMGD9dT0GhGpZXmu3Jw1f-ru
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE4NSBTYWx0ZWRfX1VrVoMXKxIk4
 up/CApMb+baE7E53MPYlQAVOkAN6Enz0S0/IXZLhMWq6a9unTABHU3lF2ER/EVnCOB8nG/ab1t/
 YDRvS57MBV63eLytMJ9h7GZZVbboAruySnb90lDaTyo4yeI1oPQ0/L1kKEhYVno892XW2MDSC9d
 5QprEuy1YvMk3j1uq09JxWyoDACSuEniafxUf3kedg9KCc3HWp2Bgya10+aLXEx6NCvPzlIc17f
 jiy4Y8+O3AxjdalpTDblqHR57Gt/hAWQ/wrP/X32uM0pW81VCkhExAXRGV2MbWF3DcsQI8EGQ4C
 6wB9GiIBoL4+Kndb00xkbmempy8fvWXh8yFcL82FIaJHGZC7ydHiTvdi5qs3bKyPob1QVMOFtGk
 wQTJ0w2KbgAAKi0NMg4D5CQ49eYlVH0Duo6Q0xe+6g1mxH9wqvnLGFv4kdbSARBVF5J+mcTlzUn
 YRVkxboYYSZc/uxANYQ==
X-Proofpoint-GUID: DF5owgFeiMGD9dT0GhGpZXmu3Jw1f-ru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260185
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 5/26/2026 6:57 AM, Philippe Mathieu-Daudé wrote:
> The Spike RISC-V ISA Simulator aims for maximum coverage,
> so can start with the 'max' CPU type by default.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/spike.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 87fe0f242f5..08eb7edb92f 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -341,7 +341,7 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
>       mc->desc = "RISC-V Spike board";
>       mc->init = spike_board_init;
>       mc->max_cpus = SPIKE_CPUS_MAX;
> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
> +    mc->default_cpu_type = TYPE_RISCV_CPU_MAX;
>       mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>       mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
>       mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;


