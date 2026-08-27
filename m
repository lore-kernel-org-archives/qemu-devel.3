Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED1CC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzW1E-0004Ly-8s; Thu, 27 Aug 2026 05:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzW1D-0004LS-1J
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:03:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzW1B-0003Hg-8R
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:03:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6RCZ52074836
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1+huZKkadA7OlJ05G69cEjDgZrqgP/nv5E3TAAxbORo=; b=SIGfo+3OaKMy5Qh2
 TeDgAB4bdyurrXWNoZHp0FjAVQUm7CBcNSIhoxxy8GUy8Bi/pLwOKLf8v/Npghmo
 5FvFbPTpbbzrkiE8lwnYi5eZIJSSXqqzZYLRt3v7Zy439QsX1ptcIQJ6btXteBLN
 VyQyLa7keDLpsQvsiLY2qDjChbmppiXzl8Uoh55XSxQ+LAvh/orbilAfMTXAhy/h
 MLFShQu8AoTEpN2INAZODdxzU17uagHKiCyfKaxTzPO2ys5SUTSpAAe1lnuIrrHx
 2YKMLwrU3HA/F9jhxoJ1Im4FTM0oNFIdaemRy+bfCwBTGqGKY0tohLa6B51GwFh+
 rv3KbQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaa3bhrsk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:03:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52827090cc5so8764091cf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787821407; x=1788426207; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1+huZKkadA7OlJ05G69cEjDgZrqgP/nv5E3TAAxbORo=;
 b=SoSHwJg1C75SFP96QpCCBMzDsFEZMiMAjFa6XGzL7F7lxLhY9c96+T/u2tf6g5LzWj
 zVAmSf2e5HiEJHXieXiV2jrVOomknOGSon6KJRG9Noy8wGQld/LBE9c4XDN9vMC0S8lw
 xYeDnvUojddGs49iMtllNiAi2AKi6hmfMwX5OBaHeNS7+RYkCxDRwWzSTFf5hhq4KhQK
 84CJAB3MLFAYHowgDeULywho8MO9WyE8Gl0VCYr96O2SuCHWjVEPUKDlSglF7byXi7ni
 0zBAcZRww4JGLYrC2Bxm+9mstBvmfDMXotkrZ879JbwU+Q03Dv/7udVncdBaKuPNmDQF
 H8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787821407; x=1788426207;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1+huZKkadA7OlJ05G69cEjDgZrqgP/nv5E3TAAxbORo=;
 b=S1MmDa5srhNuNhdOxOpwDu7iQqjgjGZxIuD5mIYc/KpzocUJxFceM979uV4HFY3nqh
 tVi5J8V5ztA4ZUKpxAWChaEfOrsSGva+5Z+yt0sNOE9yX/AUj9aa0jHBZo19Ohp7dRl7
 TFrgIb5a8dHPdPrROOq+oYnUrCsaEguTJa3zirsNCzY7rTUR3GpOLQ6XRItDSxmhuoNG
 VmVc1oofD5qVLvJ2Nq36udz331ElDM0UjH6NWpa10cheTtKCPC1hGu9UEMMSBYVUcS2o
 6mAGF1eh+C5aOvREfBtvYvIKxdDx2FFq26imWnje824ejx09e2GGrnHgOw/+tx4VTakV
 UFSA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLyBs1trt995l0I5LAyQxlQwV5LujH8jd4BxFLsUz3u1pTrkedxHmp1jhYX6bMCK4FWxVCQSb0p0u3@nongnu.org
X-Gm-Message-State: AFuF++mcxph9C+4z28xAR9eWZaBYyIMo03DMRKb3evhVH1m1G9ARQY0g
 8AF7O4CzKvNDP/NEDvyTZvsVCY8oPbrPKVe4sqLWVMTelAJGkSTs3D8D8SltVVunvSMEUoi0ZsE
 vaItRK8D5y218/0vSSwevCTA/7d+k6r2t/BnB0oiiBoTMCKYDjfMUlgRqgA==
