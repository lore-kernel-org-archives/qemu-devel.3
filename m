Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AF1CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUPi-0003EQ-N6; Tue, 29 Sep 2026 05:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBUPf-0003Dm-7A
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 05:46:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBUPc-0004Xn-Jo
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 05:46:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7Tkc34097687
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2Y1FcsuV38AmqOLMXjOaZon+EyNY7eXKdZDy7l7sajw=; b=lZfbT9BBe1Lxc5fp
 stB3FCdPjCnhOGj7IyZE89jzyxTxqilKhNcqY518WIaJSo2TxFnr2pFFQd7oMfww
 yF7ionYiC6Ysuu8ambdXXT2D8FaQwKSDb6Lg1IWl7d3m6/yajwMoC+3t4FQrHjEO
 W9VPRX1AGtpcaS2udQup361K60tQtI2NEplLjr8nxNksWZGlieNL/YJa3SxCoUNq
 r/skl//Mti7vr7Ha5rlcsxRc1C+JomMyPYhCgHQCjEN26nOOMq7MGHdz+HIBJWrN
 E55FR8PnEK1QXosifxkppIvwRPGydS4J92529jQb52G/1syljWGLW8EbxCxq5Vqp
 Av2d+Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew1t53-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:46:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a0c7126e7so729204985a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790675170; x=1791279970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Y1FcsuV38AmqOLMXjOaZon+EyNY7eXKdZDy7l7sajw=;
 b=RxgirqmjhJRogrsJG28XAh32x2s9HGkE/9Hh16Tutzb0Hz/vuTKJYiY+5MNloTaLYp
 f1GBoaFNoyfDBiLroC8DTlWKgwYHu6GgcDBu6nyJMzyLk8wmEyYaZUuwwWGugN9xHy64
 RDNkw0ZBci2pjGa5+vTF/doZJDFjAFrvzuVCZEc/yug+di2EFIkBfCmqY0JXh5uOWO3k
 gkQbHAHw/bWo7DoDdBruzdcHJtV4cV7jTzYcgucZttE+Nut33qANSH8vWsdMbsw6iGiJ
 HkSD/RQGyIj/uEwKcVX0qK2Q+VHdgC1PLMyymbUSCfwvSahfXkCXxbmHqUPfFJxYXq8J
 ITHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790675170; x=1791279970;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Y1FcsuV38AmqOLMXjOaZon+EyNY7eXKdZDy7l7sajw=;
 b=qnMB3tR3SMJqGobn8OF47tFWdoZTeSzrHF1wzB8ZoFyJOHg49RnoFp3xxc0rbaFp7X
 /2diz8aSXhxwITEkR0ginm9rli6C3KIQSKEP+V8k+m5dNof2Yh/7jks6Teep54Z0k4Vs
 AAVJZF8obJWUZEIXusuD3hQDqynQNvezYWMA2oSuDqe7aF3tDtbgPWB6Up7ljA98w48x
 RFnswCGhy+rRmsdKC8IT6nzoCJt1w0lWHRTjzNPOH+sXE4X4ilFZpwA9O/+l0PxAEGUd
 8FNEs1nDbKj4I3cjdT9jDFGljKTAsSAT/oely36NxBAKBIvZ1tepjllKe7vjcA44Ku5e
 niew==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+F1ZIN4P28xZPTqME9TZeUGLag8f077i5uTQcW8vvkXuaq9dUz5zIcPl3dj678rI3tUKV2sU7ZFkx@nongnu.org
X-Gm-Message-State: AFuF++kbuoPkIDmDls6GSE8xchojqTHjkJSRg8/JZAP5AZkEhdK00R2i
 5FbbvZ2POxX49OHthu+ZDMbiqbWztyf1OjTHT5U4r8qRE9BqQoZGGyeIC/MEgoyavD4fN2kFzyR
 ngraJIvyjgsYcejtXiqQxcOCfULZEiZqMP8kjXSRyM/lvEUKDcUQlQdvV2Q==
