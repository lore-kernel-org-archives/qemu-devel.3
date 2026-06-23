Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8B8CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc3hc-0000xv-9D; Tue, 23 Jun 2026 12:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wc3hZ-0000xa-Fn
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 12:10:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wc3hW-0001cg-R9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 12:10:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBYd02113363
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 16:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Nn68GzsSOPTN4V54dVGdEL6Il1YL42paCKU0WkAvG3o=; b=cjOigWNm6r5CFP8K
 Z3yE2KPZaImFdN8VAo/5lQPG5F7KN9JcI9zIYLwRgA4GhVHtn8M8MdF9328jPyTV
 HHOCoQJXhE1saoBR/Us0TpBP3OH/bEqUn/yJPkB7WAAfQtlcqOlD+V/3ZMSyOd7y
 U2Ry+5FRk2IfOe/cWnu9NPTFLXBLTkVADQosNW6LifiE6KIJDspiyUjbgCjIn7sg
 ZD0+1d2OO6uWMwMdbhif798ccyd5yQO8KZ2fJU5zUPwi/+IKe7LX24DdDVidLzIJ
 jKOnM2dES0guDJE9GntLQ+a6y3Ev6THsageo99rcc0goSQWnd7xlIY5Y3SU76aPD
 yFygnQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eymnvtern-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 16:10:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c5978b108so1853118eec.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782231012; x=1782835812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nn68GzsSOPTN4V54dVGdEL6Il1YL42paCKU0WkAvG3o=;
 b=eKtr7dg7sym+PAAlLiUGuFUy6dgaxbG9HdnEABxwzYpO69vgV5cIqgH4prS6C+LrvR
 UBGlBtmRiMHE3prB4naCYjb0t/4UDzuypDa+3J9TLbYo12O+MWLB55zGw/B+6vscOjSR
 7X/2AI1ZX870rSKwJ2UQddOiDbf2azJAOPZigqRTdqYLhu40xQP1cuLU+AfBJ1FKdfMp
 mqbnggcSeunah5OtbTMVzrHF//4yoX87n/qcOW7GSAJAA4Ybk940hMZ6CmLMGprJsW9T
 Pin612fnMGlVTXoogJ/1vaJqpSbTacQIUxhAHQaVq3EUu8EiOV4Z8U3idVkwbxjLwl0B
 JdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782231012; x=1782835812;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nn68GzsSOPTN4V54dVGdEL6Il1YL42paCKU0WkAvG3o=;
 b=nY0XTlr/3BEPqY/BMoy8mzwZWSL6O30FmPHInErv+BPibbxx/ySDeWH/Yqjgw4mTqc
 bOMcC5d+RuJu/rFZfS0fhJJRH5YhX33ieBsUqYeHjDtz4YBVw9EjpH5TXOVCO4x88Rld
 iuO0B7FnqXVLd6wHRwHfeq+NEJq87Qydoq5oSr2NydA+W9VZlwmpR6fJHMw+PaSSTP4j
 zXwrReM7bVie2xUQUY4pbkWtfAha+smw2JP4uknEQOFmTn1wrZh5zIB64VFBIkxhbfo5
 G0R4IezYCS7Qif+zT9LnclilM95x8RhSmIL+qb5v6pVUBE908iCzdLKciEsbwcBhID4M
 0S6g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4uZCdrHBlJySj4npsrvpe6S7BUfJJdygqgsPBwrEMti0ELYtJyocCGosZA0B9eG6oNSnptUV2v0OH@nongnu.org
X-Gm-Message-State: AOJu0YwxhgufjACYiMDJIhNyTRpGhkCYS6AAsp3LyJPXdOQUFluAGq8G
 S8pq7eYSziqZwGdU1v4d+C4iw519fMDcuDNWYJCLJ9ithmZO5Re8Cjmi3aWM9HKVeNXgVGkoXlD
 fR68Y7oc2ZsuBK+W9PdKF4nylW9AK38VdhuTKz+ggTsD8McUhQ+LCgBzX4A==
