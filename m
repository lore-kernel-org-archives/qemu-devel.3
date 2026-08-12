Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28C3C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBXN-0000aW-QA; Wed, 12 Aug 2026 12:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBXI-0000Vc-I5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:10:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBXC-0003vm-K1
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:10:35 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbodS3971671
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 16:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3mcYwLmGB8ywp06zEWTvkN37ZfSvFR7FwjCys45DO1Y=; b=cD/2xQ6R1QoihAPR
 gjuplJvVGbUES0zEyd4nfcvDkhhlBjEd/eOf9xEtV0LrL0aAn+gROWFb86mMhxbR
 ZuCZIHFf3dKxS2MFIfLaShfk5N2CC75cKivApnMbi/4/wNFTu8p6PM6v/ri6mwzV
 lZ3hIjNb0ixeyeKRuECRaFlXBgiPxLXbyyz4p+KrY2HXasLjffgD3+yKTS9Y4Ehn
 L3/5wpowMfUkNnibGX/CmbW4/Xlu371SCCYxvJcXF1SYSafj5NeRcugwmmQn+qP5
 nfger8cLeS3Ycv2R3y09RuwSBOi9HK5wyXhyxbzAQtGGum2GrJaQobUkMvmZFXF1
 iXEVkw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0jgrjq11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 16:10:20 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84e3d575d6eso1869191b3a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786551017; x=1787155817; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3mcYwLmGB8ywp06zEWTvkN37ZfSvFR7FwjCys45DO1Y=;
 b=YKywrX6jOoPUGZQxql6Uc+sGpVZ3ysqkTLn1ZsBo9PTgZWqgCJzgK1LltYEwcNCMaW
 BpOtxgMlB2REVNBOvhYDvUkDOD8vm0iPdB/iqJYPv59po5WNbSGKRNXMgpBfsbDo3pB8
 l6bWdbY66QHOz5jGRHEBjTYIN7q2+nvccD54WuxJL201rIcTxUi5sq3Su3X9VfD8fLTC
 GwKoLMC41nHJf/eubwox8lE/unqjJHUQ3DsQVQrNNbPLZtnF1Miz9f/SD3JZhSNvTjaa
 hYRAUmHM8B+AmXWL3uUrUUzYStDs9hlwsfkPjvFty3t/PuL3thrZVP70k9WisU4Pj/vC
 34hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786551017; x=1787155817;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3mcYwLmGB8ywp06zEWTvkN37ZfSvFR7FwjCys45DO1Y=;
 b=o+b5XcKTOMQP6UYt8A4cBRtQVKD8l8yMeGUL30yCn4TSlppaLElPadB7BbPqt0QEEJ
 2SL0goSfIcNTX0G2NAt4kYqOW++c/ImILwEA95E2FeUxgn2Np1lX78cAtqctpZbQnyw4
 0nqG9TsqWVho4B6Ab1FbsqIjVzVOU4TyI8yUyEUQZXsIyDZfa44IB7X0r9LE+LZMVJM1
 7GeWcBQc93/iEG476hEnDgsZEM1Yo+YPiJixzQz1Dk9jCPK6ByFUcLiyGpdkBoVKc5pO
 kt3fxaBT5exHLrIdX0elIEAdi+51gDZsgx1oNCwhrjPRkiB4/FSo9pCwETWNDpj1Q7DK
 lYWA==
X-Gm-Message-State: AOJu0YyVhuEEK6AX5vDFQKHV+B9eYWkvQDNlRC2x1kSC2bdGYIt+1ZvD
 w0bSuaGu+c0xqev79xVMEmisxGpPd3FztvTmqvdoTkGmpiLLjhwnWQOtjnDwPc7+s1N9LhrnFJ0
 QB0W8d+YYPCAXKVKckkj9slHzK/GIRVxyxE71PWO5Tdn4YGk+9cNONAPpsA==
