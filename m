Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE19CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 18:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT1ye-0000Vd-Ng; Fri, 29 May 2026 14:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT1yM-0000B4-S2
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:30:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT1yJ-0007Pt-Tn
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:30:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2Ilw589662
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WVa12isQ6aEb9mJ/d1cwSJ+qKvKQJLYVeyR/ltxHKsM=; b=GsjShRk7u7YK67Ct
 ZkrYRssXZvfIlyBagnRiTa2izPqbZADPM8JyAtjJS9k4TkLkO+D7l8tvDM3aTp3L
 tZTa765Erlf0W6GNRA+7CVO9hB6qNOL4FZ/ShMyavbXcdxJxCDnRvlcLjMrsWI28
 Tz6bPLVucwsv4h2zF/PH5udFCiiCrEaAONGsZ9prp1HvbQff0CDVARQ+j3DBULaw
 AZDc5yfz85JwXD93xB9G3dkhtxpHKw6zcTj8tbnCjZP60zZEmVpbhuiCS87lH+3g
 oMegk60w0qPZCa/6ZpD06YjcdI50HDcZDrdcAmqCn9qO2Ek8HVSuVAkIsnG0b5lh
 o9Z5Ow==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef8rcjh7r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:30:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304df51ff3eso1946538eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 11:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780079413; x=1780684213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WVa12isQ6aEb9mJ/d1cwSJ+qKvKQJLYVeyR/ltxHKsM=;
 b=ZTR8ExgzRCZX18AMCl2w8LtNk/IQrc0Fom8s3m3KSsdV39t9UsZnj+YAICbUnyt8wD
 a20M97d2/4NKttXGj9LxASYFuf4rU59iL8LfpIVjMpxJavYAM5MENHg6/WA5am/2GVAd
 ZeSCw7RU9zPn0S+8g+7CnahtPYpv2k2oiEmESFGMGGawftrou1X9yJ3bt6IGj9K/nxiI
 HKVsV31UoIZQaDMVKuiZ6GRT93hGADT9sTIg2jzHvoxGBS7x6dIbW1VaVBFDvjxzz/77
 jihZAyjFvzF5k4tUqats3+gnvYdruYytkwjZihad60XDgYJsTmJdhjgG4bGNz7O+eWqJ
 JUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780079413; x=1780684213;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WVa12isQ6aEb9mJ/d1cwSJ+qKvKQJLYVeyR/ltxHKsM=;
 b=M7pE/imrF7aGpyQS2TDxOA7bvrmxzaKYCaA5gdFSkNkFreHsyAs/Lfm9KtRz8k1V/f
 Ipt3FWqI71g7b5gaKfuykicVPFCkY4AQ09oVm1MxYG0ekJkgzJ2RPob3Qlr7Gaw/TjmV
 IimgVogPWUYsee4fuMgv9FG2FdfDw2KYSNwnSOMqO6IsgUkmsjafIQuMw24fWf99hYUh
 epZI1Xgf/6jtS8V9jbqL0tVw1gRYA7vrwQy5REtZ7AyH0uSFWRWlBft+s48e3vID0ilG
 xxOtMaLVN3Jx0xeFhH4OZ8VsxlzMQkq7OvaCLcNjD2kp8L5dayu9c7rbNoTkh1ni5Bms
 hQ/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vPg5Waz2W8ZQ1ZzZeZ/DG5rmrWe/Yqm0Wjfo57xAiNDfPceJDsgC3f3ZqR7a7AySujKCo12YypE8J@nongnu.org
X-Gm-Message-State: AOJu0Yw+rcO+irVUMp20onDwX+994fzarFpkEpJFHBorPf2syGvsLRuQ
 6S8ff2C4h9AKZ1+qrhZy2i8mo8F7MqR5QIT7XtvV6ow3s/1foF+sOUS9I3abFO60mabQ+8fzzq8
 MMmEiHcsVWjjr5/GfiQp3iK+wq64D6YqWbn4x6hnLYjJlkYO0rO9ztTqnrQ==
