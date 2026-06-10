Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B39CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXNkh-0001jW-DW; Wed, 10 Jun 2026 14:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXNkf-0001j7-QG
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:34:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXNkd-0000wt-UG
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:34:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AFxJbQ1670870
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k+VdZDN7nN2rbWE/EdYwbq7066wgL91r+hU5Xxsgat4=; b=R7JFe8x7vtCgEjUm
 +aSe7glnifbvEBXKooxhTlhcccW/l+1DjMvLb1iCXgy3gymDguuMUjeYdOi3fzTK
 r5CC9cTqhk2remKztHNjnKTNFJ6hLcbL0ZPDBEOCoaM1htGI0OnH2WJGXDoc2CDU
 6fqewZFNsKjXIWh/Zrvxp4C4ReKAbOMn887hhDTgkLhxr3GXnCjfQGnAjaNE1LSX
 YQCx/oErr7nAt4uelUn24qaVpWugkDFGqdrzJfL/7Va6vpIYm84mDo9txDOzMcaE
 6lTF18sArI39W99/SdTRCIoIdJHl9+YD8sd1De3f7M02Foh8n5U9s47ITG46j9iw
 K14zvg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0m1ud0x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:34:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-307625ee07fso9485049eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781116445; x=1781721245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k+VdZDN7nN2rbWE/EdYwbq7066wgL91r+hU5Xxsgat4=;
 b=M6XShhEQCUk+1jyPPBxB5+93t2jquZE4QUo83cMVV5lLgxvSUA0oEuy9m4jerPrZfs
 WweMK+QuSI80qhfk1wegfnP/8+zDnrj316B22U0vMLO7bzoCPhRhxZM3BK+k0r61u0GU
 EOgxmkXppbJdMUh79Qc1AZaGeJd9F8b8YD4a/IL88wVFGjHNVyJEHJPQvctfg9ADdz+y
 7P5PFl4sirvr+mHTMV1g2QKXM2WCyzwtx/RNXM31QJLylYbKbrcOAfgDW1ePNSCna2O3
 bFb4rjcMk7O1/M4+j0TlaN5shoBB7n0PLYQckhly61EQ/dDGLuiugI7semY/mFvg7dII
 Rn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781116445; x=1781721245;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k+VdZDN7nN2rbWE/EdYwbq7066wgL91r+hU5Xxsgat4=;
 b=P/O4J+NhIE4L+gGROe9JfH1BfHyaDsRQdb9bQ41f9W9GbEMHHoAblF8TJbBiepwb2v
 HPXDj64g6tMTg969/Ku6RfEeiDqiDbaYiFqnaACnAVJrWN6q6l5HTFEChmoEHKOxDl8t
 SH8ahL4dluACuEqy2YiIQwnYBKmp3dyK4Hh62REO2PTQ/5wjd+ZNL78LPxeYFR5FRpYN
 7vrNzFcqfs8Zobr8h/nyIBGm5y0c3pFPgEuKQHR656yajM4r+cfxpelIoTfvs7tVDwph
 rGosf2r+jKD8Aqbt2Ug0NkjU899LolKR3tBD/sDFemz5ashpH6mVwHJzau8HIy+r3QEC
 i/fQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZPJXtHOtqPFjf2ikSUOIUvtc4kWm9r+dnqsvIiAbfKj9uraYRH7fJSm/fAh6ld3orwbNwcKaEK5eB@nongnu.org
X-Gm-Message-State: AOJu0YyrX3ugGKIqjDQPaGFCLrD2oPVI/TZ2XGPZcb5cxcR+tD8uEbCE
 Xf4XcQSV85wvD8EYXAlYIOploqET3itpYRM2zOO3GyBit4MsxZko5rmyFWMyy5vibjAlprd06p9
 RpniFxZS7sg7pXLByVq8tPHCCM17TyayJqmXlnHPKZj5totopco6l89a7aw==
X-Gm-Gg: Acq92OFW/Z+ISNg1yVrT2X4KqxIeQ0woZvVQCU+H8jH9ZO8LGO7ZztxkkBHw4fY9NRB
 11MaoGNFXDVC74qG/ukq6FSxvrV4kgFYzRtYo+5Qk4Ep24yrDjT1c9AMIrYd5GnqKkGsMo16Fz8
 /lTwFR9gzoYs2FNZYoaL8ncEA3+34CM+cbRPQJazR154TTkrrOlprXW98sRfL44DiZ/K/6RRuc9
 canNxAex7Qns06tFOe4rq/Ic5agiPUamce0O6od6/mJfGMjIQwuJhn7KWlIjS0ERyoh3fQHaTas
 NseEOrfB9jtBaMcYJhygS9JlsC282iuO4LetZdH97SvuVRxLU4sFO0k3xToEoaFsZw/GKnAYwQY
 FxDufKGWY10yI6uOtfQX+nKgsC1DuRhCRzlnvTWha2k+VKjeqBlXYbtkqukF8iKYF6Z+qdRdh9n
 lu4679LIe77NN4S3Nfe9NpM3D8
X-Received: by 2002:a05:7022:61a0:b0:12c:6a24:a24f with SMTP id
 a92af1059eb24-13840b962bbmr208446c88.33.1781116444976; 
 Wed, 10 Jun 2026 11:34:04 -0700 (PDT)
