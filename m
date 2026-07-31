Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0DAC55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgQa-00043H-NF; Fri, 31 Jul 2026 02:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpgQZ-00042y-Pp
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:09:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpgQY-0004KY-AH
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:09:03 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V67EYP2960545
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r0dUGjRtAxmpudpXkEqKeU9YpkxTV6UPxGp7B/KYixs=; b=gCTFs3oHNCuDu6E/
 yB0dzhQkeSE+RQEdeESniiE88oWu73P0ZQw1XI7ZXoJGWy0bxCHfJqVxdnwfIi5X
 RkNEvZKZDbSeYhqKEDIFGu8j1f89DXMzwWT5LHZQXtJY8UngwzwsXJdT4lPMAhZj
 rduaQGs5hMoy4qkI3fpMSULFYvCSSPjC3iGLfJlRDJatpWQujnB/O4U5pKEYNGD0
 1Gqfb/pCt3VWLzW5ABwLAYrtcqJYdeEeERX1HAopGHkoS7Pn2Q9wWCI5LhkDkJTo
 +6M8z+ydIB3RiGxErh+voA2pL7REiwwRscRHHJta2jGiU4YxEUivAoOSzK/3Jnaf
 SWjn+A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp5kg069-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:09:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso3969121cf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785478140; x=1786082940; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r0dUGjRtAxmpudpXkEqKeU9YpkxTV6UPxGp7B/KYixs=;
 b=ivhZ0OVrK0Ox9IvjGTyprW3vAN4G2lto/yUPS64Wzy7DKZthtAGo3ZJMb4A2WNEra1
 hcvRyvKaKzapLDnqVavLI2yzYsgOau5O/1Hbi+wGtWS58ouT1L9uHp+ElEkk0a5MTswr
 0b3TJnHeeYNSHY9iApJ1wDHUP4tBxjG/cUMSncYuy7pVYtB15eb/CUG0s0XWoWbH76EO
 Mzcya9nFpJq/ru9v06IAi1qvoTDfd1hct1PmCaTtwcezBq4qW1zMAavTaFYK5PfOrxIC
 WcFLQHH0orVRcDfzG7yudPelLKbmS6OL7ObwzrVrclNQBRawn/NPx0PnGuCcfvNkazzG
 bbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785478140; x=1786082940;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r0dUGjRtAxmpudpXkEqKeU9YpkxTV6UPxGp7B/KYixs=;
 b=jUR7Wg3QBA0ttGCnx0LRAR7M4n85WWeZz2LaQi5xrcGvufWsy6HfWBx3D7PjWAT0qS
 GnQNsi/qNZtGG1OK+2N/NQtwsm0IqCHCD/1vNjnEpb1ZP56drte1/T/fZMmEfoaILYW8
 ypXIvSo6XkGlv033QiKfXWUivIEgtee6+l3jXqZCp/mJ9CHbr4Ug+bDZHGuwr4aSGGeR
 jHBaJqv6jTL7UWtneG3C8srSvpmSt2M9frOlT7lQeKR2/rxaLkPNGnXIOsGbUtGMSjOI
 RL5D7XB2R4ZrUJ4BVPVT3pfIioCSwnEC4xv6lqmnIvBIGQ/e6JhdiWIgC6lDpUTOkQ0b
 VjiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRhQmAKS1//n+obw9U9MgA7PZWq5Fz7zH7WDzBcDHNrXaTiK3W8HPRdehLJ8X3xIf18D0mGsrPfdAC@nongnu.org
X-Gm-Message-State: AOJu0YxVFa/YyoZ3T+BoO/00QGMuWICQZwxMap4XSaUYXD+1/0mnOG9S
 2T6eK13Wedj58CVxnoeWHOrCRLsgwNMZptcI1ny4D2qU/EhPLEZewhAMSuHoN3Bn4ns+HVDdJXm
 l7ZAGi4Gl6WKtnVQYTnc0biAoOm0p+VfyaLxnpyD5PgsvtRhS9hLKapzyQA==
