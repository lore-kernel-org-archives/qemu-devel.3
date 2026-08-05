Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B73C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrhDv-0003zX-Kq; Wed, 05 Aug 2026 15:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wrhDn-0003xE-DM
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:24:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wrhDk-0007IJ-Ie
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:24:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HSECO3344219
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 19:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W3mNLLw6k/Xak0TQCqCM5dgN6uQ5l64adZyyD00JMes=; b=STumKuxoFV/RPxOc
 L6LzMulSNqJCjiJWlV8CxljLJr9s842sOqK32fKUYltAr1jew+rpierixOTPmlfb
 sCWquaGj590zhSs64dUSyxdw2DA1dsIp1BFdLpI1abgDl81v+vLKgJ9x1w1Pp/pD
 4ueLV41/+MoXsywZK78eF0AiQs4nYy3uWc8gMGPlGBBIlEGJDaDMLxRoQA2k0Xla
 2yTnRyng4ua8uLALgiGE5d7lHL/Q54C6l6tyacpx/v8eIEMuIpDFF5TwrKUiQSaX
 SBVxk8txFvwAFc7LYnpofQzGNTBd7d4MijfBEQx+cbwX3xp/2LqmJMK/zMRQJd7h
 F9hi+g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x9sr3v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 19:24:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb74d5db64eso1428206a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 12:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785957844; x=1786562644; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W3mNLLw6k/Xak0TQCqCM5dgN6uQ5l64adZyyD00JMes=;
 b=Sszr1v1+NPmThTB1Lrj6FzVE5T4QVS3sKUiB34XnBNdcHsqwdFCd9BCnvn30SWUIit
 xr/rCKXC4+Wt9jHef2jy5wTxECfEDhALUW9QIjugaKeF9z88tiJ2MUJBAEdqMGR+1Kyp
 kpiIRWRgM4B+T727kDR05nmoXRbEzzE0pOfGYvBIeH5X7QA4EMOpGChvxn0lGlyEp/m9
 nPeHWDlTAzwQBT9tMI9vuj8GRqPp/dhOJzPeJMlQd8M9E0817g0Cwj51R77hKts5Hpul
 jdtVSAAFpfkUq5hRuItU2AAR3XpNhpMWETuugZTVQiWLzDBE0nvtSk8w1kzzp0zf+m3S
 p6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785957844; x=1786562644;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W3mNLLw6k/Xak0TQCqCM5dgN6uQ5l64adZyyD00JMes=;
 b=a78rXLNs2UAJ/J4LSg0lyzte6dlqdMommeur1v0W9NtqsQQ7I8dVVUp+X3yxsJLzqa
 Za1wweasdoE/P1Bhg3Po4VSEGu7PdSF8yLl+oXhciRrSNND5ODkeZ1jLZmGehHoGTUIO
 8a58c1p2eO+lSMGnoU9OFGSP6cqoW8DCHmGi8p/EvDnGXN9hdDRekSnJzHWM/+3tA/ss
 Eea1z4M8gALiW8qOh3huNYXAwv2ErGswT8L+qt5ey/+6CigXgVHdS33+PZSzh3Pnyh2I
 i1Mpv6rxhyWLyfJSTGztab3nuvkmReTlfFNW0u3g6D0SlH/Qj6UBfEmFxODoTD0VHdgm
 WG3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFMlMcpoV9mwkru1Xz1PWQ05qfG8Rwel8ntcUOfA658s/adZ0LrCssJVJ3I82kd659NNUDNBHdfWjo@nongnu.org
X-Gm-Message-State: AOJu0YwF2m+iiW7dlC7FIGdCuUsZkj6usJH89f892dY3XoAx/nHDanza
 j857JhrlBjMvdM67TFON8f6uUWuSeV1Gkgo+ipCnML5UwKSU2PFdna2PfKeGi3pKviu04y076pw
 wmczslMA57r4I8jLTSpn7pXT51ignhJTyl1PzKTz1zZo6p/qzlY0TRHv/rg==
