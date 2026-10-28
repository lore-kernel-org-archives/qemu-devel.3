Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A6B606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GTY13MEC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RPeZmmhx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAYe-00027u-4L; Wed, 28 Oct 2026 16:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAYc-00027a-Q8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:47:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAYb-0005Kn-Ad
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:47:38 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPdfr1580027
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I45lKDOum5NoadfEisVqegAyLlJKzS1QagJLtqlpxh0=; b=GTY13MECEnm+Wbav
 03Nn6prN/WecN87NrUB4GrHBjhRufIlyoqSzz6N/pHb7a6z9tb150ZD24vDxjxg9
 EXZXYJQRX/zJgrabOgct1k4Od52Ly5N94iNxCNT63jlsG93/KO1RhTxheXa71DS4
 dKEH/EzEi4u5ME/cpgI/aqESYyEaVBS/HN5FGtdfz49j2Hq1tjiEyLwOn5DHSIEl
 X4X6ON8jbGtFYmk44rzNxhFjqbO8kpTRU0TIhMjizi80Zh9qlvPHLQCzn8cLfwad
 cb/yMdk6+8z0Nq9BWeQxlFkHJxQEaM7mneJIqnbsRYMD2EeUmVYDDjmh+TMnDvUL
 D198RA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkp8pk4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:47:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so2744701eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793220455; x=1793825255; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I45lKDOum5NoadfEisVqegAyLlJKzS1QagJLtqlpxh0=;
 b=RPeZmmhxlxKG7o24GA6LtthLQBdDOY+PQdWIfGmjHaOiPfE34iLLpmOh6J1QE+MMUD
 jZYeaVVrnNcTuQ++Vyi+QRg9603Of2oM20kCFNcTfZLeOByW3XV/Yd23cpEyftTj1m0U
 cg3Mx6tklafaUXUiE4ncNCrlxPd461JTaehtljyPMayhRMzJB3Q/Gjg9dOqD5XPZOT+i
 Uyut4z1m4ey2taHXcTSsMkLJSdBp/5p1vyfh/Gz/sTHgZ/ZjdJKxrGrVi46twaRGAgwE
 /F96Q40SZrxektbgm3VHuK84XjYYdzKOG88a0MJN0lzKtm0mYePy1EzSztS5zhOAKKIB
 hf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220455; x=1793825255;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I45lKDOum5NoadfEisVqegAyLlJKzS1QagJLtqlpxh0=;
 b=aHKCuh7r85jIGhLI7e0k66yaSxbilYTf1DpsK2P4GfmGRQy3h7GuJLACYixUHqt7Qo
 U3exhQmy6BY0Ez2yLp+CHt2TtubyMeVidwG6wn4B5CK4rEvw6nU5DQIzNnF+iVtDzlna
 GlcXFwDxbnOanrv9Oufc7x8E4p7p/U/Uy/BxITO4hJUlMKVnp76FmK/EptYHolEVD2eB
 cRftqQDTol3obwVCu8tB/4CunsNCWbZuRul4lmPM4rE7S6jI18U7zSZWDn+BaG4LU8P6
 yzwc3/7MjHJn5VXvC5JV0R2KN7Zr+56loX0QqdLzzZp5BKxL8Cyrj6kVYTdiJZFiAevI
 QNLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHam+dRbgp+TCuXdafFaOYScPG1N5EDb+HNgfrSGEizeVxKit8XF59PgyARN5MjEnC6YJodLiOWyh2@nongnu.org
X-Gm-Message-State: AFq9FYJV5n53tbE4Yj3nvVrFSjBDwIlZgmpxcjcCsN5eTMHmZZgTBJxM
 DJqSE4mkYp79j5LZdbgJiGHgjzShtE1+A8PxGtM4wn/MHtcpOSKHnRAp/iyC2gSq7XZ76jiLrH2
 cIchq4nVuGkxQtCvBP2pUEp0QfbgH2XVWMKGy9xPtBaffgRLy7vYpMcClXg==
