Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E642C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1sOT-0001uc-I4; Wed, 02 Sep 2026 17:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1sOR-0001uQ-B9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:21:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1sOP-0004Ka-Oz
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:21:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KHaaW3045219
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 21:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o0t76ahDcMWdnrnmOw1/KxZkQ1yzoyX5m1ZbuMw+qkQ=; b=ZTdCo9k3KvnSx+Qe
 Op5YmcV/qE7YFDsutQ0Vum5E7XhJxDOy5j0YTy+KRqfuarvAAjWwVfXfjjB/VilK
 K5crXgd2MqMv/wOsBRyNGm9P523JHOCb8Fi/y2ZXYKVdaclGnXMI8pE54h5AqX8w
 bGo3Es57AX0Bg0Kx4PDN+KL6S8Xamn1acvqwJhuzjAF+WSc8Cjyr6eQdJasGhqcl
 ZDR/W/al0JoI7h0JZF+tZOVPRC9DbBCpyMhMzAT0kmuyYCKw7ONPcBQeKqcGLpqy
 O/bcEU+UJTnAtrcVY3Xc5cEHJy8+uwRCHYTjYyzOf9E6xg12Xb3cY1u/AyQ2rmq2
 TcNS+g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy346b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:21:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9308eafb465so424109885a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788384071; x=1788988871; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o0t76ahDcMWdnrnmOw1/KxZkQ1yzoyX5m1ZbuMw+qkQ=;
 b=EF6cFiCr9Or2vcCNIiVduyq2UMkAs0jl/x4kF/VfQnBQEjJcVotZ6AlHSIfJ1x/oD2
 0ymhI6+p1SYuANOb5n90ULvX6fH0BKmwnsEaAYbTgwf+W/6Z2JHXxV5VlKMFfGpSNTt9
 qZz18iRLYWtOV/iLQkXDA1nTuRJpfmpKCkr+D/dWuy4Tpkrq2PjqmrpX9BnzpnNSr845
 Xkc1G7cOj2VxdOJDkouKN0fOSjgr7NQrXQ8SS1OgWDjKgFd70/nLaWWiiXXe2znwaakJ
 Gdu6w9lT68CDNBZjGeMX5f3lNdFM7l9V0ziCajhWjt2Oyk1K/J2QmBSVM//+tsQ1Lv1m
 WsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788384071; x=1788988871;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o0t76ahDcMWdnrnmOw1/KxZkQ1yzoyX5m1ZbuMw+qkQ=;
 b=gADvBlOyAl6AK7uX0UpIYKzrwndsloTkHdltqIXpv8UzzDlsUDhE3S/9B6VclBY7HX
 5TmENrOoPNTYqgmseu1cNCk7tntmsdx06DIGEAD/l22TaivsTAj0yAfABCfKmeEODOm4
 jkKXkr3mb6hItXcaqBT4T2EhDYPi0nV4n6KRd7jHbesNUuv2DRl5xuvcePQm+4I3Wss8
 Z9HhllgiaR4g2htwiA97IYhxDwETET3v2z+FNM6TB3iWod5xjoH3rfi2V1S4kdAzG31W
 c0/J9qBr0UFqCv6Fdu7VHaut2vSC44bcLrlJxGw4iYcJBIiFHwArpcOrJhQjif2EHtz0
 jBzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhYoi4J4pGPOYr04dWVG+2BBScDWTIamw9zXCtpM6wczTfPnrmyd1gGUiXzTdBaYIUjgKCbRdJBkLy@nongnu.org
X-Gm-Message-State: AFuF++mwqrpTCP6zXiyZLaEcDu9CplAdFwdI5CJHYsdqGP+wqJmk3gDU
 h44wQXJBFATKU9zRa8z5CWrzS/kNUOgZevwLffg3E1j+gBR/1kU65SiUW8+Y+oiZzmQKFj2DWIk
 H0ZMf7yqBoSrbmh4cgIsh8g7SwwbPOW6l1NaAJV5C3fnmVsCe8DLc4fDHNqBhBQ37Aw==
X-Gm-Gg: AYBFou2pcPdYSJmwQRXmpjBSPrdGZg0Ss9JFBJW4sNwrLR65IJr7FD8WI4OPPZgJ9+T
 3Y9x6V1u19UBgtvV4Detevy2UX9lDr4ryvHMA4X9cWIIXwW+beZgjXLVm50KtPHzCxCfSWAemgN
 Bx5cw2eFELnzfYT+mLMNWQBrT7S2MIEpSazpX6bK8WNs9CFgBuGqLErZZQLL5IuF84yQ5sC9Flr
 foIqD6UNgOBkq8Yic6E+JOpVS5dlpxDcpnKzDAXdyqUvEP50xMBeau1zrqo4xnS2/aQP05UCu5j
 vI6KXoVW3l4XVDfsg2MSGUT3fXYoAqva7ygmOcSuJFCvCtVpm0PcB5mLLnmvgeaXy3NvVbJpHjw
 I36NzJgva29GfXERtza0A6dGkI33lt04wGg==
