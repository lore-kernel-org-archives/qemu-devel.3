Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2213606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pDpJw7tW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dQpp08Ly
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQN7k-00005u-Kf; Mon, 09 Nov 2026 06:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQN7j-00005d-3u
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:01:15 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQN7h-000556-AA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:01:14 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A99ug1V4130794
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 11:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 meRY6YSH7nRyYVEBApI1hvAZOoIyeBZyTt+lCYoT/Ig=; b=pDpJw7tW2U18XCNe
 x7cYNLnWwGWG+e7/e0n57iBH/dYf7+wCa9kuGUdNi4uqI+udmCybku8aWdrYkT2O
 RB0ljN3zJiuJ8yBL8dwZodZFnkVxYfbEAW5HBW/UMgSd6pj0dQnyZcAWfg2/we37
 5NwhdjNP95wT1eSgOwbvoOewjxAZjJiHJMgF+46bCaL3HlkYaA0uhGk2BD9PnirW
 Q+itLnyzRrEarTucTL8WFanDatbkVqJ7gl1KIIXahR4iN1pMbuomjK9qUfG/x6cD
 70+XU71M93J7WlOWSqohB77197E//jK9wgg2diwZI4hVJtOYFe6/Jy7rzCOmi3tZ
 Eej/vg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2hbjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:01:11 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99b8fbf29a9so370556241.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 03:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794222071; x=1794826871; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=meRY6YSH7nRyYVEBApI1hvAZOoIyeBZyTt+lCYoT/Ig=;
 b=dQpp08LybDEjASJBWAo6H/pEP5JQOmJpeqm3UKUjpY+iWfkD9X9qPhbu6BAwNVsnE0
 ALmtuXHRDcKyJm2TFpa+YU8I7NbQHVU1PpvGrvt9eHgpC8Z3pW4VsnNmf+B9EenvtrnL
 q6eBYguJFVMerx1WsQ0cy1H/tUKbIluHE812buxBlxIcG+IPJzm6gDDjgFZ0U15JI2D1
 /rTFb9Lxb7XXEr9VO7zwi+MThJFr8SPm5laE52SoMJFb5VzHPOkesXmbZ+42IjG7U7tK
 YbE7K5iBiI/hYTyWamD5kN/hBgMmnxEm9WBNkqQmjwBJirz3aHN+yI7+6fclWTqUl91T
 KvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794222071; x=1794826871;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=meRY6YSH7nRyYVEBApI1hvAZOoIyeBZyTt+lCYoT/Ig=;
 b=xsnu/TY/1T27pVhndQWQzk3ScO5gZ4/RbsK6QZxperNgRWIH1Ttr397pgu12b7pg4K
 YRQlLFMwMvnW+Zv9Y2ym+glcrc6qtlrm47fZMGKHe5JfVVAxvkY3vx/hRtK+0hyY9ako
 hrBjHJ3utapoAFPKpDkGZmwZkYDGVs7jYBROY5n2ertEMmXDO8hz9pj8q25anGDEbf5h
 vltlEXiL5BaHzvVDSAoSDNhm6hissJJu/50w2k4cpplapMaFPI3/miDEd/vDVa+UzQ7C
 TyOe+skUd5YTjZeS+ob1wfylhk538V8iBrMXSD1zmMHIfCvm7Aedljq2But6i/922Sn8
 QNnA==
X-Gm-Message-State: APuU4Z/3+OLrqyp36o27NNAPHQAADG29Fqfh14yCmc9vudhFBmILVeOi
 i+Ag+G1tVRluj05Aua1JUEhQZAx6htKC66Eo6yLV/nW4zAy2114lJc9rUJOPmbNt3sQJDZnWKdW
 1cMp7N68eWz2mexF4BbtdG1JV9lpFB6K6CNLiqCM7VGt9OiQFyVYPLdo6VQ==
X-Gm-Gg: AYBFou1n6CcB/x+FvaGjx7d23HfcPuVRQwrTYKymIc73abxkTmvCbox6g0/pO2bHd13
 1OYgRG2A/sEByJpfF2oxHWZA4Q5Jy9EVKAbOUD4LlFThkpE4TKItnoxIUC5Nm9eLtA/JNKLIhoU
 WYe6Baaq7Eyql666j4X2YZycSOyr5ESsyTjMvTcWg7QDhfeOWbVyg7H/28LqgsiWWCGUEOrUGZ2
 QZ/7nK1ccW9j052RXvaaW1OUqDkzXgWNsF868NYKCipDoE4K6dXVfaPCfhA+z7HbZBg+qU6U2G8
 yQg9gNeEqznXCBgsscanHYnddD1Oksz/MtZzi+kGApdYvF6I1y6vgQiC3lT48wnW1GYgXKPU74m
 WO05n8qax4FQXGwZALXkRXAdKXyq+pN1TKSaANvYkMfNfy1VQrXxHtjRIWz2eT+lmE0ltezK/24
 awSOm+8Q==
