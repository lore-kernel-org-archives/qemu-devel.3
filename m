Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD759CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGZQR-00022b-6A; Tue, 13 Oct 2026 06:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGZQP-00022T-Sg
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:08:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGZQN-0000Iv-K9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:08:01 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8SjUM302959
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 10:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rhybMcsXt7MVlQU59av/4Ud9t8eo12dIx3v1X4AmRUo=; b=TJ4il0MqhJltiOQN
 5Gy+kb7yn7pVY6jQOMmCaeUfP8410b8OovWxHN7QB+1BvDSjKWfn5ue0xdgLhwXC
 tkff5cU4SEgiyAHX0orX7XUbwLoxkfqzX/QR7wkiJMY7F0imG+5QfzdQrVVVebc4
 vk7NJAfgsbRRuOcAxwV3SekMOISJqPi+QX/bGMl+i81k8snCtoSiEItJ019M8Ofn
 h6XoDzP3ORIkaFt+/QbdNmxFgCXJft9cKTNJ1MAWxszllg8hyfjQ8x5VAWsgjeNV
 0vGxtPOd0m3zkhwiggLWXAf/aaJqrP6kU+P/mAbuFrQiRKh2ZvqBKxnVULauCn0F
 +i0Lcg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98sqa9wy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 10:07:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cbacbb996so455755385a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791886076; x=1792490876; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rhybMcsXt7MVlQU59av/4Ud9t8eo12dIx3v1X4AmRUo=;
 b=LakAJdZr0goP/YbUbTfcpcR6pINN7Pq3Wq3k65aZjcgdMt29uDGTwVD1zr9qbHDXeE
 z7d5faPW8YxHs4jti128mfxcbqgvNqHIw+jVdEP/5r95MPiVjmrQW0JI7dgD0+9K5Eb1
 eNcwDC6fedJ3cyQBGH5KEWdRVk0fEQm6+wMPEuX6BrOLVeRHAu4/pdauO2esiEE3Y11G
 A74q9yJXnUVQhexAD2B9GnPzDMn7i5AZE2l1URmG2Qn/bdNlLZQDsukhmvEzs63vhbfQ
 tV0RixQ8Ml1o3M9gr3Ar45jY3/btNzZyrw6bjoFjpkXhxvk1QoPK+Bg7p9osR9lzJ4X9
 S6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791886076; x=1792490876;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rhybMcsXt7MVlQU59av/4Ud9t8eo12dIx3v1X4AmRUo=;
 b=S5Whz9YBE/o+DUM3392EqQhNAPYQB5XqJbJybxtRn5E1eeA4M9sgUlvD774qOgtL2I
 cYWtNAiaQgffsoB+JxKjhALA1gZD2YKtFWOYls4QncNAFEfpPF8N8yDQKQuK+v6P79cp
 fslkJVVdhqoY6QDHXRwcu9eAkQnq/EmZ6GY3MYt6GqX+VrMTmc9meVu/94FamP9wxMNo
 drBDC0ijl94uYvRSI4Um59xHx3WqYPxlxRwc3xLaTUa2JvpokIhB6DWN4gDSKd+mJEA3
 yHN4M/QasnaqjHRmfWNU+SJ1Ps6Tz7/7p9/gZIvMf37BGCV1VpNLET0cw0C5oVJ1XfSD
 nhmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLJ2/O2+7kAa2yn8iI6N9V5mb1mnmq/BzdlgK33sshTQBhEtxUK0iiu2Wwvg6tqvhU9Gda9EpeKwAZ@nongnu.org
X-Gm-Message-State: AFq9FYJR7zp9QmhfhW0oS0bd/wO1U1lKHDq3J0lBjXOU06QhqKE3B636
 ZPjUP/mfY76cswhQlIm7FhA73SqSe8ti7UJ+nDCSgPnv51lc+qfuKgCC0K2HqcCaaRx/ghzhYbl
 HsrYPDxIrV/nQDfl9y+fkUCP+hGbj/c2yIYvYy4LnH5GpIr1yqCI0SBXDHQ==
X-Gm-Gg: AYBFou3K7PgBgHqFiWcU/07JDGSZ0aSdx6V/+4FgbdIfd8bF1rGOGpfNXHqgBzUXCJL
 KsjORbOiYAfVwzyeM1hgnUd8i4zc3/fdubHS5C+l+f3jq4TZzn+bhIMUSo1cn3WCytXiax+6MKT
 TLPm3QH/PU7ooDiyyxnJJfyPtdjYq13fDLVw9Bm73SPDM+wJgQOit21xSaqesJPm4L+yNUZvfDX
 Hrv0JIZCeRiw+8hASPEOpI6avWyPvKt7UHXY7EjtUfrflNJBSyeVCKLjtvRbEBpVnG73o3ZLmjX
 gEMhU7DGuw9WKaxqwOVc5Xt6nSZms48huzCTGkAPMP1/QK+p27bTeZP2C+XyEi7v2sGpK9eVbvz
 MaRWgoHf0a9scgd0wvzJ1c2m1v377k7oVUA==
