Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE4DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJAW-0005yw-LL; Fri, 10 Jul 2026 17:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJAU-0005il-C2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJAS-0006ao-Af
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3iYd1846459
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4G7jMeEgYCuX2L2ZpWyDzcYXDbcixPhaH10lFBU1ERs=; b=ocfC17EtVl57gadu
 E0uYmEQEFIBajzH6rduTEYm1cfyc7OtP5NDEJXunOd0oRW17pVMql+L6wDnOr3Kd
 9ZNSEX/0f6CLHPsfIajQFpSPef7p3IUYHqxK1bAtFKXxSck3ezd1VFBy8/e87Mba
 pRJEx6Ndos0aHYVcsOhIBa8z2SpsLjpjXzvC4JxbAoIMJdAl0B0jXHMxtL0/Fqjc
 kAiYstW80zE/5ieBFW8DwUPj7kVB+s25bZY55OTTMjmXaKL+uJD702xR1RfSN0be
 cA887hQiRGYQ32kyDYd9nc5KjPAFiNm+yvAbdpQlD8xji0D9+ivwCZodMo30fj+T
 RrVP2w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649rk6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c33f48ee4so14562431cf.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720425; x=1784325225; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4G7jMeEgYCuX2L2ZpWyDzcYXDbcixPhaH10lFBU1ERs=;
 b=bSsxsdevVwJouhv/15U+n8FlFUKhqdE8m66IZu/4Cg8S8QcE6t+ZcLMeZuA2UvCD1C
 /YgL+bmdysgKXyZpnsOtBZJZY6dej0C7yrs0GYa/+M+7BwT9MX2PnseDLjEA9879a7JG
 xGd+rMobRkqhWxXam2OQC24q93uEzxIkKa3pH8ZMCahu6i6NCfGJ0icSLcq/FV+HhB/w
 KJm9pt3yCc4vCQHJst97HjjO+HHDMGTjagViO7c7lh3aEL8BnEpLMH8mZWCKDkff6Rfr
 qvzySLvUKxgF3gOZOjc3Om4SNcDS5MF9T98SN9wKx2ua/QMEyd5hJj0eQs93vXHVRXef
 41QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720425; x=1784325225;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4G7jMeEgYCuX2L2ZpWyDzcYXDbcixPhaH10lFBU1ERs=;
 b=RRv68tjw3kqbAefqrDzdDC4ujC9ztW4OY+407aGNPChENpHnI73tQbx8t/KyVxbvn9
 E6KZ6zRDOIeKTCFB4gvofGT2Q3c2zvBIoavBmUodlT/85IbRCwiHvKtsgY3u4QwBuBgK
 8R7DyqQJIH/QW6cJJtba1hHhDl2NlU71CHOIS7yMzZ/wLDeAUZcZJoVA5J9dHwPqNEea
 IR/DlzvDazc9XMyjWXuJE6IlxvoGumpJxbWW9zUznbiZBr89JDNVlnQkfqihi+UZiKCB
 uK6Tgq1zfJWAjDfC09QXEdD0S1JylMy1RYcu/9MbkwGG87qmWEIXxRpBNhvaW0k/aaVZ
 ddUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpm0hfNO11UU5ieDztAw6/DNM4Jjt33sM82XeSkHIAhIEGGU2V1Kk8BVkQdfAFOu9RT0LSBjR95lTln@nongnu.org
X-Gm-Message-State: AOJu0YzxOW17ef0rfHrmg7XMU/1OkgpBVaHG90F3l4P8nnokG8O3Y7kp
 /JkQtTGPdI2gKaLboaP07N/69r4XxzLrhDu4icpeW7vrerVqw3vFa3js3DwFG2wlPqEz6cfMmjk
 sH47qodCUTXZWWmBvwEnePgfe+gZ440H0elGiSXDw3irnJnnQ7aAz6bQxHg==
