Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29D9CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXNmY-0003j4-2P; Wed, 10 Jun 2026 14:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXNmW-0003io-0f
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:36:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXNmT-00021n-2N
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:36:02 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AFx3bI2127553
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p1QQbWHJcKXg0ydvI6bTuAEEh2zm5udqnW20DLNpNEI=; b=joDwdyLAV+IDcNvj
 A+LRGUOJ0EK5CMZthXN8RFj+EBevJU75/IwYbUjgEbzoblDE2LANRqpGGy1ej0F3
 M8HsVgzJvY6PnGQddtEVGt7mqANBtY9RSPdhyvZHWnhApnoBXA1JecGhx3bPIDDa
 nke6yzBPta8zcIgaWah+9jLiv7II7owb7yPZ6kuyTOsJ1YUr2jypquugaJ70yjsM
 saYkwQ/FRjZQLF1jVAwAxq+O/z25TrYrxzYf6XtU5rDRXVhK2ugM/d+YcQfbTVKU
 uRsyYS/0Md7CDQyWro+aGHVwFDlI1ZWjEyifE/NVfEWlVr1gE7L6G7jnWG8woyLt
 GzETjQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq2sek1gf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:35:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-308004a2c49so122259eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781116546; x=1781721346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p1QQbWHJcKXg0ydvI6bTuAEEh2zm5udqnW20DLNpNEI=;
 b=QdVzdC0ELc+Tyj5e6C7hBzSt0RiSIqb88h1IpiiBgelR7iSCLC4IkRRBOvJ3yb5Yo0
 5ISVejgof1eC6xq3K4XMbi6h5eMlSKZC4cIYopohfDvpzOlbtg+2Vqw/NQxdPPfiGW8Y
 bFoLdo/2tHZdo3hmwSo1Qn7zx3ov5BCPzmG4vKLK1BJQ6Vyoj+BXAuokXXn0QvaUksat
 FzFedv88oVwqs0o/Z6BRFE/tP9XPa9d/2rEOCW3TXVxFPjS9MiAEM462FxNTzqQdQMEn
 7eXRCoLl/iFiQ0a12NZ/dm0wKRqh/V+ufJA9ULUlITRe3DTQmDL/kH8ajrSM6LrPjJTe
 kE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781116546; x=1781721346;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p1QQbWHJcKXg0ydvI6bTuAEEh2zm5udqnW20DLNpNEI=;
 b=XVP9Rd/aOgltfUR64fMESddW9ViBgiTXkpfAQ6CLlu7JAPqeObaGZGlR2LXZzdkk0U
 OYdNooL5XA2rAHw6Yr1KrfEVeOvo6POmIhFg5is2qFMpIazUYwRjWGpkpf6hNJO5iXSG
 zAgo3Ny67CkTRJHZHEvm/0qcvPxieqpms3YKU7OsX8LbfShXP3tdccDEl+D5EK4uz4MJ
 s8GrABf19ilgt3v1hY1x/N8thl7S6IZLjyQn7Sk2E7WTz63/EeQMqltZVn5gYCdkoKXp
 6cfkbI0pT8+5jhMDkkCw1p8cMiWq2KQW+7ZXUIO3oRr7wiedECiWAkGyQgWfhotaWM86
 AclQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ktJjq3OlK1wZRHef9vljXFJxAMgbc7ZEXoCcDWzr73pVYnthnKbsSnLNBYbfxfdhwVfNnwGoMkiu4@nongnu.org
X-Gm-Message-State: AOJu0Yzv/J+MSdFnwyWmbMuiAZCz9xNvqLPfK7ACeFSyi3ICfjf1KBQ3
 X+6R7wc5pTOUrz8Rp8U0UqpU+hOZP51ihfAgbeQ4Wo1mUVrIwkgr3LWxcIDjab7jNimOQMx+9Be
 9fOELAE3FZbxZurUGMC1p9fAQI1xdGaZ/ctmCPWezt4+T/m+CR8ETjMH1dw==
X-Gm-Gg: Acq92OFlyvlutiQpw8KYMjA61GHz9BxtUT1eEvPswtctzTSw+96sqDflA5URIBmJ1NI
 pBKNUNUMbWs1ZhjQLZ4XfptvLy6ACDXj2BpUttRJqpTk67EVD7vRxOwrIQbMLzAskrlHCLqqr9b
 VZDr5S1uzWPw9QsfVNcLzETsIw5ct26+29S4W4YdXOgHhEBOL9xaoF3jHKCIorrqWF1k5iQOvfM
 cgVOTLEr3dlPFBaMSDppt9tdX3bJhqqv8xwRS9VgdQlHiTOQhYOYWys7Yo15iIYkMlCo/0LF7Sg
 cgTQfNMHLe+/jOrwrMPvxLCFL0TW1Zoqe0xJjeQFgoBqtYWcQJewxqVM4aXIkIUGNvfXBc1U8wK
 hx0rdMvBl6FEFd3TaHQ9malikPliLowMz+ayuxTVFh31NkL3cclUl1b22pRNxp6jt8tmdQh52ZI
 b4GIzwhHgZmVEgg620lTTS+o7G
X-Received: by 2002:a05:7301:2923:b0:2ed:e12:3773 with SMTP id
 5a478bee46e88-3077b38a42fmr17689721eec.35.1781116546090; 
 Wed, 10 Jun 2026 11:35:46 -0700 (PDT)
X-Received: by 2002:a05:7301:2923:b0:2ed:e12:3773 with SMTP id
 5a478bee46e88-3077b38a42fmr17689686eec.35.1781116545458; 
 Wed, 10 Jun 2026 11:35:45 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df9bbd4sm24406870eec.30.2026.06.10.11.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 11:35:44 -0700 (PDT)
