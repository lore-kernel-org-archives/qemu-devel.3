Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AC3C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1sJs-0001GK-E2; Wed, 02 Sep 2026 17:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1sJq-0001GB-Nx
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:16:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1sJp-00027O-3f
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:16:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KH2s33288558
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 21:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u5DUXwfwtU9uBxpS+sxtPfGdyslPnA7QI3Wfs277Fe0=; b=XtCMOsg4JO+6xMbF
 U0SF7GReRvV0u/F2kPP0oKb+ykHmABgK90IVjxK4CAS1+1YWoe/XD5Jju1BoJ1a7
 PfWbMPFqRiT/ID9VoHu6Dt/61PDyK7GfO1/7n5W/o2Isw4ml4PykNRMly3ccvKyS
 TMH3uxsimJ/BO6dHqiAVJ87iJDAW61fiY67RI3IH2PULCG7R+rk8N9z4SXCXgtFl
 3ov/8YYhsY7DyEKwN3kLYDuldNBx4RSnF8O6LBlVmU8jzhf/Pe2r9TfUCKSyIJCm
 4Cf8bCu39xU7F5gH4/0lxK0jFS2foSfcnecQ6fIk6UtsQim/JOaFC5Zn0tq/6wXt
 +pWErQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gerdn92ht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:16:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939694871aaso147604285a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788383785; x=1788988585; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u5DUXwfwtU9uBxpS+sxtPfGdyslPnA7QI3Wfs277Fe0=;
 b=LXH9TWNSCufYKJWFXbe975iVXcablWGpfWVrPnAZ6FntfWvVrEDsaMyZ5IzSDqcuN6
 Zqsf7zaDnlwu/j/mb8d/S2N1jiytDPJHiwIehZEfXnmAGZVrAmWxYRle058URfxmVjSg
 IS00VNXaj2YjEW9J319gEAJ2+jGcscCZQjOdgv4zEGDebiVkfkI8X3SY9Sua0u81xwk/
 iacvJ9qtbOe5SLhD/Jnr6IzHmQ2UWcQRSWCZUQUSZUfDV1d6sDMbi7hKJqfMc7lzrS+J
 1W9iYR8bqiOfjsvbayx4DadEb1NVLJzuEFWuSFoNGphhGCFueL5PIneoZgmKixXbrRPh
 3sOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788383785; x=1788988585;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u5DUXwfwtU9uBxpS+sxtPfGdyslPnA7QI3Wfs277Fe0=;
 b=Wfxhbaw/mts04+qLsV1vJKXC3+gG5kfF7xuRgC2Nvmngs89SQGWE6RVNBJHoBbmvEt
 XHKcyQNwfHnNabrOQpX9FdWFWl/D3dT94EFhxfw/PNZ6AnlrD5BYExR+RxvaN18L2MOg
 2COM7eJEWENPYS0fDZIaQOG6/cfu/sreZH7KntPp04tsRZO8Vq/0bhNmhwUUvPjTVWym
 f0sFe9DjwGiNhJWoED86Ktb4VeN2mu4QHN6OHonWB3qgY+BohipNjoK87oOL1UDB1tLa
 4Mkfm96t4zs2cKVRIYoyMUily3ZXMwVG7xGx6xymoHWx07gVATIVzfloLs2D2H5zGF9M
 YAKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/oMInKPd4ZPqkQSsWmV70xNaF5RLS4hZBsC97PMEqmgsPJ3rwqqwiTZRSodlwmvWy4JEZpHNw/WB9@nongnu.org
X-Gm-Message-State: AFuF++kAopdHtZqy3q1OqhkuINHpD9xFlL0SpQ9mplc8X0OAPmaj+Dxs
 Yasv5KyfU3zvvImuNSaIiQkJlUvQlKfqme/d16eOwQmehDm1y3uLj1Ne/CmchU5mmU71vN+QDQ6
 1ATt4BFA7k44DGnuACGXHWgEYTH7tZg3KcaRbCgtLmyg659ChxgDBW9nXlg==
X-Gm-Gg: AYBFou1QbqojLStGqUf8KgEA1ZOcI+uWd98WLkJ5ilQ+139RqBg470j8m6RiYSwJW2B
 VfJSZVT9wsTwaT4yyz3G8SuWkQrNgkTZWlE7ir55KpXNyfUthcmlQPBoAlpggL18nDnMz9Fg7Aa
 NB0WV/xd/tcpFD9/I9lTdFw95JejvYz0BF+Zw8zvgGMep9MbIWloWbXR30jFG8hFNQse0QqOFqB
 9EZUMh9eqf3RFZeAKItVAhpiLCalPtBBJOSkABEro3k3NldXTqanpUmnXnclO7c71y1dMp+6po8
 Ox0qHTKOOoKeK9CRI0rZe6Yz28OKqkVfwHwMHUtf98AdQjWpABbeMsjCasSoHvZdDoE2LRPeSNi
 2o47MMbqBLQq4/nD96vZ6ABWjydHx1IW/Vg==