X-Gm-Gg: AR+sD12t353U7L8BOBMuj6qUHG+9we97DYyMrGMeYmKaeY+4G/v2MXAQKcEfAVn3DZo
 Qy3LVThQbg4sIrie8nR53/tyztwucqECDTdkyfIHVEuy+G3Uk6ChM1nByt1VvybhF+R436pOR6+
 FVostT7PCuQCm1XHnFQ41PZnXfeFQTTie1i+Fz8bxlUAfzLLFuaFjn3rHXr34JsxciXMTtkUjXA
 QTkiLR3H0QOBQHq8JVg3OzlJZEu15zz82Ogbe+k/CFoprwaJQbEtgTsBW0jL0Zz+tiEczOnJY3Z
 M2kYe4ZN1fTVgMBMWrL5bxDxAsweCjuXudiR8TrGoDjNrLCb8LQpSCsRzCANWkyAPJ5DTnz7ycl
 DYIvL0l48f+KNHaMTkF33/xL6O9EtrPppR2/+caXlsRE/RoNsLEhcNk3ZyNBNmgb1tsJt
X-Received: by 2002:a05:6a00:2e18:b0:848:50a5:a70b with SMTP id
 d2e1a72fcca58-84fb54dedb4mr6315362b3a.21.1786551016432; 
 Wed, 12 Aug 2026 09:10:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e18:b0:848:50a5:a70b with SMTP id
 d2e1a72fcca58-84fb54dedb4mr6315286b3a.21.1786551015848; 
 Wed, 12 Aug 2026 09:10:15 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1cf419fsm1299425b3a.5.2026.08.12.09.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 09:10:15 -0700 (PDT)
Message-ID: <8da0e719-fda6-4edd-b436-458c0d4f3d39@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 09:10:14 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8733wjz5pg.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzMSBTYWx0ZWRfX8TBF5UwEPn3w
 eS4VZh1as3eN+7WvrVBQA11M1W0Hbr6n8096rXKu3+bZxE157+jLpzAyIgKczpj/fFXGyEXrLE1
 GjKox62fcfXG7N873omMl0lz18quSAZ/O54O9ZHNydVYjg6XkarXEPFlyALCO7Do49LKmm09y7d
 ruyRD7utvfiMrF3fSPZ6EQwgky4OV+g9xBarbNTME2KwdSaAJhetfvggugBp8dX16CiajeW+LUx
 qjqdWJm4YwUj44IHiAgYGInn0Bq7VBATqyPCtSt+UDurJdi9PQmn88hsVpbk4A9BSKw1HHnb2/G
 tdpuTd72LZvW5DI3mmdKJ1yt+sJ9KhFZbf87gsM9WobclfXZ+aExMxLWVORG4F7TwhlVl16gLrh
 c3U01FoXRKGtR4xXT5PuX+Yq7sDZqtVCoFujRFwYD5DDURExLF+5lm2uQ/ebIWJfsuogKgiVjef
 Da1L7Ar5I18GUar0h0w==
X-Proofpoint-ORIG-GUID: TbaK0Dyrj5-nzokl-yxaNkQmN6JHSfOj
X-Authority-Analysis: v=2.4 cv=TNJ1jVla c=1 sm=1 tr=0 ts=6a7c9aec cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_kjzWLpimGvNuqp8o0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: TbaK0Dyrj5-nzokl-yxaNkQmN6JHSfOj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzMSBTYWx0ZWRfX0xA2hloXRz/E
 pNUc2XXWsad787ptYEYXsNJbGWxGwGfC4D/u08gjOmdclrrTNfGMWHPhzwANhZ3RkjWj2P1PB1F
 ZMEHSgaYWyVIhew3qFPmX24NkDayu5Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120131
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

