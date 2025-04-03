Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B5AC3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 16:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0NRE-0006M7-1b; Thu, 03 Apr 2025 12:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0NRC-0006Lt-NI
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:29:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0NRB-00069S-4x
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:29:06 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533FUwKf009094
 for <qemu-devel@nongnu.org>; Thu, 3 Apr 2025 16:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8JUQIKfNDrurt3B0BCjBJ0OsYNybOrx4G1xQVDBJgiI=; b=NEBauqT+3aiDNhlF
 yAf+Ok9u/a7F+f9m+sr3vDZ+qBS5dHEa+O5a9wDi33e1BtcTTCah0be9aAzIbhWo
 hJFEkAr/AE93fX5yZoqemGbEPqgFg2VHWF9xeTjYigcYxHSDT4PFR03f2lmu5zI2
 SbQVx4DkT1usU53a/v06fiFjHJgJaTEq0H2quDo6y5LaSUPuTYwEJlaZ3i/4JBqq
 HgdUi/6GdO+hJsyhJfXFY9eOhYda1VQs1y3jCwOM5KFngJQoa/jJmpLsoTPTsmJg
 xzOSk8DLjSq92gddQRIhvEIIZSrgPxBH5O4IRLrIVcfj34x9BMjZuSlbfOpDmESk
 6x98+Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45spnp1b4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:29:02 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7391d68617cso1167456b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 09:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743697741; x=1744302541;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8JUQIKfNDrurt3B0BCjBJ0OsYNybOrx4G1xQVDBJgiI=;
 b=IavDJRSpBq3zLjZE66LS4zRjM63FJmIk2UaSFwWr1laLXLiNWzjCEgkSdwqK45LUVn
 ZrV4+95dhuWtORyUbnCL203a+f+53dnIbzWDIYvWXUSalE/A1CqYPl6bxQo467UuPVCI
 Pci7hFCRGwzTU0mAGAi8fLJQUSihEOxgt5zIjkhsbFN9VSso7KKwwxjCEAqlK4Zs4/q4
 w/QH1l1Q4l3EEpRT3Qd4dx0gtiC7BmPkHtlnTkW9soqsvXquPgwyqHue9qiJ/+kodNrr
 bhCSw/3cPk7tTVPeYLi8rUg19H/UCi+EpF4iC40nW9Jl4Bs2F/z4XYpvAimLIrSGusq4
 sXFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCzdOd/X8MqEMoHxumSa5QxDZ92avuUNf5ftJ2aezNpXqA7xPVM759Jgrqn7yB4mWXG1n+X8KwkRfY@nongnu.org
X-Gm-Message-State: AOJu0YzgLZQCUrB+CMf2qJzkEnixTNKnHVYmPVGvWQemgrNR2Adb8AKP
 XUQ+f3+regg1Ct3s1jx6WLrFW8lg/OnhYtAvN8XJuQx2Um6PNNQb2m7vqwMLvVPcq3bWo3b6k9o
 QgiidSuo7nY2J+GDMaPAAa5OKF1vaXX/49EQRN8GYTMfaO/cwE+WVIg==
X-Gm-Gg: ASbGnctYMjZi1b8qZff7brF9o2qPoLrgkz6bBTksc5+KCc+Wxa0cpRv2Pnn0yVytgGA
 LAw9AxAfc4ozA60GnalxF4u601XdKtpvows9eUhwJOg8jQV7k1BGI/gIg4TPpNhPVVhmBTGRbnU
 az/rJT2K7of7gr9pMAp3dv98Qo0qQIxw2ELRQbL71cTcu1VuckF8w0TrcxB9wszhYYiqFaBuLqM
 LE9iS4bYMldbq9lFLmt90FbnLvZsEgSZWvcivAZFGH/r6hHV6Vh4sXYR8G+sgLkvGKy9rXS+OIl
 +pny9n9XoZ8ukcVe5bd7MsMQpZGn8ceewfr53VvcWRdtgzimUDwbhlMftjguP7WwpqR/n4tBqQ=
 =
X-Received: by 2002:a05:6a00:4210:b0:736:b923:5323 with SMTP id
 d2e1a72fcca58-739d6584122mr6925714b3a.10.1743697741132; 
 Thu, 03 Apr 2025 09:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGinFIJki5MXT1Y4OdrLNnu93K/AQbssQUnnz7aPOHeISteH3xH37S4He2WKwKJ/3us2J5Mng==
X-Received: by 2002:a05:6a00:4210:b0:736:b923:5323 with SMTP id
 d2e1a72fcca58-739d6584122mr6925670b3a.10.1743697740623; 
 Thu, 03 Apr 2025 09:29:00 -0700 (PDT)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97d2dbcsm1699673b3a.25.2025.04.03.09.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 09:29:00 -0700 (PDT)
Message-ID: <05993dfa-fc9b-4f77-98c9-9ca35440097c@oss.qualcomm.com>
Date: Thu, 3 Apr 2025 11:28:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: Implement CPUState.mmu_index
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@nongnu.org
References: <20250403154956.791976-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20250403154956.791976-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9xhk74fytz2f_vQLb5yF-Be4y8D7tbhE
X-Authority-Analysis: v=2.4 cv=N/gpF39B c=1 sm=1 tr=0 ts=67eeb74e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=x2rWm8D6XIvuvNDLPaoA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 9xhk74fytz2f_vQLb5yF-Be4y8D7tbhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_07,2025-04-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=977
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 4/3/2025 10:49 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/cpu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 766b678651..59fc9ed698 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -313,6 +313,11 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>       mcc->parent_realize(dev, errp);
>   }
>   
> +static int hexagon_cpu_mmu_index(CPUState *cs, bool ifetch)
> +{
> +    return MMU_USER_IDX;
> +}
> +
>   static void hexagon_cpu_init(Object *obj)
>   {
>   }
> @@ -341,6 +346,7 @@ static void hexagon_cpu_class_init(ObjectClass *c, void *data)
>                                          &mcc->parent_phases);
>   
>       cc->class_by_name = hexagon_cpu_class_by_name;
> +    cc->mmu_index = hexagon_cpu_mmu_index;
>       cc->dump_state = hexagon_dump_state;
>       cc->set_pc = hexagon_cpu_set_pc;
>       cc->get_pc = hexagon_cpu_get_pc;

