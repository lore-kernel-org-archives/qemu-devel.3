Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ED5C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 22:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whxcG-00083x-Rh; Thu, 09 Jul 2026 18:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whxcF-00083e-OU
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 18:53:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whxcE-0006lk-5B
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 18:53:11 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXfDE2473916
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 22:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e87iGVll2xIUN1LNGA4IM4XgFh6Nl4c09zWdKpmbViw=; b=jP3RQh1pNn+uM8o0
 0y1jeAAOsuRMY1wI8iBYmIjlRN/lugPEOCTilRgnmHnYdzaChKzXlEZ2L5dqdsw9
 ohvHF4+4gJQ+hLNDwT0Bi0+HmSMNBWQsK9HO7GzasTPnRX6S0JeCSutHS38G1Wlx
 4iB0rLD2tweJAABtp2APYB35Rzr8oESOQqZKIQZyhjsC0zW7KIZYIVugnNze4cph
 yFUzgS9dXk54lgavUckeZYjd9zxxXBr4QrVGvr7bEzLgz+uRlIw60doAZ6F3bRtA
 2HYTVyC/XtmRMjf6FaxvEnR5otRvqPrLTBGSxpxAr4CgQWW+wEGpaBqvrc1wbpN6
 VVysgw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpjajh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:53:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c075c1e25so2409681cf.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 15:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783637588; x=1784242388; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e87iGVll2xIUN1LNGA4IM4XgFh6Nl4c09zWdKpmbViw=;
 b=PL9LdiMpT/n2gOlHjKtJS/Mo+wRp84R3MtSq5DnXKounBhO4HAVprbq7U/H9YLFKm5
 XGgp3/tNTFKMDx9z4N5+YUFoAc993ZgGryAS5Dn6XlJy0ISjnhKGXbpr2sCKFDRWeH8n
 yYy4uH8u4fi6q+owt8ccqROC5GckjVGKQ1CH/990du78N/czCS10K+u7WYALdh054jLy
 bCVsA6fgUtMqFF4Xt4UGa2vCmIocpAEz14aSDu0jrUMZEM3FaAg4El6ioRcmSAqVxINM
 nv5xbbzToxYGwG1XDe9jQ7WGnjQ/tveM6XFX1jW3eprHjswliATZup46rYwesysa3HG9
 fJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783637588; x=1784242388;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e87iGVll2xIUN1LNGA4IM4XgFh6Nl4c09zWdKpmbViw=;
 b=RKGoaVgAHlACFOmYvSEN53A+fiVE1/MyE1yjeXx26XS0A5Y+7/xX+eAt59CBvSZKil
 +3e2v4jvDHNspPDAbh4Y8NVxKHJVxUQwy2aG1Q2XyQSvhwU8Ml7DklkRMRlOWBE6zPzF
 +tndW6f4Dj89h4ZDyTNEk0c4yt24zVcH+vd7kkhoeYnGzVcZVPLvtGLQ53/GbyzotWHY
 qN2Z6cAu1BWKxPOBzONjSJtZFiRXW+8ipmNHCfDsHWQxwwWkiLuVvflaFBRUME1A3hXT
 Ect/nZlAJMTo5Tv/ldonH9O+PtYwRGLuB9HcfmZgRuP9D/1pTQcTDDJKIw9Hg/qoX1rY
 PglA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEDR/s3fU3UiAcMev35WkRG312lNERbV6ruc5JUBaIRpoBr7OWD02zmtWnL21htJ5zwMFruPFcAkK2@nongnu.org
X-Gm-Message-State: AOJu0YyoHfMKAmxN5INnsQIY8il6muRAljkSicYVwAW/ulIu5OqAYrFF
 2v7OaRJVQJODWYEvmqwFVEgF55QLvYqkmhPW5eSMydNI8jVARI4P8l7enCzQCzv50mlxEnkDpUX
 UaRs+POuI/CbtmDY7NQNym1YHM6YH3SL8hd3hJgPodIk26rTNjWATporaog==
X-Gm-Gg: AfdE7cke1gxj3mt7l2UEG9PMeyh3AOHCc0pnoeEwdpZwZxbMw3+Pw+Op60W/VnXFoi4
 4c8C9bkS/GtuI4ltJDeyKHlGpim/+jkpcSqdofFeCaRM6vJHC9vrEcS1CwkrkEBreZ8ERyFwsLQ
 ddcCbY61bgG0cjNjM/9CVXeRUvavEPbCvMcsxwtroM89jtcaSQkhynihKQi9HimGn5gz4u5uZK/
 wbBA+b2shtWoWH8okB/o7b+0mGyUMU1Uk3OxSsjDSqfrYukpqwjjoKn5VKs0UNMKkbUJDEmkcoH
 S+c70DfhVB6UtzmV5SDKogbP0pwBcEHNGPLbJ9D8npJRPDHX3XTQXjcA2TipO78uy+vzK0M1oR4
 JSiwxoiOAMyHbjpgcjONfZkJyIcJ1/cXiVlcx0VSDAaz1lnf2ArjmQlJBln4T/w==
X-Received: by 2002:a05:622a:281:b0:51c:7b11:41ad with SMTP id
 d75a77b69052e-51c8b51366cmr99602411cf.73.1783637587710; 
 Thu, 09 Jul 2026 15:53:07 -0700 (PDT)
