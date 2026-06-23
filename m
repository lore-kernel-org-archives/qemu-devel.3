Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4135FCDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6NA-0000gs-P5; Tue, 23 Jun 2026 15:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wc6N9-0000gE-HK
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:01:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wc6N7-0003LD-0c
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:01:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NHqDmc031289
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 19:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i0jY6H4BER++6324o3goILoQzkhbY/gu7rmVgrr4LC4=; b=k90lU4oh7jdx3itD
 bodOPBxKpskQHFJCA8CertdpzTLie0emP4+BORwywJr1ZETYLjYJkiXLuEE2+JvZ
 jXJ3KYPimW1O96GB0fLka1EoQYtSkHsf+5PcSYJL9rZJw3bcqUkgrv2CcL0hNHHa
 g6ZML52n82A1IvLD7pkThd3Uvx40hCD8+4N72BMBV3NztyR4FRUVnAxY1zr32dbq
 ndI+5F5Lai5ZvxAn7bF8vmjtWdVj0ZUy3KbIjajwzN7wx2PYesx57Tc+0ohIpILM
 cMFaL0XiqADWlT594DX/hyEgEm9UYE5stfrDp3ZhhRYN50YmnWgQ1ZCeuB2+m1oL
 /GCQmw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyqe6ajd0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 19:01:19 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-69e8587d9caso197189eaf.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782241278; x=1782846078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i0jY6H4BER++6324o3goILoQzkhbY/gu7rmVgrr4LC4=;
 b=Z0s3i8aIzfmr6Ap5xIkadRGKQ1RfaO47pyksFRO/1KssU2ciIyXACPcwX1+YmUfK8x
 q5zw9AtT3yb64vdYNGVTdNnkzfRgpeeWjXI3YM9lrXET6HAfwdzSJCSTjNWi0FhSbBWY
 xomGt3XJJhjU3mlp6q9G7B+H2qsSzSUIwzj3XIMypFrptm+xty3xktb1DZrmxdMrqsa5
 EGVmvkvqlTaa6JG+3N/5LJlOPancdKREQJyWp4tp5No67uT8KSpsBhaHxfIPMZkTfd5o
 4fEen+nTyEPdymxCQKjGrMUu0e5E/CGr8hGUOTtKWNeHZCpO5RvibYWxX/vJ77JXpObU
 LKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782241278; x=1782846078;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i0jY6H4BER++6324o3goILoQzkhbY/gu7rmVgrr4LC4=;
 b=jENyMSN9T9e6tsFvh9iJcmu29CO8dFeNNjKpWGu4vI8QMuCnOeLvXkJ0cGk+sNx2fz
 OpPzUTROgpE5ATOrk7A7IpbBdSyqpHi+d5+sut9NBcPSADp9kHreV5aJ/MC5sw/3IYLn
 irYXOQEOZdhpUHrjTTTRH1Fs00Jf208Kpg2arklASfBCQHgEE3pWK6nSSBtOuFY0PGZg
 uZWScWfmHoYEh4chHjnBjHiPnbL2tzkD0jKfrpAocitHl7JW0OHmMshoyK+OQugqyInq
 j0dJEOLdO+/cwX4IrUsbgNNiJf5LVJx7ucnr7RZ5ssp4uBWnFNmeOwZtfT97CcURo3QB
 4vWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8doxALRJ6gn5d/Pn2rVsGjoncHnVSjiVymUbfuxtn9aEIUNel9o0dORiGxmJHIFDk5XuMfcmXVfIcu@nongnu.org
X-Gm-Message-State: AOJu0Yyt/mguDMeP5PiHxRI8s68ZaakwPGvot42WDrTNxxjJfWlNG8TA
 H+dlk2GWXcbC+hcjqr5amFD/vkQ+UQaCY4RM5tC85HVC4BnTyrxGCBKpHXY7YuoFuY+nElBfkW3
 NbsDSjNaqr+jAkbDqiP7zVEo48TT2AbphgX8Slx4FsPnN+uxwigeQxw19Jg==
X-Gm-Gg: AfdE7ckwcLyurklpTrEzywp7uYrt+F3vY0F0DMmUhDpzVNCAIWrFvuMYoqyA1MMzioa
 bI86VzC9yuWHNdolHha3SfCqdv54vCsey83P9Vu9Sau8FFVL9UfKEelfVmiQrH1ac0v4D6WzfgB
 469OTaV1aQZ8ug6Qsl6qMm0QsHfIulkQV0Acm1vxfAKcgwthV8TyByLXwqWR8qEZFr+p3HwRxnw
 hGdlUUvjxm5lu4nxG9e+KrqTeXFRc79Z+Lw2lOH5mnVaXoWYDkqAPK1V4zWAc4eTsqBLzwRVuSi
 T7adsHQSgG2PACFQoOPRUt5AVlQwVJO2PI3460qCyvMzV3lR5TwKVCYHC7JlCWzWPUlT+QTHVRa
 /pfa04lGpa02JKSY52WY5zJ3QINj2kYZ/aTgBU46c79VP
