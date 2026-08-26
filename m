Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1528DC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHZA-0005wq-Pt; Wed, 26 Aug 2026 13:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHZ9-0005wT-G9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:37:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHZ7-0003sa-MK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:37:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGupXT424879
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HqV4Eg92GAPHZjbpznJQ3VIi5keVOFakf3pSuKPz4E0=; b=YGh4Hq0dBNIaQCw8
 /lEu+wm6wlKwcfnqcCkG9mC3YW1jHUJ+XFeKexcPYw/8DIrvpnJ9Z0C/jX642iZE
 0GrBhFsxM0hv0RR42bQo3ApnkRFqVF108MZt4N9da3VO4kz3DYfR89uUF4gYovcf
 5EdL3vxgKx0xrHBK8w+4tsCuYSCrohWoCj4i9jPLzaj3uRyqP42C9V8FdYF3PckP
 ugFDzI4o1qLrlFgJIko3NdfvzftCUSAc6o19RjB2nbryXRmkoTrohzsPLMBLkpl5
 /ozqdvaZZ1qBExIrxjzyvKDpayMMcKmjk4YZ3rez+YwuLzyInEBkoDPnVNIfdedC
 aRKCug==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9wmqswxp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:37:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a23afcbso18786451cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787765850; x=1788370650; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HqV4Eg92GAPHZjbpznJQ3VIi5keVOFakf3pSuKPz4E0=;
 b=MduyA/qD7HnseYEvNCrVJLcyD2M7rJN7tg85iHZjWcPsy/HTZ2nDulg2q3McR4jcFz
 WbQcPpHicHCsOJkFOKZsgTAIhsVttEplch49ZfqyWwqLO3x8Zm/sERxwG37Y/2Zs1Ff6
 TdeQ6PzrRWs1kIjEXdLJLOKRw4G2MWXS6fQdu40qgL4asoqOKDV2tsvr9SiGGzcoRYe6
 3nn2TS/5U24jElry491VjAkc979ayinCgoJeB6rBKyrg45ZOQLvkfwPAtChw9cyJt1Ku
 FK/MCJjewaXZAzqTjArkH7Q5O19S8aeHgsnryURC/CS2GN1a2HapzvUoGpi5M1pTarpX
 W2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787765850; x=1788370650;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HqV4Eg92GAPHZjbpznJQ3VIi5keVOFakf3pSuKPz4E0=;
 b=LPoarxe0pc+qKklk/NvHv54X6FNsiE08kLhFmf+fuimrAfaoMNQb5oyqhJzwZWu9iO
 qAWCIMrHwTOcn4UYBb4dGChnuq8jvUHXeIhIlmK0IdwR26MR7AuTr43XV0YJ0/gEzbPr
 S+5jf6oDxdupoSqnvOxUexI4ltGqGfvQheijpv6OPZRkLQ24dDa5v+PHYJiEFY2RY8Pl
 AyBAXhTACr63hkVsTLXhgTooQwcgbKTcwqZ3Kc+ofmao6Ys9PRJf5zck0kR6kZgPBRr9
 zc/Fq9E/p58OkD3VnvUgvWEMM5LyB/LMtV1bShRlaIebRxH/IfybQdPwgyB6okWCMUdw
 tZCg==
X-Gm-Message-State: AFuF++mAT82AMgxpYzx8jl9fSY2wFg8qtvrtvThL/mA90t7CDLO3zyHD
 hCyaqDIUbv0lIBhinJuKbQ4ysOlvVsvHYNX1biPuM+jQOLc51q+RZ2r/3jCYPCInpdWt2ppZVmL
 lZE96/m7a5lQAtwwzaJbRibZFfDXvFKMHPgJKfu1BAb8eo87/IRimIFCukA==
X-Gm-Gg: AR+sD12m55a90zXTMarGbHOtIW12USLHTjtLHEocSYVpGOTD6nqGVtRPNOxQu6XlD4H
 7YKYSBaDaw4/8XZciakg3YDhxgRwRkSmwFl4nYW2O4xfmMBPJrQ79xldOgnJg3BTLfFbOK8m0mq
 jrn5EWZ41RWGaH+aC9dwtYhTpfp4Q+FNkxqcXX7Fds+dJzzQntPgeEEJvlr30Ok6UjhBURt5d6E
 SXVbIYze2O4ssLjEsOarfvc3xDy5BUTxOQZ48GGoTrXOVXsHFbBeKvWWZzTTTMfCQF7x8YEdP03
 rAYo1n1KbmNU/mY0XERPkYWrNZ/f5SwpUyzlaGepaNL0jyILsYka0eLOVYDV0I0c//X5ZNMqErQ
 lsku3L8pL2OcdE+b8gApchha00UrFnLQRfAmx7MwwntKF
X-Received: by 2002:a05:622a:8c7:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-52e423c9a7amr90996431cf.37.1787765850090; 
 Wed, 26 Aug 2026 10:37:30 -0700 (PDT)
X-Received: by 2002:a05:622a:8c7:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-52e423c9a7amr90995531cf.37.1787765849539; 
 Wed, 26 Aug 2026 10:37:29 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88af72sm698271166b.36.2026.08.26.10.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:37:28 -0700 (PDT)
Message-ID: <767dc2e5-7361-4685-a33b-3d7b52d7ffb1@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:37:26 +0200
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0NyBTYWx0ZWRfX0EGwN6kfp5vq
 nOaL3xPdGZ6s6vdO9+jRBUJPYC/MRkvjIJ1l4FBJk95KJGr4HpAQW23S5M9FVEPOdwxuG/q/l/E
 Xygs/nEuBb69joDhxhugz2I6GqC7WMw=
X-Proofpoint-ORIG-GUID: KpY_0hz5r3PMSrRbBBc6H1GuWkp5MiN4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0NyBTYWx0ZWRfX1dm9VMDwRmzQ
 +3Cm3V3iW5o0hv6P2LUX+04k/HefJMkNI/qGGwwDZjFlxSQ5Tc52NF44Rej+nes0YE/ymcsr2NK
 h2/gV+LEBmMFYvWabwLo7EndObx0bVje8zqVV0+Hxn1lquYpE4Q1HqE0nvhdBi9jk/i0n1m3LfX
 ujR1cWW02eAJGhhDyKi4osm+gUUc5+NKKKrXV4fZKeoknpIYE5TKobDJSN2oX8MJl756qaTd6+5
 BW0jS6hTlCD9IQvycg7HiloLQqaCFTPChUM2GMqs2kYIWVQVeFtwI9K/MAVwJiXuo9pVSO7jy/e
 in5G5md2KBw6wlm6RAbajvA8UOq1zFRfKAXSyMsDVgJdkUy5bpdvYRoChEq+GT8ZgupKcR/zWSA
 kbNJfUxX+AzpST2/jKTuGijzjvr7vUuxqNAdyhwYSlxdJVKChgqW78nYr+qrzqy2fi4QKZbiCfP
 LKFWEnuhllJzaLgL2RA==
X-Authority-Analysis: v=2.4 cv=T9S8ifKQ c=1 sm=1 tr=0 ts=6a8f245b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=fgrLqfBXAAAA:8 a=EUspDBNiAAAA:8 a=A-5aKlvlEl7envUJ730A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-GUID: KpY_0hz5r3PMSrRbBBc6H1GuWkp5MiN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260147
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

