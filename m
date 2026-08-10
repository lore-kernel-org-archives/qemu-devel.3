Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ADEC5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtFuc-0006hb-Rh; Sun, 09 Aug 2026 22:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtFuY-0006gm-7x
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:38:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtFuW-0002ky-Sv
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:38:45 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679L6fAs3434527
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s1yY533yzyHTN39oX1JItBjyZP91Mpjs49d9m9Z0hYk=; b=mQqfaSc4FSAdvB61
 v7qymK/M0pLmoLO5FAcPlzGf6QYYsdfila9WEzGVS9UcyTLRV4/uRp+mC0J354IL
 pmY/D8wNedT0EOqwVXPlblFuhLS5d4yZdssX/3Zc4hE1SNdXuTzJpOMlLKRL0uA+
 KdL8G3GhLWIkXfbywlTkONPhGx9uqo+JrCAgDynfvhYCSsgAQ7nJpPq0QHjAJB06
 zheO+gU7iG/OM3XinGHGLpZ8IKxQO4b28SPr99t8dit3UwO/ori8DUno9zam+Qlc
 PemxzCnOLJMTM9yvaGz+k0JVj+qPn1lJHsOMW4/4zNWr4ni6MJeSTIrs72mbDaX0
 Loscbw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwwr9ky29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:38:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0e702df8so20831131cf.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 19:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786329522; x=1786934322; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s1yY533yzyHTN39oX1JItBjyZP91Mpjs49d9m9Z0hYk=;
 b=AO4FD5uUuQn7mcfS1qfXSgrtRFHclAb9suMeFNB+FjgwpRYGnWlEpW9SCv6QOACdwq
 FNQRW/asKFYQy2RN7F58rnDzglKWekRCrTVLJdlZ4ygSQPZSImTz4GDCNFZEuDHaubYQ
 L1qeYL7d6wIsOHczV5x9KdcnusubC/BbnpHyLga0mYnfqEyEFfkJHevHzXUnmAiHyU/b
 jv29B4BmHbR3qNW1BjCz4ZeT/ThTEId4vcmjRo8BNcJ88jr0ad7XHUlJLHKpKVg8dkId
 dL4zEIlZN3eCesauE20pBxYBow8Zh8zRmzOgZ2ipRAYHfwBSvM6Srp5dPC1kiw4DC/go
 rCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786329522; x=1786934322;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s1yY533yzyHTN39oX1JItBjyZP91Mpjs49d9m9Z0hYk=;
 b=J5+GtVZwbTKje7BxmySZBF2ziYVhqiA0Cy2dRpanuzVL/e/NIXI1856H3yxM10Zsj/
 oNnJigrNrUYj/vjqFcVapaVeYGpxAUzptIWDvsErXLlNCdhVa4vjzMjaXaM1aHZ9bO+8
 tfN5UQrsqQUl9GlYRrzyt2UwLKOayPGqXSR55gDLrrm//IQ9imNK4WEF7Zczfo8Phh43
 bkp55df64e7gezHJw4pr4zSSe8AS20M9YHP+ASniZB6oy7DCGVNzRkfJgGTnAtP7lr4C
 U4PNcCIJgo1I11jtbVKhrc/h0BI/e2zIRbw+VQedoFL1wmh/J4Gp6Mc1Bgb5h47wemj7
 QAAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RofAUC/A9A0Kty9529X9dAFN74vAmonjoZB3gS1p+v9nTIpO7aiefiTqK2ysOcF6AaPY8Af7qjP6xKZ@nongnu.org
X-Gm-Message-State: AOJu0YwSQ4o5kKspE0TClodVaMO5tUcovlxvjFom8PPP1giknt5Mw7C1
 b8rxXdf0vADmZ3LNzDL4Xa68WP3U/L6q3oJ9U8Hf6LcjwLkn2zLO54G/7qMB/eU8OzBXJsacmqs
 MbvoLRlzBcnNx4R9rgPpo77N8uk3nYSrhFjtKWjHiwKlPUh4Cx7GubW3tajbhLKd7jg==
