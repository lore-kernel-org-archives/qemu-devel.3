Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9C8C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 18:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjhx1-0007KY-Uf; Tue, 14 Jul 2026 14:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjhwz-0007KJ-Nq
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:33:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjhwx-0002EF-Ew
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:33:49 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EG6mfN1068100
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xoq09aQjHNFwQS5wRLMVmzw4mkQyDDZxfHmEg18Svyg=; b=ltvxBldacwcENQqA
 DF4DBftI42tBBX5BGKMN4qJvcUI/SDkw/DlXy1I+/m4Cnb1CRc3iYBlco+fUHTxk
 CIcGF7LeQzk6FXnGyastSxKLDm+v40kXqmS7vRhwp1hlEVnBW11fNSzcKd3O5pvy
 NL0ICmxjZboQnCR3Kb9QeHRTI0u4dWH75uNPpk69PsBBGdQ5hAGRvvAyaxm1C5I3
 gRE/ZMJwngR5VJ3oIMBK9bckpzeWoXb0bckBeVxqICkSt358iXnEHDBDH3Ul3/Yj
 euchpo2u0TvRmgqsMEs50uiYYK8D7cOLZkCULyFz4UV+fyXfaR9Ni6ePdKReuIfF
 QLZ5yA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmjq1n92-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:33:45 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88aab7c1fcso10770478a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784054025; x=1784658825; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xoq09aQjHNFwQS5wRLMVmzw4mkQyDDZxfHmEg18Svyg=;
 b=OrVFKqYir3LRw3aYa0R3OH00A4mXj1P6NL8N5r9VmtYmCejuFk1aUUhlCKQT+XjlJO
 ISV4nBZDuV62e4el6TXkD1Uk/Q/q6hd1terYij1gTvndDZGLYnnCawcdaGK7ukfkfT3x
 74Y5TqSiXOBP+iAKbHf567NiQt0VB0S/s603z8ERp9SWmw9wf2LHYxpoMurlxXRuyQ5V
 s5slEA6V7QDtn5ZWaEirtFcIv6n3Tpp7WlSWSG+PCwD+216ZmQEXEkOHmNd4wawU4yAm
 ipLl+3e7uAsLhhLlDc49GSGXc+hKra07ALMDOWrz7Vp/UhzcDcKpT4ncs3sQccHodeN4
 +Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784054025; x=1784658825;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xoq09aQjHNFwQS5wRLMVmzw4mkQyDDZxfHmEg18Svyg=;
 b=HBzVnvH2A1CJFwirIwMUnWQPZbhX5c6jx8ebcWY5nxslO5X87C886mdMTgdIVJgEBd
 bVveMgFuLwaoG5kc2ppSJW/wzo/FmW4Q/K2GN5ULt2PG/q2sg+YhbCKcndNibCf3gCwY
 YSWrHiRE3vGEfQ57fKl7sKcppmhxEZwrp/DXkqhcd4dk5vzuQNyl+DvG14sWS5oJbkgW
 mCVKaLmjCnvUA5HrYwKLUPHc52P+3ldNLBoTt0sUMPx+ujIcT/wIvK6gXbVeQAsv0UqB
 PxTDUiM5TO66DPElpnGF65VRLyu4E6EJ5EJsA65dhCiIpYN7CJHoyE2XfPg/hhrt5Pmo
 pVTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RquVCjPR5Sb5cEQlXM3YNiDn3tc6CZQvmrfW5EMaBme7EbD19VXFnmMmLqcZDEBF+/SOU7nHSxxDWIY@nongnu.org
X-Gm-Message-State: AOJu0YzYw9NzUzeHZhKgLorp0YGQY9wo7/XeYVR7MDvRt/CKpZZEIYtz
 gGtZ979pzzeGrRVoysyEJSZT5wLL5CSm0fR5hkYK7X9NIFBbpuJVH/EeB/cnCzK9XNVJFpXQ0jF
 Jym9w5Pm2bnr6sk8BypQoOwRjmilXfbuYLJYYfxDbCSdW2CK7uXEsGLvObQ==
