Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E243CCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGwUE-0005e4-52; Wed, 14 Oct 2026 06:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGwU8-0005Wx-Sz
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 06:45:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGwU5-0000qs-NH
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 06:45:24 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E7hYAE2874283
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 10:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kbK2JqaYTR9Hm5RLDLjywUEU9POckGhsLsy79Dk570U=; b=iIypfVJXDscKI01L
 teA/2USQZrHRBhO1mBN3oFe6UeglFK5XVqErEd+GcbaZC2vL5kaf71IYR8OALobi
 d0pP36iurktQTh7qMe+qN0ueHQBZtB/8dqJFRlovp+JpQ7M+HRWkrJTErW11JAe4
 ZbV4uK7LTPFnYJSAJzN2xJzqMubFeej7lYLmXJbHHptitiqzY0tNCyIRzmjG/klh
 Gjgz7wZtq8XL+1EKTE6l62FvuM2Dym2qeJKQWu6hge7bRi1b/pX4S9xZyMB7Ef1Q
 hFZORJ6dBp+BUOeHNyJciBz0ZMTg2rLKlMiwl28jVfCRhi6j+78dl/rckBITx+4E
 CZhdFw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9yphj4wb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 10:45:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e834ff4d0so1082853885a.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 03:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791974718; x=1792579518; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kbK2JqaYTR9Hm5RLDLjywUEU9POckGhsLsy79Dk570U=;
 b=QP4s/EKx6IExdEq075sDnWlVE5/FI5um0FFU2s9Viu5DM7MH08Fx9QfnDD/89h9t67
 l6TsAZ+z+s+LtdmdZqaxKjB1NkrBqUJ6hP+PpEZxHB9x52fOO3rekM2CMtjWdhCHQTHu
 6g2RD9iIaAMqeB/SYAeB4Ez5YV8ZrKIsHsHeDR45D93Mw/Bsu8cRAo3d2H7WmsB6HBLo
 GXl4m8t/gyC4z0Nr1Xquy0uaQkE6FJmoAhhz/iFA8t86ll6z78Xkwhbj22lqHYxHo1l7
 ZoA4YpP8Wzx6ktBLgs8Nc3jS2kZmQKKzG2hVyrNTh1kFakoUKVN1QHEhI5KQ+kgqdlIl
 PTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791974718; x=1792579518;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kbK2JqaYTR9Hm5RLDLjywUEU9POckGhsLsy79Dk570U=;
 b=w0GTtnBQkQcH7ETdT1psSENglo7/6kRAlhNd3pgKn7A2xlrHk36Rjkak3mls8fZcSq
 2f+RThvZCmOHde7Ftzr/7KEozv/oowjddjz9FRYhyIdya/+Lxnmra8c+ZxbxpbA9m3nl
 6bW0GehJ/sJjcEvzDqmSTeRT+JoN8x/laOG2scLqadBa9UIxVOeROOy9PIq6JB08X7TY
 wxzIdMlatUp2NmaDyZq6EeNCiEbj7dy/GjDUziG59S3RRxC3ufSW9AmcoTTr8fNlQ6gj
 LXKzXFof/803hFsuRuoiS9xurAT+eNF0/pZ6nt9OYMIrJYiqS0nusuSk/RKHaV48ZBO6
 ysSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwixpNVt28GWkeM2OOQBshUXvhRNPj4W4nDJ8sOCOatrwcBo7fykUaA8d8Q8B5mKugw3fKOeSuVvNoT@nongnu.org
X-Gm-Message-State: AFq9FYLhOMB/TQPDawVtXv7tIuvBc4+5+2PZOPasigdJCtlIG847Se5D
 mtBjFYx6RFeNQEDk+bYS24TuWI3pL5zLxIlWWi4cG1UtKVjYklw+kUr3siK7MRt4VbaurUCbCjj
 fYTzdftYDClgdypob2Af3j8IMYHzZn1W6gcMH1hXG+oPE22g4u/jnfYr7aw==
