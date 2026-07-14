Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3199C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 18:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wji31-0001cw-33; Tue, 14 Jul 2026 14:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wji2t-0001ca-Kj
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:39:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wji2q-00039i-Uj
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:39:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EG78v51146741
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j7LaM4B+d3cfmPvr55Ql8FHAJ7u6UTQnmo3ZA1sXMW0=; b=BM9w1WgT1Z2LsPxO
 VWNHvMB4CZhQHao7p8Of8Mzp3UgYRO6kX+4vA0cCJic/2brySl+uGOrIMxLQ0cUa
 rk/9sg+ZLIBeK1gvYjWxFiH/a2/ILctIlwBF/pUy6zNXs0UAxms8lOC5WH8xzPgp
 hKJVlW8NB77MT3Sj85bFKrbXatbPNr/w57HUmUU36d9XfhwGAVV6hUvX4T6pXCgy
 h0jKoiJhsbhH/95g0Q2+gdd/3Ey9UVPnA1s6YVHWsIgM+pvinxL8Wph0QVpgp6Om
 IYpoqHa0n7hiNpdD9wIdZJCeuO/CdbFvJQ7ALua1nwrqdB/Kju8uYKmTSDI5Mlty
 J6tf1Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnuscsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:39:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc86a9ef97so97381735ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 11:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784054390; x=1784659190; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j7LaM4B+d3cfmPvr55Ql8FHAJ7u6UTQnmo3ZA1sXMW0=;
 b=frgWQohkDclZMfi4lxjTE3VzmlmfKkH7CmWHjOYiqXqIzbalh9evNZYAp2OAD3RmcB
 GGN3ajWGwWJkiMYXnYK8GfsymWOPEMI/w3oZF1PuCgaVU1yzrK2yDWQEuKgTbaq40BJY
 QdOluzHIscAA8Q5M3zPbeQjGEg3lgR6yS7S7o7ElLUiYmmAmnN1RjNDS0h6hyesfeAM/
 UMt/pgbG4W3TxD/pY8qKr8weIIWC62mnXAdJhCD92lxmNfKgWkgxygE+x5Oh8bj0YPcR
 fK65cHuTdsSKUYvZK4lvL4pvIJ7pFgFZMnVulmNihBqbClHpi8KbJnBVCuK6oEcm8u8C
 x2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784054390; x=1784659190;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j7LaM4B+d3cfmPvr55Ql8FHAJ7u6UTQnmo3ZA1sXMW0=;
 b=mcUhxdWFwUESsZRVbln6pWel1cy1VXw2baMchvN8rq7cp7JQb7iZYx/uUt9sdzUP1/
 /JM1CCjhW7kwTvJEPpoEKbhocWWiavWrIeD8fMQLwTBysmF0g50dR+yKDBF14IWmDc+v
 1/t6gTub0yn4aBqbFNmY49FUvodU74Kw8QYtkNt6G9WojN/ShKp+AeojyNfGEQMQOpok
 CeYUbcF8WJH4C62/R98qP1FMvQcbiW2OsqpI29iLcBrTXy74EZ7QxdB0HCG0O/LPhMEG
 6hFAm4r2gpWk/sSKAotkNP0BKX0ZU+C5jlhjlepNfqCa/aAJ87KIRG09/GGxzyUvxqGt
 59CQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RocpqYX2GHGIpIMFb+GfhjewUR5Gn6WOZrCqOHHWgfSa3SX66k186DJyTUinRSI0WHaJeArWVhrIjZT@nongnu.org
X-Gm-Message-State: AOJu0Yw79qgeDLNSGeygitsm1PAP5k8lJNBtsM45b4nlHIxdNaWSzVwp
 dRYXF4l3eNPWqOqajOrEJGcjXVR7PinuYSctbqN+82ufDbs+1Zh7DHu08vSF5V/e7+ZsMs430q4
 ntg9NYiVfxGwkAnsSis/NnpJUOEmYSm/VuRqy6HjAaQ5f3ffhUfaEIXQiKw==
X-Gm-Gg: AfdE7ckhXGn1ZlFm3z0YJ2x58I8XBlSm4RwYKKtx1ct2kw2Rifkl1rG0mNx7Q/g/jME
 AH9vjt7eMNW78o187tPipoPyICSaquj1yTcTCT+JQ26X3dnQCbWyrJ9qeZ039AFuIjXPSw1Ggc3
 1282WJG+OZ+bmZTom/VFvMwg1f+jxvN9M5dOzSwGbYRzTqwVJe/X3p3u9+DWKCq7zsx/h8FLC0c
 Ptmh5NHCPesQh9VdsJ0olROi+LeYtfUhlYHW1sMrPEcWhjdLEgPUqOAzzsKTIjsLTxEaWA+t/B+
 uaHp7LW78e4eYlJuwXuf+fyFdoPirppNIV6yAFpPiRy7tZSl/OBjsUIFQWG7KXPhRmvBpbvrTC1
 Pss40J3fUPduBFHZ9ZfyrxBsYv7/zzSNAdDruBVY8ELbxJ+GgPuntHzMlXYxo7txAfrC3ci+HgX
 BMp+A=
