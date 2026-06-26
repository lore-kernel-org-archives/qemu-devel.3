Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3899C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd8TX-0002Ar-U8; Fri, 26 Jun 2026 11:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wd8TR-00029o-I6
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:28:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wd8TP-0001SG-6a
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:28:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QF3tdO1198710
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 15:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AVaqti0KHdXH0np9lbq88qwHwi3tR+h1fIA48WixgBg=; b=gwCxZm5/YXWt9tvE
 Z/tV8+ByHgQZYy/Qb8/ilEu6bwT7DVxD7ncswWEoJWNRr2ptSM8570Aml00DdNzD
 BBb9Q+mdbrBp4SAYpt8gVBKT2+ZEq91ymPrQJP7BjQiEAgp94O/U8NphmejDpPKH
 12VGAVfXjQ4FdqvQdEBLut6Ws4FyquptGDPrWW4i78ILexEGwyxXlfKoPs+BC2nw
 Q8MLJW/iaeHU8JMwh2rtVgN81ZMjrc/hLDk4xvGZsa+pCx6F2VDD56M4uiFjHaFF
 Fe4K9Ui8JtsDYLYeKMvNn9rPv3iUt/B6cQJWXNt54xxV1BgSfw38I98b9cxaBL7r
 NbF0Xw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1t0qrj35-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 15:28:05 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-137fc6f8e9fso841200c88.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782487685; x=1783092485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AVaqti0KHdXH0np9lbq88qwHwi3tR+h1fIA48WixgBg=;
 b=X94QmM51DmxmFfMDT9NqpQOn6zq0g0uhxmvFdOyApzhHezcyEmQq2sxo/WugZ2Sblj
 9KRr/FUf3mrKLsGxIgC6eJ6V9gQFyOPcW/+A/bxDlFD2ZgZuyltRhAdynEzVFnCRDAr2
 3O7cFNM0am/bYdMehwEIb/1TwBKKo2IFXqXtH/x4QFRfCZDRjd2qHtXiWJ2R4LHmddZS
 5WVnAFX05WuYBdvuPtlNhCZgdasWoaVGoumPAx/kE7YcZxoFJmvSEE5oHpJPv/i/aC5D
 65z66cgjXxYVEQyUnNNMyQ0gqyB0fQrqukz117aPsp2AlKAZFhOh77kbQAn5vH/rddmj
 4Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782487685; x=1783092485;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AVaqti0KHdXH0np9lbq88qwHwi3tR+h1fIA48WixgBg=;
 b=Me1inJKEUPOMTMoxxgBtYCEKeqNhwdy1Kdt24KefR+/CEE/kAXVgpDvIEkJ8EQPKck
 spmALv+VO7TyRscdmbFtXHHISN6jMRQeaMkvtkry0l5mSxW3o0dBAdDm1grmrBrM0aTT
 IU7SUnQfVssUl1aphgWVhGkhoDG12YMKdzrUSYY3rxEqKROprnJjcoI7a2lDtiuEakMP
 j58DcO9TGzwQOwugpfCH3ALiqK7UXMo5MCPpoxB10H/hPOhABJzjdNl/chP8exIV83Vc
 vk9ioIhd0JKwrT7D0blRLOXNVGYtGuWjsBZ/GVq4VJnN5cpUa86flCuJiK8nB7kTYmBI
 AWHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yMno2493RXTQf57yw83iIRbOyH91YuT2ZBdANtUxnt4zald4XyjI72Adcr+sWpCM8Ynp4jtWwBoCk@nongnu.org
X-Gm-Message-State: AOJu0YzdaSAK+NUOZ+/9fWJXv2kPHo3RHp7cO8kvmXgQF3qYv6q/P8vG
 G6/1sKPGgVhzjvayZgq/65A87PGl4DJJFhDmNgxwodpOz1UySr2GnDhqge/Ko+1OWZ0ZVTmN46B
 u/5ZHYM5/C6vm65URLLjPO1vtz/G1DImDcjy9f4WRol5i75GINEDHHcgo0w==
