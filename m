Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B86FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEKz-0003zq-D1; Wed, 29 Apr 2026 19:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIEKx-0003zN-KC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:28:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIEKv-000132-PJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:28:59 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKcA3G434910
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y8QjHS2xFyZOCrCDX3iUx3kdSaiLVbQzkOAoAcvRk+A=; b=WbDnX3wv3t9sIlkA
 z4q5uCaDuSn1b+Vg7/ntxvDZKwD40NZlpvObFVbIYCDyj1s9eBqc1FlmVaYtXu/m
 xtYNphmm70plCOEx9hMoNpwS5KKfOJ7awDtoh9oQJILYBhDznF0/qDA1XuvMMgB5
 wAlqRw0wftwgxdWKFuI86JmI13JoBvwA4vy13gwoupVtyxJPmWaemlW+XLvehv4t
 503UBJ2PZdTZJVMWUCkQVhGOATh023vb6NUdQEBSyG2uhDmGU94AeBWaQTXpSgPH
 ArqljZJ8CGZDp8cGzzeHKhLhoRDoUGrWgb9ZINdYHamEllqTvPLKUMiHnCKjCnL/
 K37xEg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sxcxxf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:28:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2de07c12745so1897291eec.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777505335; x=1778110135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8QjHS2xFyZOCrCDX3iUx3kdSaiLVbQzkOAoAcvRk+A=;
 b=HGgB09Q5MamZY5y0B9f0nhOdd+ggd/HP2HjjrtG80/UczwjoirZrwZkVGAs232dGiY
 UfSNJy3+jnOnd/VcsfguHkQ8L0pktRvV1Rm6I9aaL+FiPzsRs1gVLkyveKxt4GJxk5De
 Yl4OPY0tpOkg8bP+OInlFu0pC/LY9Zr9GlWXtxjKlgxSPPfG1kdGWywN52axXeOzd3hZ
 etswn1naPhDVQzi//Dzl0bK2jy9zf+wqMnWa7c0cnOqNFEvk5DINBYZvGy4uz/sOO7kb
 5Tvv3BuWELLE9r0vB/rrX/V0zZ/DxuZhQFi5Mgrjwtmn3Yn8zApQxT23Ho7wgpGHFaSh
 rt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777505335; x=1778110135;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8QjHS2xFyZOCrCDX3iUx3kdSaiLVbQzkOAoAcvRk+A=;
 b=UinlhuJ40RCq/22xv8uqO6GnVN21X6jHzE0B/mNIiGXGNa/3NgqQsfE8wVvK4WYybE
 0TOHC/abjqoyd1i/atvWuiAQQaId2W5APzbOUyLzZLnNsRHVFaxn2EfGDSRMJyImb2Xu
 r9cetr7TYrGwooERqdd17fQ9nxXBsy3eSYj3byjbXyy/rRDMZi+UstGFNYJkZ+Z5JNvl
 /MH56V+JCt/MpHO55mKz60moNdp7Hk0nK9Spw4/AcxT2ZvDa/EOfdUVuk10ix3VHY+I4
 yNXu7fOJJOMkmjsl+URij8D7ykPhquA2xS9ItB5qpjVMCxkGlHrBDnrPjXGWPfSvJsLy
 iNdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gFhHIG2NQXeBZRHv5w9xg8Lh3Pa8gzhaWE69XY4VHXBnJB8AFe8k8EWXs2WUC6ntQVMT4j7uTFPLf@nongnu.org
X-Gm-Message-State: AOJu0YzWsnTGSus0IkFhu6VNaednbFICDIIi34VH/8JyO9OROzUIA/Ob
 7IkyTB1/0Kt8M6Yd1AGVv3mvA8OtDm4BbxabZDbUsd2XdRK7jDBd343n/IPSdSNhIMMogFDnh5a
 QakROo2g0DDIGLBf4iTtWlkmtFuGzVIohwrU5t8VKgR3NKfvK7V5RartyCw==
X-Gm-Gg: AeBDiesWSrt99/aLZLTIVqWwYkRppmlmAZy6dH7JNuVMf1vrkHuOcAbqLZ6XIjtmZLq
 P0N6SHiAYwkjHHnvazVHMj38FppY/Vvpzl9G5+OJBdPHApyY8hxdAA2SmJC3BFVYlCxwEfQfi+q
 0iJ611E6Uii8klOjEJm7k5NB/NYnhajskVC8d7vPwo+Y4WUOimEy8NP7q8s0Py4EhsI6xIXVxla
 Dn8ep7ELqXLhCX55XrDTiF+5y2evt/MVF7S6Mw9dB/w3O9ilNR4alWZ4gbHuyGCgf9cq1o9KCf2
 2VNkTBaRHm84wmh0jLh5ry30Mi1jCGzw6CjaworDGcjp3dOL3HjsBkcPfCHNruXVTTyw6rCWy5R
 RfWgg7ytivk/QX+aD1bPVRpTqy1LHq0qWLlpEgtci7XiPtpOPscHTcXAyXXNhfdRPpU5g0WGkER
 nCZ4sceu6nyy0ZJC2A6KOv27Zn
