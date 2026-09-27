Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA6CC98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqsy-0003jk-Pt; Sun, 27 Sep 2026 11:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqsb-0003gj-S9
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:33:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqsa-0002F4-1R
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:33:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QKckii263506
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=; b=khGckBkqaWSYhSul
 HI++aYXw9V4v7GO0CA0B8E13skP3f28xP7Ywswt1pqf3jGNswKXEgztfZptKCfSL
 bnqpbzxUi/5tchAc+5/3O7ypE2V7/pCTq0f3rzW09N+vjRVkH1pMcmZSuyqKKcp2
 H6y/9DMczWLaKuvgS+3XZNjx3d6rjYsVtSmDq90s8xpihPp6QP3SHu3qO/Bk3Z1t
 Z0LIHnM3l6citHugAclzWlIrfzt+lxN+DtwcX1k0amHLz+rWUQBft6+EB9vmNsov
 A1LFm3trpFFBcnnOZMTY4QqvbTynVBOc9b/NKjsijryaz2sgyxfJYvjnfZNAPbgR
 XPp0IQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6tek44y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:33:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c77c0d96eso28489585a.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790523205; x=1791128005; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=egKzfBuB+ZfBfdgz5/nG7AQJLva6CKID+st3XCfMsADglyEs3+HwH9IRUaT8QniUSn
 eLfuR4Q5Z2Bu4nYSfLnOX1fziekn0PqWLPazHW1K29e9qr4vI1OGOEMUOdfayULIccVP
 OdX9K/UXq+vhoaedui637Ksdr9uw03bW83Y8jcLgmbKr4LYEttCi3iWe5Azoyam0XgLr
 bEcvbhatiBDvlXyZV/kH1/59udOAGQzwWsxvj65VdfMsCLGUpeKzMYei/0p5HffkQ7UQ
 GOAuzcWZw99fTR0neuNxcPjWO+0jAkqyIm4KVlKZnRHozyxHN9zvatD4rjcC1W59crel
 QxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523205; x=1791128005;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=MkzhtK3ucCr2NB50V6A8dXlbMBmspMMj7gO2GnfLxfGLGvm3KuWat237Z6qoZ84sBS
 NB+fdl4gwRyryMcVXWTgIp4m8evJSfzzcIq8Gbf3g7rpnOgQ1VFzbXorwWkep3/KpJfA
 hqC3kCzQCvg/lxZyoAyzqiHCwcImafChDhvEBimA5H8CJjsDSIuwHpwR7b4EJ6u+vaNP
 NZB/jKRHbGy10Eru0CI/iSNhnfTgfCl/sxJkG6JX9UUIkdYny5htWe+Ri8JXLAPZFX0C
 zlwHLFmeiQ3gLveaorpS71zzRUYgROF2ubaWr+UqGSYI9Gs3EE8H4bubbQu0adge4reg
 R9eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZzYSk5MAgOJOCKr3jrP+X9Q37hxNcFUQvq3V4Tz3YO+u9B7MiQuo2gInCJ+HIYxaT3BEU+uwsF2Mh@nongnu.org
X-Gm-Message-State: AFuF++l4dxLEc/bW8W9fng46PpR8E0zdpN44iaSAhV30Rc+59CzWL7wQ
 yqDyPYxu/kWGuhMMGrh4l1Lb2b2gATVEO8jj20Qkj2+xFU3aR4jOEbzFvd7butoJDMojmr6jMP5
 I1hzPQLzOtmsBp8DlQh/DfAdj+P+E/Si5naqL/hy9QNZCe4fRdvbkmZHLNQ==
X-Gm-Gg: AYBFou2YNBkLS2twwxrEVyPnwI8+z64cuRQ21eKXq3Tv1lpIEg7tkLUnXNW7jfPEL2r
 cEsJqmTh9NzHcOjnPihTvMtImrJxpuwaVqCEnSUvPS9g/Df7vwQoC1yxC9VopQSH5IplFT/bMjo
 sXxWNx4q2xYceh2uFSGvAE19I92Af/XvUehBmZP0RliMwgeNQFAbFNErYOjPrdMmgsmpSuU5cDm
 NJqcWLVntsOCaj7eHROgRbnrwWPmaDiuesbTW3Smiws3KLi8KupFB3vwKWVkkLxTNiJZ2eeqOug
 N8Tt/LFO0Wv85EvFqRIAGXvVpRe1nZ10B2VOYy96KudIAb3jrnqyyN0vcpNW2SaYbGrjr9aDaQY
 o9PcTdnodBHr7G5Q89Cp2RMogY/M7lOLoJA==
X-Received: by 2002:a05:620a:172a:b0:93c:23c0:c2b8 with SMTP id
 af79cd13be357-93c43b5bb4dmr1607516285a.7.1790523205318; 
 Sun, 27 Sep 2026 08:33:25 -0700 (PDT)
X-Received: by 2002:a05:620a:172a:b0:93c:23c0:c2b8 with SMTP id
 af79cd13be357-93c43b5bb4dmr1607511885a.7.1790523204865; 
 Sun, 27 Sep 2026 08:33:24 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018e54fesm59268795e9.4.2026.09.27.08.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:33:24 -0700 (PDT)
Message-ID: <07b39b3c-0ed7-46c6-a687-9ac99b08398d@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 019/101] tcg: Generic expansion of tcg_gen_or_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX82j0tx38eWVn
 kVXJKcoRtfELn1Uus8fzATUqmVuYJ4kPfWibTuGvXKSvPIZE8KXRVN3lAilBOBmBVkUSjXEXzSW
 JSVJREmRmaHX+DgWYKXYdJmvu5HvAL8vunZq1+gan4iKaFqopPmRqVEyerRjdhi12oLSD6AVrAB
 FIwVZDNbk35zwIMAjl9Ur116VLBwOzLgtdvpuydxlPSlxA2FcFHtmcNrY3Bbjs6OBw8uAaMOb1D
 TR8tu2zjSNedipIjhWJKjL5MHCybD0FuImios4LkDLql0iECRnAvmdgYvibxW9K5FCYAhT2G4Xz
 vn3Hqpng1NzRzSE/WAv01UJxeQ9nL9tNov8aSVv1o8PW/7Bn3pCpx3cocxjBNy1RWlnwnZggaRn
 ZYUsmBB8YZxSFDNyxrAgMNYxs2twE6WnTZa520JNO4JMIv5OHf6F+RnJF171QHs6RDjqt1qDlir
 drm2V4ZYBwlS6fIHV7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX1BSBVN54zZgL
 yCxf0yiHT47eTv7yXyHgPae/ati2jEylyDJ4VdVf+0d7mbGAZq0AIXAlz67Aes9JO0ypMwS8Xcl
 BXQXu+287sdviG6cEqK7yY7pRCzNXuM=
X-Proofpoint-ORIG-GUID: _qsHhDI9d2se1ObtWyx0ANcSOX_leMew
X-Authority-Analysis: v=2.4 cv=X9LHu2Te c=1 sm=1 tr=0 ts=6ab93746 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _qsHhDI9d2se1ObtWyx0ANcSOX_leMew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270061
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 15 +++++----------
>   3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

