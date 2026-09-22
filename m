Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E09C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8sAm-0003uW-Bw; Tue, 22 Sep 2026 00:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sAk-0003uH-Nv
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:32:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sAj-0005LG-0G
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:32:02 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M00F012673815
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R9iPlc4oLP5eq3o4XOPQBEqQUZiJTSbTpGSrd+HsQqM=; b=BFK+zSWO7bAXA/Z8
 wpah/0nHl1BGANAPdw3fYb2YagReO9TCBklfuJ0rs62tf3FEag6LVUXDxC5LkdwO
 PwiBY9jRgoXb5qcuVD7gD5P6mfNd6925j2NcJ3i3PO6P3/HtG+Dp+charDWKoJ5n
 K/wFPdAxGLXBhwK3XZniK5wdWxy2vy7iUho0sj+m2MfHBjHDRBuzckBzh3WFnGKa
 o/9ieoJoS5veSuUOotlnCDJOzmDRns/FJYYLrLpi4EK3J4bBJnSvSqwafWhBRhqj
 IjpVrFSdM9Qu7qfsRC738EC4VyV602eK1Cr1qPfH3xjFiwj1gpoh3DFxiugL+FN1
 oXinpQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8w7a6gn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:31:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a1e564fd5so596582285a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 21:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790051519; x=1790656319; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=R9iPlc4oLP5eq3o4XOPQBEqQUZiJTSbTpGSrd+HsQqM=;
 b=O6FQLQBoYuQ57Mgk6IMvlyVf7qq6bkfXzvA+t5kSQGo5Lg8XM8gne4Ies+0rFfb0SL
 LFKMLq3Dl5BI6fp+8b7DCIaPba00JL2yommfS+cVzGOSHW1l41dIBydcex1yJmR8rors
 6Q6jPyNv22avQxudBv9YA3tSulu/VkLm3rTf/Mh8LJffSvJYjNK5D5ATSZCtb0XEzphu
 LUbMOhBNFufitvGaBM2maITxLey5sEsIEZjVUafSaJE1bLPMJlHC2tT/nBEoxWGT2dUb
 yKg1jbG9ynenlOcVUNYvhMiTedrCEMjtvEjcD2Bb2fgJI8n1w1gpnWfTcX1UzwnwQKz4
 V0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790051519; x=1790656319;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R9iPlc4oLP5eq3o4XOPQBEqQUZiJTSbTpGSrd+HsQqM=;
 b=HwjxSpXkAQsUS/tiE1RsypnNlCSzFUe1jorzVqFZe3iW6s2nSecm+tCOv7ohqJR5J2
 OZiy9fhGo0+O0MXBbveI4GRDvSzwXyt0P/Wjecab9LlS0IYG9vcDxWmyKRXxP9edLA+7
 ljkidts5B7M1ZtAvJvGz4l6HP092lp0wkbaPILSP1kevDk9pS/5mxfnj6mT/9cwR1Y66
 UNTWS8ZrLt8LRtbzK0OZOii8Lj9jIA8m31ggXoVfAamsKzCkOPQ/ljE+QkAmoKl4jKra
 MWtD/6mL+MwCA/YGSZnEU/wNK4GLkiZ0O782ksVHvKlcjkS3YvTR3309Y8rl7D6IXuXg
 9YuA==
X-Forwarded-Encrypted: i=1;
 AKwUvByGKgIyVrO6esosw3JVukhriy8ZvIfEsc9miw9EBORoFTTyzzbgZ0WRDHoLgyxUrdH7zJFs0InmdOAn@nongnu.org
X-Gm-Message-State: AFuF++lwS8VIio6QNbJeMqUtPdQDrIskmJPz/Bgnlof3AJKn5eReDZz+
 +j4v0Un5EblzrbSPbmbJ1o6FhIJ1uqvDmiCKPds88FrgkIPU0gs5xK2ZtlbsQppJTghTE7yvk7r
 zQdlsDkfKpXuInlgnshqKhtdvTTg8WA3AWPrWQZIXihOMGKO8yLSR0qBoOg==