X-Gm-Gg: AR+sD13XqQPCSjSYBO0eH5eI255QMskHY3VP6KCylzCOQKdiQeH/4x7/HoOsfxxopQL
 he4/CPzlGP3DdOecgETrjDIwfAkrJKpGJULJ2KujNYPaZ+XKuqdM1Z2RgQNhVBS7pgL7fpLz/Bn
 8l5u3/nwkGiWtJ5jKo7QVMMw7+HjeYVYtepdAr1UhIxOtkA/qETlOMmchDsg7lxL68klE0eg1cI
 UpnrkoZ9yvMnUB/6cvWMeAbK5cDf5NdLnHSVhKnbxwzl7llNv464WpmC1obgUkA3KD5LmLKMa72
 AzjxWSZ7oY7gCbNirPw8JT0gtxYWgqZrvTZljgcfwCK7lAR0niRu4xRbqeIWAyRkqEk6r3UhpDq
 mQadr1ve9GkQI3RDmJTA47gSA0bslYxIOQKU=
X-Received: by 2002:a05:622a:88:b0:51c:1529:2c0 with SMTP id
 d75a77b69052e-52ce620aa60mr347625011cf.43.1786329522428; 
 Sun, 09 Aug 2026 19:38:42 -0700 (PDT)
X-Received: by 2002:a05:622a:88:b0:51c:1529:2c0 with SMTP id
 d75a77b69052e-52ce620aa60mr347624801cf.43.1786329522076; 
 Sun, 09 Aug 2026 19:38:42 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021506cbsm30467105f8f.14.2026.08.09.19.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 19:38:41 -0700 (PDT)
Message-ID: <035d2d29-9493-41ef-b028-c08d22aca30a@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 04:38:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/tricore: Enable disassembly via capstone
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20260809013343.664966-1-richard.henderson@linaro.org>
 <20260809013343.664966-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809013343.664966-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d73FDxjE c=1 sm=1 tr=0 ts=6a7939b3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WRSnkZHFZRcPKBlGHT-1l27M-DUN6THz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMSBTYWx0ZWRfX3pLjGlk7twUo
 xJMGUcm1UPoTxvKRjtIMh9616W6Jt9U55uYW5Nla4lGBPCi+gBpQ3HgjKZdCfKCOSVJ5FX1JelO
 ttzsfyQ79x66EATIU96pqPY5xpRkMFXQJcBxNArV2shaJFwJ5/nxOedaMRjJX2JOi6YCT1mFbbR
 RXtgeIqY4gUvXylPKeRRImEpDuZqOvgF0kFNq6TkG+4Qvx4TRfY1liyVPJDC+95UgPQIMJE9dKL
 blZ0AahuRiVrsWlTrHkS2nFu6AS8ra87RclAPjZ7/OS8hR81OAL/XMJJEWE9yQhSPangBl9af4O
 QHXrVPoPuPu+hK2Fh32ZQEC97LOKVUfuoGYRT3QizAMckCkgaFrtRhYyYiWJOOuXtcWou35MAWI
 JKtFUEhyA6y11k4i5k3Z8deRGdHWWuyMTnNuIpwRae/LnbTZwdB9euDWaX+vKUKJYKbdFbmYzrQ
 FaL+QfAEzRVAXCMpUXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMSBTYWx0ZWRfX87IMEpa+8jEA
 Rb+iffa+KBK/sJIPnP+RY0juYA0aF12M76TkerbEqRCyCxQM94k8KEngkk0/O+pzZM8AbIrZY+i
 IMOT+FaxIJhrXS1pVBiB5N/vcFQ6Q20=
X-Proofpoint-GUID: WRSnkZHFZRcPKBlGHT-1l27M-DUN6THz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100021
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

On 9/8/26 03:33, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/disas/capstone.h | 11 +++++++++++
>   target/tricore/cpu.c     | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

