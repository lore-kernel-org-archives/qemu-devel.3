Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02917C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 09:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyR17-0008UG-Op; Mon, 24 Aug 2026 05:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyR15-0008U0-La
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:30:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyR13-0000Z4-EC
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:30:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O992O63109933
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 09:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jzrv6+K8BJy4w7h6kOzkKh3Ln9OQeMPysdnhZl73jlw=; b=f+kXXgBRvap8QfZx
 6AEEGuPd/ZV/9dW2rWq7vx+rVjRmoAJ5wJSADJUBNkWc5Wyc+y1Mt3JMUQ0RfGoT
 9oOlyjEoqTTanN1pSPVzzhnFxvoOmSrj+sc9gdYuhCjiRfJrhnibEBnjNXKmXacD
 1Xdr0EBEezqmrJJ1yluPz8LAQAZmd6mGltYRL+HWxDFbv3OsNZU4i9i6YX7HD8LY
 vRbVgzJRldhS/+vRPLcwiRUluXS1nUECwIn5VhjN0OfMmH1M1V5uR9z5wQX5oqIM
 vvL3C33ZW4j3Z42rHpml7e1ElYyYwig0iM+FikHbcIV3VPMCjd/Tll5n0Odt1/dw
 T6/TSQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8jgk0bpv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 09:30:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bf321d786so26586841cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787563850; x=1788168650; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jzrv6+K8BJy4w7h6kOzkKh3Ln9OQeMPysdnhZl73jlw=;
 b=AgWT8n4v04fZOlZWWc0HJxxb1aM/Bwb2T2K0p9Sz6AtElXM6HeSIm96UVX9/zVuwMm
 E9bjcf99wDRK1bHr6CbYNb4VrqJsJjy6CTO+lfmVBFvrMmKgZDVnriZDFZnHzALr+73g
 xH5Ls4XquyNyDmCBpD5cO6/dgfc7JuB6L8/nRmmjChU8K61adQCKd6UB5lyO9pr4Evss
 E308TbDuk7i+zRrhbtFMp4Jl8eGwf8ndB5Y0DYm9jCPM4ftpjCYk/xasGpo9y6OmN8RU
 MZfb7mt83v9M/Bt3DveNJBQ2kL1sZ+iNzB5whl7YD4Aon618DlbgmDr+OXuQM+ocrywA
 STIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787563850; x=1788168650;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jzrv6+K8BJy4w7h6kOzkKh3Ln9OQeMPysdnhZl73jlw=;
 b=Ixz4OypxoKw2v/fZdpHDRZVLZ8h6ackiBpGrMAks8fsdLGf9aAWPgVQXnEzACUTe4Q
 b+aSz5RYgmnSGNnLjQmlq25Pw5RgcVZBxhiTQZ6k4XH/80ZlKazRaqejcmEid8578bwD
 hqG6p2qYmKS2DIBBUhVjufUPKtFMHbpOVlDA6Rv8pbO9fGNFCUv7OV2AsD+PaIW6FWxc
 6yi9TI1bWxweF6CpCVyjC5nEOEMArseMo+NT4E/VQsiIHL9jqo+ZJENF7hUWyYPTU1au
 IYplL9cy5rpKOYFhLS++/Fe8mRJZn3kj4ALYvv4hXK11L889wE9cISTvoX2DN6roAVIp
 w4hw==
X-Gm-Message-State: AFuF++knXzi2AucBYv+Zzog+ZcCBYkrGzahmB45aJ3ir6HPxGEpXA1nX
 2qZJzTCZe97OEmDxtVSbqnvvgieeBuSSs29FytOmIp1Kxd0NdS6SE5ZHtY2msvu6Qe5n4fdbj4y
 ziK5R7J6XkyZrJV0dirDeKx31KJOSZs8Ukf+L8uqyIeuze9afaszVOQi2jw==
