Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D627CFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIPLj-0004eY-By; Thu, 30 Apr 2026 07:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wIPLi-0004e4-3l
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 07:14:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wIPLf-0005HE-2d
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 07:14:29 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UAGodI3729470
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 11:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rWE8VkP3X9cLhcQpQMa7dEFoe2QGng7W6js8mFqsHDI=; b=Y8KFdEptr1fFRAcf
 sTzEDSXxxEyfC03aVTG1aDwLDwYxdazw5E59Sjd2pYwwwbF2xPdsvNiROqHAnux6
 zp4/uiTunmtZkvS+RJFaOzPPuihPwsgDUxMpGQok/ek5H3HJWlRHc4ABbf/LSRMy
 MGSfHX5WuYblQfcfrt/lj9eXmeuufygUbgd1Xh5Jh0N1j7m4GoiGd+1ntw9EvEL8
 paFYXNSEBchF0QgZqzeMLyq3/jTbl5rF60hpypky3CClp80sVqW7dSkRbSnUdRl+
 PrQ2X6wde4aAohFX/zi80tUViHUxP12/nTrZolJ5qxrNDcNthiJ9UMk0fNWQ4di5
 03I8Gg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duy1w9rka-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 11:14:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2de07c12745so4357090eec.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 04:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777547665; x=1778152465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rWE8VkP3X9cLhcQpQMa7dEFoe2QGng7W6js8mFqsHDI=;
 b=ZjF78nDb3bz/cyIGCjJ4YG+gtLrZSj8Rrz6L5CyANft303AMrMr4uni1j9frGPvwxH
 8MsxtsgtuF/TLzuuMcqYXnj5qBWwoQa2PerXCbGWOERAGZLaq6SK2rSUu0Jp6fHjj/un
 q8czhPmDSKxd7DRbPZMz7DI6s94c77SAglp0Ifiasw3xQ5Wwn2v2zqTVq+Jv8V+V4p5q
 uNR6M6Ah50Aoc0guVplOOXvvhNGwBeue2ZqTUEwR6Hwi0YNS1ODZPhRnNagxkevG9cGZ
 IhmnCofTlOpT1V4opMI8m1w598VOEWcEwUUhKO8Wnfw0l0sfDQglSIvxcrDVbj2riw2p
 IVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777547665; x=1778152465;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rWE8VkP3X9cLhcQpQMa7dEFoe2QGng7W6js8mFqsHDI=;
 b=kF9Z8tahdzQ/+pWbfDpzwQue7zEzLnFKB/7Pg+08TRYQAwogaVXn6skmlUjLHdTtqa
 ifWK95R8vctvZ3VRKA1w94Z4VBgWxEaKybBIT5xjupPjZREz/aUkR2CX/X5g8S/yaJdF
 dDNzAuE8KwftXif4U7HHIBlawLxk11YK6QdXg7q8uW1Gf5B0yKFGDtiYziMIjOqYkP2V
 g1SOUz1vdE/K+fktE3WXblP7DGPM/TmFVlcj7UQU+8sytjYYsVaqaGCu3IUHWs+AAe/Q
 yasbfEpK1Y0SBBPG30hzqRyi9B6njpZqVtE03Lf/QHpDMn18enyQya4lUc4Qn9LpeAwx
 cQWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yfs6DyftcIlwNdOpeb8WB3g+S/oELw9Cx4fcp3M7JZE22gv4GdfQast06Wg36i2AoVTzyl2U/O5J7@nongnu.org
X-Gm-Message-State: AOJu0YzwSryi5WT8iSzS+sNqTsrsz47DYmT8Z48E9iYLeo/NuD36cDg9
 f/WDu6qGjcXxFvnRQ9VcZNfR0S1tW/8bdwSWCWJiQnmB9aAHOHQ7+NJ32GjUndoyWuZdwn9iM7d
 uWVP7Fcz9UyDqFGoHM74SC6oFz9YEmjKkMD8ONAHz0TuoPvFfYd38dKtAQA==
X-Gm-Gg: AeBDieuO6w3cWgvq4nbxDIdm4wbs8oywuPUisCrnb+/GjrIa1PR+jzGWBogIeE7JM0w
 vNmBPNjceFDY+KGCrg9LTThgRtu/rg4jAV1oKkFfjQnNlyWsKirTwV/Y5EecOC273aY8TZMcTtX
 Ar8y0ZoHkISZ6sDE0m/Ou4P9k1Jxy7sBitLr8PZCY+wi+ViweBunYhIB+l8zWRxrVluWsaN7BkT
 aIKIevwPHMykeOq1s6mtLtnaYy97xWhC6/lSNz6a9U/W3T1U2EY50Iay8cu3KKaV8+YXgEAQdJP
 2MdbH6HuSBF8Nouz4zah32xY9DqtSlns7Ya1crABll5vvX/JMqhxMi7MQP2R579byAcx7HYZZge
 SoxFCYiE74ukWHVkRfUD43AVNIQs59kGKmHrDYfS6NvLMkWBmiY7/l5URoOXhhY58SJYe
