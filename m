Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE7606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 02:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vk9/qoMY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AxLC9z+N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMGh-0007Vq-RJ; Tue, 20 Oct 2026 22:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJMGe-0007Vb-7S
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 22:41:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJMGZ-0008LS-Ju
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 22:41:25 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2FUSe1957080
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 02:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E/Pv+fxlDco5yiVGsaGBI1mriPFfvOSLu3Q2J7paGRs=; b=Vk9/qoMYiRnaYc/3
 52kQGroNCvhsAbvquQxGkqsGwHTxu0VcKZpVMGR64xxgSgtFfHCcNnpNDmTjnB+F
 SktAY3fAOxMbbW+ZkJBj5llZELoQ4maldBM7vW5+47Sxaq6p2smWFU9Q/ThpwWcI
 Bwg2IyzIKa4TGW11Gz+n2oa/F6uWMqsB7FyvcJ0od3U61ZXo2mut1ScUQDeNflKu
 IJMDinmZURg0yiPldKYZw4V1geuFg9YT1eGzGzDUrwU1FfjFv87CACat6dDHZTDa
 vDT/6Zs8yVOUQ+rnvokbxvlYXlXw0DZYnNQxwU/eQxeQYH3xKj+sklzQcVgG9CH2
 Fs8tbA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hvb3c2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 02:41:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b861c0618so5588706d6.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792550480; x=1793155280; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E/Pv+fxlDco5yiVGsaGBI1mriPFfvOSLu3Q2J7paGRs=;
 b=AxLC9z+NBb/Jq3gekz86TiLrkZnubPIKV3fVpeaqYVW9ot8JOFyW0rIbRhYjzJE+w1
 G8OrH7fUDACRGq1xJUsspHnYejL9ZjV3nqhVuvBWArLiMPKWLyaH0Tni+chYIoWGjg5K
 v1p/Grxf746v3X7i5k/PV5xIM/SAMPvuqS3bGmhsp80xHUzz267I+MpdejoQ9uISnVq8
 tFOfRfs5ZthRT99eYmMtJp0EVzmlgLCv+ntVY3r8xSTD1mQuu1iYmCqzcsWvUz1+PS9q
 p7JImmZMzk+U8ctnwYlz+fTlfi7/7RWnA5r8JOjD366A5wIrCmGb3dSAxj3GQxerjNGm
 5Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792550480; x=1793155280;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E/Pv+fxlDco5yiVGsaGBI1mriPFfvOSLu3Q2J7paGRs=;
 b=V/TlAyzAN6Nin9JRyTOo/1G6OCrxKlT1+ojZs0Hq8iepseEnjiDYHTD7uv8s5xOrTX
 +vx8cQt7faQPVmpPNjwtpzb7aJnkejnqXhpH5W8OIM7L2X1cMdfb3TIUhKNWXrazsD3B
 EkF2g9U4xsUYe2Apd7HFfe54bSfN4aJuSq3CIgXEQd6TIxC49d8DK2KTwS2hjv1bAPkT
 jygA8ugG5vBQR9DHwsXL6SDrB5930W2/KVqIdaAqCb/qxZ4FYIH1l3C3gHg9DcxhM9JQ
 uxvt6S8aWm9qOyqcsZYIRUP0T54LzyAQpbpifnP7PITIy/akEDhSiJGUZ/TBROv3eg/0
 JZwg==
X-Forwarded-Encrypted: i=1;
 AKwUvByamX6qHSF+Tm6UzwYZpoMbdtH2KkOx1fAscZWGJf2WeFznNx3vJKiBxb3LhHQy40c6Gz7MjjTKlFE/@nongnu.org
X-Gm-Message-State: AFq9FYKvK+GvUsvIJfHnjXDNdOtDFOeVF9jcGOZ1QYLs/owVZKWuHWva
 Ai1CNbYCz8g9SSYv6ry9FnVmbbwlLHZq+Bfjw1fuG2tAwXjsYMG1ttJeD+iIqj9p/3VgjOAY072
 /hhobPL0kp4bwxNNWflD/xI1MBlNzM8ir6koO3YOAr4i3nwkAbtIRVEveiA==
