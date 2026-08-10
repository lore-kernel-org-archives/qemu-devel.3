Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BFAC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 23:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtZiV-0005ja-QR; Mon, 10 Aug 2026 19:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtZiU-0005jS-QL
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 19:47:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtZiT-0005gQ-5S
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 19:47:38 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMqMbQ2937767
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9lu7aBNgzqbkoYJ9WUEyRLndkJupXNq812839auCbV4=; b=DkVkErrk/Yn/IK/A
 1QxfaYl/E2sJH5+yG9T7D4MPJYd2IlTqGieBTABDokP2jfUiSJ8iH+YMqYUGu54L
 tWkFlxnl0LtmSHHFFSGrB/pqQJiayUxWN9AXmFVgCh2jbHfQ984RNCjb8jMjX7G+
 xlb4hXSHlMdyn1ETbA7+TRE+/Pu/8sO+ODsnogKftRnPq/ysNOyYS5Y3X1TLp1eM
 LZJDUq/w/WeMjVZrKB7GwUZj1XLbkdc4wadxsjth8hJQ+KCa7fzNXtpnHN2eCUFb
 0UluTlMUN5RRjdghntECURVBWXZDLuarhpqwR1rrB0Ijm7c8n0HA1M9DsDswDNUK
 8jtDUA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjv1haa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:47:34 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84e048a801dso3594354b3a.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 16:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786405653; x=1787010453; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9lu7aBNgzqbkoYJ9WUEyRLndkJupXNq812839auCbV4=;
 b=Jv3WPnpLq+W0Z/VnSE+mIWgtBPQ4CHTBT6737cJ5UIpjWRLSkmSVvPjLXMJdFvMKdX
 mvx0iyWxkocL0X9xKywxZNQJ2U5V0Bwg+B1MuPL6syekyJ2FhQsV3oaWiDzn+20vZog9
 VTLLZ2QcFfPRsx+PGPnZdclpCcgmMEwj+TCiG6xG7bvnZPFafV76Ph6Y9yqT+od5Jsfx
 kh9U08NDl/ekrN2+KtyKbsPBWXdbSZdFne6i8YOPCj58qH0HlBqCCF18f0A6c11NEDuL
 YpSwdXxytYjr2DKkQY7yiFkGveKwCiYwiLfEYhFv3RKTe/KwckAy8/QUzq6vzMQpHgpW
 bK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786405653; x=1787010453;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9lu7aBNgzqbkoYJ9WUEyRLndkJupXNq812839auCbV4=;
 b=THiUBbDXCNlIWCXlSNHpDoqZzSsRLAJOtuJQfoyBzHomqhe2mPrD17O6pL0jLhuLdv
 TeusyRdlsNbvEx8VQWA/8SzehdjuIntRMfcCjfskGrchMZqhHAlpS+FqfW6oVeeZUQqa
 XNS3sYxLP7OqHCSZOp+IKL2WUnL+2pYYhnfvyrah7WkQk191BILjWt97gKv9h+YcUhEp
 rVvAw2WrmlJoY2Fnw+MvlVcH+xAaDIkEnTvx7mGTWh7PPmR5g9u10Qw1VSmBGldH6d6s
 gbRtRTUjj+WudUtxJnF+ETenlPofFE5vb3Fs6AOuPBOJZzOhJoI6d811sUl02nuufQxz
 vQjw==
X-Gm-Message-State: AOJu0YzCeXxlFY9/UDTSoAHsa4Sl4QegX4UDvuJqrhCP3HTTtqDykMga
 37yoUP2rbGmjRIzWedmHPmrZgtw5paBQJP9sM1BGHiyIr+HHDQDhvZhq6C3T0l6TeQdS2jSEFAF
 C9HIPqDGO0AvW570vQheC6gRpWdVKdnY1NCUJqvDehV1r15vX8Bt+V5kFfA==
X-Gm-Gg: AR+sD13Vuc89z1VQHBrkd5SmlVEpNikpQHv7naF117wNeBztaTFQTsZy/hq7NiQPHVm
 VLtztxgxbLY6wyYHjuVSIr01cYDvCf32En9BNz08Ko1ljz3bER8utWw1ilJIjyuMtCMINwfEBE1
 bpDDtAXAvWT41YTvvSYFZPr3zkrKRTlqr+TDPv8DjJmlN+qxsmsQb4QU7mtUh1UvJcC74qd0Ku3
 INEx9nbmBY0ShQko6oyXTaWpRBBu6vgIL+e3qZZ3/jdxauC9Oo9YsfZjfzxYCGy93MjxDQ812g8
 u0BBX9t44+lDrzMtvg5fqvjAIIGhla5DpTv5MRT2ovnU8mTCOVeANWx8jusg/rNTbelZB0m7Yv2
 dunUroW1UUvB4bNJlFecePjcs0mHPS8cmvC2QeoCeJsjeejvO+/DK3SY=
X-Received: by 2002:a05:6a00:6c84:b0:847:982e:cca0 with SMTP id
 d2e1a72fcca58-84f9c9658e7mr5910865b3a.19.1786405653545; 
 Mon, 10 Aug 2026 16:47:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c84:b0:847:982e:cca0 with SMTP id
 d2e1a72fcca58-84f9c9658e7mr5910815b3a.19.1786405653067; 
 Mon, 10 Aug 2026 16:47:33 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a3d4024sm4452951b3a.24.2026.08.10.16.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 16:47:32 -0700 (PDT)
