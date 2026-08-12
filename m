Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85440C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4gA-0006EB-1h; Wed, 12 Aug 2026 04:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu4g7-0006DD-Qr
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:51:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu4g6-0007qQ-3D
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:51:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C8YFHd2527085
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8WrxQzOnerTtxnB1Al6iha6KngpZXX41g9rrbBK/Tw4=; b=iUsGZ0Ui/23XEkiY
 IqGwWwgZ74W5yI5CXaAND1mhBwr9i+XMd+zhbPSi/ZHOaKsrWXK+jBqOUHwtqzw3
 Uru9RSQFYyQKfygREL+iBVlqFy/ci7Qy6jjUFkr5hmcgs9q/6506Iq/orXh0e+DX
 hpALlb10YVU6esa2zWkXvmrRmrXjx6iGh2WgZ6peCpQGVuStekkgo1A0ww0j2ZWv
 vkFpViytIaJdcwLRYNTPBJwVbGw1Ypr+Mm775Zdz9vCI62QZVaTvsQNzSHsm6+94
 iRw1rKVnEzGU38Fz2kciJXGBqdP3Z5sXhsxMVVSwMVIutr0fE6crIk17DSLuXqx1
 MyXD5A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mnd8861-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:51:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bff5c7035so13864631cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786524670; x=1787129470; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8WrxQzOnerTtxnB1Al6iha6KngpZXX41g9rrbBK/Tw4=;
 b=i+mhO8zOOyh7BTO9DUlMln62//KflUNkHR6k97Q7qx8BQqkWG1sKGsuMOSzZOdkMD/
 fmE92EI85KvwaH4JO/jy2m7pYExiiiH4O8+pfW4m8GdHMbQ/A93QvpqPkkQie2CC1RYD
 zuvSZSXIpreEKgSym1dwacxMQ2rtPnXVbmKxLNh4JxZ9z4u//HTG9mYqdbHMr70NO4fl
 7hqeIDd1RJSKTwu6P4Nb77t4JPCw4DDaO9UnqWaW+dbcZ3/mqXptysGwTOEJkWf+a8BR
 eJ9LBp28WVjD56Ek88MxL6rtm9LUQIErmqoEOUpDky776YWlj55/yui08ofeblQgYLRU
 FqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786524670; x=1787129470;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8WrxQzOnerTtxnB1Al6iha6KngpZXX41g9rrbBK/Tw4=;
 b=KlwVYr+qUGQb6c584oWfXZGtn9+7I7BKcIfQXZr2LzSEkIzIThqjno5v1W9n4zB/nw
 ry9VBtpQ0XPdfBI6ytDmKbO1s5qXu9IpZL+lYqPns9G+29Kc+tzmaqch0t6t5RsPh/iE
 YSXw/ijESFaIvhUvVDSkgoycj7T4o+9OkU3sDZxdGSFjDLAx7yA9Psr9gp684ocxm6+i
 ho8pW+TNKq2GQiYYZEaEbIykt8YP8JoJA751h1jPtuijXeUAjCKiU9mIX9xihnJ2YswS
 6u5E3tpp8RK7LvBxku7A4D4hqPTvVL5bdmX/c3I164pEtwJngp0uGlGBvUD6mfRV0awB
 ri6Q==
X-Gm-Message-State: AOJu0YzjEz0fWi0dpyoSk0yHGZu5v/XS7V9h+yBmPQewnAuUkJSgQ1Vc
 hX0lk7TG9bZ+U8jH0mdr/rk6eOX0jPXQNqGGBn+w/DdtGbLyVaX4JZNIUBkjmtmpcl3TF5PA5HI
 YnqTF59dmQsstT8qAv8zJK5mW//HqxCMjFBwzllSFXeQ0EWownj8pta4C0DtTLnTgjw==
X-Gm-Gg: AR+sD13V5mwtuGft3VqoKspjH9il6acnizD6ccxpYpHPxqmNJ4SYTfeXq4PQYQTcqnz
 KF9g6Hmg5iF48xbawolj/o2dhPqk1Ti9zLubFQzD6xT5MfA6IJ30rkB6wXVGboaCHt0ggTyi2kY
 xhZ6KyIzc6VRCdqE2nn+reF8tk2q87CAq6T1mIWbVhyABhq21/zyn644Ax1hgKr+gHWc6hrAAEb
 X1g71W75MTz4gqemL6B092rVsz6z7u2mBkkj8Tx+PaiER/XZyALaQx53ZU+IZbNNz2Io8JydJ2d
 DUWwFct31CsqN4PLH+12y7eIIo8BC2fnN7awn+XdJdvAxA3yh93zmsBmUPv+EA3NLADAMRRsNR4
 NVE8X46AMbLjmhiGD2pOzIa0jfH8sS4p+vcM=
