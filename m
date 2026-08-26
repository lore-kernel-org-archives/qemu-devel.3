Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCC3C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHh9-0000ts-Hx; Wed, 26 Aug 2026 13:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHh7-0000kG-Hl
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:45:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHh3-0005d8-O1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:45:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGusq31008165
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4YJPgMr1NHZUiWQ319CFOmWqzQ85FhtagjDhlxId37Y=; b=cFoZWGKvCniBWDsH
 e03l1KdERaJb3arBS19M+s7jsdbI1Mp1+H7ufNArXSEftOvJJVCbewhOtnJcUnMn
 AYb9ot38bILXnp+0Bfd8KhUD15PVRd16rOrukmg1nnEOrHs2Ly7Lk8GxFSd6yGjB
 5w3zRL4dss9QN3Tn9jwiPEZk4lKZWRYmD1fHSD/ix/ZcBOb7F8V+aXQFqlr+hXQm
 VkHS5mg+Fp9/S2PJaP8qymrG63l7Hyrn13zMxF3IWr5A8FnQ1it1sGCBOy2sXL+S
 cH9uO+MJzBTXZ9XUXoq/0qNniWeIAdNL2OlZodiKvg7AghbZkDQGX91ruZvswQaV
 ZVPOmA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smxb1d2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:45:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52827090cc5so1675861cf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787766343; x=1788371143; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4YJPgMr1NHZUiWQ319CFOmWqzQ85FhtagjDhlxId37Y=;
 b=E0WWlBeAHeEbRDazw7fPUqAfFNphTLItSzv/W0WEaZmTQWy1EzYXMK6BYW8LCHXNzp
 YzOAg4Jvr5YI5AQWkk25djE1jePB3O1Hs0vKIkA+hi29YNhG56hGz4S3MkqjWuEcNWEM
 IqdDFrPK/3SKbweDqgn8aEz7EXMH6QqaL6hSSI5UGYEvF9kL9h/S/XtqpFQE9fyuIn2U
 UxnfL36zxsLjCNMS+xrVjQJQE/5uvtDDauBRJxQaQNNO+vo4OqL+mVtynyH332Pth9El
 NU7mbpGnhcAAiQsqimxIjSl2fhNID5rWLTsQAKw7DNy3qNwiCJRMJv76rjDe2NBziLv4
 no+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766343; x=1788371143;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4YJPgMr1NHZUiWQ319CFOmWqzQ85FhtagjDhlxId37Y=;
 b=nmLHirf9Iw6Ct8Mg5m5ufhBNLYpVWvVP5OyZ17aBNRDr1i4wpmN6BXRfwSBUJOTbCg
 hgVl60D0WEWDRshPXyHoO8NHhNreQLoWXRp1w7Nrv8EgFAEFsIYr2Gu7OlQ68vYoG+GO
 Id6hQy8J3UUD4BfNfoX+rM5UfUjAlCa5q4LIsalfTkgVhKkYCyLdbrzNWFTqtg45wRjT
 xkE5/s3RknMIzgz6+gInHwK8Id7RUK4RmGKX2S0COk3n43fswLDzrU6DFd4pUJgNxUx6
 R8TqzBhLA9nv6FLQnfgBbBBk/ulL0InBHFA6ZywBirLtBHap9W5EDLqtLdxz1zGFtgin
 WjxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqTZT7dbXjH6CguBfzDpkt411KIuwVQ/rZTLZjYNn93TDcrwlO/MBC6pPssth4/ZqDj3DyWPGpXB1l@nongnu.org
X-Gm-Message-State: AFuF++kj72itelnmNu2uozOIEYez3ujL9EwqcBlBFqMXQ4Gu2bz5VScT
 2+yxVbMDvj+i0bymQYgwLE5SuJE4efKm91aQ6A9Lfm3eCLJinjY3dIT/uRQyn/5rlJt6SMnxvNp
 jLZ7qp9KEjuBtWzcjM52s/eLr5X36Nt+lSml2Ice1Eozy72AftxVBd8/QjQ==