X-Received: by 2002:a05:620a:6546:b0:930:a635:a782 with SMTP id
 af79cd13be357-93960e21312mr659630085a.11.1788383785391; 
 Wed, 02 Sep 2026 14:16:25 -0700 (PDT)
X-Received: by 2002:a05:620a:6546:b0:930:a635:a782 with SMTP id
 af79cd13be357-93960e21312mr659610485a.11.1788383782733; 
 Wed, 02 Sep 2026 14:16:22 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eeacbbsm8344437f8f.30.2026.09.02.14.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 14:16:21 -0700 (PDT)
Message-ID: <f7f34a43-c1cc-4dd8-a859-9ab72e1b015f@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 23:16:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] target/hexagon: gate GPCYCLE guest register
 reads on SSR:CE
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
 <20260901173353.200474-7-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901173353.200474-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YcmNIQRf c=1 sm=1 tr=0 ts=6a98922a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=JhdHm6U_lmk7mXBORDQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE4OCBTYWx0ZWRfX5Vd3+9PUziUW
 0z+2hT3dXzEQdt7SbUS4LVjGuGqtDsRMYzOM702X3OrM+DyV7YgXdbd/My+0H6XUeCNAM9id5Dn
 +j2ARfP/Jol19BDIn5btsFTlT7R58SM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE4OCBTYWx0ZWRfX9sBQrWSn7L6t
 MzZiKo0/us230t/vfZfCkirjfueF4hbsciuYXK4yh5LArCsOxIjwg7y8wiTRCn4IBJHo/HjqMGs
 UfXNDT1ZIz2QR0KXT/sGoguoww9/XPTU6SzeJzK9Nux9/n43fY50t4VeYiaSSG/DxpVN5d6f6dr
 vaabD8WP/5BCkYyH8jmEdm9YtiLqESXI5wAKUI5cbR+CdSu2P6MIB0faC0k8rwR60oogPpyTLo/
 aex7rA/RQQ+rvtGgDeMkZoU7vTGcNuMltef02lv8ldQkmZA0ngBMfRGvS5auZJFYYjfcWPLZTwX
 9xvll3mUt5swagpWn+Ox5bPVnTZwUss+tJ1TSNXXd7TxOUFhdj1TMv7p2m/IF9rT/gcqDtIjUBz
 2nFoGh5Zr7a61bqb8NCbq8cQTsZjb4l0NYGsfOVL1+7fhLYgqweRcqcPoHtmRPrcZWv26fs1gTL
 o20xLUqeBwpq85gV9dw==
X-Proofpoint-GUID: 2YA1QHERBJvh9dcsR0I3x0O4oNPqHR_O
X-Proofpoint-ORIG-GUID: 2YA1QHERBJvh9dcsR0I3x0O4oNPqHR_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020188
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

Hi Brian,

On 1/9/26 19:33, Brian Cain wrote:
> GPCYCLELO/GPCYCLEHI read as zero unless the cycle counter is enabled
> (SSR:CE), matching the hardware.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.c       | 7 +++++--
>   target/hexagon/op_helper.c | 9 ++-------
>   2 files changed, 7 insertions(+), 9 deletions(-)


> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 23894ff3d28..2cea1927263 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1912,13 +1912,8 @@ uint64_t HELPER(greg_read_pair)(CPUHexagonState *env, uint32_t reg)
>           return (uint64_t)(env->greg[reg]) |
>                  (((uint64_t)(env->greg[reg + 1])) << 32);
>       }
> -    switch (reg) {
> -    case HEX_GREG_GPCYCLELO:
> -        return hexagon_get_sys_pcycle_count(env);
> -    default:
> -        return (uint64_t)hexagon_greg_read(env, reg) |
> -               ((uint64_t)(hexagon_greg_read(env, reg + 1)) << 32);
> -    }
> +    return (uint64_t)hexagon_greg_read(env, reg) |
> +           ((uint64_t)(hexagon_greg_read(env, reg + 1)) << 32);
>   }

Just curious, does greg_read_pair() work with impair %reg?