X-Gm-Gg: AfdE7clNfQ11PUGCHb/jN3g+mJEwfaMdbAHJ9S2F8wrpxneX3riiwK4eM8Mg38AdRMp
 w9/IzUsXkPs8OXtIw8msl5YdXmZd+aTZa2lxNdQd3eD56JDaYoNlNxHjJ4Qz1t3ji1wjfd7otRP
 nnF69cpv+vywijqMoLE8pH+LxAaT7eCE+69IcFe34Py8BReTQurYoqN11djaNTdrnEX+Lpo02dH
 MFI6CzNxBBL9ct0uKKNrcM7f3lWxF5VgvPDAzBMIOhzlW70a+nRWnn/u6rotoTINpF+Q4axSz+X
 35Tyhlfvy+8ezi7U1PV3oAo2IOcOvfJJZal8iHoggruVWXMo4KHgbb2L0p+LRou80yTpql60Rov
 jmMnrMKXQ0g6opnN8uNdEZNZbjza+XwSxeKS+2Zr2JvKT1otZVqqqTRfrFELysgQI3csdhYEhC/
 7TWaA=
X-Received: by 2002:a05:6300:2213:b0:3bf:b931:b3f4 with SMTP id
 adf61e73a8af0-3c3572324aemr4360164637.51.1784054024722; 
 Tue, 14 Jul 2026 11:33:44 -0700 (PDT)
X-Received: by 2002:a05:6300:2213:b0:3bf:b931:b3f4 with SMTP id
 adf61e73a8af0-3c3572324aemr4360117637.51.1784054024144; 
 Tue, 14 Jul 2026 11:33:44 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm149161806c88.14.2026.07.14.11.33.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 11:33:43 -0700 (PDT)
Message-ID: <62ec55ea-59c4-4b70-8e12-c04bb0cb998e@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:33:42 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3a4c0e61-23d3-4baa-878c-a31c7fc2a8c8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LqmiDHdc c=1 sm=1 tr=0 ts=6a568109 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=1IGy7ES-h7rZXMYyGBYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: qWzFmuIU-VNs1lX70Upr1FFxjQu8y1to
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE5MiBTYWx0ZWRfX6LaYrf5KHmt7
 PA84WSlcOLCYcNugfeiNqmmSj54vqvPisRuyLmr9eYfdxebL26nwYVTgesINUD3pP5huBBlzl4q
 TsUWQW5zuTwHy1iMn/BiQLLytRirvEwGdPwT7iBjRgj16x94n2ROK/Hx33w9Ozg/VKXqqFxWxJ2
 VxikO1JdkEMUJNhhhtpBQxCBe6TgMC0No8790NOWCDoF5PGGDSMCBc2uXSYiPp26/djq43kCaAV
 PVvvOVktRbFnU19RYF60UaXpuQf4/waBQ+53Ra4H4UM3z7A73wMrn9bEaLggPLxHEd48vsvR0zC
 +sSNCIR1u/57hTafdc4Mvm1DsvfT+0sEqdCnffLrXBYADjGeHKc9RFJKlh4oLVWXPeNi4SKFmFT
 6cCCHbi4jfQ5wdHeEpb7sSmrA2M06d2shQHsrQjyAA/gg0ZDyOcFC9sc52uloml42gw2pp4wz4u
 wwePgAty5lsv7qgkoZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE5MiBTYWx0ZWRfX9JwrLB/fZ0GI
 DkXoINRaH4Fv/5u2RnONqZ9QOLmSpdsvNyqDz7RdZgPHueyxV2AikLGnaT/ZQKHEfRgwPv+JM0D
 db0xx2kn6o6UlHv3+5ZgaohO8LDnzEs=
X-Proofpoint-ORIG-GUID: qWzFmuIU-VNs1lX70Upr1FFxjQu8y1to
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140192
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

