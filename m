Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F1ECA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 20:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEv04-0006Hr-6V; Thu, 08 Oct 2026 16:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEv00-0006DL-49
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 16:45:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEuzx-00082J-PB
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 16:45:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HVRdo4038791
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 20:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SlIkkVNmdinaMRsysy/zu1eyiwLBmRQSUwosJWtN0Gw=; b=dZCGwXJa8LUzroIa
 D4a4E/6A3V126N7wj8UGYOhy9uuAdOyxyUei2HJ1qxOSnYQpecdWRhS0dt31BxUQ
 FOU8QURgyZADECaXI328B+gKnHZPmHSdVtei/ud07t2K6vFcNZhie3zeZE6EVWHi
 FFxUpjvuCMxoHwleIHSaKJFvGYP5Zv+ljquMEoRmShiaRcZjjGOCgdJz+Cxs9eiD
 9gRH0b9KPVIIPlBYb8Zs+KtIAz+3lBT0GzlTx5awcwDNLjx+hF+nHG3Il3H2Wtyo
 N7FOocuVcBmjN4vcM9hQMzdHDkUAevsaLc3jK9SEBOe4BjUEO30YyI/+NYuNhi9F
 dsAW5Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekv8x40-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 20:45:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso1245120185a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791492352; x=1792097152; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SlIkkVNmdinaMRsysy/zu1eyiwLBmRQSUwosJWtN0Gw=;
 b=AL5oHWPMbxt8lnxHo9AgwVtJFjmJajhtO1qR4MbhqslTxU6xJcQFlO5zesLo1bJpa3
 soY9KV+fFIWYdYOvkJ/vWwDwToTY3z8M70a/ecRuNLpbWqaHpxNDY3QGZeDHY6UqmLyf
 sfgzRJ19WB4XTnRYzldWNrKnvzwObTdOsy6TgrKkrOW3P9sTQpcIyXmf3dhp+5TLITmA
 tKcUiHet/8LZL3Il9mBhAgavua2QUlGE0jLjhuvomE37raD4a+9ovryNxTynMLV0ASj7
 kra2xMRbQcSJwE6Ic+YlvbsPvpsWg9BOa71JXeHNMvVhmA52t5iuggY1egeBTOxYPozf
 3a0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791492352; x=1792097152;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SlIkkVNmdinaMRsysy/zu1eyiwLBmRQSUwosJWtN0Gw=;
 b=ZeW4H2ffLF5POmcaD1jVH0zF5k0zc7fzfRUmyZmyjKrhaU6eN17NbFL9uxEOvbEkJw
 UElpAbX1RjVIFAJSifKt7hsn3Tm4inR0DJ5V6TP8FJ0QmzjDtlKTIrdz2lO5EJsGMB+N
 l7I0xWo7LXNe4QA6yJXm0JTTilwi1UYZsn89fAD99VehBFxZDj0itunE5aaoqqNcOl1j
 KThQP7FVXYahWTB2mmeJ9MOXv5F7GVbUXkDaw9/LoBmuPcQCk235LPxJO4SgqdqHKTUh
 IpITVN0Gfve6oTOcjjxGlsIA3abz/EwzWAWaL2PeNXw/FrUeZsjqJ87hpr3HtxZ7FiXe
 fhjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxy/OTyoObCni2tGpD73xAe1TsD/Bu6BeWB5wjLAUvuHs3lWells6Je2opeFyYhcrmSRTPdq5qg2l5c@nongnu.org
X-Gm-Message-State: AFuF++k6sOuq4F6jhzgSseQXKYqDn0pGXl3AG5zK57kZAcPwMkz6Ylzq
 +DJfqFAe+Xgt+UG3MBGocHwvvB9dzVkemgUVhniU3wnKA6tyP04Y+jL1TdlbdeKMAkvdIm9vSET
 aUmRbIup25hSeWWBrKZE4W3UYO85A0tYKJM8VLwvW96QsFVPYo1rOqj42cQ==
