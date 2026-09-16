Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5219DC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sYg-00019n-1I; Wed, 16 Sep 2026 12:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6sYD-00014T-1N
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:32:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6sY3-00068Q-QC
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:31:55 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFeJKF3233144
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F1AREO69r44NgyUYJ7+qw6Vd+ao2yR0xyMzMBwd5clQ=; b=OBHxsmdlajPNH2yY
 joFfVh02B3jrkJKHyaATvVPyAPJHY6RvkJEZPzMwzFEUuaQ65lKX5aAyy8clKEBT
 xaaTQUYfdZ1aUEugDLs/BvCXVB1FzEalOvMHTYvEcMPe3Aqe/0JpDi74kuwB4/0J
 Vn97TDKlnO/eXvYmAoj+2CsI0KPaBAqFRTkwk+T7xur7epc7drOHIWbUsB7H9+Sp
 T9li3OiTCo430mx6Y0eGLncQuvfuim2khHSDnibdq6+ajKzJeQJhzF0dtIxxmCdv
 PjSl2ZakaYgFCdsqnVUQmi+E4tAqTh7rcq4S+d15BrZOYg/asS2kpIoLMfMwoiKb
 ZUJ33A==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqdywcah0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:31:49 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4959c49e054so4909468b6e.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789576308; x=1790181108; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F1AREO69r44NgyUYJ7+qw6Vd+ao2yR0xyMzMBwd5clQ=;
 b=BvDw6euTVmtrdRvG7qsfrjaj4yn9jz3YD7cbJ+xXX5t3F7mK4C17tYJCosu4GOGbRK
 OmDXMlHUCyz+szQ25cl0y2dDtDkkvOfxmncylfUAGgC3JLYuErzarJor3vU9SHVC987H
 hMXVQXu/CMI40RR7lcM6kL2KYdSJXpuY7m8xHO6fJU20Y6zHCuNmKL5GLaPx5X8vY2CF
 PgfFh1ZEOyEI4GAMZ5Oi9bfdysQMIlMFLS2IZalOm5kcQ6pw6MvlV8f162wwvpU+7NhK
 17vcg9tfubwpc1YBM35lm2t8u8BE2dmlwJiDyJZPis/rG/6h0icubGenrcLqIZfp3mfj
 VMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789576308; x=1790181108;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F1AREO69r44NgyUYJ7+qw6Vd+ao2yR0xyMzMBwd5clQ=;
 b=awG0c4RbY1uoVvy5AKr45dpYhv6aDvfbdVWyi7jZjjuha+RMJm1fU8LEVLL2tIQV3/
 cXE1oEBeIN8qAg/uSjE1/K9jc8MvMB5x1HJUh14EZmjKunKiigvI7PUof9pmD0CnHx1Y
 uFpDambk0vY4Wu/GOadYhZuqi1O+VxNvuqVlPULrtBGHl3ehCAhjra/ib8b45CKyr1Nw
 ZThReR0V1X8IyY1iQrA+Y6g2daeE01OL40XA6HoLhIn/G/rGGL6cb8kE72hSYWxKULgP
 YxW6O3C0p6Rn708Vuell+aWMGTuxZl5okpj1oauyWDlTdh2x8Y0pyhNI9qtzmyRB7vuM
 FVxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBymCUCd3bgTNJqo00dKrUhJ2/R/m1muWqnavMNnUlxWqXwepmy54o7lRkeFETgDcwLFwk+xD/fVf0Lo@nongnu.org
X-Gm-Message-State: AFuF++niA9hcy/lyS/yZgI8Gv/laHGtEOjqaeaQVX+HAdj4fOReAX3F+
 x6jWLIbLek9zZd4yFxOfhJ37+NYWiBJdE9/XtwHLb8mYnYyjLA0njoIf+FCJ704vqe5NMRQap1d
 7FFuq2/kCmOS1wzFcH4lkHLyrKRV/Bk6qDsXIDJgPJ00dcJjrRBxcyiZjrA==
