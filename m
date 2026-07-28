Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FF9C54F55
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZUF-00074e-44; Tue, 28 Jul 2026 00:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woZU7-00073p-F2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:32:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woZU5-0005pJ-P7
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:32:07 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3arvU1701599
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ub/0ZePdk4Y90jbtQ+uEBBUliBz8MAqA12F2Xm3YUoc=; b=k3Tmj+qlCqTc7La4
 hyBKFpImSP7ae8m1ODc5DhkSb9liJvSL7IAdL44nSn7v1D6nDYjxAU3wUZETvldX
 dcH0ELh5cbmHAS290KcHyZ+CPi1IXa1p9XMRh2eIzpCyV0NvAI9PHWx74KvAr+vI
 +91SUgJ+y0omwGYlZ3SvAi4XQqpUzyJdfibe0fL55/tHCXX40yY/ObFWTd3oHsmv
 4zJMyLb2oFLKs+uCh/fhEL8/16FukxkllbZwuoKFz6maotfbmAozxq+oAuRFdSdv
 h2MYKDK16de6nCYWgu0xgQRdvvCN5tPLsW5qNAKOAFXUfdHaMCKvYQfTW+hpiZMV
 uhEFvw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7gv32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:32:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c12e43b98so42670241cf.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213123; x=1785817923; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ub/0ZePdk4Y90jbtQ+uEBBUliBz8MAqA12F2Xm3YUoc=;
 b=jN3J5yQ/gnIqDiv0NOrd7yN4uNo8bKGJWU2sngLwixqz7kHUBt4yIqBY25xSabHBVl
 813lSvhihGApT0UY+nn5ruL5xGsMbLyQ+zcBN38ZzxXNqj6zghL2MFuQz4TXbpPFVZP+
 HG+GWtwFfMW0sUULBXMXWJKgsN2q2BlZYhSDNms0R6fCpdUajyQMN8lhzyJwgKv0bynw
 hOOCG4HIRa9+pLhxw4eJ72JUO/qAzYhFYW0JNM3WufJvyTGVqbjVWFTj/bJWmLoQ2xk5
 G6DtHYzSnVJyM+sXENcuwlBFIWxKTnHPl7DmjouTU/PSdj1VRe0g0eJ3fkwT+pwAfY+2
 Pnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213123; x=1785817923;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ub/0ZePdk4Y90jbtQ+uEBBUliBz8MAqA12F2Xm3YUoc=;
 b=d+9AbTwPLENn7o700depj7yGFiirmcsQI1aHrPEI3UOFgY4uuYpkx3kakI3du+6iWV
 ZjLBdIHy1ije3xMIODA4/El7ajSKjyHNk/1jjz3UTue5lp75KaI+AEYCVfXn76GTT7Ee
 GcXmSQMCATssuLyXc6exUSXRi0vABIqDZ3S5VA3Bkg7h/v1eLVpqFLsmvKZyqZ3D6Ph2
 VPc7nKHM+qrnhcWmHX6+IpP/N6Be453uJRjCmxMd5A5guZg1kMafazLl6btwccgndgfI
 D/zNhP7L2G+1ZNwd3xms2eHyFCVY2fWA6sTbYkF4i3XxgaLr0ZDbepPeYMrAgHa07ovk
 l2lg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqnh6da3JZ2heOXsByWC+PMUX0IFX0vBJUEwhG+rbRwKEcD7e4iQug34IPHo8pq1vqWDO1b6mZ7G8+S@nongnu.org
X-Gm-Message-State: AOJu0Yy5eR0RJn/VPMt2a+lFd9f0d7Adv2CBwUIxj2iAEZ5kDLwXvuKD
 rxemoTC0SaYWAAOzBJJe8E2KhmnZ6abudNNR5SOg6NOITho/v2ltHGaM3MoufpZg4dANGfmi46x
 6lu9DuAGVh5YSzTUjOtri5CV2Z4HV+Uog/ZMSbDHE0Q8hHcxHpIfxEnw2UA==