X-Gm-Gg: AfdE7cnQaf7kJd6Ha8sM5l9acGwXzlEij9csxAw0WvXWFdW01d23xhpUkltVc59zESQ
 ts+W+cLO6/bYl3l+Hn0I+M84qp3J+561va1XPxT0bGgMkrmK5oxZekScA2kkjhhCF7C8Lfn1Vri
 EloE2s/lmpzGHn5eeF7aMYb7w12hhgPbdGPlqvS4O4KttNPIlwJPoSp093aI5kT1LnZVnODB1FW
 TI7QwnBafv+AIUrbQ5aB2kdXOzPMmRo6HmK7gUP3+eMDuisOIPEMtWkctfmpbwp///6LTMo86m7
 k/wMwk6PKxeaGAN+mPiDWo5HsPyP9KQHO0qOp0sUOFzVu0x3r1j3k4XMgg249Uqh+e87BXZizL6
 1ZbDexIZNNUtLpMhAPz/6Lma6rMXuvPJhSRnAmU5i8NMC9LsecEiC6I9zvkUKTL42RxOKJswhvL
 UoRBI=
X-Received: by 2002:a05:7022:ec83:b0:138:51c:c5aa with SMTP id
 a92af1059eb24-139dbae338bmr5252431c88.27.1782487684752; 
 Fri, 26 Jun 2026 08:28:04 -0700 (PDT)
X-Received: by 2002:a05:7022:ec83:b0:138:51c:c5aa with SMTP id
 a92af1059eb24-139dbae338bmr5252405c88.27.1782487684074; 
 Fri, 26 Jun 2026 08:28:04 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e4c33af7sm6143851c88.5.2026.06.26.08.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 08:28:03 -0700 (PDT)
Message-ID: <feb50737-7897-4881-95f1-cdf1725bb7a2@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 08:28:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <52c3605c-345f-43d2-8cc6-794980c805fa@oss.qualcomm.com>
 <50ce1e98-2c1f-4cbd-b191-1eac324b71b6@oss.qualcomm.com>
 <704cfba3-e92a-498d-928b-877f7f7641fe@oss.qualcomm.com>
 <9d2737e3-34f0-4f68-813b-37059615bced@oss.qualcomm.com>
 <CAFEAcA8660BZOmX_KXeF7JJaJwgKO3zSRDEmJURg27FK=tqbZg@mail.gmail.com>
 <df4a5857-ec4f-4d4f-bc08-1a9c5caae100@oss.qualcomm.com>
 <0f2205d0-06b5-40ad-9952-e18a6a951078@oss.qualcomm.com>
 <fe77f7a1-1a31-457c-9dec-e1b49cd35371@oss.qualcomm.com>
 <d83a2e21-403f-4146-b129-4d9ee264282a@oss.qualcomm.com>
 <CAKmqyKOXPCWPFP7Htr5BByp=7jsDDp6kYXRhyn6Ycre0pjofCg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAKmqyKOXPCWPFP7Htr5BByp=7jsDDp6kYXRhyn6Ycre0pjofCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyOCBTYWx0ZWRfX1Rxdrk9oNPqe
 fKZBUa1cC1tYuSyhak472PkI0821NXdj3x4mq2pG+pvcN8EB0KsYfAOIqOVhpV75XZ3c1YDptmt
 3yXt3KD8fGO9qDJgW3faSIY3s8l0bTk=
