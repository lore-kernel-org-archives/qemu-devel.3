Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D67CC531F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmwMa-0005vw-Ln; Thu, 23 Jul 2026 12:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmwMV-0005va-E5
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:33:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmwMS-0003fN-VX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:33:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NCvJ7L3951315
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 16:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T+NuLyt8RWrwYTLFt6VsUF3RrTFRcA2PcuBtBNqD6Jg=; b=GRqP98CZIhJHB0+9
 4+qLYNZn44FyOqHJ+kxfWr2WTNTESSyNrH0tiZqdPqb2GbRu6RNaKbbOMLXzXdYe
 G2jf5b5B3rQkgUgTPtSYF9jjzC4r+nSUbDYEGDrN/ocpbTKRWV6vB4KL9DKCp6Pp
 6EoZ/Ijf/hOFyUZXEeeu/yJXQ9KgNSUwuk/5eeGhoHaqVVcm18HBd6j5xNPVgjd4
 1mAnTg7pVRox/pxFd3TTb6SqgPYrvj+ducrq5c7ZnBY6ios1sX4M9ByoAM3cL5Q3
 tZppfQisln+ItPiV8bbzgYcvYc8/r3eKPNgW2A3OtN/zsdmlm1e4YMliCak3AfAP
 cxwtyA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkjnu9aa1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 16:33:24 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb733fc5024so1468427a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784824403; x=1785429203; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T+NuLyt8RWrwYTLFt6VsUF3RrTFRcA2PcuBtBNqD6Jg=;
 b=MUjT5g6uU/mkWRNNAI8kG+ckLWjNM9GiDGkJxupKVudtwixLF8ARSMH0+VEyfxMY4P
 zdNI+ouaSBh7G8uGoEsPTHOIELPA5yALP6G2UoJ5KaPLVe8DnKg5h9fPknaaUR8FmIUa
 FSgmerTDz2V8faRSkBxxEubu2P1iN+ZKZI8yvWRkRMUKIMlQKC2+1/F+vSOOc+uz6VOY
 gfl2921vyGfTnnfLJn8LRCZ6KLTaUfrB1PqtdLEHps3Uxz/rOLQGNDpMWVh6KH3fU5aS
 3LuHsQe0JsyPo1Ptei7MbIon6jjOOjhy1pDDmnuUqNc6X8hK2CUPLmMy2b60bMzYlCJ4
 rTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784824403; x=1785429203;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T+NuLyt8RWrwYTLFt6VsUF3RrTFRcA2PcuBtBNqD6Jg=;
 b=M8KkMeGqx5PZjWNX7VTHJ81L0JrwZqG4/W6/b/1oUCGXtwm83bnGpFmCGOG8KhgdKF
 oYDmOUr67SnVjTk4pgxRcQMx7P6SAdmDppqmp3VvRO4/g+FRxET6g7k/0dL6kl/sAQGq
 dZduYblGetipehA5SkScn8ie9pSA5Ys4A+th38eJjwLG/UCZyB3rsiMjhZFgCFFnMG1u
 axeHNe3vgiLoWher4v6QuDR0sy4L7jKxXDLpmgU6uiEQq1yUhQA/5H0mrFtq7KUu7H45
 cfnK29XB5ussRbWpRoqYhqGTtNrOP2aXl0hKo5wuIOBj/bCC/dAyXYsA6zRilU0PNa0p
 SX3g==
X-Gm-Message-State: AOJu0YxhN2pNzFzfuNcbGcbACx3MXbxow/TgmumLy34AbGX+EN+ksd4h
 QeYUPdDTZ08lmLkFjfueeaBk9JTw0uCNH6XHprRPTaBUkri2xLI+AOPzwdDxZhM9kUCvHC5bYwO
 GqTQ6qTzth17QDKFU2EXV0khSyHkr3y21JOV8UV8Wr1FaTDyUe3Yw2vzfMw==
X-Gm-Gg: AR+sD119oJaN353tQwsIvtsXVelCBDalt04t1KE8AkJh1Mevz68lMilBA/a19lKH8We
 PRlJ2BEOUFEi0vWDhPaIP3VVeWisHS20X2Ji9VK2QgoiQOLnM22OPcxCEqZUJ9QIH185cy9fMmQ
 15D4hftxHeIO6fnkaRk7Nvoeh4KkEM+4st3pSj9cQqbNXPfyXlLgBSb2iJRB3YOwnubwYFCmG5z
 E2tv3N55Z3VIph1HfcngiyTBrpy+6cJ2xr0Zi+78vvyWToQ02rYhzlpQYKPVtTeHs1J9lwyRKKa
 oZgKsffePNt2zjb/bURPQ0SYOJLSOQokvvEHo8e+ImqJD6KELTkevjS1+UIYxVberWjE1CjKbmI
 PyrrpYBW6ZblK+E32HJUnyuvjZ4F5p92uIcMPGRpnBRvMgEqoUsFqW+fDBU/2QoV0ttLW
