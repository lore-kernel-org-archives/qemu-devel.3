Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2726C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVjO-0004jz-I4; Thu, 27 Aug 2026 04:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVjM-0004jf-Uf
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:45:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVjL-00078D-6m
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:45:04 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6RAqe3039549
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HI2PPP35hYZZ+f08QaJr4ILDZf014qy5m9U2m6WtkvE=; b=lBwOhaUfgH7Mg2hd
 vYbnRnsA/Hjm2/0W19gyNCK0hu/d4wIt+dHZumLHFMtj+eAF2ZUEbJyDiytV0etf
 QGDODiEwH8vu/3AbALPiE6R3HMoQPBpb0KOTtAx/SjOCODh65JcJKIF70K27B6iF
 yYI/WX7zDBLCRc144O3kN5fTIEqULhhR8e/1n+ung8/r1vymo9UuqMd9JeKY2HQK
 tRXwGaMu2VAjV5aWvzdVh9SQt++cSRlnoi1gbDoJ4eu5W/itVM4QylldKi6ZIrVc
 bOgqC+8FfJ+3T6JFtMi8g7aDGMQjJ1M6DQWhgZBgotCwwWpf+3+NljcRqA+AUgXR
 W3Y1LA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03ac329-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:45:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so33588181cf.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787820301; x=1788425101; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HI2PPP35hYZZ+f08QaJr4ILDZf014qy5m9U2m6WtkvE=;
 b=ZiCFQGAUbsVa39OEWDKlT/ieYG++uAQ8weR6FSWiArqBldetL7IyjIpvZTw3vq+8J4
 C8WgkOkSC5G0p95/2aEe0xbiYFBzmdAgioBDPYEx9ho7SATszXHQtCnicm6CVd8vAQzi
 7Z8rar0CH97wgFTApSV1nqA/RmQAfpyj4z4q+Du6jSjht3j3Pqk/TDfX2i02yQjQqFH2
 9XKFhQp9Z4tHhULS2s8ZA+YVDB4TrYNFyJnHnQ1GwUyth1ngLctZ+D+X8kCj8pzS1UK8
 RloOTN8JIRm0wdS9hVn/ogkhJErDkl3sBeySek1ImaSH8UX7s2bA+YrQc+LagJhi5DQK
 KLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787820301; x=1788425101;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HI2PPP35hYZZ+f08QaJr4ILDZf014qy5m9U2m6WtkvE=;
 b=JLj6r6gznJ6Rn1jQLrjlIVs/1BMRp6+aqIbAVyFQz6YAEniQ/v0FuMW2eNukH/ic/Z
 KT6/RPVRRjSfxh86uilf9oYM/UV2uscJMs1I5BVUO4yrY8o83ZgowSQjaKkZFKo5JzbX
 TzWUKPfolP3WGpMX6NxVD7+iilu0gVokjwvztp4hbcuj1BCzy58esFFpqjwW+wAb/pcG
 Ksp9EluktxDu+/1GJrD3vZUe4CW7bnIqyMBKBu94vKPoTBrYFhOCJmMkF1ih00pAc1op
 pSwEHnnKR2xPABVVNZvHAbB4J+Q4URSOJFfvbld1jrtHUuQOmf/eHEoBZY5hVYHUXpUe
 eftA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXmPUHWdPNhC/mynuHkjs3x26xxi7zT8/xtiNVCXqVdzzeDvhsr6YaBRzJhsRekLTASbTVwtkrbgkP@nongnu.org
X-Gm-Message-State: AFuF++m7xJZIwBVMyFH6Dy7f2Cg+ZVIK/UTZGJXRRm7lIhEkMSbRNVhJ
 t1D8NHmOpoz9CQ3gtf1GPZHBZziEPe4doUibZ+UgJXyNUfI8oiGmDGOuYKigQY21hWZPaLcYVRi
 E7mcuxyucKl4Zc5uOmWaWkVmDhbACvGc1yccDusn9Q0mLyyDuXUxxuOSZNA==
X-Gm-Gg: AR+sD11JIbncZ4pnk3MzWYCE3m6eDoYWBX+iGSLDtvajIS7fpqHWclaWvEGfldiROOI
 6f05+wEH5lUD0z7b0bmnOM+BkQpajm1nFgeewuduPZ0KHLtXUrG9z/Vs8FSo/G0Y2HD65YwlkoT
 fCsleTx2gdbHc7LAkgtB/jcXskXDtxkzkFGsx9uuOn/7G9ptNZqxCBr5GZ/xeTSHrzSkzsZFp+9
 4lqI71yO8Uwj9RYTi/AmjusebS+c2mHAB7sS9Fr1IlrvPuOnQcaI05pOmE0FbpVm6HEK8hIPdgR
 C+y3h/punqprVMWUd6Fbnao+vWqpczEVyoVhKl2+rNzRjT8wYPoPN/rN0W/Zc1phbDleun3vQgW
 jo1xcWzLbRiDhuz37m5E0IsKI5lxRC6mPEgYaXBtUHiZX+W9O
X-Received: by 2002:a05:622a:30b:b0:527:7842:72cc with SMTP id
 d75a77b69052e-52e424059fbmr132419521cf.39.1787820301489; 
 Thu, 27 Aug 2026 01:45:01 -0700 (PDT)
X-Received: by 2002:a05:622a:30b:b0:527:7842:72cc with SMTP id
 d75a77b69052e-52e424059fbmr132419161cf.39.1787820300940; 
 Thu, 27 Aug 2026 01:45:00 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4942298fsm36659845e9.1.2026.08.27.01.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:45:00 -0700 (PDT)
Message-ID: <56221472-2b28-42d5-912b-26b791657706@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] tests/acpi: log the name of the table checked
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260824164751.1700783-1-kraxel@redhat.com>
 <20260824164751.1700783-9-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824164751.1700783-9-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TQZxQzlnH6p4UYMOY9F7gMt5k9NhGqqC
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8ff90d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Km4GceFjMsEA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: TQZxQzlnH6p4UYMOY9F7gMt5k9NhGqqC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX78S/2cad4ho7
 +zdL7OHwnbWSic91I6QEPbrXkFB2mcoAOAU2oVZf3dW8N0PrSKjU/V4Hhx7pwe4swAMQC5aW62o
 fbd9XNMYl4MRj285yLMxZQTzXQ+enfA8XnSvTEomyimWko8zlv7WUJJ9jH+L3WK9op3JWnTYNjD
 28EEorf01bZAv5llKZIcFLzebXkWETUBFCGvGtjccl5RByYdVNNFbyOrI29j26zPLiw5qNIm7gy
 4jg/dZl050WFKiHyFnw0kE4B2BF+hsIfHEjcz9z71sXgW4kolOeRP1To7HTvujYL0+b5FIX5Ic+
 bKw3laH2S3vJdSEiCfXQmy8qqp4i84QZOMmPOzbZTqdoejZR8GU0pvFzq2h4FKqQWBk9tjQlVUi
 i7uITbNczB7wEE7Dlehu9B2F8K8O1it063dVnPp0CrcdfIaAamhvGPseqOfy8zO/mIEnHNGgeCT
 uBPxL/k6y5qBOQFAYXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX2Xf4Nrq194NO
 z4SyTrexq2RtCSNsLHf4rftMssySCkCIIF9alOKoSFbWB21sJCB7bNeJG1w33CDsxgPBYB/UC3+
 dqyjTxG4ERVVbituhb2cDMx2yDcwc0g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270071
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

On 24/8/26 18:47, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/qtest/bios-tables-test.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