X-Gm-Gg: AYBFou1IogJEhbg2dnSBDOfTcUtQQ26uI0HqnkmkR0kXBEePh5o+VITXtzDPwNLcBsx
 Mea8TS1NuXD4beUSc4ZgXno0KxWork+QTuP8eWIdXZwbTRb5tVeNmSDbm4mLq5k/b4Qwrh+4nfF
 jYTR9iik+kr+2YAYliN2YuinYR9MiBqjCtzBxlw0NX50cf1tX38SKegfCYTzhQlrR5QQ6jGWzvj
 s6T4SrM2jmokQN3fjcg5nr7SG9OTDyMYfKNUCHJ0Fn67w08xelmu20aY5mfZZb6EdOYgIopSnTb
 Ny80lQtw1olofC8p00iw7fQ/q2lFgX7zpDOBqbGV84+/lXrIdQxnilipuSk4mSFScQ9ltAuoNa6
 HTSnJclyOzgjYOneVMXPVUb3YGnvgBDh1Zg==
X-Received: by 2002:a05:620a:4503:b0:93a:2bdc:cd57 with SMTP id
 af79cd13be357-93c15d7cceemr384496685a.2.1790051519388; 
 Mon, 21 Sep 2026 21:31:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4503:b0:93a:2bdc:cd57 with SMTP id
 af79cd13be357-93c15d7cceemr384495685a.2.1790051519044; 
 Mon, 21 Sep 2026 21:31:59 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdace7941sm23582015e9.2.2026.09.21.21.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 21:31:58 -0700 (PDT)
Message-ID: <a52257f4-dae3-4bb5-baea-42750064a2da@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 06:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] tests/lci/refresh: add parameter to override
 container registry
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-4-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921231458.3369-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GCg0C2qKtTHMlHus2-DlbUNTZOYIB9AU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX0GSsOTbQ6iED
 7I/01jjBIEAETcwwJ/u3nFiU+MZG4gOtihrkzaL6coKg0HGpJ2QqpiRrLRaTmmxUZ3OXx9Gg7jF
 +a59g7Qlo+DD4GMzO/1M+CX7JTZrRJNEVUo3u2RjzK6vmlkJHWABMcdUqvBvvYvYJF1l0hfWEOi
 7xsV4mU3mbQ0inCCox6WAV4/TSqwGQ1wcOGt90ofj/W3KYr3W85IOmohN04mbvShQOMhJAW9AGo
 Mxx0Zjj2EeO1GzjP1KeLyob9ad7MFMmbu41X88hcLopEkYwWwNnNUf4XEtcjI3+LtS+mJQfdt0q
 3mnzhNf89WRZfMYTXRlE43VRssaPBArJ4CJ5/LiZg0F6mfEbja+tik4CWmtNGZmKoD2qr2wcg9q
 lKyW5a60DRdCDYGBAiYOjHgjDSr3g67oOricKJKvBs9+8xN5CEpAWwwkJKrU+F25xowH50EHWKM
 eyMOqTy1z50qXdiSe1Q==
X-Proofpoint-ORIG-GUID: GCg0C2qKtTHMlHus2-DlbUNTZOYIB9AU
X-Authority-Analysis: v=2.4 cv=Vqi2kO2n c=1 sm=1 tr=0 ts=6ab204bf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=0lgtpPvCYYIA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX8GM5I1T9gRg8
 65BmBHQEd+o/pcM1WKnIJj2xV+xHXZz7k/c0W6ylEYf7tfGB4TaYyo9XOM9FS491AfY9f8WroR8
 zgYFQeLXAhpLsKr9/5oCHNWe7eZrYD4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220062
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

On 22/9/26 01:14, Pierrick Bouvier wrote:
> We'll use this in next patch to switch FROM docker.io/library to
> docker.io/amd64. It would not make sense to add a new target to
> libvirt-ci for this, since it's just a variant of an existing target.
> Simply replace container registry with arch specific one.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/lcitool/refresh | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

