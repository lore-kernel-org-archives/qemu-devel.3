Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF16EC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGMX-0002qS-O8; Wed, 12 Aug 2026 17:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGMB-0002Fc-4L
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGM9-0007tr-8H
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2ZGB642457
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mKmcJs7GK0Zw0n/Q1LidRqIr6h6PlQEJSZg+NmiQHxw=; b=abSwK1nKJnWfwcRd
 Dqvg2dGYFbCz2rIkIad6MAtEdqOm7d4Sib97bIeWzp85OfELDj9WC2WZCSCMC5pH
 6GWjJCSGrBhK9dImeHAZKBZdyMkEEfjxFv7wl4vu55nT5tjjY9M4LG16N5h5wx1v
 NfchhH3n41jLuktNzHj9E/Nn1qE3x/ZlR1RqOgSrUYM4xM9MSw91aZNrcgIfF70V
 KsnhEKi6EdqMTewvnGyynuhosrVkgXAo/61YMhJegwU5GJd9jzryt8KtgW3dNiAE
 l6z9S1jhndEJXW5tEIvx8nr2YX/1ilm7PD3Yhp974m1D6GwZWN4E+EfEGL6vejxh
 9jo+Cw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0wt8rrp1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso14827171cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569563; x=1787174363; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mKmcJs7GK0Zw0n/Q1LidRqIr6h6PlQEJSZg+NmiQHxw=;
 b=RNoLBHj8m5ouq0tMZZcpAYOySCknFr0tcorAcosqAEmPksqEJHSehw+Hv0S6MSu+xl
 QkW2jx9Y7s+q2HcH7dTGmCY2DY3ozTMdyNQefRrNzCHtBkcv8LihiwrRII4UwuXN0W/O
 UiQ9Q7xrTY60q7sKGoWoi8ejtWR5haaAfIxYwkZqjapQgiI21DpnH8Q9BXad6SjZ4zBz
 wjF0uf8tDyQAD5DJs5g9g7Z1pjpe7nRmPjl40BPSg+U825SSEeZjXna1R4CXO8ZGH58C
 dq0iwggKdPPx67MzTzkPu6S/fR4Y3XPOf93nTR5Vc78PeHApS6VwkTaFy+8LIVvOd6Vk
 QkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569563; x=1787174363;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mKmcJs7GK0Zw0n/Q1LidRqIr6h6PlQEJSZg+NmiQHxw=;
 b=k9KX5I46BP03MLcvng1dV1VzwM8Ca6TdKlKFXefH3NNK2c9FLFc4vbkdIQuB93qzvc
 qgmNFAAMKyANw9aTzV6Ls+pYFkqyjlr5GpOWD7lqgPJf2N/cJP5yYkoOhpZYX2lUFouR
 WcyNMc/bpKQ1yi41oVugYyrLe8msSuWFQcvZtBJJRxmN4ZY+2d09T8VuNCwXS8wwXOO8
 K2Po7EnxUsZKJI+9WwtaR5WeXWbb9TBCtQo0jbAczdOrz0NGl7D/MSzt4Y8XJQkDucV1
 +dgHVlMLrD6jW7OV6HmBbHBvvAdv+T1c9CKq+y8oxQ7StzqM+IY8urURwPKYunSHW96+
 7V3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMbdStDcyJS/ydFTL1tyegQfpLlq/BkKjVYMraLbctW5P6HP7EdtdioUtpnEZIiGdHhlOaplJ+FRaq@nongnu.org
X-Gm-Message-State: AOJu0YyZqWQWk3uPYdJrh1AH3T7sLN3E8jVDdySGXHKMBtoGxIdoJk67
 3wJItPL8yIe5xsrqVVcYMf9Yuu+QS+stdPoOrMLh4L1o90uH/9qDiAiWG1NRpysJbtl0/8tbBh2
 xbGOWywwSOVcHk9WofVQ18UF8+VeJSVGVknQRedTv9JbgAY+bZCoMSl3PZTFZYY44qQ==
