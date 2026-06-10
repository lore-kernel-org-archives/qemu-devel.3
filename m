Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECECCD98CE
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXNqX-0004oR-Bb; Wed, 10 Jun 2026 14:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXNqV-0004gj-Mg
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:40:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXNqR-0003zF-U8
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:40:11 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AFwr4g1665606
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rgJuudJJ3h3f46ppjCm3V15d8HmyFlPifhJNxucGFYo=; b=J5oOuABLelzmCa+r
 AKFcsVsCnqRyIoABrtmzMtzbGV60jIEygT6CN8u6QRKzd+zSitmzxwmv6awc+YmR
 ZbzcgEl+qJSeae0FFOEyrKDKbF5GSjr62YTQH+TtcL3ZPmi4DbjVNm67f8ACuxic
 dCyE0RbAfswLh6XFLRsRIuf8Zi7p6+1xF2BbYgEBZMh3ReFAuSecVZN3iUiRVDoH
 HPG/HWk3X5cUgu0Y1R73fKABIcvtQwNSJAONLIGmD4ICd1sbfu9KQdH0fVKqeMDw
 StqgiVJSAJEBph6cYdExeuKyfAmwk8cqsNJpKKrZvM8Jl/wj31NOBByu4ZGv/5G+
 g62jOg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwr2m2xh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:40:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3074d4102a9so5434679eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781116805; x=1781721605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rgJuudJJ3h3f46ppjCm3V15d8HmyFlPifhJNxucGFYo=;
 b=GhKbmo6x89aVfn//AE4rybNlCRX1hGLRzbNBXoKqoEPimZC9dTT4qFu3ruB6j4KXC5
 xmPgOK4/nrMxTPj+GW/3ww56HrFeTnzO+43N2lIBY2eeocOtsC7K4gXHr/eGZgrIcl18
 qPepvkD8IH4qCkwl7Git3hdBYuoRJOilZS4gM7Er7FK0N59/GcBvqvwSP2PXtafekTwa
 wHDmMCh1Dupp0dIMUuXFbX9D6ZJmij9jGjoX7K9WGRQ/VMmIxreqsnm2PfPjbpbY9SuJ
 TcmrmOStpZjSVs0Xdj+gj6/eMySYqCsjo6P/rJW0EWE2UG7gQP9+Vnf/9VOvosScVogw
 QVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781116805; x=1781721605;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rgJuudJJ3h3f46ppjCm3V15d8HmyFlPifhJNxucGFYo=;
 b=D6F24CslMlobNBLlCy2TjXYWglooXY4Sv+bjNKQj82h7UYHTnvzp76kcIrxNTLxdwF
 orkD4/iz1gpdyrLlzRAtaYHoGWL0Cyy0wvqn5KZFkDnyM0GXa/N+Yo6U9eryXWMwwSHn
 /7S/J3G/SG6z78A7Pq5nir4iMXlwyJHf6zn4pe03r0ifg4vtl6umZWuYV4gg/wqK+4bN
 AVQOvffTB98fIF6DGnA0DHvJg4UIcxly0zkVtzylGyWdzP4ecqWgsb1IyK1giIYY3Yry
 7VtTGGP9OEcst77Bo6W/Yr27nKYz+kBuUsqRMskmOsye7/+Uz03rxZ4ta73eqIuFTiZl
 PoIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BedlnFVXfYkjbiAS3nRfFRPYuWz7FcZgB9t+mwZ4Et1P3HIqr0cZ0s3bhHUKfhPBwh3pUUCt43CxP@nongnu.org
X-Gm-Message-State: AOJu0YySvWfg/wXFmk6QJ5YtWpGVAiKFZ4cPTg1g2zCJACErATBIq0jG
 W5lZSQfUQcF9WHOh22DjQnIDmnQAHM1Oi4tXjtzCEFR+Nyfo99g+4gp5dT5SLVqGns0qB3251j8
 B3HEk/GcdcO9QoPoU2t6EW/+pi2hQkXxnHBEpHg/FOdQhUVzh5mW1hgpJqA==