X-Received: by 2002:a05:6a21:2d46:b0:3c4:46ca:334e with SMTP id
 adf61e73a8af0-3c44b2c2321mr4238418637.72.1784824403305; 
 Thu, 23 Jul 2026 09:33:23 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d46:b0:3c4:46ca:334e with SMTP id
 adf61e73a8af0-3c44b2c2321mr4238358637.72.1784824402540; 
 Thu, 23 Jul 2026 09:33:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1b6a45sm21230398eec.28.2026.07.23.09.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 09:33:21 -0700 (PDT)
Message-ID: <c16b4480-06fd-4d96-b628-5c423d300988@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 09:33:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 97/98] configure: remove --cross-cc* options
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-98-pierrick.bouvier@oss.qualcomm.com>
 <87wlupst0e.fsf@draig.linaro.org>
 <0ed09a8f-2de8-4910-b853-cd717dbf3317@oss.qualcomm.com>
 <87se59r999.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87se59r999.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _OlcLWytU8zCLxlbYCBzLUyfr1iXY2ST
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE2MiBTYWx0ZWRfXztz2/qHLvT8g
 RcoQS6FHe+VOE795xpvg6qslTly3RpPuIEck5Em+m3OukN7wB9RP7/2qdxQAn38qKvaXW9mFXOW
 8AhCptFTK6Oojidjvu/4jIdhCPV266xsIum3RfsK8NMHZ69/P6pwuAs7zmCa/mzvGdmx6nZ3sNE
 50BZNUWnJdmeclziYa1eBUjxMWErOpGfXMw+T7+uR9R3+PPq1T+uzL5dhNzwJZRoHtjYq/Roeoe
 6WicbbWidsCvgrWFatYt/LufK4wUZMVloI1/0YM5Eji3PP97mKGyaLJFq7zP1TitfRxjrbKwIzK
 uHoaGulLnhDaBkoSVhuTowmZChMyARvvCBOqDfrVky6Nn5Px92VstUmJZ+tJ1Am/aOj63HCjMlo
 InLtsdZNP97Y/QNtadd0R/BsTgO+CmJSIPttI9XM7RggNBfWawxI4CbXNjIyt2hYCB67rb8lBSv
 HLk4pnrOlBePpzfvqTA==
X-Authority-Analysis: v=2.4 cv=Een4hvmC c=1 sm=1 tr=0 ts=6a624254 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jDHOMGtdI9Rblyo4078A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE2MiBTYWx0ZWRfX2XhhjOidg4q8
 tkk+jm5q67l8rLDLlLHD5qdXpOOsfo7RqaraUcNY5WAThz6DZHwGEsKs8zV91QWbhY+O2jIUsNp
 t4NY6A7TcZdFsXcGW2bDHC/wGTBEbig=
X-Proofpoint-GUID: _OlcLWytU8zCLxlbYCBzLUyfr1iXY2ST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230162
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

