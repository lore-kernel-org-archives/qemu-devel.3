Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A063C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ndr-0007C9-8B; Wed, 02 Sep 2026 12:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1ndp-0007BX-VC
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:16:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1ndn-0003fN-Nm
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:16:49 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682FYw7R3071123
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 16:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5LDI2JScvormYirFbxmb7Mw8lZGcKuNc/CE0uQI5/o4=; b=K0RKmLZzMYoLtYAH
 geXZagYegzXTMHt2xiWn8Cl58oMfzHtfPA6j5rY03bYjHS7TRd1VyZjWYSIsYR1z
 MT3tZNCgSPgX7Bdt/bJxINqOsXeFrvTnzpVg5rkOb62vFbcG6jQuMZifUQ+2ZMIX
 L0l0KJ08RyL8+10yGv1wQ6j9FRPHsjbDoer2b0ydJyvsU8IeUe8B2JuN1j8goMyw
 gz/ipwOdVc8YzeK7+d1RZ7WpKp/9NLivO+z9hYSeOSiDV3AD9LHjCowOBCGgnC8Y
 MzARZsu6W8u0OAxt8Aqn3MMfPnmWRSQnio3AGWWR5Bl+u5mv82VwBjz1JmfnC+JW
 3iflow==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrngcfv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 16:16:45 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90e7db8d191so23120906d6.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788365805; x=1788970605; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5LDI2JScvormYirFbxmb7Mw8lZGcKuNc/CE0uQI5/o4=;
 b=cl83iouWihPvdSrz+OwfggrFGgxh3oeICm+AerxUGa3ULgDOVPdjGrPvCQ02Pja61z
 kSQ9xK9LG/EtLEkEmsEZA23biX+HYE44wWp3c8WS3i4/U4ZQeEgMZdXMhLS19NGJWXx6
 gj7TCNLRaBo3dRs5wYWcq6fyz51jr7orTXH90BoaCqxEKcII6oU3Ijio05FZ8dM5J70J
 snp82kgK5cJKSkoTFVOxnKCXkgAGo1Z3YKEC0hxVBeXC2APYmHTQHmlxhoEweTWda/Ur
 nwrLg4Z/BKJB+ZRnGxNReUlPxoM9rXgvEUzxFRPmMn//g7TvNxf+IRU5FQZxbansVxsb
 Y5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788365805; x=1788970605;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5LDI2JScvormYirFbxmb7Mw8lZGcKuNc/CE0uQI5/o4=;
 b=q9KIPRle+bsq5BrFwTqA7arcBEWhdPO7ZtOwWf1iRl3uObbD12BfXY5ZR1y4RB2Tmo
 ZydqfDPaKUPvwj+5HYCe+9Q2mOJhHcfMldJLGNI6MwByhoEY1y/d+5WIQ1Xw99J+Wb7u
 JPp0om7/yJpH+blCTNel4OQzRbGU9nbxuBqENblT/X2o+tZFds7MubYVRM1smRAXiDLQ
 1bOjMkC9cG9i/KxbqwyQYJsHvxHGZ74JM/cdg3WRZ4ZDAcN4TEPrlfmtwhZ+4gsh2FTx
 xKFHj/t+VyiSJYknA+3LnITpnFBk1F4OACCbH4IwuVK0DA0gKytprYIbMnadfmBBH1xB
 PtWw==
X-Gm-Message-State: AFuF++mPDTB2SNppOuKsYDbcYDnNtpToQSpL5n1G4elFivxMH50a+2rL
 Z8lB06YjjO8VWq3HqkctzpKtoXcC6ait3S/K1as740aEywdEWzErgZEk1YM5hRzOmI8FU2N3qUh
 EenUZWyZn86xyNyS7bYCgOpPB9UyVPBzJ5XNTzBhnMyHs8BqUvDj+JFErng==
