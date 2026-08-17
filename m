Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7040C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvysv-0002RI-8F; Mon, 17 Aug 2026 11:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvysq-0002QU-0o
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:04:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvysl-0006HT-HF
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:04:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HD647B2329914
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 15:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c48NO1a48tM+F/Lkpv3O4CoS4+T65KdNa5aaEcZoPwQ=; b=jR0MX9o6CHVhb3vC
 AaAmBeffWBWBwxAH8ik4kEkoCCgbnvPe2MjNnKwca1faZOgs9Vo2w9BcvPB3h71N
 5NFhnKmoh1+V2mT8ydshReP3ic8Bh7XfegiV3xFUofHgWg4Hwn5rxwwD2nW5f/ku
 BucUMmYWrjvrf6sspTE851wPRrSqDvpp8dSH5rbm/iQyl2+Sz8VCpXWpUQrfB5yz
 lhciOi3FhlEORC57HNvqmBUpZeu/Q0aljjAaBuxKdWAgqel9UQMWdBpOyNKJ3fpz
 P+cymhkb9OjCz3xvXo4zWOJ/dc/ZV4rnXrf86Ko6WVXed3L8IBQwOBRci1i7ogPQ
 IlWiyg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3vght8f9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 15:04:06 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7716062304bso610452137.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786979046; x=1787583846; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c48NO1a48tM+F/Lkpv3O4CoS4+T65KdNa5aaEcZoPwQ=;
 b=e795Yb1ocs5a0GU1rSUpyBYMBbSc6dnm+4BsvoI1nd3tLrqjYRLFiKnZbSmpCi7O/I
 5x3RModLNzbMCDA0UrBxxSctf8fELzxbQ3Hu3fXAlml3h96uv+NSp+S65UGLi03ucFFS
 e4xzPA9R2lV9TtWiY98hbI7Ng+nX0h0NAqy7xMDm5SrK0aK/G66INGHBs+zUXG6DaJkz
 JhRYCel/W5YlySn8/yifY8LgTi1g+Duj1P300vsOe3ZNId/CfW06yreHFBluNf8LOEhf
 jst4CMtL2tGzAl4nzDuU8UbelMqXK1QhMCuFK8aHSUPyDJrlbKgSDPMrqk4UP4JRJYLX
 vpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786979046; x=1787583846;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c48NO1a48tM+F/Lkpv3O4CoS4+T65KdNa5aaEcZoPwQ=;
 b=N4UmReIV7nkihQ/0W640dfRbchTu+dmwMjF6Y7R8ku63njN+MG5WQG9+Ihxzhqumb6
 eo1bZifa3glVSmsRgPdZ0Oc/ULvumDCLDUsPJWI3dOaB9nMTsxookdAmH7NmTRwVo32Z
 RNqK3opf+gX1nMh0EAHSzSRNGrPoEaEPdddbBsIYeUvx1noFUBl0t6np5eQjZaZvZHHg
 5P8OqlI4zXozGk4iJEinPMhfO6P4q44eBbnDT0YtRQwSs3e2bNXGBrFlF185Hu/uOFeX
 WSIWpSkprlcuUqVMlsOxuFmsaIqQOAtrcKHpiePRVpn1anzBATRDH2FiVU4E3thMG+dg
 hkDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpxi28tXlwFw0CBucWoBpuYssxpmAzY9lffVWIUg312cLYTIoLBXg1wZ+RmCG/wpc9KQCkMh1gjjFn9@nongnu.org
X-Gm-Message-State: AOJu0YzAPLR0Rzt4VQnAM2X22yGk5lmmL6MCsDS+Az+4sfvoPrG4lUpt
 K2Ki9jp1V131hKFEuUIy5WxT8ID3u1p50ECPfqYq7bhKkNfHPle6HL+Rz13igWlVqjV/Owo6mBW
 fpJptnQxeadB4xu3YVU/Obh5CHhHVo3IAD8tdXAHihI+p9B8a0/no2ReL2A==
