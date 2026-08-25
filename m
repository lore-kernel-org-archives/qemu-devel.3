Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA05C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyysF-00087l-64; Tue, 25 Aug 2026 17:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyysC-0007t8-QD
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:40:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyysA-0005HE-Gn
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:40:00 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PL9vPW1924612
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sE6GUJhkl6GxUY02yU0z0SlZ8W1ZyKCg2wbCHeQI7z8=; b=Ks4qrzxZdtoNpeMC
 wLDzxYWAkanLR39Ou1lb17PJbK81FAMYrp2kpwhBMUL+PqT4gkoKxPRj15EKMroc
 +fi6n9GLQeIFZlqTW0uh42Zmh/fGhqAO7rgW/gDJYIG7a2mfOj86HOeAFs3W4KQr
 prkoAiWcTpGLe5qI5/nkfIa87HTd0lTTUlmVHQElgTPBzMYfnWHzIY0aDPqzcU3K
 JXPieDcisQAHezY0EtJWmNX6qnHTPAA5JV9u06cWzLPFq+6M2k1hCykKFb0ejOKE
 puaXpeoYc8NRsKW0JB3p5ZCM3P540i91zqdgSznaTmYyBdZj39xrOxa+RPmz49nm
 TiUa0Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9f9urvqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:39:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52d827597fbso3291941cf.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787693996; x=1788298796; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sE6GUJhkl6GxUY02yU0z0SlZ8W1ZyKCg2wbCHeQI7z8=;
 b=T7r1zlhobn8YCSKmTrwx9slJLBZSkOj15dO8foP9NDBR6tv6X09fVmLD6w+Pp6Cw9H
 EjTFtjSE3tX84RU+JgAoy2w3RIrZ82uZ58OD6adxGAXl9z3T6AWhe7SFOlGxlG5X1WoI
 EIvflf/lxD6WFofF0zVuTmDo/Wxt3g9zcE8d7g/dCbXpDcng8fiwjIjMx5F61CU7/U/r
 hWi2BBI+rUWTEOT/SfMHM7sWJryzYUZzXLipIhF/nUbOwTRp9C6xZAXsw1gNUKAuzVvr
 6ik8RkJpxJTWSwcftCvqnASwunO35spTzZdb5yTIlTsuUX1F3Pxf1sUAz2gXXXveJ+eh
 jrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693996; x=1788298796;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sE6GUJhkl6GxUY02yU0z0SlZ8W1ZyKCg2wbCHeQI7z8=;
 b=VNez3/ZP9VEmFlIErtU0yiVgLZYEJWG/ZEQtWscZZ5HuS2ic/kAOK1d/qKkp+xw6sP
 xs3v4fREseBz0mbqm+p4bAeOGuqmu0GgWy+jmSW5mvuihAN7N76E3l7fmW8p45W2hO2l
 chvYmdn/Qv+C0R8652HT7SAw1rGbdpqu0K4sicGJwM1Anoa0fZGh2V4b9go8y7B37Ny6
 QKuI+tgg7OXKyYS4ssDEJAExmvFJdF/CGTUiqj20Sv0wZ5rPFtr4xLv4ZAmxsYPucWZ2
 KhHpoeBbP1/Q6Owi27K7urHCJpD7YrLBJvqIBzZMILsfG/t1EClwtiY7EajS6IlKHW8b
 aNzA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3fMNMDayDONeVyIjjA4normDA/HKrFBjS0EXXoYZ4iY+aAS6Wx07pkhc4xxHLLmtDl2alIDVmfbh+@nongnu.org
X-Gm-Message-State: AFuF++ktYhPCx5F04vbol97LjJC5u/7h8Y+dCXXz2Ebj1EgALRHwllc6
 3k5EIkPLfJ1k4ti77F9pVeo5AqSxBERpSVH3AQn3pOTFeuz5+lsbfURSDqug3704VoZ/F69h6wQ
 PpswbWEW76Uuu4UOLQoS4/4cuGFnDEEQBkMbIYLwpi80vqKCIuIi8oM/5uA==
