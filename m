Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1F1C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBVN-0008Lb-7G; Wed, 12 Aug 2026 12:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBVK-0008KD-EK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:08:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBVF-0002tI-4T
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:08:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDdFIl3656233
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 16:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dq3BTiFKZ9jUzV6Fg3ew+Ney2XeJTERdgU8PJ2g629Y=; b=PyRpSAsMlAXvX0B2
 YjIdSvgPKZDUQOhJWMmaINvccmhEdahELCEjBZPDtZK/S/VU7xrLNwN9OaA4Z2aH
 O0GMZFKtO5Zu/B9yshzjzHrq/SLKGKdEtxT/bBEvIK6ZoRxNH8jof2ZCJTzjtuhL
 N218/0xVXS6H74NHXf+RnYmLHLg/2ZOiytxRfd+2pSR+EjwE/q0HLRHOyr9mxyPb
 eB8AdrBNm7gGSMFr8BmfNX5S5LBrCQH78G0fhsJrB4iW/A9fN6rgOgSuUFKZomRu
 HonElPebogG0VVNm/uEnlCNwmQa3ic2t2Y2J8zNcMsxNwEARcQd/yAReDrkIHZmW
 T0yXWw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmysktp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 16:08:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d04908139bso15076995ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786550901; x=1787155701; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dq3BTiFKZ9jUzV6Fg3ew+Ney2XeJTERdgU8PJ2g629Y=;
 b=J3xkPqjqkgRCHrOpC8ZI+2EDFHCq893TNttCjUuM/RkHzPxO+EPIPXvu3pGPStnxju
 Y9lAw7sJM4UHt7HJ8d0xi4Vfgrz+z4IHOYhfKR7mAg030nbXfxJz/R4rj/EYxBEcf8sy
 8pPKz2AYJTUPID3wpM6CTgfxk+6fayNpZmiECNqlhcC8nXZkxxukLLIKRkpaSd2zJm6V
 tFEIzxlXJ9HjyPf58yYV6vNkrqTOWWHZFoEoGiNPYVwvSIJrknwZq1/pEujQTwhkNIzh
 eIun/VZU5m5NrFZ8/LqrNc1g/eFY1NmNACFScKwUi8TJkdRLoKpPELVCyaM9HyVu3m8U
 Qepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550901; x=1787155701;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dq3BTiFKZ9jUzV6Fg3ew+Ney2XeJTERdgU8PJ2g629Y=;
 b=SUrGcssVJomPZ5Ww0O55HU2I8dVntsCYorJXUE0tGK9cXDIXFvmvJYT950Cw2p7MxL
 TqvW9owmaRjtmF7FCNc8+m9MGoCvh6/rnLRlmeVqQkAxxWg/C+Rum10qpW6R7eVg5SFD
 /rv8lTzyrGT3b/jH2nlXSD3KHEHXXP/TIcqsufgJ4CUtWifs6FHtUI63DCP2oL+lF8xD
 jWfWfy5o/rzPvkjxGoBvStk+HN23WyqeKJZ7DsETPiPUggDs9TNAU+mvcIjQuAOQGcPW
 9TFUNRHYeJWOIHW14qmVr1kGlQFHSFEW2hlLii8KGVGGhgpMmEK/fC2ELW9bl4fef+Wa
 6nmQ==
X-Gm-Message-State: AOJu0YziQAJS+84aIzmhYZWLj3UzRW8k78GKaJcb/rpxlSXxtZ2EmNst
 Ii5urTRudb/T9iKfaRfgZ7oN4QU6Jn3g2yIZJUipXT1epMKyznQUXauwnlYX66hJ6pvZ+wxc8tJ
 jnvQuJKsOJX8R9sHgFlgGgf/78RNDBvudiTnmq16faTRLNB05vMvJ13fCzg==