X-Gm-Gg: AR+sD10zbDs7hin4PrZsKz4drVnteEnlXC0GFgPaGQY1HX78to3ozMWQkIraQeufYyT
 4nWSFrvmYlmlXijhaZgiwqj4KRZaTcBHFGSepmFy3+CYu6J2psBF57Zum51jux8AgpwJm8ikEUx
 3p1QhaVAmPD7/I3Oq93W77p1xdQZmu/4W8QtRE2k5uPP0//TIAQKmuuTJV9oUo72gqhCoOk0FNt
 u4j+DvYmc11EjWvOuRWoanAB8sx1byybBv4g4/l6b3QZsy4w0x+W6m8XtaqxxraJ1DXP0/2MA9o
 QQXSFMi5zNAqxXThNmc2dDEEPE/EQN8PFoaK7xfEYvdbFMig7rMmHzAuc4CH3a6Tc2LRQAr5oNm
 FLqfCMTaVnqQO6RvL5t24rJ3s9dqKZT16m68nf7fH+RSK
X-Received: by 2002:a05:622a:93:b0:52e:125b:9444 with SMTP id
 d75a77b69052e-52fa1d2d479mr9994471cf.17.1787766342517; 
 Wed, 26 Aug 2026 10:45:42 -0700 (PDT)
X-Received: by 2002:a05:622a:93:b0:52e:125b:9444 with SMTP id
 d75a77b69052e-52fa1d2d479mr9993831cf.17.1787766342112; 
 Wed, 26 Aug 2026 10:45:42 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deae179fsm7182997a12.26.2026.08.26.10.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:45:41 -0700 (PDT)
Message-ID: <0d110721-caa0-45de-a528-5103c4d89407@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 46/49] monitor: move monitor_hmp_print*() functions to
 hmp.c
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-46-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-46-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8f2647 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=3WJfbomfAAAA:8 a=20KFwNOVAAAA:8 a=23H03MXXmLmTsxUcf24A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-GUID: uzYfNu2pA9L7xsPXPFOj3UIil6hVFHKj
X-Proofpoint-ORIG-GUID: uzYfNu2pA9L7xsPXPFOj3UIil6hVFHKj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0OCBTYWx0ZWRfX4359JRkozpCw
 FXUC9+kygP6HJ/cEiaqpX8jC9xcWA52sAqRCO0MRYWqMme81aE0HBFA5Ng6dmR4z+mt/kwE9Yhf
 Qbfu7l6cPbXgz2zslQfVauXBOBlwGrSwzcJa5hriDuC1wnv4EwhQvMShSpym5gwvGODCRtY+O05
 2B6jvtI1MeSYOM/dshQ2KL4PQDv4scSQZhImazjy5JkG/zfuqDL/9hOxlDujh16yLUnbi24o8V9
 GBZgaaeLHnSwJIM9sjWzRjF05VcTBM+xtorUzLSVJG9Zwz5oBLRdksMLcx54fh/MrI/rll/LiiW
 gyhU7ym1pGAIHBGMISfT9kp3NhXVvXFOr0CmWSYjhkUEp0ECTLIC4qauo/hJ5Dp+0PWb+RCT7ng
 UMpGP0QIUctiyBS/Bi3FTiLazMhDB6DwffMQ8vNhXTDA+ecNm3DT38lf/RbYzUSVk3pIHH+ecke
 tKqx6rtM3tRLqx0LqUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0OCBTYWx0ZWRfX9b/CtKnWSwBn
 4fIrg+LLkxQ2tr9atHPNsuQbwvT+Tpz1qXAYZCDqy0kiTY3Gj2Eu6/iBTWkdnyYpVr8duDj6EI+
 yt/hg2pHd8IuQCV6kvMMgE58oJtjxnI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260148
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> Those functions are only used when CONFIG_HMP, compile them out, and add
> conditions for the calling code.
> 
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   monitor/hmp.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>   monitor/monitor.c   | 49 -------------------------------------------------
>   util/error-report.c |  3 ++-
>   util/qemu-print.c   |  6 ++++++
>   4 files changed, 57 insertions(+), 50 deletions(-)


> diff --git a/util/error-report.c b/util/error-report.c
> index 78ccb6ea608e..111bfe29020b 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -35,10 +35,11 @@ const char *error_guest_name;
>   static int G_GNUC_PRINTF(2, 0)
>   error_vprintf_mon(MonitorHMP *hmp, const char *fmt, va_list ap)
>   {
> +#ifdef CONFIG_HMP
>       if (hmp) {

Would this work?

         if (IS_ENABLED(CONFIG_HMP) && hmp) {

>           return monitor_hmp_vprintf(hmp, fmt, ap);
>       }
> -
> +#endif
>       return vfprintf(stderr, fmt, ap);
>   }