X-Gm-Gg: AfdE7cl3KFqwGwoqvlgsPmdSscSALW9Qu3gkg9gdeGW+AdK5hXSmOqBdEiWWPx5zimu
 vlE4LZEV972KR18nUq5VeFdJmAkEoMA0tNTab4BnrKZ9GEJjlLjLwVLQ6tFbKAsvB48GaXpm8Tf
 /3PFJ7i5xLzyGhaMXkSxK698KILqCs9sctdsozI1VwqcgPYbgud73RM94UKY6NwwH1r1gQg+GVq
 UzKL9aTm21T+agVi4ySgrfwJGXnOAJqn7uiBxOPePXBuBI5nuxBXFsLlsnEGP6sDO3kylWnC3JT
 D/HSWRZ/C6OVLNmXOGJpUg2TT30/P6LffOpmtmD3/g50YXurn/iTW+l/P36gJm2ywrWOeKbQVJ5
 dSbvf/e7mwhUZaT89MXgv44sTXD8o9tRLCx3uh0OnVz1y8K8rmMboMiwvmlg7Vw==
X-Received: by 2002:ac8:5ad2:0:b0:51c:1967:5098 with SMTP id
 d75a77b69052e-51cbf147113mr7801531cf.38.1783720422927; 
 Fri, 10 Jul 2026 14:53:42 -0700 (PDT)
X-Received: by 2002:ac8:5ad2:0:b0:51c:1967:5098 with SMTP id
 d75a77b69052e-51cbf147113mr7801391cf.38.1783720422565; 
 Fri, 10 Jul 2026 14:53:42 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f25b23b7esm8759717f8f.18.2026.07.10.14.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 14:53:41 -0700 (PDT)
Message-ID: <1da100e0-57b5-4e18-91f5-b1855b181fc4@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 23:53:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/51] exec/breakpoint: Return the new bp from
 cpu_breakpoint_insert
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Z-GzAzbZTG0djgk3Fo7zyuPnMYDw41PF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX89/Zrqq41tqe
 OxQOkIE8Qji0CYOdMQ25kBbVHcUkGaTMYovqCSHQzO0ATJh3tSiBOgNnTIPr3nb8s71yxbx1dXS
 KrTNzaEPhI197hr5HQZLOFkek2mNCDcWDsTL7yEBHvfCsDmeA9rg4dF5MG7gxzaKPu0QXRTPR+G
 zjelGG/1cclrxsz1dMWR6Zj4l4VDpKJKGH0iK0ykYDdh+rKiPwLrr4uCHaxacVqhKWBxifoqeJ7
 oDwNHfY7ve2yOcui8lALjKgVCdJN7vrNtqg6ZN7q4DRSeofG1FDK/LXiMK4sqy1hu5wE0SWPUAw
 LjMhteEBt5f87vRSswBzDweEuDaR95s6cqlAoGASzbF/80EeQC2VCClapbUiD35hQsfMm1JR5Cx
 Lg6sTUfb4bdXdMWMq6xrWvpkZTGKlVLSOQpH3OmaObUxTRyWoIE5ykCAk93Z7ZsmSVlDzoXTt40
 j9afXUTYA8eIFJRdmSg==
X-Proofpoint-GUID: Z-GzAzbZTG0djgk3Fo7zyuPnMYDw41PF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfXzdrrF8h1REjs
 Fcwioz719meTQHYvVWdGChXjJjaLh1KR3ZxHRhtYtHZsxdsf9jn7iZbsxEK1zPqG7ErJJVf5mSC
 AKH+8t67hrwsaH5u+/rIQnIj7rfNJ+Q=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a5169e9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=b7RqGuJXx8hbMOLXtX8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100220
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 10/7/26 22:53, Richard Henderson wrote:
> The cpu_breakpoint_insert function cannot fail, so the error
> return value isn't actually used.  Instead of returning the
> new breakpoint by reference, return it directly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h           |  4 ++--
>   accel/tcg/tcg-accel-ops.c           |  7 ++-----
>   cpu-common.c                        | 11 +++--------
>   gdbstub/user.c                      |  8 ++------
>   linux-user/main.c                   |  2 +-
>   target/arm/tcg/debug.c              |  2 +-
>   target/i386/tcg/system/bpt_helper.c |  3 +--
>   target/ppc/cpu.c                    |  2 +-
>   target/riscv/debug.c                |  5 ++---
>   target/xtensa/dbg_helper.c          |  6 +++---
>   10 files changed, 18 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