X-Gm-Gg: AR+sD13eVtTe25tTZ0+tj8AetK4CwA44UsKlKYNL4CWmaT8c1TSovg6JkPTUYpU/UJ7
 Etq2O28CzUQ5DJqpZGBMySu7VVsyq7AiHFaFqhAX9Fozki2ClYuahNGZZ3xAzF2w67sGHNYWrMd
 CGwSbvcaRpP8yTc6kR/8G2bE5UWKxMVZQJr7RSP7HVwQNGMXI4V3DCdpQj3nyglOsUUJtnlq+MV
 TyCN0xcKjpO4CdPze9zOnZuHqS7MkCUjJJhgrV17eL2zuZoqOX98cMRywPg4D8r/Iaa875g96w9
 O7CscAsLFYvsxUbuYTItNFKEyDuo+crJtD1uObZRFlWg49ZM6UJnJVHbPWQ3vxtXXaU+mrCgF56
 chcb1858FSs/FMBX6/zlP2F+43Rs5ZKwbTucFslKhoRy6xHVcI3s=
X-Received: by 2002:a05:622a:110f:b0:519:8998:661b with SMTP id
 d75a77b69052e-52e423226edmr21722551cf.20.1787693996072; 
 Tue, 25 Aug 2026 14:39:56 -0700 (PDT)
X-Received: by 2002:a05:622a:110f:b0:519:8998:661b with SMTP id
 d75a77b69052e-52e423226edmr21722141cf.20.1787693995624; 
 Tue, 25 Aug 2026 14:39:55 -0700 (PDT)
Received: from [192.168.20.232] (82-66-243-121.subs.proxad.net.
 [82.66.243.121]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm5661745e9.2.2026.08.25.14.39.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 14:39:54 -0700 (PDT)
Message-ID: <e3243ebb-9089-43a3-aadc-29cde5e658de@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 23:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] target/arm: Introduce cpu types max-v8 and max-v9
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260825213000.221822-1-richard.henderson@linaro.org>
 <20260825213000.221822-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825213000.221822-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MrNpNxuLNtUwJPqXggShFPqiuvnvVREl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NCBTYWx0ZWRfX/tL7U3ioF9hq
 oq1h0H61GsHRS/beyuBxdrNXGZ3RjbIz+HjFKd5lbeA+XfnF5af0BTmulKXeZB0lblTN0jDMZ3L
 lkOI24z2lJriAAbZdEOnLC+Eeh1Nz+IQgOFxErYxqeWn67Ui72Qky2U28ex0OnumWiaHMIepjTr
 i+1KMFe7YdU3i/kfZbQsafRHB33T0XDoeHVbYFgIZLz14PaWLvQgysluNqZOJpkwh/pV5AbxU9T
 bqy0pigGtL84jYeBirOmh1X5OnmSKutHiAndhNZNktjvA27pBZ8qYKxCpcI7k1zZtmqHtGackOz
 3LvjsRNFUjVilNaxq5iITZG1zv7lWFZ/it1sEDyLVhhtDAtj1PSMMzznE6mNy/dqtXbKM5KDLBu
 MbNctPcm/vk6puuDnSfyBEGJ0urrefDMDJEYhxQ7a2aNwhs942HCvY/JKZA3QZfsNOiL6Vpssjw
 1EupeZYIB4MuLiqnDlw==
X-Authority-Analysis: v=2.4 cv=acNRWxot c=1 sm=1 tr=0 ts=6a8e0bac cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=lbskcjEx90pOFJH4cTSgiA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NCBTYWx0ZWRfX2gX7jJh01Cyx
 W4eb04Hv2QUk79HBjTsOIgCrKp7gdMv+1quEV33MSDhwPGfAsbNeIGh59wAeUtaQmpg8TFtJD9g
 q0cdVxmbij8bpMqIip5L4L37/0kwiA8=
X-Proofpoint-ORIG-GUID: MrNpNxuLNtUwJPqXggShFPqiuvnvVREl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250184
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 25/8/26 23:29, Richard Henderson wrote:
> Introduce the names and allow them with the virt and sbsa-ref
> machine types.  So far, the cpu types both exactly match "max".
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/arm/sbsa-ref.c      | 2 ++
>   hw/arm/virt.c          | 2 ++
>   target/arm/tcg/cpu32.c | 4 ++++
>   target/arm/tcg/cpu64.c | 2 ++
>   4 files changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

