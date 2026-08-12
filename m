Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91321C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuF4f-0001tr-5k; Wed, 12 Aug 2026 15:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuF4X-0001t0-HP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 15:57:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuF4T-0003Bd-82
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 15:57:09 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CI8hEv1497879
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 19:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fv+kAwflSXSkrS9U55qfVWawE0Xdp3zPoe4TFD7XcQg=; b=bcyPW2pSlQpsoKXq
 /0/kzGY7zpZIZbjLuVPR2rsNVXsV9dgUOogktijV0wMVLGqvkhPJoTykAd28Ufiu
 0W2fJz33ICFfaSjcHspWnj+/6U3gMMoxkqy0LkzOZoJ9svNaj5OGgctKqhJVmrZh
 seH2S0+ODrwjUgNGmPqRPSdFjBkBW+ozrB45WvHHBczF1y+ILLlE1wSY727ORsFk
 ZrxTSq09xl+3kgMN1R1iUCpJm5RofcDANQFpIs9qty9XxYwffKlSPBaqyCA5As5z
 qmTaDRtdBLA2Bp+BajXKMdxLI/C/5KvTU+iNcQOlMjAm1CRG3zYXX4G/vR7n/Gu2
 gnFUDQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nutawen-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 19:56:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38f0fe57470so301774a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786564619; x=1787169419; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fv+kAwflSXSkrS9U55qfVWawE0Xdp3zPoe4TFD7XcQg=;
 b=dPV45eAVohwAaqM/jS8iymMjhor6U1XatKUXx7ybL/libsvpEcCPunKPp49nfKx0sT
 mKS2qIMtLAs63WPRpwNqRl51XyIlwHIyvhRQdppNmkqYh0kltvXw060+6+7bP/o1Tozx
 W2ViDq7diP4Bk/WbqzC75hWKIYGC591W0mKHd0Yls4zsSJf2dXSDajDkqWWjViNiiz5P
 duy9NS890kIMcpIAP7fOW3bKOeJeetKE9nFYYRsl01XSeUQFyDjOmQuVEEth6bVRIlhU
 pzKV5LvmGB9KQSJwdnXedmwY2EhwRSeEwNWgihr726IsEJDVmc9/5wyyc/3VRKXUV6j5
 wN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786564619; x=1787169419;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fv+kAwflSXSkrS9U55qfVWawE0Xdp3zPoe4TFD7XcQg=;
 b=j/E2h0OJjhxSSmEtVpvSBBV0O1vM5Awgys7x5N+IZOw7dCOFJQ7qWDv1H9Kc25gTgn
 qGbFnFFnUyg/NuzIMikPdPyr4egxPEnLB8XLA9pqfw1Af/z546PD0JbxNb7fbzWZf2ka
 QXVeDcsrA9aGIikmUlJnr2BH1pX/Q7dEPcsnoUWekXgzU02ZCMQq6CRYjxk9p5VDBjhl
 EXfUMZ6cskFqibAVbIcibYjw4lSS8G2kjg5H6sKgoGuWvfwHGdxOyLH/i4s5x1oqfdFM
 886vdhSbDkq5BsGc735jk3m8bsUjxR7LGu1GHizzeQKIZwsdH6YCVvX7h5e4AuOLDsoF
 PN3Q==
X-Gm-Message-State: AOJu0YyrtjyxfM/wCbsldO64KIQLRDejuylVN7kyHW2K/BzlWQpoktWn
 mXv1zX5iiagiNniHYMajUTsxaHRnHXfMgHPYjpdtLVsKawXmjerHdgsKnSaX71o2XKkj4BhkQbj
 j0Ct25zzbYDJNAqWVdQKNbhZ4ILSlXLcDdIoYfiiaYec8+3y0zf/7Ftmyqw==
X-Gm-Gg: AR+sD1113uUuAo90R5cbvvefmO8XUMzuYPrmPi27f8bnaFWte7FQle+GCKPrG2bfYgu
 SB4QgOTsCCpj6nsQ6Dcnkc1lUKU3he2uhNCU5JWwGix0DfSWJqVgcQnoIrcu1qA/xFEZolDqp50
 qJ9h6rofsncCMV3ju7D6q7LaCTpTtFQ/OdwfhDth1+58Byq9eDTRJ/zaVFWahWaSQ4AVzrG8v+W
 uYlOFMVnDupCaDSrND5Kyc9tjXX62Ww05H2pYBD+u7vAuV0VuDfvlY67HMA/xqONfrKQze3TavR
 1jbViZgwnRUKpknfOfigIlFYlzJwy93+0gFwxFX5RbsQiNK+Xmqp1cCBcX4iQpvd9gZoZ2YKCRq
 JYUS12HdrPvUEjN5yhwUwbvtneENZ1ooPHPHV2UMcCDryUpCBSj2W8MkqpaZxRj9NhJ8b