X-Received: by 2002:a05:620a:454f:b0:93e:d364:c9ee with SMTP id
 af79cd13be357-93ed364ea97mr1244318385a.74.1791886075935; 
 Tue, 13 Oct 2026 03:07:55 -0700 (PDT)
X-Received: by 2002:a05:620a:454f:b0:93e:d364:c9ee with SMTP id
 af79cd13be357-93ed364ea97mr1244315585a.74.1791886075466; 
 Tue, 13 Oct 2026 03:07:55 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19f249692sm290969025e9.3.2026.10.13.03.07.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 03:07:54 -0700 (PDT)
Message-ID: <220d3e91-fa4b-45dc-a8b5-8a6ee04e1ba5@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:07:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 38/67] target/arm: GICv5 cpuif: Implement PPI pending
 status registers
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
 <20260507155154.1886557-39-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260507155154.1886557-39-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfXyDcHH65sLVEj
 bGA6AU8KZCptIc2ntLOht9Y+gp27BNwArNJtuP3BJEOjxyVnhrEWlpa/Y9xoOX1Taz3inX4aZXo
 pxGfWW9YudtBplFKgDEJsaFUl3W/222VOGKUf6RwLTilNHOX2lJyUIXyA5BxtGYKqCMqZ3/uZu1
 wTPkaL0B/yHvjImJDbsAmBAUEusRXTk17EuBje9gE228brDQ0Fd6EXa2wripodt2KW5VJJa8+yd
 Mnv0B6PxZyYxkFeeUE6vPBDzqTYpZroiq3WVPsC3manRO97Q9tPuUFXZ1wTXlNo56MI6RayA+1v
 HyczTIAVflYeGiW/fqq/9bg+lprQTEIMV7zr/nZ02rPItgQqDNqsq6XpDOljhUzbxFi7b215lCN
 lyLDWpXOTFqWOyVyWj+7G+JTbhLxvDiUzFFu08pKHzR4kndygNt/gPWy/aJd//4lTnp0G2EPfQR
 mvClm+bdrc7VYx4B5gw==
X-Authority-Analysis: v=2.4 cv=JN+uIMKb c=1 sm=1 tr=0 ts=6ace02fc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=i0EeH86SAAAA:8 a=qvKvpNmNlKrUKqZPLrAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfX16wDJfcfpzry
 c8TFNZCA0TMy1y6Zo/ScR8eiUoTC0UrTKVuDiBjkRFlLsaVha6FQEi01jD8Sp2KvAoldBH05t/v
 hGFKtVruBH8Hw/zXpL2Q+Ext/xB2amc=
X-Proofpoint-ORIG-GUID: vPncI_1Hf8BjZ81XtDd__oMCQz7yHO8g
X-Proofpoint-GUID: vPncI_1Hf8BjZ81XtDd__oMCQz7yHO8g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130040
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

On 7/5/26 17:51, Peter Maydell wrote:
> The GICv5 PPI pending status is handled by two registers, one of
> which is write-1-to-set and one of which is write-1-to-clear.  The
> pending state is read-only for PPIs where the handling mode is Edge.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Message-id: 20260327111700.795099-39-peter.maydell@linaro.org
> ---
>   target/arm/cpu.h             |  1 +
>   target/arm/tcg/gicv5-cpuif.c | 44 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+)


>   static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
>       /*
>        * Barrier: wait until the effects of a cpuif system register
> @@ -314,6 +334,30 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
>           .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_hm[1]),
>           .resetvalue = PPI_HMR1_RESET,
>       },
> +    {   .name = "ICC_PPI_CPENDR0_EL1", .state = ARM_CP_STATE_AA64,
> +        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 4,
> +        .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
> +        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[0]),
> +        .writefn = gic_ppi_cpend_write,
> +    },
> +    {   .name = "ICC_PPI_CPENDR1_EL1", .state = ARM_CP_STATE_AA64,
> +        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 5,
> +        .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
> +        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
> +        .writefn = gic_ppi_cpend_write,
> +    },
> +    {   .name = "ICC_PPI_SPENDR0_EL1", .state = ARM_CP_STATE_AA64,
> +        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 6,
> +        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
> +        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[0]),
> +        .writefn = gic_ppi_spend_write,
> +    },
> +    {   .name = "ICC_PPI_SPENDR0_EL1", .state = ARM_CP_STATE_AA64,

ICC_PPI_SPENDR1_EL1 typo?

> +        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 7,
> +        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
> +        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
> +        .writefn = gic_ppi_spend_write,
> +    },
>   };

