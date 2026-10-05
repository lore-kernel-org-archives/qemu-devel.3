Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C1CCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkaz-00058Q-VQ; Mon, 05 Oct 2026 11:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDkay-00056f-6X
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:27:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDkaw-00016L-KE
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:27:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EP3Gh2015016
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 15:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vd/Fe+SRE/yTPzyqk25dZAwLtqJ2dceKDx4JWjNCVOA=; b=aMKNEQrKOLZJZfvf
 m0qQ0Eda5kY6/P6vww/+F0WPo2qb5LivSOA91mY2E4aMtGLyAUUpU37L0L+ZLSRd
 vEXDVyAgmVXdDHRd/0QlZaBTDbP3sWY+C2PtvGJTb7lW7YAaWDmRKtrPYjjy0Mxf
 9iTXC07KiYtfuKm3ZNv9oGU2AP7M/ZIvWxX1tc6BWOwOqPGwUfLM+Un2zSUS3NBu
 GPUak3VETpEkFVTHsKv+TvXhiaTK3LcmjuXFXJJj+z4iDdLvqiIiWn5j/kRennt+
 uqCJguGfU2ZZl8Sx1Aon1ilXNRcFpv+c8fFDfud+ViIUNq4cftuJgwb8f17uwMU+
 ejIt0w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xhs2qpf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 15:27:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so4459353eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791214032; x=1791818832; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vd/Fe+SRE/yTPzyqk25dZAwLtqJ2dceKDx4JWjNCVOA=;
 b=NrJ3NN4ETr364Z5ri+EAoYPZbjDswBnce4uPo3ABzGcNIopGiGJihog06It0tEpKIM
 smoxediLuBe4ix3Waln6CPy9zBKQIxRiSpaOgwuZHMjiJkwEdkiaXXq8rHNqCbIkVsqo
 M54/RBSsfB6U277NrJlEKDPj18DG9twrLby5LNZBhbuy9MGdOg3vNzeqD3BQg6isynSE
 0PQaqMV9cEs9SVnwD6oQbfYMXRXjOIZGM55g2Drk5Wn9npBgzAEQn5mC62HAUt40K+VW
 pWo/P3dUs0ZORZU+lEp7jsk39kWz2pmthjiRuzt34iTEVEW3fk65QPuwrPrj5Pw4DwI0
 C48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791214032; x=1791818832;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vd/Fe+SRE/yTPzyqk25dZAwLtqJ2dceKDx4JWjNCVOA=;
 b=r0fLu1I8Vdy7/ytV+K2KpApls55l1ElBCO/7fFv/3NGFOnQqMR4ek4X3d7dL16l7+G
 01s/0415wa9vc7I9yEiQ2SswS9fevRvRApAJWZmJvpJ992XytXQcpWoDWArAAvU97WNV
 JgQ7t+SGYOg4cHU3s5akLMqBbiqboiGGi9E7h8W/4WkHWTWEEt2InyA3+Y1LmImGzVmd
 bnJDYH/VmqvE2XmR/IpJXuBrobJNhwWemv97oD1IQSzL8T4OADHW21kzLZdCTB1x7tPj
 qb/t0GbI1CtX3VScQzTuj96e1OeGuHX/c5ejXoY0AygtrGkswfgFAS1HThKFv48gJUcG
 8TKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3AugI6diRsBtGlVIir8yK6+srulQFF4iHstb/qug4kjNDNQOOuLjNRSZkpglvSgUAQEbgE0dvo/VK@nongnu.org
X-Gm-Message-State: AFuF++kKdbQCTPolBzBwRr2lC7+c4SU2vI2a5pKyXFRvTBuxkjsx9lIR
 tktOQnVEE55vN54XacVkfgaBq4EKLYZd49JJ3FaydCsgv9PNoXv31t5z4/xX+t6UPEH75ZF4mRe
 N9lmeik3+7PinbqgD3GWt5znWAbmahD8D4lDj30uN1v8YMnkpsBo/IDQRBg==