X-Received: by 2002:a17:90b:4ec5:b0:38f:657:6823 with SMTP id
 98e67ed59e1d1-3931f8c2d46mr23621a91.8.1786564618611; 
 Wed, 12 Aug 2026 12:56:58 -0700 (PDT)
X-Received: by 2002:a17:90b:4ec5:b0:38f:657:6823 with SMTP id
 98e67ed59e1d1-3931f8c2d46mr23587a91.8.1786564617965; 
 Wed, 12 Aug 2026 12:56:57 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f26c9c3sm160631a91.2.2026.08.12.12.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 12:56:57 -0700 (PDT)
Message-ID: <aa3a7a63-d1e3-4b50-910c-8b2597780e50@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 12:56:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 100/103] tests/tcg/meson.build: implement ./configure
 -cross-cc-* options
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
 <20260728044248.137626-101-pierrick.bouvier@oss.qualcomm.com>
 <87v79fzfqb.fsf@draig.linaro.org> <8733wjz5pg.fsf@draig.linaro.org>
 <8da0e719-fda6-4edd-b436-458c0d4f3d39@oss.qualcomm.com>
 <87ldabxh8l.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87ldabxh8l.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2MCBTYWx0ZWRfX9erG+HbxdcBg
 u10Fos9+loV4mzwb2CgYkbwgeTCNBvxSrAk9Odq6fHM+Nyx9FGWPdCGWozpVyiVq2lnSuQcnFaJ
 mRGQ5wjpBaM5f2xCzzhwCY8GLB0z7mE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2MCBTYWx0ZWRfXwdr9sicnk24p
 mElZkMdR/nhYRctsFhs2eGPmps4UZfr+DnZXB0sG/pe3HxAQI3CcmxefFs6ynH/BfgWRXNVb19i
 8NwmyeduwL5qcyJrObGchceIO/LnXfHCJLJyW5I2Dvd5SLpBBMDP5KUUKuIPfE5NqPHMx8ZF2+0
 Kp3T8TZ22WNHKfvbOvKYiDRLitrpjeaLv1w6k+SmQhoG2Ykv9aQyP4TeEU1cmXmb81mNrZHyIRe
 I8mE6njwX3iAORVNCur4jA38yNJ5xUEhWCgmYERZLgQJeS58QVAYIgPqMhJKm4PKYRfn1fRKMOA
 0BAZ00MSrJfwdzt/NVQKoxr1c3FHHuMK2na0YPjtWjiYgf/1dqsDNbcISJNjAp4nuuerfEF/P6V
 WJTkzy8Sot0e2xJqTr6PWvs7FGWrpfwxj64hRzO5gdiqdPxWRLlD3EXG9eVVFxsHYE3qoFfMnL+
 5cnB+uX4c4gzRj/mFYQ==
X-Proofpoint-ORIG-GUID: OnGCFlBu2U-dTZaEtoZq-o8xjvu2T3pm
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a7cd00b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=H3BSfdpvyRiUHRZMpUUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: OnGCFlBu2U-dTZaEtoZq-o8xjvu2T3pm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120160
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