X-Gm-Gg: AYBFou14to4vIRNMPx0GkRsFbctLWfkVRXdhwRqDuSWb6dvByFTQj605UZaZkPl2R68
 VdpJCQiMYuA+h3/Y7wH5YWJuS2hvPDX98UlMuY6u0GYo0yf4Zxkc9mvP3/Y+XAyWE+ubJcRNhKb
 9Qj6kOL2u9KmjlArPPnc1IHGFUkktFyKEPc/3cdSnxGcjlL79YiAwvUjUlmFx4tEBFgdeqGYOWx
 EEwrvInWdwOHKERUANEle+7PrM+wHBX7fN2MgWoOLIZWLrz83BP0Nwcbb3lyRRUiF/NbYM4YNNW
 MPGzdBa778P16Co7U+RHjAVNhvCU75Iwt5z3LpBPRmkVrC7bQFLROe7f4XsXNmR8pttBah6tvvX
 5Z5abBmou9cp8HHxA6QLTS5o3pfvWmTU7wg==
X-Received: by 2002:a05:620a:a0d6:20b0:93e:c12c:fbc2 with SMTP id
 af79cd13be357-93ec12d0818mr1724793385a.79.1791974718425; 
 Wed, 14 Oct 2026 03:45:18 -0700 (PDT)
X-Received: by 2002:a05:620a:a0d6:20b0:93e:c12c:fbc2 with SMTP id
 af79cd13be357-93ec12d0818mr1724787685a.79.1791974717802; 
 Wed, 14 Oct 2026 03:45:17 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be964dfsm429280735e9.7.2026.10.14.03.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 03:45:16 -0700 (PDT)
Message-ID: <5d86e4c0-43b3-475b-b135-29b9d685d13b@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 12:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/34] qapi: add missing Linux user-mode targets to
 EmuTarget
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
 <20261014093152.834-6-luoyonggang@gmail.com>
 <e09a64d3-7632-4f90-bd69-0c6097f8cd78@oss.qualcomm.com>
 <as9ZvlmXQUwvm0vz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <as9ZvlmXQUwvm0vz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OcYo58mgkgp9bV2hovPyCvB7QlxVDiqZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0MiBTYWx0ZWRfX7HsJXbOq25h9
 Ng76qqNhS1MpBhU48WF7e/Gomyr+U5XktEvg3FG4QzpaOBelyll4Huzc5eelGjuuGmAfUx69PbJ
 OAb6dS6yIvSeRaHomiEQSOpU1tt4h60=
