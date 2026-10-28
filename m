Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1640B606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TNMf5okF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UYTrooWx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8Kk-00052a-Lb; Wed, 28 Oct 2026 14:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xM8Kj-00051X-QT
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:25:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xM8Kf-00031L-EA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:25:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SFA3494165792
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OFFijUbU4WRlBht/kHL+q7vJa2sE2ievEjnRef8nHEE=; b=TNMf5okF8xoQeT4v
 Tb6AuJGgg4CyUUZ1zrlu2yHQTkAJepBdOvm9mvNy2EWAzkDXuwiYBwpwB2uQet8o
 zvtP6uKMwrzVuwQzOluWRJbTZq26SwFokQujEXo1L19kkuSOg525TpyWpVPgHBP8
 cw3eOeGaWDbEfhzRgStJiFp1BUbxXMTLY3D4AFPNU/RTTcrBEvhGoKOaq0HLGLCI
 xVC5ZF1+WZG6jrNowx942hPFjnEk7oHjEo3o/Q3WIcL78oZk76WDSFJiVvqr63B2
 Mg971Iut0u6g9Eo9mVmVmbdRR/XWRmAUHmlyX4G2k8i/UjRQc5jTIaKfkNCVuqCu
 R4wq+Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkhtnhcb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:25:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so2649663eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793211900; x=1793816700; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OFFijUbU4WRlBht/kHL+q7vJa2sE2ievEjnRef8nHEE=;
 b=UYTrooWxMMjt6LXeaEzZ9bKGx4MA43KrhWs80UajBq6jHSEKvyYiXI6TRty8wrx+qZ
 Sv9I8xKEqKuFqyZyQUz2Xw+AJCIas/HCmZHdtrs+74WVVLjhfGjcVYag86xjml7Ow3Qn
 YM9GzlEGaBEL59FMlcCDDTgLGYB7ILnlNrIb1JwbhhNc7RSNNMjUI01DpnYkQSk2IV3c
 tL6YUbNMKWnfSFVbB1zTcUG1WSOsP7sy5gYqSXPA2sX3DtykMwWo7WSIjOoXWLb6tW2J
 617kKf5XfXcgp/Z1/BDsOLM80ymZcJOZKA1ovYwXUqkOuyUe2k5/VWBnpGJ82Ix4DPwM
 K2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793211900; x=1793816700;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OFFijUbU4WRlBht/kHL+q7vJa2sE2ievEjnRef8nHEE=;
 b=KRnP7k1QLt4VoLKSvv52S70s5zTHoqZxeIFYt1XJuJKKT8E59KHUsKG3C/Rb58QYJ3
 4Vjhs+1V7H41102krwpIe8WU9DVELNLc5HEZXS0zvLJ6XvVMo2uk5JCAKa2SiIXI+rX7
 1hLwuKSXkZkkwrJKapaLPIVu56Yn/1QbpIUdTtmJ9rqzpIYHznPvBjMUJbjZE8s6zwhc
 AzWDKEOTiF9pZsEALjSNUMDOW7KUFeQUy3NEpHEt89lLfoDT7rXw+i9bo6ELxgalCCga
 iAF0CjciCe10ujo22cxpuY1Enj4A0NyD8uhQpDVlv8YTTfJLvlUZtCPEUMhbf8ATiGuj
 +RPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBweYOPWdQhxaf0B7UZ/JV9WjCBy6T/nGcg5uttrlB9u1lSnSTn18AI+lAAvJgpj83dRE0ijhgW4iO9+@nongnu.org
X-Gm-Message-State: AFq9FYJrNryp5JTfwWVcpJiRi4eW9Wjps/o6ZyWFk/9OcanUvRdQAnjF
 wCG/v5BrTUvLrekTkjuH7phRLuLV3bni0ODkuesZltNs0oQYVtL5INBjzlrcsTSaJSjSbv904lF
 GTL3XqEDi1NFPrq6DyK2ry3o0Lqe/9Wxq9gFcFLcLEhaUC3idwv7YDqMrQA==
X-Gm-Gg: AYBFou1l8qmGWukyuJzaVB0S/7AZb5FBYBUX6Yjpk5tdgQW8heXAhj0BXHDFXfO64O1
 iS2m7wAdZgXiXce5ClnBQ5Tb2vUL+6I8tNJc+34AvOlA9dVxkjLDQVY940S6Ndjum6dEIKuS76A
 shB042INoq0EQV7aX0YBktZCbYxdcrqNsFPzGxjy0P5agRsDhJIWU0fCzDIcuZ/kXs+VpCIGE+u
 pwMZ0T0flNv0/sl2JLuBvqV/PUliQ7TzNzEyj1DJobdYRgCqf/595JTMgyAUOZJFtoPTb/0Y5kz
 qYdF8WA9+j4YlTlpR8+YtaeyD35itK8407ftNViSGotkgapIp/xQ0C1kHP48V2OZmPx4lFeCbxP
 Dz6Ks6DE4+SNFK2HxBVz2KcnbZ8uP1L7ngVoRUBb1VJvdyLvPs/vz2E/0xyObueKIPACaE403Iq
 d0wdcQltrqbNWtDtJr7uOTKGtsHCP1zVeZzmpw+7dN1Ko=
X-Received: by 2002:a05:7300:a8f:b0:368:c6b9:d3bb with SMTP id
 5a478bee46e88-36a203f18f1mr4656560eec.14.1793211899636; 
 Wed, 28 Oct 2026 11:24:59 -0700 (PDT)