X-Gm-Gg: AR+sD11LW7fcRbzXJ+6AXncD9BT4lljSWMRVxfVtdbBhCKSdipCWOCdL9Bx8GAgkaus
 kdGoDuzcHigsAgVQTmAUEL/YKGPJi6wgqH1fl4v72gqeyuV21PUoOIYy+RySw9VDNsYRwcEo8hg
 aRf2i9xJPKd72dAQJx6td/n0pW+6Gtzgn2OvdAewb/AUkQZvZ7rSc8/6Pu1WpQXHINr1aC4Elaw
 YoBYeR56CDfg1B9VPomiZ6M1Cb+DtqLNuGs4Kh2MbYLz5dPAFkWJOhTHtUmdM8r7p5IdZc4dcTR
 +Onvr6gLvDf0qOqO57GRgJj7XpIRB291uh5rs0a8SU4vg4cHlB1VqRylRj9BnVM3xo/52kVueUT
 igmpljY1wbQT8Z9OhBn3kFTAjFdcGt/0ow5u7/RwS7A2xeSX/kno=
X-Received: by 2002:a05:622a:5292:b0:527:8300:3d78 with SMTP id
 d75a77b69052e-529d7147430mr5596781cf.70.1785213123519; 
 Mon, 27 Jul 2026 21:32:03 -0700 (PDT)
X-Received: by 2002:a05:622a:5292:b0:527:8300:3d78 with SMTP id
 d75a77b69052e-529d7147430mr5596561cf.70.1785213123095; 
 Mon, 27 Jul 2026 21:32:03 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85a2573csm54974574f8f.0.2026.07.27.21.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 21:32:02 -0700 (PDT)
Message-ID: <80f8b49a-2f1f-4070-984a-a0543b6214a9@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 06:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/display/exynos4210_find: Clamp windows to screen
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260706173324.804340-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260706173324.804340-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAzOCBTYWx0ZWRfX5ycxO+qoFtLO
 H2N7nJ9TSBikuuUEpWg6FRdWikzAa+1qUfXwZN982QMTV4gJ3YqteWnl+0kJzxqR/QkDdiXgtaZ
 b9qYbnprT1ZEizBAHJ4scBXPW43nQ5VhJCOk7HLJCQ4SIXeba+JvDjeYqppZWKoYEsYrkGUG/HW
 JRfGzGv85rdP36SbmNiyor+I0jUR2SpY5cMGtf2WGzoowT8Fh8cjeIERIRWl34uCH+0seseDbpF
 HdS8cTSAma2XstW0xy7EzlLUY4oc+O/jpGsv875O1D6/lBN3IMeQSq91nNnRahWsAF2Mi9EG4ou
 2Z+cC6HhTKzbSGxZVbgTOXrZq4hJpAZkWZKSvPB2Szuy3Hal1OiYkW8lRXU4V2Os2ovGy/Zy6qv
 clelRwGExK3kO+oHSi0xTSc+jw2kztDqcwRJJ/Ts5FD7MK4iZDLtOraYQaebmuxmLPu1N6jhCy/
 xZd5BGgMd6YsQb2jGRw==
X-Proofpoint-ORIG-GUID: fMj3REiV6AB4ZMeURRdEuOBeIS3LOvLd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAzOCBTYWx0ZWRfX2ihUy+O9pahk
 RvMWdomsbikCHPgso6SWp4tiIJxIcDopOC8+sCYTTRNhi/6cO3ywgBi9jSym2YZfiLaVyGu5zpf
 tJ9cxB7YY8eEdb0zxybjqtJzPcFS8kI=
X-Proofpoint-GUID: fMj3REiV6AB4ZMeURRdEuOBeIS3LOvLd
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a6830c4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=DdBaGUreeh0kHB85sUsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280038
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

Cc'ing Zoltan & Marc-André.

On 6/7/26 19:33, Peter Maydell wrote:
> The exynos4210_fimd device has a setup where the guest can program
> both the overall size of the LCD screen and also the corners of
> "windows" that define where the guest memory should appear on that
> screen. The current code assumes that the guest is sensible and
> puts the corners of windows inside the overall screen. If it doesn't
> then we will try to copy data to an address that is outside the
> interfal framebuffer memory that we allocate to be the size of the
> screen.
> 
> This patchset clamps the window coordinates to be within the screen
> size. Patches 1 and 2 are simple refactorings to make the third
> patch easier to read.
> 
> This fixes https://gitlab.com/qemu-project/qemu/-/work_items/3795
> 
> thanks
> -- PMM
> 
> Peter Maydell (3):
>    hw/display/exynos4210_fimd: Factor out finding screen width/height
>    hw/display/exynos4210_fimd: Pass width to draw_line functions
>    hw/display/exynos4210_fimd: Clamp windows to screen size
> 
>   hw/display/exynos4210_fimd.c | 54 ++++++++++++++++++++++++++----------
>   1 file changed, 39 insertions(+), 15 deletions(-)
> 


