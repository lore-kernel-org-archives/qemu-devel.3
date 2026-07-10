Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E5CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 05:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi3YV-0007Ld-GK; Fri, 10 Jul 2026 01:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi3YT-0007LM-7r
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:13:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi3YR-0002A7-9J
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:13:40 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mpFT3629779
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xs6NUFxRVHe+c16WgLR69BYhRzNE9OXt2c8UIjniR5Q=; b=bsNWT/8P8xu63eSo
 ynPEh9y5rF/SAbkCzGeLgdkD7gIFbA23oWEO/T4cAy8zeOMgIR7ID0oCI9g5SwTv
 z1GkutYJPeJoR17LF4ROViLxYAk2GduQ7fgFtnE1+RJS8AIW/SiFbZdu1sjcf2hJ
 B5AxqlSLo0xXhkxGVpcXz6PCZobqjPHVIgzefAt62YpkIBp90xQGk9W75Ty/3b6h
 f8neQbSG9p+0lTVBKIC+bzXzpcZkqC8wDQ3S6ykwRCbmPybeGEpjq/GPX05IQTtx
 uKZ15OqKPGd1MgJOOw/HfdVydmFHqr3MOePDxzHjiPF9UII8VE9wdz1Pp1gFRdq3
 u+kFkg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8hnpb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:13:34 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so1129726a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783660414; x=1784265214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xs6NUFxRVHe+c16WgLR69BYhRzNE9OXt2c8UIjniR5Q=;
 b=DjcEPbAfJlyn25fUYx2pgKeKjZDdRA2dDsVbxTSSRr0MOl5FG5PCUxluFs/uu/D6Ih
 8+4Jhfjsxl/QlHOXeWeWIOwAzngABQglMPXJEgUr7ScmCt0D/4+uNyKdnKZbWxcIdFdh
 FX7HIwpwnj+TYxnRS/hBScodksSaTqkbSs3Pez0p70jbuMWJ9zj9VkhIFR836/V1GdQx
 iasaH8hurawPXD98u9L0ouoVhscmWpQnmW9tyeOP+PoZ1GzY5P7CL3PbVkk0xKJE9faf
 o8Yaj6uKSldK7FGAPsnP6Nc5IoJEu/qRsYFoaO+hY7KeYJlvjrwLdZEKeN+BcXs0KS4e
 qXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783660414; x=1784265214;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xs6NUFxRVHe+c16WgLR69BYhRzNE9OXt2c8UIjniR5Q=;
 b=nMPI8z3vqe29RPh7pAUHeA7X1OfozeZhnfYZdX2C5r0x9aq5gtP5fqyQUadlqobhtI
 1AxasFQvnfV3RDraRnixJLYcLBAXmUpradEpEZoRvyrhI8viW+7lfEjn+9Qp50vs3thO
 hwq71SXMtTqVNPAtrDKGJe01kOR1+B1Ijmz84k8Fh2Cg/XlRaiYW0c1x8nvjcK1aeBdX
 w9RRKyU3JdAjenflqLtKLbKbWXs9DVfwPvm8OYcss3fSZMmyOh//ENhxj7JakuUDscxv
 dOeKqpkRCio3SMAZviCGVtQeBmqFzI5t/MWyKRWY9MB97pma6GYQ2qztdv/OOXYRgMf/
 tM+Q==
X-Gm-Message-State: AOJu0Yw8kjFbasJxZ4amBxg5oP8R0M+2Lg33S2t3XeCfyY/8jU2kvw1Y
 f7mVlvM8Nyd25kNJ4NRLyayUZNqK/7CE7X6XYHM3g57JK5D/Eu9H93OMvMreyqwKwutHH7v7P2a
 ezRragIWqPM6Vhm8oFFXgf/7Gr9mqAkvzQztVArCqucguHzmuOS+0UKinTUP+8eNnIg==
X-Gm-Gg: AfdE7cn6o48/oW+vbxVeOTjZP2Ku8Ab5nn+k3FAKQMNRGiCi2wEAezZ2Qdr39lK58aZ
 M6zvQOF7HOcKxkOJdAl8zEIKq1QLgdcUyxlhtvGlc7Z7JVXEbGT/bmihxP78PLPezMjLH34OZiE
 Hss1ML9aJFnc7az71Azh+q4bIo2j8IilMKITSbIKYFEj6LUZ5gyn+mlmsZkiRuV0rT3dAk2alqA
 N4dWHoEDviCmndmSh+6f8PlPg6FOrSAP7/mTocKSOU2dLKr306H6WMLb9YyxkrQJ+nRa2QTJ9OS
 +n0UVlFCAj/n5P6IGiMnniVrXjhZ035X3R0sSJ1AuMOJgYcL4nqE6lDxNdkaR37HhS81SuAQ8YK
 YWfZUXHY5hsj57M8VUxDdJZiYQacaO9GecIP5p4plaIVspgWV8MLHcP3mhzmxrhYsN4rK8OJQWB
 awLnU=
