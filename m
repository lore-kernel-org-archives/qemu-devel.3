Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C810C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd8RL-0001ab-Ah; Fri, 26 Jun 2026 11:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wd8R8-0001ZT-2X
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:25:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wd8R5-0001Bn-Fj
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:25:45 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QF44QG1150895
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 15:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pmTPpcUP6+bGRKOlJ61wMwLG41VtmkKzGLDeUHsYHUQ=; b=fHP6SAApNd/mBdJb
 JGENPFP17NHcy/dkav8YiloLrf7t+rtPR8WHOMPqLSob+TuHtwoeAHSKizVw7jIG
 HKwap3nTpKi+CvyCRHw2lB+eJSjYYoBqWhULmEiyRwT/Fu4LyChTU3VvjHD3/9CX
 glWx+ebli/fMN4qMF3HDpu1g/1BDldIb1yFisYDEhqp06mOYvW/mWlPOSdjGPbFu
 O1fdxjYznvUvl6m9gdYHvaQGDG2/8aC4d2gSBettayi/0SdgI1mKGvE/jyBOG8sU
 9bBiZMkwAvwKqUZQqSgBZ5/ABVoYyG1a3RsDUSAMzIDEUN7qEiI+A7l1eEP4kUGy
 hXwIrA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1fgdu2k5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 15:25:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30ca81e05bfso478185eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782487538; x=1783092338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pmTPpcUP6+bGRKOlJ61wMwLG41VtmkKzGLDeUHsYHUQ=;
 b=kXLL1ngh5T6W+v9LlbUhVm//82i3/iV1BSPAVdU8uwRvNrQN26MPZLLOecNQ8q44dl
 Md83lO0XWY1yEL2GKj68C7ftreWoOySYGRM1BlZPspt0qlBbrTXh/IQ+SjsI9d8Pcru2
 w7wz8scAW/K/ib4/g1qsdIxexT5qV8RU21PRomnhx5EVAc32BUg4wc9S6lF2Ht3e9G7+
 ZFxq7+kGNDuBKWVz/9ci+wA+4sp60g9bco7iRMOgs5glhY22WE7wvkr0prSrbiyl/L/t
 5//UjQCRqdUnbAT9jP3GnraSwwCsK7MZFJkAH6uE4+J8MenVy/aGSzD6GTI/OVyKXifB
 j4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782487538; x=1783092338;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pmTPpcUP6+bGRKOlJ61wMwLG41VtmkKzGLDeUHsYHUQ=;
 b=SvsF+GZPs2vqdVRrhWfZ+YOMfswFgFHSaF3831BI5OEUGn5gZLj23LmSOeRy/6tiew
 NexcQ0LUf0f/AlGZcNYTxFaj1URPs+gUb/dQplCFycfCBzK3/Uz2Nb0V1vsFKrqs5+Gg
 QSiArzayf7T809am6E1wE5zIY8MFcbleSlGErutUK+6YgEUcqt8c+MTpBlbRtNVNqefl
 +L0HwVZFtK7uoW+HS6sc6ew377yIhQeJSqcHL6pCVzH6+/T0TCkn+OTZU3kHW+yIqxiZ
 vew1gEKpEFwdu/smsnCPusod4jiAlck71s1hs23wBOgo1/dRG7iJay1n8GBvf4eu3Xoi
 z+1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJUiW046xjx5YkP7/AC3KmTcMX9tvkDNvlJFNhbLAm08K/2CWCuAfid90SGCy6PCBucHokHEXcGJ7z@nongnu.org
X-Gm-Message-State: AOJu0YyjSHvOMGz0wwfnb3bBN4g/gxUCJzG2O4JljS7kXexi084UeiI0
 PXqHrtU3AxypViv4CY8WZ+UbECu1PurO4nS7iJ7iaqL5mpIz+ubRA2QYgsNVTRlB6IQtKyFuJGo
 cjtm9D2WvlCbWoVHJGZAEhpsamr/qlH+KdBBWZbpDaPeB4ZycpdmbdtPdQg==
X-Gm-Gg: AfdE7cnU41g3J1jdHBcCVyNXyrIz/IPkbo8f0Lx87VIXzD+kHqcfR4nrSe6fix+cjIk
 5aJVHSzHRGDZctGU93w9Z6sX14g50BdBglLHfN/q+bd22wxaxHiALupkij4krGcr5g5fDFyhCm0
 heEUB6AsZaOP6ZENNbcGX13BF4VCwI1nfQ7MLL6xSfwHX6qLqIhdkBG3h2dBb5u8yxe/gZGAFmQ
 O73Vb+5KYcYU8TWy9F0Old8sgVLophBeo0o0arZvjlBNDMCp2C3j46cTXePwvbthGEkwQglKAJV
 Dbygom2jk9CGwzzvYb0yBdptdW4hz4ZWly9YdVHCvToURpl8/U35ABSrAjKzw9e/0YgWbWRCA1/
 nFbYHQ69Dt2/p/dEGAfSkYlszo4LgX4l5uVkMVZQaqfeKzjZfkSSW5S3BQ8MRrbRDi5D6gjn1gg
 gcIZc=
X-Received: by 2002:a05:7300:80ce:b0:30c:ab4f:46a2 with SMTP id
 5a478bee46e88-30cab4f490fmr737774eec.38.1782487538289; 
 Fri, 26 Jun 2026 08:25:38 -0700 (PDT)
X-Received: by 2002:a05:7300:80ce:b0:30c:ab4f:46a2 with SMTP id
 5a478bee46e88-30cab4f490fmr737743eec.38.1782487537608; 
 Fri, 26 Jun 2026 08:25:37 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ab6sm30337618eec.15.2026.06.26.08.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 08:25:36 -0700 (PDT)