X-Gm-Gg: Acq92OG97yAmKdtVe/UlHu4HBan6bWOGi91U0TW4T1xNFXm+NBM5dc86P5vBgAWpNCH
 L5XGdFcxamN9qfnClLjGTmd/s6cNoLGe3aJOyscyt+Pkb+53+nZglmwNssWQQ3fExLWiMZEEhLG
 YunX/xqEOrFaQKZRqgE9pI0Uw1vB1agPZINWrqVgyAkJmbz7zUgbV6l5zCOgX7dH2Zt3bSgY9Nr
 lyNK0m5pKym3yyjRYUGT1LGtA59Fv5aT1WEBV+NMhvSKWwD+mjAxwivoWue3t+lKsfKtcXXoF5Z
 nUN80tdey7dGUo41DVi/45uFTY7HBh0Qoh2n1f0f8VHVRc+3s6u2CMgbq6NHWT40vbg0bNmh7SU
 8NRLvDkycO3408UurpQPWTZXxxw5DY3ZbsxU6w5bgALE2/Y+xFhiwuMW1gdx1MNcA/mn7HVIgGC
 k+ieOf6n/FC6mYjgTztlScTC2R
X-Received: by 2002:a05:7300:8ba3:b0:304:5644:f97a with SMTP id
 5a478bee46e88-307ff5f79e4mr248112eec.21.1781116804614; 
 Wed, 10 Jun 2026 11:40:04 -0700 (PDT)
X-Received: by 2002:a05:7300:8ba3:b0:304:5644:f97a with SMTP id
 5a478bee46e88-307ff5f79e4mr248090eec.21.1781116804072; 
 Wed, 10 Jun 2026 11:40:04 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df77a0asm28483425eec.27.2026.06.10.11.40.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 11:40:03 -0700 (PDT)
Message-ID: <af320c95-e1af-4a8b-bbee-3763cc619808@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:40:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/27] tests/tcg/meson.build: introduce expected_output
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-17-pierrick.bouvier@oss.qualcomm.com>
 <b7ab8f6e-7600-40ca-947f-e7e357055272@oss.qualcomm.com>
 <tgenec.cusd1nl68lj9@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tgenec.cusd1nl68lj9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gu1yPE1C c=1 sm=1 tr=0 ts=6a29af85 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=vtDBMp4bDa5AtHrscMQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE3NiBTYWx0ZWRfX975xOEIYkzZS
 vCYc00OWOwLC+ujgQTxQj8ojmXEpMW6VQRdfre62llik9wypkyyX61YaXItfugmDZI8A90PsRA1
 yPciYsrp6NCc/8D6VENs+5xSIhue3wsfxRxSh4BDjI2oC/N3FIsRp3Ws67NMEHz0duw0hhdn2q4
 16FklrA9XkNgnrY9hxovmihDz92/p7U/TaswMDV16wJSTnMcF4ix+IZOlaDiP5nxNrIU+ySUuZ5
 9n7e5z91KI3hpMuAjWzvUdaI3hAX2YPg4z1mYFSW4DXD9Cvjf3q1N+2+ZQ9BiR9iduZ/PLbBO82
 vXC872lBmcVsNnHsLGkT5P/JYLyESW0hDlnXc1LdaedOp0/6RUXxguWOEfyZziOlbe0+M6SdwYN
 6wngDAv60UYUlaizV1mi964lH9Wthx/2ajWRwF5Y6DlDqENxbe7ovt8u8QKHpV/iU1l8d2mmR6i
 EGVs82X+lkJmpkwtrnw==
X-Proofpoint-ORIG-GUID: yE2S9nYhyGuDd2zIDbJU4S5MJI7T_JQq
X-Proofpoint-GUID: yE2S9nYhyGuDd2zIDbJU4S5MJI7T_JQq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
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

