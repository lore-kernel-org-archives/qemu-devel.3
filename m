Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F54606A32C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RJ1Tuxpw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bHZF+9F3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPNj3-00043H-S4; Fri, 06 Nov 2026 12:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPNj1-00042o-Q3
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:27:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPNiz-000455-Ci
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:27:39 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6F01bE044269
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 17:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3v9g+H5icHbP4iB0MbLLikJjo629QnchuP1FAbWW1Kw=; b=RJ1Tuxpw+HN9FkkL
 Qo/ITRTCrT1AOC9bxuem2TeXQBKV7gGbFIMBVONBJ8pbxGnFpoITrU2XfhZOOCx0
 tv4mxLz7yv6q7gCmGNQU7hhaGYWgqLicWJG7GHYGbTYOCl2tRQbf48dnVicV3q/c
 pWT4W9raV13wFmfWAe1WgkRJ/XMmjDlFeOtwXQXyE+tuakqyN5vNtDrRykCMdcPj
 u7S9ITu0EyKDso7IaPeBi2HPYz46llK28cxS7Cid1qXVv8SvUqeoh1T7I5CDPOFy
 TdpM2nESqnRNYsY/YUlg6BVdxzVt8bYbl6PgpD88HSn/RWLLKr9mf/Lb4jlLo/Ob
 7GCLSA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa3uuw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 17:27:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3700be873ebso651180eec.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793986052; x=1794590852; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3v9g+H5icHbP4iB0MbLLikJjo629QnchuP1FAbWW1Kw=;
 b=bHZF+9F3+fNmtPvqONQw2dDermHC+TTf8b0uWWZGJGow+hq7B0smJeJFdwJhcH/spd
 SF5OQ9IadQPv/XMYYIBs0dQuHhehymdr2NS2xfgHN5QgTHJ74P/jJNQNTjb0dHjFwmTs
 EJ5HnCwX1qIYtsk+e0XZx7WO2kqE+zMUrZT3vjg5aFb9asZgWQHk2iISqSfrnrtK8ikX
 M1WKFSOzFtacMo1YsVAD0jr7+nt0x1JVFSkSuF6P2USdiwUyBh9uErV1IbW5PUJnlfyD
 FpPZL1+1z9mwxB0vHKjnr6Z2lgGD5yj4uvQQdQvcxiL9a9bP9b9azYqBwPrH7o+OmLJV
 iItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793986052; x=1794590852;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3v9g+H5icHbP4iB0MbLLikJjo629QnchuP1FAbWW1Kw=;
 b=fbRO6ecuXMaBjF1oHiliBpCLVzz5jzMYsoinelzh1ZtEJRJ4kQJZFvP1sBOVOLhVd5
 aQ64ImOLDlM4aehH/cTDBQ6pqV2qSzUY8+NJaZts2SkSSX/aKs9lm8KEC2ZU8J036qd6
 7mObhsDRdlKFmoGYyftg0mIOif/wS8cP/NrsX8XIW9G03JohUX0QpZWqPBg2NGRJOUDP
 4tmsqML+hBqc3wOX3w7UoHNvO0akDyJXZtXJx2I9F+4E0iAZQU2IFng0pHJth5LQGzpH
 KU9he5KaiIIaa8tr9hl3ksynlu5qBQDlZsSNoI/BA8vqSP6L6dSxgcTaG63jz1peMWm5
 qlNQ==
X-Gm-Message-State: APuU4Z+CWunh/2KE3qfyVqafv/B2atTW9zJVjI6XPBGjKL3JXyIOSsGp
 boHw+ZnyCQetPayZC6QBx9gOvU1F1ffCfw1669iJMdBE0N9GAgAYfxi5ssdf3Zy4LubK5NF/XGu
 TXAK2Hpws/6kz/bAx1oxNO76zMELN0rkv1qQPY0fcVYcDlPhGb5GexlouLA==
