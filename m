Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B85CCF2C4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHoQu-0004W7-EV; Fri, 16 Oct 2026 16:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHoQr-0004Vq-0I
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:21:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHoQl-0008U6-Gu
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:21:36 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GJf16N3179349
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KMilIGKE9c3UY1XmkCtOYC69VKsut1+Uxtkbx4CyM1A=; b=kiE7dZ49No+xr+Tb
 xgINCzkM9UjxGiIF3ca0LzV0eYy9BFpob9Gcw5tA7v58F+Oh+EcjkZLsrsCaFvJn
 aKWWP8QB20A1uLL1ENups9FXZ3H37nOfkDACUo/h1xfmo/aRFz1y9d8VmJgm6crg
 wQITPs1S/mTFv/yFbXVmoOjfZn8WedxChVLuiiUtsbFCry3nFkmaSfldpnsobk7E
 NFDYs+tTdJGDSEdc9gwpas0XXMDRKol0yHWOkCRpGEzDfaKtsVvxeleuooBqhGk/
 6vBPoUpserkrJ4dcp9uLnFhBrQvOdRth3gK0zjQt7c1vrrnTJHR87DHuPLCs1DjA
 +yU2Qg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5ytqbp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:21:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9179a556c43so6644946d6.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792182087; x=1792786887; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KMilIGKE9c3UY1XmkCtOYC69VKsut1+Uxtkbx4CyM1A=;
 b=Qz5xBBydWxDr66IqUYvcQKjbzzLG5LllrevBUUJM6BWDe2y+E0LkGrKHKXgOpx9tIt
 KOXXk09l9jWl5xRn0VNp8gP/n/H8d7ZP4aEnwvqFMOFfJ0ptECCcndoubP04retNj2Qy
 awbCTfmZQaDCju9pl+oavjQEbhqV8jeGKopLmHmU0YUOsgEWHqW8fSglq1rxQQqqMnnE
 VlkWmHmUHjDt0iPhIOwUsccnNOPMqD0DpAP2h0yRiPoMt/NQ2wr5sTq8c9ehjXFlEa6B
 f1Fj9yD4RzU/sCJo/4/ffcSUwcizq5dEy0QLnPYOKpZBvVmXDbwL0/asFeedEuYxia0r
 Wppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792182087; x=1792786887;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KMilIGKE9c3UY1XmkCtOYC69VKsut1+Uxtkbx4CyM1A=;
 b=S9wpWhgd0tQsKXfyrBaWQqd4E6zqNoJD/aAgHv+iauMOyjOgeyzAKQIvoFR06+7Vj8
 ZbKUkQETSEv5guJu95GeJREkGSOW5M/HVsUziEAEe03VWx8DbNo2o7rTcH2ahPKBrbnG
 pf0D6HIb86XIf5gRD5L6OdC2u1+bBFniGtSWGPEZaobQ3YS/Tc0nmYNEwACHVxo2NvPx
 cJ/w8l5JZX4mZ5bmCPESgNx7k02M/ftX3/gvd7nA+g+ErCte78Og+BvlISIWHV7ZdxKi
 sccci0UrH2A0sqZ2Kn3n9RZ5R8IJiqupgQq5DTbNups93wiRsfH/QuCxxjRFP/SZI2zx
 JaFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBySEhF//9W6NqObul9cFrxcqWHYr38TpE0atV3mSyliZK2HMU1r/LZ9+9OrbesNWfN3zmoTr3sQGPEi@nongnu.org
X-Gm-Message-State: AFq9FYJ+EK0+xk6YKxyDp2YxK4F0SIx/RVHK/QaWxx/OyVLbj/UYNhxS
 pEHyIIHvpe/mwEKlbyWjrE8STEwzjlUsUQ9nktwlT2QHIUBH9tEk7y/ZlGyl3rT7MdZRHGRospz
 PXG9eAksiZx7e6w6LYotGKHMm+UPEQEvl6wa9ee3DDDq5h4SoIgTUbtKe7lIVDQZ9yw==
X-Gm-Gg: AYBFou2RVB3yaGpOMO0Vd0p/tfRjnV++oTMgJKXhN47rlrcX5gZACFk6cP3ih0teSkG
 d1+kmByuPqHW8NlOVPi3mGp1O2VJYCpcNsyyQlUhutuq8lqpulXLgPv7kVl0w7kSJz1VGk4Fov0
 P1fHpi9GkWaQ8eFOfBX+eJ91WvUoh2kPDELNSXsDPgZ/9NoBR7MPQ2UzgUJwvq54j+Z129Zt2uN
 raThRn1s6uEY8Pn7SLXoa58tWpIACo9fuc+EwzEgnrl87nu7Vjr0mYscq8BhCr+GVKoo1vOz3Hk
 ieUuI1+9Uu2zIPDqiWeA1PPdYLlxC64b77i5RXJnN2swPvU/7Dpx5koEykzNnPAHAlmyFQgbiTP
 m5nXEvVrsAuk51c77og3yvmLSkKb3WCaaQAg=