X-Gm-Gg: AfdE7cn49moMLO879DgXTnHzbkbhwSewC1fyHqwqhaHMHVh7LgxGA5Q1TQGuEl1N1X0
 rb14c4yhKYV0S4E/oxyAb1uNB9Gq4Y0hio5YHUzwUUtFEsFJqUSqR5bo4Xzis/KtyqdokYu5rw1
 jUDRZTWNBHMZek81+3BCEat3oGkzaAFzqlsFkp03WiX/VeprxHGFyyv2+TBJYaGejV9iQ34gIiU
 Wb0hJT3j2z1eMswN6tiDe68vMmW264NiN3LIuxWK+Nnf7I/OLrEOWpicy5bM+tQdwFQEM551uA+
 XnCAbWxNZrgeRY/fJ7MBe8Xv3dhHVZa5XGeWy/QOcjjttnZDwVLRMP3TDmM9ALrGM+zX0SFMQjD
 HPj+EPBr0XUV8Vdcklhpo9KZYaVwOyhJKUV2GYArk/e4c2E4M+UUDMaJ+ej/LxI2llCo5r6pHV5
 3qd0k=
X-Received: by 2002:a05:7301:9f0f:b0:30c:5534:e6f1 with SMTP id
 5a478bee46e88-30c5b962df4mr2726553eec.29.1782231011565; 
 Tue, 23 Jun 2026 09:10:11 -0700 (PDT)
X-Received: by 2002:a05:7301:9f0f:b0:30c:5534:e6f1 with SMTP id
 5a478bee46e88-30c5b962df4mr2726511eec.29.1782231010980; 
 Tue, 23 Jun 2026 09:10:10 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d779sm17030447eec.17.2026.06.23.09.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 09:10:10 -0700 (PDT)
Message-ID: <0f2205d0-06b5-40ad-9952-e18a6a951078@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 09:10:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <df4a5857-ec4f-4d4f-bc08-1a9c5caae100@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dOWWXuZb c=1 sm=1 tr=0 ts=6a3aafe4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=N8n3KahPn3zQMflmis8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzMiBTYWx0ZWRfX0sZqmHL5f1Jp
 //mg0+GT/Dyqdrnjud7IBM1eEyhIQ/ftltNxSADJvqtpPXrto+2Sixf85k1dX43V24jXlqdgbVV
 3HseCuchfLfa1+UklpF+cH8A+S8TziE=
X-Proofpoint-ORIG-GUID: wd3qSFGC9xIe8fQPtTndgnoHKwaa9EZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzMiBTYWx0ZWRfX3N9BfSoRdKAL
 JaLzH/yEHMzqDHiKwBBnzufw7FqjFxdVKdHVqfeSuknbwRtOJHb5t3Hhg2Qedj8tQWkEULdkXa4
 tZDIifRXFO5GZ1kj+A/Id49oM6/1bO1EBHqLyZp9wB1MiR8X0eSVOnCc5P8gi4khSFUy+7e42Qw
 mEZzlvRnHsMO9FPp/6F+q0E3kFfjg0DGJNrFmR7NU5HsDjGHo/zgRUp3q6zvIdXV8dH5i0GFa6A
 hRgdGXXifIMUjL74ljtNDvb+A2jr/KQJc5YAijPZBJfkY8tSxsPE2MDzTGl5Paup2a+J3PWScbi
 wJ7WLeNC8FYn7n/m1pw402GX8xzy1TMdt3LkoRmzwkf+foruqphxW2ikut5+Sasnb1CcxrYbh26
 Raw21jTh8u3CbrdSblyErYVh27RVCT/wxnAoX/m02uLRjx9d2TPAL0KNITyLaV8eoPPRprjb9d3
 sgDKBLi9gQsCQ73KzfA==
