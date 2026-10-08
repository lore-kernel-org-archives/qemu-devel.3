Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D08CA6017
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 22:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEwZv-00055m-6g; Thu, 08 Oct 2026 18:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEwZa-00054x-L9
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 18:26:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEwZX-0008Rr-As
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 18:26:44 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0DVm296644
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 22:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CVv8aMWcBfVexbcRUO23u+KIrFbU4urij+3AwRHx26k=; b=SusZVY8uPMm0UZ+Y
 0UTm0VjgjmgaJKwdxM8TqVnw0MdqCN/Ss4zz5NrWoMUfmwRW+wo6hgn79Wtx7cQy
 V+G5QI2olV6GsJhOIFT4HC3tYexSxEt8K3mVcq0zg5XofShJdFJUi7R+/Op/6doL
 JOr02eo4W/hCuFJjzW1cISMAD/YaafO4/ERuWQGxf06oD+CR+Oed2tcMbU459vrh
 FzFhxEC+yfrhZF3uoV4hdAYYYEYPZ6OZx8cd+iJ6JkwLpOiyRplerR3bDDN/asiE
 X6TRB6Xg1pFGg8/m1G96wxNjnLZSjMom3+lZNIcPk+4fEzw7Xd9b3n6leLhj3nJS
 eKH04Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekv96r5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 22:26:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e834ff4d0so1119638185a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791498401; x=1792103201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CVv8aMWcBfVexbcRUO23u+KIrFbU4urij+3AwRHx26k=;
 b=Zvjj9CiD4vJ3AttYQzWHxAre5Ob0iuzIBnZrkqVbsErTo9rdusDaacX/8VcAbEPmRD
 aiqSn+JG+sTWft2zsbzhpfjCbQ30h7AgqaxYiNKikncjW1DPuj5HQG8urcKRGn+sEPqT
 0swI+lABeFDzj5WpccoTPE8/c1p2pMxXmutpwlvcdVnmEOHfaD99AyCRkUvmFOuag7vV
 k3jp0x7lyiNo2GCWR2Bg9EtqBY++mg71AefIN0dlionww/9YmWWu8IHxyprPICtOdoPU
 pnVG1luWLCPYTQyhik1svvLqplODRSpKt5y0s2jfLhZX1Jw18L2md1Dj1M/1BB37l7Ja
 GE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791498401; x=1792103201;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CVv8aMWcBfVexbcRUO23u+KIrFbU4urij+3AwRHx26k=;
 b=zxpxZCB0iHNd2rqjo/n+ikyOGc90qkuxkPePieqqi/BoQXsX39MiraVV5phkp/UTiC
 9Yn44du5+7CvUVItoe9MCEuysW2HdVp1TUWXv0VNObAoBSksyK1UvaydD7dyqudp95sq
 jkEMXQ/yHzb06cd4ulv9dPLbJY9bPkrd3D4nBjsDp5g7kBRF8qQK+LGOQpWqiqMSdxoe
 ValwPDhhdKdq4RZT60gVx8opCmg3PWY1rYlQbu2ahqHSvKk16g1Zqi5cjd0JR9qRcz/Y
 7aHkTtkyw2aMdXaFOwsrgdDCt60ehO3+jYpPxgbM+/Wgo2HJR5Ul1qwiP6+HyNe+bYvf
 KN6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZ7bQcLOfSuqaDgNIIpt/kEdu1hQhW2La3g20oe22J6P2wwXJdPZ3VF3/v/5xQtqNdM0DHpimUALre@nongnu.org
X-Gm-Message-State: AFuF++ncwn1ARoA6EyebZUr9eqYydemYupD8jAB/URqLQStciEISDyIF
 TYB+HjwWpgVerb+UgFaD3xatsQoTbOm+kxS0twL9zfx6UwHhTSa1xy+amskV0+GN6TCf/M+uS9D
 IUnsbKJiFwQnUtGxZeQva90XIP0ROjUnwHUKe7Cj1s+EcaqBgoLHk7sygTQ==
