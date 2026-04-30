Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863AFFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIPKF-00048V-FG; Thu, 30 Apr 2026 07:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wIPKE-00048D-5u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 07:12:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wIPKB-0004z2-Rs
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 07:12:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63U603od3992801
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 11:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kzsspylgS57n1p9zrY/s+mXCIVa9PYsmQ1jH94aONOM=; b=hr1iTqRRtGIhAqKL
 HRd/WHoNrkAU/TOj5ef2QtCUixEJkA5mn6hEPPrQU24aV+Gp633nDjPQL8Dn2ay6
 1O1uAHFTNaONcdzKuUdm9ngiMI7yNyTy0qp8/tfvgDszN4DEZDsp6wJm/+ma02Yt
 2ZY2B3ra1c8rpstdP98HyxBxujMcs7bgfr/6jU8bNkAsb0HDK9BWn7b8Y0QhCem+
 abPjcdba60K9T7kaiCAufU5jzM5gRkNejWcN1lHNk6/aJrM24XliyKusAs0ue7HI
 4Q9RUqxwEZzUlHViHibGEmKtKdZ8PcmK0hITapcLmSyebhaz/vsV5tddB4ZX/xcu
 GtcxZg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duhx94s1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 11:12:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so1498579eec.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777547573; x=1778152373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kzsspylgS57n1p9zrY/s+mXCIVa9PYsmQ1jH94aONOM=;
 b=fzvsGaULHDqrZK75Wz/awjtSs6+E1nK+Z71cvt8ZnpuuJc1N2Og/aBFAobK8Qq1ro4
 TYQdz7Yj2fGBBGgPK83AnafdlEnfQZapyTcjVvrqmEatIwmVgk3zECsoaqcmTQevklQV
 8xciqBa6I1hSaoCxk9b6l59df8+kgR3Y4UO6IIliN0Dveh7/tOf0hCNcHMiDl12yboE3
 djfqhnmrYLsi6cy5enLSkZN9pjjy0uRcksYjBUz+Ff0wBUNUuUz8OsS2xpVgNbwvIm11
 huCAagCm6tc39/FitcwAm2HuZcvlMzErGNxYZzAmMwrmz13uS526W3CTVz7t71HC9U0+
 7Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777547573; x=1778152373;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kzsspylgS57n1p9zrY/s+mXCIVa9PYsmQ1jH94aONOM=;
 b=koKCwnZTfWc1hpEAnPzBP4vwSx72WnjxsvoB6w0LFZ2xtRYCnbeZb0nLtBV95C/7yi
 l70g70eFHtH4UatkqyWG1b/S8nxNSKcTm6HSxCxTAU2ohH9z33VL6VC+hc7lZI6O6gec
 aAJ7XvO6wLnzLZ0jvchWFqYqNmGmW0g96Dy+GAp5sEUPIM/OJ+kK7Fbb4yp9ny6pV5+/
 lF5CE8MHMfPkpHJqLd+gkCPP+kO7d9M4bEe57NpKmZOBZ+5xYd3o21NRn1jrZLmrwjXW
 9knbQ0ot4O267BhBr2ax5Vu+LIYuY86NNTEnpugXXiXduUA5eiOm3XMPugn9Sjm+DG5c
 TvCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DiWysMKt0Jekb4X1XRgTwzZWW3iFC/l1IuyWuWuRvJsqjB4XFQQdQv/QXGrzarjMukj6lYwEEstxo@nongnu.org
X-Gm-Message-State: AOJu0Yy0HTxFONtg2Rnrhy4dQIBs6B8gMGIVtf4P6Ni0Rs2mSEjGY9b9
 057Dc6TVXT4GMbiYhaI1VlEj1GkzZ5o2X3oqi+7UTgHbzWGqcJEl5HfRSPwNPs0+MR+4nxQ2b79
 PJIAYQO6bxH0MLNYENCxq8o6avq4WOAlsedJ0c85TgZVkba841aYrQ8ly8g==
X-Gm-Gg: AeBDiev5P2DsYE0UclvvnN8plbxpQAbBGQk3YvVc1jxMjJP/0G2w9dzh3irmUQi7+pn
 KZebAWO4nqXNc4pirJxavneHkUxhvnOjcffPfeVpM2Er5W0ompp7rgjJvU6TuP9SO3nTg8gIOvq
 bHJa/Gxr6P5vxaC+qcNv2GWEDGKXjQViSLT2nK19WBV/WyEBLe+RfLd+v7T2adexu7Xb5C4mqDx
 fgm4b+ntWZTW5ZPGtom23G6vN1VPdIJG6gg4HbnaAcg2uo7rTppkHAnevPyq6DFuFPnrBR2au4o
 Fy/oTW4dsPDjMJ6MgjQwjTMiHbEY3hasuEoT5g9ADX/BwpRVzlaEd9Jz07tWzCesk4hNFVU9Km9
 IQPTWw8yYOb+aWFDrot1RAaDvYlKpZ845/j3nLBoRNAQDJt/ewoikprvoCV6QgxLvNHmr