X-Gm-Gg: AR+sD10orggUvPw5+OqXs7oA28S8MaHJsUbFT+wr0sCp9mXVigapwdI7jnnxyWCvAMG
 YVOaSvXmCE6Oc50fTsNO1LAzmhsrUr1rGBe83Q+pGZKVWa6ZS8n590H7rM2QxiFv86PCd97IjRv
 JyNhPB1gfRwTUjnlPM8flhk1zCyG990nQGtSpeY0ogl8WL9kd6PbRc0oHefIFNp7qQtXsDhbcWS
 BbVCkcWR9RUdkCgcgvK0sQypytnFzx3RDaZ/6hnAsiV+pGGOmR0C7VZdODB0XMRsngR5dsl0wfk
 rWO2aI3NiJ7/WlUzYMMVvfYe0ioK++MCu0coy06SSxgZ7Hc7XKKeNfERqFcyoqCxYIhXoKRoMPx
 MliRp6Ruoi0Oed3DGdVoT/IC+zfbRfnlY5WW3ABJpcmhEEpfN3D4CtUZqIiMB52x0goNy
X-Received: by 2002:a17:903:182:b0:2d0:cc92:f7ac with SMTP id
 d9443c01a7336-2d345661fe0mr65091795ad.14.1786550901041; 
 Wed, 12 Aug 2026 09:08:21 -0700 (PDT)
X-Received: by 2002:a17:903:182:b0:2d0:cc92:f7ac with SMTP id
 d9443c01a7336-2d345661fe0mr65091075ad.14.1786550900598; 
 Wed, 12 Aug 2026 09:08:20 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d35117c548sm8988785ad.37.2026.08.12.09.08.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 09:08:20 -0700 (PDT)
Message-ID: <984b5586-4240-4ab8-9bb4-54ec4214ebd4@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 09:08:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 103/103] docs/devel/testing/: update documentation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-104-pierrick.bouvier@oss.qualcomm.com>
 <anxS5H-ldefxUBpQ@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <anxS5H-ldefxUBpQ@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzMSBTYWx0ZWRfX6C9qnT2hleNj
 ysa+DFXbh01LVOUzYDb0LmHM8BoqO6zBN8iACihBcurFknYRXeV9+sDab7k6UA9iN650Gs3WGKn
 hpzqzmi2j5kwrBk++R5fW00RDx4T/nY=
X-Proofpoint-ORIG-GUID: ZDYg0LfrSrm5uFI9E1WtWUnWYuUyW1qq
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7c9a75 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=gK41AM-RggYdnkelLWkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZDYg0LfrSrm5uFI9E1WtWUnWYuUyW1qq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzMSBTYWx0ZWRfX/heGXlAqBkar
 XYQV/53XDihfllddJCahLWaayqMIe8OFcZmyhCSfsJYlFn2htX+EzS1SMtlnKxPXl2cg2EVPCeO
 zegZ05pDT5njSm0So3sxUVJE0XZC5etMSbPAqm6PPkoMCEKVsgbL9AzIrbdd7I6Oga/pknr3qAk
 q/7UqcFFiaTupNvRf/mN2OGelOl2gS0+ndCZR+0DP6ApRpWsRqQDPpC2guLbOhvlXW7WtImxPY9
 yjg5+c830gSkiG6GtDDJsJU9cpdCWtxxIi+1fkvbrl+zh+jb98HxvfBqmT2BBscsn2rD1hnYK0P
 Y+IhAdlRTtLVFeyfx05tK5MmZIZOnI27gyrLLdd118qgskVVKON4xckRDt+uV239Bp/g5kfq+FY
 raV/hKfavhnhBHeWnXvh4aOS/QdKQ+WO+VdfrkDfHVXqdwwKh22KfKPQgixpxkVmP10fkbIkNgZ
 JCAZXe7mdaW62ZsTF1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120131
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