On 6/10/2026 12:25 AM, Manos Pitsidianakis wrote:
> On Wed, 10 Jun 2026 07:30, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> On 6/9/2026 2:47 PM, Pierrick Bouvier wrote:
>>> A test can declare it expects a specific output on stdout. In this case,
>>> we compare it to a reference file. We implement this instead of relying
>>> on a wrapper because we need the flexibility to resolve name of
>>> reference file per target.
>>>
>>> For instance, multiarch float tests expect different ref files for each
>>> target, which is something we can't express with a test wrapper.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>  tests/tcg/meson.build             |  9 ++++++++-
>>>  tests/tcg/scripts/run_and_diff.sh | 12 ++++++++++++
>>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>>  create mode 100755 tests/tcg/scripts/run_and_diff.sh
>>>
>>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>>> index 5380a360830..3d2c0d6583b 100644
>>> --- a/tests/tcg/meson.build
>>> +++ b/tests/tcg/meson.build
>>> @@ -7,6 +7,7 @@ if config_host.has_key('GDB')
>>>  endif
>>>  gdb = find_program(gdb_progs, required: false)
>>>  prog_gdb_test = find_program('../guest-debug/run-test.py')
>>> +prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
>>>  
>>>  tcg_tests = {}
>>>  # tcg_tests is a dictionary with following structure:
>>> @@ -24,6 +25,7 @@ tcg_tests = {}
>>>  #           'test_name': ['provide an alternative test name'],
>>>  #           'cflags': ['cflags to compile test', ...],
>>>  #           'qemu_args': ['qemu command line flags', ...],
>>> +#           'expected_output': 'file_to_compare_output',
>>>  #           'gdb_test': ['gdb test args'],
>>>  #           'env_var': ['VAR=value', ...],
>>>  #           'wrapper': [program_to_launch_test, 'args'...],
>>> @@ -84,7 +86,7 @@ foreach target, plan: tcg_tests
>>>      foreach src, setup: t
>>>        # return a clear error if user mispell a setup entry
>>>        foreach key, _ : setup
>>> -        if key not in ['cflags', 'qemu_args', 'gdb_test',
>>> +        if key not in ['cflags', 'qemu_args', 'expected_output',
>>> 'gdb_test',
>>>                         'exe_name', 'test_name', 'env_var',
>>> 'plugin_test',
>>>                         'wrapper']
>>>            error('unknown tcg setup entry \'' + key + '\' for test '
>>> + src)
>>> @@ -197,6 +199,11 @@ foreach target, plan: tcg_tests
>>>                ]
>>>        endif
>>>  
>>> +      if 'expected_output' in setup
>>> +        expected = files(folder / setup['expected_output'])
>>> +        cmd = [prog_run_and_diff, expected, cmd]
>>> +      endif
>>> +
>>>        if 'wrapper' in setup
>>>          cmd = [setup['wrapper'], cmd]
>>>        endif
>>> diff --git a/tests/tcg/scripts/run_and_diff.sh b/tests/tcg/scripts/
>>> run_and_diff.sh
>>> new file mode 100755
>>> index 00000000000..d1e9243c49d
>>> --- /dev/null
>>> +++ b/tests/tcg/scripts/run_and_diff.sh
>>> @@ -0,0 +1,12 @@
>>> +#!/usr/bin/env bash
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +set -euo pipefail
>>> +
>>> +if [ $# -lt 2 ]; then
>>> +    echo "run_and_diff: expected_output_file cmd [args]..." 1>&2
>>> +    exit 1
>>> +fi
>>> +expected="$1";shift
>>> +set -x
>>> +diff <("$@") $expected
>>
>> Fixed this line, since it hides return code of program.
>> Write to a temporary file, then diff.
> 
> Also, consider if using #!/bin/sh is possible, since it's universally
> portable.
> 

Probably will move this to python instead.
sh does not have equivalent for set -euo pipefail.

