Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250A1C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wprD8-0003Ja-Bn; Fri, 31 Jul 2026 13:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wprCf-0003IB-J0
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:39:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wprCc-0006jW-K2
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:39:24 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VFO8c23879395
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mXA8m0SO/Gx+ltRmH3MlFa85Q4rEiE+qfxWqOVZIq+E=; b=NOdTxmTtTwUMIr00
 iHDKgEnj5uPR/Ig1+WYKb81rz5SH7GGQQeWBlxmsz9mqZVsZJSF39b3n3A4XZJA+
 gD8Opu1pShLNI2kTZpF0AT/BlsopdoQzDhplVay2AGs8gK7NwDhkPlj8OOgSCSju
 OqOZhAEBV1tqQL5DMPl+0HZ6+ZxhzNunDwg645QoIvD6y6S52ZnWr6bd7ZZPfw0I
 4P4THhoc8BSGwkyoEoICF2ozf7DTtK2hZ3BFhr19UDNeeX58Zd2FYdLmRShIV8m3
 wlHbkCMBvUHtfMbvIXDuf1DFyoKfs7rD9f33wwegymBTtfKYl2TEx/pjKDOgqsqj
 KCoutg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru0y1krp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:39:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccb6823efcso10252635ad.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785519558; x=1786124358; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mXA8m0SO/Gx+ltRmH3MlFa85Q4rEiE+qfxWqOVZIq+E=;
 b=N3867OggCbsLT6BZmOTBe3kDy/aL1FcR/nfttfXM3Hko+jMkR1lw1WVmh1M43zJwW9
 NsrKVfnYRbjljgGRXCsOx/LALPrQI/7NtZhZ6wby8TvT6023ypmyCqemBSEKDiNBFBhP
 ihYj61H9ol17G49n2WjBuQCPe9GnoFZtkWXymp+7BR3ilUnraimB09PlmKLGXvEWQk+A
 kxN6BMZaZFsmqsZpbY4rygPZbx+cncebgSepTRcWkDJviXI7NAsNoEYuckZ0EmQfhxd/
 uvunc5a2e+EGeZ9SH5k+/LsaBRkyY/1oDp3/og7Ex16JjQytE6ID76Vitey1TNS/7lE2
 wYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785519558; x=1786124358;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mXA8m0SO/Gx+ltRmH3MlFa85Q4rEiE+qfxWqOVZIq+E=;
 b=WwR9C2PnALgHQa1W6AA776VdWLuCVxZMcvPquW1mYChP4kL/+yKfaTQKgZqZG9EcX1
 s6ztwrleVj2kdCouU+z+TwwT7FB/NtLXzu3Xj5ui7rZ9a/j8UxpQFwho51J3Ad592JUq
 fYHjKDPYvTg2ccVJH179KF8B6Nhsr5ZLILv0I8XtxGdccgaD3qMmD1lK3I8BW17t0p/X
 Dv+4EXHi4FjnsS1QQ/ikJ/+eL9REsoNjvJ2REfAJdBIuvB0O6wEwQgP3DtALmaRos5dW
 7/UeotCop0LbS+SThxIjRSvWIi9naG7uG8dBDsYK0+Nog79WOKSOU55NDC3wi5MBpaCD
 kxOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyIapW3+rvBtsBxWTnvdKGjps6ko5lmABE6cpbm1l0OMKnaaD3z18XQuXZzKarBg0xvFoGfiXwwOcO@nongnu.org
X-Gm-Message-State: AOJu0YxEOCgUzlp1L6roAWqLrg7WMLEyb7O8jv4qfc/NYj5Geoivjosm
 UZZZWoBsEN3v0fp414/dTJEngUGAxgpMq7oLnrNESe4/isT/SIOKmLXTEZ3EeT2+zlJP8jTHLfF
 GjxJvK4RT/1yvXV7C3/jyYhVVTEn6idmB3zaZClYuliWFzcBaQFAZ99MliQ==
