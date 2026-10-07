Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE32CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEYGW-0002G7-Fk; Wed, 07 Oct 2026 16:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEYGU-0002Fq-3A
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:29:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEYGS-0003YX-JG
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:29:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697JNX4m1025310
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 20:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wvwv2FxCQ0XZGL56Z59jUR/siZitrbyZ03mjLQ0+GZE=; b=lztg0S6OqywzPv14
 Y/4K+KenSEEvo7/fI5EWrw+8hN26N8wM/KX8ohuy5voRzkPM7iDj0h7pbWIwffpP
 MCtp65JLuZyuKqG9IOVGKt5b85Wd3pG2UAYMcYleW3LjA/7bgGd5p37AHa6cl39C
 kE4yXuvpUSrV31pgo8m/vOmOwy9GiT0ibajlearN1N+mKNVzIiWKoiTtEMloshVa
 bLdQ0JLowXVWTX1jg6lGRgmc0CRgOt4myxBBoCm26PQCGHct6HwW+I7WSQFdHGVs
 ZinaCTKJSlWmPtntpVRcfFJEBxE6QY4HM7JinbXHfe87ryMYicIblKfV/muzN0f/
 TMj48w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5td40q07-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 20:29:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so6926816eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791404957; x=1792009757; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wvwv2FxCQ0XZGL56Z59jUR/siZitrbyZ03mjLQ0+GZE=;
 b=WWifD19KgdqJ+E2WwrxBmIF0GjJrNh/qdr40n5fFg7GeJh8Wb6YeWP6TGmu5vPIS7u
 lLnp8yCk+CyNW5JeMN3HOEKKVJe3NHzMcC04Ye6mMpKYnDxLfCvs3QU48Zgu6VUgUhzC
 oEOlBZD1DpieQSojJWnyjv4gohs8OpCRkLGhwfUqdMJZlYJcAXCsiqHdRvdo0MZixOeO
 cz2wOPz7UvUJiX9m0y4r6B662ubp7f6DQ6UR8XK6FYQW1now8jC2INMJ430f409rUAfm
 nKNgHMR2bUsIXV2KVx6mJIKL/wsvBPwrZzaVsTogzmCkt7uRE9OxdEAUN2+CD9mHMOIN
 izHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791404957; x=1792009757;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wvwv2FxCQ0XZGL56Z59jUR/siZitrbyZ03mjLQ0+GZE=;
 b=ot82lGZNhIO9sSufXMsoFHZ1NwKUyODz9GCRfsvtFfvBYJanLyRM57xgdfzAgZoBmr
 OP0TE3xUUHFmI/IWezGIXe6NOdlzdvY+6S3ooby3WoMw+PHlh5P/wYHigofbEKa0hFyp
 t7gco3DsmWzO5EhXtX1wnFJdugw7dobZgwxqOVlCFj5AXSgmOK3FNa4H9Vapx4JhN/B+
 16xGQEmN3x03T/6mI8KnBJlHZblfhSql61zdJ34nUki9lVswxaR/+B7Gu+wLr/mvMo2a
 efyvfJT+njpGoXLjgdGxZbDtu7lcZjsqCxqKxNY5c3+Ya6RYNMHhUmT/Y8TLCjxJ6caL
 +evA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwafbo4zx2tUaLuz2V29ysfEw3Hw5Jhm0gCGI0qwBG2u7n654Muauy6RuT9g1IHfTcYhghwtqm/Gr2a@nongnu.org
X-Gm-Message-State: AFq9FYIe5anPvooCALADMvrqd8aoq0gpl9IZQMavo0TSQnfulUExVpGS
 v9IW2P4d/vsxKaKLa/TBhL1/7yFEv0LpDB2LpVCxjeDtOfqd8fOxRYID508cSURBct/Q+z0ZGAJ
 kyymL1NDf3xCwoOQs+PeDkXSERF9NKGhnvgzAnpytQX0EBjcdq+QjuYzHlA==
X-Gm-Gg: AYBFou2Mu1CFdXP3Ug+/YHLu5H5G9zZAo0oK0yTZszaQqymGJ1R6kgg1iVwGkdRn+pI
 p+Rf7GzgN6ZLtLvxf3FaRIpmvFRVA3OeY6imKCAyUQFDFQKknz9q9FcEBt34NmAauw3/AxkRLn5
 gSMf5e+a0vtYuCd435c1WKFokwA4/ZK02sq7n8F2cjoggKi2D1WSYtkypJf21mHKvWbUvrv569l
 gFTMFCshAU1jITfwJYYhcVFCCsj530z7HIGwydA3SFRvs3huRDnojQXkDJ6VrpEMhAPXT23+gSx
 7nNPsgzOU/VIdGgXSmr6alYBLyp1sYRWcRC8d8sHLuNV/EldGwhK7W0QK63u5UywNjNAngqE/YR
 TM63LluQvaIx+tGeF7cQEY2vUogBFhPEXrBN/1a9pG5ZJHHmZk8zLP/InS2pqHUmQfbAPWg==