Message-ID: <8eefb8df-eb85-4a29-9bcc-1b5ca4e9b809@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:35:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/27] tests/tcg/meson.build: introduce plugin_test
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-12-pierrick.bouvier@oss.qualcomm.com>
 <tgen2u.3c957rnxjp0lu@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tgen2u.3c957rnxjp0lu@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0LMlbErtTgN_EzXztmOwKsTScmJLckhE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE3NiBTYWx0ZWRfXy0B3UAyFwCQ8
 wGZg2xvQh2LrvUavRP236UuPtaWkY0RZGBgmKDN1FGfW30Ytyu62sYKSrl2+MHAv3XmWd7GPluu
 bvrbA9BzZvKRZgmER4PT8KLzFomlO5Dad+4dky5mmnpvhDlRJ2v+bt0blI0e0VBVa5hDeiEf/RL
 LEMBEPfEAtEmbM90GCQeITw9bKyplGkVTS0sxFWo0XNhDAtEyzyroIG9eUiAv+yFdxlq7RnUIHs
 +c/OpHWCtMziMb2lg2NHvQKbeSp2rJH/PDKr9tXFmRCzylIiH1LfY7KJMgFre4ridc75mEHu4X5
 lnirunuUoGnGbDCQL/g9ZmOumK/WL6Sn6D9ZUMd5NxmUDnUCd3han3Em465idm7jDzr8+q7un3a
 ph65cFsT9zBTmhgox+A5wnD1N184/Q1EKuSb4OfTLrhwEjN9Gh8Pn9kwCuhfLHt/hE+mqMr3anR
 lCLJ7avvvUZ8ULaD23w==
X-Proofpoint-ORIG-GUID: 0LMlbErtTgN_EzXztmOwKsTScmJLckhE
X-Authority-Analysis: v=2.4 cv=Md1cfZ/f c=1 sm=1 tr=0 ts=6a29ae83 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=MkhVk2wWyBbEnf8Dz6AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100176
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

On 6/10/2026 12:17 AM, Manos Pitsidianakis wrote:
> On Wed, 10 Jun 2026 00:47, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> We add possibility to declare a test that is based on a plugin.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>> tests/tcg/meson.build | 40 +++++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index 5cd80f3c030..a47f1ada779 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -16,6 +16,10 @@ tcg_tests = {}
>> #           'cflags': ['cflags to compile test', ...],
>> #           'qemu_args': ['qemu command line flags', ...],
>> #           'env_var': ['VAR=value', ...],
>> +#           'plugin_test': {
>> +#             'plugin': 'plugin_name',
>> +#             'args': ['plugin_args', ...],
>> +#           },
>> #         }
>> #       },
>> #       ...
>> @@ -57,12 +61,25 @@ foreach target, plan: tcg_tests
>>       # return a clear error if user mispell a setup entry
>>       foreach key, _ : setup
>>         if key not in ['cflags', 'qemu_args',
>> -                       'exe_name', 'test_name', 'env_var',
>> +                       'exe_name', 'test_name', 'env_var',
>> 'plugin_test',
>>                        ]
>>           error('unknown tcg setup entry \'' + key + '\' for test ' +
>> src)
>>         endif
>>       endforeach
>>
>> +      # return a clear error if user mispell a plugin entry
> 
> misspells :D haha
> 
>> +      if 'plugin_test' in setup
>> +        foreach key, _ : setup['plugin_test']
>> +          if key not in ['plugin', 'args']
>> +            error('unknown tcg plugin entry \'' + key + '\' for test
>> ' + src)
>> +          endif
>> +        endforeach
>> +      endif
>> +
>> +      if 'plugin_test' in setup and not get_option('plugins')
>> +        continue
>> +      endif
>> +
>>       # meson '/' operator drops left operand if right is an absolute
>> path
>>       src = folder / src
>>       file = files(src)
>> @@ -76,6 +93,12 @@ foreach target, plan: tcg_tests
>>       if 'test_name' in setup
>>         test_name = setup['test_name']
>>       endif
>> +      if 'plugin_test' in setup
>> +        # remove lib prefix
>> +        plugin = test_plugins[setup['plugin_test']['plugin']]
>> +        plugin_name = fs.stem(plugin).substring(3)
> 
> Why skip the first 3 chars? Maybe add a comment like you do elsewhere
> for unclear lines (suggestion).
>

The comment says it "remove 'lib' prefix", but I should move it just on
next line.

> Regardless of my comments:
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
>> +        test_name = 'plugin-' + plugin_name + '-with-' + test_name
>> +      endif
>>
>>       exe_name = target + '-' + exe_name
>>       test_name = target + '-' + test_name
>> @@ -116,6 +139,21 @@ foreach target, plan: tcg_tests
>>         qemu_args = setup['qemu_args']
>>       endif
>>
>> +      if 'plugin_test' in setup
>> +        plugin_setup = setup['plugin_test']
>> +        plugin = test_plugins[plugin_setup['plugin']]
>> +        plugin_args = []
>> +        if 'args' in plugin_setup
>> +          # add empty arg to generate an additional comma
>> +          plugin_args = ['', plugin_setup['args']]
>> +        endif
>> +        plugin_args = ','.join(plugin_args)
>> +
>> +        # since we turn plugin into a string, add dependency explicitly
>> +        depends += plugin
>> +        qemu_args = ['-plugin', plugin.full_path() + plugin_args,
>> qemu_args]
>> +      endif
>> +
>>       exe = built_tests[exe_name]
>>       cmd = [qemu, qemu_args, exe]
>>
>> -- 
>> 2.43.0
>>


