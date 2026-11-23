Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E08F606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QghD3vJQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JN5Vlwkn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWQZ-0005Y2-2e; Mon, 23 Nov 2026 10:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVWQX-0005Xt-F7
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:57:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVWQV-00055H-UC
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:57:57 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDKw1E2442731
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 15:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X4K2iHS1kXnmNbak1hubPDGET0UrMJqgb1i/ivmd3m8=; b=QghD3vJQLx4FyspS
 4lE3FxBiQ3fJ2nB+2JZrwl4eDhZzKAIGTjoNyECYgYqFHD3YnmjQgIIWg+jDP075
 B2nLPPGErfOM1YeM73qtqUT1PAcVvHdcToqw57fGDDd4XUjBEue18VnWiaBwlyGw
 h/VIpVVv3Z32haioruvg7nSZh8Y2gMSK120lOVoQdq5QfKjhWjgjwd7ZPlE/QUbn
 DlXTwjHxXS3Ic3NhxJK0cKzt2xGi9NzDBlKT4yvT5BL+PH01m89xHs6aWHw7Eb3V
 aV6eQlARM289nzPGU2iPTgylT11xH/aUmIGH0oflFRLJs/TVZL8ldBbSxRI80HNk
 2MmX8g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k27aa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 15:57:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9213730b07eso61865266d6.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795449473; x=1796054273; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X4K2iHS1kXnmNbak1hubPDGET0UrMJqgb1i/ivmd3m8=;
 b=JN5VlwknAF84dWrONNNBXawJ5aa5SJcHQqgPOu84Rq+AmZCxi7X+5HYRBa2ujXZPil
 O6n4QxXwz8zk0V8dnTma1urnJ+xpQCECrmX7GR6AQLMw918K8PjbCkGbb2hxJm6jJVRz
 M7B0SWYBAblbO+ys4EdCdPkQT2KZm80FUvprBNzViLDu78bG0pLS32fzTLLGLJxyOp6x
 DoiDXxOV8QHmV/AoFABtqBivgSwbrF+axNo1Yfcvwdz26ghOaNufzlo+d+RxfnZ3fjxy
 vdfwR0EzC8bA15jKypRdtGK2rUBJWuHrEj/b7ZGLQyQli9wuMxTi6GggudBd0/nFEc5Z
 H/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795449473; x=1796054273;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X4K2iHS1kXnmNbak1hubPDGET0UrMJqgb1i/ivmd3m8=;
 b=akPo65WTdmr/f7wE48yXYrSSEZEl6bWpp2Yyzm77NGYwf61iKBBkqJmJ7Wx2fXNEYu
 6yGVdvO7+gASwi79+akA0/BqrqG/3VvX1B7+WswXVv4BAbpBlEgl8KQXffb2W6oVLexV
 8tW0NZzPvA7ncGQJ4oZ8l5c2s4Ln+9IO8Xxzjszx2O6MV5BSNXtPkwID7VIzd+55UE1U
 zJuZB3mWZLuXNAO9tTRBO+4MKbmuPGAPmNj9X5HUBzk0QAJ8G5U8kVCZcpmkx6a3O2mr
 PA2N2dZZ4ywO/pT6K+jI8zSfl+ilixrdtw22jL0WG85z0xBNpIiJopIWtHFWit08eEvm
 nEFA==
X-Gm-Message-State: APuU4Z/Lu1t3lsR/v51gJe1j8KEx4URMA5NMhSRVTqJWezFNko6xmm0Y
 LJZ/ee/t3SaQgKd+d0QLdIEFP1fTlfYNiCzbT8xNMRIxD6z+WUre6dL9wKiRUfrG+JgK6pBce4W
 o/u/2dU0roQ6mbAPTbUpmCY/RZrtfYllPsAaocMYLQJuxsOwwkB7vvcjsIEWjgX4QTA+0
X-Gm-Gg: AZFdTZfgSnHYsfbmGiGKtZG+0kDqma4x4f0jOElerfDvfhj1QIQ+Yo8NpOxJjaf8RE8
 WVi6OwvqMmkpn+mlQn4/49oLiosCwJ2pkfiZnLca0zYTs5WF7GPtSG0S5e4h8rpp2tIBcM7r9Cm
 DpE5gzt2NaXoRA18SffznxzEwIDT/J9Nook9q2aro7V33/QoSzfoP5qYe6uUrOHl3ZxqUm9vs19
 h2slwVWnPLa8+1m39AoemWfw2xnzXz65t+HUuqBoDtN04Y+r1fj9Eg62mpSLIBScUDKMef55PC1
 gdRwe1fbOb+TuNt4uCY0QsD2vb7zpMTL/pZMONGrvDzy1wr+C7jiz+KHOX6J0hF6o7owxFVpg4g
 F6HgColt+oBoEwcLRK72RTgVpHxffx88s7j5uPyRK46MSQCdDSWt4Q8uK4rya1sdniZQy7JEDBW
 q0vKfFaOg=