Message-ID: <bd41b617-c5f3-4b9b-a8e3-25d76d37bf13@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 08:25:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
To: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
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
 <CAKmqyKOJ4xgYq4G2DsZMocdXKBuekFxNUkvK0x6qJzZHjXN5QQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAKmqyKOJ4xgYq4G2DsZMocdXKBuekFxNUkvK0x6qJzZHjXN5QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=API5kwXb c=1 sm=1 tr=0 ts=6a3e99f3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=IerRr1emMuI6M3M2-zUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyNyBTYWx0ZWRfXzmm+RLGPMEzf
 ehaW0jT/IcIlY9d+8F/Ldu6cZYfSAdG9YaFjc17Libh2hcWzGYZI1nQ3d1gflGRrX9ofAoZJLNO
 etlNNe//hOAginLZ6eZTbnBFxdT3nnvA6Te43j0uk7gJCsE6xWbWSWLZ3yZYItija1icwPHAuGb
 liB/rEBhnqcCZ8PbGhXgaSvXphC4ZtZBFKVUcnbEH7nau32oaFZx7CnYB+PgJlNduZ8aU58jMll
 y2qJoVunZA6wSQ0AKaW7MqZJ+RDQbbU1wbsMd5IyLGtUuOhzvlJin+sKbqopqeyhwOSY11cZN+5
 aNTjkXtijVwKRIYfuUbZXtEQkdv9pfkdDmeTPul6LD7YDE6ssrrWoY7YwtS+ULrcBN0PblsOAWt
 SUQsL1YmqTCy2/6ghxGGnab+YtBW7quax7KsLsreGdH7gps3dc+WSzDhUlCC84Hk+FFNPzL1TQd
 gMDKX6ATxYpyXxM2XtA==
X-Proofpoint-ORIG-GUID: 9wO0JOhbzFHvpvWHAt4EGOCgPFZy6hp_
X-Proofpoint-GUID: 9wO0JOhbzFHvpvWHAt4EGOCgPFZy6hp_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyNyBTYWx0ZWRfXyAbbkZP5lpap
 x5na8ShKyrMR1f/xEo5+GMqte8/VgmGRN1rYXSL+1iW0VJUyd+G7KzJB8UTmjWQU6UKgcO5Z/x7
 artGyhPgDZuyKMUO4RNRMzgO3aADu/c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260127
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

On 6/25/2026 6:37 PM, Alistair Francis wrote:
> On Tue, Jun 23, 2026 at 9:39 PM Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
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
>>>>>>>> It is yet another attempt at fixing --disable-tcg.  We have a recent
>>>>>>>> work sent to the ML [1] and we had Phil's attempt back in 2023 [2].
>>>>>>>> Phil's work didn't get merged and it's now too hard to rebase and
>>>>>>>> revive, the most recent attempt got misled into the 'what is common code
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
>>>> Don't we have ways of saying in the commit message "these patches applies
>>>> on top of these other patches" and then the tooling would deal with it?
>>>> I remember patchew doing stuff like that with that "Based-on: <message-id>"
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
>> maintainer's tree.  And we could make a better job at informing developers that
>> submitting a patch for qemu-riscv, vfio or any particular subtree, means that
>> the patch should be based on a maintainer tree X.
> 
> I would prefer patches on master, the issue is it just creates a lot
> of conflicts. That takes time for me to fix and I'm always worried
> that I'll mess something up and it will go upstream with a bug that
> wasn't in the original patch because no one gets a chance to verify
> that I rebased it correctly.
>

I agree it does not scale. It creates friction both for you and people
who submit in the subsystem.

>>
>> The thing is that sending patches on master only works if master is always up
>> to date, and that's not feasible with our current style of merging PRs.  This
>> series we're commenting on is an example: it doesn't apply to master because
>> there are pre-approved RISC-V patches in the maintainer's tree from 2 days ago
>> (also my patches, I might add) that caused conflicts that I wasn't aware that
>> would happen.  This conflict would have to be dealt with at some point by myself
>> or the maintainer, and it's not like 2 days is too much time without a PR.
> 
> Yeah, I try to send them every few weeks, but when all the patches are
> touching the same few files it's hard not to hit conflicts.
>

Then simply apply a FIFO strategy. Take series as they come, and leave
conflicting one out. IMHO, it should not be the responsibility of a
maintainer.

>>
>> We can argue "this is an exception that doesn't happen that often, we should
>> stick with using master as a base", and to a certain extend that's true.  But
>> then this sort of conflict happens again, then again, then again, it comes to
>> a point where it's easier to tell developers to use the maintainer's tree instead
>> of master.
> 
> Which is exactly what happened. I think I have just asked people to
> rebase on the RISC-V tree enough times that they just start with that
> from the beginning.
>

How about merging things to master fast enough so people can just rebase
on master? It seems like it would solve both people problems, and yours
also. No need to do any rebase, and no wait time for developers.

The only thing it requires is to increase PR frequency, and I would even
go as far as suggesting to send one PR per series if you want to provide
the best velocity possible for this subsystem. Just automate the push
and CI triggering, so it does not take more than 2 min of your time.

When a conflict happen or a test fail, simply ask "please rebase/fix",
and wait for the next version. Not your problem anymore.

What do you think?

> Alistair
> 
>>
>> Maybe I'm downplaying the problem because I've been sending stuff based on the
>> maintainer's tree since forever and got used to it.  IMO, unless we decide to be
>> like libvirt and create the "committer" role to allow trustworthy devs to push
>> stuff to master after acks, making it more feasible to expect master to be up to
>> date, I'm afraid we're closer to a kernel-style workflow.  For better or worse.
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
>>

Regards,
Pierrick