X-Received: by 2002:a05:7022:61a0:b0:12c:6a24:a24f with SMTP id
 a92af1059eb24-13840b962bbmr208426c88.33.1781116444447; 
 Wed, 10 Jun 2026 11:34:04 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54c9c12sm19328093c88.6.2026.06.10.11.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 11:34:04 -0700 (PDT)
Message-ID: <525beb88-c311-498a-aa52-4eb188eac008@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:34:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/27] tests/tcg/meson.build: introduce test_name
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-7-pierrick.bouvier@oss.qualcomm.com>
 <tgemmc.ymcxyhiodn9w@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tgemmc.ymcxyhiodn9w@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE3NiBTYWx0ZWRfX+EWCJLmWolip
 DPZE8wL1eeU4oJGzG/7AJxiMNqcrCec8XBZj64tJ0TxROiG7k+83aWOiqwY/4Kc1Pnz/hFKJ44u
 fXREfMNlPbPbZtfmKGj7rDundsU37+Fx40q3K1TpsGLmVHrlpRlEbab/zwz5e8n/0raENb1iZXY
 wpadna09UiRwRk7yd/AdLtBEzzdo8PFeTdtoozL0TUF8D/Wh0MOu3sL5c3tIqxa+2z/ahqtdb3/
 IDOZkULdQU1OOC4w+9G4jUsMNJPUBFNWCjI8j4WcOAfb1EmsEyMW0AH8D17OQaOB35l2aqLSE3e
 zNGvRT0vS6zpfpUHik2dqvjYjy6nQUOdzll9rsImeV9waVOh0KNdlGunI4URFB7LFxfk79Ll48x
 z4htf9iGETIYENZ9GqcHhdjXXZ8aTIWZh8CtjLqmbXjXIbplKVJumDZGgHEWMJ4Hv+OgE8N1G1x
 +OTs1t4VQMFpPORg3BA==
X-Proofpoint-GUID: tfuoNgmScBCxdrgnb0MKNKAEMjqQKMPU
X-Authority-Analysis: v=2.4 cv=UdJhjqSN c=1 sm=1 tr=0 ts=6a29ae1d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=5r5wm9yo4xwGGYzd8k8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: tfuoNgmScBCxdrgnb0MKNKAEMjqQKMPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100176
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

On 6/10/2026 12:08 AM, Manos Pitsidianakis wrote:
> On Wed, 10 Jun 2026 00:47, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> We add possibility to duplicate a test for a given src. This allows to
>> declare several tests that still share the same executable, thus saving
>> space and compile time.
>>
>> A side note to mention that meson perfectly supports declaring several
>> tests with the same name. However, we prevent that to force dev to
>> clarify what is the intent of each individual test.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>> tests/tcg/meson.build | 14 ++++++++++----
>> 1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index 2c6d85c586a..bb0184732fd 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -12,6 +12,7 @@ tcg_tests = {}
>> #       {
>> #         'src_file': {
>> #           'exe_name': ['provide an alternative binary name'],
>> +#           'test_name': ['provide an alternative test name'],
>> #         }
>> #       },
>> #       ...
>> @@ -21,8 +22,8 @@ tcg_tests = {}
>> #
>> # Every test executable, identified by 'exe_name' is built only once.
>> # Tests for a given src use the same executable by default, and their
>> definition
>> -# is guaranteed to be unique also.
>> -# Default name is derived from src if 'exe_name' is omitted.
>> +# is guaranteed to be unique also. They can be duplicated by setting
>> 'test_name'.
> 
> While it's clear in the patch description, it might be a good idea to
> explain that "duplication" means using the same executable here, for
> clarity, if you respin this series.
>

Sure, I can add this.

>> +# Default name is derived from src if 'exe_name' and 'test_name' are
>> omitted.
>>
>> # plugins come first, as we need to build the list
>> subdir('plugins')
>> @@ -51,7 +52,7 @@ foreach target, plan: tcg_tests
>>       # return a clear error if user mispell a setup entry
>>       foreach key, _ : setup
>>         if key not in [
>> -                       'exe_name',
>> +                       'exe_name', 'test_name',
>>                        ]
>>           error('unknown tcg setup entry \'' + key + '\' for test ' +
>> src)
> 
> 
> Unrelated to this patch, but you could refactor the ['exe_name',
> 'test_name'] etc key set outside and print the list of valid keys in the
> error message as well for UX.
>

Good idea.

>>         endif
>> @@ -66,8 +67,13 @@ foreach target, plan: tcg_tests
>>         exe_name = setup['exe_name']
>>       endif
>>
>> -      exe_name = target + '-' + exe_name
>>       test_name = exe_name
>> +      if 'test_name' in setup
>> +        test_name = setup['test_name']
>> +      endif
>> +
>> +      exe_name = target + '-' + exe_name
>> +      test_name = target + '-' + test_name
>>
>>       if test_name in added_tests
>>         error('test ' + test_name + ' was already added: ' +
>> -- 
>> 2.43.0
>>
> 
> 
> LGTM (feel free to ignore the comments)
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


