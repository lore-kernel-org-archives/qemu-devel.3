Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE98C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHb4-0008QH-5j; Thu, 02 Jul 2026 09:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHb1-0008N5-UQ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:36:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHb0-0001Iq-KQ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:36:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0ZfR478719
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SjtPy9QYdLzORbeOrchJb93/5cjTTKW0GQXyXgQrusc=; b=SdkE6JYd5oBdQIrb
 YN7AtUQl//CEuEOINOmcflIhakbnDneVixPyogPx+3KYdvKutN6gFYdkXCeVVugX
 QqrTuaJPY/9xRXJu0fg0vMi5Ga/j39wt9Eu2IJFAmSwlgGSeWtZibSNeGbizB9zC
 OZQymRcQLyYMKxOx+weSQJJj/J1yh2t/WDBzUTxgvK60gkMcIfatleje6ls6ehWe
 ZPlLCvmf0HjjUZssSM773qLAfD02ppDyVNM4CfTUzs0NEdjvJiED67i5kY52Y9mN
 2XzoScYFOEBUxzo1qOldBGB88Rdtr755JAWtYWBJqn0PDJuiMN9UU/nmXiQ6wkGr
 yKGZ9w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f579rv8db-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:36:49 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-96966afe3d1so1671577241.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782999409; x=1783604209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SjtPy9QYdLzORbeOrchJb93/5cjTTKW0GQXyXgQrusc=;
 b=NMv1I9mCRQsZdctG0ONsX0GZrHMbkLU904ftE/AwkOQMnRnUBmVWXColwYSwX48e/n
 aVdTaSZ9PPShjgTjvPtntdnnsLXM6IqWuZBuXpGluX9d7or3fdk+cRqcxtfRSqT68tIH
 +hmAteoihVw7Jigah6LYwrIYM1vMxYWzgBZcej8M1chJV/gFMTzttZmi7D9uP5FeZ6ue
 Ed4pBip24JMRO+msEiLlngQAJTwsqqRYZPcHacH11jeCtomSHCTt47KA7x7XtfPVB48W
 uz38jJ2GYEQPByNhvDbzhgGYM2jPB4rR0gYFQMZvuwP1+SYFZDxQiIr4GB96IfbXzmFp
 jQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782999409; x=1783604209;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SjtPy9QYdLzORbeOrchJb93/5cjTTKW0GQXyXgQrusc=;
 b=ZdyHNl0IryexEbFTXEZTBc5xXLHKArFNMCzB0Ch7jZ7FLdjWKcEHNNHhiKFIL3xC+y
 FT/UUFUrtwJobtMDgLwTXjRRz2cn5ayOsGC0gcwrZyLuGBD+su+vQYMBCQBuWnGAjndr
 YAO6OG9puGgLnZpR+Ne63f11bJTuN0kg3lRfKQFz61w5xobzT11zD0cBZKT/KSzkpNNC
 oJmhlaEMz/dKruPCIrQJrS8+peTDVQ4jUus18Nl1pvnKpFQeLy+LIM7avmEw37A53ArH
 hVeCJECE8wJOew2WjK4V2gxT1eQUNu3trxOlfPDndzLVtqnFOXUjwxcp2jVkb3eJOcW+
 XQdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqG0ETzeXsqLnxTBPV0qqtYarRAFfHq71jbn43FSgnSK0SOZLJrW6AaxTQGSZyz2Mi3Nv93IekoVpJC@nongnu.org
X-Gm-Message-State: AOJu0Yx/UjCgCvqC+paWJpUJ0DLLcgSk7iD2PwrvBZ40EdbyS8azQX2x
 FKPokJCH+8UFBoBdfbnL03G8ys6OHGL75LbJg3ZVYx2rt2/ugegJeP6f3a+fQ+aUEbADqrRkxE6
 6eBdPZwr6S3DvHqQfyvytLrRXv1+V9g12y0vOFcYToGBjlJbYC2SCZG7Rjg==
