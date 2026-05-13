Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD44CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 20:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNGeA-0004GC-MO; Wed, 13 May 2026 16:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNGdx-0004DF-FD
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:57:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNGdu-0001gC-OW
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:57:24 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DINi5i2965293
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 20:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GdYnN6bUXAPKbyXF8mxSEpwkUIrJKzu4XTDQ3+dDJ+w=; b=CHAEOf1dq8ilKwvh
 dBuWi83p0Y9h2xaJzezyhWganLSRN+9yC3oT/enwZI3/FL/ok1H7XREBqjm8zXgo
 ov4e993bIIzysdXnOB3WhrtuaC+SnZVZ534YLDPhgZOtrS3RwWw+urwaQt1lqTXy
 +4qfIKlrknrXXjnUUihRkpqg6+eLZPr3qGAolTTziZ4a1E3G39XkT98bSfkmGd8i
 cn4+h0IAg88arz3hoQcqatGU3KC/1ssl5rjqMR8+bIv31AGrsmsnMMWQzoXC5wGB
 efrM+JW31pRh0IruB6OI7aFYy5+QONwA7DewZ0OMnF0C0g5uKxpJUbvvs09UIkBm
 znDxHQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4ma5begq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 20:57:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-90f4bdebe77so312210085a.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 13:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778705840; x=1779310640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GdYnN6bUXAPKbyXF8mxSEpwkUIrJKzu4XTDQ3+dDJ+w=;
 b=de08ltzwkIfqmIZl4sc/GnTGN4Xf2JOSm1MOdEPnbd+Rbf5IE0Fzc6vsQnYW516Z/V
 U51TMKUwFElvsJOsneC6oKcPODpqDiCZ914KbYaypeb2Dki54Skys+1UUmdIx7UAgp1t
 meej05aySizmICCXrZP4OSjwfuMBVMA2XloPePISuaytPzZR7W70o8lQJkaLKfy4Uxq8
 NNnjj6S2ZcOE8j4ED5isF2iWVjfWlw1qRSLT84jtOkZ18jag80mSur6ihpF96l9zZP0z
 wLrI3pkHX8yF5/7AYZaB08nRqbZUVlevsQKrdczbFp9UyAFlxWK3lHHH6eUymkaCXSc7
 49fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778705840; x=1779310640;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GdYnN6bUXAPKbyXF8mxSEpwkUIrJKzu4XTDQ3+dDJ+w=;
 b=QnVnjXTE95b5H0f+jbE48u3xWMtz9s1fE/7TMQpz5JbMgI5FNr584YfKSREaRABMsa
 oaaTtTmGDMzrpLyVOu99GCZZHgxJlH65uIAPbpnu3bktJEEAg33h3o3XM0lQ5DYLpD1k
 1hscC/NNoNXzFAkBh4W86Tpc+DNmr2XnZ8rsMOO1PAmQ5bMG9HWMYAuGhCqRFC9jd5pb
 JGauGzERGluXxTWl3X4fVyX6sai2Jg/O1/h1utokicEGENVzpNcLB4paf810X8WvYVpz
 1nliosxz9F6OxGcH5aIhasAVjNF+9uFH2CkcGk1HzRQS0s/7Ou1sIKutqOy6B5usSL0W
 4Y/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9o74LwYeIf1yQ/fI9U8WShALXfYDxGJyVWZUmEQrhcwhUNXOzGsvCuYRe4RD6J05LdRaVx5GjwtRGT@nongnu.org
X-Gm-Message-State: AOJu0YxuqdBlknnIQqsnhn22NeRIA/zMzXmpxvQIZqVz4p+mJ+gvBeYk
 +E5X6Bd3Nr/XNR0r758NekUKCRBLcE/KCw2irjzLtf4JG5b7eZyzrRiVYz4thiUZE62vZY+LPYp
 kdFWLPz4ds4GuzhsB6/xv5CIRdqWk36GyAEu4LNtYAGwFWPtTFpPhg1q18g==