On 8/12/2026 9:03 AM, Alex Bennée wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>
>>> When a user set explicit cross cc, we ensure it's available and working.
>>> When a user set explicit cross cflags, we ensure they work with default
>>> or overriden cross_cc.
>>>
>>> Made the first implementation with a single meson option (array), which
>>> proved to be absolutely unreadable.
>>> By having one option per target, we directly detect issue at configure
>>> time, either for user, or when iterating on all our targets. This
>>> ensures user can't mispell any target name, and that we can't forget any
>>> new one in the future.
>>> Also, it shows them in the configuration summary, which is a bonus.
>>>
>>> Since we now only need to know compiler to write tcg tests, we can
>>> simply alias -cross-prefix-* options to compiler override.
>>>
>>> Examples
>>> --------
>>>
>>> wrong architecture:
>>> $ ./configure --cross-cc-bad='cc'
>>> ../meson.build:1:0: ERROR: Unknown option: "tcg_tests_cross_cc_bad"
>>>
>>> wrong option:
>>> $ ./configure --cross-cc-cflags-aarch64='-bad-option'
>>> ../tests/tcg/meson.build:228:10: ERROR: Command `/usr/bin/aarch64-linux-gnu-gcc /home/pbouvier/.work/qemu/tests/tcg/test_cc.c -bad-option -static -nostdlib -r -o /dev/null` failed with status 1.
>>> A full log can be found at /qemu/build/meson-logs/meson-log.txt
>>>
>>> cross compile with clang (fails at the moment, since some tests have
>>> compilation errors with it):
>>> $ ./configure --target-list=aarch64-linux-user --cross-cc-aarch64='clang' --cross-cc-cflags-aarch64='-target aarch64-linux-gnu'
>>>   User defined options
>>>   ...
>>>     tcg_tests_cross_cc_aarch64      : clang
>>>     tcg_tests_cross_cflags_aarch64  : -target aarch64-linux-gnu
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>  configure             | 27 ++++++-------
>>>  meson_options.txt     | 89 +++++++++++++++++++++++++++++++++++++++++++
>>>  tests/tcg/meson.build | 30 ++++++++++++---
>>>  3 files changed, 126 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/configure b/configure
>>> index 568de41dadd..c9e2cdcce5f 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -227,19 +227,6 @@ for opt do
>>>    ;;
>>>    --extra-ldflags=*) EXTRA_LDFLAGS="$EXTRA_LDFLAGS $optarg"
>>>    ;;
>>> -  --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
>>> -  ;;
>>> -  --cross-cc-cflags-*) cc_arch=${opt#--cross-cc-cflags-}; cc_arch=${cc_arch%%=*}
>>> -                      eval "cross_cc_cflags_${cc_arch}=\$optarg"
>>> -  ;;
>>> -  --cross-cc-*) cc_arch=${opt#--cross-cc-}; cc_arch=${cc_arch%%=*}
>>> -                eval "cross_cc_${cc_arch}=\$optarg"
>>> -  ;;
>>> -  --cross-prefix-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-prefix-FOO option"
>>> -  ;;
>>> -  --cross-prefix-*) cc_arch=${opt#--cross-prefix-}; cc_arch=${cc_arch%%=*}
>>> -                    eval "cross_prefix_${cc_arch}=\$optarg"
>>> -  ;;
>>>    --without-default-features) default_feature="no"
>>>    ;;
>>>    --wasm64-32bit-address-limit) wasm64_memory64="2"
>>> @@ -632,9 +619,19 @@ for opt do
>>>    ;;
>>>    --extra-ldflags=*)
>>>    ;;
>>> -  --cross-cc-*)
>>> +  --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
>>>    ;;
>>> -  --cross-prefix-*)
>>> +  --cross-cc-cflags-*) arch=${opt#--cross-cc-cflags-}; arch=${arch%%=*}
>>> +                       meson_option_add "-Dtcg_tests_cross_cflags_${arch}=${optarg}"
>>> +  ;;
>>> +  --cross-cc-*) arch=${opt#--cross-cc-}; arch=${arch%%=*}
>>> +                meson_option_add "-Dtcg_tests_cross_cc_${arch}=${optarg}"
>>> +  ;;
>>> +  --cross-prefix-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-prefix-FOO option"
>>> +  ;;
>>> +  # cross-prefix is just used as a syntactic sugar for -cross-cc.
>>> +  --cross-prefix-*) arch=${opt#--cross-prefix-}; arch=${arch%%=*}
>>> +                    meson_option_add "-Dtcg_tests_cross_cc_${arch}=${optarg}gcc"
>>>    ;;
>>>    --enable-docs) docs=enabled
>>>    ;;
>>> diff --git a/meson_options.txt b/meson_options.txt
>>> index 5e91969414a..fd9ff0df893 100644
>>> --- a/meson_options.txt
>>> +++ b/meson_options.txt
>>> @@ -389,3 +389,92 @@ option('containers', type: 'boolean', value: true,
>>>         description: 'use containers to cross compile tcg tests')
>>>  option('container_command', type: 'string',
>>>         description: 'command to build/run containers')
>>> +
>>> +option('tcg_tests_cross_cc_aarch64', type: 'string',
>>> +       description: 'cc for aarch64 tcg tests')
>>> +option('tcg_tests_cross_cflags_aarch64', type: 'string',
>>> +       description: 'cflags for aarch64 tcg tests')
>>> +option('tcg_tests_cross_cc_aarch64_be', type: 'string',
>>> +       description: 'cc for aarch64_be tcg tests')
>>> +option('tcg_tests_cross_cflags_aarch64_be', type: 'string',
>>> +       description: 'cflags for aarch64_be tcg tests')
>>> +option('tcg_tests_cross_cc_alpha', type: 'string',
>>> +       description: 'cc for alpha tcg tests')
>>> +option('tcg_tests_cross_cflags_alpha', type: 'string',
>>> +       description: 'cflags for alpha tcg tests')
>>> +option('tcg_tests_cross_cc_arm', type: 'string',
>>> +       description: 'cc for arm tcg tests')
>>> +option('tcg_tests_cross_cflags_arm', type: 'string',
>>> +       description: 'cflags for arm tcg tests')
>>> +option('tcg_tests_cross_cc_hexagon', type: 'string',
>>> +       description: 'cc for hexagon tcg tests')
>>> +option('tcg_tests_cross_cflags_hexagon', type: 'string',
>>> +       description: 'cflags for hexagon tcg tests')
>>> +option('tcg_tests_cross_cc_hppa', type: 'string',
>>> +       description: 'cc for hppa tcg tests')
>>> +option('tcg_tests_cross_cflags_hppa', type: 'string',
>>> +       description: 'cflags for hppa tcg tests')
>>> +option('tcg_tests_cross_cc_i386', type: 'string',
>>> +       description: 'cc for i386 tcg tests')
>>> +option('tcg_tests_cross_cflags_i386', type: 'string',
>>> +       description: 'cflags for i386 tcg tests')
>>> +option('tcg_tests_cross_cc_loongarch64', type: 'string',
>>> +       description: 'cc for loongarch64 tcg tests')
>>> +option('tcg_tests_cross_cflags_loongarch64', type: 'string',
>>> +       description: 'cflags for loongarch64 tcg tests')
>>> +option('tcg_tests_cross_cc_m68k', type: 'string',
>>> +       description: 'cc for m68k tcg tests')
>>> +option('tcg_tests_cross_cflags_m68k', type: 'string',
>>> +       description: 'cflags for m68k tcg tests')
>>> +option('tcg_tests_cross_cc_mips', type: 'string',
>>> +       description: 'cc for mips tcg tests')
>>> +option('tcg_tests_cross_cflags_mips', type: 'string',
>>> +       description: 'cflags for mips tcg tests')
>>> +option('tcg_tests_cross_cc_mips64', type: 'string',
>>> +       description: 'cc for mips64 tcg tests')
>>> +option('tcg_tests_cross_cflags_mips64', type: 'string',
>>> +       description: 'cflags for mips64 tcg tests')
>>> +option('tcg_tests_cross_cc_mips64el', type: 'string',
>>> +       description: 'cc for mips64el tcg tests')
>>> +option('tcg_tests_cross_cflags_mips64el', type: 'string',
>>> +       description: 'cflags for mips64el tcg tests')
>>> +option('tcg_tests_cross_cc_or1k', type: 'string',
>>> +       description: 'cc for or1k tcg tests')
>>> +option('tcg_tests_cross_cflags_or1k', type: 'string',
>>> +       description: 'cflags for or1k tcg tests')
>>> +option('tcg_tests_cross_cc_ppc64', type: 'string',
>>> +       description: 'cc for ppc64 tcg tests')
>>> +option('tcg_tests_cross_cflags_ppc64', type: 'string',
>>> +       description: 'cflags for ppc64 tcg tests')
>>> +option('tcg_tests_cross_cc_ppc64le', type: 'string',
>>> +       description: 'cc for ppc64le tcg tests')
>>> +option('tcg_tests_cross_cflags_ppc64le', type: 'string',
>>> +       description: 'cflags for ppc64le tcg tests')
>>> +option('tcg_tests_cross_cc_riscv64', type: 'string',
>>> +       description: 'cc for riscv64 tcg tests')
>>> +option('tcg_tests_cross_cflags_riscv64', type: 'string',
>>> +       description: 'cflags for riscv64 tcg tests')
>>> +option('tcg_tests_cross_cc_s390x', type: 'string',
>>> +       description: 'cc for s390x tcg tests')
>>> +option('tcg_tests_cross_cflags_s390x', type: 'string',
>>> +       description: 'cflags for s390x tcg tests')
>>> +option('tcg_tests_cross_cc_sh4', type: 'string',
>>> +       description: 'cc for sh4 tcg tests')
>>> +option('tcg_tests_cross_cflags_sh4', type: 'string',
>>> +       description: 'cflags for sh4 tcg tests')
>>> +option('tcg_tests_cross_cc_tricore', type: 'string',
>>> +       description: 'cc for tricore tcg tests')
>>> +option('tcg_tests_cross_cflags_tricore', type: 'string',
>>> +       description: 'cflags for tricore tcg tests')
>>> +option('tcg_tests_cross_cc_x86_64', type: 'string',
>>> +       description: 'cc for x86_64 tcg tests')
>>> +option('tcg_tests_cross_cflags_x86_64', type: 'string',
>>> +       description: 'cflags for x86_64 tcg tests')
>>> +option('tcg_tests_cross_cc_xtensa', type: 'string',
>>> +       description: 'cc for xtensa tcg tests')
>>> +option('tcg_tests_cross_cflags_xtensa', type: 'string',
>>> +       description: 'cflags for xtensa tcg tests')
>>> +option('tcg_tests_cross_cc_xtensaeb', type: 'string',
>>> +       description: 'cc for xtensaeb tcg tests')
>>> +option('tcg_tests_cross_cflags_xtensaeb', type: 'string',
>>> +       description: 'cflags for xtensaeb tcg tests')
>>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>>> index ba73eecf1c9..8dd6623ad1d 100644
>>> --- a/tests/tcg/meson.build
>>> +++ b/tests/tcg/meson.build
>>> @@ -180,6 +180,8 @@ foreach target, plan: tcg_tests
>>>      continue
>>>    endif
>>>  
>>> +  cc_arch = target.replace('-linux-user', '').replace('-softmmu', '')
>>> +
>>>    # Detect duplicated executables/tests, and report an error to force user to
>>>    # choose how to deal with it.
>>>    built_tests = {}
>>> @@ -197,16 +199,34 @@ foreach target, plan: tcg_tests
>>>    endforeach
>>>  
>>>    cc = find_program(plan['cc'], required : false)
>>> +  cc_cflags = []
>>> +
>>> +  check_flags = []
>>> +  check_required = false
>>> +  cross_cc = get_option('tcg_tests_cross_cc_' + cc_arch)
>>> +  if cross_cc != ''
>>> +    # we make sure cross cc exists
>>> +    cc = find_program(cross_cc, required: true)
>>> +    check_required = true
>>> +  endif
>>> +  cross_cflags = get_option('tcg_tests_cross_cflags_' + cc_arch)
>>> +  if cross_cflags != ''
>>> +    cc_cflags = cross_cflags.split()
>>> +    # and that cross cc can compile programs
>>> +    check_flags = cc_cflags
>>> +    check_required = true
>>> +  endif
>>> +
>>>    cc_from_system = cc.found()
>>>    has_cc = cc.found()
>>>    if has_cc
>>> -    check_flags = ['-static']
>>> +    check_flags += ['-static']
>>>      if target.endswith('softmmu')
>>> -      check_flags = ['-nostdlib', '-r']
>>> +      check_flags += ['-nostdlib', '-r']
>>>      endif
> 
> What it needs is -ffreestanding - it gets away with it on linux as the
> compilers are mostly userspace compilers and it can fallback to those
> headers. On macOS or if you install a pure bare metal compiler it would
> fail.
>

Makes sense, that's a good reason for having this flag setup by default.
Does it solve the issue to find stdint.h on the mac setup you have?

> <snip>
> 