X-Received: by 2002:a05:6a21:339f:b0:3c0:9c19:6583 with SMTP id
 adf61e73a8af0-3c0bcf97af7mr15238919637.61.1783660414008; 
 Thu, 09 Jul 2026 22:13:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:339f:b0:3c0:9c19:6583 with SMTP id
 adf61e73a8af0-3c0bcf97af7mr15238874637.61.1783660413433; 
 Thu, 09 Jul 2026 22:13:33 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a583bcsm41376586eec.19.2026.07.09.22.13.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 22:13:32 -0700 (PDT)
Message-ID: <ac1d8cc3-b7f4-42ff-ad52-8f478e5356d8@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 22:13:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tests/docker/dockerfiles: add missing apt update
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 berrange@redhat.com, mjt@tls.msk.ru
References: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MvyU7SbQ2rIrIMrYkQleTYwY9ckMUhZI
X-Proofpoint-ORIG-GUID: MvyU7SbQ2rIrIMrYkQleTYwY9ckMUhZI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA0NiBTYWx0ZWRfX9xBOkdgsGRZx
 mFvtnU2StYYzRWbgFHNih3tQGolYG9DDfR1c8hNGXOeqBrl5MTLrsWjIA+T+vYOMRD2k4PFxzdV
 WKgrrufYsF6JFcatxlFSXHPz4sefE3c=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a507f7e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=n6MYwUk4AAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=4PkhFD8GIvDxF98vbkAA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA0NiBTYWx0ZWRfXyNliLMGN5mlE
 m1FN8zJ94MOHwq4T+1pnnji0lz5VhL7MH14WXt8BmOYIHtLSN9ZU5ioQlZKJakeKLmrN+ZfPu/T
 CPl3G9kQej0HfASKKWgE6/B7fsWXXkkhdR7UGMpszzU9Ie8mTtEUhfY0qqH4XQuj3xm8NGSt7DI
 AZc2GPb1ZykEzhIl7bgkF9RVRiy10PjPZAqFkG4qhxyRJ854H1cPRaTZx1DyPSzbxoXwmE1FKKd
 hIXb9gVoBKxzbF51QcvvkQZx1mUjYRuNj40eJI7ITF0kE5qlIxunXv2No78zkmH0stPCzQ9nNU/
 hVBCzk0xC3Cm6wU3uTZ8pFCgj5DJCfEKE2fG/6M1FOtVt+YvCqlwRVcwC9T1/brhYO7ZJxdu/1L
 wcGeGIoFf48czBaMjDEQJaqXKhQ/oz/yMJacstFukFKplfl9pUj9l3BYaQJ+K4hdQ0SCQhJ5Zu4
 cFUIHIzrQy2f1vigaxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100046
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/7/2026 2:46 PM, Pierrick Bouvier wrote:
> Some of our dockerfiles include custom statements, and those are missing
> explicit apt update when doing an apt install.
> 
> Since docker caches layers when building an image, not including an apt update
> may result in error, since packages file will not be up to date.
> This is also documented in official docker documentation:
> https://docs.docker.com/build/building/best-practices/#apt-get
> 
> This issue was first reported on:
> https://lore.kernel.org/qemu-devel/4b08f4e2-2274-409a-86d8-469c73e21579@linaro.org/
> 
> Pierrick Bouvier (4):
>   tests/lcitool/refresh: use raw string literal for trailers
>   tests/docker/dockerfiles/ubuntu2404.docker: add missing apt update
>   tests/docker/dockerfiles/debian.docker: add missing apt update
>   tests/docker/dockerfiles/debian-all-test-cross.docker: add missing apt
>     update
> 
>  .../dockerfiles/debian-all-test-cross.docker  |   4 +-
>  tests/docker/dockerfiles/debian.docker        |   3 +-
>  tests/docker/dockerfiles/ubuntu2404.docker    |   3 +-
>  tests/lcitool/refresh                         | 213 +++++++++---------
>  4 files changed, 116 insertions(+), 107 deletions(-)
> 

This was merged into master (4faab9a11f8be37c869894cda821823ef6ca7f58).

Regards,
Pierrick

