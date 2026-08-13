Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C334BC5AC67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuQki-0000Ah-Se; Thu, 13 Aug 2026 04:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuQkX-00008O-OG
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 04:25:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuQkW-0001CX-4v
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 04:25:17 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5g0dI1875063
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 08:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vgfr61AI1OzNyS/5Dwvzo1Zys2YD9Mh2egnc3CcCFRs=; b=Kfah5kfka3J9q3MY
 7SsDz+01bhvHg6TzSBYaoHYmUdfUqSb/omaDScUYnj/IvOZHbwNue8F8aH9CyNQw
 a7vr4Wel8aH1fYLqkTdyV++fCwq+gV9YSHbnZpyDGXc78pMnNxFh4rNUiPpcsUt7
 P73gg/IvK7RELcPE2YMNrrncOUO+/dQYcqNhiUPhXzFEhQ/wsGoofpz03mFQLH5K
 ctLMdzcm4Sc8ShJZhbjSnCrM5TLJX7yU0+iASKmOfoPk85Oz9Xe05F9lEcNMWTni
 5tYOLcIeIc03/4uVvPf+xg1F1vYNAFOx/vuzeRXDhGYvqkOM7EriUceIMrrot9We
 hfdwXA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0wt8u1aj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 08:25:14 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ea75996387so8319456d6.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786609513; x=1787214313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vgfr61AI1OzNyS/5Dwvzo1Zys2YD9Mh2egnc3CcCFRs=;
 b=bInlk63238I7L+bQhjwOFWoYo3ukW6KuI4BnNhpAS33tndC07vjgWkM5OSw26Nw+bA
 YL2x+L9QU4hu+I/+WzeKaY5DBeeYezcl+QTcvkVfmUVauYarqGxCY/dRCF2Lq938d4HZ
 DQcBkWpRwtI55wWmqOOBOSJemf6DNaHt0uPQhvH7hcXCRPBbApkP2VLSXYvRQVnmEj+9
 Z004l+Og9kAaNKjZNgTtl3zpf+M7Obqg1cTLyvvyI48KWLaVBpXgHoKCSFMA5ptwwwDM
 g/8RBskI/UoaUYlFR9XsTBmQzfksOXqS33gc9TcLL8BgwrQSok2J2XU50/y6Y22B/R4t
 p/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786609513; x=1787214313;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vgfr61AI1OzNyS/5Dwvzo1Zys2YD9Mh2egnc3CcCFRs=;
 b=UqMw6Ik4D+E8bFoGZ4AUf8RUYI6s/GMf5aZIknDjNTgHn0Cx54eoFqRHztDFt5mo6E
 8C46ln/xHR6Bt7v7gadriURr5pWW1GEJ+j/LU31xf3oGlJqxoCApl2NzDwcTBt3TkVzh
 cf/oKpAghC4s5lKnOW6a/lJDarPbvX+pPf0iXnbBfqo82KjAwbia/oJB3qO+9bq62psh
 58n1PwZJcZAY7+Z+Vc/fnGYhK74Q9Hs8q3ZEQRnune+BTYgFRp3g8m7oJIx0ntXuTM6R
 LEF2jptQlJLybpT/jhhf7hxBoXh6XIAOK74BFd3goZj9wAm742rlUmSOXaJYoH+XKcBG
 sGRA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpk9PjSylBBYpWB5S+vb+TOfkJjcoXmfaJZr+HJDx+NyeRKPtnN+T31+EL71hLkTbZ6Qzri6u1fzcgd@nongnu.org
X-Gm-Message-State: AOJu0Yylvq2JsJ4eiDVEtCNJETTVrA0O7mBwdzJyyEqXifhXHefpBTE9
 /BqLagGoF5hQOAbfwGGy3mnTHnG0FIts3QzPP3sOo9nVerQg8ISk3n3pbxjHJp3vetCWYUJXJcP
 nZH0T4Osp9FUG9Or5gha3RYMrgKUGixQuHJWdRaYFE2ilcPGx3uZlxihDQA==