Message-ID: <6b3c2aee-9599-41f0-969b-e71087f85de2@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 16:47:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 004/103] meson: bump minimal version to 1.6.0
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-5-pierrick.bouvier@oss.qualcomm.com>
 <87bjb93ad1.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87bjb93ad1.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDIwMiBTYWx0ZWRfX88mefSCjxiVO
 UpgvG38KJ3f4lJ/rzlqySvKAhQiBByIr4Urq8rL6zXiplv3zna5rB7UlkV0W9xzPWLRDO3SE1CX
 beGZfsXGADQCWWRiUHKLu0gXrg4WYeAUv6BqmZqFGxVcPMETHyrHYvvp6h/kqHA0nTJ3MJgE9rD
 XufsroTYSmlCPhGxTa27AFf8HM5GH7IIThccWOp+eTMF0BUH3PMC7ohZKyPY62sDyie5cS+Esfl
 YYoT1BVdPdJV/IVaKKBz+8lszlgW0X2rgHVJvdCOhjCrACsrUpYGlITXKgBrBznnT4Arzwix8Z9
 RfIPB0lQ96FZnsWTFSOykn1iKiyIdBcz23A4OElymGnjBCuViEhS2zKPBCv6LfSTEZy8k8oVcZS
 T0wViewInLsfRD/emOaX2K6EAol+YIG9iX0z3r0SD/6XMG4lVZa2Rzxtc5cmohTx244D1gB2WzV
 4mzol+fBai2xJr/72iA==
X-Proofpoint-ORIG-GUID: S1AR81evf2zUnFKGn9wlc7jpkzndCUzr
X-Authority-Analysis: v=2.4 cv=KLtqylFo c=1 sm=1 tr=0 ts=6a7a6316 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=11Uqm9eB3zqumQh0m2cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: S1AR81evf2zUnFKGn9wlc7jpkzndCUzr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDIwMiBTYWx0ZWRfXxU9wdxOB1MOU
 /fs6xWi5l5/y99xS4OhtmvnMD1JofpRs9/62zOKbHybQbk88i2PBDM+vOYvkQ9WSiPoME38vjxr
 wFKRshTsKHYJa/NKALcGKRHfrNMkR2s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100202
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

On 8/10/26 2:59 PM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> Without it, we'll get the following warning:
>> WARNING: Project specifies a minimum meson_version '>=1.5.0' but uses features which were added in newer versions:
>>   * 1.6.0: {'test with external_program in args'}
>>
>> Which we require because of how we build iteratively our test command
>> line.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   meson.build                                                   | 4 ++--
>>   pythondeps.toml                                               | 2 +-
>>   subprojects/packagefiles/anyhow-1-rs/meson.build              | 2 +-
>>   subprojects/packagefiles/arbitrary-int-1-rs/meson.build       | 2 +-
>>   subprojects/packagefiles/attrs-0.2-rs/meson.build             | 2 +-
>>   subprojects/packagefiles/bilge-0.2-rs/meson.build             | 2 +-
>>   subprojects/packagefiles/bilge-impl-0.2-rs/meson.build        | 2 +-
>>   subprojects/packagefiles/either-1-rs/meson.build              | 2 +-
>>   subprojects/packagefiles/foreign-0.3-rs/meson.build           | 2 +-
>>   subprojects/packagefiles/glib-sys-0.21-rs/meson.build         | 2 +-
>>   subprojects/packagefiles/itertools-0.11-rs/meson.build        | 2 +-
>>   subprojects/packagefiles/libc-0.2-rs/meson.build              | 2 +-
>>   subprojects/packagefiles/probe-0.5-rs/meson.build             | 2 +-
>>   subprojects/packagefiles/proc-macro-error-1-rs/meson.build    | 2 +-
>>   .../packagefiles/proc-macro-error-attr-1-rs/meson.build       | 2 +-
>>   subprojects/packagefiles/proc-macro2-1-rs/meson.build         | 2 +-
>>   subprojects/packagefiles/quote-1-rs/meson.build               | 2 +-
>>   subprojects/packagefiles/syn-2-rs/meson.build                 | 2 +-
>>   subprojects/packagefiles/unicode-ident-1-rs/meson.build       | 2 +-
>>   19 files changed, 20 insertions(+), 20 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 49a5baf5b52..d59c86ab2bc 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1,4 +1,4 @@
>> -project('qemu', ['c'], meson_version: '>=1.5.0',
>> +project('qemu', ['c'], meson_version: '>=1.6.0',
>>           default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
>>                             'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'] +
>>   
>> @@ -1385,7 +1385,7 @@ if not get_option('zstd').auto() or have_block
>>   endif
>>   qpl = not_found
>>   if not get_option('qpl').auto() or have_system
>> -  qpl = dependency('qpl', version: '>=1.5.0',
>> +  qpl = dependency('qpl', version: '>=1.6.0',
>>                       required: get_option('qpl'),
>>                       method: 'pkg-config')
> 
> How is this a meson dependency?
>

Good catch, definitely a mistake replacing 1.5.0 in this file.
I'll remove this chunk.

Thanks,
Pierrick

