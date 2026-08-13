Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44D4C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuX0n-00008x-Sp; Thu, 13 Aug 2026 11:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuX0m-00008A-7r
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:06:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuX0k-0000rL-P3
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:06:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DCKklp2765862
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 15:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dZNW5ehvzPXuJ+c028RpvvezrzPsfLWCzRxY79Wk/Bw=; b=hQqSJGe48Osza4T9
 GszbM2W1Gw/qOjbXmWEk4g8KxW09LreRXMe5oFmGpHaYZOUCrB5dq95LDBo2WCEP
 8uaeGRx3ZQO6nA4jdwb/iZR4fSpn7sAHZp4ng0XXqbuTKYFzd6wfgCdsQvOcO18w
 nfX3XDpmVCgOFoM94tx6TLD8C2mVQXOVy8z+S9+ud88hN6fGa85b5WaCYWxEiaNi
 Vs7/kfhrbFsTvmD4Z1xOHPiTG581LjNYW6grv0Xc3TeiIfN03Plm4XvldBtdnk8v
 xdny13WmJhTcxCTieD7KDzfM95uFlj/wasznmQkjHcp3bqo0XHqp3ckiYSmvqGev
 U+EM7Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g11askrm9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 15:06:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d7b3b6aa2so107681cf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786633585; x=1787238385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dZNW5ehvzPXuJ+c028RpvvezrzPsfLWCzRxY79Wk/Bw=;
 b=kgv04PjPLCrS/r3GQUnExR+ToF+VESZXD9Szq/1S0NYhBWDtzAh1MkIdjm9X6VTX4p
 AmGZFYlwlNKYu39iVfnb9Nd5Sz5/FHCJrDj+BzqB9ppyO7LywE0ubsfE+SYOCV/o6kY6
 7OXbOYCdbK7KJuNqHtg/Wr3ja5LjOENF44gqbDHKLZqxiOvLvSbMI+cp7tNLQM98vKM7
 w1Std7AXoha6vMYdKjn3eoSYnTLPF+iwh/MT/QT/+12eVG9lrqje99rXuMtgSYn8NZdV
 oH2Kdou6MXX+JgPfKmGEcJuQEGUVvc2KxNPrLQGIeAiT+k7Uifv1uDixHngosrrojqmd
 dw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786633585; x=1787238385;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dZNW5ehvzPXuJ+c028RpvvezrzPsfLWCzRxY79Wk/Bw=;
 b=TGG/aYSWywjlaEbIXONwsxc7U45nPVN9Cvp4tQ6pD28HSkk2zTBsxOYn4vl4C4okFP
 lRgFWWSzAEyyAivMHfjx4T2U2l+DffIxtEyT+66WoflK4vegB8BaJ4Lu4OjfYhYmRd5e
 X9Tm4ckrkzZeQ/bbyGgRl/7+lwAyVfyBcjtreSbxYD9gRsvMjmB8a/F0sY/LqRQkRYs6
 JyAFPP5hJuRJyets7SS5OgQtOpmiaAfjIPK5e/3nb2eAoD4T2yyRM/0oD5Jut7TtfuDM
 7q6X+SY1U1XSkNn1J4IeDKtRU0R/7uGDP59w+uOPvE0/v0zSQVntP+clVYITed0GWgm5
 slBw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7pvnCIrLlk66KmKG5YfNZlyNr761TW8/mWl3bBIZ+qgD9v3KdJAh7dgD5bFnHOlvIgP8IBZrCq7n/@nongnu.org
X-Gm-Message-State: AOJu0YzQwQ8lQRtVpjbXrOK5S1zm8CCAX38Dv6wqBiXNgaNAbfFJYT+N
 BtnbGXwKAdtWU75LFGJ4zxjDOhXAH/yzaMP+kmb4YI9GYxijp+zCJruXBxStuSw7ScGxH2j8Uo/
 IidBgU5rWL8kkKKGhFLvhmYYE9lQob2qDl+m7GNjrmXfzoqLqDIEum9acRA==
