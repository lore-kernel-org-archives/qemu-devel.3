Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B4BC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7c44-0001pf-3n; Fri, 18 Sep 2026 13:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7c42-0001pU-SB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 13:07:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7c3z-0006H1-Pc
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 13:07:54 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGoFp2508888
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 17:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TzkGwgOGfQ4qWlUdAXViubhnnGYtcCWWHFCp2XE4Xtk=; b=FBgFdMJSvo6Bar0f
 MdFbpRYm12Iaf1QLpkbrS+lEh5b24dqE/O+XTFdDtq3+uNdSeFvpJCxD/Y5//4oN
 jRtgrXI0bx9t9hLHHKZsR3iRLHwPVt5+UqhRSw0kNca1ucqZKJdJqLDeLF2UCImd
 gjqeu0njlQMgrqAua/wV/DI1k84F2+DCW1noXN/dMDy4PKu6NTbEhBA1ABNNQYp2
 gY82gigYCUp2HgEexKMFGOyiY5hA0XhYvxQP4knvkWXJXscwqc64rXsgWr1rE/lr
 f6ShgpB1eJ/i5tU60nnVz3WCg/RoTloRssz5WG4w6OyfZFsAbtEeAvSmzRBeWBje
 ClpypA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs84a0dtw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 17:07:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39b6416441eso1656238a91.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789751267; x=1790356067; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TzkGwgOGfQ4qWlUdAXViubhnnGYtcCWWHFCp2XE4Xtk=;
 b=cefESusoXvT1rUHwdGKOFKKisyE5YObO3WtX6TJV300Ru9hOJDH9s/QhQChxgFD85v
 2YH0rj6DcXFZ1Mz4G64GKABunXnf/3JWiHCCd/7E91m63+uuONKYpax2ScEAKrvJTY47
 gXoxLlBj+kqeFHrnPuaF9nGjBwalXBdVADIC3zGKBFsgVcZRbkoOIO1pjCeaTPrhE8yy
 2b6ovJLIMDDtxuy7RU0h3BTu9uIuooftB/NWoNqWjlMpdsCVg+r8QMOaJVD2OpgfJA+x
 bDsFI5a4kURbjk3qzVbWY8/phSwVPwaUHA4ZPOY/+OqQYFTVchrVEnw207Ptv/OW+xUp
 L6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789751267; x=1790356067;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TzkGwgOGfQ4qWlUdAXViubhnnGYtcCWWHFCp2XE4Xtk=;
 b=z5eWJSA2HDDHLEnT6TvOYCIScqSh69JzrFQ9B9XwN9nrUB6pN6p32rCLONzxySuN52
 LWIOIlogcwn6tP3o+Yso13MF+L0BAbbQwFNuWjGCqggQRInibiA1LFeQRC4wsGAj9FRI
 arHF3eLccE1bKw+BLcwiSS1asaKsdTbgqO1bvfBzVigMu/Cadv2iLnByVra76m4tpwUL
 7QDDORA2TOyiJjl81t9ydA9+PMkD2sOfGgy41D9O3PxC4XIqi7CJy1u54xenYBAFYT5Z
 QZ//afCK8WHwf9Dq4JIjxTgU7ySiy8RJ0kbj+GJLAL/Fo+0+X8YpRJDY9i1ZilKHN4/l
 Hcxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwU/vwXgTfScVcBm+7BVAox7ecC3vVF6hMw0S1YJ3SeYTW+eoRG//IVtNcsrAq2RvpKOI01ESZVISao@nongnu.org
X-Gm-Message-State: AFuF++nnM7uqwvkD6J29Zc8Y33AapRzIhJwqLizzrcgtuKEdAFQQ4Dtx
 i58iCRTpMDsX1wgRJ0LKt0LMgIYooQUaMeqOX0L1awNB7FhJ9el92xePQE/GExF0Fz7yLBNrO1w
 wEiejmeHw0OvDGLsom/NTSJqih4vNO5DhnfFBv7aJaFfvpDJV9Qt1XlzVSQ==