X-Gm-Gg: AYBFou2awg8Yd9Z0HBGW1ISgjT9XQmc/WF8RlxVcJsgjQlnFvjoLJJcHIIRKrxJvs4X
 yfg2k41WmsVhIP4H/cTZMoDZnFWLNB30WGSU++FI/Hk2aIQRmcebcHOKiUlTZZz9xs0amh9B1oK
 m86y5THqktaABuzstpF+wNY9Jm9luAfOFbIc6FOucwCi+I0RS2mPBAT9lAT+WqU20Uk6nLs58eg
 CsDEwu1IkpIV+TEZI03HScXJwkdxggWOtDGNzo0RyPxHe0KrlbP0cjajxYLv27GsEJMZfBCY2dg
 I4FGXNSsjClSpOzqdihbAv22nHrjBGDEtk5GsCKhJncZfSmLhRvEEddiaAU6DdHklsAeDQtk/x7
 Qwz5fXG4Qd26m9xspDxX4Y/g7fltzoKYH8H11bAlKMitA52jDTSGsiQW4HgnjkEHHsRkQ2fAzDe
 TGveUBMDP4A4r0CRNPE/3R3xJz5rEHXnzz4ADkp3MYuA==
X-Received: by 2002:a05:701b:4192:10b0:1b2:581d:5dc7 with SMTP id
 a92af1059eb24-1b2581d604bmr5594921c88.25.1793986051977; 
 Fri, 06 Nov 2026 09:27:31 -0800 (PST)
X-Received: by 2002:a05:701b:4192:10b0:1b2:581d:5dc7 with SMTP id
 a92af1059eb24-1b2581d604bmr5594885c88.25.1793986051386; 
 Fri, 06 Nov 2026 09:27:31 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4f03f5sm7016905c88.21.2026.11.06.09.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 09:27:30 -0800 (PST)
Message-ID: <8b2c47e7-589a-4e5f-b46d-11cf336e9a1c@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 09:27:27 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "meson: rewrite scripts/qemu-version.sh
 directly in meson.build"
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
References: <20261106155858.3779237-1-peter.maydell@linaro.org>
 <20261106155858.3779237-2-peter.maydell@linaro.org>
 <a66e5489-7898-43b6-a7c3-8a7a3deedbb7@oss.qualcomm.com>
 <CAFEAcA8jLh_5B563-Y-JmhFoimssDB71Lncq8vy4cf9RdqVm6A@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA8jLh_5B563-Y-JmhFoimssDB71Lncq8vy4cf9RdqVm6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aee0e04 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=MYQR_do9cMJfMNXNqZMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OSBTYWx0ZWRfX9/Cb+3DguvbQ
 2pAq0SGlOjfsi3TVtPWdv0sNNE8sYBv9vmpUKzPvEzn97fg6MTO3d0A3rhyazeghBzYE5JAoA2S
 e5/3yC3ucIUFUmPKrDp3lSwuVToKDc0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OSBTYWx0ZWRfX0Q1+GLgtO2xB
 XR1PcgvwkPFrh/IO/ftkh34lBF2mu+dIY/hQ7TF+u12ACbbrQyhDadLjwUL9sg1Su28PB9MDfkH
 1P/f8fis3JofrXgoOMQPIYfzk5y2iZvp0VnAXt5HAadzzGOtr6gP3GLvUXVIbt3tAbtm/kt69uI
 ZxipOIlKC4NEdLnILmVmMYLbkchr3tBUKC0twQ5UUdEexNdsPH8k/yveXy0eY/GcuXDl268rN9q
 r49JB0hqp3tn1nqZUiBMGOtZJnKjrN6SL2/dkfaswYQmNPvLkhKlH7sgowimqJSyEA1a9V85XWs
 CG3eZLdu/48SVPH4ZiRc129CgoXU4hTbCNZ0/q1wzrVJzYNzcKyftqixOZsRdStd7y4iJNmLp+t
 Zjs1zlUzMGDl8ogr/MH6z3UgXv2UBUw2jh+r0UdmNTFZXtTghPb/hk1TGlSLIsSdEm1vWEIJTeh
 FCrrIkYKG2qMPn4V7xw==