X-Received: by 2002:a05:622a:281:b0:51c:7b11:41ad with SMTP id
 d75a77b69052e-51c8b51366cmr99602241cf.73.1783637587298; 
 Thu, 09 Jul 2026 15:53:07 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb66beddsm106641295e9.0.2026.07.09.15.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 15:53:06 -0700 (PDT)
Message-ID: <3a360264-4dbe-4e99-9555-9454d67de533@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:53:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Refactor AST2700 SCU preparation for coprocessors
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIyOSBTYWx0ZWRfX/EZwgQz0jbsm
 pU/EHxp0dRChEP//MaShIjpAccp2bD5yLn5nsjximmOV50HMdLLHPrhVPpSajxScHEqZqOg7P6o
 WZ4V0G+v4AeY4QQog3XRDrkXTdH9TYcX8Zylorm3h8hXaLUKnMkNzDom6U9dQrBxM0DbRdIKsy7
 mN48Dz/EzJUlEra7A+JgchvxRfEo1uje8QDiD37UUKvipNms/TC+tVEKNphEVxRYUL8mCfHszUx
 yQng7nHjixY6ZrqSgBYaO2m6DIjMc5SGe0OzLztq5G8WclZdMNzprseuSepgenjpjYBkIiNNZBt
 q90uy52uv2XSGqkw7oRk8k14dezxzDGBa5AcXVt4sDziRbpbPE0XpX4rUQt9+gZBMhDoFO7eIer
 4LCL1XX9P480/G5QytnRqLKvXLbHlmmDBvM5dK8iFuh9OpLuTz3nGRwQ86QOno0JP4UQ2M9FWH7
 vOcHJj/50hTKJzCCaoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIyOSBTYWx0ZWRfX3a7CfbDX3OGU
 WV5pqW4AzaFW1wruP1y98JaYbXpGiuhewBkR0A18RISCu2J2YAH6hz32UuPTGlVIy9D2Cpch8G2
 MuUYNh3Kgpa/zoXRLapApu04QCRKLjE=
X-Proofpoint-GUID: XIgjuVzsyBZio8WxVFfaKo1n38inBW4U
X-Proofpoint-ORIG-GUID: XIgjuVzsyBZio8WxVFfaKo1n38inBW4U
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a502654 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Cn5a_A406VAXTJO-DV8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090229
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Jamin,

On 7/7/26 08:09, Jamin Lin wrote:
> The original AST2700 FC support series [1] is fairly large, making it
> difficult to review all changes together.
> 
> To help speed up the review process, this series extracts the SCU/FMC-related
> refactoring into a standalone prerequisite series.


> Jamin Lin (8):
>    hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
>    hw/arm/aspeed: Use Aspeed2700SCUState for AST2700 users
>    hw/arm/aspeed_ast27x0: Move SCU link into AST27x0 coprocessors
>    hw/misc/aspeed_scu: Add separate reset handler for AST2700 SCUIO
>    hw/arm/aspeed_ast27x0: Pass realized PSP SoC to SSP/TSP initialization
>    hw/arm/ast27x0: Share single SCUIO instance across PSP, SSP, and TSP
>    hw/arm/ast27x0: Share FMC controller with SSP and TSP
>    hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for
>      AST2700

Looking at this machine in more detail, I think it would be
better modelled as:

struct Ast2700FcMachineState {
     MachineState parent_obj;

     MemoryRegion dram;
     Aspeed2700SCUState scu;

     Aspeed27x0SoCState psp;
     MemoryRegion psp_memory;
     MemoryRegion psp_bootrom;

     Aspeed27x0CoprocessorState ssp;
     Clock *ssp_sysclk;
     MemoryRegion ssp_memory;

     Aspeed27x0CoprocessorState tsp;
     Clock *tsp_sysclk;
     MemoryRegion tsp_memory;
};

- dram and scu are shared within psp/ssp/tsp
   (ca35_dram renamed as generic dram)
   (ca35_memory renamed as psp_memory)
   (ca35_boot_rom renamed as psp_bootrom)

and:

struct Aspeed27x0SoCState {
     AspeedSoCState parent;

     ARMCPU cpu[ASPEED_CPUS_NUM];
     AspeedINTCState intc[ASPEED_INTC_NUM];
     AspeedINTCState intcioexp[ASPEED_IOEXP_NUM];
     GICv3State gic;
     MemoryRegion dram_empty;
     Aspeed2700SCUState *scu;
};

- scu becomes a link property

struct Ast2700FcMachineState {
     MachineState parent_obj;

     MemoryRegion dram;
     Aspeed2700SCUState scu;

     Aspeed27x0SoCState psp;
     MemoryRegion psp_memory;
     MemoryRegion psp_bootrom;

     Aspeed27x0CoprocessorState ssp;
     Clock *ssp_sysclk;
     MemoryRegion ssp_memory;

     Aspeed27x0CoprocessorState tsp;
     Clock *tsp_sysclk;
     MemoryRegion tsp_memory;
};

My personal style preference being:

struct Ast2700FcMachineState {
     MachineState parent_obj;

     MemoryRegion dram;
     Aspeed2700SCUState scu;

     struct {
         Aspeed27x0SoCState mpcore;
         MemoryRegion memory;
         MemoryRegion bootrom;
     } psp;

     struct {
         Aspeed27x0CoprocessorState mcu;
         Clock *sysclk;
         MemoryRegion memory;
     } ssp;

     struct {
         Aspeed27x0CoprocessorState mcu;
         Clock *sysclk;
         MemoryRegion memory;
     } tsp;
};