X-Received: by 2002:a05:622a:8c8:b0:51c:1c73:5945 with SMTP id
 d75a77b69052e-52d647fa1ccmr26306731cf.24.1786524670560; 
 Wed, 12 Aug 2026 01:51:10 -0700 (PDT)
X-Received: by 2002:a05:622a:8c8:b0:51c:1c73:5945 with SMTP id
 d75a77b69052e-52d647fa1ccmr26306551cf.24.1786524670185; 
 Wed, 12 Aug 2026 01:51:10 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997b237ab6sm27764545e9.0.2026.08.12.01.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 01:51:07 -0700 (PDT)
Message-ID: <08483eb9-54c4-4f65-9983-cdd2167e90db@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 10:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] hw/nmi: Remove @cpu_index argument from
 nmi_inject()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260811154930.13915-1-philmd@oss.qualcomm.com>
 <20260811154930.13915-5-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811154930.13915-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2OSBTYWx0ZWRfX1bfsEjqwC69h
 xjXqG7sOi5RQ4OIalG8bncReiW+rdpJJaVHhTsJZcHAGK9JHUtml4HVT4ypdsDNbP8uJQ0uvMY8
 2PFWBFSq11f8M8ShowQgW9kdYKwGJ2k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2OSBTYWx0ZWRfXwNGhFMzJVax9
 xWcmB+ylIo0N2lte77kXFSTJzHFaHitweTjdO7DDGBtpKfle8OWUI5bP/cgBALM9kafBOUXZHMf
 Wq8C/CzCsUTxw0vzdp/ZnLTlk103q5ashIDn4My6dJ90nYSlylXC2JP/XlnyJSpI3hfNuZmW7dN
 TdgGn2eMntGVITX7aCwvzt/nQZ2a+x3CGxI+iW3CjDH7s/zcLMcR4H1tF7g9W/VB8tOAIScQ8Ke
 BhQ8kns9wuPXNejt+s1cnPSkIvSPgtGfxdb8pAyccN4zplOPSFHrRVHy03cQC00orVL8ZAVd8xH
 sDIfzjjo8N8stMi2gO/qwrDW86sbZwvgThVO2VmgKUZ43Q+Qxm5g/wFxduHuUMMP3xIuYBwXQSB
 JyfSF3kVTVK8tZS9VnkM18sLTpiUaENyQT2Xn3f6jEzdlrOH3eVEOJy2qYQKwEhOWINLMujyjPO
 9wj0cyvM5MkcLapkIkA==
X-Proofpoint-GUID: 4IqDCqEQwgVecyCSS-jbWCNs5q-C6hR2
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7c33ff cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=rTrqi_LvMq1sP66tgHsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 4IqDCqEQwgVecyCSS-jbWCNs5q-C6hR2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120069
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

On 11/8/26 17:49, Philippe Mathieu-DaudÃ© wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> nmi_monitor_handle() is not related to the monitor, rename
> it as nmi_inject().
> 
> Return a boolean value indicating success / failure as
> recommended by the Error API since commit e3fe3988d7
> ("error: Document Error API usage rules").
> 
> The 'cpu_index' argument is not used, remove it.
> This officially drops the current CPU for HMP command.
> 
> Document nmi_inject() as suggested by Peter Maydell in
> https://lore.kernel.org/qemu-devel/CAFEAcA-yALySmCJLbitCmYpiZKUXJNOavGJG9RYeo8fKqz7gcw@mail.gmail.com/.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/hw/core/nmi.h  | 25 ++++++++++++++++++++++++-
>   hw/core/nmi.c          |  9 ++++-----
>   hw/ipmi/ipmi.c         |  3 +--
>   hw/watchdog/watchdog.c |  2 +-
>   system/cpus.c          |  2 +-
>   hmp-commands.hx        |  2 +-
>   6 files changed, 32 insertions(+), 11 deletions(-)


> diff --git a/system/cpus.c b/system/cpus.c
> index 97e5a5edee2..04809698de4 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -926,6 +926,6 @@ exit:
>   
>   void qmp_inject_nmi(Error **errp)
>   {
> -    nmi_monitor_handle(monitor_get_cpu_index(monitor_cur()), errp);
> +    nmi_inject(errp);
>   }

Squashing:

-- >8 --diff --
git a/system/cpus.c b/system/cpus.c
index 3729f2cc10d..b9dd4478fda 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -25,3 +25,2 @@
  #include "qemu/osdep.h"
-#include "monitor/monitor.h"
  #include "qemu/coroutine-tls.h"

