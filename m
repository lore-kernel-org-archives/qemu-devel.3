Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35287C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNSE-00068P-7t; Fri, 24 Jan 2025 12:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tbNSB-00064P-V1
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:26:47 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tbNS9-0008B8-A4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:26:47 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OBkvpk003372
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 17:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1iNjhcmeuwab8iVPAdNGqiqQK1M7BBG3ikuwGU5J3CA=; b=CMe4mr7nKtSPFejP
 k3EynlLL2zy0Cx8ORP9cVxrFNqyPgaczaX5NmhzShCAc+VN9/LniJjK2KTXjKCRy
 M5ctygqNPerT7DVpnadRVa4v5Rr0KZfhQQUtHIL7tu8NRJC3wy8ari9lKfl8NziA
 csGBDsWhl3ZUaUUPBkdin50crPuol8m0ZUoNiRuO22/RItXYvZUcbop1MbLhgwbh
 kq85A7qB8dX2m8/ebeGjfmcdrq2KkG9kmVk+Dfmk++eL7R7YFZtxp7tp4jzKpOG1
 lsH7sDC24asFGgxwKqkph22yNyLKnQkHrHV7VTwink/0BspClVKpLwRAvkg4xMur
 9nrE6g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ca9prrra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 17:26:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6c51069f5so380022985a.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737739600; x=1738344400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1iNjhcmeuwab8iVPAdNGqiqQK1M7BBG3ikuwGU5J3CA=;
 b=iRB7Kq3Kf61m5gjJXHZkXeN80+mUiolQ4xziMVxo7cstrTQz7XKqpvb4cu3/bBph6w
 +nU07FCGUcklCt9yDaCRctYhsEuQKUmvtK5joARXgVu78frJnhWGHt/O0xApQY6uzJwK
 vH86QD+nCVb407cgXpc9FcYO/GaOVmYQfUAV5r7k0gtRmKleE0g0B5Q5Ur9HQHR9B3OC
 ccbp81H4nvO4D557iHVpB+3EHmuULV0jkqYlhywvcU4/pI0nr32pxCD5f0K5Qi0rQym0
 mjNd4dbdIzHN7lZ4q8wakNylcSU5eMZxqwnt2r8jCWulZzj7fLEmv/zKjFF9ezaR66Kj
 6i/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWfk78G9D1wSkw/IZ+58/AraarDxBVFft/1YUVXViNJAm+N8ZrEHynsa1ZJdQ0kEVXxgpIU6kYEAhf@nongnu.org
X-Gm-Message-State: AOJu0Yy1JbXDWwVKcYKYWGmwM2PnF2wwtFG2dTq5QOyoNykJ3UkisttW
 8NEJOeQs8jdIldk65lKj8gFgD0O+9+B+JXyFvefFslDXjq/G7U38+A5fKc9PHtzYoWaagZPZ80w
 CZNYZFTHKY9uGBHvrV6vMaW1eKm/NIGKTqxABlfAQTKLVLfJ8AtM4i0WiPnvZ9g==
X-Gm-Gg: ASbGncs4SkV0HwtgvxMna9yi9yFzb35n0vIPa99qVNf9PvLT+ekxHUml/n5KZTW8kwB
 iWwf35nOy+hLm1jfmHfdyUa1/4ca9xL4UaPBHEa1kRkgQwwuendS9G4CR8p+/YSP/8zAFeIoDu2
 fhAWCFkGGmNBoMA7ymSr8Ol5zk3P+rd3Qb/p2JIXtgaq+nHgVUcU/R9X9rX5hu48id+DD5UnJ8Z
 xDNgvxZ/y2PkjxU6oj3U2CHxlRTQPzjInYPd0SV6ChUwlU6RmB+83C7KlyN6g7v+VIspNF97kru
 zAUDLdRqZtOkeygEMNVlNxDeKGOJByNnLGNtGxr0qc9q6LwK9Q+O
X-Received: by 2002:a05:620a:4142:b0:7bc:e736:27f2 with SMTP id
 af79cd13be357-7be6323b6bemr5014858885a.18.1737739600632; 
 Fri, 24 Jan 2025 09:26:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnugcB8jaLHWW+etB28PMFIOJXFgZysMzv0TgtCuOoxjHUc+B6JaYXZublZ91A8dwHJ7No1w==
X-Received: by 2002:a05:620a:4142:b0:7bc:e736:27f2 with SMTP id
 af79cd13be357-7be6323b6bemr5014856785a.18.1737739600328; 
 Fri, 24 Jan 2025 09:26:40 -0800 (PST)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae8c048sm114208085a.47.2025.01.24.09.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:26:40 -0800 (PST)
Message-ID: <f2b27d7b-8788-414c-b8ae-a76780a5278f@oss.qualcomm.com>
Date: Fri, 24 Jan 2025 11:26:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/28] target/hexagon: Remove CPUClass:has_work() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-12-philmd@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20250121142341.17001-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5N91Rm6DQDYTWNCVzN4R3OSYVpC6ljEB
X-Proofpoint-ORIG-GUID: 5N91Rm6DQDYTWNCVzN4R3OSYVpC6ljEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501240122
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


On 1/21/2025 8:23 AM, Philippe Mathieu-Daudé wrote:
> Remove as unreachable code.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/cpu.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 0b7fc98f6ce..f77e305d611 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -262,11 +262,6 @@ static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
>       cpu_env(cs)->gpr[HEX_REG_PC] = tb->pc;
>   }
>   
> -static bool hexagon_cpu_has_work(CPUState *cs)
> -{
> -    return true;
> -}
> -
>   static void hexagon_restore_state_to_opc(CPUState *cs,
>                                            const TranslationBlock *tb,
>                                            const uint64_t *data)
> @@ -345,7 +340,6 @@ static void hexagon_cpu_class_init(ObjectClass *c, void *data)
>                                          &mcc->parent_phases);
>   
>       cc->class_by_name = hexagon_cpu_class_by_name;
> -    cc->has_work = hexagon_cpu_has_work;
>       cc->dump_state = hexagon_dump_state;
>       cc->set_pc = hexagon_cpu_set_pc;
>       cc->get_pc = hexagon_cpu_get_pc;

