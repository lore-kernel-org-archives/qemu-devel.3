Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139EDC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlj6u-0003lk-J5; Mon, 20 Jul 2026 04:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlj6q-0003lH-IW
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:12:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlj6n-0000EN-QZ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:12:20 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RXR21420266
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qXCW2u5Zf3sHXiRkFa4GiLmRJ0/lczR8t7soZbpiguo=; b=eaiFLco5WxQ5y0Wx
 BPqZ2uNCZJQPHmFX7YPu4xGRBbQeS6ew9ULuaobUQt1P+W2TzqsbIkb6NIj/ClYv
 G8nlZ9EsTuIeshR+CTmaadvB6jmontDn+RdXZo875Xm12qipvykMtYePYd8tJZnh
 R20CBSuK4wyjQIazXjOT0dBD0pmf2LWopPRHFYo6gKXyTbDihhNtFlIvnwAWlIPm
 SisTlzaDG8kqSIA29BY9a1kOCnQ7/7ZpYqK2JsXGQf+WpGu0JU2NiW5UZUZ9X1Rb
 HmRVhGorkINKWPASVIdOLwP1305m7l3ZcHOTxAU0B6Pr9A9KkriiJ9IyxEGKYz+4
 wXPAbA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2s7w2bk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:12:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1852a86fso138808501cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784535131; x=1785139931; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qXCW2u5Zf3sHXiRkFa4GiLmRJ0/lczR8t7soZbpiguo=;
 b=YERB1ifR4FrNmIpO+DGaRrXwwFLA+wi6rPt1ao2YMv7DmY/5e14WnhXSr7BbuEmoTK
 DpjYZlj6nZDccZ5N9qo4hj20BqtZITbKmS1O9e/AY5BOJIcTv/GMoL8TCDfIAIqDyidp
 8xKkzAUdFOvwvYK61xiB6D5dOph4fAtSAp6+wIef0pPzC5+cRizazaSowMTvvl8j6PRV
 ji0OgqSwRJkVfGol4LfgOB3f9MTVBFF9mdPGn7y1UaB7OuGdknvhwev1RMvO4qXi9b5z
 ++nhEju/03pOGDcFqcb44F9plDC4A0Xs5ApfMhAazDOIXpK+TZopEPKSQUkizb/erxoO
 flQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784535131; x=1785139931;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qXCW2u5Zf3sHXiRkFa4GiLmRJ0/lczR8t7soZbpiguo=;
 b=QFRtGhgWIpiK7egjeZd3gr0sTIVF0GzE/l2WCuWjKu+pF9VEiTYk9JrfywqvHgEdxp
 IuCh23QxSIPUGzW9nzhkrtJ7Jp6zUgSGUaZ16hjJOCUthyd8RMFdloljZEicwo9qbIgm
 lYHE2Wxs7qE7k9jWGBLcwEnZQgP+k86u6ttJiTbYJogyG+hfpzNUXxLZSmZXzKi8TVaC
 sHSbHaSL+iaYQ8TkxI6o/61IXGKr0nsuzdEU5+oEdPfZ4Vdck6UlFLS+9ffHPZTXpknI
 77PMKMrQ0pR2QU891/qGO4c5KF94bR77TZLTS3idUZ+/o4mJPeIpQAlZS9tkjh2fkGaj
 04Hg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKFurvNn9u7snnuW8aR5KqPjhEJD4/UkhMYrgGKYi6g+7jtJHkqfuU8yIqm7JFgVfYsfi9H32gko0e@nongnu.org
X-Gm-Message-State: AOJu0YwSejaR2p9aPC4r6pxOXAclJByQxS433IrCD1ylLL1EQ2MDqqKX
 cs9awEGs+VU3zzHUYNCj5tp0C+Mr8yHlETBBi2RnjsNO/ZsXvV9KUNlkTuEpEcWHOTc7NooVYp7
 aUKuTY05QZwA9kWA0yaWkxHcs7oktyzWZ4UCMMj9bSm6Btfzl9ZUYN0nlWg==
X-Gm-Gg: AfdE7ckmh2JIBet9OD6u9PjrrSObJ7KQ9SVA76IG6WbOUy8xZ4X1nc1MH9jbOkYvFwM
 rtNsZAhV+yA9qyRWPm5VPNTueHqa8Xeb+v2fzDCFEAbH/Dr9RH5kwlZ19DbR5vWY/Ish+rqdrTL
 PnAZ9wlnxnf6Kk7SLidVP5RMzbWv/tauKau52lAbVpY+PS5udbOIyXUMcU9hIN06cssVmmEm5Zv
 Dfrag+U5BHL62O3Wmb+0s5LQbsxndDBkvNV8h+D0HECvmtMtlKRXSEpOUMr3x1PPwZ9UBzSLt+E
 DFZ9Ox2LyRFPa6woNuY/k9NxFYqu2qkmFtB6x8Zw1Uap0RMMg/5NNokFi5Al6aK7HHH7FMd6RZd
 ajR7JFBD4wHRXZ36Ub+gDdUROooqDfjradBo/MI7lPQn1LzJ/E/o=