X-Received: by 2002:a67:e104:0:b0:7cc:2cd0:e74f with SMTP id
 ada2fe7eead31-7d2db1bcf74mr684433137.30.1794222070566; 
 Mon, 09 Nov 2026 03:01:10 -0800 (PST)
X-Received: by 2002:a67:e104:0:b0:7cc:2cd0:e74f with SMTP id
 ada2fe7eead31-7d2db1bcf74mr684356137.30.1794222065103; 
 Mon, 09 Nov 2026 03:01:05 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b79501502asm154215695e9.2.2026.11.09.03.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 03:01:04 -0800 (PST)
Message-ID: <a973e342-bf83-457d-8f0a-461ce1bcbbd7@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 12:01:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] docs: add a diagram of the development process
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20261106122111.3005638-1-alex.bennee@linaro.org>
 <dfc31d65-d309-461d-a47e-3df3c658d56e@oss.qualcomm.com>
 <87ld7566jz.fsf@draig.linaro.org>
 <b6a6e0bc-90b0-4162-8ec9-098d1ced1069@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <b6a6e0bc-90b0-4162-8ec9-098d1ced1069@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af1a7f7 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=S0jo4cuPHJH6ETGbiJoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MyBTYWx0ZWRfX6MKBNWRNdXRv
 d7ezXmWZbIuj+OnE8fpkMNHttvK7faWvf2lpIcHn0gy0rx+z2BfvpThFWGb024TKopuoJ2QzCJV
 AMqkHZ3luQ4Qg2RS6p8VuFtNlOjkJ+P/X9A+Ogle2BvxiV7TZOxDmhjA3MvjItwI080eBUBYTx5
 DQiuQoXNlwJnjoVMlH5KdX0CuBabDmOOk3HeRO/EGEjoshtizPUqfp3h3+n3xzVis6Zt0HbX54z
 iqX+plE9oxEuQX4V2WiQuJ7H1DoAvFoJUBlXPS+Dcepz/68g0T4BFM4Nhr5JLk4t8Ddt4KbZ/Wd
 6e0fEgZXeZPG8ukVaqz8qFV4SCdOc3YB7LreutLCn4SyVrqoA8XeCRmkJaAq+UMgZxga73xLgGG
 ZfO1jIvrzHozdo5JcOWZiIwiBqq1b8eULYjVvLubpsSIDUesRRDLgAIAqoH3I+LVsHncTGJU0CK
 7AfvPUFY9zNFdUu29Kg==
X-Proofpoint-GUID: pkplMtxEusZHatPkv4LDW0_wHRAxYYkJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MyBTYWx0ZWRfX/JG8C4CX68+O
 BmkdqEqIpWsgJl3tnuCQ6zxiUieQXYFNv+ISyfdLNNKlV5wmnj0e0Uf8oUwsYj3mDlnmkW/FQGZ
 jmQJO7+XlZUOyJhi/lLn7ISM+5t9kkw=
X-Proofpoint-ORIG-GUID: pkplMtxEusZHatPkv4LDW0_wHRAxYYkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090043
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 6/11/26 22:01, Pierrick Bouvier wrote:
> On 11/6/2026 12:36 PM, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>
>>> On 11/6/2026 4:21 AM, Alex Bennée wrote:
>>>> We've had various versions of this diagram for a while so I thought it
>>>> would be worth adding to the developer docs. I chose plantuml as it
>>>> has a plugin for sphinx that we can use and supports sequence diagrams
>>>> which could be useful for documenting other features in the code base.
>>>>
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>
>>>> ---
>>>> vRFC
>>>>    - I've bundled all the plumbing together in this commit but it can
>>>>    be split up if we want to go forward.
>>>> ---
>>>>   docs/conf.py                    | 22 +++++++++++++++
>>>>   docs/devel/index-process.rst    | 47 +++++++++++++++++++++++++++++++++
>>>>   docs/meson.build                |  3 ++-
>>>>   docs/requirements.txt           |  1 +
>>>>   configure                       |  6 +++++
>>>>   pythondeps.toml                 |  1 +
>>>>   tests/lcitool/mappings.yml      |  3 +++
>>>>   tests/lcitool/projects/qemu.yml |  1 +
>>>>   8 files changed, 83 insertions(+), 1 deletion(-)