X-Gm-Gg: AYBFou2Z/+Q+ehUWs//cDfN0EPRfLs3C/EzBamKFMzZO2wByUhJLxqq1mv8Cyzi9HNG
 CHe7ZXqfNXFNEFlELUdbZqwpGNWtU7PWT/Hyh88pyv9LNjUO2hTNhmF7dN5hn2cALWV62k+58HS
 0hhSKN8xigYbgYOwxtCMVaGLHSHCHSJH0ON/v9a1l3siz3xgiq/r7OTFKkSc/G/DQ09AJJqFaXJ
 Zb5h4eYEZAjROhiJjIEo7fHRHMhLTZ0mOwCuWVOp48pRJnMMestafa9QtccHBYzvgCN82oP6K/z
 bfq6UGv+rCOk1fKlouF0Q+2+2p9nAB0fQv9neJVuKi7fHdKYSMdojO3fBHTv/E+0xwzOWRAREge
 +Bv6XJcdWAaZ+0OsGKUWqYfYcRliaJsPZ4acAJkp0T+jHHF8slqVxAMDyd7C5gQrtBqEq
X-Received: by 2002:a17:90b:58ef:b0:39e:27e:2f09 with SMTP id
 98e67ed59e1d1-39e54d126b5mr7711635a91.8.1789751266456; 
 Fri, 18 Sep 2026 10:07:46 -0700 (PDT)
X-Received: by 2002:a17:90b:58ef:b0:39e:27e:2f09 with SMTP id
 98e67ed59e1d1-39e54d126b5mr7711567a91.8.1789751265880; 
 Fri, 18 Sep 2026 10:07:45 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c33186490sm112964eec.18.2026.09.18.10.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 10:07:44 -0700 (PDT)
Message-ID: <7393baca-7746-4211-94cd-e0400cb864b2@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 10:07:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic from
 docker.py
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
 <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
 <87fqz77dln.fsf@draig.linaro.org>
 <7a587ac5-b7bb-4c69-a022-3e65e49070c6@oss.qualcomm.com>
 <96e3f93f-a12f-4d18-badd-2ea60efc715b@linaro.org>
 <26dff9eb-b48b-4fd1-822a-806c3e83aadd@oss.qualcomm.com>
 <87a4pf6moc.fsf@draig.linaro.org>
 <d1cf4f82-5604-47b1-887c-99d69cf1b754@oss.qualcomm.com>
 <87y0cy6ace.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87y0cy6ace.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Cr_fUt5Y3S3i3k34swreyKJv6abSCbZ8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI0NSBTYWx0ZWRfX0d4Ovtv0MWK/
 oGxbJgc7GTeM04ekMwtwQPlFM2hMvU2Kqiob0k3k74XJGmJoCt7VxqY/ml+Z1pcARpSfmmwnoHf
 GfffnhrScyk/Y6diujLsLss396EBPXg=
X-Proofpoint-ORIG-GUID: Cr_fUt5Y3S3i3k34swreyKJv6abSCbZ8
X-Authority-Analysis: v=2.4 cv=MLD1C8Zl c=1 sm=1 tr=0 ts=6aad6fe3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=EPOArxBXykR0hS9015wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI0NSBTYWx0ZWRfX6ZdeLMUTeTFZ
 thMPg+1ufOD90QMobRJq+E/JKvJ19Lpa31sbrPCKXaoF8w00F8meHUSIdfJ0PXaRNY9Kan0imd7
 x1a0LWldQ3aaOHaAr32BOi5K4BWlqTjBxhtkG918AGVWi62WXEkBf74n3HnaQ95UZHh2+6C8RGR
 grrMhCScZjulxOIeCv1H9svisHrcSr2KUO3ou4bGAt/PcCDLUe4qnwy/PK++f2Zu3bF8UbDtfkH
 4S1ZUCVYGDxFy1mtpogeQLBnD2gM1B96lklcklDGupi0dLUVTYD9uO+/yYnvqc+owfUmZMpPH2s
 ssfbddp4kcqGwLwYvjs6JdxNmaIcss33Ar5wteZm332SfiW3oYPqp11umcIeT6fgm3pqO2f/zm/
 oF8CD2HelFmB2aERrKzJDkHQ4vo5NelPBzLOwdagmI7dSGHs8euaoatRxe6wv5Zf5TM4sJpN588
 lCqb++VE6YpTyRU8C5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180245
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