On 8/12/2026 4:03 AM, Daniel P. Berrangé wrote:
> On Mon, Jul 27, 2026 at 09:42:47PM -0700, Pierrick Bouvier wrote:
>> We document how to build and run tcg tests with new framework.
>>
>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  docs/devel/build-system.rst |  4 ++--
>>  docs/devel/testing/main.rst | 33 ++++++++++++++++++++++-----------
>>  2 files changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
>> index 71331e64ac8..c64d40b42af 100644
>> --- a/docs/devel/build-system.rst
>> +++ b/docs/devel/build-system.rst
>> @@ -447,8 +447,8 @@ these sub-Makefiles, the resulting build is largely non-recursive.
>>  Tests, whether defined in ``meson.build`` or not, are also ran by the
>>  Makefile with the traditional ``make check`` phony target, while benchmarks
>>  are run with ``make bench``.  Meson test suites such as ``unit`` can be ran
>> -with ``make check-unit``, and ``make check-tcg`` builds and runs "non-Meson"
>> -tests for all targets.
>> +with ``make check-unit``, and ``make check-tcg`` builds and runs tcg tests
>> +for all targets.
>>  
>>  If desired, it is also possible to use ``ninja`` and ``pyvenv/bin/meson test``,
>>  respectively to build emulators and run tests defined in meson.build.
>> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
>> index c6821a36d99..9cbac144fdd 100644
>> --- a/docs/devel/testing/main.rst
>> +++ b/docs/devel/testing/main.rst
>> @@ -1035,29 +1035,40 @@ See :ref:`container-ref` for more details.
>>  Running subset of tests
>>  ~~~~~~~~~~~~~~~~~~~~~~~
>>  
>> -You can build the tests for one architecture::
>> +You can build the tcg tests using::
>>  
>> -  make build-tcg-tests-$TARGET
>> +  make tcg-tests
>>  
>> -And run with::
>> +And run them for one target with::
>>  
>> -  make run-tcg-tests-$TARGET
>> +  make check-tcg-$TARGET
>>  
>>  Adding ``V=1`` to the invocation will show the details of how to
>>  invoke QEMU for the test which is useful for debugging tests.
>>  
>> +Tests can also be run using directly meson test::
>> +
>> +  ./pyvenv/bin/meson test --suite tcg
>> +  ./pyvenv/bin/meson test --suite tcg-$TARGET
> 
> For any binary that lives within the build dir, it is sufficient
> to use the 'run' script which sets $PATH to search all build dir
> locations, including the python venv.
> 
> IOW, this command should be just
> 
>    ./run meson test .....
>

Good idea.

> Or probably slightly better as
> 
>   $BUILD-DIR/run meson test ...
> 
> to avoid the docs assumption that the user's CWD is at the root
> of the build dir.
>

This assumption is probably fair, given all the commands in doc we give
either are ran from src root or build root folder anyway.

>> +
>> +Tests can be listed using::
>> +
>> +  ./pyvenv/bin/meson test --suite tcg --list
>> +
>>  Running individual tests
>>  ~~~~~~~~~~~~~~~~~~~~~~~~
>>  
>> -Tests can also be run directly from the test build directory. If you
>> -run ``make help`` from the test build directory you will get a list of
>> -all the tests that can be run. Please note that same binaries are used
>> -in multiple tests, for example::
>> +Tests can also be run using directly meson test::
>>  
>> -  make run-plugin-test-mmap-with-libinline.so
>> +  ./pyvenv/bin/meson test $TARGET-$TEST
>>  
>> -will run the mmap test with the ``libinline.so`` TCG plugin. The
>> -gdbstub tests also re-use the test binaries but while exercising gdb.
>> +For instance::
>> +
>> +  ./pyvenv/bin/meson test aarch64-softmmu-hello
>> +
>> +Test command and output can be accessed by using verbose flag::
>> +
>> +  ./pyvenv/bin/meson test aarch64-softmmu-hello --verbose
>>  
>>  TCG test dependencies
>>  ~~~~~~~~~~~~~~~~~~~~~
>> -- 
>> 2.47.3
>>
> 
> With regards,
> Daniel


