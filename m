Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2081CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXl0I-0001vT-Ut; Thu, 11 Jun 2026 15:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXl0H-0001ul-B4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:23:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXl0F-0003Au-MT
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:23:49 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BJEBHS1400710
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 19:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 60jDMnGtWGLcdzOG3GSmfEmet+r0TOwibA8TTaUTlp4=; b=i4tg7gKpS9UmmInd
 b4POASWl1MUpX1ajv9FrdDPHxVTHq1logd0lJrJI0yOe8OZClgB4GbcYLUWYQmXx
 4nY+A5OU3kDm0yYIIHf+9eQ6v7TCXzgy4TPLALqdDjgMQcBpCKIwOKj1YAexxsjB
 4mZQAAsGd3kLddjTbzLWErXu420oed5If+hEuAaY6yl2sEVI3YRvrZNMr9JQD19u
 1wZB5936T6temhaReHdq6O6sqL7U288RuJtbQRbOnZjZqyqp+1VkuoYZd7PtLeYm
 G9lU2pT/Qe0XxTKqLula18ltzYAwAjwBDjNqSzskkyG/wUwjGrAI9ZNMskrA13ot
 DXxoaQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er30g81cw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 19:23:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8596e4272aso134659a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781205823; x=1781810623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=60jDMnGtWGLcdzOG3GSmfEmet+r0TOwibA8TTaUTlp4=;
 b=OQXs529T83Xepyyt0R+Lt4xbLLiH69SniF2Vp9z51DqctVEd0jAv1WiUUYLk4BYCIj
 AHKcuuRS+esdMQwdE7F8YpPgNvWHf2Ghg8zqfVvCPeu0ncMGECGQWNbb/RHkYljFHg1N
 8IOAZzWseTi8VgSCHp7GESQ1a2xTKZKPllQZ1bOjtXX93CHHWEVFP0uXxCh5uT33vxh6
 sYb1lZfF9aYbB/gEHWIINMZDmMnZNh5iuTqCoY2PJL9H7+Szr4XpWplcS5Y1Z9eJ5a4l
 jQqy5fuHInbdGpMP3o8q97fG+u63BXPQd/9gknvEWucf0A7lKZBoRYM6eCQJ/ehg90gx
 8X+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781205823; x=1781810623;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=60jDMnGtWGLcdzOG3GSmfEmet+r0TOwibA8TTaUTlp4=;
 b=NFkxPXoJxXNwYEIeFC8FEYF8xfuScF05skjMEQB8IeFXtflkWV5Qx1PrlT9VVh92a3
 3ifdwOo7GUmyK8YjiYV0Wpx1JN1lyuXifMC71g/stkedbGY9ceXbfgoFM+MVb7c63+PF
 yRRNx3miS5F0DOI63vLRKrMZSMgZooNvPm9NFrFbABlPI82wBgJRDwlyfOdEgAyRQQfD
 RlFfDw3Zu1iNO4mz+5HOuE77GKurQEk7UeyeuQwLIAawDd4cmzp9MOhtKaALwEARnLX7
 7Bnzp0JDz3H3rM2uvuBBtGnshhOBGWSvTLYwaPe/po8aLuiQv0IRDQuDeEYlojNGBr8t
 SarQ==
X-Gm-Message-State: AOJu0YxfpUPD4s2iP7+WbsGPR7b6aX+BCScljW4Xn2DQRraiZUWQbj9/
 cqRsUwBf4DYai5XRY7ZdtuEiPRRZD6mWHMjmYWprfRUIjIzzL6tH79KtkgTLXNkv6Hk5zvY4+7I
 pZy9WmyQF1tG3N4iqI6gBqGMp5EqgNW+9F3EzkKI5E4jOvMpiaLtYRuThyA==
X-Gm-Gg: Acq92OG+WyAZAJm4n2H2h0dYwZpAcWuN+HOs5YsfBUTNj4H56dEank1Y8I2YCdYwMzV
 bZ+0/QAfUNlsrIhaNfgaYlylMNI49hvLXL9BRFcvh8PBsL1rU/82Iy6IGbDX/utgZfNeCetlKd0
 Q4PmEkbJN5AnsDcN6S9SAsgFJmZs5hqPiG0gIQQoZn9ub8yu94SHVNdzwF3p0LxxV4BeopxBfP6
 HSKy6U+otjAQeOp5RMz7YPk8MEOMiM5Dd8+4cSShkkhoNFHOA4hoPjsrcbxN1fwPaVZvCd+QxCZ
 blsby1ChACuAi5NpwKts1ZM/YEMVJIobO1J6dKnp7aS+8Ry9yNuY7zOSilyelwbcLQ9E4aFde8o
 /ROXOtbNy6Fw9ed4mQWC4aR82xYrh9rDuZpy0/yWjjz9SSmLKMEiLcIfILh6mTSHkP23yG7opPq
 Lh5lmTpGMTMFCfzw==
