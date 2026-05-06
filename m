Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3DACD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 17:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKgJC-0007pE-0A; Wed, 06 May 2026 13:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKgJA-0007p4-Gu
 for qemu-devel@nongnu.org; Wed, 06 May 2026 13:45:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKgJ8-00041Z-23
 for qemu-devel@nongnu.org; Wed, 06 May 2026 13:45:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646CYOSu1514824
 for <qemu-devel@nongnu.org>; Wed, 6 May 2026 17:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pfGr9sBziC2buBnsrHOpYy0py46oN6ysBzrpDlsotro=; b=Khi9HCdHpgjK2Z0R
 6jE+w11jCAH3Tq1SYfNGg2RGyjlfSsbb76cRhRNBCHhuiDhK73+w2HEITNpBnoQ/
 suagF1953IOlxMP7Mns4MiIbI6k8P3LY+VSBNHqluIBaZw2ERGlrkQT3Z26CRhzU
 cz2AHNwj2W7JUC+vTaN5EPqSMFSGtwQa7Y0DJH/ziLkDX5bLoJjajDt/L93tyDoB
 peYFAA+p8ElXsxElnZsnCDVRXMpbiUOf/NJ5T/qxpVaIiZCUQ5N9T7ONpyi/a2eD
 74cXXY1U++DmMYIa4YdP4bQeF2+p4wiIc98esXriL70A1+LsWCumsGEZQUqTiJjL
 suik8g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e00v1tk9g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 17:45:11 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12dfb99429bso13979925c88.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778089511; x=1778694311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pfGr9sBziC2buBnsrHOpYy0py46oN6ysBzrpDlsotro=;
 b=S6ZUZetntztY4aTBQs0oSCbQOdUcQsWA+OZF5rIbq59ZXy50dBk9PN6jm1fqCQX5DU
 ljPzA/NRUXTVn5mUV+PNU3zPAYuh5SHmrkzi4u2LuA+AIB2RzZkO8X/Wz+w3OkOsnjCj
 dGlNLEWHOheZd0SHh9CLYY7n5zIyomRkCe+jESh3D3Bzu8tgXHhX2ZIjPDiRcy/ViXQA
 RWOvrli3ZPnaIQPZO2DtjKxeHmeKRRQB7XM0zMs30Rm8La5iFRcBw8fUu4YEQMGh9tf/
 uZfEwqnWHjpTVcuCySLN919Vq+HIMIUE6qytkzcQZz4q8J4bvj5daj7lw5EpSqMey7yQ
 918g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778089511; x=1778694311;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pfGr9sBziC2buBnsrHOpYy0py46oN6ysBzrpDlsotro=;
 b=Qc3Vk6+3SSozLcVjpbZA2Tf/a3BRHB8C5z65tzox8bRo61LNb+9ArpSdhDHUcl56Mr
 7XYZILJTl4ANf5efKUeKUBjcc6coiOGMiqt8P+Xs5TRewq2JrjFyMubij7dLaa502Wrn
 JcsnbQgEGrUTl07+ea9S2lsgKh5lo9fmsrW4KVVJfinUyl4HHVV/shD2GdKGXKybxHBC
 /L4VrlkgM4zZE90kFJdtMjmd60xGXLxgJw7Vg/fBKybxjMq9W9xxPu78xsavLTzpj5H7
 1VwRYXNrSl87vPXe0zafdh3or86/Kq+6Ml/VN8xnJ7VEPa49asLQaBjEln/pmLREPeFK
 x7Ag==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ooH0ycIR31Nbk4U4uYuc615fDbL055xAPANQoqTscN8DLsYQJViiiFEHBv9EdOl6z29xXxCm5kic1@nongnu.org
X-Gm-Message-State: AOJu0YzwcNvylnbxR509igTPEQHggiAx9lNaCa8Sw6SIDWgtaUTArA+z
 GS/g/uyr4kW4uxUREGS6PNU9gwMU63GTPKB5eAY7piSIw18Jywsr1sACDt2IpMTFYomdjdGNu00
 m1/9LVtbfzl01y2KoA9y9+JUFM6Rsjlx4PSvF3BaV1o4q50uQDCfuJApOow==