X-Proofpoint-GUID: WmyITYQlk9c2RRv_Ssnvu0bPh7fYq8sz
X-Proofpoint-ORIG-GUID: WmyITYQlk9c2RRv_Ssnvu0bPh7fYq8sz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060069
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/2026 9:06 AM, Peter Maydell wrote:
> On Fri, 6 Nov 2026 at 16:59, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 11/6/2026 7:58 AM, Peter Maydell wrote:
>>> This reverts commit ab78ac76f44a1241e76fd32d248df62d83f1ea58.
>>>
>>> The change to create the version header in meson.build loses
>>> the dependency needed for the header file to be built when
>>> it doesn't exist. This means that:
>>>
>>>  * if you delete the build/qemu-version.h file, an incremental
>>>    rebuild fails, rather than recreating it
>>
>> That's not what I observe. From current master, file is correctly
>> recreated. Do you still observe a problem with a clean build folder?
> 
> Yes.
> 
> $ git log --oneline -1
> f71afb409a8 Merge tag 'pull-loongarch-20261105' of
> https://github.com/bibo-mao/qemu into staging
> $ rm -rf build/arm && mkdir build/arm && (cd build/arm &&
> '../../configure'
> '--target-list=arm-softmmu,aarch64-softmmu,arm-linux-user,aarch64-linux-user,aarch64_be-linux-user'
> '--cc=ccache gcc' '--with-pkgversion=pm215' '--enable-debug'
> '--enable-docs') && make -C build/arm -j20
> [...]
> $ make -C build/arm -j20
> make: Entering directory '/home/pm215/qemu/build/arm'
> [1/35] Generating tests/include/QAPI test (include) with a custom command
> make: Leaving directory '/home/pm215/qemu/build/arm'
> $ make -C build/arm -j20
> make: Entering directory '/home/pm215/qemu/build/arm'
> [1/27] Compiling C object qga/qemu-ga.p/main.c.o
> FAILED: qga/qemu-ga.p/main.c.o
> /usr/bin/ccache gcc -m64 -Iqga/qemu-ga.p -Iqga -I../../qga -I. -Iqapi
> -Itrace -Iui -Iui/shader -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fdiagnostics-color=auto
> -Wall -Winvalid-pch -Werror -std=gnu11 -O0 -g -mcx16 -msse2
> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero
> -fzero-call-used-regs=used-gpr -fstack-protector-strong -Wempty-body
> -Wendif-labels -Wexpansion-to-defined -Wformat-overflow=2
> -Wformat-security -Wformat-y2k -Wignored-qualifiers
> -Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute
> -Wmissing-prototypes -Wnested-externs -Wold-style-declaration
> -Wold-style-definition -Wredundant-decls -Wshadow=local
> -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings
> -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value
> -isystem /home/pm215/qemu/linux-headers -isystem linux-headers -iquote
> . -iquote /home/pm215/qemu -iquote /home/pm215/qemu/include -iquote
> /home/pm215/qemu/host/include/x86_64 -iquote
> /home/pm215/qemu/host/include/generic -iquote
> /home/pm215/qemu/tcg/x86_64 -pthread -fPIE -MD -MQ
> qga/qemu-ga.p/main.c.o -MF qga/qemu-ga.p/main.c.o.d -o
> qga/qemu-ga.p/main.c.o -c ../../qga/main.c
> In file included from ../../qga/main.c:33:
> /home/pm215/qemu/include/qemu/version.h:11:10: fatal error:
> qemu-version.h: No such file or directory
>    11 | #include "qemu-version.h"
>       |          ^~~~~~~~~~~~~~~~
> compilation terminated.
> [etc]
> 
> I have run into this problem about a dozen times this week with
> different build trees and different git branches, and it is very
> annoying.
> 
>> The problem seems to be crossing this commit, which we can't do anything
>> about since it's there.
> 
> Yeah, it's going to be a broken git bisect for that part of
> history, which is unavoidable. But the current state of git
> is (a) broken and (b) not clearly what we actually want, per
> the other thread.
> 
> -- PMM

I see, the missing bit I didn't use is '--with-pkgversion=pm215'.
Without it, it works fine.

Any reason you use it for dev builds?

Seems to be something related to releases, which probably won't use
incremental builds.

Regards,
Pierrick