X-Gm-Gg: Acq92OEhFcCQ5y4YF/tBcOsIdtnFDyF+H+42Rvxv9pD3oq7C0tGVaevyFnwRGje5AJX
 qliQ+3F+ByEqMEKeDIvehvcTmiGuNz7lFG6YXM6V9CVikAlwuz9tZE3c7hYGl4DM4ZwEnESN8Lh
 4BuLQ5SSgWeNSQetBRqdKnrS4VNeS++qOQTQk6c1kOQo3kzI9DoN+sKbLSZaavTYpO+z06iSIM2
 VAYOCsxjUdQEBOZymMQ1qyDeAVETpeW4l2aDTclU7pgqlj6ERFsLnGFGWLjmOz8j13W1MpSv6PD
 4/Aen38Bz+8/LksVPGnW+47kMH66BV2k18O7BLinu8CfvqbLT5W58DB4tp58sHfT+plbhy3gdFN
 ua9/ybgbXoqsYLJiSbvBTZT4ue4onI0fVmRp5r5LKnSzx8RTIEcFQq7PgQzJmiEr9Nm9kYYWlGD
 PmKeJ69JZnPRNzD8e9El/gDvTS
X-Received: by 2002:a05:7301:290b:b0:2ed:e12:3769 with SMTP id
 5a478bee46e88-304fa6b6007mr531256eec.31.1780079412942; 
 Fri, 29 May 2026 11:30:12 -0700 (PDT)
X-Received: by 2002:a05:7301:290b:b0:2ed:e12:3769 with SMTP id
 5a478bee46e88-304fa6b6007mr531212eec.31.1780079412222; 
 Fri, 29 May 2026 11:30:12 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed53f002sm2113454eec.18.2026.05.29.11.30.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 11:30:11 -0700 (PDT)
Message-ID: <5a8cbc9c-1206-4140-ae91-235996f8374c@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:30:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] accel: Remove AccelCPUClass::cpu_class_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: __3Rqi3MzHN1jDsbS6dR0nrH1x8KJptC
X-Proofpoint-ORIG-GUID: __3Rqi3MzHN1jDsbS6dR0nrH1x8KJptC
X-Authority-Analysis: v=2.4 cv=DuNmPm/+ c=1 sm=1 tr=0 ts=6a19db35 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=M4ieH9tDHB7thNhbP8AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NCBTYWx0ZWRfX5aHFNQJQp5kM
 7vvhxuIus1vxyKUdvnxpJuvVxILcxW+Gz9tuFwVKzmJX6HOHBfOkErPguTEObA1Rqb0kU1mU8E4
 alJ97QKJpGjbsnDhMaO8dhHf6Kjui9ENGnSsVcAJLa6cGAhv8UgJYzjCz+6fVj3xB+QF0DhTpR5
 kBmMUuQ9PHkus0scW2GcCfCFAM01r1Vi/0COq6jzeBaD9OJ50SJDr7dmmnxHqONRNVHcpYFxd0w
 /Cp7YYRZMQIFgSKqHt37nXCJSwcNB3fLioGdmMvYsihAuhVZONjuXdO1ymQg7WWiYQjLl3aEfb1
 h976nhtrMRsH9dwNteUUKL9Fd8yXBnje9hou2XviZGvvxUhWU7p+jvw2v/5wol5Q6wwZWXVzkqK
 cGMKRISxR95siuJiYa5pUiFsJGe8LxG+2MBosg64CxAB3AGJgMLewnzkPbfzen+l/u2fG4Lx6E5
 1EJFxGgNYRDZXBkOYtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290184
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> Last implementation were removed in commits f50d0f335a6 and
> a522b04bb9c ("Remove AccelCPUClass::cpu_class_init need").
> Remove as dead code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/accel/accel-cpu.h |  1 -
>  accel/accel-common.c      | 33 ---------------------------------
>  2 files changed, 34 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