X-Gm-Gg: AR+sD12ePzr2peiM+1JmcIIM9wCf03Kxvn+rLrDyc5xBO7lQKy78kEkXVCwOyace/DA
 WJigZvfQ3W5NBofpTEKSD4e6jFQ4gsUPMbc/eJEsKbRdLjmkjmK7oHxsym0DVOt8Db+f+ezUdMA
 cYvnMmQ7fyci6stEXI1U9rECh5Uax2E7WZ+YDZYG92RnkBHSd1p4QAto5azpl0ETNdERpPCRhkZ
 EBZenAtcAB2vrTT69++9itnJjh6glOyHUz0Hk1LeAEp8Yaf2Z0PPuEoDy+t5TnROL2MWaXpGphn
 3kP1RQiMwwjeTpsCa4JNeFx78ez6pGe+0vvVlaSV6805pMbuom7Z8jzdL1lx4+h88oelb5hBEeW
 OyjVNw+StZM4DE9oJDkfpdczH4+aLp/leq+I=
X-Received: by 2002:a05:622a:4a8a:b0:51c:f8f:13e with SMTP id
 d75a77b69052e-52d73e3c88bmr42354911cf.40.1786609513567; 
 Thu, 13 Aug 2026 01:25:13 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8a:b0:51c:f8f:13e with SMTP id
 d75a77b69052e-52d73e3c88bmr42354701cf.40.1786609513167; 
 Thu, 13 Aug 2026 01:25:13 -0700 (PDT)
Received: from [192.168.69.208] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b631c1sm101475805e9.14.2026.08.13.01.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 01:25:12 -0700 (PDT)
Message-ID: <a1de655a-0c03-4cad-997e-b3952e2083d9@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 10:25:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: fix build against nettle >= 4
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: berrange@redhat.com
References: <20260813074048.3624651-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260813074048.3624651-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLqvDxGx c=1 sm=1 tr=0 ts=6a7d7f6a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=FHLMpmxj3tT-JxaKygcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1NyBTYWx0ZWRfX0lJP5SFhN1qt
 ZXZIvTPSChXoW9HB9NgCUk2V7ounhjUrrk4jmQwUQzYk2ugNijVN1DTAYZOza4PswOhS53O1SVV
 ZQXhKuo4OiYcRY54oz/FPL05jSqEP4gC/obwtQz1vHm52PNG1JggIVzicgCuPkxL7IFOMuNPlEz
 vEY/z4GZKPFslMb7NlmJU+HssUZjTyMd8kZe19MH0SZbGvFWRXhIssMP8xFCmq4nNMCtVaS2Y3Q
 n5cPxnRfcBR7BdiDM5Kae5/hwHk6ab4Bg4ZF4DNMjBvVxm4dBPRLqZJRzqAsWu/xvLiapfqEjkn
 /JrTyJUA1yaZt0PjGcV5dKQs0u/lFYvvLl8f8H0374ZFVgr/i9+ZLQIoy1MlibBbXfj1k6V+Bzc
 pzabqqcp/EotCxT3iqNCdVWuppq8YJGsSm28NTgRzoPOh4US/SjZIYeL++ZvYlUgxSbtXejOPXe
 QKt038IeF3ESOZcckPA==
X-Proofpoint-ORIG-GUID: uV9CJVQH194rzj-HUoZ76oD7MR2g83Fv
X-Proofpoint-GUID: uV9CJVQH194rzj-HUoZ76oD7MR2g83Fv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1NyBTYWx0ZWRfX5vd1gNnjOhMY
 8XIfP1ArN/CXix0RO5lAoW7QYp5YOYmzW6UlFRyyDLuvsy2GNV9gBVRKk2KFIRhE6hTgL32q4Da
 yLaU7KnNwXmeDgA+Xq8KLJ6GHSOBRDo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130057
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

On 13/8/26 09:40, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> sha.h has been deprecated. It seems we could just rely on sha1.h/sha2.h
> for older versions too, but I didn't check.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4184
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   crypto/hash-nettle.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
> index 53f68301efb5..c0ebb44e11f0 100644
> --- a/crypto/hash-nettle.c
> +++ b/crypto/hash-nettle.c
> @@ -23,8 +23,14 @@
>   #include "qapi/error.h"
>   #include "crypto/hash.h"
>   #include "hashpriv.h"
> +#include <nettle/version.h>
>   #include <nettle/md5.h>
> +#if NETTLE_VERSION_MAJOR >= 4
> +#include <nettle/sha1.h>
> +#include <nettle/sha2.h>
> +#else
>   #include <nettle/sha.h>
> +#endif
>   #include <nettle/ripemd160.h>
>   #ifdef CONFIG_CRYPTO_SM3
>   #include <nettle/sm3.h>