X-Gm-Gg: AR+sD10JCmMdHIslQZEz+DMEzCIduKZTBioNp7XEbrYczsFQWQH7CaignJX5mdBjJo1
 /hSnDpl/dqW7NAKTtOs8q82h0iE+Iv4F5Byrb7/pYZeBOFM7l4N3X9/4dfzsUbvan+ziRopnFVc
 sPAOX0j54NlRSiamv+yQioi3kXTz47XTjv7MZo4CUDud+HERIXnP1/U7MJ3TC7J9UoOWw6vnd2X
 Jrn33QaNtISyDfSGfsHk7VsZian+DUBAyF7lsUaGPD1h7lChmU2C8JxnPndkh5yx2kUqmc8SJfN
 d/4/GC9KRw9S4GCnEmiX9S8pveBBjdfVf9Gqm8U1hogOMrqw9Ybrd2Mzy7Au5RwxZ7KG/BidQ2b
 nWcLVk+eyFAM7eGXjHE7o8tx0vbVxG8eyAvpTiLMUqJr8V4pSzdGYbmJLfwOZ7W4MtkyM
X-Received: by 2002:a05:6a21:4685:b0:3c0:b766:74f4 with SMTP id
 adf61e73a8af0-3cb85f4a279mr11260770637.31.1785957844526; 
 Wed, 05 Aug 2026 12:24:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:4685:b0:3c0:b766:74f4 with SMTP id
 adf61e73a8af0-3cb85f4a279mr11260732637.31.1785957844130; 
 Wed, 05 Aug 2026 12:24:04 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca50acddsm16683695c88.3.2026.08.05.12.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 12:24:03 -0700 (PDT)
Message-ID: <58f4d3bb-493a-423c-94b1-364ecd27e134@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 12:24:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] host-utils: fix ssub32/64_saturate return type and
 clamp direction
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org
References: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
 <20260805165225.3117924-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805165225.3117924-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE1OSBTYWx0ZWRfXwWrTcDzbO1of
 CFwSe9J2DwC5jQIl9Cr3AAbB4mwWCCYMWM4Etdqwo8XUKwCfvw5rX4opIxD2mAOxXGAoeA7cFBR
 zMRin200wN/kv9zClKZd4SQ5b8IldXQot+6Ca0eBmfLe/Ct653G5oeMQr0p6DzctTQvSph9E/cK
 +UNLTbZqFp09B1TDiEzkZirFeLGODXrEdtzKnrqq34ANjSmbHjsbW2aqefn3PnSKr/g3uR47TGH
 9FZo9oFq7GEHg+IRAKmICTCjnKsmRsuDylg5jJr8ykK+nwjQUszFypM49RouNs1Q+PMzTiJzxor
 OjVSuu3+iCgZbJpdWEIu+FhqKzvZNCzRDJ6or1b2L8i2+0VXdF1rxsTUL1eHo5y/nsahWdJGncl
 YJWi2hC/VlLz5L+IpTkj/2r1LXDAdqO4ViBumalwPK2c9SOss7s8938FXtz/yTTHFCGKLjmEplP
 Igs+XaNXFnCp+c559Lg==
X-Proofpoint-ORIG-GUID: noUkiaBlCHvJhgkZIwdNXsOItPwPqVvh
X-Authority-Analysis: v=2.4 cv=BMqDalQG c=1 sm=1 tr=0 ts=6a738dd5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=XT3WE8YE5UooiT4Obg8A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: noUkiaBlCHvJhgkZIwdNXsOItPwPqVvh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE1OSBTYWx0ZWRfX75yuRaNDkiX8
 arWtCc7MoSIraMfN/u9KMYmSe9OkBht2dMW29vs8vnroKjSLcoGImBYnzuEY5fOmWMMRwHI4uX3
 iyH7ihFijN/VcZiXp3OMBIdU3tJ3DTY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050159
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

On 8/5/2026 9:52 AM, Brian Cain wrote:
> ssub32_saturate() and ssub64_saturate() were declared to return bool
> instead of int32_t/int64_t, and clamped to the wrong bound on overflow.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/qemu/host-utils.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