X-Gm-Gg: AYBFou3NpZImMXTFwKsJ0BVVhYgmjRQuiuHFXjR5q2sg/ZVX08L3lQSeQNxQwTpVtjL
 95uhn3f8/9unCggEhI/E6O5nkiiLXU9SUWcHn1vqf/OL1FAw9S+l8O1wDZbQEMVmNiqcQPsbw0A
 xVVHcwiMdhdz1oGi1BM2Qn7SbQIOBUaGYFL5ADTngB2IkzycMPE+C3NdRd6/BGtBJJLLqYbkVu5
 7S7e0cWbDOJiuLBqa5knxgxghs4qW6tGv68BN2qKWD6ST9/s2sAgcsrMhALvpO+C0edKcSLLWYN
 fxYMnbmA7GR3WM4poyLLkdGQl8/LIDlOhL1bM6QUXKhVzkmSHxEzqj63c+MJl21jQS7rVyNUIu7
 JNg0paTrIw6h3wibmfZN0JUhZQtTJ78y38Plupz+IvsGGfCp/0S8hKPAJ4hzihT2T8EcB7absso
 2mkpgoL4sy49MKxANTrDcVyV8BT0NFtTrVEX+CQl0dysU=
X-Received: by 2002:a05:693c:2a17:b0:36a:1bac:6bf4 with SMTP id
 5a478bee46e88-36a2039cb09mr5202685eec.18.1793220454976; 
 Wed, 28 Oct 2026 13:47:34 -0700 (PDT)
X-Received: by 2002:a05:693c:2a17:b0:36a:1bac:6bf4 with SMTP id
 5a478bee46e88-36a2039cb09mr5202639eec.18.1793220454312; 
 Wed, 28 Oct 2026 13:47:34 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a238da3e1sm12647365eec.8.2026.10.28.13.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:47:33 -0700 (PDT)
Message-ID: <9d4b42d4-27b6-4899-9ae4-02fa4baa7563@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:47:32 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] hw/loongarch/virt: select virt machine types with
 is_available
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Farman
 <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
 <20261028201557.2688-3-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028201557.2688-3-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae25f67 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mcrl7TYwk7DjkRtL9ZEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: -LPPUAyIGE2GtR8rX5Zf33H50mpAgDbf
X-Proofpoint-GUID: -LPPUAyIGE2GtR8rX5Zf33H50mpAgDbf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfXyvw8dW76iIxi
 0tRZZa+6rEhNtlGbzZdzx42qNDtyCmdn0OpPJuD/IXjrfhTkfi8jvTrz36KTwc/tgJGKvkyDQCY
 PrV43UpiQqURlBCxyeb4VAZtF9N4QDs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX58RkVMSbFLUu
 uFdHCBW6Q63002uNN5Ip1ykeWslU8/4eHlqrcNyinA0GBepWz1hcWSMLEh5Up1z0Z/Njrk3pwUF
 r8YEv4fAW2zkp1J8LMcnkYNpaeaEb4GS0zKO27+QhRwvNPfJAFvaqgVaVlfPRWUwLYb6P2iIrPC
 fRPzNjIIOsEaTY1NIc19//UHMYPQ+oxTjHce4RGzA3Ias6EXKDojHrQ3i2SBITlP7S0KaeCHi/y
 7qRqqnr7JmCo2XxshHj2gQOb2S7iI7fY2OI/iU4VfkWzN37V9IhLqBon6SW4zHKwSfhiJeoLPYU
 OspwCN35mkHpaDeww5N0YuyytaRGJ1Q+PzRRGOvUOd3PFIrMhkKRljlqFV9cBOBqqCMXUi2RCSv
 VnaM6YwfXDifGKaYsZfMUiYcYQMVdRwzN8GtgiU4PSzqs/HsZvxaaSzh2o51Mikl/ywCMiJsVXQ
 h3VHBx6Q4UAlemFy2qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 12:15 PM, Yonggang Luo wrote:
> LoongArch virt machines use the same QOM names as virt machines on
> other targets. Register them only when the selected target is
> LoongArch, via target_loongarch().
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  hw/loongarch/virt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

