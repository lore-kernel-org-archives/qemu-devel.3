Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C28C5DF6A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 14:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvFAC-0006EH-QN; Sat, 15 Aug 2026 10:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFAA-0006DR-Hf
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:15:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFA8-0007NX-RP
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:15:06 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDNAKj569549
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AD7nNk4hEoi8pMJD9uiiFg0A72xA4fwNWV5XorLg/1I=; b=IaHVLgb7d2bdOowW
 Vh35pj0cxWIQ5ELCPBQGpXlnZkBEdE7XTyXiRg8kyYIkXfnM8PCjSfeSg3mIFWfW
 DFrZFJ6/+ljInEP/3AO8UmCVcFZMdNYRG7xJZ2iHQlGn/pIrAzDFE1o2jH/i57i9
 NdCtZ/xBO9vLNda1qKuJ+/25sbnye02Vb/aOOULlGl8dGt7vXEWl+KnGs5ZJifUb
 W/cod8VCJSKxeoXRWifR+MuRRdfT78X49eIgfZtnl1LXiPXY+WYZknHsz/po9Dra
 oQp/gmZsYVYM/rSO8nvTmT1AXjQCPU7pCtirEBYlUGQwPMQMX2YGIbOWnk437RDn
 oCBpYA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf15c3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:15:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d827597fbso30634231cf.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 07:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786803302; x=1787408102; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AD7nNk4hEoi8pMJD9uiiFg0A72xA4fwNWV5XorLg/1I=;
 b=Wbit4jOvrLf5yHTAga+4lhxORGuDDGN0QW/2Mf0tZvncyJcWNMg43dNLQg9A4XcRN+
 Hg8wl1luOZ0H9LpxOo5Odic6keIfooDlKysZe7BXZwnZmPLsbOlDxrMKhTyq+RsZ6FTI
 qfWfsgW3Fu1yM3PO5AUd9fmzizCTYS/vo7CkkSwZxEoJc/ZdJsd+Nf4fYfSYxxYD9iRl
 iSpgW7tTFLrNdKfMlVMxU7I3Xez3JurOInkxzF4N0ntcv3Aybug5Z7yr6twQ7xTjbKTZ
 +ab1BgEsQKGdKDFTD/zUgsxwNIaYPPYgLfUuTl8Cca50ojePRHqP9sERSEyAm6gP/OgJ
 B7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786803302; x=1787408102;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AD7nNk4hEoi8pMJD9uiiFg0A72xA4fwNWV5XorLg/1I=;
 b=ODW6a1yHSPVZep9CbN4NYZ3p1gcP197CS7IjCHbua1AmutrdRlS/TICRMhSpNpbEC/
 46bk6H6IRcPkUzsDP8F0W3mSMI26WiLPIWY/yP3ySenVczYFfuVoZDtJpu9YPayVEVgL
 lQZZetzL5Ta5qKAYw+PoNJVpZ4WSo0Vnqy83kdWrZJP0WuVK03WKKGsgxX+uyNDhYm2v
 QEin+4FnzuNYnVXy/T5wYf9Makb5aLhsP2GytRApE09B8Y/Hm7VOYdoQSWJx7lnVxorF
 CM12Rn4gUD6TizigaNVi4TSFb5plGbeGU6jsgTZS56qaYwYOOcBWkB5jvESKlJY9Aypo
 /bIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqTxBy9v+cEkXw1/FS4b0OyPbvMnkUpAM6rxwl6dLPn4+xN2+yOmvqaVotGZFxvpLK+gZ7ojoZh4NN@nongnu.org
X-Gm-Message-State: AOJu0Yx6I46G72r4HYWgRtYah2IP/T/ij6A7kebIMcJTdj02nw0dVAp7
 UQ0jJpU9PyBzl5PSjX8vkkmXr4/SmtIVFV+OgsJLnwR7adIkFb32Gs30n8xJXpbGVwUOqJnt3PZ
 m8TXXhiebba+KQoxUcaQIiWTiEVWVAk2ZU46k9PaZ5nuMsaD3Q02Ta+Sk0w==
X-Gm-Gg: AR+sD10YkaOVf0X1YETaEB1kv/a3gCCS+LN6/ZIR3zSfD4jfe+/f0XSeRBB1BsDNimv
 GxZTLC5dgJxF3hCHAhhrCws5Gz1Q8eDNkDR3mj2jL9mmFopzHurqmCfXOwG2bYPTbQLZErzc6lY
 bIk5MvK/PoEf9ONWrByHCpZpXUMrHawHsh2KgtMxtA9d19VB4uqcYWSjJyRSvqo6MiAssJrGeiv
 RbF1J2zyUvmox1jZo836MK7JpS9Sj3CA2/7JJGeDfjefRZ/FLdL3UIZaY/0Lqrh+XMm/0jePK6a
 8K8Cljwf4qVmki2oMYeBuV09QIW48vNHrIX5ZO7kFjLvNCl5Utk0OIBpWB7R3Dw2pFIaBOK8Vkd
 lb1xrK3a7F1RnKJ4kUntwIuTpZ5s3vwcbcS4=