X-Gm-Gg: AYBFou1dBTbqDdRgrRP7viUMY9MS6PDUJ0hBMpADOguesxjLpNszB6UVcfONsEGl+JN
 wvYFKjCUmUUdYOTVCzbEv2Mc89sDrbfI0gvoW5kmKv/iS1qd3M/6XIcYGZGn89fCt08AzNtupff
 tVVXtn7fLpqYOfCvnR6Zrphuyd/n3g88X1yRd6bvZk78GElswVlCeySlDp5pTFDxzxLFPGeOE7p
 igcUvURSbFvkyYeDl592Aj4HdC8hUpX7fqb0qkhz4VFfds5gQ8fBp6ICRBWm2EYYjsM0RWBHbXP
 +cRAcpIT6onGWHnSaHwMFlPC/gDpgckpHy5UKKXuZP9RGl14zq+JQpukZBrfiqpOlyKgnA9uKjl
 JWfqe/YQz9Y5EyGAvfnik3ekjlBHjskQFglW22SNmeyI6Qnk3iSvJ6KU8/6dEn0jvTc4H
X-Received: by 2002:a05:6808:1903:b0:4b9:a88b:888a with SMTP id
 5614622812f47-4ca4c49bdebmr3404456b6e.32.1789576308600; 
 Wed, 16 Sep 2026 09:31:48 -0700 (PDT)
X-Received: by 2002:a05:6808:1903:b0:4b9:a88b:888a with SMTP id
 5614622812f47-4ca4c49bdebmr3404396b6e.32.1789576308041; 
 Wed, 16 Sep 2026 09:31:48 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a1a5sm9559834eec.5.2026.09.16.09.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 09:31:47 -0700 (PDT)
Message-ID: <65a743c6-54ae-4e2c-ae4d-08e1d6f87ef3@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 09:31:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/19] Revert "tests/tcg/meson.build: implement
 ./configure -cross-cc-* options"
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
 <20260916153013.2134555-3-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260916153013.2134555-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ktqxeg1lonruPYklWpG147Sq4jGuHUnN
X-Authority-Analysis: v=2.4 cv=aJ1lOr9m c=1 sm=1 tr=0 ts=6aaac475 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=qpEU-adqf6FSEL6AZwUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=_Y9Zt4tPzoBS9L09Snn2:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIyNSBTYWx0ZWRfX5+MDXl2DE9jS
 IutllwybHaRQGeStItTTPd+xorshOfW5sHyz7wLlwlhZkY2Lv6kxhrWI/uT04+7XmIgmvTa+cNk
 gNZMI/BeSmULhbfwMyWtsNCP5L53eCA4nOaYfhzlnCduosPtV+sxH7KxHoDiLCWZjE4pe3t8drf
 2AdEJMOSLZPgqGi7abdCRMZbKpakxFqjWsMcyq0jYTko3U7QjTm6b7dTZoGkLuqrYW0J7Haw/lP
 CFbhNuHZ2BI7IZc9ZXAD0j6HILzRSAHEux47OdcrB0jNARgOz87kS5eW+eFzYa0XyHT8rZKXFlp
 1+irFvvWneiHk00wNNm4KoawG80AEYw86e6wl38+7I5WXWd3tfuzOXy5L254rD40/P9RGdx45gh
 tXDDie7RAmNPTZzHNtfEto4PXEBtfy8eS3uTfk4/7nAmmGosReVEnVDCzSQpn4f4QM1meACItf3
 58NObF/ZDbeqc2JkkGg==
X-Proofpoint-ORIG-GUID: ktqxeg1lonruPYklWpG147Sq4jGuHUnN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIyNSBTYWx0ZWRfX2fHVvlPQ1bKl
 CI4RX8lG5TbuUE6sf7hjQ6fHSPIpOm2FPSrRDh5ataU36UzPoEDetpspynlpbvGdNk0yKaLZIKQ
 FL4y2/i1bfYL+QDY3kVeZZpwa001J2E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160225
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

On 9/16/2026 8:29 AM, Alex Bennée wrote:
> We want to keep configuring of the cross compiler within configure so
> it can be used by the firmware.
>

Would that be possible to add in command message that it disable effect
of those options for tcg-tests?

> This reverts commit 7e1d54da6faf10e1fc70f6b3d8247068b80b1597.
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - declare empty container_command/use_containers to avoid unref var
> ---
>  configure             | 31 ++++++++-------
>  meson_options.txt     | 89 -------------------------------------------
>  tests/tcg/meson.build | 31 +++------------
>  3 files changed, 23 insertions(+), 128 deletions(-)
> 

For the rest,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

