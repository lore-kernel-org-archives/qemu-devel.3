Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44C0606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZQqu7xTC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wx0H3aVH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ4mW-00054A-Ht; Tue, 20 Oct 2026 04:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJ4mS-00051X-3y
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 04:01:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJ4mM-0007Oe-JT
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 04:01:05 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tBxf2877675
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 08:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kqdUQZ5WOVbFKmWnSIDXR3DCl1yA6xbzJRYh//OQAIs=; b=ZQqu7xTChU3gUb/b
 iAAZI4AJWKHqkimc9gOgtVjFOM+i69YoYT3rjxDLqJSboxiFrdYmhF97A636rt3t
 p5FKAIF2ac+08lR8RJT6BfFRQHKU3nVONa/X37vU51HmCTAXPOQJRuLITzSKwj3w
 0dwo4/zGNVqPNTCK8istxJyQD8IFGiunuJ/CRvw4ncRTMIaR8DyWsss8mW7zxm6G
 2CiibpK0r/SUwwbVfToVf00KjjFc7cB7aAjI/AYckynUCjI0RYcWIg7jJYdqpIV2
 JWS8ZQO5I4q9gZKGHEXNKWvZFYa2vTpHJYHqtzNc59Sbm4x3DFJ3iNfpbZc2NMs4
 SS0Zog==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5psgwx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 08:01:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2005ce21so522155385a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 01:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792483260; x=1793088060; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kqdUQZ5WOVbFKmWnSIDXR3DCl1yA6xbzJRYh//OQAIs=;
 b=Wx0H3aVHHtAlGV+h5qJp+c+O5LDBDWcNoYEyMNq9vpyb/XxsKCFXn0DN2vKqrAZ8QF
 3JUA4zb4r+qkVaGcXQ6Ing3zW1MFp/177t2hP5WzdOzoi6oSfGdgkTBzsw8+SVJUP6I2
 9IdAVWilL7ayEHm8K61oD52ZcbJAGR9GtZDZjl90+OMfR/beDfElcXHiNufmlmCAKMFt
 MjdGC/bYMYKRq2tHEClLVE8qGxRn1CsArz2XWfJq+YPu+47ZKFIK5eS6O9jkgjoe5P+s
 KQYcSrXCGSX9OeIoVfi5/rIXAiJXc4aE3fwJYWlj6R0UGyS90SO7OsWBX2arlZ+vVlNz
 KLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792483260; x=1793088060;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kqdUQZ5WOVbFKmWnSIDXR3DCl1yA6xbzJRYh//OQAIs=;
 b=IjiSAuQFxmLkWVqiWIGBCB+azaXFv9uOE/wlbBtI5mW4qBNmt+xqAY3tJfIllzTR7g
 w2Asd9KMbpOA83pOOxNaYOdUxRxlhS/UESJK+vawCyPuD+CJTAYgzjKkkn/pCK0abPdQ
 29sM1u/zKtpV3z/TYzSGeaYWOiJdgGgRxQwc+2+h3RvgRbVr5lr8gwrRpL4Efhk+AVDO
 xTxOYs0HNO7uBjNSQfX0YHFYvZjJT/S0+FcBAWgbXD1QWQ2HYkNBngVLvN5ABRVKMBIQ
 HkCjM/E2Iv5NvohJOT2N+ozvvOnmTbP5Sn2yGEe7/LgqzZMX1OJqAFTmfz3hyzGwYvf+
 JPLQ==
X-Gm-Message-State: AFq9FYLw+B8feWf7yXACezefxRrThPnwL6kMZ3zEd08Z2RVP++3FzaCL
 71vhy/9/ahmrcX50w+gKKZ1VOSATawTz/9PL6ZsQENY35e9jd2yYpgnATtkxlGTbp8B+Hq487TJ
 R+6544EiCD+8NdEYqypL2r4j8IJBbr6jE8IgFRu5w+3cvXXKISe7h0s6FKg==
X-Gm-Gg: AYBFou2iMOgRhrGoJ8wxA7+b6JaqLHIVX3UWoN7SV4C1v8/A4rQCKXpEkt03+6N5MIi
 iTmj34oIcSUBhkxzcBlCVMqYdxTTbkcU3JQGxgHjiPCyd3cT9ddWmUYbXybYCH4LffJtwziQCEA
 +tqNrmTpSAeapPtrR7QeLSg5iueydac9gFW2gsjrNAvlWiAuCpFbvbYR0b01KU+cj3FgpMPhRdi
 zDz8mApUVk4T/BzqP7OTOqLS7Xagb6fKAwtH26vf8egrROrJd22Kk0DQHtFwXhVdNH/nIAk02Ax
 jbswfmn8igMK9REqd2TJNKyHEAZHQdUv39SZlHqFlS8uoGP6/Cm5vhmI3b76yk9Xg9s8j8gBN3x
 2zCD8mZFSNecphN6wM2tPnHicfGJeL2361g==