X-Gm-Gg: AR+sD12BE16pO2nrktKI7TvAtrFTjOruH0pglv+EpYrgAA1d62iursZk3AsMdCD3u57
 J4HzRWXTF3x+Ct0J1+WY/Vzav5u1pSYogOOV+e0g50HnS23f/dMOGLXicq4/mR2NvYVsLty24ou
 gr5XrXIyphT9OqAUI2GW13m+oIpL+NwE9pcci6z00RcpRutABaYX8OA2ij3xgUUIzjqQOhLXNL/
 RrlLIOJuawvBwRlqGRGnFmmpt/V4YBne0bjDcROvYnhyeF+UFuXu541zqR32Aq1MiRRkoflPEFe
 tJ4ZtT45rpFjfkLhnOyB1OZGjxOlWFlP06SgVr9M/NW8o8nTJebxFdWzn4atQaxlSKOWxP8wDR2
 IIlATdXAazZXtqHsDX+djwqICpJ3obXw3FPQ=
X-Received: by 2002:a05:6102:2c88:b0:737:4cac:52f8 with SMTP id
 ada2fe7eead31-76f2afe5580mr4195563137.4.1786979046311; 
 Mon, 17 Aug 2026 08:04:06 -0700 (PDT)
X-Received: by 2002:a05:6102:2c88:b0:737:4cac:52f8 with SMTP id
 ada2fe7eead31-76f2afe5580mr4195526137.4.1786979045703; 
 Mon, 17 Aug 2026 08:04:05 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d11f073sm54541705e9.15.2026.08.17.08.04.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 08:04:04 -0700 (PDT)
Message-ID: <b7e6bde9-5fd7-4352-9442-c79755c364b9@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 17:04:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Register device ops in drives without media
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-stable@nongnu.org
References: <20260723205847.137001-1-berto@igalia.com>
 <aoMJijNhyBxemov4@igalia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aoMJijNhyBxemov4@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=6a8322e6 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bm9RqcFPatijYUmmefQA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfXzvVTOHtA5de9
 jIL/nKEu2JfiXflgeBneNPpi+FcLuwhTcmRJacomVITecAV2kjX8r1heOIPPrp4d7/s9lrMcKpM
 p7ejMzo0Rix/thBePgNEaAecLV4/VAs=
X-Proofpoint-ORIG-GUID: dTvmpFM4uBoTFBTEgoukhCViePP7i4bb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfX/lmhDk2sh27R
 3FZMfcA2HAxCt6UbiAQqReUvSp0d/d+Hn5ixN9ChKjhU4/wynb+VrGXKz2OA/qiZ3Li1m1Zblvr
 jkp2Gxx+ddtEVhp9E91nBpE2I8/tsSRtFdNq/LvON9J13BH0UCyihRRqr+GFfd+mOiGB/7MAMyv
 YCOjQ0NAkbzxmkbmuM7xRgYqgL7zOjqJ8CxQ+KwTw4EncAZF12Ha9yd1xhmf/NztFtXh3m+yASL
 6QKoS5nN897eII1qmAPhX0i3vqinY85lUDx1XAz/dPKxB80HveOP447t+1P5pO9+4uMSEkycbTA
 6BJ0MvBXcleqvTVp2JC/ZG4MKvUVBBFgx9BwiG1+yMLdkbfvaqbRLuq8BY9WNofwDyzb1wn2X8o
 5wSg6TyaEREk0NdjP47PG31x8iXw0XLCn0GU39GC+hZc1dFLkaPrIHGSMAqJFDB7yrUwMlv+Ywp
 vogrb4OIGnwHHrYrJQw==
X-Proofpoint-GUID: dTvmpFM4uBoTFBTEgoukhCViePP7i4bb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170115
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

Hi Alberto,

On 17/8/26 15:15, Alberto Garcia wrote:
> ping
> 
> On Thu, Jul 23, 2026 at 10:58:39PM +0200, Alberto Garcia wrote:
>> This patch moves the blk_set_perm() and blk_set_dev_ops() calls
>> outside of the 'if (blk_size >= 0)' block so the device ops and
>> permissions are registered when a drive is attached.
> 

I have your series tagged for to review and pick for my next
sdmmc pull request which 1/ is long due and 2/ is scheduled
for this week hopefully.

Sorry to keep you waiting...