X-Received: by 2002:a05:6820:1c93:b0:6a1:13f7:2118 with SMTP id
 006d021491bc7-6a122fedec9mr4458eaf.29.1782241278259; 
 Tue, 23 Jun 2026 12:01:18 -0700 (PDT)
X-Received: by 2002:a05:6820:1c93:b0:6a1:13f7:2118 with SMTP id
 006d021491bc7-6a122fedec9mr4414eaf.29.1782241277705; 
 Tue, 23 Jun 2026 12:01:17 -0700 (PDT)
Received: from [192.168.68.103] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df7f8f1464sm148319266d6.19.2026.06.23.12.01.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 12:01:17 -0700 (PDT)
Message-ID: <fe77f7a1-1a31-457c-9dec-e1b49cd35371@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 16:01:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
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
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0f2205d0-06b5-40ad-9952-e18a6a951078@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6nrZ7FemkxEjeORQgeYu1RkjbeqimsSj
X-Proofpoint-ORIG-GUID: 6nrZ7FemkxEjeORQgeYu1RkjbeqimsSj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1NiBTYWx0ZWRfXzO76ItUuBBal
 aapZyh5BEmESB2mJLZ6kH22MV8nLCkpsKKHuziVgs7PYdBS6AXcjf1zWzZwN78UPtGKw06IJamO
 fabq60GVhZufScFZGZ5DY6z24Arf/XM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1NiBTYWx0ZWRfX/7EcPEUkLmF0
 QuuR+8J3QaFGPYZKsM2JiLLC2iK+Cb2+hlaxOcMiLmOQ3o8S1Kb+xcPKFj8ftR5FPmodGCwq+Z6
 N8rzdGMN/dff+PxbvmL1VtjTk9Wcs+HRqRHGSb03wBaW3Tj43lHuXhmAr0nNT2gunz1/Wu/bBCl
 nmblTodt+hK2aFmMbfhp19vTmuwyDbxHbcNwKAI9X2mpd9o3CppF65kF7TuOPK65XDi1Pn4hMoC
 VEf04+twq4pv5rhZmCVZAaYN8fBD7T3cWKw9/S3IdGNUYtKLGtRzjX3EI3dw7moF1i5p3o1VkwP
 Fbb3DI7d7PSyhCVc3sevOxOJS5pvaHZQrzQSA05HNPt6S4e9LhnNPTvUxJj2Y6l0whZRlC5NDFJ
 7cwx+W4ONqCHz1C95+XEzH5EVFjZ2k8IjKSl03G01IVp/fz+poBp4Odvv5+aE/FNKu7N+f5jd0T
 PzNnJvii3wpjWiI9YxQ==
