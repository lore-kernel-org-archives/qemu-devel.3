Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B74606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=afNsH0QW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OXqIRwvK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFAw-00018V-Dc; Tue, 20 Oct 2026 15:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFAq-00012i-PQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:07:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFAk-00068K-AG
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:06:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7Nsu3460915
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8oYdvoZS/Q0vAM4+csZpfjAnN0wDOGVgp2gNk5VMa+M=; b=afNsH0QWlAZPJCvf
 nB4nrm7xoS7OfSVD0T/EwRGPCBiHyq9fcmYIjsDd4BleXrdoU4NPyuwc4JN2MD0/
 +64DuIgBZi6NsuYug49YH56/7Vn3C4UhCFjJwIyJQ9uaqwRC4kpvOiAIqNfDQr1/
 VnanRKirjHn4+ew3V6+pPwjjlY1t5RBknME12uzmC5qrb2B05jwaGJXETiwldj0B
 Utl+tLT1Y3+FoTEA+08vjidkI3V+EfDAglgzYi1QABk5vWvaY9/o9/GvAzlPOAkf
 mNaP/ZwOy25nu1RoWD0dwX7RsoW7m/BxWw5fvRrFrz/Jgr2ZuqcmOcfpe0QnbagZ
 2OC16w==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4r73c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:06:52 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-18eb2616974so8036c88.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523212; x=1793128012; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8oYdvoZS/Q0vAM4+csZpfjAnN0wDOGVgp2gNk5VMa+M=;
 b=OXqIRwvK+Rf5xlwu+6s0LVoOT+0QrIrUP78usTNsXRFAQOUYDE5aXKym6qpO9UU1UR
 r0VVCKMbuNEis9yPwYIBLRmvNUlgBZqrVL2hE+Y80e52pjRW5dTzXZKoKU+X0F6F6k7R
 VgBsYS+Sq1qHUUkdgYurd4NUjBMruvch0BtYyP2n7+R6Ss52fbe+bBlSzhxgiq21OziR
 54tynPdc+5jKB5Axfhfx6tgs2tVMNonR3HOBRhSbRP/agHk2g5i1Xxar7/if/8UXyHeC
 a02UNUERGiOkpzKEp9YagYhdLhYOnxIyvFe+B/fV04f5ku1rSq+aEwLNIyG51/RlkJQi
 xesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523212; x=1793128012;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8oYdvoZS/Q0vAM4+csZpfjAnN0wDOGVgp2gNk5VMa+M=;
 b=xw9XhDoGmkrgyOIokJar9pqxkE8r1Z7FslP70rFVR33A5q2dz+6+O1H9pPcJhbnWn4
 fZvc3JkFWPeoNSY8Ja3vDo5/VxJQuQBW/XcVNtZJZGET5fwHHyYp7HyqmgLWJZQ+WbDM
 g4PhJeTKz2wmwRun+Q1UT4raU1YFLzxYEI4Z09M5UjD+b8qTdsWx0C72LUBNNDzqqSoW
 HiFh/ypbmb0deqwiM153M7THN29BtVKsraOlOHVsPV4CKbTV2dfGVqjdwkYZRk6D1h9x
 ZrlXIyn3oZXPwf68VWo5MHsIi2DKBmVlY75F5IFIliNyY1IBAO6Ex1p0+89M1HcWsKdy
 nmrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDqjcJrzoT1b7YtlGnRjN7q2IiJt0Mk340RzvEU03GvQVzlD1cKTbtO3otwSxhvS0oAD5VtAtkAQcl@nongnu.org
X-Gm-Message-State: AFq9FYIH1ceJynLLBBIrA1w4G3g1/sUwvthdRd21a/JTM+O8Vhfb+NGp
 6cJMs7MfP+FBwPKrWmhtRj7Ir/9ePghIrEi3lSrhKUsArjW0AqKC+owQkISvSi3qkxfXNQvkDpz
 monIGWKuAV28c8jakOrg+A8w+QHuGtQNRCfd2lWgUV0YmBj45RhxRuwsaFg==