X-Received: by 2002:a05:693c:83dc:20b0:33b:b0c8:73d2 with SMTP id
 5a478bee46e88-3515dc54535mr4054169eec.3.1791404957095; 
 Wed, 07 Oct 2026 13:29:17 -0700 (PDT)
X-Received: by 2002:a05:693c:83dc:20b0:33b:b0c8:73d2 with SMTP id
 5a478bee46e88-3515dc54535mr4054138eec.3.1791404956496; 
 Wed, 07 Oct 2026 13:29:16 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515b02d552sm16799624eec.28.2026.10.07.13.29.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 13:29:16 -0700 (PDT)
Message-ID: <37275f1f-aee9-444b-aaed-3e0bf34b63cd@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 13:29:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target-info: replace QOM registration with a
 constructor list
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-5-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007115253.328-5-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: n5ZzczE9N4lCvZ2LM54n8cN5K544r9AY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA4MSBTYWx0ZWRfX4tbfxiOGoP14
 x4BPMh6qxqM7go9u9S0SymS5rNgqReOSnt1z6REhMBrrTiOYdNAREEDE/N4W6IWCvwQWSjhazSp
 0OjeXqw3zD7GChQa7aXmRrYtOCel+HuL74VKHUZj8vNnm3KpmZ6wPdluSJRpWM6YZNna7fZk3kf
 jyE5CBhKD6LXT7dgwY71BQI/vxcqu8/BmJyb6KQvXsa/C9pCgn3NnUHhEcOctD2xmgkuD27iJfB
 3jdZtAbtGnBzdFmRtV0Uzg83ndgpDBuotD4fh+Zr7t7eU4m3bSMXGe3Ni4HICMZC0oWm0nsiTLH
 eY6q/XeJV8Elcz/cCUGXXNBY93AlzVN2OGEgW0AleGEY9lDzVrrrrfwWRfwgQUvlMQUFTNRSQ9S
 Ygdftgvo4DbLayYQadYFYW0NBVu4htjfUAamgX3FzQ4D7UmvtIM/oiZNZ25f8MM7UJjkLd7jtTc
 76rzIYxIaFzdAicn+gw==
X-Proofpoint-GUID: n5ZzczE9N4lCvZ2LM54n8cN5K544r9AY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA4MSBTYWx0ZWRfX5JsNX0WuvdCH
 94onXtFZkYLsZm3X5FJlg8ZY36wQeLgtZqEoBOwvLSV0+dwUYTmwZJrhbx9acdkyM6vGVeFsboo
 pr/R8ichlYX0aE5wNu7SZArZsJE7SV0=
X-Authority-Analysis: v=2.4 cv=NY1zRGD4 c=1 sm=1 tr=0 ts=6ac6ab9f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=UaM_-XG8lHQMMUz9hlwA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/7/2026 4:48 AM, Yonggang Luo wrote:
> Register target definitions through constructors instead of
> MODULE_INIT_TARGET_INFO, making target_info_list() and target_info()
> available on entry to main(), without explicit initialization or a
> call to module_call_init(MODULE_INIT_QOM).
> 
> Keep the target list sorted by target_arch and default to its first
> entry. Provide an unknown TargetInfo fallback for target-independent
> tools such as qemu-img and unit tests that link no target-info-def.c
> objects.
> 
> Remove the obsolete QOM target-info registration infrastructure and
> update the multi-target test to inspect target information before
> initializing QOM.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  include/qemu/module.h           |  1 -
>  include/qemu/target-info-def.h  | 56 +++++++++++++++++++++++++++---
>  include/qemu/target-info-init.h | 53 ----------------------------
>  include/qemu/target-info-qom.h  | 31 -----------------
>  include/qemu/target-info.h      |  9 +++++
>  meson.build                     |  6 ++--
>  system/vl.c                     |  4 ---
>  target-info-def.c               |  1 -
>  target-info-qom.c               | 60 --------------------------------
>  target-info.c                   | 61 ++++++++++++++++++++++++++++++++-
>  tests/qtest/fuzz/fuzz.c         |  3 --
>  tests/unit/test-multi-target.c  | 12 +++----
>  12 files changed, 129 insertions(+), 168 deletions(-)
>  delete mode 100644 include/qemu/target-info-init.h
>  delete mode 100644 include/qemu/target-info-qom.h
>  delete mode 100644 target-info-qom.c
> 

This approach (custom list based) was considered before implementing
things with QOM Types. The rationale I followed was that if everything
is in QOM, we might better follow that for consistency sake.
Yes, the compromise if that we need an extra init step, but it was not a
problem to add it.

Is there another good value this list approach brings compared to what
exists?

Regards,
Pierrick

