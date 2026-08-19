Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102D8C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwh7I-00072F-Np; Wed, 19 Aug 2026 10:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwh7G-00071q-4H
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:18:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwh7E-0007yL-Fp
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:18:05 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JDLn3j399414
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B5cQKGFNx7Thsjl/O6o/yq3sBbxMF5l+pp4tRDtqmr0=; b=AkXMYwjl7CxneWXS
 H3lpClXP16f/bNQpA+9I8HhY5e/LE6JSc/R/TgGRUZ55y6JRiMecOjXRNwBp+Kaf
 JtnnKpHOcjFffnp4h3tYkMAMwi782RzsISTS9K2m4b9J5p9Yhq6HscSiy0uNO2yT
 YhHVDQ8R0lJwKhmptIkhSY059qZ2Oq5bSZS7ggSxM7aCf5OAAGmHUquvPVlmeiDP
 XV6/ncNllDNMYTQyfo4gEDthu5ksiNVAw4FShbmjYTwSJY+fyq2fKiGDdNcy+n1o
 +MrjzUzQsksMgho/eWc+UWAQFj4KkLly/x+zkAwfIKpSji0i4VZJgZIGOy+TQruu
 cxP5ow==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5daa08k3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:18:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so21798805ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787149081; x=1787753881; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B5cQKGFNx7Thsjl/O6o/yq3sBbxMF5l+pp4tRDtqmr0=;
 b=R97Gdm4irOxe3oj/YqRD9jtxTr/kXWxP8a7EI76JDATF6U1LEsMtrqEDw21lXOj/Kp
 aokdArHRJRBdI63hZcUnVSlJyMAjU6TwEfA7QwVsSqDebZwMIWmzlwJJGvIwyS2175xF
 JKDAzwvcYN716XLAw/pC0I9pEFnNVPvbb/ChNkjcWuEoIaC0s6Uu/ffxHJGCzLdfR9oU
 Nvo1V/TuRxqR1K3EGi+W7m0Ww23wotFgRM+FMdn9A+nSBkrCv9Lp6MhHLx8d15+CNbmb
 ReAlYt0oid+ZZjuiq1XqhSR7PsJfgwmAfhLSyDQW7QM1TT18RMihi6jVbcrfu0Pd0fpN
 D/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787149081; x=1787753881;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B5cQKGFNx7Thsjl/O6o/yq3sBbxMF5l+pp4tRDtqmr0=;
 b=peuAV4gI6zGkkSuErhvO4czAQjg2VA4Nw6CTG9VvEBKl/zAB/jUNlHJmwtXvFGlp9y
 cdPVSO1YxHd3BhKIbidUp3wPBCwRmCRCX1EL6kX5Chr4X5dhu7UO0LKvAWNdUXe9ES6U
 ECsO76iXO30cMd1Cbdzwfu6WoTFLexdlSuEVlKi/b+/GLZ6I/4ql1Su5OxWkDcCic8EA
 Kct32sj+qDjfX9Bc/dUiXYoi9gfwFbQiC1LvPWQ/BUCxkBuGRhmTYPbTCj49V3oaq3w4
 SzVQZbXn6SlQvH68tVPmnmruxAfYHk5yWxYno0PHeJt9vIV4RF7YjdRHetD6Hbx1QNj7
 +o+w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7VvkaAHhY0wDq4XXcavLQ1/8Ck/Iqfs2T+FAj527Cu7824PYTVY3K5+hvP9+sv8ePYKm3yz/JM2wI@nongnu.org
X-Gm-Message-State: AFuF++n6C1NoMXTNiT9XvVENCAEGqkcNqZ4d2Syy6e35CLEpv/UakhVE
 aU40fiviA1d0EaeEtzM5S2Ivy4TgJavWfHkZalP/BwsYCsUkdTM64/4U6858Qmi7aMtH0fp9cwf
 jYnmI6Xtmchp0X9YTz3IQNjTHcHaf1NxOzPF2oKp71sW4pftjJkRo0w3l6g==
X-Gm-Gg: AR+sD10/bB+Rki+MlsgNCt3doc7B2lAudMR8huTfBEPll1/mehC2Yr3zQgY9yhzinHZ
 69KYnhvFuPXF4HxU7yYHxDizQqs7qg+Kd/c9hQX8Bj3jOmepeacVDss7XfjI4MXqYEIEk9Hm4uQ
 qQaBXWNA0lIREU7Wuu1ySKpQPPMKomdo4nlUJi4vyIFnmbZxcZaq6azv8aZEJ3TbXQ5QcU+CH1j
 M+MZjYRRr7o3y1Uxib4WhRQlA1qWuUnRRGXJE2iOdjm1WnsYlWQmbJ0qpeUp6a6gxOU/0H+bGMb
 TaEX5bL/z1R9BOWYD69BDFUJUnXKbNQPRwA4R3PEqQF/4pDYOgYxb/HdaUWFPYs+SmGiXL0dSCM
 udGxaLAipV+HW6IGoP3y03rNE/cYZClxdC0SGVrv5PufFoyTSe08uNzk=