X-Gm-Gg: AR+sD136dyH4UNawTjsB7ds0Ve9EQPl4fJNOUwZw8JXmVPvExi9ENfBu/G6LNvwz9Nf
 qzLRHNtw8ioFVFPJfxssP3yKQBem9+jYyI0dF+91sGpoVKL7ln35/2PIkTUG2MdhuzW0rNbqRAG
 UJXdwx2ASCYkoO8uhElSAE5nM3RcOS95X67duW5anLNtYIcDgoh4+79Od9r4hJKT85vWPZGSbFg
 y+GF1Vx3AgA48jE5Cr0g9jjyCL2DLLG8xQg3cgHgHpVlkpqM2L66fJdOX9TtCDg8jyTQXSFuwlD
 RrwOPhh/HKXwg5vMhIGX7K1oHxYXwLQ9IGqVkSCX/FBai5DLMGlwYPZ9ivlHJlX3ircySmZOaZD
 uUzsTaSyj5YstlqmhFvXTtQa8CLyqDqqrZjUA1xgpQmSvz5hp
X-Received: by 2002:a05:622a:4291:b0:52d:9cfa:663c with SMTP id
 d75a77b69052e-52fa185dc9amr55824981cf.0.1787821407270; 
 Thu, 27 Aug 2026 02:03:27 -0700 (PDT)
X-Received: by 2002:a05:622a:4291:b0:52d:9cfa:663c with SMTP id
 d75a77b69052e-52fa185dc9amr55824381cf.0.1787821406770; 
 Thu, 27 Aug 2026 02:03:26 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f5d01sm7795028f8f.32.2026.08.27.02.03.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 02:03:26 -0700 (PDT)
Message-ID: <a1efce6b-fa40-451a-af55-53ccfbe630f6@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 11:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] tests/acpi: skip FPDT oem field test
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260824164751.1700783-1-kraxel@redhat.com>
 <20260824164751.1700783-10-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824164751.1700783-10-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3NCBTYWx0ZWRfXyoiniZrHHh49
 tHMQkIbilwTejtya1CyFRUTo7Yt+WfW6osGZJoE5uRmYz1xFPERFGJNYdGvaMfq580YXicgDH4C
 FTJlFvxdziLhIeYY2YdedSCkDjAk4hK7xfabXyGcaLtCOoqMn13W0BQzWUYr/7ZLYrXV4MedElF
 6lH/buvUWFmWmm4SqLxI8bfHgqmDVclx/XtlzsS9VRzBaC8bRjVKFdmIm52pgbm3l3FOvJy7xqG
 vdc1xyNNx6V2ZK2ic9/YkA9z+miWC/z9th19+j+pO2aQ1+zTPDBZc/bpQoy61dqPzmBG2AaTugz
 IE2ZtNKc9JcxqpvdHXjW51Glqukv23wN1ydTCA/hJyLJnYnN+GZHP3ocLq0YH9kBT0iltPrsrS7
 cm39WEqWCIKKrgGVH15GmRIab1u6X3zCxt7X/74s8/6iJ84fWrBpljh4rcZ1VGHYD5xJHMCReWk
 0AS8WHFuiKyY212+uBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3NCBTYWx0ZWRfX+g8ImyK3AKtj
 MMrB/P5nyqnfAhSxiPjg7eBFBsR2BneG0vwdRsICbAtwu/hKr3ngO+v9eXAr9yi5r8MspyUXluS
 sPYSjVIiWlfnQRtn+hnKKWosfOIE5bU=
X-Proofpoint-ORIG-GUID: Kode3Ew-0lA6YdAT0VjkS5aY5zKb9fkl
X-Proofpoint-GUID: Kode3Ew-0lA6YdAT0VjkS5aY5zKb9fkl
X-Authority-Analysis: v=2.4 cv=KbfidwYD c=1 sm=1 tr=0 ts=6a8ffd5f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270074
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

On 24/8/26 18:47, Gerd Hoffmann wrote:
> The table comes from edk2 not qemu, so qemu
> has no control over these fields.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/qtest/bios-tables-test.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index a85ca8e98253..ce3f770abbba 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2616,6 +2616,11 @@ static void test_oem_fields(test_data *data)
>               continue;
>           }
>   
> +        /* created by edk2 not qemu */

   /* Firmware Performance Data created by EDK2 not QEMU */

> +        if (compare_signature(sdt, "FPDT")) {
> +            continue;
> +        }
> +
>           if (verbosity_level >= 2) {
>               fprintf(stderr, "Checking '%.4s'\n", sdt->aml);
>           }

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


