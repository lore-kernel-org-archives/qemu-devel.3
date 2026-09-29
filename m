Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07344CA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBX1X-0001QF-E8; Tue, 29 Sep 2026 08:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBX1U-0001P9-FR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:33:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBX1S-0005Io-Sj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:33:28 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCDvsm3756703
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CgPrpaJ32NCOZTlYTbq+HMVqlW0RdNsFhw36/bYMkSw=; b=p3tRAGwasDi4dFdV
 n2hRfZLCcik0dEF9q/cltX1UN36+HkArYH07kj2bN/IlhtbDsHujefE+g2RDyXTD
 Yr3uEIaN5SNudALkL6cpkTQWKvBJtsVo00upU5HaU/c4Zwm3Dl0ggKnqx/rQShoo
 RRR6jm7GkJrTND5pToOhUMgxFpHVM17kvMrGezWWvqxUM++XlgOyjMENSTt7kLE8
 ehRa+rqRl92lzRDpJrIY1V7UIM/GffNIIsb1wIF/fhC0Xq0ag6F61WsERLeWiGnd
 m/6LjSvArpVYh7rTCrYw76SiNVsFhioI9ou/2c7+KW7PldU3X/bvKdcedE5oXhYZ
 hbos9g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0b0v8ngd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:33:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c57e0436aso338594085a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790685205; x=1791290005; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CgPrpaJ32NCOZTlYTbq+HMVqlW0RdNsFhw36/bYMkSw=;
 b=S7eU9A6tyzOnG+Zzy6rPTH0pGmIe4vwoatNnT9r5ZIgSNfx6xt6Fuf/czd8nxqJ+hS
 vX+R5OrTfFNsFpRo/JDw8YTL16pn8J3tlPHJI0JhCPc/J7Fkn56HY/5vDq/0D8Vkv3uF
 Co2EAbPYY8Vujipu+ZNoGxoz1+zmxJnTOV9msj2TambuPlmSGuFVf0hAnH6zlakRsaw2
 NAWjWNYBXPBDyyQ3wAOoCYHBxP6+dmeYHB/sbSVSZnOD5pX0VhIy8tKonK4Dv8XvR/VK
 247o3M6WN0idC1Ue58W+BIkvwRx4HZcZ5sMyEHma3v7iF3HYKgWYRkCL0ItAgctEgzrc
 7psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685205; x=1791290005;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CgPrpaJ32NCOZTlYTbq+HMVqlW0RdNsFhw36/bYMkSw=;
 b=F9XzjfEU6ikQGuItBHBCm7xQKD0bewuzBo5bdABXm7hqRQ+YvUHaNRM0534U9cui8u
 6LcLgR23bT4z7bo6tf+QHFskCnyjy2cOsxU49yyNLcjufwXQtKUh2taBsWQemaecnXUS
 U0n+41xskub+b9BMRH1bMpvTZxUylknOoX5vRRd5avxi++aKLIj0oBmBKjD3Rx8NOz8C
 XB9SNWeyslwKLevVrUdIjejcc++hJiIfB6RIN+YeAzRXoae1Vuheow+PQPY8WG6GTCEo
 8clqRkGjJaSy8mlK7EFqqsTP1KnQTBmPzWx2orgLoycT/NKWfFIR6MsvyIKb+7qtcta2
 l2oQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLlzj+SzDh2Vur+vbbr04Ks5G0ZBU/io0ycgMgDqMHz8Ksv/OdihiCNT3uvI0arz3ybRVOuL9T2EcZ@nongnu.org
X-Gm-Message-State: AFuF++lf7A4PcXS8pkbKo8n4xhYSdfc3/Pp2Vjl+VpwFFk0kCKNpL7bO
 7ewV4ACwO79+PV9Cp00cUpLjaarxo/tdL0dsblM3e5VxSrB4y8zLKd5doJuoFMF0NpyiqriYTjh
 qAoHckrXA1/A8AYxHzD/e8OadorXSA4Y3t4KmNJXnv1Q1SdIbe6L7ta+UaA==
X-Gm-Gg: AYBFou28V/XDtYSa/rf9BzSyGrC6D7sTt2qFpyNjWJSHKYkuHBhzA9Q2htAFEyTfem/
 8oT0yxzTFu9QhBdsbYfAx+e3BEEnIrWqz5DfGFI4EaHNzyn/K8zC0BNPd/fHxmzJoMPLK2M7HXg
 ekvGgKk5Gmwa2GNsv2NkSfWPRIhkm8/qEgPqae31M1V8nuowHTPLwSM7o/RLbGCMY9/jKP8Pbz5
 3XSvHfzV76VHwifmfekMx79c8ngIXYswhAj0PD7foiErLuBGH+t5zgM++SeUANVGZk8ndd4qXma
 s2RZJMTzmjmdeKr2Rez1QJJ3NIFrQpJgSTSsF7riZIh1fM0G19/1O9gtg7FAICWs87NPOlQhw/P
 QT5OFshF3SR9fpqjI5DIHPYqLBZqT9x+b0w==