X-Gm-Gg: AYBFou0WbWhJeC7mzO/eyg67DXPZjAFKuG3x+xWreUhep7XsKW6Ck3hBqGi8t2loVS4
 fWh7w+yEtnddoC790MZ3EVVq/KYj88wSCRYrjW+d55GuxkGx2WNwNJyFU6urgRLk65MrcTlaFoa
 b0EFLBEHl/WIarCsQHt530j9IPfR5kwlBTV4I92SAJk2RtDUJD4EKIBLssnwr+Due5ILnMS6BEX
 b3gdSMo7t/VUV9R+KMsO41XqSPANRfO0xnSq/mxjB034tFWk0YIheZ9IHMhP+TbY9c0VNIA5NFU
 Hf3pF33Is67R3lJ8SiEnKKAKYyf161kHoL/PGcq5J8RUjuUIwfz4vDuWf6ZQo/A678oO4qBqa+3
 l4h3xbpYT8DUh5H+KYxi5M8YkJNIQZq5Lz96HhPDtVu5KO6fMFnDQ5oGGHCWn4P/wlwrgXA==
X-Received: by 2002:a05:701b:2086:10b0:144:e38d:8e52 with SMTP id
 a92af1059eb24-14f5c5e89femr13837564c88.37.1791214031803; 
 Mon, 05 Oct 2026 08:27:11 -0700 (PDT)
X-Received: by 2002:a05:701b:2086:10b0:144:e38d:8e52 with SMTP id
 a92af1059eb24-14f5c5e89femr13837540c88.37.1791214031205; 
 Mon, 05 Oct 2026 08:27:11 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fca985c6sm33553486c88.10.2026.10.05.08.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:27:10 -0700 (PDT)
Message-ID: <80659d36-1a3f-4ce6-951a-172d672a7625@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 08:27:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Gustavo's email address
To: Gustavo Romero <gromero@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: eric.auger@redhat.com, gshan@redhat.com, alex.bennee@linaro.org
References: <20261002185538.1020233-1-gromero@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261002185538.1020233-1-gromero@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QrEg8Lb4DwlKt9MLJhdcVn9kWJUhBzBc
X-Proofpoint-GUID: QrEg8Lb4DwlKt9MLJhdcVn9kWJUhBzBc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfX6+Lh9kQuORnN
 17Cj5EforvVCJ14NLPIQP3JousfikFrlgn+xj3eLn0WQyIqKZRkT8gUqG6HujiPx1Qk7wpiHyCC
 ms5Ksg7rNTXp279NBxIwY7JbBkABVSI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfX7PfIS2m4aFlf
 wlZAKnvvpKFP68P8Yf4PdfEm+M/LzCmKZDqroXASYIJK41lbEcWdy6x2poYZAfOKETC37EE3FM0
 0X5XCH+eUvTgAPIqj9W2HS0NsXOYjt2gtEFw7dIBSCS6dp+5rECFlaCKwOncSIqy8aENE+u0Txl
 vQ/2aPvU//WmiM3LFjjK/qxqyUOnzj2r8/oSqdVyuxuQYBqFd0WK+kDKeFTexVNhfcRGdeW19M6
 CcIcJ/X+EsgxFtkTwgajakLuCM5gPw47U02Z2PGOrnzbfEQd3oWqV3oniM1bfxRgefk2qXUWmqr
 buMu8MNiCYM8lK5+OwJ79QQJRwmobg6AI3P5mMbuP8QYBcXAMaVg6dIuvynIRF/LF8ZecnhGV67
 N7v/FuF1SadsApmgnvmQFx3FzXkqdonjNKutg1sm6mtIIy9OLdjWp+awEFO1UvW9+m9mUupmyGZ
 2ThNtf6M/EE7FMY/7mA==
X-Authority-Analysis: v=2.4 cv=Q6tHcI2a c=1 sm=1 tr=0 ts=6ac3c1d1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ku12R8h4HjsqBJT5z5IA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050060
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/2/2026 11:55 AM, Gustavo Romero wrote:
> Update my email address to my current Red Hat address.
> 
> Signed-off-by: Gustavo Romero <gromero@redhat.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Cheers,
Pierrick