X-Gm-Gg: AR+sD12RwnZNvDtadq1AH0SIkbJv+4OueZPY63ylQsxAQ1JzpIVglz356m87w52kMsv
 41H38JUwSNQL4r906h8zSs3vy4x4ffNkNlAFOan5KPtn5wHpyE8YMO8u3aerM31ChndH54YGRtN
 lW+qU5477E+rhNRpyrVmu7etyzC2pi1RTiKSFaxvTxnx7/c3QxQNkLpgFljYZJ5kpnCqb3KK6mf
 rWNU8571JOCwYIZxbvus6iE8Au4HN1+agU9eERo0i42a2FIocKk7N011s+kICoov8vbRTo6S8Zd
 vveInM5Hsqgx6C75qxzw6GPho3p5b1Cpel7l8xvWQLC1+i+c1A2oSpHOEtvyzB+QGvm0MCRmZsx
 yxlcaHS4HpjM63UKS17YMT9VAuI8saGJbw9U/rPUsyQ==
X-Received: by 2002:a05:622a:8c8:b0:50b:4491:a2cf with SMTP id
 d75a77b69052e-52df5a07b28mr269944351cf.27.1787563849557; 
 Mon, 24 Aug 2026 02:30:49 -0700 (PDT)
X-Received: by 2002:a05:622a:8c8:b0:50b:4491:a2cf with SMTP id
 d75a77b69052e-52df5a07b28mr269943671cf.27.1787563848976; 
 Mon, 24 Aug 2026 02:30:48 -0700 (PDT)
Received: from [10.254.188.74] (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249685ef7bsm1320196666b.52.2026.08.24.02.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 02:30:48 -0700 (PDT)
Message-ID: <b8381fc7-e1f9-4b76-8794-cf9cfb15cdb0@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 11:30:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 09/38] tcg: Simplify bswap/hswap expansion using bitswap
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
 <20260818170155.1907006-10-richard.henderson@linaro.org>
 <CAFEAcA8pSuhgPAoM0VbEsZUyVrw8NqVrtKjmpg0-dhM1y9r96A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA8pSuhgPAoM0VbEsZUyVrw8NqVrtKjmpg0-dhM1y9r96A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7dqrNIWwaJfLVujEEDCeyiV2TMknN5dh
X-Proofpoint-GUID: 7dqrNIWwaJfLVujEEDCeyiV2TMknN5dh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4MiBTYWx0ZWRfX9f1jhzET/Fmu
 ydw40HSleuPpdnGYPrsJFUDmFEPxFBSZegqX/aVLhyIOejWWn+3bEhEmfcpdDdqP1XSfkwmn88Z
 cXGSK15r6QCqnBCKqGwKxL+eEg5oBX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4MiBTYWx0ZWRfX3rT894Ib4WeO
 gjMICU6gDZIfy9YfkpoluiW+JLKwaJrKr8Hf3iM1wKli1zf80ZxnFjntGGObHRIRlW2vKzM8Oum
 JEkUuhypCgUoyXjpA3Iw7BDhbhDvjgYMHvpGwIjdLH0AnJ8jTrF1DfoKSwAiObvCMG5XZE/9sup
 6mMV3/jtN1cfOM2PmpWStgE6UFRvm4QDWf6Kl+qHqvo5wzslx/fyD228xwC3cu+Mp/9Xj+69xYe
 YjldeNbfRXsMpTZliPI6j6esvvmEUoqrNT/esN39DpkB78HraDlpc8npzFgJOuQReO4a4b7lvZL
 wwj2WF6KFkod2hbUIPh2JbVIm4allSbrOH0Elb61R5ozNyy6+jql/ubKhgDB/OQRejENtZmoVy0
 jA4726mZFFofZ8ET1NsRXOa2wCHVY0SA9aH+a8cUidCb9SpbExPuYHJ02nHe8Oe4BOXWcyZb1SY
 cALwzAJRN1pNrtzGVwQ==
X-Authority-Analysis: v=2.4 cv=KcvidwYD c=1 sm=1 tr=0 ts=6a8c0f4a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YelGcSiot1SMLvslgbIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240082
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

On 24/8/26 11:05, Peter Maydell wrote:
> On Tue, 18 Aug 2026 at 18:07, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Hi -- this commit is reported to cause a regression where an
> aarch64 rev64 can now trigger a TCG assertion:
> https://gitlab.com/qemu-project/qemu/-/work_items/4229
> 
> Could you have a look at that, please?

If so I'd expect the culprit to be either the previous one,
"tcg: Add tcg_gen_revbit{8,32,64}" or later "tcg/aarch64:
Implement revbit{32,64}".
Richard you'll likely beat me at finding the issue, otherwise
I can have a look in 3 days.