X-Proofpoint-GUID: wd3qSFGC9xIe8fQPtTndgnoHKwaa9EZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230132
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/23/2026 4:38 AM, Daniel Henrique Barboza wrote:
> 
> 
> On 6/23/2026 6:58 AM, Peter Maydell wrote:
>> On Tue, 23 Jun 2026 at 10:49, Daniel Henrique Barboza
>> <daniel.barboza@oss.qualcomm.com> wrote:
>>>
>>>
>>>
>>> On 6/22/2026 6:34 PM, Pierrick Bouvier wrote:
>>>> On 6/22/2026 2:23 PM, Philippe Mathieu-Daudé wrote:
>>>>> On 22/6/26 22:52, Pierrick Bouvier wrote:
>>>>>> On 6/22/2026 12:31 PM, Daniel Henrique Barboza wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> This series looks scary but it's mostly trivial and mechanical work.
>>>>>>>
>>>>>>> It is yet another attempt at fixing --disable-tcg.  We have a recent
>>>>>>> work sent to the ML [1] and we had Phil's attempt back in 2023 [2].
>>>>>>> Phil's work didn't get merged and it's now too hard to rebase and
>>>>>>> revive, the most recent attempt got misled into the 'what is
>>>>>>> common code
>>>>>>> between TCG and KVM' dungeon.
>>>>>
>>>>>
>>>>>> It seems like series does not apply on top of master, would that be
>>>>>> possible to rebase it?
>>>>>
>>>>> For some reason the RISC-V series are handled distinctly than the
>>>>> rest of QEMU, Alistair queues work on his repository and developers
>>>>> are custome to base their series on top of it (otherwise Alistair
>>>>> can not apply them on his tree and asks for reposts), see the
>>>>> riscv-to-apply.next branch on https://github.com/alistair23/qemu.
>>>>
>>>> Unfortunately, it makes it hard to run any kind of automated testing,
>>>> especially for series like this that target specific configs.
>>>
>>> Don't we have ways of saying in the commit message "these patches
>>> applies
>>> on top of these other patches" and then the tooling would deal with it?
>>> I remember patchew doing stuff like that with that "Based-on:
>>> <message-id>"
>>> tag.
>>
>> Yes, Based-on: is our convention for marking "this patchset needs some
>> other one to be applied first". But that should be the exception rather
>> than a common case -- if patchsets regularly need to be based on
>> something other than head-of-git, this is I think a sign that
>> maintainers are not sending out pull requests frequently enough.
>>
>> I would prefer it if QEMU didn't develop kernel-style "subsystems
>> have their own particular workflows" fragmentation -- I don't
>> think we're big enough or that sub-parts of QEMU are sufficiently
>> well separated for it to work out well.
> 
> I agree that rebasing things on master is better than rebasing it on the
> maintainer's tree.  And we could make a better job at informing
> developers that
> submitting a patch for qemu-riscv, vfio or any particular subtree, means
> that
> the patch should be based on a maintainer tree X.
> 
> The thing is that sending patches on master only works if master is
> always up
> to date, and that's not feasible with our current style of merging PRs. 
> This
> series we're commenting on is an example: it doesn't apply to master
> because
> there are pre-approved RISC-V patches in the maintainer's tree from 2
> days ago
> (also my patches, I might add) that caused conflicts that I wasn't aware
> that
> would happen.  This conflict would have to be dealt with at some point
> by myself
> or the maintainer, and it's not like 2 days is too much time without a PR.
> 
> We can argue "this is an exception that doesn't happen that often, we
> should
> stick with using master as a base", and to a certain extend that's
> true.  But
> then this sort of conflict happens again, then again, then again, it
> comes to
> a point where it's easier to tell developers to use the maintainer's
> tree instead
> of master.
> 
> Maybe I'm downplaying the problem because I've been sending stuff based
> on the
> maintainer's tree since forever and got used to it.  IMO, unless we
> decide to be
> like libvirt and create the "committer" role to allow trustworthy devs
> to push
> stuff to master after acks, making it more feasible to expect master to
> be up to
> date, I'm afraid we're closer to a kernel-style workflow.  For better or
> worse.
> 
> 
> Thanks,
> Daniel
> 
> 
>>
>> thanks
>> -- PMM
> 

In this very specific case, where base patches are needed, maybe it
would be better to make the required commits appear in this series, and
mention in cover letter that patches 1-N are just coming from another
series and are already reviewed/approved. IMHO it doesn't hurt, and
reviewers are free to skip commits already reviewed.

Or, a solution I'm not fond of but I ended up adopting most of the time,
just wait for required patches to be merged on master before posting the
series, and work on something else meanwhile.

Ideally, yes, it would be better if maintainers could send PR more
frequently to avoid creating those intermediate staging trees. The
faster we merge, the less conflicts we'll have.

Regards,
Pierrick