X-Gm-Gg: AYBFou0xnWoyn26OaRk6VTKcdphcaWUlxGKMl/ky9xlBiHtYYMBBbfL9BWmRO5Q4zaU
 i8luDKedh7DYHu0qRMKhub3GjR8u7239E7sKaE5NvHpwvn7uXrOqxUPzWM4gzR21i1TXajVon9f
 3riDDpFLS8B1qjbRgfxz0kL1hex74xYqWmk8+pLgR9UkrRoq6ttufUuTQEArfBYmaw4nNSj6ii7
 dEkKjc/Eep/axT05GNJdxPBSJ5M1vX+5LRUDAhlFcrGkP8hgKlcG35SkQinLT5KFUPN0sA1b9ll
 lz36gcRpYAQ8QzcOwj2Y2c5Z2OZTl236lOjqlln0GXOTE7rqS14VE4l4ULT14TP9fU7vybkDWKO
 UShBH7UQmdl6Drnfash88nMM6h33cPTnxhdZTTT0oXYat9B2k4h3/UYjyWaUzxhCDk+Av3Ftzri
 JHE5M=
X-Received: by 2002:a05:6214:2f08:b0:917:a16b:e1b8 with SMTP id
 6a1803df08f44-91c12dfaa45mr13479106d6.8.1792550480138; 
 Tue, 20 Oct 2026 19:41:20 -0700 (PDT)
X-Received: by 2002:a05:6214:2f08:b0:917:a16b:e1b8 with SMTP id
 6a1803df08f44-91c12dfaa45mr13478936d6.8.1792550479705; 
 Tue, 20 Oct 2026 19:41:19 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c10a45336sm13845436d6.3.2026.10.20.19.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 19:41:18 -0700 (PDT)
Message-ID: <ceab474d-ea17-41f8-817c-86f90c0feef0@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 21:41:16 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: add automatic retry
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMCBTYWx0ZWRfX2bmOiNsksbYi
 Igpc9VMhUl3DZA+vCgrigoy7UGShFB4FKtLQyKwYw1ChJYnZtc2ddwibspYtgdrsSPN+ivriiq7
 fw1sogzyhv11O8nJBP2u/Hoyg+zafe/GKNy/UvftfMCTXND1Es77GQySjCjYLMyqvbm2SCuSh59
 OVrs7A7hFV9vD0GEBoAlirKdAkyqkBXmTjgOmqgRo2D+0rS5pDwxu3UID7+3k8nqZNhlRO948lr
 6bF2iAcADJVLQVZhaguz3pq1uGZCJnLvYgL3OlnX/cDr8IRvKh1nqT0/rnObAIPNWQDG6tbrvVM
 1rvpxrk8S6lc0ok1kbC7A5LLJzL8Tn8OYZkWr3R4P2SVtY1s4sU4mqGZPE9CRQk6123kHD79Kaf
 k4f6ofXwO8udHo8GcrQHFsyXm43YILJoyK3q4DmrEZ/WNTjslrDjHjIkbjmp6ZHQ48cEt60vANn
 03sROWR2wdVlDd3WuFQ==
X-Proofpoint-ORIG-GUID: 8ytmyMbdHeU0HQaYZ2NjpUfl4QfyNuh6
X-Proofpoint-GUID: 8ytmyMbdHeU0HQaYZ2NjpUfl4QfyNuh6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMCBTYWx0ZWRfXwPA9oHUI4tDJ
 ork8CEU8iLksZengHDIUyfaHvPMzHfEhegrDFFh/1lpy7LTrHfzfoolUY1U43BzZ50nrtgIlGv0
 7qFMBYPR8mm34DvGSUxs9HWwfzipcos=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad82651 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=oP5yz2Yi8CnxVeh9_jYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210010
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/20/2026 6:16 PM, Pierrick Bouvier wrote:
> When merging PR on the project, it's possible to observe failures on CI
> that can be related to sporadic test failures or infrastructure issues
> (pod eviction with Kubernetes). As a result, it adds latency on the
> process and workload for our top maintainers.
>
> This patch sets an automatic retry (supported by gitlab out of the box),
> so failing jobs are automatically retriggered.
>
> It's important to note that in case there is a real test or build
> failure, concerned jobs will run a second time, and fail again. That
> said, it happens seldomly since sub maintainers are supposed to test for
> this before sending it. Also, the retry is limited to the job that
> failed, so it should be cheap in terms of CI minutes.

Will this effectively mask those flaky failures so that no one hears 
about them?  Is there a way to find out about them with something like a 
weekly/monthly digest of failures?


>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   .gitlab-ci.d/base.yml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
> index 8fe00809357..63ba82e3632 100644
> --- a/.gitlab-ci.d/base.yml
> +++ b/.gitlab-ci.d/base.yml
> @@ -31,8 +31,9 @@ variables:
>       # Ensure docker.py / tests/docker/Makefile.include always displays stdout
>       # from any docker commands to aid debugging of failures
>       DOCKER_V: 1
> -
>     interruptible: true
> +  # automatic retry on failure (sporadic test failures or infra issues)
> +  retry: 2
>   
>     rules:
>       #############################################################

