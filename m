Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530C606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EYIWeALW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dsqBJd9n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJLGH-0005oo-RL; Tue, 20 Oct 2026 21:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJLGF-0005ie-Uv
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:36:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJLGE-0003Gc-6H
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:36:59 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKteTx3856188
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WKlJOIA9hYNOP7ylM5rw2WVhhGMxHVFUPwOUehaVkMQ=; b=EYIWeALW5JvwMtlt
 ZNUShHdUSPXE1EyLm4hJOVwHDjJ1vBrkPUx5uqZfjWVpe7f7MLJX60afYdFLyhRe
 6Twogiq9vzEXjgNSByoYNM0+nhW1Ix59d4g8unyijEloc/ZcYEdkwV49lNo4gjzW
 knO7NsB2oER6cqU74Ezrqa7zO1KYlmBCBvRDVYRM6zdOYpk5/bsQT6CngecJXlaO
 nL/jaNKWAHQJIKp/OLOVzNhCIpHoeezAddHr1ZvBonjpvoC5skOBSx6GD2EO3M2P
 FoMpDZIi7ryUHZtkdDH2TDL0cB9wAEY92OYTo7gyoJm+gDZsni+cLS+NxQsElKVS
 erefFg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabhcjk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:36:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so1094855a91.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 18:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792546616; x=1793151416; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WKlJOIA9hYNOP7ylM5rw2WVhhGMxHVFUPwOUehaVkMQ=;
 b=dsqBJd9nCzzmLBJTHCWnEG/UbIWzsBgGzpKUfSab4wa3AZ9Y91hKdLrhSXs0ucGlHc
 DqiznTo9Z9n3qDFaCxOgWXucxJtkh3b06nZXVlTxFKi6XBmb4ELxVClAVwhw0l2IH9Vg
 2Zze+lj63A5HxlIIzOwDUKfpOZA7f56MvY1leSfQwRCiiO7RLD3nQ8C81ZABS/wXs3+L
 xMJDHhbBHTZAzE0TT8mxtvy7A3Pkv1FkKklYM0beSYnvj1z+SVk4FHavz/nSq6EYrijN
 8i8VfGnrobfpTvIIeVhYXvQjLepuwzHN0Gifu0exwodlFtn3q90AVsJus879ljt4be+s
 ZLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792546616; x=1793151416;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WKlJOIA9hYNOP7ylM5rw2WVhhGMxHVFUPwOUehaVkMQ=;
 b=fMXnmc06VZ6ORIn86Nn60mOP8oqFJ1zNJ8Zo0HSDXoE4z4DG/Sp/hHv5fIO/PZ86hP
 sugOJaKZ2r2WcMfJb+tAEdBZcTvP9T6VS2M6pJMKkeFXIlx8E5cxkmIWbwhmy8Btay+U
 +J86Y1xwo64pwsCbpKp+Cx8Hp7H/rCHLDONU3COlTsyJhIcyF+CTdln0uBtDsHCh+nx0
 /DJVTzXvDFr/5Olzj9TrwOlrw/7J9/wtdko0imv7s14jScewDV9kuaXGPtIXIfSkuNsJ
 1c/opm2JvRmsP7cgJrm5lmGZO8q+WSqVJNLAK4U9E1KaESm4uvgmuU07ijJmqAWDE1kg
 HrpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1AoOju2E/AkRAEp00fD1mxBtYUgvr5BfoXNB5D0QzsxTx9UzpggIff+h16HffJJjqNHdpqtybJQdX@nongnu.org
X-Gm-Message-State: AFq9FYJdviQgRQ0wMJm6LR6664eezfBWJx4TCr6MDSeNlvRjVl39DqT1
 yB35jBCMrCYSoLRETKxzNkAWhNEA6bT+wGEAffFmzeDeieWagohogdJYwOAd9A0tDUer96dGSUQ
 aokYsFnJ43ssuAsy+UH5Hx1gvk5jYJoOsVYcOX77/m2CWyj4KMidyMb4sfg==