X-Received: by 2002:a05:620a:470f:b0:93c:7e9c:3bba with SMTP id
 af79cd13be357-93f29d2c0b9mr1746211185a.41.1792483260011; 
 Tue, 20 Oct 2026 01:01:00 -0700 (PDT)
X-Received: by 2002:a05:620a:470f:b0:93c:7e9c:3bba with SMTP id
 af79cd13be357-93f29d2c0b9mr1746207985a.41.1792483259548; 
 Tue, 20 Oct 2026 01:00:59 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d810035sm4688542f8f.13.2026.10.20.01.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 01:00:58 -0700 (PDT)
Message-ID: <6337a90b-b14c-4df8-aa0b-570cac47e965@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 10:00:57 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Remove stale chapter on RISC-V 'Z' CPU properties
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261018230741.6560-1-philmd@oss.qualcomm.com>
 <8360ad12-6dab-44e6-a930-17ed8e92a09b@oss.qualcomm.com>
 <CAFEAcA8thrNkzvR_UVnfYUjaSNiaax6Xupw=DsBapHDyPbpdEg@mail.gmail.com>
 <943c16d9-1880-44a6-9982-4fac725cf982@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <943c16d9-1880-44a6-9982-4fac725cf982@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DrrDa2/+ c=1 sm=1 tr=0 ts=6ad71fbd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0JJvY9oDge711AmrAkMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMSBTYWx0ZWRfX2jIe+vabXGpv
 lvFRSA4Sl01biZbxntEwxD0+bZ4zItBMg693ndCFQ+MTeKEfiJlOtvQczbhhOSzuw0bpV+Qo9p/
 VCJwsWyObHc999ZsMY9N81ewnrxkJUKllOxAUI92OMEMVP1vw03uNdfn6cBHmwpWmikgYx2Q06r
 qTLI8y2sxB8SUE7saVXZu4TBzEyR3qqZtFczqFJmdmOWcd3SmL6zBNCkVRG/Qbllp3oEPNQfUSE
 7OK5S5AqHHn/0yt6DSiIUWcMAbT0oFxC9cpNPjoq5oJUUXDEPyg3rF+GBNFqDl6gUg5H9eFD6LX
 9hX8K+afoMxLZvhvGTzvrNye+2Y9Y7HisNXdvllKRyUlPvhWzF4nCKJv2Fm161LiEx7FwjUcxRW
 aRGfyL+6H/3RDV4hYKskeRUqfLWscmvu2wFftkPUVRfvZeASA7PxoqkOXfHE2JrVSBnA1UrfNqO
 ENGBmUkUcogTkBPiUmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMSBTYWx0ZWRfXxglgyzMJnJzu
 3L6QUlowa5D2XyC5ozGqdCj4YePn4J0Q7ZO+W2kf3a+jfhDq2CR33pJG0Mlospx1E7oAo3fT4Zh
 7GV8xcaJqMBGxgFSdjC8cXMpgzkIyt0=
X-Proofpoint-GUID: yo73G9qqV4FFDk_KyEh0f9yPAOtdyNzL
X-Proofpoint-ORIG-GUID: yo73G9qqV4FFDk_KyEh0f9yPAOtdyNzL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200031
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/10/26 13:54, Daniel Henrique Barboza wrote:
> 
> 
> On 10/19/2026 6:48 AM, Peter Maydell wrote:
>> On Mon, 19 Oct 2026 at 10:42, Daniel Henrique Barboza
>> <daniel.barboza@oss.qualcomm.com> wrote:
>>>
>>>
>>>
>>> On 10/18/2026 8:07 PM, Philippe Mathieu-Daudé wrote:
>>>> RISC-V 'Z' CPU properties were removed in commit 455c0fa9eef,
>>>> for the release v10.1.0. Remove the stale comment.
>>>
>>> I wasn't aware that we need to remove stuff from deprecated.rst after
>>> awhile.  Thanks for taking care of it!
>>
>> We are supposed to move the section from deprecated.rst to
>> removed.rst (adjusting it as necessary) when the feature moves
>> from "deprecated" to "actually removed". We didn't do that in
>> 455c0fa9eef, so we should do that here, rather than just deleting
>> the section.

Oops...

> 
> Got it.  Thanks for clarifying!
> 
> Phil, can you please re-send the patch moving the text to remove.rst?

Fixed in v2:
https://lore.kernel.org/qemu-devel/20261020075927.56983-1-philmd@oss.qualcomm.com/T/#u