X-Received: by 2002:a05:620a:4547:b0:93e:6ff1:b67c with SMTP id
 af79cd13be357-93f29cc8320mr177551885a.20.1792182087216; 
 Fri, 16 Oct 2026 13:21:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4547:b0:93e:6ff1:b67c with SMTP id
 af79cd13be357-93f29cc8320mr177548085a.20.1792182086715; 
 Fri, 16 Oct 2026 13:21:26 -0700 (PDT)
Received: from [192.168.68.103] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f1a16c21esm298141185a.16.2026.10.16.13.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 13:21:26 -0700 (PDT)
Message-ID: <0078a7dc-f7a5-47ad-b4df-5cd210ef7b99@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 17:21:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/riscv/virt: restrict scope of virt_is_acpi_enabled
 to this file
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>
References: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016182751.264704-2-pierrick.bouvier@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261016182751.264704-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EOcyqdtxZ30oCpKLU1BdN4nyitRZbUdD
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad28747 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=WDSYQnpEfCFHCtFydvYA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfX+HYjXsPaKSPt
 isYrIMwXMljSgJF59gUA3+MZj8d97EG9J5Gspeu+k90i5n9B3aMqzSSPWRHcMDL0qGoUWowx5hh
 lMGOj5z8IrWlW8U9GPSqJDt2GLzmouQ=
X-Proofpoint-GUID: EOcyqdtxZ30oCpKLU1BdN4nyitRZbUdD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfXycjllzb4sWcA
 j0FbM1qXz3LclbaVLswxlXKvdm109JaRviUBTHlNwsYt/uTO50zO0EizxrLMYPqCYWOpabxwVOY
 v1kdN/WZuQuL8MOd4Citq9DESV3iPhH++Do9diPZGEGGV/cnKkQYliK7LRHGJN0perj/RkPewBf
 qIBhhu5/lU2wTJnMA/BfoKFjaQa4ho93Bhmo7bY4evwpqTcnlostnC/UNMwuTmzbevm9H6Sp7kJ
 NtzIY0ktN27F2P1EaptzaflYYYbTw5hRXXuz7NUTb6ibI69on6orrSld9/r5RZEcksnougWOZaA
 aeXDh8k5C2K4zIkWq+tjpn+ECPNCuksb//PRD1QTMtwPX8pcLWCVPyyhYpDG1RIcqUE5BnWqOod
 QvjcrOQG+wQgCG/bicSUoolEbCdc1uUALER5whQyzqyi2L86DpuW9X7sPEliePENgADfr/aUEN+
 jaoO/RObH3vS4sHnMJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 10/16/2026 3:27 PM, Pierrick Bouvier wrote:
> This removes conflict with the same function from target/arm. To the
> opposite of arm target, there is no external caller for this function.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Not sure why virt_is_acpi_enabled() is public.  Probably something that
we did in the past and never revisited it.


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/virt.c         | 10 +++++-----
>   include/hw/riscv/virt.h |  1 -
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d4b501802f6..b53ae07f9b9 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -71,6 +71,11 @@ static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
>       return riscv_is_kvm_aia_aplic_imsic(msimode);
>   }
>   
> +static bool virt_is_acpi_enabled(RISCVVirtState *s)
> +{
> +    return s->acpi != ON_OFF_AUTO_OFF;
> +}
> +
>   static bool virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
>   {
>       bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
> @@ -1066,11 +1071,6 @@ static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name,
>       visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
>   }
>   
> -bool virt_is_acpi_enabled(RISCVVirtState *s)
> -{
> -    return s->acpi != ON_OFF_AUTO_OFF;
> -}
> -
>   static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
>                             void *opaque, Error **errp)
>   {
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index e516898f9ad..16d86edfcfc 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -121,7 +121,6 @@ enum {
>   #define VIRT_PLIC_SIZE(__num_context) \
>       (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
>   
> -bool virt_is_acpi_enabled(RISCVVirtState *s);
>   bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
>   void virt_acpi_setup(RISCVVirtState *vms);
>   