X-Gm-Gg: AR+sD10/gDvqaB9W5Z8YL5f9hLwFAXtyx7Ty7lFztoFUj75Hm6HF7bcqKzHylavfX3V
 VC1uewASZiT0oSUDZy0+HXvawKVcolDWPTbkKJmx/7XurqvepVor9jNJIRLFWUvEX7IlzOvPNwY
 hFlN1xBqKfkSA5lMMTBp0wVj28+mb3xog3CvwBsxwBmswl6L6w414sMouUeMQ8N0PZEX8V6aodd
 GwK/SeduoXvOkJzLypBMQMtmVfHBrLlGOafBkdnpwA+WPY58BQ6oGF3aBOfEvZ9NQB36u7uSkKO
 odKzEy0G722qHxCix+/PB19qwjJUS0gCuRe5aufYqXO+IVV2MmkZiNeZbFrBl4LaAf2Z06KnkQZ
 qnKXC3DLmgXuzEGceKL5hJalAm9nsEnPm1yzFI+zYPXGyVAhqLBe7ZsJo5ogSh93McXC0
X-Received: by 2002:a17:90b:55c8:b0:38e:11ba:992c with SMTP id
 98e67ed59e1d1-38fbc44261fmr578236a91.12.1785519557837; 
 Fri, 31 Jul 2026 10:39:17 -0700 (PDT)
X-Received: by 2002:a17:90b:55c8:b0:38e:11ba:992c with SMTP id
 98e67ed59e1d1-38fbc44261fmr578222a91.12.1785519557358; 
 Fri, 31 Jul 2026 10:39:17 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38fb2bac654sm1038291a91.10.2026.07.31.10.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 10:39:16 -0700 (PDT)
Message-ID: <37b0fbca-4626-44d1-af35-1d500aaebb1c@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 10:39:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/18] tests/functional/hexagon: enable more arch_tests
 cases
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
 <20260730012824.1135905-19-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730012824.1135905-19-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNSBTYWx0ZWRfX3b1ZMQPyLg00
 UlkvA2G+aeStvt8RnAWnJOio8SOrdkZEEMWYB789Gy4DRcMEjNH1LVntF705WjiQ1BLz+WTYrWk
 DFCJuYi3wGYngGXxSenlXFFzbYgwsnQ=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a6cddc6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=7P3ncBC4fLWaOKjC6XAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNSBTYWx0ZWRfX4fHlQrG6po1t
 LEXLKABHMeiPDErdUAslrttQypE7bWU0KJa+Y6hb1XO+gBTq6R2Oecf/l3icFckj0kipr13nc0f
 fBHBPPZim/W5oBkRutfKJ/H18MhoG0rGftMuSpJXosXg6cpYO9hDct/ntbpYBcf1x3pAae0p84c
 MWtgEPMgfE/uuT4IAeHgI5vWHzTO27/msCt31YjvZmM6gbACncx036CQN53o5fZ+jIoj+265iKW
 vxAQQbXh2SwtqHboWQzRwRDqKnvOyP+kHGm0zq46ppqFCza78nCqjuv9/zYT4yh6w8N/uHmQUpd
 8OIrqPjSATU+7rQd4AVtW2Z9CKEjxtlForM0iPh7prJxkrax4EuyCQSCisZVDpVyyipkAr6SDtM
 a+wfu2Y2QpLSDag0aLKyZ57CKxas11JC3HudOXgMLssZcgImXzFNHXdN7NO+Rp7XCgh2OwChsVu
 n4C20l/Y2LvwU4wd4TA==
X-Proofpoint-ORIG-GUID: qQrfHYybmHK_RiUwCcNmalzxQGHt7D1X
X-Proofpoint-GUID: qQrfHYybmHK_RiUwCcNmalzxQGHt7D1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310135
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/29/2026 6:28 PM, Brian Cain wrote:
> Add more tests from hexagon-arch-tests, enabled by QTimer device.
> 
> These exercise cache maintenance ops, l2vic, thread start/stop, tlb/mmu
> operations, and user-mode transitions.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/test_arch_tests.py | 32 +++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