>> I have the ascii original although ditaa seemed more of a stretch:
>>
>> --8<---------------cut here---------------start------------->8---
>> #+name: QEMU Development Process
>> #+begin_src ditaa :cmdline -T -o :file images/qemu-dev-process.png
>>             Developer                                   QEMU Community                           Subsystem Maintainer
>>    +-=--------------------------+   +-=---------------------------------------------------+   +-=----------------------+
>>    |                            |   |                                                     |   |                        |
>>    |    +-------------------+   |   |  +-----------------------------------------------+  |   |   +----------------+   |
>>    |    |{io}               |   |   |  |{io}                                           |  |   |   |{io}            |   |
>>    |    |  Develop and      |   | +--->|              Code Review on List              |  | +---->| Add Maintainer |   |
>>    |    |   Test feature    |   | | |  |                                               |  | | |   |    Sign-off    |   |
>>    |    |                   |   | | |  +------+----------------+----------------+------+  | | |   |                |   |
>>    |    +--------+----------+   | | |         |                |                |         | | |   +-------+--------+   |
>>    |             |              | | |         V                V                V         | | |           |            |
>>    |             V              | | :  +-------------+  +-------------+  +-------------+  | | |           v            |
>>    |    +-------------------+   | | |  |{d}          |  |{d}          |  |{io}         |  | | |   +----------------+   |
>>    |    |{io}               |   | | |  |  Review     |  |  Review     |  | Maintainer  |  | | |   |{s}             |   |
>>    | +->|  Post to List     +-----+ |  |    Comments |  |    Tags     |  |  accepts    |  | | |   |   GIT Branch   |   |
>>    | |  |                   |   |   |  |             |  |             |  | some or all |  | | |   |    foo/next    |   |
>>    | |  +-------------------+   |   |  |             |  |             |  |  patches    |  | | |   |                |   |
>>    | |                          :   |  +------+------+  +------+------+  +------+------+  | | :   |                |   |
>>    | |  +-------------------+   |   |         |                |                |         | | |   |                |   |
>>    | |  |{io}               |<----------------+                |                +-----------+ |   |                |   |
>>    | |  |    Incorporate    |                                  |                          |   |   |                |   |
>>    | |  |     Feedback      |<---------------------------------+                          |   |   |                |   |
>>    | |  +--------+----------+   |   |                                                     :   |   +-------+--------+   |
>>    | |           |              :   +-----------------------------------------------------+   |           |            |
>>    | |           v              |                                                             |           V            |
>>    | |  +-------------------+   |                       QEMU Maintainer                       |   +----------------+   |
>>    | |  |{io}               |   |  +-=-----------------------------------------------------+  |   |{io}            |   |
>>    | |  |    Prepare n+1    |   |  | +-------------+  +--------------+  +----------------+ |  |   |  Sign & Submit |   |
>>    | |  |                   |   |  | |{io}         |  |{s}           |  |{io}            | |  |   |      Pull      |   |
>>    | |  +--------+----------+   |  | | Tag Release |<-+   qemu.git   |<-+ Test and Merge |<-------+     Request    |   |
>>    | |           |              |  | |             |  |    master    |  |    Pull Reqs   |<-+ |   |                |   |
>>    | +-----------+              |  | |             |  |              |  |                | || |   +----------------+   |
>>    |                            |  | +------+------+  +--------------+  +----------------+ || |                        |
>>    +----------------------------+  +--------+----------------------------------------------+| +------------------------+
>>                                             +----------------+                              |
>>                                                              |                              |
>>                                                              V                              |       Pull Requests
>>                                                       +--------------+                      +----       from
>>                                                       |{d}           |                            Other Maintainers
>>                                                       |     QEMU     |
>>                                                       |    Release   |
>>                                                       |              |
>>                                                       |              |
>>                                                       +--------------+
>>
>> #+end_src
>> --8<---------------cut here---------------end--------------->8---
>>
> 
> Nice diagram!
> Better in picture indeed.

In the picture can we express the time dilatation factor in the
arrows to help contributors understand when they shouldn't worry
wrt QEMU mailing list pace? Like the wider the arrow the more we
need to wait.

