Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E984C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVuz-0002BG-NR; Thu, 27 Aug 2026 04:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVux-0002Az-Fl
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:57:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVuk-0002F7-UU
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:57:03 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R76ijY3226589
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y0OSza6y5c0MpeGKN2QX8FQh4EvN1ip+go3ZqrwrdOA=; b=eoWINmlDYkBZvGif
 /gEEnrW2XWbKUU79n5lWKLaO8FmdtnqOHrz68fogupWblx2gRvhUBbSVNEoObIDL
 u1cfnNC69JXpEixH2231NBfQiTeow1niMN2CEe/GJiI4dAXhmk+1TVJX9JsY72iN
 m4rrwo9ED98MtRGAbSmxekFdrOFkGO4F4IkGaBx9EcTGT7a+xe2zc0Vupu1ma0HS
 H3bew1fcukxzaDWZUHJYEivcSfk+9Of6gPL8UR3MoEBal/XQ8FMlvqRIlW3Qrper
 8wXShePxhSRoJR+Thz3aU2UEakW0gL4zXeRwskz1JdSg5JxznXb7tplO2UMToyOv
 H3PSqw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfreaj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:56:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8db414c7so24993711cf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787821008; x=1788425808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y0OSza6y5c0MpeGKN2QX8FQh4EvN1ip+go3ZqrwrdOA=;
 b=QbK6MMMCZCSMudPz9GrTR7xqF841mrurACFacNVW38d7gXm+OeHOb+J7J5CquvAAw3
 SgNu1giX6U9Pf2ReLxmSnMnP9xidUG4w6GmMNoap04PzMCiAgSXePMEDtACmO13fIP4v
 kSpCPsA/RRkL2cHwH1zZn/02WjOsRKfaJsUuxOKTjbERKPw/m456QQDC3qxgZ2Me7pYa
 1cym12S6dk2F4Hg9j6ySt84TuN4HyKznHYEX/2xkar40xBYjUuh0jH3BhL7nAUIkXbU6
 mVLXs1BwzwdBi8tsgLqwYrUjEs7drEgBh/+XKRoqD3mQ/ips4cDTTdSMA3EnCUDtyPgk
 6fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787821008; x=1788425808;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y0OSza6y5c0MpeGKN2QX8FQh4EvN1ip+go3ZqrwrdOA=;
 b=BgHN9OoQHUy/q83rVbcscvTDx14aq/KLjA+SD3NOtgzFtlbahXIFopaBTIlk544KcZ
 UzMqECO2k/M/lchDk2TeDvnAm+3dSZx0Hy5W2cF7MJCYSKeeyVxcJOCZF8GnOIwZAzyV
 N1MYufq51nmOieudwI2IFR1F2meUYpsJmjaIOks/SKR0TwhcwDgFjSJZSjV4KeGAsmGY
 aMjaUxgVXO8K33sThGosGW6q1pAQfdQLbPvH2XeGfjuD1hWtIMd/aWb6va9TYQPnZp0t
 wYLJPDwJNhjDuXNUxbslqZhzDo8JZZ8kZs/hybF2vD5IS64MVdf9vF/8U9XObO+lE3A7
 sPPg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro60IYH04nj9V8oeGiEXGfVYwU/ybJiRJntX0vsnihLNOgbMLzPOyPHJlf/mVO3XjkjXHBmUBWAOoxF@nongnu.org
X-Gm-Message-State: AFuF++lqcAWz9EZJpmvTyHkoD7DUPWiueTrJJGkVFVYJu82dgTXFxVb9
 FcjdmM69YZ+D1Y9QNEXrXQn7THjASbLJdrX3Mo0/PEG8Ay9MLpsYFMV7AbIchnCVmwgz0CYEaAP
 BfqXm8xtqSgw0Il6zdxlIZ40ih5MrhkTa3n2vDgv3J2FkI9KAI+1uZIvyqw==
X-Gm-Gg: AR+sD1054fIRBfxR/7mAvTIzrF6ySZNjh3zp020q1kW88xyonsTEwMZ+EEtiMKjLXfF
 gBKAH+qqCJFSsz645ZvWo5DMU/L9jjqy6nU9Pb81Cu6DQyL0hWzXEpGtROc1A864k0DpDCSQ7WE
 C/DsslwSwFY871ki3ktqafuZHlaa990aEB3lzW1wsApg7Fcu2nHCYScGMniY37JJDZJwuLeOLLs
 RHizTfMHMd5zGoTT3NXvJWmDtyL8p32B8pfnz5N/O1w5YTp97nUQfolH5814UjKkd/XFyAniht/
 LythzAgCfG9xi5yw9ViLz0QoF1lXaVISK16qUax2Mq1YbRMbjCU9MVLPOI4c43T0HAdRtid64N+
 5pJeWx3gKp/y3pZiV3rTsUMMaRSqR2mKiVdZlmkIz3jbTLi2l