X-Gm-Gg: AYBFou0kMmUfp+zloSm2U/EJgoh9Ul2dQExQ9TGWRrygBNgMP+Q3Mc/YRXxCvyoQF2l
 dx5BrzpBrFaXbu9tHGtnoQrtfbHQqmuVK2KO8fPLPt3VNhF9DvH2e/OH35a7e75V4GqNYbefOz5
 hAzADIMZ3uHzDJWQtu8u8xKdgvt2VOHiIysIqYs18CtDZAvkV8NarvOaNFmNXQIIlxYPiAc7cMQ
 mSrMYK4DjEgjeCQDroZ31lx2TTRnm2Oow/DmbtZN13RM4yHYnaitFiKEc58JS9nFf8eonp5j9Xd
 pkHDggWDpHCZAyzrpzvOa+eFUKr0TICO11EAde2g/2H0T0vB4tbG+rsTDKn7fB7mvx841pXF5qN
 PoKwvpgE3YKJeYEiXdW851alxaEE6y4iaR/8GThiwcTuG/X5NgCYr5vF4
X-Received: by 2002:a17:90b:380f:b0:3a6:e9bf:f244 with SMTP id
 98e67ed59e1d1-3ad86da476amr324028a91.1.1792546616158; 
 Tue, 20 Oct 2026 18:36:56 -0700 (PDT)
X-Received: by 2002:a17:90b:380f:b0:3a6:e9bf:f244 with SMTP id
 98e67ed59e1d1-3ad86da476amr323983a91.1.1792546614796; 
 Tue, 20 Oct 2026 18:36:54 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad813dfa5fsm1601844a91.14.2026.10.20.18.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 18:36:54 -0700 (PDT)
Message-ID: <5866657c-fb2a-4802-9b70-e22983f78ba8@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 18:36:53 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] tests/functional/hexagon: boot DSP firmware
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Alessandro Di Federico <ale@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
 <20261021004145.1693260-16-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261021004145.1693260-16-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfXweOAWVv0ZmdA
 m3XGIO9FaEM6/a+IfmLhBvf0FI1B+cIsBIIm5bilDHcsJlnWk1nnRJbmu2sbAvyRfiBan+mMjFf
 9tYe9Xw3O8xFl6sO1EtvKhIkcSOa7GE=
X-Proofpoint-ORIG-GUID: ZLDUldyc17E5yaGQN0po0jxdZK3ZchJk
X-Proofpoint-GUID: ZLDUldyc17E5yaGQN0po0jxdZK3ZchJk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfX6QbHC2piYcQy
 5CkgckkZ1piabje42NBXcH/+WzBOvgwVf1eoPnIEZCQ/sivt9RF9vqZsmVFEHqbBnlFfqksLaRP
 Qj8ihZ979H0FOgxmBg2vvNoHoQURF+6BNxidB8YHLz/ENjjZrdOXu/lcsI7nQDPMKQlWMb9bq23
 10YCGeYCd3M8VGkAKx4vIQbVtbdFCTH/GE5mnsqiMd9Aht1xC3/373AesaKip4U4r/w7DOVdVqk
 MHZ7VLVVVx9Lna9Xzb970txux6zaSVYHXMvAKo2GtLY1wpfD3RqYI99Zw72IGAOskd0C/PrE/UG
 ldZUGmDEfTSz9RcV7HlYX3r5+rimE87+dHSp+D7sYGzqtTmOHNrIGeTKySisrVA1fiUmLf+uT9m
 K88k689Vb2fk2S2bbY9RSP8HqszCSj0XcgiURtsFiFKQ+ROTOFlVsj7ygKG9FITkjfqjY1g5r53
 yrFvDgDMo7hNE2wPwCw==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad81738 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=8C1UA3Q6ubXIjXfnr48A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210006
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 5:41 PM, Brian Cain wrote:
> Download the firmware and run it on the corresponding DSP machine.
> 
> The images are third-party binaries, so the tests run only when untrusted
> code is allowed.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   tests/functional/hexagon/meson.build          |  2 +
>   .../hexagon/test_qcom_dsp_firmware.py         | 92 +++++++++++++++++++
>   2 files changed, 94 insertions(+)
>   create mode 100755 tests/functional/hexagon/test_qcom_dsp_firmware.py
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