X-Received: by 2002:a05:7300:a8f:b0:368:c6b9:d3bb with SMTP id
 5a478bee46e88-36a203f18f1mr4656517eec.14.1793211898967; 
 Wed, 28 Oct 2026 11:24:58 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a237bddb7sm7781276eec.3.2026.10.28.11.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 11:24:58 -0700 (PDT)
Message-ID: <bc5bad6e-fbc2-44e1-a4b4-41bdfd41d33a@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 10:24:57 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] accel: register CPU parent for each target
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Weiwei Li <liwei1518@gmail.com>
References: <20261028063049.2530-1-luoyonggang@gmail.com>
 <20261028063049.2530-2-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028063049.2530-2-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Lb2R25NN6Prq7L2j2MQFoqIjmvGihHb_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MyBTYWx0ZWRfXwfwdh5ZHIaxK
 fG1NYsI75avHyMfk27Y02Hp6VNZE6w+TS4V01dRsEwoWCQNlBCSGBO1GwfkHZzXlBrqeunUtjd2
 525ksYTP5EkFkIOUVvv2FqE8pgX5Lnx/DwfDrIzo+ImNYtEYQWORoZYNOVuV5+WRp4JdNF9hifs
 pQMsVyDIPcOfBDg1NjhyulSBpra8K1YwwxzfCexSDmJhUeB1/K/H6hgBaxw1CiOBLe9s/EJLRmC
 tloOCDD9ygxFtl5ehZvlRIMXNbqRJN+hMlGraIahc0CfpPREMLyWwQhKscO4SF/WLCYqIo/uYby
 HS1hfOusam6xuqNbWiglEGr55YkAVqJtIFbTtI7XOrWDdYQiKycvCHu5m0x/xSVAN8SHdJOWC4g
 rVu7SQj1GrW3NWVUoRXYamq4eLtUXPrjPDrcNC1e6ecyHAEX38QeU72BO6M08jhdWqVFxx7Hw2j
 i4O/sA1M1mJghxWC7wQ==
X-Authority-Analysis: v=2.4 cv=c/A+0h9l c=1 sm=1 tr=0 ts=6ae23dfc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=krN7td2c9BGyjRQewgcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: Lb2R25NN6Prq7L2j2MQFoqIjmvGihHb_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3MyBTYWx0ZWRfX8bwsu+Mywfru
 01EWNz2srJjileyN9DtkgYotBUwJxWeZwBv5nPOAX9m47Tr5eDI1xO7dENRxnRJZSNKEpM/0IiD
 U35VmmE0o/wK66l7lmHfXtTozQztyj4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/2026 10:30 PM, Yonggang Luo wrote:
> A multi-target binary registers one accel-$cpu_type parent per linked
> target. accel-target.c is compiled once per target and calls
> accel_register_cpu_type() with that target's target_arch and
> CPU_RESOLVING_TYPE. A bool array keyed by SysEmuTarget records which
> arch already registered. Targets that share one CPU_RESOLVING_TYPE
> reuse the parent from the earlier arch.
> 
> test-multi-target checks that each target's accel parent exists after
> QOM init.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  accel/accel-common.c           | 31 ++++++++++++++++++++++++++++---
>  accel/accel-internal.h         |  2 ++
>  accel/accel-target.c           | 21 +++++++++++++++++++++
>  accel/meson.build              |  1 +
>  tests/unit/test-multi-target.c | 22 ++++++++++++++++++++++
>  5 files changed, 74 insertions(+), 3 deletions(-)
>  create mode 100644 accel/accel-target.c
> 
> diff --git a/accel/accel-common.c b/accel/accel-common.c
> index 00a400243f0..0d04b8c5749 100644
> --- a/accel/accel-common.c
> +++ b/accel/accel-common.c
> @@ -130,9 +130,9 @@ static const TypeInfo accel_types[] = {
>  
>  DEFINE_TYPES(accel_types)
>  
> -static void register_accel_target_type(void)
> +static void register_accel_target_type(const char *cpu_type)
>  {
> -    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
> +    g_autofree char *name = g_strconcat("accel-", cpu_type, NULL);
>      const TypeInfo accel_cpu_type = {
>          .name = name,
>          .parent = TYPE_OBJECT,
> @@ -143,4 +143,29 @@ static void register_accel_target_type(void)
>      type_register_static(&accel_cpu_type);
>  }
>  
> -type_init(register_accel_target_type);
> +void accel_register_cpu_type(SysEmuTarget arch, const char *cpu_type)
> +{
> +    static bool accel_cpu_registered[SYS_EMU_TARGET__MAX];
> +    static const char *accel_cpu_types[SYS_EMU_TARGET__MAX];
> +
> +    if (accel_cpu_registered[arch]) {
> +        return;
> +    }
> +
> +    /*
> +     * Keyed by target_arch. Targets that share CPU_RESOLVING_TYPE already
> +     * have a parent from an earlier target_arch.
> +     */
> +    for (int i = 0; i < SYS_EMU_TARGET__MAX; i++) {
> +        if (accel_cpu_registered[i] &&
> +            g_str_equal(accel_cpu_types[i], cpu_type)) {
> +            accel_cpu_registered[arch] = true;
> +            accel_cpu_types[arch] = cpu_type;
> +            return;
> +        }
> +    }
> +
> +    accel_cpu_registered[arch] = true;
> +    accel_cpu_types[arch] = cpu_type;
> +    register_accel_target_type(cpu_type);
> +}

No need to do this, just move the whole type registration in
accel-target.c and type will be present at runtime for all present targets.
	
Regards,
Pierrick