X-Gm-Gg: AYBFou32CRq2T8pW+0LLVCEHf9CYNfWy03W747+sL+xW0vzvYQTOukoYEFS1IVvgICX
 mnyY51gQGMOAQjGWlYUl0Kr7kzs2oFq7KO3ZrijeIZDP57oPMuDjsmpRm/uj3HXnBGySeGl3vJ5
 V2+4nP/D9plVS1stwI/qep1oYOOcTrsTZfQJ/be2cm6EQhFNKuRgOspT74vcvk84Df+RIXFACxr
 bklZbUxzSVmmy0r6anjVlQ5ToLhSYLymG8kvDfYocKDz8GiWYDCJMQxvBqEPVAm1NHRHpGwpMgE
 C1Xb4w+G6CBHe6iLX+ZifLOTTFEEU6kcYetq4jA3cw2x3+bL34gYVBdeyAN8SMx6VL9Ki9f9Gdq
 Qxo3uzI1JAfYarIJJQnwGdE18cfSvSM3ApA==
X-Received: by 2002:a05:620a:6405:b0:93d:e031:5ad with SMTP id
 af79cd13be357-93ebd224911mr5203585a.17.1791498400701; 
 Thu, 08 Oct 2026 15:26:40 -0700 (PDT)
X-Received: by 2002:a05:620a:6405:b0:93d:e031:5ad with SMTP id
 af79cd13be357-93ebd224911mr5200685a.17.1791498400253; 
 Thu, 08 Oct 2026 15:26:40 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm11112045e9.6.2026.10.08.15.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 15:26:39 -0700 (PDT)
Message-ID: <471263fb-bb06-47f6-83a9-764e603a7a68@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 00:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] target/hexagon: pass the packet PC to lock
 implementations
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 ltaylorsimpson@gmail.com
References: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
 <20261008211005.1853542-2-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261008211005.1853542-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: X9_C03uNBMTlMAftLXpo4s34S-FReXdk
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac818a1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=YLznLUdcFbrBv5XlK9kA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4OSBTYWx0ZWRfX74uvwgjjLSJN
 IsLzbeCxQPTTICQ+fhVq8BQC+mT4NQ8XkOiomkTIWPlAl9/JIVFWaJOZ/YdKHoKw1CrHbsnus1W
 9m0C8VmQF4j1bx4d6YQEahvG/i23sY5ck/jnodkQo8QE/YNAt/JP5aS0wmU2AY+Cs5q52QXPBdt
 85AnVu/0O+KmwBOJsUV2Gj8qUsn/tJJWh4C3BVqx9wmUYFbBxYqsZQ1aX+W9OOHqKaPmHdb6gxM
 tMxZq799in2uymfqIxL0yKbrJ5g+z5F366zxgYltTz7OBQEtRNXS9Vhd//ENUV987ZEbJpKPALX
 mQyxeJXSmYRtaeoWrscJNPhcN3l63A1xT7HrX5BslSdo6WrgU9TFIAuRKSnaCxegpwFAjUkO0j9
 +82u3bZ64iihZYzejJa6O4fQotYU2n7NxK+fXY+oVBJdavIBKA+nNk8g81jzaaji/fxSL34gSBD
 vlKnFMwryA56hQPt8sg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4OSBTYWx0ZWRfXya1Kl3Eenzo6
 oGViwJD64lhuJuMlGJXsN39v2a3XSpqD1mhqU5FqFBisoEWd/aG+aY4U8H4oRdSZ4Nya2zk4+DR
 QsQILsU+fyous5vvV++ETN8EPKYfqJA=
X-Proofpoint-GUID: X9_C03uNBMTlMAftLXpo4s34S-FReXdk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080089
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

Hi Brian,

On 8/10/26 23:10, Brian Cain wrote:
> Hand the k0lock/tlblock lock implementation functions the packet PC as a
> constant instead of relying on next_PC's opcode-dependent staging.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/hex_mmu.h    |  2 +-
>   target/hexagon/sys_macros.h |  4 ++--
>   target/hexagon/hex_mmu.c    | 16 +++++++++-------
>   target/hexagon/op_helper.c  | 16 +++++++++-------
>   4 files changed, 21 insertions(+), 17 deletions(-)
> 

> -extern void hex_tlb_lock(CPUHexagonState *env);
> +extern void hex_tlb_lock(CPUHexagonState *env, target_ulong PC);

> -void hex_tlb_lock(CPUHexagonState *env)
> +void hex_tlb_lock(CPUHexagonState *env, target_ulong PC)

> -static void hex_k0_lock(CPUHexagonState *env)
> +static void hex_k0_lock(CPUHexagonState *env, target_ulong PC)

Please do not re-introduce more target_ulong uses.

@next_PC was converted from target_ulong to uint32_t in commit
613653e500c ("Hexagon Remove next_PC from runtime state").

