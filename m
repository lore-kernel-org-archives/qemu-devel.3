Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BEDCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGZi0-0006PD-6c; Tue, 13 Oct 2026 06:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGZhm-0006OH-FE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:26:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGZhi-0002l1-Cu
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:25:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8NFJu302833
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 10:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q8+9yR373X+NzW5an4odj488gqLsHbix8GtRHcs48uM=; b=PJBlgG+TbyygRxN8
 Q0p9OG9SHE+4LC3WitHAbuL9pvV18rQkvUuUw2koTJv7i+FR4Zg7CZPy2wOnLRlR
 IVG1o9EXUWiHRyVXkySBfpHGNo85AiApHQkWMIeCJbg9rHVg4ONV4qy1E9sxoSBf
 wxXyr3sy0Ooedun9WTQ53LGVh2C4MC83ZIzN3JcvUrIHAi4VfQQwAlSBWxcx50ax
 n+lKxTuIbZLReMnXfKC1OTL8rlCQU2/QDT9/u5GKm1KwNyv+5MO8YUTc3JwGq/Pv
 Nhhfbq/29GOhiVJZKUVxGiYneWnZd0brN8Efx1Ug8/yiqEQHaur0v7a39/L1NrE/
 yBFusQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98sqacc7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 10:25:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e46b4b700so498566285a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791887151; x=1792491951; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q8+9yR373X+NzW5an4odj488gqLsHbix8GtRHcs48uM=;
 b=QmzkJJNH3xnYqRgsKaFduYOzjF5TLyKuKPadvavyoIcqZoQFhavKnIQ738QFh24FLZ
 bqfJTvO5U1JTfUzDFfhyo4QORgzjiDMkXbdbAtAEQYo22qtujv6V0MBxTEw2y595WNHE
 bRLsmdXt+iwi4pVisHno4EyMC+xJX8pteQ2G7eN/C50uDafjKIIVs2+h8tx5NBu6h7iV
 KYfI+wWlhOrPAqrHLYRUFEoZmBzv3pCOfHYy7Q+sw9MSSlD1DPk2LjO37jOoH0VdIuj+
 PPtF0Sdb7OqxlY5yyvtSTyXQdzmnZrvTju/+2oz5TZLxLoo1UdhWcoT0bbdhm+RiRtxD
 YWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791887151; x=1792491951;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q8+9yR373X+NzW5an4odj488gqLsHbix8GtRHcs48uM=;
 b=A1oq3nq8RcclsSQn9C63QUDmLwkTMAVwknd919l8VjpjwLSXFXdK5cPl/g9WJoZktt
 C/FNGZT9hGrvdIbRDwjqjnCZQx1TFacTYUOl2+D1kR11efDDj23odBT8HCyNbuPHAlfM
 WnQ1LSSbEPYfzrTju2SinWMy34CIAojeeKAHc9WCfAmA5tNMIkXcc4a5+7kADnMv4hCh
 Rf4gSOa8zuXsLIIoWra/1mdmBV8KZ5vNKOC4hs8nmoMx+mLqk13QGgXStWWMuR0ZTKO+
 lW8yFwyOmLRJVM1ZioNqv/WR1Zxm1HF+onkSOxu237vwOlrTr0GEpB7vMIw0lFuIjFhj
 EKgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCWUUklZlS+muMRdT/gb3lhCekU04zuL3qURY2GkyCUv5PndCMSNs4m2goV+9DdIWnoVDxHnirP1nJ@nongnu.org
X-Gm-Message-State: AFq9FYK0J1Ce9vaK4pe+cfP7EZ8HC2oLEWbmENj7bsdUZiINUDLt4HWW
 xsNixEb2ccrq3zk0CowE1ph3BpI6sIY7fiqw0wisvXAILeCyIbQcXKxBv4are4TiHjVjAhsWe1+
 Jj0N7nl/SGQS3V+4qkf4Ac8pShM3X+mkXKOCklryD85nmB/Ffs9z1D/xxLA==
X-Gm-Gg: AYBFou2Kz4GNcTr1NIXOfvSDZFgmQw8w2pV9H9sd+NkqSJ4RlQKjriCD68n+7rAxZVv
 9PBKc9PeNMKPuadoiP47rPmurZNkHG8QJ49IhxsrE8S69oHI3j3BnWW3qh3SJuXZNWXfLB4TVAd
 kAe1MZgpG5u+EC0Cu0F1KBTSZYYJXlYKyz48lQzlwlRZ94JmglMRbo4K9PbCMQzTvnS5bi7LHAB
 4oTubaAZsLsW5FWXIWpg0+uWL8Mb8qyg3QjgNKh4RBgu2LlsMS2DEAH8DrLTHXYlWvllXIUrXXe
 z0kYi1Adgu5fhzg4UiFx/ga6RaAEStlFI16ylJBPykzx2RdbhjhAxTp/9S2RW/V1eV2PcTgbSCg
 T5e+GYJrrI/H43THpqcmFIXCGncBe2BBFtQ==