X-Received: by 2002:a17:903:3205:b0:2c7:f4bd:91b5 with SMTP id
 d9443c01a7336-2cee98446f9mr55679965ad.0.1784054389648; 
 Tue, 14 Jul 2026 11:39:49 -0700 (PDT)
X-Received: by 2002:a17:903:3205:b0:2c7:f4bd:91b5 with SMTP id
 d9443c01a7336-2cee98446f9mr55679735ad.0.1784054389146; 
 Tue, 14 Jul 2026 11:39:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b9a67c217sm24419591c88.8.2026.07.14.11.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 11:39:48 -0700 (PDT)
Message-ID: <78b111ef-5873-4cb7-ab15-879f3ba171e6@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:39:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 82/98] tests/tcg/s390x: user tests
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-83-pierrick.bouvier@oss.qualcomm.com>
 <584dbebe-6105-45a6-ae4d-d0fb4fc6eaaf@linux.ibm.com>
 <24690de5-8178-41bf-94f6-cd383f599b2a@oss.qualcomm.com>
 <3a4c0e61-23d3-4baa-878c-a31c7fc2a8c8@linux.ibm.com>
 <62ec55ea-59c4-4b70-8e12-c04bb0cb998e@oss.qualcomm.com>
 <fd573325-c8bc-458a-bbe2-041d4e6e3206@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fd573325-c8bc-458a-bbe2-041d4e6e3206@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vFJmUq1MsUqDDeioKBRFIGv-IbvVjSSh
X-Authority-Analysis: v=2.4 cv=E+v9Y6dl c=1 sm=1 tr=0 ts=6a568276 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=c6si1dUfamQGHOI6g7cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE5MyBTYWx0ZWRfXwHGlTKd1J7VA
 +SuPspRhz3OHdCGabYzeQPUYFAtqJHYpmQBPEiO2L8LtXsC81ah5l4W/Dj4feIUze3K+5PSldFM
 yCZxqyKAcsZRR42p7Slk5Bf8qTQpc3HWx7Q5XoSIe80oOcmzkGpu0Twf6T13bobvVuTfzJGP41Z
 gLFjoajgJwm86xjyHNlXiJFAJnlZ8YDG1bDmm4GFxOzgHuW6F2oBtbkop718at9uRT8pA8FESMR
 5qBZGb43yHqrL65NSXhAqSahN0tcbiwL9ywQz5sZ5vBCyxMlTS2eHpTec0bWr4+ckT0iObWa0n3
 leIGSPh9il9HeJ9qXKYOwP0fxjpr4BOHNVzP2ccjVtzelvooqOdwzc3HE11bLY9RaByncZsricv
 ygxcoRYc3BAvITMAMhKo/Bm9kfG10Ogm3W0wpRKmELw0oIu4uKY2yYN9HO56vruOyrrv7WVE/hD
 BQ7D5MlaxUL0AdM1M5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE5MyBTYWx0ZWRfX+baunPzqxMzg
 KNMKXwaAzrhtPngnPlPpsgTEPuE7Zg0r63jWTZMao1keAkDP/mNZMr8G1aWseOwwwtvAl530nj+
 NCmg8rRBXtNh+p52cd0ygFOpBlRF7W8=
X-Proofpoint-GUID: vFJmUq1MsUqDDeioKBRFIGv-IbvVjSSh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140193
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