On 9/18/2026 4:57 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 9/18/2026 12:30 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 9/17/2026 3:18 PM, Richard Henderson wrote:
>>>>> On 9/17/26 12:00, Pierrick Bouvier wrote:
>>>>>> On 9/17/2026 2:49 PM, Alex Bennée wrote:
>>>>>>> how much time? it flies past when I run a rebuild.
>>>>>>>
>>>>>>
>>>>>> For a no-op tcg-tests build (i.e. with tests already built):
>>>>>>
>>>>>> - With current patch:
>>>>>> time ninja -C tcg-tests
>>>>>> ...
>>>>>> verbose pull and build
>>>>>> 320 lines of output
>>>>>> ...
>>>>>> real    0m15.817s
>>>>>> user    0m1.342s
>>>>>> sys     0m0.840s
>>>
>>>   ✗  time ninja
>>>   [1/114] Generating qemu-version.h with a custom command (wrapped by meson to capture output)
>>>
>>>   ________________________________________________________
>>>   Executed in  515.16 millis    fish           external
>>>      usr time  433.82 millis  968.00 micros  432.85 millis
>>>      sys time   86.05 millis  253.00 micros   85.80 millis
>>>
>>> Not sure whats going on there then. The whole tcg suite completes in
>>> under a minute (and would be shorter if i386-linux-user-test-i386-fprem
>>> and riscv64-softmmu-plugin-discons-with-interruptedmemory where in the
>>> thorough test suite).
>>>
>>
>> You need to run "ninja tcg-tests" explicitly, as tests (and images) are
>> not built by default.
> 
> What is that target trying to do? Because when I run:
>

tcg-tests will build only tests (and their dependencies, container images).

tcg/tests/meson.build
```
if exe_name not in built_tests
    exe = custom_target(exe_name,
                        input: file,
                        command: [cc, '@INPUT@',
                                  '-o', '@OUTPUT@', '-static',
                                  '-MMD', '-MF', '@DEPFILE@',
                                  '-Wall', '-Werror',
                                  '-O0', '-g', '-fno-strict-aliasing',
                                  cflags],
                        depfile: exe_name + '.d',
                        output: exe_name + '.test',
                        depends: exe_depends,
                        depend_files: build_test_depend_files,
                        build_by_default: false)
    exe_targets += exe
endif

...

if exe_targets.length() > 0
  # finally create a top level target to rebuild all tests
  alias_target('tcg-tests', exe_targets)
endif
```

build_test_depend_files contains container images, and eventually some
generated files given in "depends" field of test declaration. It's used
for x86 tests who need to generate headers.

Test compilation generates depfile (.d), which meson reintegrates
automatically, so test depends on all their headers correctly.

```
build_test_depends = []
build_test_depends_files = []
...
      build_test_depends += image_targets[cc_dockerfile]
      build_test_depend_files += dockerfile
...
exe_depends = build_test_depends
if 'depends' in setup
    exe_depends += setup['depends']
endif

exe..
   depends: exe_depends,
   depend_files: build_test_depend_files,
# meson has distinct fields for target dependencies and file
# dependencies, which is a bit confusing IMHO.
```

>   ./run meson test --suite tcg
>

This target will build test dependencies, and run them also.

```
test(test_name, env, args: cmd,
     depends: test_depends,
     timeout: 120,
     suite: ['tcg', 'tcg-' + target])
```

test_depends contains the test binary itself (as seen above), but also
qemu binaries, plugins.

```
test_depends = []
...
if 'plugin_test' in setup
   test_depends += plugin
endif
...
test_depends += qemu
```

Also, meson adds an implicit dependency on every target included in cmd
(args: cmd) array, which includes transitively test binaries and all
their deps.

> it still ends up rebuilding the test binaries. 
>

So from all code above, it should now be clear that:
   `meson --suite tcg`
will automatically build all that is needed (and no more - like no other
test binaries). Also, if you modify an existing dockerfile, it will
automatically rebuilds all tests associated for you.

Same goes for any subsuite: tcg-aarch64-softmmu, which only build
qemu-system-aarch64, needed container images, and only test binaries.

Beyond a better maintainability, one of the goal of original series was
to have *complete* dependencies, so we never need to add fake "all"
dependencies on Makefile level, which is why I insisted to remove the
patch that was doing it for images in this series.

Hope it's more clear now!

>>
>>>>>
>>>>> The variance from the middle of the pacific ocean, and associated
>>>>> network latency, is between 20 and 27 seconds.
>>>>>
>>>>> Amusingly, with the network actively disconnected (airplane mode), the
>>>>> no-op build completes in 1 to 2 seconds.
>>>>>
>>>>
>>>> Funny, on my side if hangs a long time (timeout 30s), then retry 3 times
>>>> per image. I tried it on WSL on my windows laptop.
>>>>
>>>>>
>>>>> r~
>>>
> 