X-Proofpoint-GUID: UVmfqzRQV_osC2cW6iuW7AwCVgpB7rKY
X-Authority-Analysis: v=2.4 cv=StqgLvO0 c=1 sm=1 tr=0 ts=6a3e9a85 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=5sm5QLcBCla-CBgxaecA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: UVmfqzRQV_osC2cW6iuW7AwCVgpB7rKY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyOCBTYWx0ZWRfX3W4+++0+X+ib
 60Le+lttqYkA4Hii7JNB3IXV0PHXDBTuWdP4Tu23z1Mo4sxvE5BtmTxv7LuKo4CH5e7duY+hW9k
 4Gg2vn4e9T9vN0GaRTDG6c9A4YJ1eJs4sSI9njopDx5D4qeDfTrR9bp20Kow98H66SS/WXDwG2X
 cRzqIxND7zHbwcDncf4tGWL5ssqnJlUI8S0N10vEUDP2J+F3qj192kXv0/6lvEjnS2GFF6zoBzE
 Ppl3DDaJsKdiHzvKWmCGeM9Jlis0EJNrMaQhgWl2+Wjc7p54ze6fbzpKB+FgGJaBSCPIcgPqY+c
 ZD4mEv2Pn7HM6GCaudIBVmrHgPlGeDJt2ah2FGqSkDJIySnBCkV5JG48FB9k2z/odjPsee+zNb/
 7F06gArZnHBtgx3pQ22Guy0OTj0dzXzryvLIx8ydXd0cmdga+y/tz5jzoy4sCCH1fshf88TTe5q
 Ex6+xjnkxZHdPEVmtRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260128
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 6/25/2026 6:41 PM, Alistair Francis wrote:
> On Wed, Jun 24, 2026 at 5:18 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 6/23/2026 12:01 PM, Daniel Henrique Barboza wrote:
>>>
>>>
>>> On 6/23/2026 1:10 PM, Pierrick Bouvier wrote:
>>>> On 6/23/2026 4:38 AM, Daniel Henrique Barboza wrote:
>>>>>
>>>>>
>>>>> On 6/23/2026 6:58 AM, Peter Maydell wrote:
>>>>>> On Tue, 23 Jun 2026 at 10:49, Daniel Henrique Barboza
>>>>>> <daniel.barboza@oss.qualcomm.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 6/22/2026 6:34 PM, Pierrick Bouvier wrote:
>>>>>>>> On 6/22/2026 2:23 PM, Philippe Mathieu-Daudé wrote:
>>>>>>>>> On 22/6/26 22:52, Pierrick Bouvier wrote:
>>>>>>>>>> On 6/22/2026 12:31 PM, Daniel Henrique Barboza wrote:
>>>>>>>>>>> Hello,
>>>>>>>>>>>
>>>>>>>>>>> This series looks scary but it's mostly trivial and mechanical
>>>>>>>>>>> work.
>>>>>>>>>>>
>>>>>>>>>>> It is yet another attempt at fixing --disable-tcg.  We have a
>>>>>>>>>>> recent
>>>>>>>>>>> work sent to the ML [1] and we had Phil's attempt back in 2023
>>>>>>>>>>> [2].
>>>>>>>>>>> Phil's work didn't get merged and it's now too hard to rebase and
>>>>>>>>>>> revive, the most recent attempt got misled into the 'what is
>>>>>>>>>>> common code
>>>>>>>>>>> between TCG and KVM' dungeon.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> It seems like series does not apply on top of master, would that be
>>>>>>>>>> possible to rebase it?
>>>>>>>>>
>>>>>>>>> For some reason the RISC-V series are handled distinctly than the
>>>>>>>>> rest of QEMU, Alistair queues work on his repository and developers
>>>>>>>>> are custome to base their series on top of it (otherwise Alistair
>>>>>>>>> can not apply them on his tree and asks for reposts), see the
>>>>>>>>> riscv-to-apply.next branch on https://github.com/alistair23/qemu.
>>>>>>>>
>>>>>>>> Unfortunately, it makes it hard to run any kind of automated testing,
>>>>>>>> especially for series like this that target specific configs.
>>>>>>>
>>>>>>> Don't we have ways of saying in the commit message "these patches
>>>>>>> applies
>>>>>>> on top of these other patches" and then the tooling would deal with
>>>>>>> it?
>>>>>>> I remember patchew doing stuff like that with that "Based-on:
>>>>>>> <message-id>"
>>>>>>> tag.
>>>>>>
>>>>>> Yes, Based-on: is our convention for marking "this patchset needs some
>>>>>> other one to be applied first". But that should be the exception rather
>>>>>> than a common case -- if patchsets regularly need to be based on
>>>>>> something other than head-of-git, this is I think a sign that
>>>>>> maintainers are not sending out pull requests frequently enough.
>>>>>>
>>>>>> I would prefer it if QEMU didn't develop kernel-style "subsystems
>>>>>> have their own particular workflows" fragmentation -- I don't
>>>>>> think we're big enough or that sub-parts of QEMU are sufficiently
>>>>>> well separated for it to work out well.
>>>>>
>>>>> I agree that rebasing things on master is better than rebasing it on the
>>>>> maintainer's tree.  And we could make a better job at informing
>>>>> developers that
>>>>> submitting a patch for qemu-riscv, vfio or any particular subtree, means
>>>>> that
>>>>> the patch should be based on a maintainer tree X.
>>>>>
>>>>> The thing is that sending patches on master only works if master is
>>>>> always up
>>>>> to date, and that's not feasible with our current style of merging PRs.
>>>>> This
>>>>> series we're commenting on is an example: it doesn't apply to master
>>>>> because
>>>>> there are pre-approved RISC-V patches in the maintainer's tree from 2
>>>>> days ago
>>>>> (also my patches, I might add) that caused conflicts that I wasn't aware
>>>>> that
>>>>> would happen.  This conflict would have to be dealt with at some point
>>>>> by myself
>>>>> or the maintainer, and it's not like 2 days is too much time without
>>>>> a PR.
>>>>>
>>>>> We can argue "this is an exception that doesn't happen that often, we
>>>>> should
>>>>> stick with using master as a base", and to a certain extend that's
>>>>> true.  But
>>>>> then this sort of conflict happens again, then again, then again, it
>>>>> comes to
>>>>> a point where it's easier to tell developers to use the maintainer's
>>>>> tree instead
>>>>> of master.
>>>>>
>>>>> Maybe I'm downplaying the problem because I've been sending stuff based
>>>>> on the
>>>>> maintainer's tree since forever and got used to it.  IMO, unless we
>>>>> decide to be
>>>>> like libvirt and create the "committer" role to allow trustworthy devs
>>>>> to push
>>>>> stuff to master after acks, making it more feasible to expect master to
>>>>> be up to
>>>>> date, I'm afraid we're closer to a kernel-style workflow.  For better or
>>>>> worse.
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Daniel
>>>>>
>>>>>
>>>>>>
>>>>>> thanks
>>>>>> -- PMM
>>>>>
>>>>
>>>> In this very specific case, where base patches are needed, maybe it
>>>> would be better to make the required commits appear in this series, and
>>>> mention in cover letter that patches 1-N are just coming from another
>>>> series and are already reviewed/approved. IMHO it doesn't hurt, and
>>>> reviewers are free to skip commits already reviewed.
>>>
>>> That's fair enough but I wonder if that won't scare people away with
>>> even bigger series :D  in this case here I would need to either send all
>>> the queued patches, making the series go to 40+, or I would need to triage
>>> which patches from the queue creates a conflict with this work and send
>>> only those.
>>>
>>> Now, as for qemu-ci ...  How farfetched it is to make it read a specific
>>> tag
>>> in the cover-letter, e.g. "branch-id", that can point to a gitlab/github
>>> repo with the patches, and use that code base instead of applying the
>>> patches to the master branch?  Then for the next version of this work
>>> I could do
>>>
>>> "branch-id: https://gitlab.com/danielhb/qemu/-/tree/riscv_disabletcg_v2"
>>>
>>
>> Based-on: is a QEMU specific tag, that is only understood by patchew,
>> and no other tool to my knowledge.
>> b4 has base_commit, which allows to give a specific base, but not a
>> specific repository. I'm not aware of any b4 tag that allows to mention
>> a base series. It makes sense, series are not branches, and stacking
>> them comes with a lot of problems.
>>
>> So it seems like email workflow is quite limited in this regard, and the
>> only way to deal with it properly is to wait for base patches to be
>> merged, or include them in the series.
>>
>> From another perspective, the same problem would exist if we would use a
>> forge like GitHub or GitLab. It's not possible to stack PR on top of
>> others, and only solution is to wait, or duplicate patches. IMHO, it's a
>> sane default, as it forces correct ordering instead of allowing chaotic
>> development.
>>
>>> and the tool would still work.  If there's no "branch-id" then it assumes
>>> that the patches are to be applied on master.
>>>
>>>
>>> And yeah, in an ideal world the problem goes away if we just do more PRs
>>> and
>>> strive to keep 'master' updated.  I'm just thinking out loud about possible
>>> alternatives until we reach that point.
> 
> When you sent v2 of this series it had been one week since the last
> RISC-V PR. Are we really aiming for more than one PR a week?
> 
>>>
>>>
>>> Cheers,
>>> Daniel
>>>
>>>>
>>>> Or, a solution I'm not fond of but I ended up adopting most of the time,
>>>> just wait for required patches to be merged on master before posting the
>>>> series, and work on something else meanwhile.
> 
> I do feel that a few people do that, just not Daniel :)
>

Waiting works well if you know the wait period is deterministic. "Ok, I
missed this train, let me catch the one next week". Unfortunately, it
varies per maintainer, and some are even stochastic processes on their own.

I can't blame people who submit and are not maintainer to feel
frustration with this, it's a real issue.

> Alistair
> 
>>>>
>>>> Ideally, yes, it would be better if maintainers could send PR more
>>>> frequently to avoid creating those intermediate staging trees. The
>>>> faster we merge, the less conflicts we'll have.
>>>>
>>>> Regards,
>>>> Pierrick
>>>
>>
>>


