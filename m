Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCC4CA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDob-0003dW-4X; Mon, 28 Sep 2026 12:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDoZ-0003Zx-6O
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:02:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDoX-0006sb-BT
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:02:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEe3lH2298468
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c0MaJKY+L6cH8KYjv8Rbr/kHeJ2zMwKF/59pg0a/u70=; b=bM7+BskYdsZOjU+U
 X6KaBzIDYDCQ6i+SbqvE42QNNnZXjgmZwVSqTjWpaz9SRIi+HuqyRu47qFxC6csg
 K2x0rfjRFddBNWiwV+7ZbBHb6B7BMt9TpzW2ltaT37jTIy82X108RzJxCGqlkUEg
 FTirRDUiDNAMCZoGrXNkMgpA9i9pU7qqAMGX/uCl+RqE9Qo8g2SOEcPME7USagrG
 RvFZTOzpqV+viV21awabeAGiAdBAAfwmr9gRucPAPVM2ENaRNEc7ZM+BT4QEX4Jn
 FIJBI/0siwcB4cgA+nQj9umTo4MrC4Wlz8bx3g9j5Hx5iEEV8juYYeChS4fpveXH
 56iigg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynb6hm3p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:02:47 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7ac2663eba2so2362677137.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790611367; x=1791216167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c0MaJKY+L6cH8KYjv8Rbr/kHeJ2zMwKF/59pg0a/u70=;
 b=MtNcVdod6u7LVgl9kEe+BwfnsFl4I04ONzuXA7ciU+fLb4ev1ukRscDaHALGu4iw0w
 Nd/pPY/Un9cl7ER2+5Av8r8oXUtttj6wN36THzW7PdDX04h4thCLsq43bobtfvNfAkKJ
 H+5cFstsUZIIdxDJ4NAtqhwIxcRJiiwdOO1nHYOGNIMcGEh7HwreHAqIQult/jYOaId6
 cHITONtJFX5+7WAO7UQ0bOmmZrjC34vpG5rA9g2lhvhORNv2DpPgOkK0ecgQYe89U0MP
 VtZHBqTcCm+s35FJHMadyUQLqVDNXqmMxBIv9ttgQ5AS1bqkYOqWK/lKiEEKrHLrroEP
 xfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790611367; x=1791216167;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c0MaJKY+L6cH8KYjv8Rbr/kHeJ2zMwKF/59pg0a/u70=;
 b=Mm7syVfPBE3v1rvzInK8BKqcpl9VntFz+ZjYiJ1/KQxih7bplZ0+ZCZ7sosd1yiJ0j
 XxcN+jIwyZx9hGXxClsM1X3vY2wd+DC0XY0oM5/pimEPq0zj2hKGwOcQ6r2FoiLwx7IE
 KTcTWnaRY3E/6ncCT59I+Jknd2CpW+eRcwyDzTk74QvuSI2uZ7//hbLIP8u78NSiK/HR
 +LPDLGavW7S0YyRgBrqWtQghG8zWSRMETdNY4QmC9AS2xgj3Nw3G79wfdCo+6TB0Pkn0
 64BZrUO1K3KRuLmp/fsYjbjK1NrcPZ5/KviQVe4zzXs9DfeWQtf4eCh0ieiGyvXacd0f
 Fanw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGIV6XSeg3vX/y/Oe/MPKtJjwVs5ZbV5bgPf8VsLERChwjEXGhnY8i8hg7kCsl9YbG3LYr2M+uMfbn@nongnu.org
X-Gm-Message-State: AFq9FYJcXCgvXC8oJc4DWQGHDUOoipRTzv37Sezmlg63X2isIs0EGijP
 QMQkQnDuIp4UOYX54evABr2OuQHIicdDiofE2MGNxYQm9sVFnvzx1UFKKhzUcEHcEpxQyaTjbH8
 n3co7R0tLqI8jMWsSa8fxRRZktGvwy99fBNqUhe+u8NQpYeMlQfeWaDY5RQ==