On 7/14/2026 11:36 AM, Ilya Leoshkevich wrote:
> 
> 
> On 7/14/26 20:33, Pierrick Bouvier wrote:
>> On 7/14/2026 11:22 AM, Ilya Leoshkevich wrote:
>>>
>>>
>>> On 7/14/26 17:43, Pierrick Bouvier wrote:
>>>> On 7/14/2026 1:54 AM, Ilya Leoshkevich wrote:
>>>>>
>>>>>
>>>>> On 7/10/26 23:43, Pierrick Bouvier wrote:
>>>>>> Signed-off-by: Pierrick Bouvier
>>>>>> <pierrick.bouvier@oss.qualcomm.com> --- tests/tcg/
>>>>>> meson.build           |   1 + tests/tcg/s390x/Makefile.target
>>>>>> | 127 ----------------------------- tests/tcg/s390x/
>>>>>> meson.build     | 138 +++++++++++++++++++++++++++ +++++ 3
>>>>>> files changed, 139 insertions(+), 127 deletions(-) delete mode
>>>>>> 100644 tests/tcg/s390x/Makefile.target create mode 100644
>>>>>> tests/tcg/s390x/meson.build
>>>>>
>>>>> In general the s390x tests work now, however, I get:
>>>>>
>>>>> 155/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-fma
>>>>> SKIP             0.09s   exit status 77 156/164 tcg+tcg-s390x-
>>>>> linux-user - qemu:s390x-linux-user-vfminmax SKIP
>>>>> 0.07s   exit status 77 157/164 tcg+tcg-s390x-linux-user -
>>>>> qemu:s390x-linux-user-vxeh2_vs SKIP             0.06s   exit
>>>>> status 77 158/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-
>>>>> user-vxeh2_vcvt SKIP             0.06s   exit status 77 159/164
>>>>> tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vlstr
>>>>> SKIP             0.05s   exit status 77 160/164 tcg+tcg-s390x-
>>>>> linux-user - qemu:s390x-linux-user-vxeh2_vstrs SKIP
>>>>> 0.04s   exit status 77
>>>>>
>>>>> with the series. Without the series these tests do run:
>>>>>
>>>>> TEST    fma on s390x TEST    vfminmax on s390x TEST
>>>>> vxeh2_vcvt on s390x TEST    vxeh2_vlstr on s390x TEST
>>>>> vxeh2_vstrs on s390x TEST    vxeh2_vs on s390x
>>>>>
>>>>
>>>> Can you please run one of the test in verbose? It will print the
>>>> reason why it was skipped. $ ./build/pyvenv/bin/meson test -C
>>>> build \ s390x-linux-user-vxeh2_vcvt --verbose
>>>
>>> $ ./build/pyvenv/bin/meson test -C build \ s390x-linux-user-
>>> vxeh2_vcvt --verbose 1/1 tcg+tcg-s390x-linux-user - qemu:s390x-linux-
>>> user-vxeh2_vcvt RUNNING
>>>>>>
>>> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
>>> MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
>>> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1
>>> MESON_TEST_ITERATION=1 RUST_BACKTRACE=1 MALLOC_PERTURB_=146 /usr/bin/
>>> env sh -c 'echo "compiler feature z15 not supported" && exit 77'
>>> ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
>>> ✀
>>> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
>>>   compiler feature z15 not supported
>>>
>>>> I guess the cross compiler is not detected, and we need to find
>>>> why. With following questions, we should know what's missing.
>>>>
>>>> - Do you have s390x-linux-gnu-gcc installed?
>>>
>>> Yes.
>>>
>>>>
>>>> - Does this command work? $ s390x-linux-gnu-gcc -static -o /dev/
>>>> null tests/tcg/test_cc.c
>>>
>>> $ s390x-linux-gnu-gcc -static -o /dev/null tests/tcg/test_cc.c In
>>> file included from tests/tcg/test_cc.c:3: /usr/lib/gcc/s390x-linux-
>>> gnu/16/include/stdint.h:11:16: fatal error: stdint.h: No such file
>>> or directory 11 | # include_next <stdint.h> |
>>> ^~~~~~~~~~
>>>
>>> Apparently it's the same issue. Fedora doesn't ship cross glibc
>>> headers.
>>>
>>
>> And we should skip using it thus.
>>
>>>> - Do you have podman or docker installed?
>>>
>>> Yes.
>>>
>>>>
>>>> - What is the output of this command? $ ./tests/docker/docker.py
>>>> probe
>>>
>>> $ ./tests/docker/docker.py probe docker
>>>
>>>>
>>>> Regards, Pierrick
>>>
>>
>> It seems like local compiler was taken even though it's not working,
>> which should not happen.
>>
>> Double checking the part checking this, there was a typo on my side.
>> Sorry, I checked this in fedora, refactored after and missed it.
>>
>> Could you please try with following change?
>> It should correctly use container version and compile binaries without
>> checking if feature is supported.
>>
>> ```
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -192,7 +192,7 @@ foreach target, plan: tcg_tests
>>       cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/
>> dev/null'],
>>                         check: false)
>>       avail = cmd.returncode() == 0
>> -    cc_from_system = has_cc
>> +    cc_from_system = avail
>>       has_cc = avail
>>     endif
>> ```
>>
>> Regards,
>> Pierrick
> 
> Perfect, now it works. Thanks!
> 
> 142/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-fma
>                                         OK               0.04s
> 143/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-sha512-mvx
>                                         OK               0.04s
> 144/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vfminmax
>                                         OK               0.04s
> 145/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vs
>                                         OK               0.03s
> 146/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vcvt
>                                         OK               0.03s
> 147/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vlstr
>                                         OK               0.02s
> 148/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vstrs
>                                         OK               0.02s
> 

Thanks for testing, and sorry for inconvenience again.

Regards,
Pierrick