X-Received: by 2002:a05:622a:607:b0:517:76b7:7b3e with SMTP id
 d75a77b69052e-52d854dcc4amr125037391cf.38.1786803302531; 
 Sat, 15 Aug 2026 07:15:02 -0700 (PDT)
X-Received: by 2002:a05:622a:607:b0:517:76b7:7b3e with SMTP id
 d75a77b69052e-52d854dcc4amr125036861cf.38.1786803302110; 
 Sat, 15 Aug 2026 07:15:02 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c46besm16783230f8f.31.2026.08.15.07.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 07:15:01 -0700 (PDT)
Message-ID: <fca795b7-052f-4bc5-900c-d77b8cbae14e@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 16:15:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] hw/sd: sdhci: Honor i.MX uSDHC vendor clock gates
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, qemu-block@nongnu.org
References: <20260812013619.2134092-1-bin.meng@processmission.com>
 <20260812013619.2134092-7-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812013619.2134092-7-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QsVuG1yd c=1 sm=1 tr=0 ts=6a807467 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=8AirrxEcAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=ST-jHhOKWsTCqRlWije3:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: 7hyD-CFSiCBpM6q6BOUFtHd0Eisukq4m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMyBTYWx0ZWRfX88xXpbxSu2q1
 scfHRvMzuAtcdlCFZgdiHH5R41Tu0Vum02QjQZHRZSviYN/I/I5ImffVvkCfe7+BqHcw8GMak6U
 JRTH5v4cRs2V54qfZWbBRpPkvzbPJENBpmG+KnczEwT4h/nVXtO4UbvRnZkKnD1XWQWRphYCpYI
 tsO8x9vNJGrYAy0e/PgXnTylkW+j5088V2LgZdNKWEUwlJ+/G/BfiIBwddHskYp0j1+JDHsbW6b
 J4Ak0fcfJQdqM9ObSS7z9KWjPJjF7mv0yD0ZHr3THJrej04GZsJEg2MBUlubC660YKlsqgasKOo
 +PO485ePxfRFRTOKvtGwUDUT0HzO8OpTdUZd1b0k/c9z32WGJcUYLKKBFtXIwnYBJ8SFv9PwQJH
 onr39CAWg/bQ0EEVSutN65VyDcBZ+WelhdUc00NLT7mRHZgbhZq3h8kVjSKtGF82hLDguLQM6OC
 re+m9UTl9c4UKLiNuZQ==
X-Proofpoint-ORIG-GUID: 7hyD-CFSiCBpM6q6BOUFtHd0Eisukq4m
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMyBTYWx0ZWRfXwQI/luea1QV8
 SUfSoOfXZUlovgooFUQVSERoml1+73fEjU622f5aS35gyFBPZ8N6wVH65JQBe8R2Bjlw8gWFSUj
 f9wwHy3qHaY8TcdWWNcbxKP/xzcpzDI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150103
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

On 12/8/26 03:36, Bin Meng wrote:
> U-Boot's i.MX uSDHC driver enables IPGEN, HCKEN, PEREN and CKEN in
> VEND_SPEC rather than the standard SDHCI clock-control fields. QEMU
> only checks the standard fields before issuing a command. It therefore
> silently drops U-Boot's MMC commands even though the controller clocks
> are enabled. U-Boot eventually times out waiting for command completion
> and cannot load the kernel and device tree from the SD card.
> 
> Accept the complete vendor clock-gate set as another valid clock source
> for i.MX uSDHC. Also report SDSTB when the vendor IP and host clocks
> are enabled, matching the state U-Boot polls while changing the clock.
> 
> Keep this behavior behind an i.MX uSDHC quirk because the shared eSDHC
> paths also serve controllers which use the standard SDHCI fields.
> 
> Reference: IMX6ULRM (Rev 2), section 56.8.10, 56.8.12 and 56.8.26
> https://www.nxp.com/webapp/Download?colCode=IMX6ULRM
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/sd/sdhci.c         | 27 ++++++++++++++++++++++++---
>   include/hw/sd/sdhci.h |  7 ++++++-
>   2 files changed, 30 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