X-Gm-Gg: AR+sD10kvEBrZIcMYv6L70iEBvfoc5F18Hs7U6F15mh+qno35FWMeDYjhazDJvjSnxf
 t3X8BiR8gu0ZOoQdZ16jIuLy0AcmGBTGdrQfm875COLmGzJfaxAZbTMDskl4gBpuAz0i5bSM4+V
 8P9xqQNdZ76hRT5PWO0JjLB6c36UrCtfn/Ji9ZDVSPcxh0dZ8Em8blibPYZFEl4urtZrpuaJRZ9
 L/MmdIrJss5O4P9fDDMZrWWQ3nZuP93t/637kxP0XGRYe8w4kgU3yhL4B31/vKFjAASD9TDeWqe
 XYIIxz7yi0snFBMiBaxgp0KifJ70OVU67TnZEQYKRry/k/ui7oIbyHYWVew+cf+6NJsOe82XtES
 coQLJ6f2yPfOJTGCHXstvDzOi0MU2a27dPoE=
X-Received: by 2002:a05:622a:2507:b0:527:9603:8123 with SMTP id
 d75a77b69052e-52d73c37b2amr70205071cf.2.1786633584718; 
 Thu, 13 Aug 2026 08:06:24 -0700 (PDT)
X-Received: by 2002:a05:622a:2507:b0:527:9603:8123 with SMTP id
 d75a77b69052e-52d73c37b2amr70203061cf.2.1786633584046; 
 Thu, 13 Aug 2026 08:06:24 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5b6616sm7820496f8f.25.2026.08.13.08.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 08:06:23 -0700 (PDT)
Message-ID: <f9ef6f8d-39a1-453b-88ac-dc372abe1a21@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 17:06:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tcg: Return success from tcg_region_alloc__locked
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: yvyas1991@gmail.com, qemu-ppc@nongnu.org, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com
References: <20260813005031.518387-1-richard.henderson@linaro.org>
 <20260813005031.518387-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260813005031.518387-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EujiaycA c=1 sm=1 tr=0 ts=6a7ddd71 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwOCBTYWx0ZWRfX41yQetvZqSAS
 1g8d7gXttFhG/h8+IljnFuhx+6aJ11KkGnIxR1NUYfA1L598czRKjCSoc1rccjfjtUJ5mb/H2Bz
 zFvFSxDXhql1utPhAMo0UE+K4zhStIsNkmUsOH1IRlDk98Jmq+uUMHqQPR3Tj8T4cuZrA+hGD9i
 CZF6QVbJQBOUvbEGE+4ro7yUBQ0MciCngLDFLm2kwudwcYGo1J81poFK9nRRE+kTgnxjPdsaM4H
 amzaXeuyRWfLDBqJok6femz0xhYBlcMejxnsLfTrXw4axBtLDMDHjKoXCbRuuUcDXnCUDWnhsrp
 KoT7laCzHqwPeoEoXySULFPrqEtgZLKgluhcWqKFEoz71tuV2m49jmAXBL5sULTx01HOGyp/Nc4
 SDich2DHuIeXJj/2pL5k8avfBscqPK18YGJFSVKUZuh8hETA3F0jpAEh8AqVuAT2ESLN6JRNMOV
 CYG51iqCdIbRlYi5sqg==
X-Proofpoint-GUID: 5Vm-L-rebBOAu9R-WODWH-4DkFsvanlu
X-Proofpoint-ORIG-GUID: 5Vm-L-rebBOAu9R-WODWH-4DkFsvanlu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwOCBTYWx0ZWRfX7/GO6f8Lt6Xs
 J/9cFLc4InVUNpB6S1OrOmXbyo4GHXcMszvNp+JswIFtqgAKEld9wEPk4Yos48jksJWO9Tu3reC
 HQANLhwHdst9lDhjxARAgvgQg4EceTc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130108
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

On 13/8/26 02:50, Richard Henderson wrote:
> Invert the sense of the boolean result from 'error' to 'success'.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/region.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