X-Received: by 2002:a05:622a:5d1:b0:51c:bfd:772b with SMTP id
 d75a77b69052e-5213ea80af2mr112215111cf.65.1784535131070; 
 Mon, 20 Jul 2026 01:12:11 -0700 (PDT)
X-Received: by 2002:a05:622a:5d1:b0:51c:bfd:772b with SMTP id
 d75a77b69052e-5213ea80af2mr112214981cf.65.1784535130563; 
 Mon, 20 Jul 2026 01:12:10 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f6980582csm20653559f8f.13.2026.07.20.01.12.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:12:09 -0700 (PDT)
Message-ID: <23c9a0e2-857e-4cea-81dd-cf53399f1490@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:12:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replay: fix use of uninitialized pointer on error
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260719113216.1177594-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260719113216.1177594-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfX+g7/+P48Qf5J
 2Y3KAjO6KwPBo3va9OsTjPlGUGWtEDLTsdqqfdAEWJ/ck3UcQ1jbrsT356LUJKu8kChrFpc/wUb
 L+58m0FZzvF5Yb/xRGaqcC0hfoNi8jtfxdVYh56DrrLWThe2CLN4ce5ar4VvYty6Xiogagg8AIk
 6eyf8Vxy6MkY4xx60WcHOb4kzbmC5fZMnXYDKnBODKKAqroOmzKoi/nFBHxe/o88H4ZPB9LRzgm
 QDr/2fvY789YRWpKdsmad4k/Rhm90BEUiU4nY1s+YUOt4A3O6tu6wjfYIZP0A93QtMfJTe2Uxl5
 EeKjO53kZM+uanu9+Lxhb/rMGAMzc/cOCfGrOiGDxMITPp2VrAiRRPeCAkPmPEm1jZSvjMPLBN8
 t3avvGp/ppHZpWO0Dw2VjJ2dIkhqtJjtDyLXTYQTFlZnWt+mAoddnYWez6gjPpLB7sfhxendsAu
 0NMPnomobG0jw4TzoPA==
X-Authority-Analysis: v=2.4 cv=eKsjSnp1 c=1 sm=1 tr=0 ts=6a5dd85c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=J5NEWGdLVZZC7EV8Bk4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: ZpAoZbTP17Q9JLXaex_HSkWOr3Ymdfpp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfX22DPADZvcPXe
 Fhnj+Q0HK/ZNZntmZa/8qf5Tb2XAGKmnhpmUyk0/L+nv2T0fGp149KGGvX/VZltUSn7hvzrbqFv
 IWaV64TFfWTkqcE9XvqxLtl/ZJSfWm4=
X-Proofpoint-GUID: ZpAoZbTP17Q9JLXaex_HSkWOr3Ymdfpp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200090
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

On 19/7/26 13:32, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When bdrv_snapshot_list() returns a negative error code, sn_tab is
> uninitialized. The loop does not execute (since i=0 < negative is
> false), but the code falls through to g_free(sn_tab) which frees
> an uninitialized pointer.
> 
> Fixes: f6baed3d1485 ("replay: implement replay-seek command")
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   replay/replay-debugging.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
> index 11053640021..7b904a14165 100644
> --- a/replay/replay-debugging.c
> +++ b/replay/replay-debugging.c
> @@ -139,9 +139,8 @@ static char *replay_find_nearest_snapshot(int64_t icount,
>                                             int64_t *snapshot_icount)
>   {
>       BlockDriverState *bs;
> -    QEMUSnapshotInfo *sn_tab;
> +    g_autofree QEMUSnapshotInfo *sn_tab = NULL;
>       QEMUSnapshotInfo *nearest = NULL;
> -    char *ret = NULL;
>       int rv;
>       int nb_sns, i;
>   
> @@ -149,15 +148,19 @@ static char *replay_find_nearest_snapshot(int64_t icount,
>   
>       bs = bdrv_all_find_vmstate_bs(NULL, false, NULL, NULL);
>       if (!bs) {
> -        goto fail;
> +        return NULL;
>       }
>   
>       nb_sns = bdrv_snapshot_list(bs, &sn_tab);
> +    if (nb_sns < 0) {
> +        return NULL;
> +    }
>   
>       for (i = 0; i < nb_sns; i++) {
>           rv = bdrv_all_has_snapshot(sn_tab[i].name, false, NULL, NULL);
> -        if (rv < 0)
> -            goto fail;
> +        if (rv < 0) {
> +            return NULL;
> +        }
>           if (rv == 1) {
>               if (sn_tab[i].icount != -1ULL
>                   && sn_tab[i].icount <= icount
> @@ -166,14 +169,12 @@ static char *replay_find_nearest_snapshot(int64_t icount,
>               }
>           }
>       }
> -    if (nearest) {
> -        ret = g_strdup(nearest->name);
> -        *snapshot_icount = nearest->icount;
> +    if (!nearest) {
> +        return NULL;
>       }
> -    g_free(sn_tab);
>   
> -fail:
> -    return ret;
> +    *snapshot_icount = nearest->icount;
> +    return g_strdup(nearest->name);
>   }
>   
>   static void replay_seek(int64_t icount, QEMUTimerCB callback, Error **errp)