On 7/14/2026 11:22 AM, Ilya Leoshkevich wrote:
> 
> 
> On 7/14/26 17:43, Pierrick Bouvier wrote:
>> On 7/14/2026 1:54 AM, Ilya Leoshkevich wrote:
>>> 
>>> 
>>> On 7/10/26 23:43, Pierrick Bouvier wrote:
>>>> Signed-off-by: Pierrick Bouvier
>>>> <pierrick.bouvier@oss.qualcomm.com> --- tests/tcg/
>>>> meson.build           |   1 + tests/tcg/s390x/Makefile.target
>>>> | 127 ----------------------------- tests/tcg/s390x/
>>>> meson.build     | 138 +++++++++++++++++++++++++++ +++++ 3
>>>> files changed, 139 insertions(+), 127 deletions(-) delete mode
>>>> 100644 tests/tcg/s390x/Makefile.target create mode 100644
>>>> tests/tcg/s390x/meson.build
>>> 
>>> In general the s390x tests work now, however, I get:
>>> 
>>> 155/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-fma 
>>> SKIP             0.09s   exit status 77 156/164 tcg+tcg-s390x-
>>> linux-user - qemu:s390x-linux-user-vfminmax SKIP
>>> 0.07s   exit status 77 157/164 tcg+tcg-s390x-linux-user -
>>> qemu:s390x-linux-user-vxeh2_vs SKIP             0.06s   exit 
>>> status 77 158/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-
>>> user-vxeh2_vcvt SKIP             0.06s   exit status 77 159/164
>>> tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vlstr 
>>> SKIP             0.05s   exit status 77 160/164 tcg+tcg-s390x-
>>> linux-user - qemu:s390x-linux-user-vxeh2_vstrs SKIP
>>> 0.04s   exit status 77
>>> 
>>> with the series. Without the series these tests do run:
>>> 
>>> TEST    fma on s390x TEST    vfminmax on s390x TEST
>>> vxeh2_vcvt on s390x TEST    vxeh2_vlstr on s390x TEST
>>> vxeh2_vstrs on s390x TEST    vxeh2_vs on s390x
>>> 
>> 
>> Can you please run one of the test in verbose? It will print the
>> reason why it was skipped. $ ./build/pyvenv/bin/meson test -C
>> build \ s390x-linux-user-vxeh2_vcvt --verbose
> 
> $ ./build/pyvenv/bin/meson test -C build \ s390x-linux-user-
> vxeh2_vcvt --verbose 1/1 tcg+tcg-s390x-linux-user - qemu:s390x-linux-
> user-vxeh2_vcvt RUNNING
>>>> 
> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1
> MESON_TEST_ITERATION=1 RUST_BACKTRACE=1 MALLOC_PERTURB_=146 /usr/bin/
> env sh -c 'echo "compiler feature z15 not supported" && exit 77' 
> ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> ✀
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
>  compiler feature z15 not supported
> 
>> I guess the cross compiler is not detected, and we need to find
>> why. With following questions, we should know what's missing.
>> 
>> - Do you have s390x-linux-gnu-gcc installed?
> 
> Yes.
> 
>> 
>> - Does this command work? $ s390x-linux-gnu-gcc -static -o /dev/
>> null tests/tcg/test_cc.c
> 
> $ s390x-linux-gnu-gcc -static -o /dev/null tests/tcg/test_cc.c In
> file included from tests/tcg/test_cc.c:3: /usr/lib/gcc/s390x-linux-
> gnu/16/include/stdint.h:11:16: fatal error: stdint.h: No such file
> or directory 11 | # include_next <stdint.h> |
> ^~~~~~~~~~
> 
> Apparently it's the same issue. Fedora doesn't ship cross glibc
> headers.
> 

And we should skip using it thus.

>> - Do you have podman or docker installed?
> 
> Yes.
> 
>> 
>> - What is the output of this command? $ ./tests/docker/docker.py
>> probe
> 
> $ ./tests/docker/docker.py probe docker
> 
>> 
>> Regards, Pierrick
> 

It seems like local compiler was taken even though it's not working,
which should not happen.

Double checking the part checking this, there was a typo on my side.
Sorry, I checked this in fedora, refactored after and missed it.

Could you please try with following change?
It should correctly use container version and compile binaries without
checking if feature is supported.

```
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -192,7 +192,7 @@ foreach target, plan: tcg_tests
     cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/
dev/null'],
                       check: false)
     avail = cmd.returncode() == 0
-    cc_from_system = has_cc
+    cc_from_system = avail
     has_cc = avail
   endif
```

Regards,
Pierrick