X-Gm-Gg: AR+sD11ulVyiwjfAnYu4/NIOo25cyCwnRlv7FevrSKwgVNOE1GS6WrF6ZerOGcwgWWw
 mgsOsqvsRgGNzFuqpzXDPbs5J1O+qzc82J8hJ98y6kyzhXmX6Btk10Byht8Js0JhLmxJ9SEdtoy
 wpyaEC/1s39YonRakvuHnki0tA+U/Ip8UzHrl7FwMONXYJyY5o7JZ7+yvIpm5oJPKksJSZv428+
 e+b8xRfCRE19+JnjHtN6JgFt38zbHZkZ2lW3XDgn4Oaoi8GtXxPWPQuHz7u9h4r4hKfJTCqwQBy
 Rq5dG8sDtVhnIYvelAcgq2bae8xFA9uUxVYv6876HE6eo9rys7HA4J2ABvp5gEZUE9JJIfcGgPS
 6JxwfbjE2KCK2Em09w05NuddwqjQayqJ3lj0WyowR5WQ97DmrRig=
X-Received: by 2002:ac8:5892:0:b0:51b:fb5f:b263 with SMTP id
 d75a77b69052e-52b4c433f3dmr4077341cf.4.1785478139717; 
 Thu, 30 Jul 2026 23:08:59 -0700 (PDT)
X-Received: by 2002:ac8:5892:0:b0:51b:fb5f:b263 with SMTP id
 d75a77b69052e-52b4c433f3dmr4077071cf.4.1785478139264; 
 Thu, 30 Jul 2026 23:08:59 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456220esm809889f8f.18.2026.07.30.23.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 23:08:58 -0700 (PDT)
Message-ID: <a7330e7e-be2e-4c65-9e6d-a665bfa71373@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 08:08:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] target/arm: Use generic tcg_gen_revbit*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731000503.170446-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0MCBTYWx0ZWRfX38irM5cLSJOf
 q3iEu6LZLRUdxF+aWozjIfDlBMD+1EP3REAtEaOoVvUe/tEvz9HK+WuJMuMSNfg2iycb+3o/FX9
 yjVzZB9Q5ijr1vdgqqr/6ahDPU3nT+A=
X-Proofpoint-GUID: mUMBtG-KZUgOFU5FDCGY9_DCQGe1dshz
X-Proofpoint-ORIG-GUID: mUMBtG-KZUgOFU5FDCGY9_DCQGe1dshz
X-Authority-Analysis: v=2.4 cv=c/Obhx9l c=1 sm=1 tr=0 ts=6a6c3bfc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0MCBTYWx0ZWRfXyMFjO0gsL+rM
 IWJIOAKADI/6M9O2tXA6tAax1NdY37i6DaqVxzXu+4hr/dVAwazwrMa9vvXn7b4QQ/AK4NDQ11X
 GM7OUJFS/IDUNmi3cu6ys8pz5sjm18c8VTgrjcN7L/manGer6PPcqB5LV2DskqtP6Fj9FPm2W/4
 Q0hakQIegoLuJ/w+n2F0YDuZI+YbkofqiIu8t1JgUhnSGGlHBTvhiXMkM2lEJpz+Kjcod8liewE
 bSxR4ZmgFAD5HoRCLkAgjR2dApRlznS9k398dD5nb2Y5k79xDZ1IaWcA9sVmWXNEom0He1hNWjB
 heLPPGOdV5y+BXiflQ//s9p2/ZXwvVZLpqGk53Bbio1mZeBGZhUdohsJjQ60+Pa2af3oAUe8D5w
 57REIZifGHbUjQOYSSS6gGKJydcLmTcUDMUS9sjEETyr/iEsDUvHIqAGWNA9koP1gF0lrV2xhyA
 9QWK6a05DULyeIYDEWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310040
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

On 31/7/26 02:04, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/helper-a64-defs.h | 1 -
>   target/arm/tcg/helper-defs.h     | 1 -
>   target/arm/tcg/helper-a64.c      | 5 -----
>   target/arm/tcg/op_helper.c       | 5 -----
>   target/arm/tcg/translate-a64.c   | 4 ++--
>   target/arm/tcg/translate.c       | 2 +-
>   6 files changed, 3 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