X-Authority-Analysis: v=2.4 cv=OeKoyBTY c=1 sm=1 tr=0 ts=6a3ad7ff cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=AnIwrFvORbfaNLpTvcgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230156
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 6/23/2026 1:10 PM, Pierrick Bouvier wrote:
> On 6/23/2026 4:38 AM, Daniel Henrique Barboza wrote:
>>
>>
>> On 6/23/2026 6:58 AM, Peter Maydell wrote:
>>> On Tue, 23 Jun 2026 at 10:49, Daniel Henrique Barboza
>>> <daniel.barboza@oss.qualcomm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 6/22/2026 6:34 PM, Pierrick Bouvier wrote:
>>>>> On 6/22/2026 2:23 PM, Philippe Mathieu-Daudé wrote:
>>>>>> On 22/6/26 22:52, Pierrick Bouvier wrote:
>>>>>>> On 6/22/2026 12:31 PM, Daniel Henrique Barboza wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> This series looks scary but it's mostly trivial and mechanical work.
>>>>>>>>
>>>>>>>> It is yet another attempt at fixing --disable-tcg.  We have a recent
>>>>>>>> work sent to the ML [1] and we had Phil's attempt back in 2023 [2].
>>>>>>>> Phil's work didn't get merged and it's now too hard to rebase and
>>>>>>>> revive, the most recent attempt got misled into the 'what is
>>>>>>>> common code
>>>>>>>> between TCG and KVM' dungeon.
>>>>>>
>>>>>>
>>>>>>> It seems like series does not apply on top of master, would that be
>>>>>>> possible to rebase it?
>>>>>>
>>>>>> For some reason the RISC-V series are handled distinctly than the
>>>>>> rest of QEMU, Alistair queues work on his repository and developers
>>>>>> are custome to base their series on top of it (otherwise Alistair
>>>>>> can not apply them on his tree and asks for reposts), see the
>>>>>> riscv-to-apply.next branch on https://github.com/alistair23/qemu.
>>>>>
>>>>> Unfortunately, it makes it hard to run any kind of automated testing,
>>>>> especially for series like this that target specific configs.
>>>>
>>>> Don't we have ways of saying in the commit message "these patches
>>>> applies
>>>> on top of these other patches" and then the tooling would deal with it?
>>>> I remember patchew doing stuff like that with that "Based-on:
>>>> <message-id>"
>>>> tag.
>>>
>>> Yes, Based-on: is our convention for marking "this patchset needs some
>>> other one to be applied first". But that should be the exception rather
>>> than a common case -- if patchsets regularly need to be based on
>>> something other than head-of-git, this is I think a sign that
>>> maintainers are not sending out pull requests frequently enough.
>>>
>>> I would prefer it if QEMU didn't develop kernel-style "subsystems
>>> have their own particular workflows" fragmentation -- I don't
>>> think we're big enough or that sub-parts of QEMU are sufficiently
>>> well separated for it to work out well.
>>
>> I agree that rebasing things on master is better than rebasing it on the
>> maintainer's tree.  And we could make a better job at informing
>> developers that
>> submitting a patch for qemu-riscv, vfio or any particular subtree, means
>> that
>> the patch should be based on a maintainer tree X.
>>
>> The thing is that sending patches on master only works if master is
>> always up
>> to date, and that's not feasible with our current style of merging PRs.
>> This
>> series we're commenting on is an example: it doesn't apply to master
>> because
>> there are pre-approved RISC-V patches in the maintainer's tree from 2
>> days ago
>> (also my patches, I might add) that caused conflicts that I wasn't aware
>> that
>> would happen.  This conflict would have to be dealt with at some point
>> by myself
>> or the maintainer, and it's not like 2 days is too much time without a PR.
>>
>> We can argue "this is an exception that doesn't happen that often, we
>> should
>> stick with using master as a base", and to a certain extend that's
>> true.  But
>> then this sort of conflict happens again, then again, then again, it
>> comes to
>> a point where it's easier to tell developers to use the maintainer's
>> tree instead
>> of master.
>>
>> Maybe I'm downplaying the problem because I've been sending stuff based
>> on the
>> maintainer's tree since forever and got used to it.  IMO, unless we
>> decide to be
>> like libvirt and create the "committer" role to allow trustworthy devs
>> to push
>> stuff to master after acks, making it more feasible to expect master to
>> be up to
>> date, I'm afraid we're closer to a kernel-style workflow.  For better or
>> worse.
>>
>>
>> Thanks,
>> Daniel
>>
>>
>>>
>>> thanks
>>> -- PMM
>>
> 
> In this very specific case, where base patches are needed, maybe it
> would be better to make the required commits appear in this series, and
> mention in cover letter that patches 1-N are just coming from another
> series and are already reviewed/approved. IMHO it doesn't hurt, and
> reviewers are free to skip commits already reviewed.

That's fair enough but I wonder if that won't scare people away with
even bigger series :D  in this case here I would need to either send all
the queued patches, making the series go to 40+, or I would need to triage
which patches from the queue creates a conflict with this work and send
only those.

Now, as for qemu-ci ...  How farfetched it is to make it read a specific tag
in the cover-letter, e.g. "branch-id", that can point to a gitlab/github
repo with the patches, and use that code base instead of applying the
patches to the master branch?  Then for the next version of this work
I could do

"branch-id: https://gitlab.com/danielhb/qemu/-/tree/riscv_disabletcg_v2"

and the tool would still work.  If there's no "branch-id" then it assumes
that the patches are to be applied on master.


And yeah, in an ideal world the problem goes away if we just do more PRs and
strive to keep 'master' updated.  I'm just thinking out loud about possible
alternatives until we reach that point.


Cheers,
Daniel

> 
> Or, a solution I'm not fond of but I ended up adopting most of the time,
> just wait for required patches to be merged on master before posting the
> series, and work on something else meanwhile.
> 
> Ideally, yes, it would be better if maintainers could send PR more
> frequently to avoid creating those intermediate staging trees. The
> faster we merge, the less conflicts we'll have.
> 
> Regards,
> Pierrick