X-Gm-Gg: Acq92OEqniIdirxnwdyhLH4GZrQyX4d38iwRsjIw7Bw/RiAuR0SIJXDnFjPiT7xak3p
 HkIcw36QAl6Y8ire4v+KgvtyFTTNAKXG3CnVo0wDBT3HgsSmyypRUg/Tpr83lqSgrsJYJ6dCVSZ
 PdYssxXcRCV0pIxsZozjMZUd/whcWQJg10iVxs7HfEwFuxUhYiRN/fm47JKx9VR5C5WThFwwnsH
 N//+mSQSBQyiEmGJcjQ09g2ftkbY4jL+PgI/th9iSKRGMEOWd4htMSiyydWihwlEo+IuR8zzgwt
 eOvwwZiQCQ3thI7qc3Pg4gLVFwIucmHUuMZRebVeSYf7HvmbLNL3u3g18y4jrnSmfyT65uIEd+q
 HLxxrhKim0hARpo9Rk4e2HhozdeqHzLtv9SGBMw2vE+B3Y9TP4rSaievoC2Q=
X-Received: by 2002:a05:620a:4403:b0:8cf:d717:c22e with SMTP id
 af79cd13be357-90f8ac08841mr760967385a.28.1778705839831; 
 Wed, 13 May 2026 13:57:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4403:b0:8cf:d717:c22e with SMTP id
 af79cd13be357-90f8ac08841mr760963485a.28.1778705839209; 
 Wed, 13 May 2026 13:57:19 -0700 (PDT)
Received: from [192.168.68.105] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bab3ad15sm60761685a.16.2026.05.13.13.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 13:57:18 -0700 (PDT)
Message-ID: <c583c23f-c202-4ba8-b546-efcde10e6cce@oss.qualcomm.com>
Date: Wed, 13 May 2026 17:57:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix IOCOUNTINH.CY toggle detection
To: fangyu.yu@linux.alibaba.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, tjeznach@rivosinc.com
Cc: guoren@kernel.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260509074941.99295-1-fangyu.yu@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260509074941.99295-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDIwNyBTYWx0ZWRfX1bq/s0uxrbH6
 Yoa9F9tf4a0RZ+kp1rN/os8CqBprJpGY8FcCb2p6r6o4FWBvBlpq4lwSWqwwS6g+7fVzUwQDT0k
 KPQhDamxNt8cxlQAHkPq5AUNBnnsPUs5agKEp0FYWaIdHVxEPpHyTrdPdd5fgtMCNHpz6RpXb2F
 6McQSwGy/Qi9wlZRFJPcT8wSHnEnxv6Y6ro3fhc4dRqKCYAn6CDavTn0R1jV5VOAzUYJgN7a6Vf
 5spbGNAn7qtzPR6XWHeROF4+N1RiU1iU4iUUAgpT5pngPr2ddAyf/HaejCc71r759NwAETvCarZ
 FzZmUBQdZX2gwomNBknDsSYsDCQzyLsF3CnYsVZxY2OP5kQ27O9u05OZn322VUzu7uN+hPmM8i/
 P3e+pt7Ib1RkCtccAksLkd6xowdvwXd4vOX/Do3hmW3SlejUtM5xnnCQYPs3ToB0qiwrk5qXji2
 /cGOOrQUpiSD3oRiFwg==
X-Proofpoint-ORIG-GUID: ToO5CcQ2cAzkvLaKMNnUhx1hVCWSQw0a
X-Authority-Analysis: v=2.4 cv=TJZ1jVla c=1 sm=1 tr=0 ts=6a04e5b0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=3D468XuweCyeP0HIuucA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: ToO5CcQ2cAzkvLaKMNnUhx1hVCWSQw0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130207
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



On 5/9/2026 4:49 AM, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Fix IOCOUNTINH.CY toggle detection by comparing normalized CY bit
> rather than XORing whole register with boolean.
> 
> Fixes: 2cf2a6c027ba ("hw/riscv/riscv-iommu: add IOCOUNTINH mmio writes")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu-hpm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
> index e8d284ac8b..5bf80a8db9 100644
> --- a/hw/riscv/riscv-iommu-hpm.c
> +++ b/hw/riscv/riscv-iommu-hpm.c
> @@ -245,7 +245,8 @@ void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh)
>           s, RISCV_IOMMU_REG_IOCOUNTINH);
>   
>       /* We only need to process CY bit toggle. */
> -    if (!(inhibit ^ prev_cy_inh)) {
> +    bool cy_inh = !!(inhibit & RISCV_IOMMU_IOCOUNTINH_CY);
> +    if (cy_inh == prev_cy_inh) {
>           return;
>       }
>   