On 8/12/2026 12:37 PM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 8/12/2026 9:03 AM, Alex Bennée wrote:
>>> Alex Bennée <alex.bennee@linaro.org> writes:
>>>
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> When a user set explicit cross cc, we ensure it's available and working.
>>>>> When a user set explicit cross cflags, we ensure they work with default
>>>>> or overriden cross_cc.
>>>>>
>>>>> Made the first implementation with a single meson option (array), which
>>>>> proved to be absolutely unreadable.
>>>>> By having one option per target, we directly detect issue at configure
>>>>> time, either for user, or when iterating on all our targets. This
>>>>> ensures user can't mispell any target name, and that we can't forget any
>>>>> new one in the future.
>>>>> Also, it shows them in the configuration summary, which is a bonus.
>>>>>
>>>>> Since we now only need to know compiler to write tcg tests, we can
>>>>> simply alias -cross-prefix-* options to compiler override.
>>>>>
>>>>> Examples
>>>>> --------
>>>>>
>>>>> wrong architecture:
>>>>> $ ./configure --cross-cc-bad='cc'
>>>>> ../meson.build:1:0: ERROR: Unknown option: "tcg_tests_cross_cc_bad"
>>>>>
>>>>> wrong option:
>>>>> $ ./configure --cross-cc-cflags-aarch64='-bad-option'
>>>>> ../tests/tcg/meson.build:228:10: ERROR: Command `/usr/bin/aarch64-linux-gnu-gcc /home/pbouvier/.work/qemu/tests/tcg/test_cc.c -bad-option -static -nostdlib -r -o /dev/null` failed with status 1.
>>>>> A full log can be found at /qemu/build/meson-logs/meson-log.txt
>>>>>
>>>>> cross compile with clang (fails at the moment, since some tests have
>>>>> compilation errors with it):
>>>>> $ ./configure --target-list=aarch64-linux-user --cross-cc-aarch64='clang' --cross-cc-cflags-aarch64='-target aarch64-linux-gnu'
>>>>>   User defined options
>>>>>   ...
>>>>>     tcg_tests_cross_cc_aarch64      : clang
>>>>>     tcg_tests_cross_cflags_aarch64  : -target aarch64-linux-gnu
>>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>> ---
>>>>>  configure             | 27 ++++++-------
>>>>>  meson_options.txt     | 89 +++++++++++++++++++++++++++++++++++++++++++
>>>>>  tests/tcg/meson.build | 30 ++++++++++++---
>>>>>  3 files changed, 126 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/configure b/configure
>>>>> index 568de41dadd..c9e2cdcce5f 100755
>>>>> --- a/configure
>>>>> +++ b/configure
>>>>> @@ -227,19 +227,6 @@ for opt do
>>>>>    ;;
>>>>>    --extra-ldflags=*) EXTRA_LDFLAGS="$EXTRA_LDFLAGS $optarg"
>>>>>    ;;
>>>>> -  --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
>>>>> -  ;;
>>>>> -  --cross-cc-cflags-*) cc_arch=${opt#--cross-cc-cflags-}; cc_arch=${cc_arch%%=*}
>>>>> -                      eval "cross_cc_cflags_${cc_arch}=\$optarg"
>>>>> -  ;;
>>>>> -  --cross-cc-*) cc_arch=${opt#--cross-cc-}; cc_arch=${cc_arch%%=*}
>>>>> -                eval "cross_cc_${cc_arch}=\$optarg"
>>>>> -  ;;
>>>>> -  --cross-prefix-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-prefix-FOO option"
>>>>> -  ;;
>>>>> -  --cross-prefix-*) cc_arch=${opt#--cross-prefix-}; cc_arch=${cc_arch%%=*}
>>>>> -                    eval "cross_prefix_${cc_arch}=\$optarg"
>>>>> -  ;;
>>>>>    --without-default-features) default_feature="no"
>>>>>    ;;
>>>>>    --wasm64-32bit-address-limit) wasm64_memory64="2"
>>>>> @@ -632,9 +619,19 @@ for opt do
>>>>>    ;;
>>>>>    --extra-ldflags=*)
>>>>>    ;;
>>>>> -  --cross-cc-*)
>>>>> +  --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
>>>>>    ;;
>>>>> -  --cross-prefix-*)
>>>>> +  --cross-cc-cflags-*) arch=${opt#--cross-cc-cflags-}; arch=${arch%%=*}
>>>>> +                       meson_option_add "-Dtcg_tests_cross_cflags_${arch}=${optarg}"
>>>>> +  ;;
>>>>> +  --cross-cc-*) arch=${opt#--cross-cc-}; arch=${arch%%=*}
>>>>> +                meson_option_add "-Dtcg_tests_cross_cc_${arch}=${optarg}"
>>>>> +  ;;
>>>>> +  --cross-prefix-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-prefix-FOO option"
>>>>> +  ;;
>>>>> +  # cross-prefix is just used as a syntactic sugar for -cross-cc.
>>>>> +  --cross-prefix-*) arch=${opt#--cross-prefix-}; arch=${arch%%=*}
>>>>> +                    meson_option_add "-Dtcg_tests_cross_cc_${arch}=${optarg}gcc"
>>>>>    ;;
>>>>>    --enable-docs) docs=enabled
>>>>>    ;;
>>>>> diff --git a/meson_options.txt b/meson_options.txt
>>>>> index 5e91969414a..fd9ff0df893 100644
>>>>> --- a/meson_options.txt
>>>>> +++ b/meson_options.txt
>>>>> @@ -389,3 +389,92 @@ option('containers', type: 'boolean', value: true,
>>>>>         description: 'use containers to cross compile tcg tests')
>>>>>  option('container_command', type: 'string',
>>>>>         description: 'command to build/run containers')
>>>>> +
>>>>> +option('tcg_tests_cross_cc_aarch64', type: 'string',
>>>>> +       description: 'cc for aarch64 tcg tests')
>>>>> +option('tcg_tests_cross_cflags_aarch64', type: 'string',
>>>>> +       description: 'cflags for aarch64 tcg tests')
>>>>> +option('tcg_tests_cross_cc_aarch64_be', type: 'string',
>>>>> +       description: 'cc for aarch64_be tcg tests')
>>>>> +option('tcg_tests_cross_cflags_aarch64_be', type: 'string',
>>>>> +       description: 'cflags for aarch64_be tcg tests')
>>>>> +option('tcg_tests_cross_cc_alpha', type: 'string',
>>>>> +       description: 'cc for alpha tcg tests')
>>>>> +option('tcg_tests_cross_cflags_alpha', type: 'string',
>>>>> +       description: 'cflags for alpha tcg tests')
>>>>> +option('tcg_tests_cross_cc_arm', type: 'string',
>>>>> +       description: 'cc for arm tcg tests')
>>>>> +option('tcg_tests_cross_cflags_arm', type: 'string',
>>>>> +       description: 'cflags for arm tcg tests')
>>>>> +option('tcg_tests_cross_cc_hexagon', type: 'string',
>>>>> +       description: 'cc for hexagon tcg tests')
>>>>> +option('tcg_tests_cross_cflags_hexagon', type: 'string',
>>>>> +       description: 'cflags for hexagon tcg tests')
>>>>> +option('tcg_tests_cross_cc_hppa', type: 'string',
>>>>> +       description: 'cc for hppa tcg tests')
>>>>> +option('tcg_tests_cross_cflags_hppa', type: 'string',
>>>>> +       description: 'cflags for hppa tcg tests')
>>>>> +option('tcg_tests_cross_cc_i386', type: 'string',
>>>>> +       description: 'cc for i386 tcg tests')
>>>>> +option('tcg_tests_cross_cflags_i386', type: 'string',
>>>>> +       description: 'cflags for i386 tcg tests')
>>>>> +option('tcg_tests_cross_cc_loongarch64', type: 'string',
>>>>> +       description: 'cc for loongarch64 tcg tests')
>>>>> +option('tcg_tests_cross_cflags_loongarch64', type: 'string',
>>>>> +       description: 'cflags for loongarch64 tcg tests')
>>>>> +option('tcg_tests_cross_cc_m68k', type: 'string',
>>>>> +       description: 'cc for m68k tcg tests')
>>>>> +option('tcg_tests_cross_cflags_m68k', type: 'string',
>>>>> +       description: 'cflags for m68k tcg tests')
>>>>> +option('tcg_tests_cross_cc_mips', type: 'string',
>>>>> +       description: 'cc for mips tcg tests')
>>>>> +option('tcg_tests_cross_cflags_mips', type: 'string',
>>>>> +       description: 'cflags for mips tcg tests')
>>>>> +option('tcg_tests_cross_cc_mips64', type: 'string',
>>>>> +       description: 'cc for mips64 tcg tests')
>>>>> +option('tcg_tests_cross_cflags_mips64', type: 'string',
>>>>> +       description: 'cflags for mips64 tcg tests')
>>>>> +option('tcg_tests_cross_cc_mips64el', type: 'string',
>>>>> +       description: 'cc for mips64el tcg tests')
>>>>> +option('tcg_tests_cross_cflags_mips64el', type: 'string',
>>>>> +       description: 'cflags for mips64el tcg tests')
>>>>> +option('tcg_tests_cross_cc_or1k', type: 'string',
>>>>> +       description: 'cc for or1k tcg tests')
>>>>> +option('tcg_tests_cross_cflags_or1k', type: 'string',
>>>>> +       description: 'cflags for or1k tcg tests')
>>>>> +option('tcg_tests_cross_cc_ppc64', type: 'string',
>>>>> +       description: 'cc for ppc64 tcg tests')
>>>>> +option('tcg_tests_cross_cflags_ppc64', type: 'string',
>>>>> +       description: 'cflags for ppc64 tcg tests')
>>>>> +option('tcg_tests_cross_cc_ppc64le', type: 'string',
>>>>> +       description: 'cc for ppc64le tcg tests')
>>>>> +option('tcg_tests_cross_cflags_ppc64le', type: 'string',
>>>>> +       description: 'cflags for ppc64le tcg tests')
>>>>> +option('tcg_tests_cross_cc_riscv64', type: 'string',
>>>>> +       description: 'cc for riscv64 tcg tests')
>>>>> +option('tcg_tests_cross_cflags_riscv64', type: 'string',
>>>>> +       description: 'cflags for riscv64 tcg tests')
>>>>> +option('tcg_tests_cross_cc_s390x', type: 'string',
>>>>> +       description: 'cc for s390x tcg tests')
>>>>> +option('tcg_tests_cross_cflags_s390x', type: 'string',
>>>>> +       description: 'cflags for s390x tcg tests')
>>>>> +option('tcg_tests_cross_cc_sh4', type: 'string',
>>>>> +       description: 'cc for sh4 tcg tests')
>>>>> +option('tcg_tests_cross_cflags_sh4', type: 'string',
>>>>> +       description: 'cflags for sh4 tcg tests')
>>>>> +option('tcg_tests_cross_cc_tricore', type: 'string',
>>>>> +       description: 'cc for tricore tcg tests')
>>>>> +option('tcg_tests_cross_cflags_tricore', type: 'string',
>>>>> +       description: 'cflags for tricore tcg tests')
>>>>> +option('tcg_tests_cross_cc_x86_64', type: 'string',
>>>>> +       description: 'cc for x86_64 tcg tests')
>>>>> +option('tcg_tests_cross_cflags_x86_64', type: 'string',
>>>>> +       description: 'cflags for x86_64 tcg tests')
>>>>> +option('tcg_tests_cross_cc_xtensa', type: 'string',
>>>>> +       description: 'cc for xtensa tcg tests')
>>>>> +option('tcg_tests_cross_cflags_xtensa', type: 'string',
>>>>> +       description: 'cflags for xtensa tcg tests')
>>>>> +option('tcg_tests_cross_cc_xtensaeb', type: 'string',
>>>>> +       description: 'cc for xtensaeb tcg tests')
>>>>> +option('tcg_tests_cross_cflags_xtensaeb', type: 'string',
>>>>> +       description: 'cflags for xtensaeb tcg tests')
>>>>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>>>>> index ba73eecf1c9..8dd6623ad1d 100644
>>>>> --- a/tests/tcg/meson.build
>>>>> +++ b/tests/tcg/meson.build
>>>>> @@ -180,6 +180,8 @@ foreach target, plan: tcg_tests
>>>>>      continue
>>>>>    endif
>>>>>  
>>>>> +  cc_arch = target.replace('-linux-user', '').replace('-softmmu', '')
>>>>> +
>>>>>    # Detect duplicated executables/tests, and report an error to force user to
>>>>>    # choose how to deal with it.
>>>>>    built_tests = {}
>>>>> @@ -197,16 +199,34 @@ foreach target, plan: tcg_tests
>>>>>    endforeach
>>>>>  
>>>>>    cc = find_program(plan['cc'], required : false)
>>>>> +  cc_cflags = []
>>>>> +
>>>>> +  check_flags = []
>>>>> +  check_required = false
>>>>> +  cross_cc = get_option('tcg_tests_cross_cc_' + cc_arch)
>>>>> +  if cross_cc != ''
>>>>> +    # we make sure cross cc exists
>>>>> +    cc = find_program(cross_cc, required: true)
>>>>> +    check_required = true
>>>>> +  endif
>>>>> +  cross_cflags = get_option('tcg_tests_cross_cflags_' + cc_arch)
>>>>> +  if cross_cflags != ''
>>>>> +    cc_cflags = cross_cflags.split()
>>>>> +    # and that cross cc can compile programs
>>>>> +    check_flags = cc_cflags
>>>>> +    check_required = true
>>>>> +  endif
>>>>> +
>>>>>    cc_from_system = cc.found()
>>>>>    has_cc = cc.found()
>>>>>    if has_cc
>>>>> -    check_flags = ['-static']
>>>>> +    check_flags += ['-static']
>>>>>      if target.endswith('softmmu')
>>>>> -      check_flags = ['-nostdlib', '-r']
>>>>> +      check_flags += ['-nostdlib', '-r']
>>>>>      endif
>>>
>>> What it needs is -ffreestanding - it gets away with it on linux as the
>>> compilers are mostly userspace compilers and it can fallback to those
>>> headers. On macOS or if you install a pure bare metal compiler it would
>>> fail.
>>>
>>
>> Makes sense, that's a good reason for having this flag setup by default.
>> Does it solve the issue to find stdint.h on the mac setup you have?
> 
> For softmmu yes, for linux-user we shouldn't ever try to build a target
> on macOS (although I don't know if the bsd-user would work?).
>

Ok. I don't think *-user would work on MacOS, since it's the same
situation than windows where syscall interface is not stable across
versions.

>>> <snip>
>>>
> 