X-Received: by 2002:a05:620a:28c7:b0:932:ddff:1241 with SMTP id
 af79cd13be357-93960efc6d7mr964848585a.26.1788384071528; 
 Wed, 02 Sep 2026 14:21:11 -0700 (PDT)
X-Received: by 2002:a05:620a:28c7:b0:932:ddff:1241 with SMTP id
 af79cd13be357-93960efc6d7mr964840885a.26.1788384070796; 
 Wed, 02 Sep 2026 14:21:10 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e13db0sm9168669f8f.0.2026.09.02.14.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 14:21:10 -0700 (PDT)
Message-ID: <251e13c5-7b7f-4cd4-b060-2335c4b377ca@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 23:21:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] target/hexagon: read UTIMERLO/UTIMERHI from the
 global timer
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
 <20260901173353.200474-8-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901173353.200474-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a989348 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=3mrZ0iiCT4S30eFRzQoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: dMLd7Y1RCGjbLzhT7yDQK77n1eyN42gl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE4OCBTYWx0ZWRfX0hK0rvE+bAgS
 cfzsDvAufTZ/RUJ0bdBSrgg7RF3jyNbJCkF1vfgRdfgfWCVL1HoiYCHnLNtEgfzVtGcB1eXLdAQ
 RB3qa7Izqwo6YJw40cXiViP/GYkWHIM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE4OCBTYWx0ZWRfXwFpJPXEQ/QBZ
 9tQiK3lZiQGeHAUs8nCsWADBsRZTJji71r6KTHWSbqWMIHa3Of/pfSpGECM1mh0Zcc/KeCbkWPx
 dw4RN3V1PG2MIzPebHARjB4WmUEJ+DXMPfWjW+4aJxgr6/dA88DGRgnvKVBkkBfRZ+Hkaaa01G1
 yuwiXu9PHN3bqtOZRZxMz3H1p8JCEmCCdIr9RIXPlKqRM7FQNX/orX0PqFXejXRdill/Ikob9Xm
 vVGpqiQQyj9oC2rbuqaW0z5mN75eWTB5gBf2NZO2NeStoZVzx323RmPevoOtFogvpfVtIvNUZpG
 ipiLq5g0B/x0f5pKKmVOFFjEf5GmWJBeZmK3SZF09oS+6Vsz/0XCNodbh5DxQ0V3kSht89HUllO
 C+/esUtJd2yDUyTPiL7NmrUAQKyMUjl7WGJNOxxiLn0L7M/CPZJEjQgFtYVBSafY6x+KIFjtJkP
 WmqaY0kpztoUrhPtc5w==
X-Proofpoint-ORIG-GUID: dMLd7Y1RCGjbLzhT7yDQK77n1eyN42gl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020188
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

On 1/9/26 19:33, Brian Cain wrote:
> In system mode, route accesses to the qtimer-backed global
> TIMERLO/TIMERHI so guest reads see a live, monotonically increasing
> timer.
> 
> In user mode we derive it from QEMU_CLOCK_VIRTUAL.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/helper.h     |  4 ++++
>   target/hexagon/genptr.c     | 29 +++++++++++++++++++++++++++++
>   target/hexagon/op_helper.c  | 21 +++++++++++++++++++++
>   tests/tcg/hexagon/reg_mut.c | 11 ++++++++---
>   4 files changed, 62 insertions(+), 3 deletions(-)


> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 2cea1927263..df31ed2488a 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -37,6 +37,9 @@
>   #include "cpu_helper.h"
>   #include "tcg/tcg-gvec-desc.h"
>   #include "translate.h"
> +#ifdef CONFIG_USER_ONLY
> +#include "qemu/timer.h"
> +#endif
>   #ifndef CONFIG_USER_ONLY
>   #include "hw/hexagon/hexagon_globalreg.h"
>   #include "hex_mmu.h"
> @@ -46,6 +49,24 @@
>   #include "hexswi.h"
>   #endif
>   
> +#ifdef CONFIG_USER_ONLY
> +/*
> + * User mode has no qtimer device backing TIMERLO/TIMERHI, so derive the
> + * user timer directly from the virtual clock -- the same clock the qtimer
> + * counts -- at the qtimer's default 19.2MHz tick rate, masked to the
> + * qtimer's counter width.
> + */
> +#define HEX_UTIMER_FREQ_HZ  19200000ULL
> +#define HEX_UTIMER_CNT_MASK 0x00ffffffffffffffULL
> +
> +uint64_t HELPER(utimer)(void)
> +{
> +    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                    HEX_UTIMER_FREQ_HZ, NANOSECONDS_PER_SECOND) &
> +           HEX_UTIMER_CNT_MASK;
> +}
> +#endif

Long term it could be easier to maintain a new user-specific file,
adding it to hexagon_user_ss[] then target_user_arch (less #ifdefs).

