Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469E3C55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqX13-0001U2-2A; Sun, 02 Aug 2026 10:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX0y-0001IJ-12
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:18:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX0u-0006Sn-TW
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:18:07 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B6osU1791329
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cyGJbPOh/GA2iXPjLis00KdtdPYuuDRO8asMSLi3EX4=; b=AY+p8aF/wKxhDdtV
 58qgYuwj1v8mulUh7mJ74LSYgLXkSK1HQdY39m6PxngDZzCbXyJNQ3nmhHABCT4c
 HX9EtBMOwoOuRfn8qVOzyRqpG6t5KEzAnZjE5p8GS5+B5yaesZaLXZ9teFehaX5d
 PDFt1q+8YRuaJpoMqfPIBesjg1dGoh9glJjMZjpeTiaPyMdaTAXNLKzYw74++YMo
 wSfGaviXa4zhiG2RorzsNtp8NYv1TQLVsglSNcy4DONnCObMef70Z8v0jkWNHGDG
 s89y5ohmmz9vcv8TWWi9pLyl+NRIkpDJKOtWywHSAse9H2uWF+aK0nzsGzsR5C6U
 0bxB9Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8tx30u4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:18:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d137a68so47607371cf.3
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680283; x=1786285083; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyGJbPOh/GA2iXPjLis00KdtdPYuuDRO8asMSLi3EX4=;
 b=V/4hf82jdnLsEmDRAQQylbNL/4CzcopAwMDkAbQ7pZC83h3p5SXtL85CV3UdftswAV
 Ve5sNa+TplxIGbva0q+ovrM7lP56yqLb2DCi9Jwc1YRBWei71pAi6nka1EOXLRGna/zg
 c3omaQ4ceHWN50r02FE05L2wAbilSwyyVfFjflzXjA42FcTdihDnPCQ+l9iRoM4Dh3+q
 vW0mFY541FOeUOSSPXsPPlg04YcGRGi+cpvPBn3bwd7WGuIvmsG9wcwMaICRTuSd3I1q
 lK/4AgNV9c3tdCrTpkM/yzbDVEO9sDEda7M0eEOHeDgb/qHV0sCf6Ix+/sMT0qKPHPM7
 amXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680283; x=1786285083;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyGJbPOh/GA2iXPjLis00KdtdPYuuDRO8asMSLi3EX4=;
 b=XL54FBaevsezxFoUzmdKV/6T8icJQA+jpglk6R5eYBMk7jaAZw9gjcYKPVvk5jBlWK
 +I9BuEEAD0MllQYKSDJFvqdbWFROm/ksQ3o/8R55jN/P4zvfogX+3QJWeY56eNDlHxKN
 5AUy65HGKNgjAtLo8ASirNytUKVi5aJIQtgnzZhq9zP3WyfVH+q2s+JkpDTfCWwjRTcw
 CYbQHYU6Cx5H/lkZug7NHYIo+46+29vV2brQaAWVZz6p84/AM44dt1mCq318byEIh6//
 UoFIPB6pAPRMcl+FpmkPF1WrF8qsmgzorW3tNGcNe7fRQZN2Tum/P6rANg5/OyL9pn5j
 9qDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJMw0uGH4kDfiseNn9uQaJFlzCDZc85bJje/RzcRFYI2Z/3D75rK7n7B0s7C/DyQVTCNUyJk/mpW2T@nongnu.org
X-Gm-Message-State: AOJu0YyXGg2GzaDdcK2wkxKGEya/0K5ouHrhMrzWpGNA7ZwV+YcJGPEB
 qWm2vlrBu2GebtxrApFSLqiF1ZVFk4V/lKR9VKUvjYU8dRzPNcgJ68SbWHRg4zWLjnQhDxeS/gV
 k5dibjwLTpKdczjwb82PhBcrG2nPKBzCWV8sskB/85oaNxH50RRjYQP5YNs3WR3v2jw==
X-Gm-Gg: AR+sD13jsMHjMG+MSIVCfqXtg7ODLv4+rHV1ZrFruBo9+osNoAlIITSBzu9wjQY9cpw
 Ezi8lNBOFsPi0HELlV7SyQgv45t1D6cIteGs8l31XvmE6SYJe5vb1Ha/UBNrskEx7PwGxHUKPOo
 uGn1BaM002v7iLTffKTU0Btp9yL1LdEkda56BfLfxr6uLbx3zTUxRTAjlcHXTyZBdPQQ943U6YC
 /va4ZQ+KbW/ZdI6p6F2rtyVs4MUQjbfzGmfG1bYQ8z1t33IG+6OjGIF5TenBjkiDfdbLQNOoaK6
 CI28InUg7yFQmlaG/V6MVOBKe6L134dCJuYddKCIm0Wre912gHiMFECH+DVpNmKTV8iehCXOP8r
 m16B8MPB+mrHQ6Eo5BmQK1JdPqvjKnX7TMNTiAQSsXrBNoOmIpqs=
X-Received: by 2002:a05:622a:1aa8:b0:528:32c0:8237 with SMTP id
 d75a77b69052e-52b567cfad9mr132239761cf.44.1785680282852; 
 Sun, 02 Aug 2026 07:18:02 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa8:b0:528:32c0:8237 with SMTP id
 d75a77b69052e-52b567cfad9mr132239211cf.44.1785680282465; 
 Sun, 02 Aug 2026 07:18:02 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49808a721d2sm131006615e9.15.2026.08.02.07.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:18:01 -0700 (PDT)
Message-ID: <c4501c77-8988-4729-9f02-d33e0897a72d@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:18:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] target/s390x: Convert op_ld32u to op_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731185628.23161-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfXxa3eCCSeONBT
 JAnIv20PyeBNzGDAwaXT0gGM2Ceg8VeQ+03l6z6cWLY2WrgUO7iPtUCH1j3gefRg/bzCdvlJ++v
 UpH6/OiV1GMdCN5ob4AVKaUb3+d5vUfNRg+OFCaH5as28kERs5i/O3Q3cXTcNmDQ9XS12/uYEni
 0ry1P7PS+eLQn5xy1oWRlZWV8eCKi8lNckz8PyhulKmDeFqFJfV/9Q97yKbDCV9TBj9uE3+s2XV
 56paV4WLMa/cPxq4K1zI4kNCJWhKVjNPDcLQ08SQdZJCc7Cue55jpViimrhZ2lB+xlXQkDA5AQu
 U77xYHhFpVxjreunwzF2dMX+j8fe9uw0wMNX0W7Wn44FmnEyt6Evt6E49uUf4PmRC3rOV+YOuOo
 ZtlsPcY1kIxOenagGSvGSBMlxiUrlt6NHaQ71bri0BAXB4q2k05uB6CpLgaow4cKkMeYlYavcQC
 9WV6wrcHuY6r1ZlQY/A==
X-Proofpoint-GUID: KQFTowknYTnnHrrodIJl6hJ7Id6tZmYp
X-Authority-Analysis: v=2.4 cv=T9C8ifKQ c=1 sm=1 tr=0 ts=6a6f519b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfXx2UdBlv7QjFC
 A9V3PGW6IVm1/HhhmsPYwmqOJ/ty5Tx9WqoSCdUEcrailh23bkN5BNYpPRIJ/O7mtark+GzqJNP
 Qpd1AOy4MDleQz5LgNmUH2Ie9n5I0nY=
X-Proofpoint-ORIG-GUID: KQFTowknYTnnHrrodIJl6hJ7Id6tZmYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020126
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

On 31/7/26 20:56, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 7 -------
>   target/s390x/tcg/insn-data.h.inc | 6 +++---
>   2 files changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