X-Proofpoint-ORIG-GUID: OcYo58mgkgp9bV2hovPyCvB7QlxVDiqZ
X-Authority-Analysis: v=2.4 cv=Uv72pOwB c=1 sm=1 tr=0 ts=6acf5d3f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=0dUR4_UHYLhz-S5sKh8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0MiBTYWx0ZWRfX5CKsq6SBlHkN
 agduYcRxT81D+hCVwBKBuKFLUZZ3cQybJ9oVxhqNox9iX6wcp8uPQLChchU/8AwTU+dra+KiJJN
 VSYW8QWh1gmDDhx1Aq/p9jZl2DU1obn0tLxnzDTMKvdR67/L1kF42BwY6uwAqNZQt/6bYNh3wLZ
 lfVdNKOg8LLLwm1YnkOrdFvxe0gPYtNbWcCRQtX4D4aXRboUZq/i3+aiFa/2qOVnnQZhCx6gUWh
 dpJ8ty/VItWjftDQFCkwTfh9kda8tufHUR1THlxA2UpIbhEcR5QRb5T53GKhZ7RjWDSjidzIMza
 7ltitDtnN3ZQtgXCYzKv1FzqZ8i07mHFmcVWDJhhLXP0OnhUmtITE8sL8mJF83KR7//ldrjS9fr
 IQpdDZPJG3h8o3Hjz84Q4mi6yoYJXmjOqNCC9CixUA6mY+Urw/fKpN60P8x/rnokMEaAiJ7IOuI
 heXAK0IVo2CYP3zAibg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140042
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/10/26 12:30, Daniel P. BerrangÃ© wrote:
> On Wed, Oct 14, 2026 at 12:24:57PM +0200, Philippe Mathieu-Daudé wrote:
>> On 14/10/26 11:31, Yonggang Luo wrote:
>>> This usermode targets:
>>> aarch64_be
>>> armeb
>>> microblazeel
>>> mipsn32
>>> mipsn32el
>>> ppc64le
>>> sparc32plus
>>> are not in machine.json
>>>
>>> This is a prepare for directly using TARGET_ARCH_VARIANT latter.
>>>
>>> Also get target-info.c to be compatible with future TARGET_ARCH_VARIANT only usage.
>>> So that we can define TARGET_ARCH_VARIANT to target_name directly
>>>
>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>> ---
>>>    include/qemu/base-arch-defs.h | 13 +++++++++++++
>>>    qapi/machine.json             | 25 +++++++++++++------------
>>>    target-info.c                 | 26 +++++++++-----------------
>>>    3 files changed, 35 insertions(+), 29 deletions(-)
>>
>>
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index 07fac4f0764..a3d6e08a847 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -15,11 +15,10 @@
>>>    ##
>>>    # @EmuTarget:
>>> -#     The comprehensive enumeration of QEMU system emulation
>>> -#     ("softmmu") targets.  Run "./configure --help" in the project
>>> -#     root directory, and look for the \*-softmmu targets near the
>>> -#     "--target-list" option.  The individual target constants are not
>>> -#     documented here, for the time being.
>>> +#     The comprehensive enumeration of QEMU system and user-mode
>>> +#     emulation targets.  Run "./configure --help" in the project root
>>> +#     directory, and look for the targets near the "--target-list"
>>> +#     option.  Individual target constants are not documented here.
>>>    #
>>>    # @rx: since 5.0
>>>    #
>>> @@ -30,17 +29,19 @@
>>>    # @hexagon: since 11.0
>>>    #
>>>    # .. note:: The resulting QMP strings can be appended to the
>>> -#    "qemu-system-" prefix to produce the corresponding QEMU
>>> -#    executable name.  This is true even for "qemu-system-x86_64".
>>> +#    "qemu-system-" prefix for system emulation, or the "qemu-" prefix
>>> +#    for user-mode emulation, to produce the corresponding executable
>>> +#    name, where that target supports the respective emulation mode.
>>>    #
>>>    # Since: 3.0
>>>    ##
>>>    { 'enum' : 'EmuTarget',
>>> -  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
>>> -             'loongarch64', 'm68k', 'microblaze', 'mips', 'mips64',
>>> -             'mips64el', 'mipsel', 'or1k', 'ppc',
>>> -             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>>> -             'sh4eb', 'sparc', 'sparc64', 'tricore',
>>> +  'data' : [ 'aarch64', 'aarch64_be', 'alpha', 'arm', 'armeb', 'avr',
>>> +             'hexagon', 'hppa', 'i386', 'loongarch64', 'm68k', 'microblaze',
>>> +             'microblazeel', 'mips', 'mips64', 'mips64el', 'mipsel',
>>> +             'mipsn32', 'mipsn32el', 'or1k', 'ppc', 'ppc64', 'ppc64le',
>>> +             'riscv32', 'riscv64', 'rx', 's390x', 'sh4', 'sh4eb', 'sparc',
>>> +             'sparc32plus', 'sparc64', 'tricore',
>>>                 'x86_64', 'xtensa', 'xtensaeb' ] }
>>
>> 'machine.json' is for system binaries.
>>
>> If we want to expose these QAPI types to the user binaries
>> (I'm not sure we want...) then this declaration block should
>> be moved in another {qapi}.json file. QAPI types are versioned,
>> so we'd need some "  @aarch64_be   # Since v13.0" comments.
>>
>> Anyway I doubt we want to alter EmuTarget, I'd rather let it
>> die as a legacy field, and expose {arch, wordsize, endianness}
>> to management layer if this is important to consume.
> 
> Libvirt uses query-target so we don't want that data to go away.
> If we want to expose other data alongside the target name that's
> fine.

I'm not suggesting to change 'query-target' format; the opposite...
If we are going to add 'query-targets' (the plural form) then we
should report something more useful like {arch, wordsize, endianness}
but not that EmuTarget type which I consider legacy.