X-Received: by 2002:a05:7300:5bab:b0:2e6:e916:7105 with SMTP id
 5a478bee46e88-2ed3c5cc1d4mr161043eec.13.1777505334820; 
 Wed, 29 Apr 2026 16:28:54 -0700 (PDT)
X-Received: by 2002:a05:7300:5bab:b0:2e6:e916:7105 with SMTP id
 5a478bee46e88-2ed3c5cc1d4mr161037eec.13.1777505334245; 
 Wed, 29 Apr 2026 16:28:54 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed46afda3fsm448622eec.30.2026.04.29.16.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 16:28:53 -0700 (PDT)
Message-ID: <76cb2cb3-9306-4d17-9a19-e6262ffc0ad7@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:28:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Rust builds don't use link_args
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <24ba9372-a691-4a63-a6da-e8340343faaf@oss.qualcomm.com>
 <389edd46-c25d-473c-8603-1a5d411d0d63@redhat.com>
 <5aed20fb-9df4-4f87-83f2-2309a8d6ad8f@oss.qualcomm.com>
 <8209d049-83ee-4900-a3dd-0797eb99ecf9@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8209d049-83ee-4900-a3dd-0797eb99ecf9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _VjN0qoNWzgyP5m970PnNK6Tixg3clYZ
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f29437 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=ukH1R-b_AAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=4gpYruzheLjQzouPzScA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=zUGFzhdS3I8ccRoxxLmr:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzNSBTYWx0ZWRfX/hbsOMcy6UBN
 REyAlQL9fxj7ynYVjdfc4SjLcQPwRNShGyBbTGKrb/axAUtziRP8x5C5eM89jKSY143mv0U7y9U
 FI1wmxf5nQkirhBFM/ogwe/E5CjdHPwQRuoWfqC5lryMb5Z648Eo3OJNR+X9EUdbfnPEhQg07UN
 UOG0TEGfaFeBPi4XXpD6cFC/ga5BCCQe3SPUUqECbdcyfD03s1r2zFG23a9bf2SWl0JYTC7IOMM
 ORhjuxZo8MqV/K2AVlHMZ6KWaUAX2NgnAiPS3h93etS3Ur2VAJaii7PIPCdZDHWKT/BIdnBG5rJ
 H5+0ZKD6m7yYajR7p4ntIJ7jDnvVqmYUtF6d6rLFsa0B6vMOjfWrV9tYGxUJafxWZUGy98xemio
 DY0LDu8E1VnDkLkzRCm2uStQPNeKvyswCbh6OeHbNR9Mu5BeFFeIheqkwdF7Yu+FC/4tLAulzCY
 3j/3zNgOYcUyw3JKt3Q==
X-Proofpoint-ORIG-GUID: _VjN0qoNWzgyP5m970PnNK6Tixg3clYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290235
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 4/29/2026 1:25 PM, Pierrick Bouvier wrote:
> On 4/29/2026 11:03 AM, Pierrick Bouvier wrote:
>> On 4/29/2026 1:32 AM, Paolo Bonzini wrote:
>>> On 4/29/26 01:16, Pierrick Bouvier wrote:
>>>> I noticed that plugins are not working when building with with
>>>> --enable-rust.
>>>>
>>>> We explicitly export qemu_plugin_* symbols from QEMU binary using:
>>>> plugins/meson.build:24 [1]
>>>> ```
>>>> emulator_link_args += '-Xlinker', '--dynamic-list=' +
>>>> qemu_plugin_symbols.full_path()
>>>> ```
>>>>
>>>> Tracing a rust enabled build, it seems that rustc is responsible for
>>>> doing the final link, by calling the compiler (cc here).
>>>> However, I didn't see those flags being passed.
>>>>
>>>> Any idea how to make rustc apply these flags correctly?
>>>
>>> I would start by testing Meson 1.11. From https://mesonbuild.com/
>>> Release-notes-for-1-11-0.html:
>>>
>>> ---
>>> ## Change to handling of linker arguments for Rust
>>>
>>> Since the Rust compiler integrates the compiler and linker phase,
>>> previous Meson versions did not obey link_args,
>>> add_project_link_arguments or add_global_link_arguments.
>>>
>>> Starting in this version, add_project_link_arguments(),
>>> add_global_link_arguments(), and the link_args keyword argument are
>>> supported for Rust. They wrap the arguments with -Clink-arg= when
>>> invoking rustc, and are only included when creating binary or shared
>>> library crates.
>>>
>>> Likewise, methods such as has_link_argument() now wrap the arguments
>>> being tested with -Clink-arg=.
>>> ----
>>>
>>> Paolo
>>>
>>
>> This works with meson 1.11.0, I'll send a patch to update version after
>> running a full CI.
>>
>> Regards,
>> Pierrick
>>
> 
> Sent patch (not yet available on lore, hope the updated wheel didn't
> break it):
> 20260429202051.2998084-1-pierrick.bouvier@oss.qualcomm.com
> 
> Regards,
> Pierrick

This test is the only one left that fails with --enable-rust build.
qemu:func-x86_64-rebuild_vmfd

However, it's pretty surprising because the log does not show any
special error, so I'm not sure what is going on with this one.

I reproduced it locally, but see an online log here:
https://github.com/p-b-o/qemu-ci/actions/runs/25131702774/job/73660160251

Regards,
Pierrick