X-Gm-Gg: AfdE7cl4uSr8sozzxPeMbqDiVi1qTEtZC6SqhZjoOZZv6tywPRid3oRyz4/Xiis9ztg
 yV5SJBFRVEiK+77jO7Hmkv1gs98c4nEFr+QDaE79D2I22zKXOhMon1Sz5KPNVmSbunG6KFyPeIT
 e16K01c6FZBN+Q9sWR4G7BrQDzeRHaCQ4Y6LQZbFQ1z6RBFINptd6gicdAZbxmmAm8B+dVdSwPX
 Jgj6/7l4EkW12TOun+u4cpkp5cM43kYL6sAKvkSzXTXCTEONJ9nwnZ6JRhO7M/ZEe9FngDj7+eb
 pwQlnjDLw3lZrWQgXjcN4W7q4eJLY0yp3YqBWq5U+biyuJ9jCnMy+jJ+lordqZgdcFwE2PuqkUu
 fbvJzgq5tax1r93hzJX68ZLq6uqi9ZiyqSjRX0ESkp9dV
X-Received: by 2002:a05:6102:50aa:b0:738:9c30:2b7c with SMTP id
 ada2fe7eead31-73da80fa321mr2834497137.6.1782999409000; 
 Thu, 02 Jul 2026 06:36:49 -0700 (PDT)
X-Received: by 2002:a05:6102:50aa:b0:738:9c30:2b7c with SMTP id
 ada2fe7eead31-73da80fa321mr2834476137.6.1782999408594; 
 Thu, 02 Jul 2026 06:36:48 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96983a0b1efsm959106241.12.2026.07.02.06.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:36:48 -0700 (PDT)
Message-ID: <f83e94c0-2e2d-4453-8b30-22e40ab508ac@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:36:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/33] accel/hvf: Remove left-over comment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-5-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0MiBTYWx0ZWRfX7/jhKbFTbO87
 zJJK8enmxgW2VhfgiOjeSfzo3MwoanirBbm/fZh2bv15Jnr51L00w7weeKYX6K1H+Hebi0TOo16
 Tr2IZIfTDch2y/8GXWpz3qS1XzubP/+y+s0Py4XvJLiwAEyWvuPlgvdtXNv8u8KSgl+ISMA/h3H
 qIMQuclCDgnaTjprv0LNzOP0gEqNV66RcdNOY205XzayDugx7XI11gaIJN6n4Lhpl7vNAAe9MkL
 zAKijmd7tQBCO3eEi9vdR29MnrlXpWRAq5AOXUBN2uORCsbWu4O3yXDpynlljEJ/LoCxqbsuYo+
 dXoAiLuQm21xlehZinxrMcCkzsIdsBOH5PxClMPOwE/4xKjQXhVxlH07RmWFDWNF62Oab6kyZps
 ABrU2O1xHBpgu3xoNRvLYJ+FGHU0Qefcvw5g+Vk0/MJ2e9oUuIP5GgxubD231v/XbbmgVQn0B3r
 s/O4VPQdV8RE2RVuKPw==
X-Authority-Analysis: v=2.4 cv=X8pi7mTe c=1 sm=1 tr=0 ts=6a466971 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Rn2ZOfCVTLO_yM1-VsQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: I0iXUNkjSEe_b_etkHdSM-pZ8pBoOD81
X-Proofpoint-ORIG-GUID: I0iXUNkjSEe_b_etkHdSM-pZ8pBoOD81
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0MiBTYWx0ZWRfX9sID6VZwAG5b
 nwV1l5P1N3bHOBJ90ysMebdEzWbjvvfJPdH0v2wsR+vNIjgLlgTf0WYK4H5uZ8am4bbIHIubReL
 D0h3bVxfHBaKsZMBEKoEjXp9AQcWaRA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> Missed in commit 6bf331164c5 ("accel/hvf: Drop hvf_slot and
> hvf_find_overlap_slot").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Trivial stuff even for non-HVF people, so:

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   accel/hvf/hvf-accel-ops.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index b74a5779c3d..dd2b45b7cb5 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -62,8 +62,6 @@
>   
>   HVFState *hvf_state;
>   
> -/* Memory slots */
> -
>   static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
>   {
>       if (!cpu->vcpu_dirty) {