X-Received: by 2002:a17:903:2311:b0:2d3:716e:e2ae with SMTP id
 d9443c01a7336-2d5fd62c4b2mr90975565ad.6.1787149080603; 
 Wed, 19 Aug 2026 07:18:00 -0700 (PDT)
X-Received: by 2002:a17:903:2311:b0:2d3:716e:e2ae with SMTP id
 d9443c01a7336-2d5fd62c4b2mr90974375ad.6.1787149080043; 
 Wed, 19 Aug 2026 07:18:00 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5bb499e07sm27988865ad.15.2026.08.19.07.17.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 07:17:59 -0700 (PDT)
Message-ID: <f885071f-95f8-446e-819d-7dcb7f161d96@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 07:17:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 000/104] tests/tcg: run tests with meson
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <5e603ff8-b885-4f86-922d-6e2ee93fdef2@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5e603ff8-b885-4f86-922d-6e2ee93fdef2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fv3sol4f c=1 sm=1 tr=0 ts=6a85bb19 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=EG0GylOBU9okRF1S-IMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iKmKpKKOA0nYYhlIkmieqrcLQhL0B-1E
X-Proofpoint-ORIG-GUID: iKmKpKKOA0nYYhlIkmieqrcLQhL0B-1E
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExMSBTYWx0ZWRfXxlCZWGR6hlOV
 c6eIAqEeBRSpQt2ViPhA5VHwqVM2lGXLEoT/sGzgm9jdpJUe6PxXONzcr2T65ulAayZ9xaGZ7Hv
 Gu3ItymEW7ENsdD8uRcjF0ngXXVm+ug=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExMSBTYWx0ZWRfX0eqoHudkD45O
 Kw2w+K1SXDaDdqqsWEXL4puGVm7ijHR0NFXomNe/SPdq39BOWmaltPAxPe5/3F4xwicuWEJps/L
 3o5P/bjrJuvM1Q3Dn9vgrnevZg73Uuxe/uV5nT4WERNT1fHGi/NdtusRDzfzbRfy3akBSbtEAnF
 6dfDogjIQLRnYurfuRCD9SmRr2A4lNj/zV/vtFrv5JhJpitUGhgz0FrsdjRJFqvpAAikKNtkZc0
 IVzOloYOTLaO/GW7JUM6AvFETXee2qiS0JGerwaBVam72hBTSOcrPIfh+W55JJmBVaiICfPiB8p
 vPyJ8IHU4gjKSVCGYS79YnCzJSsPdc0oOC4EJQyrSel92aGeVZd2PGIXowsgvSwIDc7kQi9kJ9F
 ihah46LJtv+ezb4reoDSjTHWIw+DOb0q5V2Srn9AblfYaJqa4LqVJcw/hncvUT+mr2v/8RSpBKD
 Yz5p5zu0/bZ2rcKC5Lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190111
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

On 8/19/26 4:23 AM, Philippe Mathieu-Daudé wrote:
> On 18/8/26 21:21, Pierrick Bouvier wrote:
>> This series replaces TCG tests makefiles with meson, with the
>> goal of having something more readable and maintainable in the long term.
>> Also it closes the gap that tcg tests had with the rest of tests, by integrating
> 
> 
>>    configure                                     | 530 +---------
>>    docs/devel/build-system.rst                   |   4 +-
>>    docs/devel/testing/main.rst                   |  35 +-
>>    meson.build                                   |  21 +-
>>    meson_options.txt                             |  95 +-
>>    plugins/api.c                                 |   2 +
>>    pythondeps.toml                               |   2 +-
> ...>   tests/tcg/Makefile.target                     | 281 -----
>>    tests/tcg/test_cc.c                           |   9 +
>>    159 files changed, 30852 insertions(+), 3924 deletions(-)
> This is a massive rewrite of TCG test harness. Markus noted on current
> /master there are no maintainer:
> 
> $ ./scripts/get_maintainer.pl -f tests/tcg/
> get_maintainer.pl: No maintainers found, printing recent contributors.
> get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> (commit_signer:62/99=63%, gitlab:@pierrick.bouvier)
> Richard Henderson <richard.henderson@linaro.org>
> (commit_signer:34/99=34%, gitlab:@rth7680)
> 
> Still before this rewrite you are the first one listed.
> Just saying, you are a good candidate ;)

I can help on this if Alex is ok with it!