X-Received: by 2002:a05:620a:45a3:b0:93f:568d:ebbc with SMTP id
 af79cd13be357-949ba98e6dfmr1935037585a.32.1795449473586; 
 Mon, 23 Nov 2026 07:57:53 -0800 (PST)
X-Received: by 2002:a05:620a:45a3:b0:93f:568d:ebbc with SMTP id
 af79cd13be357-949ba98e6dfmr1935033085a.32.1795449473044; 
 Mon, 23 Nov 2026 07:57:53 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c4353d6sm22297066f8f.56.2026.11.23.07.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 07:57:52 -0800 (PST)
Message-ID: <251ab6a6-bc87-45ad-8bb4-22d7cdb6b647@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 16:57:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/xtensa: Constify ISA tables
Content-Language: en-US
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
References: <20261120174757.65815-1-philmd@oss.qualcomm.com>
 <awQH2kndr_kuXSPl@octofox.metropolis>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <awQH2kndr_kuXSPl@octofox.metropolis>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2MyBTYWx0ZWRfXzC/qEu7H3yDJ
 8IsTD2187uQGv+Q1TQnGvM+G143kn2iftOGbVL5laCBWXu5YBgpY2g0ZCBzapIJxr7wRuC8CQOX
 W1nCaxK/amD7uBq3urb6Qv+sSdmqqcA=
X-Proofpoint-GUID: ESHwo5tYgAAk9H0qwM4zSYfAnmjG7wMU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2MyBTYWx0ZWRfX4OOfz6a69FJf
 6dGwLCLJiTjsdLgge/qFT2h6wRlWlFn2CasgCawdRF4bVnjEDmHlinyuDvebIBttyDxdac8ZwSy
 EbJ3BKDgKcSCXmEoaLZa/AZ/fBJabE4d13SSzOfzV9AbceR017q7qrVp1DiAUbIzhech5tziIpD
 kHSJMw7vMMfLVPyZ0Bi1uqdlAoMT8yNKh3sP+duemgJDJUI5eu842jJaR/gaIh3UBvJ4UxqHB7v
 VnY9UK+29MrS7SssFUd1jBhAtoIGy7NuJHQ3C9SQDNHUTcEjINrWSEo7FEBFZx7OvULXpZK+OZH
 +e4P7RfknGXeNj9uOZ1iHk3U+zGHY5Dt8KXflmEI5tk8kdnMLHR91SI1929boVbIc+ZOyVDzBIB
 5CIaq9Y5OGbRipHQBz3wKGGmEVlEtReBP3Ap9P+9nuAC5OhBeva6T2knjl2px1Rm8ypc3e4YANd
 gSQzGfwy42OslDpyQbw==
X-Proofpoint-ORIG-GUID: ESHwo5tYgAAk9H0qwM4zSYfAnmjG7wMU
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b046282 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=r_1QIA8Q05IciC83LpUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230063
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

On 23/11/26 10:31, Max Filippov wrote:
> Hi Philippe,
> 
> On Fri, Nov 20, 2026 at 06:47:54PM +0100, Philippe Mathieu-Daudé wrote:
>> The generated xtensa-modules.c.inc tables are static ISA
>> metadata. xtensa-isa.c only reads them; runtime writes go
>> to the malloc'ed lookup tables and xtensa_isa_internal fields.
>> Make them const so they are placed in .rodata instead of .data.
>> Make import_core.sh emit const tables for newly imported cores.
>>
>> Inspired-by: John Snow <jsnow@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/xtensa/import_core.sh                  |    2 +
>>   .../xtensa/core-dc232b/xtensa-modules.c.inc   | 2034 ++++----
>>   .../xtensa/core-dc233c/xtensa-modules.c.inc   | 2066 ++++----
>>   target/xtensa/core-de212/xtensa-modules.c.inc | 1942 +++----
>>   .../core-de233_fpu/xtensa-modules.c.inc       | 2892 +++++-----
>>   .../xtensa/core-dsp3400/xtensa-modules.c.inc  | 4638 ++++++++---------
>>   target/xtensa/core-fsf/xtensa-modules.c.inc   | 1422 ++---
>>   target/xtensa/core-lx106/xtensa-modules.c.inc |  932 ++--
>>   .../xtensa-modules.c.inc                      | 1536 +++---
>>   .../core-test_kc705_be/xtensa-modules.c.inc   | 4616 ++++++++--------
>>   .../core-test_mmuhifi_c3/xtensa-modules.c.inc | 3578 ++++++-------
>>   11 files changed, 12830 insertions(+), 12828 deletions(-)
> 
> this doesn't build for me without additional changes that I just
> posted (target/xtensa: constify internal pointers in xtensa-isa).
> 
> Together with that patch:
> Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
> Tested-by: Max Filippov <jcmvbkbc@gmail.com>

Thanks! I extracted this patch from a bigger branch but screwed
since huge. I'll queue both for 12.0 :)