X-Gm-Gg: AeBDieuM1PCqTXbyYCKJxC9iqP1ZY3Urhe2lro8EAX/zf4lYEq9GlB+YLiMtArAKPLi
 tHfh3IDk40fgtyyD4E8SrDo26KjY99sEYaOoeV1qpBjGhTLTsIzW1xK/Nuy3EDBQHXB0kjVnD8o
 z+c+deO5XRhVxXHsstijipLtBjahhd3ZogrU5tXUR8a52lY2IRAXjVbTqgfNdTpismD/lIZ8cQ1
 4Uvfb+6bF+skOqBlr15i93voFEyCaOWoIDB8gbMGHZUxygGOxyQvCYb9J6hJxQxIPDYyQSSKQ/U
 iqnWVRykIu7HMFFtGMjL/0l741FOyBB+lvVs30TSwicS7jaA35p7EQtQZc0CFHVcQikTpsUUE0f
 910zQ0MTgLvObXedLoYmty8apzSgbaAmrzODVMNS+SaJFB3bKYcXJtBi8fkhUZf3vjTvOGfXrAm
 asi+s2cd9iO0zfYLop695pFKMf
X-Received: by 2002:a05:7022:1a83:b0:130:68a1:a221 with SMTP id
 a92af1059eb24-1318eb57bbcmr2371407c88.38.1778089510891; 
 Wed, 06 May 2026 10:45:10 -0700 (PDT)
X-Received: by 2002:a05:7022:1a83:b0:130:68a1:a221 with SMTP id
 a92af1059eb24-1318eb57bbcmr2371358c88.38.1778089509731; 
 Wed, 06 May 2026 10:45:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f57038b096sm3885176eec.27.2026.05.06.10.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 10:45:09 -0700 (PDT)
Message-ID: <fdf34d9e-75aa-43b0-a70c-9ea59e4a3902@oss.qualcomm.com>
Date: Wed, 6 May 2026 10:45:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Build system: add stubs per target
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com
References: <20260505230644.2710049-1-pierrick.bouvier@oss.qualcomm.com>
 <CAJSP0QUki9C6Nk8owfvmfyy_vfYT66mFQfsharkZ6GnDCLR5zg@mail.gmail.com>
 <CAPMQPEJMDp=9TgXvKPYhGDbyiePz6Q7RLycWDsUxG3SyR8gHog@mail.gmail.com>
 <20260506170818.GA203585@fedora>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260506170818.GA203585@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 84nhIVO4mARSm43IcmuinLqi61cAM6Wa
X-Proofpoint-GUID: 84nhIVO4mARSm43IcmuinLqi61cAM6Wa
X-Authority-Analysis: v=2.4 cv=cKXQdFeN c=1 sm=1 tr=0 ts=69fb7e27 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=-AnQz9JOAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=ggltgSJ5Mq7Xy2AbUuAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=3bnadFWGKyIZm4bBUiDd:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3MyBTYWx0ZWRfX6aFaw4Y1JH04
 /uQH393fCBF+e/i7g/zf46Ftp4ZC0cCjRPhLbCCn30FfYCJe+A+12pIUrTGgoATwSi6JOUaMAJm
 5RGEJsuQcsYScjgWui88dRHmXrRtBbARH2FEk6jVfVbMCwO2oYqn1sW0koUk/jvD7a93dqwFa5+
 Dg4PLWQvj+Fq3te0Z4DZ0ErXFgcSEoA6Qslv22v+dS8mt+fneJBKOqcuLryTX8HX3By2h5W7js3
 3Ql5gnYZMeFXNu/BVNFzPGBeOL62l5WxQJXel0AMvWxKADNyMx/92ohq0H1mYtxOrozvJVkILfu
 kFna9X3e2ZQD19YcsjqoqONq6/RZhdhjq2mvPCEFxXohu2Dgd8oFm+QfClPfeWUucBEMy2s0ZvY
 V9hvFGtkVbyT8xhIt2Tvd1cFxFuSOqKb9lIZ29uLKiBsk21qOTAVnV7t6NGAhXgcrfhoXODNJnb
 xNbQK/0vLyTBuNejGLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060173
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