X-Gm-Gg: AR+sD106ZK2zSfT04sX0BWQFAay5SOidAHscJNWbulsW8TVyHFULB4Ws4b+0+m76kpq
 y++3fX7vEiOvpmWmT7HqgMcm70OKLts3DyXfsrga5u9L4GItKesT9yjMzGcTMgCT7xVM/C+FFqu
 Olyx0b78aRWuqnhGzzOafJKMJwssCZaDcD7txgq56IgWPULVXwva0vpvoHyTQEILDFXkk2km/Vf
 n2aD1Dtu1f3j8LuiOoAskdBz/HHelbW/nPfNsZUv8h2l7j+VBYv/qzf/KAzDqZFbQcJDLwpuxrV
 pdhe29NUbKGagznMMTZBNdJL9Q59D8JRjzzSCg3jx7/MjlMoSLXfrGvL3liVinBdvIC86QqSFR9
 lW4uPyLUsw2kSFQUbMHKleiW5Ly9+s5gBJA==
X-Received: by 2002:a05:620a:122a:b0:939:1d86:94aa with SMTP id
 af79cd13be357-9396e56ac4dmr5791385a.39.1788365804802; 
 Wed, 02 Sep 2026 09:16:44 -0700 (PDT)
X-Received: by 2002:a05:620a:122a:b0:939:1d86:94aa with SMTP id
 af79cd13be357-9396e56ac4dmr5783285a.39.1788365804307; 
 Wed, 02 Sep 2026 09:16:44 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492cdbfbsm7369174f8f.33.2026.09.02.09.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 09:16:43 -0700 (PDT)
Message-ID: <717fcf10-2d29-4894-893e-259aff8fe02e@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 18:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cpuinfo-aarch64: Fix build with older glibc headers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>
References: <20260826163753.459661-1-tangtao1634@phytium.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826163753.459661-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yr1uRWxqANPCfe4JZrx9WoMYcCEtDlus
X-Proofpoint-ORIG-GUID: yr1uRWxqANPCfe4JZrx9WoMYcCEtDlus
X-Authority-Analysis: v=2.4 cv=YKuvDxGx c=1 sm=1 tr=0 ts=6a984bed cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=fgrLqfBXAAAA:8 a=A-5aKlvlEl7envUJ730A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX4J5bJ/L9tfT2
 rRs62m1rfOyz7I4pkRfcTmT2qlwmXmYq5Tva8Kz4ms878Ctsjs1CpD8fjHIwKv3B84mBKQe3Q1P
 OSepAe+1DxZjnFwkVLhXrnwl2mRZ3raj+yeJ6MpjtiW6id2ar4jZioEyHG4yhGetdiWud95q0/0
 FjG+vJ6ecLwW3R+YPWqvfVwxuPsO73FaLScf270ELCvAZ2vaz9QeQGCdZ1wW4bJa6cQ51Pg4peH
 KwjJhBy9NHaSWSwW+ZzfjNgF5/wpzW9VKL9ID2xSdQNeOoQHf/4ItSscLRbOlCTtQFRmcAiR5bQ
 Gi6s+MIe1DFJWslgWJqRgW580vpAiRDhkbK/ZVdyWDnZ2N9rOHVTT5rrUKNHTell8JhV6RaJusQ
 9KBDm8jdU/XtLHYVwjeI/aBr4FyB9WK1ZroD75IwNe6FA7cdl8GFxI19y0L9hvoQWVQrLL+Ngbz
 ePrlhp7rHrd/wvfy9jg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX2mhbmVy24Wmc
 5B8CF407jAjCZ32Iek6OtrITUPhQ9GbsGKkzY5HtiMBLldu+RhFYP0ABFUoIPWoYmYncagUNrbT
 n95CzYsBbGA14/g5pKWoUNiewHmSYoA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020143
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/8/26 18:37, Tao Tang wrote:
> Commit 761bfe07b2c9 ("util/cpuinfo-aarch64: Detect FEAT_CSSC")
> started using HWCAP2_CSSC unconditionally. This macro was added to
> glibc's AArch64 bits/hwcap.h during the glibc 2.38 development cycle,
> so AArch64 hosts with older headers fail to build.
> 
> Follow the existing HWCAP2_BTI handling and define HWCAP2_CSSC to
> zero when it is not provided by system headers. Such environments
> simply do not use FEAT_CSSC host optimizations.
> 
> This has been tested on an Ubuntu 22.04 aarch64 host with glibc 2.35.
> 
> Fixes: 761bfe07b2c9 ("util/cpuinfo-aarch64: Detect FEAT_CSSC")
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   util/cpuinfo-aarch64.c | 3 +++
>   1 file changed, 3 insertions(+)
Merged as 01e1455139196cc8d6bcde7d2f918348a90f7f26.