On 7/23/2026 8:55 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 7/20/2026 6:14 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> Those options were useful a few years ago, before containers were
>>>> available as an alternative for missing cross compilers. Simplify the
>>>> workflow by removing those options and maintaining only the container
>>>> based approach.
>>>
>>
>> I was expecting some discussion around this patch, and to start it when
>> the comment comes. Question is "Should we provide this feature or not?".
>> I totally agree with you that we need to support other configurations we
>> have in our CI, like MacOS and compilers from homebrew.
>>
>> However, instead of implementing this by keeping --cross-* options, I
>> would be more keen to turn 'cc' into a list, instead of fixed choice.
>>
>> For instance, instead of:
>> # tests/tcg/aarch64/meson.build
>>   tcg_tests += {
>>     'aarch64-linux-user': {
>>       'cc': 'aarch64-linux-gnu-gcc',
>>     ...
>>
>> We could have:
>>   tcg_tests += {
>>     'aarch64-linux-user': {
>>       'cc': ['aarch64-linux-gnu-gcc', 'some_other_variant-gcc'],
>>     ...
> 
> The trouble is this will lead to quite a long list as every distro has
> its own naming ABI. While Debian covers most things its not everything.
>

The way I see it is that we offer native cross compilers (with a focus
on debian at the moment), and the containerized ones: people have a choice.
We can add any additional compiler name for other distros.
Also, as Ilya mentioned before, cross compiler on fedora, for instance,
are not providing any sysroot. So it makes them unusable in our case.
So I'm not sure which other distro you would like to support that is not
(alpine, arch, slack, other?).

In all cases, just let me know what are your exact requirements (distro
list and set of compilers) and I would be happy to make it work just as
you expect on all those platforms.

>> I think it's a saner choice, because one problem with --cross-* is that
>> it allows people and maintainers to have their "own" setup, that are not
>> documented anywhere. By forcing compilers to be added to dockerfiles and
>> paths to be explicit in arch files, we make sure the same CI is
>> reproducible for everyone.
> 
> I agree the ideal is everything is dockerised for CI but there are times
> its not practical:
> 
>   - working with very new features on bleeding edge compilers
>   - binary only toolchains for the more niche architectures
>   - unable to run any containers
>   - running the test inside containers (this is why
>     debian-all-test-cross has qemu-minimal pre-reqs)
>

The point of containerization is to hide those details in a reproducible
recipe. For instance, we could definitely provide bleeding edge gcc to
have the latest features.

If test relies on a specific machine setup, it's basically dead code: CI
and other devs can't run it. That's why containerization is important.

>> A good example of that is xtensaeb, which was not in docker container
>> file because it could be set with cross-cc-xtensaeb.
> 
> I suspect it was more because its a niche of a niche of a
> under-maintained port and it just hadn't been gotten round to.
> 
>>
>>> I'm confused here - I thought we wanted to keep local cross compilers
>>> and provide containers as the fallback. Otherwise it will be very
>>> difficult to test against newer compilers without having to rebuild the
>>> containers.
>>>
>>
>> That's exactly the point. By making it hard, you force by design things
>> to be reproductible by anyone and documented. In this case, by forcing
>> the people who wants a newer compiler to provide a dockerfile patch for it.
>>
>> Another example is the aarch64 test with have require a bleeding gcc-16.
>> It's not even installable via debian repositories at the moment, it
>> means the test is just always skipped in CI. So basically, it's not
>> testing anything out of the original developer's machine who has the
>> "right" setup. In this case, the right fix is not rely on latest gcc,
>> but add manual the needed opcode so it works on any version (see patch
>> included in current series).
> 
> Hand coding the opcode will work for now, but eventually the gcc's will
> be updated and we can generate from gcc. It's easier to extend tests
> will inline assembly than hand encoding ops.
>

If you take some time and look at the patches, you'll see it adds all
the needed infrastructure for when we'll have a gcc supporting it
available in debian-all-test-cross container. So it's not a "will be
like this forever", just the time people can access easily the right
version.

As mentioned above, until there, it's basically dead code: no one can
run it.

>> For those reasons, I'm really much more in favor to provide a default
>> that works out of the box, instead of "it works on my machine with a
>> custom configure option".
> 
> I agree the default should be working out of the box but I still think
> this is removing developer flexibility which will result in an up-front
> barrier to getting tests in meaning they are just as likely not to get
> written than the developer going through the process of working out how
> to package the compiler.
>

This should be considered though. What's the point to add a test if dev
doesn't want to commit providing recipe to build it also? "It works on a
given machine" is the only thing we can ensure.

Also, I would like to point that in all the 1500 tests, only 1 is
concerned at the moment. I'm not sure we can call that a "general" need.
It's a one line code change:
https://lore.kernel.org/qemu-devel/20260710214343.2065491-38-pierrick.bouvier@oss.qualcomm.com/

If we keep providing --cross-cc-arch options, we explicitly make sure
people can keep on adding dead tests by design.
Also, if I can help maintaining this, you know I'll be as reactive as
I'm on other subsystems, and won't ignore an email asking for help to
package anything.

If it's still not convincing enough, let me know, and I'll add those
features back. I made a good effort to address all requirements and
remove any "implicit" aspect of our test suite. I would like to make
this effort complete, thus why I insist in favor or removing it.

What do you think?

>>
>>> Currently the MacOS build relies on local compilers built via brew.
>>>
>>
>> Let me know which compiler is used on MacOS for cross compiling every
>> arch, and I can add those to next version, so it can work out of the
>> box.
> 
>  Cross compilers                        
>     aarch64                         : aarch64-elf-gcc
>     i386                            : i686-elf-gcc                                     
>     x86_64                          : x86_64-elf-gcc                                   
>

I see our only usage of cross-prefix-X is for .gitlab-ci.d/macos.yml, so
that should be easy to provide same feature, and extend it. I can add it
by default in case you would reconsider your mind about --cross-cc-*
options.

> but brew also packages:
> 
>   arm-none-eabi-gcc
>   riscv64-elf-gcc
>   m68k-elf-gcc
> 
> The arm one isn't being picked up at the moment, I need to debug that.
> The other two aren't yet useful until we have system mode tcg tests for
> those guests.
>

I think it needs to be added to .gitlab-ci.d/macos.yml also, because
configure can't guess that by itself.

>>
>> Regards,
>> Pierrick
> 

Regards,
Pierrick