X-Received: by 2002:a05:6a21:1519:b0:3aa:f9cb:d43a with SMTP id
 adf61e73a8af0-3b5e317308dmr4730015637.5.1781205823117; 
 Thu, 11 Jun 2026 12:23:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:1519:b0:3aa:f9cb:d43a with SMTP id
 adf61e73a8af0-3b5e317308dmr4729982637.5.1781205822679; 
 Thu, 11 Jun 2026 12:23:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866325d1c8sm51295a12.9.2026.06.11.12.23.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 12:23:42 -0700 (PDT)
Message-ID: <49ef4614-1d8d-44c7-bdbf-485d971be02c@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 12:23:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] tests/tcg: run tests with meson
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <0a0a1116-a5f3-45f2-b079-f66e6b17f672@redhat.com>
 <c5945f76-ae18-4a8c-ae58-d22be7a7f6bd@oss.qualcomm.com>
 <CABgObfYy48HzQmJTJ4r_dswGjmgMkeuy=1OiY_VbEupC1UX6ww@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CABgObfYy48HzQmJTJ4r_dswGjmgMkeuy=1OiY_VbEupC1UX6ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE5NSBTYWx0ZWRfX9uX29VMAIfeB
 QuyDU2MhKbgaf+a9CNTzRQJToK6LuEp6QaJMlahyjqiEHDIOwYbFFpQpygFfo0cngEfEa20d4gz
 CiV4KMojWfZwqUd51DvLKoMzeSB/B4o=
X-Proofpoint-GUID: tlVdc5dwKiNALPivx1DD8TBYR0aGqVUN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE5NSBTYWx0ZWRfXy+/nMYcQD9c0
 2d1FnG8opNudbSIvklcNpmU5fUzf1oHvaiqwTiPMnvcO3Sch7T4cYo5O+Y4sO17EnSUsA9tcY5x
 pnsgk/5hqCpA3txPnbRuyNgiiJKno/GAGxQqCRPb6H5Rzb86RLJhlp1plQIijE3h2t3UsEx68s2
 XfnCmmVAgOE0OicIHNnGV7Ct9hOYWHLTOECNeXT/0Se1c4QbRhKoLMwnnxC5dTJ0dRjW6JhtxuR
 j9dDfh0q2A812rr+vKvrsBQ5A+nO/tItTvDy3KI8O10M49a8MZ+tdFQoh3chDmNAkmmQBOdNl9+
 TVR0pOoiK+ThegHO/bzuytgMxTGsMbu4nidNBNVeD81AZ9sYnhSEr4DLlZiCa50/D/u8B2Jl93Q
 veyMfrsyPZ4wQ4+evARzQI8A5j+nBozNZdu5wzwQkhQbwz0k9/tIlMioLtrW9/SW/aksbQMBE8h
 ipGSe5p6gXUNupyjDWw==
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a2b0b40 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VI0ZA3KHNYDXwnx6_70A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: tlVdc5dwKiNALPivx1DD8TBYR0aGqVUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110195
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/11/2026 7:49 AM, Paolo Bonzini wrote:
> On Wed, Jun 10, 2026 at 7:01 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> Your idea is to have one project per target, and use meson cross compile
>> support for this?
> 
> Yes, that was the idea.
> 
>> `make check-tcg-aarch64-softmu` is supported out of the box with this
>> series, without having to write a single line of Makefile. You can still
>> do what you like: see cover letter usage, to run a suite or a single test.
>> I don't see rewriting the cc_feat part in meson directly as a problem to
>> be honest. Not all architectures needs to check specific feat (only
>> aarch64, arm, i386, ppc64 and s390x).
>>
>> Also, calling:
>>   supported = run_command[cc, check_cflags, flags].returncode() == 0
>> vs
>>   cc.get_supported_arguments(flags)
>> is not really much more complex IMHO, and not a huge reinvention.
>>
>> Also, the custom target is hidden inside tcg/tests/meson.build and not
>> exposed to arch files. Even if we had multiple projects, I would stick
>> to not exposing test() and executable() in arch files.
> 
> Fair enough.
> 
>> I would expect this file to disappear completely, and to rely on make
>> check-tcg-arch-* targets at top level instead. Would that work for you?
> 
> Yeah, you're right that at this point TCG tests are the last
> stragglers in that file. That tilts the balance for me, it does make
> sense to do this with custom_target() until Meson grows support for
> something like multi-machine projects. Just please add an alias_target
> 'build-tcg-tests-...' for compatibility with tests/Makefile.include.
>

Sure, that's a good idea.
I was wondering as well if we should build those tests by default (as
part of 'all' target). We should do this only if cross compiler is not
using any container, to avoid triggering a confusing container build.
Any opinion?

> Paolo
> 