X-Received: by 2002:a05:7300:d00d:b0:2d8:97d6:6abc with SMTP id
 5a478bee46e88-2ed3d8c3166mr1250711eec.22.1777547664859; 
 Thu, 30 Apr 2026 04:14:24 -0700 (PDT)
X-Received: by 2002:a05:7300:d00d:b0:2d8:97d6:6abc with SMTP id
 5a478bee46e88-2ed3d8c3166mr1250688eec.22.1777547664328; 
 Thu, 30 Apr 2026 04:14:24 -0700 (PDT)
Received: from [192.168.15.14] ([179.118.208.147])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c070523sm6491031eec.19.2026.04.30.04.14.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 04:14:23 -0700 (PDT)
Message-ID: <001ae7eb-65a3-433d-9117-11d694d88d40@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 08:14:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv: Deprecate the shakti_c machine
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260430052218.771358-1-alistair.francis@wdc.com>
 <20260430052218.771358-3-alistair.francis@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260430052218.771358-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XBR2Z22RIgrnc6RXZD-Z3tbexgaxdZ0k
X-Proofpoint-ORIG-GUID: XBR2Z22RIgrnc6RXZD-Z3tbexgaxdZ0k
X-Authority-Analysis: v=2.4 cv=DPy/JSNb c=1 sm=1 tr=0 ts=69f33991 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=TkFQdvD96oRUceFd3B6Mgg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=EUspDBNiAAAA:8 a=V6nZijMKQ0s8eCwPh3oA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDExNCBTYWx0ZWRfX/kIVCHXcXqN4
 UPdUo5VpEwwBXYUyZfDidStyh+d5WY3xJCzlM4PmONudTyNiEqIA2fNP5jwS3EnuMrxEMnK/8Rn
 B+rHfwNupweccCGiBNnaM+s/OvjD1souU25hPQj+idxf0qaWaeirBnR/cPsI/vA2oWQdLdWvIDR
 XXRa5O/LfEB1NhRKgmU88HfXWnyXOcY7KMNOnVL0LNQEMIaoXM7P6+E2PYsednWFJ7r9Z5W3ghX
 smvckxT9LsEouwy8TCOqJq7W0zgKZrm75mTRkH1XShZ8Lw7d8I4vMrNnstiaAahReRl8Rg5Eu9g
 tCY0dJgKNPZ5vUtjunJaLzRb5sDSwJymgynnDEfxFaAzQV/NQYie4TdWtlM11X4k611vV6uqP0P
 8SsQPuOf/8P/sjrzyLQ4hJhmP6dTxidtjoORoBzBBYjUalcHAVUzaXujodYWNBv9g2+7iWvVmx1
 68J/vm1bnxCLpYS4nFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300114
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
> The RISC-V shakti_c machine hasn't had meaningful contributions since 2021
> and is currently unmaintained. The machine is scheduled to be removed as it
> appears to have no users.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


>   docs/about/deprecated.rst | 8 ++++++++
>   hw/riscv/shakti_c.c       | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index f3622dcf93..041f71c5bf 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -282,6 +282,14 @@ firmware is available to boot it. It can be replaced by the
>   ``ast2700fc``, another multi-SoC machine based on the newer AST2700
>   SoCs which are excepted to receive better support in the future.
>   
> +
> +RISC-V Shakti machine (since 11.1)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +The RISC-V ``shakti_c`` machine hasn't had meaningful contributions since 2021
> +and is currently unmaintained. The machine is scheduled to be removed as it
> +appears to have no users.
> +
>   Backend options
>   ---------------
>   
> diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
> index 49a39b3021..852d5b9797 100644
> --- a/hw/riscv/shakti_c.c
> +++ b/hw/riscv/shakti_c.c
> @@ -83,6 +83,7 @@ static void shakti_c_machine_class_init(ObjectClass *klass, const void *data)
>       mc->init = shakti_c_machine_state_init;
>       mc->default_cpu_type = TYPE_RISCV_CPU_SHAKTI_C;
>       mc->valid_cpu_types = valid_cpu_types;
> +    mc->deprecation_reason = "Currently unmaintained with no known users";
>       mc->default_ram_id = "riscv.shakti.c.ram";
>   }
>   