X-Received: by 2002:a05:620a:1720:b0:93e:c12c:9b69 with SMTP id
 af79cd13be357-93ec12c9eb7mr1851773185a.68.1791887150777; 
 Tue, 13 Oct 2026 03:25:50 -0700 (PDT)
X-Received: by 2002:a05:620a:1720:b0:93e:c12c:9b69 with SMTP id
 af79cd13be357-93ec12c9eb7mr1851769485a.68.1791887150185; 
 Tue, 13 Oct 2026 03:25:50 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a198c80cb3sm168593785e9.3.2026.10.13.03.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 03:25:49 -0700 (PDT)
Message-ID: <047c7b05-ca11-4194-a6db-c0dd2f4f2b2c@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:25:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 62/86] hw/intc/arm_gicv5: Implement IRS_VMAP_L2_VISTR
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-63-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261013083933.1024405-63-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX/n/Cbu28y1yf
 FzMMxZHX7fkZcgXmroPpxIBZm9nv86zDWjfmMDnu/68k9rSWWPYX7Qr2kON8iv0qt0q2xxAnRdZ
 gKc0t+pEKoxpVQC3zOKBumYpQ7FKtcHmVtZRk/0A4uyLrpJpVuM7WK7eGR/HIwBgpOzER2QeYIL
 scsFLMzNUkfH75x799s1s+pB/XchjnaIwtErWMphJ/PHSv0zBYSXx1uPESiMGJklfwM6B43HDNp
 qpEJoc2JPfb8JAs1AHhpUYz1uzcrPBosOS9kYuVMGpitX4zHpHXc1shEJnxIxaOH+2NqdBQOFv+
 LhyfLl8Lck1Sv2uiPVYPzs0rSaBg/jTcD268jlHL9kL9CjOINN3L8C+WTPyDc+mj2lKW/s12dNS
 VEEbqBb0U2IwU2jxphUCZ4Oang9TkIaRBWNgYFm8YjIBFBeXv35gCJvjwyAiU1ZeM5hDGNcpXKU
 5cqseLTSOqgKXoFQvzg==
X-Authority-Analysis: v=2.4 cv=JN+uIMKb c=1 sm=1 tr=0 ts=6ace072f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=CimgT5QdlH8y0ofWgOsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX3D5zyKlus+73
 vN/CQ17fZkZpz48Eq9WKWG92AHL4TXuhHvFIxeWtHUQdzeA6W81Slc/YVzmz9X5Po0dhXV4WU7E
 HQ0CzMIoOLud1HYF6JIRPSNcWtIpzw0=
X-Proofpoint-ORIG-GUID: BO9VVdWNh-QdlOKeCBxDVJmDKOsesHxE
X-Proofpoint-GUID: BO9VVdWNh-QdlOKeCBxDVJmDKOsesHxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130041
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 13/10/26 10:39, Peter Maydell wrote:
> The IRS_VMAP_L2_VISTR allows the guest to make an L2 entry in the
> VM's VLPI or VSPI IST valid; it is the equivalent of what
> IRS_MAP_L2_ISTR does for the physical LPI IST.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c                | 76 ++++++++++++++++++++++++++++++
>   hw/intc/arm_gicv5_common.c         |  1 +
>   include/hw/intc/arm_gicv5_common.h |  1 +
>   3 files changed, 78 insertions(+)


> @@ -2128,6 +2184,15 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
>                                deposit64(cs->irs_vmap_vistr[domain],
>                                          32, 32, data));
>           return true;
> +    case A_IRS_VMAP_L2_VISTR:
> +        irs_vmap_l2_vistr_write(s, domain,
> +                                deposit64(cs->irs_vmap_vistr[domain], 0, 32, data));

irs_vmap_l2_vistr[] typo?

> +        return true;
> +    case A_IRS_VMAP_L2_VISTR + 4:
> +        irs_vmap_l2_vistr_write(s, domain,
> +                                deposit64(cs->irs_vmap_vistr[domain],
> +                                          32, 32, data));

(ditto?)

> +        return true;
>       case A_IRS_SPI_SELR:
>           cs->irs_spi_selr[domain] = data;
>           return true;