X-Gm-Gg: AR+sD137Tkijo0oGuFyMYPgk4K2TweGiI8UJcGvnB1UeBmwZc6BIRmcniQURrkQTWsi
 4Q7H//1FLiK79mvmk0VJPL0sqCOlLiBlNXEiSEm4+i+zWlH5y3a/gBSDPMtgBlgMTLl5fwdUhHo
 iQKAFSbLK9R8OveDj4GhiGS4GOhN3cZ+gCsIzf8zhijZ61pOn3mRe77gpXnQFOEMk5WoZaLP1cp
 DVZUEff0iIQSAfKdFCMKuTiuGVq1vEgv05X/t34wj+qnUc2oXfHsdIUv0VPcnXgLqKIqIxcv7BS
 izdAVc7wvULOWMlWW3cn7JMD1NOQtDcKIw2S02aW7JDWE8Et5jEcWQZ+f93mJo1mKyo4ve0A2yb
 thGTfD6NFcQcDmbuXj+v/+fIg3R7r70ZDRw4=
X-Received: by 2002:ac8:5f06:0:b0:51c:1c2c:a8bf with SMTP id
 d75a77b69052e-52d73e400ccmr8873271cf.43.1786569562620; 
 Wed, 12 Aug 2026 14:19:22 -0700 (PDT)
X-Received: by 2002:ac8:5f06:0:b0:51c:1c2c:a8bf with SMTP id
 d75a77b69052e-52d73e400ccmr8872931cf.43.1786569562108; 
 Wed, 12 Aug 2026 14:19:22 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5af441sm718306f8f.22.2026.08.12.14.19.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 14:19:21 -0700 (PDT)
Message-ID: <2ca53033-9bd0-45d7-bfcd-6b17996f8b62@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 23:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] target/arm: Move aa32_max_features to tcg/cpu32.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260812204435.295067-1-richard.henderson@linaro.org>
 <20260812204435.295067-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812204435.295067-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLqvDxGx c=1 sm=1 tr=0 ts=6a7ce35b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX2g184CjKHQiD
 /auyKcwuXHVITV9RNPc+N7AjxyI0BLs0BsCJ2U+PX5J5tI4fy9g9zfBd2XWeu308swcwYSZsxn4
 /xYopcUlq8JCoie51gaNlH7rjK120Q9Uf0cbM7ljdUpFElz+USMijQ0uGtSqHTbCWZqeBAp9uCt
 R9jtC4Z/+urDIeLUPKYpoLo4R9JJfhzxlIve68q4OiDx9TJGM9I/phrUzbI+Wm8iwSeUCzaIrb8
 fIrfH82i2uf9aX0BAoeuI8+iNm/HyMfqGH6ICrCkzLO6y4FN1vp/Cf5zzeonw/18uvgjAeo3DIL
 Ta2j+QxWcJ0quSh1ljAPP83bn4CN/gE6NNkmHtjvRNc8dowgD2WNQ5/Dq6z3VLvtr9l8IdvQ3xI
 oBZ2/g0bEDWWveM34oedkefjZ/889fETxNk9FFahq6Zilu9p1mg8UDoPdaAPM2bjg9rpFQ+97fY
 wbqqXR2E0Sd7Ti1CbuA==
X-Proofpoint-ORIG-GUID: XrGh8jdXgR1i6CH9rmF2ooaytdY7sAEX
X-Proofpoint-GUID: XrGh8jdXgR1i6CH9rmF2ooaytdY7sAEX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX0MB3HSY12PMB
 7Z6us3kO94u8nirpPXkpQ/odcgZrLPySFBFPM9lu5E+btx4ouTD2jh5iLJ3h0LUiXKv3Ex4+vB+
 82Sbkl3mCMp5hcjxLutYcEvjrYSEiAY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120171
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

On 12/8/26 22:44, Richard Henderson wrote:
> The function is unused without TCG, so move.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu-max.c   | 96 ------------------------------------------
>   target/arm/tcg/cpu32.c | 96 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 96 insertions(+), 96 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

