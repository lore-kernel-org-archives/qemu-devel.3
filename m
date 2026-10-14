Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D596CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4ua-0002Io-4b; Wed, 14 Oct 2026 15:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4uY-0002IB-O9
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:45:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4uW-0001zz-W8
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:45:14 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EF4EBt4167047
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5plLQWO5tvlcV+CqTVn9jusKLGppwruhYJTm+kbRcrg=; b=diUKbl53PumweCZN
 gVg7rgtgb5xwMQGHFdzW746dQjsgWZKZ0wo2nkOubpjuyyyIxONIZn9Izq0BJvk4
 I0annByLoEWJ9tQmIDSCWIvB162KiJ3smswb+8HMygzRjRqWQKWpjphefmFq/1PG
 auA+9Stx6+8yAgVekqTGqrwJawBA+AEyD//EQQml8r9ZoDdn5TjkB5WyJ0hFTCAy
 1po2LRDFREOpcfMMiHJGK23I4dWkV//RjKDqZRQWE+4RJ3KNC89NMbvsJda8Y33L
 pG6fFobbcwUB8H5IHnYTAwSFd0spwVPZiFHhRqWZL7Ioso5i/pbNMhE5lFMz1jUa
 zwYTkw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hac23138k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:45:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ae8e7e546so966348985a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792007110; x=1792611910; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5plLQWO5tvlcV+CqTVn9jusKLGppwruhYJTm+kbRcrg=;
 b=QHRrylzl7M6Auh6STRD1rkqBLO/oOE3nad4HvmnYKoNsAtRiKgSkWnF9bqz0E2VqaH
 y8RR7+euzYl5pMGvY8QO7Fji9rarPw7U40LE/KpIsjYyj0piZMF+YdqBuP9spLcfBjpo
 sJw9I0oBog0xz8062dzIYm9T8u0SL9/QAz2Jybsq8nw21/Kh0oeR1nVHEo7sUbVTh7i3
 eb9B6oK0aYHUiBFb6ryP4p6dRpcjqV3xPypXTWzCXcQnmCOO0IjwGObUo+Tt4bUIdZSS
 19zbivWZlyneJiQRxD8/CUhX7Bs9R86yLyTxE9AUvT4yxhiKflkAvNd7W3ypWf7CqF12
 fLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007110; x=1792611910;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5plLQWO5tvlcV+CqTVn9jusKLGppwruhYJTm+kbRcrg=;
 b=fN+bL7OJvljvpNvAPE8UVTVXEaKQx2qegLhTjSTPqnVtKx+j4BicCgoIJJNSaYPc/h
 9SZuWSEcBpQ4QtaFTiaGVchEjbc7IJqdwxg6CeLO7rWXqwfVuBcWj/cA8eQDPBpbYsPg
 igcSyziZzjgOw5GYc8toIyFerTjrtEid7giElK4T0bqSYdtH79vpB9bkyoO8LYjsoMst
 fkI9/jNyvXcTMGAWyolCg0JSnCkJkr1BR1nVmRXtrrJogveqhSYAGzC0H5ZyxjGSauqx
 h1Z/EEYIu3zhKv1GkQi8wWD982oZlcBXE4H6yLGhnVQz4K+IPkcXfmXeaOAwCQXov5bp
 TYoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHuJhBNXL3Dofc2zpOPqW6Czn9zkgXwEeLELYkQ1t/4IstpznGxs57k4ci+9XEGG6oJbv8SFSd24yy@nongnu.org
X-Gm-Message-State: AFq9FYKu6wae18XXNr7e0OsOVrQiYurSrYCWGJwAyNGGtcAmIEcz1Qba
 VT/cC5BjI5nnDwKAQNiuXCXlr0Kz8yVUMwqyfGk41VdyuKXITVb2nW/JPQVWGw7um+TUJDpFPri
 Vbxx3x1NmfqwD2KHWT8scYXzd2uSOSk9qyuZqadq+aEGtG4rfF2cGU5wJuQ==
X-Gm-Gg: AYBFou20g2xpsJv7VUdq6qH1YWlqjY6PDGsmXwHl1NQrQuA5Kre/NUXfnWnyoOlI6Hz
 Qj4suxsfDKCcV7rQqx96m+TiNlryHdzZfVguL1xPF2YhFVJj9tDO3AF85RhpPFTvf9zBQedJOWU
 B1SDQJtUex0Idj4fhp71e4MC9XtfZEeIQYH4BQ5CJKvvotm66ZlivSmZHJKZuxDeS+2YnwVuVBf
 1nzaSc+/boz8+TydJPu8KthXAMm0A64sqGgU2h0DuLWtTacVvmIat3gzvfIRX23fjI7e56muPpg
 ox9FI9elX2MtACDfQpaLe22mddAH1Zo8PM7lCyI6FTBEjJ7a4LJIv751AWaShkwCaREC1ghKp90
 yGPFBXz3yxdOSuofywutH24HiyrAy1Kv1ow==