X-Received: by 2002:a05:620a:8811:b0:93a:2e8:5af1 with SMTP id
 af79cd13be357-93c43cf7d1dmr2588293485a.46.1790685204336; 
 Tue, 29 Sep 2026 05:33:24 -0700 (PDT)
X-Received: by 2002:a05:620a:8811:b0:93a:2e8:5af1 with SMTP id
 af79cd13be357-93c43cf7d1dmr2588285885a.46.1790685203577; 
 Tue, 29 Sep 2026 05:33:23 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfa66e5sm87625965e9.11.2026.09.29.05.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:33:22 -0700 (PDT)
Message-ID: <b41d9ec2-916d-4952-b63b-05e3edf80e8b@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] s390x/pci: Fix frame stepping in rpcit_service_call()
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20260928202325.309353-1-mjrosato@linux.ibm.com>
 <20260928202325.309353-2-mjrosato@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260928202325.309353-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rfdjCE3-Wo-Sfh1V0iC_KNG69GyO6vSa
X-Proofpoint-GUID: rfdjCE3-Wo-Sfh1V0iC_KNG69GyO6vSa
X-Authority-Analysis: v=2.4 cv=Z+55j3RA c=1 sm=1 tr=0 ts=6abbb015 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8 a=ph5Z-r5AeXlLnT07bH4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfXyM6zgylmt0Tg
 RxZJexZ0abgRO3uwaY+ErtwmQCtLzbeRtDTdlA7p9Yi8Q2gaWMmodxV1utSI5ETNOaeFa49kOx1
 9LLUMWTyQ7tzjcAkrEJ9tVUAJSaDgbJRLXgt93W5TRMBt5GTXCgHUThSlE2lBWsn/2K77M18t8L
 tk1Tb78AC/mdMdjepn0Lz0qZcfzfpW5Hxjx3oefVl7LAaSToe73RGUU71RH3moQ02cPNyLNoKi6
 qk/DasZ5vjGce53hosn7y339tSjXDF1a3VyQxtS1ko5G9NPwGqcXKEOLj+hXcOjkiKFj0ggA6nU
 K/pTVVDq+uPfp8GYQwti+oYAYr268Xh6TbnlJByiWzclSjtfTIQlsaNBaCitWsGv6+JWBZC1Qoq
 PZR2ZW8HuYX1e6BvoETspZ+tQQ0SgrKy9K9WyHEytoWTmky/4s/8siEiYub8Rhb5u99yaSpQiZ5
 kLVMbJ4WzcGo5vLJurw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfXwjfPpboKAl+H
 WcDF9laRQs8D38U5Xa/JtbUa0KW+A4CIEYIzsN7RfxPrlHQH9veRh22iI3BaiqlBrod7fLheHQq
 AFI1WpcJpavrWrb7LANYfVLk1Gk6pBw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290049
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

Hi Matthew,

On 28/9/26 22:23, Matthew Rosato wrote:
> When walking the guest IO address table, an invalid segment or region
> entry causes table_translate() to return entry.len equal to the frame
> size for that table level (1 MiB for ST, 2 GiB for RT).  Adding
> entry.len directly to start only advances to the correct next frame
> boundary if start is already frame-aligned at that level -- which is
> true for a well-behaved Linux guest but not a general requirement.
> 
> Add logic to advance start to the next frame boundary rather than
> simply adding entry.len.  For a frame-aligned start (the typical,
> well-behaved case) the result is identical.
> 
> Fixes: 0125861eacc3 ("s390x/pci: fixup the code walking IOMMU tables")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-inst.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 652e1712ec..a51543df44 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -808,7 +808,8 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
>               coalesce = 0;
>           }
>   
> -        start += entry.len;
> +        /* Advance to next frame boundary if start was not frame-aligned */
> +        start = (start & ~(entry.len - 1)) + entry.len;

Could that be QEMU_ALIGN_UP()?

>           while (entry.iova < start && entry.iova < end) {
>               if (dma_avail > 0 || entry.perm == IOMMU_NONE) {
>                   dma_avail = s390_pci_update_iotlb(iommu, &entry);