On 5/6/2026 10:08 AM, Stefan Hajnoczi wrote:
> On Wed, May 06, 2026 at 05:16:21PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Stefan, Pierrick,
>>
>> On Wed, 6 May 2026 at 16:42, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>
>>> On Tue, May 5, 2026 at 7:07 PM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> The following changes since commit a85c588d07f8d3345ccad38b22026569a04571d1:
>>>>
>>>>   Merge tag 'pull-monitor-2026-05-05' of https://repo.or.cz/qemu/armbru into staging (2026-05-05 10:11:49 -0400)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/build_system-20260505
>>>>
>>>> for you to fetch changes up to 2e44ff32fc758bf8c0df13b0287afb75bb00c38e:
>>>>
>>>>   target/arm: define stub library (2026-05-05 16:06:00 -0700)
>>>>
>>>> ----------------------------------------------------------------
>>>> Changes:
>>>> - [PATCH 0/2] single-binary: add stubs for target/ (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
>>>>   Link: https://lore.kernel.org/qemu-devel/20260424230103.1579600-1-pierrick.bouvier@oss.qualcomm.com
>>>>
>>>> ----------------------------------------------------------------
>>>> Pierrick Bouvier (2):
>>>>       meson.build: define stubs library per target base architecture
>>>>       target/arm: define stub library
>>>>
>>>>  meson.build                | 22 +++++++++++++++++++---
>>>>  target/arm/meson.build     |  8 +++-----
>>>>  target/arm/tcg/meson.build |  2 +-
>>>>  3 files changed, 23 insertions(+), 9 deletions(-)
>>>
>>> Is this a pull request for Paolo's build system tree?
>>>
>>> I'm not merging this directly because I prefer to follow MAINTAINERS
>>> so it's clear who sends pull requests for each subsystem. That way
>>> maintainers won't be surprised by me merging a pull request from
>>> another contributor who is not officially the maintainer and it's also
>>> better for security.
>>
>> I did not notice Pierrick's PR and actually included these 2
>> commits in my latest "single-binary" pull request:
>> https://lore.kernel.org/qemu-devel/20260506135524.20617-1-philmd@linaro.org/
> 
> That can be fine, sometimes changes are cross-cutting or part of another
> sub-system (e.g. ARM target) even though they touch files a different
> subsystem.
> 
> My concern is only about the pull request process. Please don't send
> pull requests with a new tag/branch name that is not in MAINTAINERS. No
> PR has ever been merged from Pierrick with a build_system-* tag and he
> is not listed in MAINTAINERS for Build System.
> 
> This could be a sign that something in MAINTAINERS needs to be changed
> or it could be a sign that these patches should go through another tree
> (Paolo's or yours).
> 
>> Pierrick and I are simply reviewers on the "Build System" topic,
>> but it happens that I send patches there where they are related to
>> the overall single binary objective, and I see Pierrick as a co-maintainer
>> in this area. However there is no clearly defined MAINTAINERS
>> section, we happen to touch build system related files all over
>> the tree.
> 
> I can't accept random pull requests, even from regular contributors.
> Patches should go through subsystem maintainers listed in the
> MAINTAINERS file. This way we can be sure that only commits reviewed by
> a subsystem maintainers are merged and reduce the risk that malicious
> pull requests are merged (while I trust Pierrick, it lowers my guard if
> I'm accepting random pull requests from anyone at all).
>

That's totally my fault here, sorry.

I have been assuming that "Build and test automation, general continuous
integration" was by extension integrating build system, but it seems
like it doesn't. I would not dare sending PR for an area I don't
maintain officially.

As well, in the past, Richard integrated some of those patches on build
system for single-binary, but I appreciate that he's definitely more
legitimate than me for pulling these kind of patches.

Philippe and I will remove those patches, and I'll ping Paolo to let him
pull this instead.

> Stefan

Regards,
Pierrick