X-Received: by 2002:a05:620a:170d:b0:93e:653e:6981 with SMTP id
 af79cd13be357-93ebd0cbff2mr2825612385a.11.1792007109723; 
 Wed, 14 Oct 2026 12:45:09 -0700 (PDT)
X-Received: by 2002:a05:620a:170d:b0:93e:653e:6981 with SMTP id
 af79cd13be357-93ebd0cbff2mr2825606485a.11.1792007109252; 
 Wed, 14 Oct 2026 12:45:09 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd68dce7sm6369145e9.3.2026.10.14.12.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 12:45:08 -0700 (PDT)
Message-ID: <09d841b5-8d8b-4f7b-8c62-e28d0e338d57@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 21:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] semihosting: declare semihosting cpu ops
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-6-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014182543.135965-6-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6acfdbc6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=n4OUKMfNwTi0FTMpOwgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX/I31/aWRpL2k
 JNxciljkzUrZGhTVuT1jRmWYjfKUuqBYGnKNVmi/AH957rQ2GwwrI14tBMto4zbOOq8M2/u3el5
 hYjMD9rvIOwrAV5JKPSh8Q5ZYc5rfPA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX7dJLz2eo9jeP
 6yofOsapl43rnEyQSmNWqNSZ0+Bq6oLh0dz/FoNdfqOqA34IOVw3exC9Gl44Hrpo/be3tudBBc1
 24Wz4dtHqw0yF0LiFDilAI0HdwbWLrIqqE1fPfEW94dFWFQmmXDtYsOa8fxNWeR+bgcpPUlUy41
 b/7vVwuEgOt0da8SaRJ3R/FfWcIXXxmhG1Qbw7KJRxf5uFzssQVQd+3HeRveprVUYF2Cua6RFn0
 ki7B3kLOVjQGt5z52H+7DrQppt/95fC+AMtNQTib3WkX5iYQlMZyICdLyWB+KeCR5A1QQYV/qmt
 +Q/ARvo90pQ+ay9yrv3LsLzCRLc6y/nOPCjocQ718ls988cWXV7QtuSgC+2dlTNwXLiflZR7H6O
 rGzLfvLoD7LaF09MNtU0+xr+aS5VdONNaLCQKTl6L0I91wzW54yHZ83X9RtVnAJwED7RKv20gn7
 qHivwfuNkS+7USusWAQ==
X-Proofpoint-GUID: PmZHc5NPSbWev9PtCztwqwxRDHndUJo5
X-Proofpoint-ORIG-GUID: PmZHc5NPSbWev9PtCztwqwxRDHndUJo5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 14/10/26 20:25, Pierrick Bouvier wrote:
> This allows a specific target to declare its implementation of
> semihosting.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/hw/core/cpu.h             |  6 ++++++
>   include/semihosting/common-semi.h | 17 +++++++++++++++++
>   2 files changed, 23 insertions(+)


> diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
> index 1e7699d7bbd..618f60f76e7 100644
> --- a/include/semihosting/common-semi.h
> +++ b/include/semihosting/common-semi.h
> @@ -34,6 +34,23 @@
>   #ifndef COMMON_SEMI_H
>   #define COMMON_SEMI_H
>   
> +typedef struct SemihostingCPUOps {
> +    /* Return argument @argno */
> +    uint64_t (*arg)(CPUState *cs, int argno);

To be cleaned on top: const

> +    /* Set return value for semihosting call */
> +    void (*set_ret)(CPUState *cs, uint64_t ret);
> +    /* Set an error for a semihosting call */
> +    void (*set_err)(CPUState *cs, int err);
> +    /* True if the guest is using the 64-bit semihosting ABI */
> +    bool (*is_64bit)(CPUState *cs);

const

> +    /* True if SYS_EXIT takes an extended parameter block */
> +    bool (*sys_exit_is_extended)(CPUState *cs);

const

> +    /* Return lowest address until which stack can grow */
> +    uint64_t (*stack_bottom)(CPUState *cs);

const

> +    /* True if SYS_SYNCCACHE is implemented */
> +    bool (*has_synccache)(CPUState *cs);

const

> +} SemihostingCPUOps;
> +