X-Gm-Gg: AYBFou1wF5FuZDLBIHAwDfjnqlGBZv98262yF8GULkc6HGHgz+qwKdtvXeD9N4v0cH0
 PLiIkUKb1nQ2D9mRE//JYOUBE0WVrWz16XtIQjmf0MW6aWLnlHDcj5AiG3HMC8+NWYubialgoPG
 RmBlnPPOrMe5YgPrJm/Uuf3xz4SBnC0pcQUFO0e+zM8ir0DCeqjOSTfdHmKsTFdYTwmCIQMnEsN
 ll0qT/JW3YS13N95sZwMkNwHtJOVOFuEgpJmIa5nGaUuVC1zlBSbl+RmAmbIQPAxf+A4dxN89ff
 nrYhXXvHWUmcdxWU2HN/PtuK1UIh3QwRw+J0hkg2RLsXHFGW22lNv4KsEiNu9klsBvIAg3V0nhK
 Vqj4saqN7ubPbqIo+KbUoqM0xSl172q/Qag==
X-Received: by 2002:a05:620a:648b:b0:939:6de9:4cff with SMTP id
 af79cd13be357-93e9b7d8dbbmr1280926885a.45.1791492352163; 
 Thu, 08 Oct 2026 13:45:52 -0700 (PDT)
X-Received: by 2002:a05:620a:648b:b0:939:6de9:4cff with SMTP id
 af79cd13be357-93e9b7d8dbbmr1280923685a.45.1791492351680; 
 Thu, 08 Oct 2026 13:45:51 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e30a7sm201386f8f.12.2026.10.08.13.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 13:45:51 -0700 (PDT)
Message-ID: <b898236e-8773-4950-a967-9bb6a12f9ca5@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 22:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Gustavo's email address
Content-Language: en-US
To: Gustavo Romero <gromero@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: eric.auger@redhat.com, gshan@redhat.com, alex.bennee@linaro.org
References: <20261002185538.1020233-1-gromero@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261002185538.1020233-1-gromero@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sE8BIyAjDGfTNkVMcs8FVi8LvYxAYk0T
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac80100 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=ku12R8h4HjsqBJT5z5IA:9 a=QEXdDO2ut3YA:10 a=tXfupSrto38A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4MiBTYWx0ZWRfX981kApxPOa50
 bYsNqfThaablHs0I+gFyCYumsNQXjDwbHityd6reD4QLey16iB2BoIZe+2oAhESiJhw2i9CVbwu
 eGSbd3vbmIh/YJ7mqt6KRLGYzj3dH93mUfelF56TZinEha3jI0hoavjxQQCOBV1qk2+t6GbynUv
 JQZ+DRMAfDJB1veFwxooxPlrdF0XoywDBclpr7LS8UOad3tSCUis9AWvJ4kUcsOViPs8tVTL+FC
 +HGLPtONUz08n4vSYbUas3oHqOF0lftnDKChE5RBvSKDjTefXfNw/dYqgbUm1bYwS7w6WJSin1x
 E3RaV7dq4APNjhU098tsRxFYjYyPFFiqJukUCzoMyEr3mAYUKHYisHmTTTw0vzGNBSWp6HPhWz/
 QNsRp1iOrap9R44Qd0gT8BEfT61owPeNv0ZiwU+flJfKPx/WvDtUME/fMAWxsNwFKdb3Bibesmi
 dhphOpjdT2uaZwYg3ww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4MiBTYWx0ZWRfXwYQ6cth95cc+
 bo0cG37hbN4ICXqanlye9B8pB6C81nGJbV0GCgvi0xzh0NNnq/46V5MTGccEhC64zpUh1rlece4
 /8i6ddyaKF3Vv3HvlOdqLcOTkmQwBm4=
X-Proofpoint-GUID: sE8BIyAjDGfTNkVMcs8FVi8LvYxAYk0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080082
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

On 2/10/26 20:55, Gustavo Romero wrote:
> Update my email address to my current Red Hat address.
> 
> Signed-off-by: Gustavo Romero <gromero@redhat.com>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Queued via hw-misc, thanks!