X-Received: by 2002:a05:701a:c950:b0:12d:de3e:be89 with SMTP id
 a92af1059eb24-12dead279efmr1189395c88.37.1777547573028; 
 Thu, 30 Apr 2026 04:12:53 -0700 (PDT)
X-Received: by 2002:a05:701a:c950:b0:12d:de3e:be89 with SMTP id
 a92af1059eb24-12dead279efmr1189373c88.37.1777547572463; 
 Thu, 30 Apr 2026 04:12:52 -0700 (PDT)
Received: from [192.168.15.14] ([179.118.208.147])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de320ecf9sm9098829c88.2.2026.04.30.04.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 04:12:52 -0700 (PDT)
Message-ID: <f3003303-f7af-4452-a0d7-6511cc0ecdad@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 08:12:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Remove spike as default machine
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260430052218.771358-1-alistair.francis@wdc.com>
 <20260430052218.771358-2-alistair.francis@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260430052218.771358-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDExNCBTYWx0ZWRfXy5OBPaT4yERU
 cg1jgmwQRAfNvPI7zZf+IKOlcGa/7KFM12lAWaFJv/AL2XJWk+nddAgnzFBhPmoUGWbzr7pv9B8
 ucrYzHi8a4F0EW9nzNCJSsrrPg3Ee717b8J/6+c1MNIMLP/nxmzMYawUAbRnEelLJGWJgvRQ8zI
 63rthwJ4cdl4GW6eXUslyZrN1AQYI7DvEFhaYM1qkE+AivoyBJ/Ift/ZNyNrYConC8G4gdhJGlo
 IrLXCZq18TX7FexRrBFJvjqxszirwDcNmCdE/ARAn5P0dwoXWt3bJ0mRPjXK6OoKYwhhNwgBt5Q
 pcYLmBiitQL3kG9lY6w+gGTJRUE7N3NfWipCuc3sHEnqbmuffF7XCYHzfxfv1wXlVPF7Y5N9DSw
 mG3on9t259NB5upUX+7DBY77wHT1Ym/ZeYEdmag4aOEtt7c2GCm4wjEQmw4EjKKlLGoxAaE6UZE
 25PDqIhlhMgNCILSMOw==
X-Proofpoint-ORIG-GUID: XS8zGdf_lbEUXYdyIRdLMBMc_FuxTEnV
X-Authority-Analysis: v=2.4 cv=O5oJeh9W c=1 sm=1 tr=0 ts=69f33935 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=TkFQdvD96oRUceFd3B6Mgg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=EUspDBNiAAAA:8 a=_YxS-mPEv9IPJugqKOAA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: XS8zGdf_lbEUXYdyIRdLMBMc_FuxTEnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300114
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



On 4/30/2026 2:22 AM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> In QEMU 10.0 we deprecated the default spike machine, let's finally
> remove spike as the default and require users to specify the machine.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


>   docs/about/deprecated.rst | 19 -------------------
>   hw/riscv/spike.c          |  1 -
>   2 files changed, 20 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 10de10dc23..f3622dcf93 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -282,25 +282,6 @@ firmware is available to boot it. It can be replaced by the
>   ``ast2700fc``, another multi-SoC machine based on the newer AST2700
>   SoCs which are excepted to receive better support in the future.
>   
> -
> -RISC-V default machine option (since 10.0)
> -''''''''''''''''''''''''''''''''''''''''''
> -
> -RISC-V defines ``spike`` as the default machine if no machine option is
> -given in the command line.  This happens because ``spike`` is the first
> -RISC-V machine implemented in QEMU and setting it as default was
> -convenient at that time.  Now we have 7 riscv64 and 6 riscv32 machines
> -and having ``spike`` as a default is no longer justified.  This default
> -will also promote situations where users think they're running ``virt``
> -(the most used RISC-V machine type in 10.0) when in fact they're
> -running ``spike``.
> -
> -Removing the default machine option forces users to always set the machine
> -they want to use and avoids confusion.  Existing users of the ``spike``
> -machine must ensure that they're setting the ``spike`` machine in the
> -command line (``-M spike``).
> -
> -
>   Backend options
>   ---------------
>   
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 35c696f891..87fe0f242f 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -341,7 +341,6 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
>       mc->desc = "RISC-V Spike board";
>       mc->init = spike_board_init;
>       mc->max_cpus = SPIKE_CPUS_MAX;
> -    mc->is_default = true;
>       mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
>       mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>       mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;