X-Gm-Gg: AYBFou3HO6hFpg4T1NOjRhrQ81MUDQizyefx7bb0qy3UpglA7agN62++bkia4lLtPmm
 /dbwYLpmKTA9Kr9aDQNrOM/dap+eQJuO+f9f92Ov52ITWtjFR4KSDNPbLyDw5xDVfkOh5Ao5fdu
 NTV5fH7x0Hl+QX4gMHBjjwMIiqjU+Rut5c1Sj2xX7N4yDxydOWObKAihGZX1pbJCMjsjxKn3W5y
 HJvg9zSKLdGzTzpJiTX/VBIzto7y4ehkvAIvEBzLiG6YMSM4BwhFJyNudztKKXjN+8mnx5CL47V
 zx/sDB9iVG6aCAG8WubS78BMjYstkL0AUeD5qbkTUx/gzlHw05ZLYbm5JuiTuEsv3FKlzxgPvRQ
 JEhN0jsMG/ZTh2L/GNk9dIxgVoh3nsxrRBg==
X-Received: by 2002:a05:620a:45a4:b0:93c:6450:9cf2 with SMTP id
 af79cd13be357-93c6450c354mr1714788385a.28.1790675170583; 
 Tue, 29 Sep 2026 02:46:10 -0700 (PDT)
X-Received: by 2002:a05:620a:45a4:b0:93c:6450:9cf2 with SMTP id
 af79cd13be357-93c6450c354mr1714785785a.28.1790675170100; 
 Tue, 29 Sep 2026 02:46:10 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af502da06sm3253383f8f.11.2026.09.29.02.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 02:46:09 -0700 (PDT)
Message-ID: <73334e69-3827-4c2b-81aa-61b30045817f@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 11:46:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/19] tests/docker/dockerfiles/debian-all-test: add
 mips64r6 toolchains
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
 <20260929074007.118970-12-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260929074007.118970-12-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfX60TR2HFYA8oA
 G/tSkaNuqPsTywnqwxXgtjGue5tHKwmluJTV0to8nXinw2UHmDbuOp8aFKJzKOqdGZYpDCpqXpd
 4sIUh7ZWgPxB4n2Lb61jBFFuCuD5UqA=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abb88e3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfX5BElsOPhjVnR
 Jqy0VZCJMJdX9i0Kc3ruCR3nNF2bMYRlXzQ3JGvoxGnbW/YTcjvMrnfyr6LZXtJYunDfxiLIW+K
 aerm0Iul6+pAPXyWo/2iLgIXtcj7jWjLhBHcY/A125FRR3JNoOZOAVNHb+6+oaMlKYJZRQRp66F
 n2hDVT2tkTnzU52/O1Rwh3emMdMOAXIKur/hS7/dP3LrpA6eY9qkC5UKUg4kn8pRr/PUB1cbPd9
 Zch/DCxg7U+g3eexPvDbuqDvTWfwUQ3pNQxVjBUfgx1GY0jzm4gOR/o4muVkqdo5kTI3NywZM5/
 MBIHkI4KwCo3NoreOwLzUYBbJhb8T6COq0/RiX0vM/6uDs1QirN16bGH4qAjtaIri1HlIrCTGYM
 krlPfsyZe0CvOjtyHbqMK8hxUOqf1AelSlsF82oqXWZayPJEBh5viEeah/ZRzQT9boMp8gxxee2
 a1eGb9nVAEDq9xHDs2Q==
X-Proofpoint-GUID: ES2B8mNXTJn6Nuy0k9Jit5x0hVQ-4N7H
X-Proofpoint-ORIG-GUID: ES2B8mNXTJn6Nuy0k9Jit5x0hVQ-4N7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290038
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

On 29/9/26 09:39, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/docker/dockerfiles/debian-all-test-cross.docker | 4 ++++
>   tests/lcitool/refresh                                 | 4 ++++
>   2 files changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