X-Gm-Gg: AYBFou1NmOQYi5EhmXPa7MVMLdAyx8bZvzEEGP2XZWoudi5Vt3Iifc0Px+QuYoTw3i/
 s9EMfDdP5mVoKsR1SxrvHgm4T2XEwtJvwOkaZLIhQrL+h34kmDJjxWM5HB1Yd8uqdToedm5Ylgu
 tT3lowh22LMV3A85Fdd1VuQkx+2JSytlWOuGHCTbR3G7aVtajzQ0+8+ruwPXO19l3gB6FWmR5sx
 9bZOiUK37i4CeD3Brl0e9dRraXTefY6rnt1yiD1oqb7lUVdxyjeExhVcNNnhbCYYwgsUBN6E0ww
 w+z58BBxso85cI3d6NgX3YeufWonHClMDDo5bF/XatYBPRD+8aF0Sn38d5RkHBEV8gLAm6mpS3X
 QSeiTmBeC6jdltL58Mso5cxXHYOBRTAjSVQ==
X-Received: by 2002:a05:6102:441e:b0:7a6:a24e:811f with SMTP id
 ada2fe7eead31-7af1c79966cmr5474436137.7.1790611366713; 
 Mon, 28 Sep 2026 09:02:46 -0700 (PDT)
X-Received: by 2002:a05:6102:441e:b0:7a6:a24e:811f with SMTP id
 ada2fe7eead31-7af1c79966cmr5474360137.7.1790611363997; 
 Mon, 28 Sep 2026 09:02:43 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a34a638sm27630724f8f.9.2026.09.28.09.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 09:02:43 -0700 (PDT)
Message-ID: <57b370d0-23bb-4ce6-b1da-c9c6be244b10@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:02:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 043/101] tcg: Generic expansion of tcg_gen_brcond_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-44-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-44-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MyBTYWx0ZWRfXzWe7t4j5OF0j
 ZBeT47ckqSGSyltKlcJX3IEwzdmH6LrIZrH72nVc9odoWmIVgU++MC/yXBjyy1oIo++xccw0OHa
 06FIn01k6/zrZKyeHknJICOHP1MmPxZ7q2veNMlcRaKeTP7AzI+LaMqkwxBLp8YT2JxVKPHt1F1
 b+eNkH62jtnqHocw+7lWpEPWqKQGPAMaT9rlnoIEcSSLcZNWYYrSnYPgEqmCqy+PA8fOfJrslGW
 Oev9CZmmLvGIBM91WWOKerZeWjYCL+bqxYkVVMfGU+j4Ih4L+Z8lH68Cr0hgUQcEbQ5CI4vI0lh
 k5uRc9suS0upjYZ/G+Io/vZJacHAMo80K+wLr+Evx5LGlVASnxefgXV3oZbSE0cdAdPOVHjfajM
 a7R3hTlP5SWfCTCbCjIH/BfyoS5ju3xsoALtqbEW+uBqTXfyE+L5J54PkPtkxNrvHHViQFm/eDQ
 AERzUIDseA4DmBJWT1Q==
X-Authority-Analysis: v=2.4 cv=K+e3jCWI c=1 sm=1 tr=0 ts=6aba8fa7 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MyBTYWx0ZWRfX9FlRIomVznMZ
 om+RBOGoomDiG5ILeaxRoYW0iG7P60ilCMexyxg2AgkD5kNrFHYZXfV/orjPgCNhQp5WkOOVitZ
 F1iGzcEQlU+YxfEx8GZ1N910z/I7CeU=
X-Proofpoint-ORIG-GUID: R3_LB4PYIqlM205BA6w-VM9slUAmQSCx
X-Proofpoint-GUID: R3_LB4PYIqlM205BA6w-VM9slUAmQSCx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280063
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  5 ++--
>   include/tcg/tcg.h            |  1 +
>   tcg/tcg-internal.h           |  3 +++
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 44 ++++++++++++++++++------------------
>   5 files changed, 30 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

