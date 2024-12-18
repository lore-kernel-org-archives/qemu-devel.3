Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6905E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 14:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNvAG-0004U0-Lh; Wed, 18 Dec 2024 09:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1tNvAE-0004Td-VJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 09:36:38 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1tNvAD-0005CS-5T
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 09:36:38 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI85ffn008854
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KbE10CchUz7Lpn5Fh7tQMUMA
 0Oa6DpMtjQjc9TgNgsQ=; b=LacW7+9C/hHZ77cbEB/vGqAZ8kKIVkCcpyuaNToT
 fHxTO/breTujQnxTTnNsRnu+6maE3jWlEZanDf61RGfjXf8Ap6lqz44b/i1SXx6w
 oYIDGdAWFBTO4TUL+ey89fR3RmYj4ChGBU01PdCIOWGOgapH7Vaa4JCp7aUjETxS
 GTy0BfZGtT05LBu5p5UYcOQmcUnjBArifEGzjZ3LekmbV3BPrT7o1uWXfTmPJ39e
 VoOTpRB+ixFayJRIFVJVem/lM5GRW1Zt7o/egmdU/GXc4zlPR7J4E5I4s5Blzp8O
 yq4NsK3T+Q3y35iiTL2l/k9MYMhnXji6LQJUasCv0c/r7A==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ktk2h1n4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:36:34 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6ef66fd6e78so12363247b3.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 06:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734532594; x=1735137394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KbE10CchUz7Lpn5Fh7tQMUMA0Oa6DpMtjQjc9TgNgsQ=;
 b=sAax31ZTBd4t1bm1/cl9iclusrvctWWT9wd2JTyjJ3zGMnnpoPj5/mCxXL1cJXtt5Z
 YA5TZNFv1SfizrmzKg7sZjhKMJ2vvZtkbNxn17f/1CIrQi/yacbSSgMpME9pUQIeuP0s
 9kQDYA5tcexEvCCpvujAfMZsZos/eGSmtOdBwY+B4/4SVad/ENSkYKcARVDp2nsO4g2x
 Hpnvq92gYootsa3hTnnugUY3SDCLoC/UiJ0CGdp/mZvTaaewY4k9wlfsdyd0pG/fONpq
 Wkdf25C8x5x+2jOXoS0rrSpSCTXgGBXaAOBfeH5YZspDaMg5dFUfOsN5AUWJo0uMYUft
 2MeA==
X-Gm-Message-State: AOJu0Ywy9O6KsaolY3Csq3MV2qoynEHBYbPAYT7uWVzhXrjwBDLnYsud
 acMlDcrcLZiJiXn2iKKD5rGCWETmaXBFsiRqZ/x10LyvsAf5j4aTNHOSto8w0vwvFgSAHlT0iog
 H3guxhnmB8cSQdvhD023rBiXHM+xTx7mEgPMKKHoky6tfO2j/1i9GUpLnmDzTTvSkREsezZFElY
 56ZibAarl85dRE4EigltAxoGJWaTLx
X-Gm-Gg: ASbGncsCyWBUDSMdA6Y3vIfhR7/u9u3UXqUnOdYfP1letzFJS7Tt0K7Hy5ImnRFWbT/
 u0XDi/xwFd8by6UU4P7i/TNKi6UK3jMIssefaJEiUjHlj4lchiQH+ApjB3I7sHHpqAabsmg==
X-Received: by 2002:a05:690c:4984:b0:6ea:6666:c0c2 with SMTP id
 00721157ae682-6f2bb9a3898mr68117877b3.4.1734532594155; 
 Wed, 18 Dec 2024 06:36:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQRCkIkfkJUJe5U0ylwUllPxMX4hRbs2qMjUhs23LYZ5eg2h+RSlw/j9rplFMVoxFl7tzQW4/gFsIjeQSuoPQ=
X-Received: by 2002:a05:690c:4984:b0:6ea:6666:c0c2 with SMTP id
 00721157ae682-6f2bb9a3898mr68117687b3.4.1734532593827; Wed, 18 Dec 2024
 06:36:33 -0800 (PST)
MIME-Version: 1.0
References: <20241218123055.11220-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20241218123055.11220-1-marcin.juszkiewicz@linaro.org>
From: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Date: Wed, 18 Dec 2024 14:36:22 +0000
Message-ID: <CAD=n3R0cxu_jf7ErQ7Cjwx1pr+tU=8F-THKAaH8KVHubb2VAHg@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: remove myself from sbsa-ref
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: jtwK3-JeUvhsr-b7H3Qs7cypDCadgkAw
X-Proofpoint-ORIG-GUID: jtwK3-JeUvhsr-b7H3Qs7cypDCadgkAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=817 clxscore=1015
 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412180113
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=leif.lindholm@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 18 Dec 2024 at 12:31, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> I am ending my time with Linaro and do not have plans to continue
> working on SBSA Reference Platform anymore.

Thank you very much for all your contributions to this platform over the years.

> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Reviewed-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 822f34344b..776e0b997d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -918,7 +918,6 @@ SBSA-REF
>  M: Radoslaw Biernacki <rad@semihalf.com>
>  M: Peter Maydell <peter.maydell@linaro.org>
>  R: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
> -R: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/sbsa-ref.c
> --
> 2.47.1
>