X-Received: by 2002:a05:622a:356:b0:527:809c:f9cf with SMTP id
 d75a77b69052e-52e423df870mr114418881cf.21.1787821008461; 
 Thu, 27 Aug 2026 01:56:48 -0700 (PDT)
X-Received: by 2002:a05:622a:356:b0:527:809c:f9cf with SMTP id
 d75a77b69052e-52e423df870mr114418671cf.21.1787821008079; 
 Thu, 27 Aug 2026 01:56:48 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499e7170b72sm74773345e9.0.2026.08.27.01.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:56:47 -0700 (PDT)
Message-ID: <95b7d9b3-b61b-448c-9fc3-a3d91d438a1b@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:56:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: improve -mon deprecation warning
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260824122942.85863-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824122942.85863-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6m1viM_8T6wrDZspeiJRjUjDBEqMFAz2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MyBTYWx0ZWRfX/DZhlYjzMYex
 rTvouJE2+R7Tu8jreYU2T2+/OSI/5zjfUd2ND8+e/nBlWcA+id9ap6BsdjXcQ9Wk61CAcOpIZsS
 T0dwFrWHb0MI39KHCQvqsn/uv+UKEml+0uT23YubpD4k2YOIKezZHP41Nn4PNisxjIIWB5se5ps
 XufABd2MfFZl2lZlGFZnVDaV+Uyy8fK9XScx6KHPdSZQTq8rAASlsO1pArgzsV9hSUuqzFH8n+H
 q8FUhxz21UTJD+lGnLKTxNZapw1UXfJdb0bZHrEmUntr1SczOLlDurqrFJ5tfR9rgn6grBSKuko
 YsVWb41jSGK3tVfsdM+f+ZmHrlYyQMqUM6vY6x1dnpIwY211FuYahgqpyG6J505KKV1sjsLU8tv
 jWD1aifJM3FYkl9oLLngjhdB7Qgiy8Jh9DeouubC1WBVmn3wD+5QWwerwRu+2Mlzu/XcRyAsxc1
 dN2/C5hyG0G/tnlX0sQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MyBTYWx0ZWRfX4WVv9gXRmAbv
 aPWeey0TehRJXmE0zMFCd0W/JqyDZhPvv3iE/miKKraAY2LBYFRTy4xpq6CxKkG/UqbL2UcWvBi
 gm8zECcg8ygA6zu0wLceP2eZwcvE1no=
X-Proofpoint-GUID: 6m1viM_8T6wrDZspeiJRjUjDBEqMFAz2
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a8ffbd1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=Ycv5J0b5PTW63uash5wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270073
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

On 24/8/26 14:29, Daniel P. BerrangÃ© wrote:
> Expand the text a bit to make the new syntax more explicit and point
> users to the man page for further info.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   system/vl.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/system/vl.c b/system/vl.c
> index 061cbdf860..d5b5392569 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -3239,8 +3239,11 @@ void qemu_init(int argc, char **argv)
>                   default_monitor = 0;
>                   break;
>               case QEMU_OPTION_mon:
> -                warn_report_once("'-mon' is deprecated, use '-object' with "
> -                                 "'monitor-hmp' or 'monitor-qmp' types instead");
> +                warn_report_once("'-mon' is deprecated. Switch to either "
> +                                 "'-object monitor-hmp,id=ID,chardev=CHR-ID' "
> +                                 "or '-object monitor-qmp,id=qmpNN,chardev=CHR-ID' "
> +                                 "instead. See '-object' docs in 'qemu(1)' for further "
> +                                 "configuration guidance.");

Looking at commit 58b70f21ba6 ("docs: mark '-mon' as deprecated in
favour of -object") I'm not sure this is a good idea to document
'-object monitor-qmp' at all on CLI help. CLI users looking at
help output are likely users of '-mon' for HMP. My 2 cents.
>                   if (!qemu_opts_parse_noisily(qemu_find_opts("mon"), optarg,
>                                                true)) {
>                       exit(1);


