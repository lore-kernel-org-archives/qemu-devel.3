Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C05FC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 18:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuDSx-0000mC-PO; Wed, 12 Aug 2026 14:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wuDSw-0000hV-08
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 14:14:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wuDSt-0006eq-Ut
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 14:14:13 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CI8OsT397704
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 18:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gi+YmZUFhZ1/osyalKdvaj1XG5F24GPcrW5SATjvXfQ=; b=R7zFrwqjy2Npf4a9
 CLBuR30jJ+JOnsXKkxR1lNkP7/15/nxkohcIlx0/lYXeQb4KYF4LCv35OoAwILhn
 vEsf6Mfk6XCm04Te1MjGvHHDhb7UMqLhmPUvKiewh55sM3xAP5symywcF7LXURFl
 gyGJjopMoPjj4ZDLVXcbJOjL7AjeAz/XloDaCGO9sRNcVrD7BcFRVX/rh0ZnI5ok
 yZRrQI/KunDIpT1+Fxo0xd4CjFizn7UZeqUd2s3mo2iAS1XOe69YkuMlem1aMrIg
 cUTFPtDYx2B1xctPehD6uT4JCTJvKK18rOZo13V0w4qW0c9HrH2iDn8YDneGtewD
 Ennegg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0wt8r1fc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 18:14:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c083f1818so17252521cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 11:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786558448; x=1787163248; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gi+YmZUFhZ1/osyalKdvaj1XG5F24GPcrW5SATjvXfQ=;
 b=KOXBjMzEvvwh2IXqSI5Tk5EuJ1JDJ78F+c7jM5+fwTBQEzHSAke2Em1MnjpuL/ZGT0
 R5NSjAZP9IKvN+WVsZdZUrLdvyOSv64Ez2kgzUL8IVcOQzMMzAxgisD2Auw4pM0T/Tu/
 VD2DVX6LNzGKkMzz+WqzI8Df/K0Nera0NTKwslfRR8/eV79G/KUTtMtxGHLaV1tNeMw0
 bQddItrEuzkYcCbNTukd39Q8rdEJR0poE7+tAWTQBSZI2ADpaXsRufmksa7/rMOtd5Zx
 MpPJrEITF7ZpnD78lBQBL2le8agmxeaWAbfGf19ZGmIdwfM+7bsZNahuJoNZkDU4JaxA
 BkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786558448; x=1787163248;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gi+YmZUFhZ1/osyalKdvaj1XG5F24GPcrW5SATjvXfQ=;
 b=etoYUHcm/3H21hANNR95osIdgdxFFOrhXE+yPGkudpUXbN0peUGNjOOmrYdQmMqIJG
 Lwph0WHs24GbwdD7IEn+opiSoRDPot/lVInhWIHciczBOtAO4f9HrG12V24keAU3s2rt
 TPsRuuk0t+GLerjJnOpJeKfeuwJf0jtwAe8U0XQiZ4XrI72rx1d7Mo+RCKTU5MXiF9os
 /hkD4vSgbYJuuLYNFONLZXNAtezkG13eyRhRSaH8OlsnLtqo9zb1FoFeKKpdc5puRSLh
 YbIMzq2mntzWA9IGd7uVbrKYtxRY0caT+DaIKbN/K6wniTF5KS3lfkzy78O/L/gDS4Fg
 rmmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpfehl8+KFYq0SzPWkn3E9Oi3L+1jvQGU67bGPQ13Hmsg7NMlCzHxGFWO/t/sc4TkFplP0PrjQlD6u7@nongnu.org
X-Gm-Message-State: AOJu0YyTVfdtuaiPA3rLZnJaJU4rRExUM+BfL2ye1BwKe24OeL5WQUsp
 xji+lYeNqeC++G83zBsaoVMGcGlNTlxSokBQ04oVkmYrK1xZnQt5f20rHyZol5dxun0UnhfYot6
 icIRdV7HcIBc1nA9sv7QUjNb1I0aZX2qgyKFTHYaJyXbs4wbWa1lH7xhRYQ==
X-Gm-Gg: AR+sD120PXumNrge8Oe1RjaFC7G6GVuI0VOLiAm9RXacYPP9VOrJCDCXm0t5T6IcozV
 bP95GW53pL+KfteZZW6engquaiYfGjmvk6lJm7fQpCpaUTaJipASF/D4ePVXFasUWiphanbIIqk
 D6ewB0pLXSCiAV1wJj2DUo3eLootP5b3f0/+96dCVcTukdZbZ/McuWF9qCmhCRkeAI8hfaIM2M+
 d4Y2yItA+4r016tYPuBMLwO/8Psp2t+3KKvU43qyWzrIFUMxDMFzsf0r/bzwd6Qps/wEJd7zesv
 6UnChsfhdsapJM9lIgz+V0M7rpeGYjEgpBxTM/YHoBZzrzjZLbeNEoPtjUx7iBSBx1gTFUe6Of/
 DPbiWZ5RX5LHkbom730BRhGFVEDD9JZHHXezt
X-Received: by 2002:a05:622a:1aa3:b0:51c:1132:c80d with SMTP id
 d75a77b69052e-52d73d9227fmr398031cf.28.1786558447507; 
 Wed, 12 Aug 2026 11:14:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa3:b0:51c:1132:c80d with SMTP id
 d75a77b69052e-52d73d9227fmr397321cf.28.1786558446962; 
 Wed, 12 Aug 2026 11:14:06 -0700 (PDT)