X-Gm-Gg: AYBFou0R3SYhJD2exQKgYRB3fEYTFDRA3wWKjepL7MGLGzYgfyYHEGEHMhecAKds9CT
 xF+J4WMNZUXnXdP/dYCn4xaHOITg8HFl3CLHbhmz6qTic32l20rnLAhzQiEe51FZ0TlKeIppOJB
 J8n8oYyMTsrm+zvsiTgkrcYmGbyMQ3RQPauixbBhA4XMFZnWn+Sfn9Or36YrEudZGvgyfenGYAg
 a8VoUOdes5ee+TfxdN+fzcgiZnFDrJyd53AYlO9XXDHv4/cU3G93xAxqGly/newNL4PaDkP2BdA
 bSfS9RWBvPfwgjaj2wrYjJCVK95vfCUsiAntpph5b4SMIvfgjSYIcMi6uPSfh1x1CoYt+PF7978
 yu0H3c649wXHq0lDv6GAmEqY3f4faECfGtlCVYMXQPETfGkoXNXPqYIem8vCNc/LDjcq54g==
X-Received: by 2002:a05:7022:f50b:b0:17c:a0c5:8c9a with SMTP id
 a92af1059eb24-18514914deamr16951192c88.42.1792523211879; 
 Tue, 20 Oct 2026 12:06:51 -0700 (PDT)
X-Received: by 2002:a05:7022:f50b:b0:17c:a0c5:8c9a with SMTP id
 a92af1059eb24-18514914deamr16951165c88.42.1792523211389; 
 Tue, 20 Oct 2026 12:06:51 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ec6c3sm667904eec.7.2026.10.20.12.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:06:50 -0700 (PDT)
Message-ID: <515e3adb-2463-4a6e-b921-57fb596f494b@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:06:49 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/27] target/avr: Implement and register
 CPUClass::exception_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Michael Rolnik <mrolnik@gmail.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-6-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: E-OaWfwDyoW1N0Cq1Y5RBGKfgBnnnyFM
X-Proofpoint-GUID: E-OaWfwDyoW1N0Cq1Y5RBGKfgBnnnyFM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX0TzOyf7uYumC
 FfHJ1iYMobflP7tx5WkAqSzr6ZDfW8VseaSZ/M03pqupXyux8vcgMEPTRhYBlTDHU4GQubQGKFb
 ubD0tY5q4Dd01Jm0tMmdbExOD7fq/OM=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad7bbcc cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=0SWiVAHH5O7ObZikbn4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX+I7Ye+2OYbXT
 fUp3yT51w8wMhPYuZSdqsK6ogQKpBnmrg3vojO75D9jLvybBjW49ZFHyMIieGins0QTBh5w9Ypz
 nZZ3HIx7Vf7dcRS+XbE69EclPLcY/j82QvuFdB5VqQnNt9zXLy+0asfUk+lHNVf2a+Gl4r7hPIs
 85LZ5/zbjLcunycB6G2nZWfjseAWwbXBj4U237GpmX16JjFmoFEY0MGY3yyRAZgIBiGC08wWELO
 oFCcKoe01G99hsa9Z+td41O3QELofxnhYLWMLAxXIJr/5PujqPxYlzARWuRaVuKPObYcC2nO7//
 M35a5rySy0N5zO+N2gxwi5mAoEdcNfKMcdAHjpZki4RwTS9gQQgrpxBYXz8OYVRRAgX9hcCR1pt
 12qKegWIcbsDWUgp05SF00HmexqbN5WGjFGN27Kfd7wHDC3dcbF3A+phzLoPkPPzXeHgcsRoz7s
 VGLrrztHVFO/CWL2sCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/7/2026 2:44 AM, Philippe Mathieu-Daudé wrote:
> Implement avr_exception_name() and register it as
> the CPUClass::exception_name() handler, so the common
> exception logging can resolve AVR exception codes to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/avr/cpu.h |  2 ++
>  target/avr/cpu.c | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