Received: from [192.168.68.100] ([177.198.100.18])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936b5f136a8sm182900385a.22.2026.08.12.11.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 11:14:06 -0700 (PDT)
Message-ID: <91247095-8bb1-4c0e-a27a-9419eddd7792@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 15:14:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] target/riscv/cpu: List one implied-ext rule per
 line
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260812174417.2468981-1-max.chou@sifive.com>
 <20260812174417.2468981-3-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260812174417.2468981-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YLqvDxGx c=1 sm=1 tr=0 ts=6a7cb7f0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=el0UrXJS4K3zujXh0Vdy/w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pFyQfRViAAAA:8 a=3YQCPPdjfU7-w7EmfpgA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0NSBTYWx0ZWRfX+PGY0lzF19Ix
 Bji9sjUx6MrTQ7pQX65bte7Nq1QjNFI2Od6HF/tvYXLDmr/AOCDAKyYthMi1zoaeYdVKZf+P5Sn
 2bUg7F543zYI6QIvJKW8fkD8zley2c4kAAobSO8Mrxkk0JPYTizRuhIgft2+wMznRAe2GBcFveh
 1jsnAWLD/BICgIj7C8dUGHLPOSfxKQbsLwn2Zd+IxfXm/5urr8nAbVWzAlDYYOFA+WCWt7gx0P1
 9iBwTneojxUVWK+CB2jM4U02YCe0tK8oDtebw4TjBPdC3vZN11pH3CIm58ZZ+MtkirbAHSevTBX
 dDAM6dzvVuKbkldowl66RQUdb5qv4ez2fNBg3sFzZXQiMqR89TS5XfGIDV4PPYB2karXn2Y6/Gh
 wyKoJPcHyvDeZRpvYqQ0C/K8+bs7qSFbPCjU5JpuoM+xGjdtt7pIUf0ED7znubhc6i4f6MZjW1p
 wLWUWuqpgR21nRaK7dg==
X-Proofpoint-ORIG-GUID: QkN-2z4fO7oTtUUUJ3w-QBKSe1F5NF0D
X-Proofpoint-GUID: QkN-2z4fO7oTtUUUJ3w-QBKSe1F5NF0D
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0NSBTYWx0ZWRfX75/RBW8KrQDm
 sRw4dy7SjDxuZb4YQ8qZm+1OtXgYMFhgGI39pBoOeIqkFUnLduvvAVPAtT/oZc97/QtyglWrRPY
 w8vbjoK36XcXsxWMTVI1YxtRjyxn2ZE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120145
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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



On 8/12/2026 2:44 PM, Max Chou wrote:
> Every entry added to riscv_multi_ext_implied_rules[] currently has to
> reflow whatever line it lands on, since entries are packed several
> per line. List one rule per line instead so future additions are a
> pure append.
> 
> Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 58 +++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e643d7c7af7..fffb92ff110 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2818,20 +2818,50 @@ RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
>   };
>   
>   RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
> -    &ZCB_IMPLIED, &ZCD_IMPLIED, &ZCE_IMPLIED,
> -    &ZCF_IMPLIED, &ZCMP_IMPLIED, &ZCMT_IMPLIED,
> -    &ZDINX_IMPLIED, &ZFA_IMPLIED, &ZFBFMIN_IMPLIED,
> -    &ZFH_IMPLIED, &ZFHMIN_IMPLIED, &ZFINX_IMPLIED,
> -    &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
> -    &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
> -    &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
> -    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
> -    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
> -    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
> -    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
> -    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
> -    &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
> -    &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
> +    &ZCB_IMPLIED,
> +    &ZCD_IMPLIED,
> +    &ZCE_IMPLIED,
> +    &ZCF_IMPLIED,
> +    &ZCMP_IMPLIED,
> +    &ZCMT_IMPLIED,
> +    &ZDINX_IMPLIED,
> +    &ZFA_IMPLIED,
> +    &ZFBFMIN_IMPLIED,
> +    &ZFH_IMPLIED,
> +    &ZFHMIN_IMPLIED,
> +    &ZFINX_IMPLIED,
> +    &ZHINX_IMPLIED,
> +    &ZHINXMIN_IMPLIED,
> +    &ZICNTR_IMPLIED,
> +    &ZIHPM_IMPLIED,
> +    &ZK_IMPLIED,
> +    &ZKN_IMPLIED,
> +    &ZKS_IMPLIED,
> +    &ZVBB_IMPLIED,
> +    &ZVE32F_IMPLIED,
> +    &ZVE32X_IMPLIED,
> +    &ZVE64D_IMPLIED,
> +    &ZVE64F_IMPLIED,
> +    &ZVE64X_IMPLIED,
> +    &ZVFBFA_IMPLIED,
> +    &ZVFBFMIN_IMPLIED,
> +    &ZVFBFWMA_IMPLIED,
> +    &ZVFH_IMPLIED,
> +    &ZVFHMIN_IMPLIED,
> +    &ZVKN_IMPLIED,
> +    &ZVKNC_IMPLIED,
> +    &ZVKNG_IMPLIED,
> +    &ZVKNHB_IMPLIED,
> +    &ZVKS_IMPLIED,
> +    &ZVKSC_IMPLIED,
> +    &ZVKSG_IMPLIED,
> +    &SHA_IMPLIED,
> +    &SSCFG_IMPLIED,
> +    &SUPM_IMPLIED,
> +    &SSPM_IMPLIED,
> +    &SMCTR_IMPLIED,
> +    &SSCTR_IMPLIED,
> +    &SSSTATEEN_IMPLIED,
>       NULL
>   };
>   


