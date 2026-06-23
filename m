Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2F9CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbzSa-0007cp-Ds; Tue, 23 Jun 2026 07:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbzSV-0007bo-9a
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:38:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbzST-0007TE-0u
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:38:26 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBZ9pk030761
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UPpoLKGJWRlJieChzufFTnRGpcbnyegvHeqLvZG8LBc=; b=Y+NZ6MdGITg9XXb8
 Xj3Ejdd9pdNr+8/yQVh4Vxj3vpaGhfPaJ+G5wP0hwZ6we0lTf1UPAnydx3kRxvRs
 V7fGJxDoUgWN6/cdhz+cy5AJ/gdoDg/aT1AWw/DCBPNHHZfxq4ds9yEJIiLOAVtb
 kOme/HbTVzO8Lh7ZIi7lXSIDK2HEy8qd0PqCd3qa3xZZsV7bD+10d7oX6dCgAiz/
 YOy1W9o6dr76BJzYF2Vp/iB4/MyPW+Fp3UnCM2Gx7EQQj1U/U39ppkI4wMAg4L18
 02hnSOwEWQIJ5os6ZqadMgnatOi2MTpZmG9VGFVUu7zYV5d85pENDuKrMMgv+vsm
 8FD0QQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyqe68jqq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:38:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a5212cf77so14997181cf.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 04:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782214703; x=1782819503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UPpoLKGJWRlJieChzufFTnRGpcbnyegvHeqLvZG8LBc=;
 b=YQGYNuI+nRRGB6ckOY1YKbf9cVTdvnipGH5YC5aYCWhzjIv4A2eUamyVklQyjvlV7E
 HVZCunEQM5uDWokOBS8vKwWhUTiX0SnzKYgfQNk+29S8DyYNxxRDK/fCYxF/Hn3rSswR
 QskrU6qzIKEv1FYjhIy5x+NfZiclwOOQK3Fj7IEsvikbgSnmiag6TSbW6MrpMKZzbThf
 4Z2XzhdbyBKcj5ju/RoUSW/dZuZ4I1VfElvRe9jgpt5+DX5909HhIsduB4UfpeOceXV/
 pFTHZyvfiPfnGcD8rbBmayINGhbmvf70w4v2fv+MX++3V5l6NiRLreTHZUeqcwm65ipz
 IGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782214703; x=1782819503;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UPpoLKGJWRlJieChzufFTnRGpcbnyegvHeqLvZG8LBc=;
 b=QFMWjxfdyDo5f8yfoBxEq2Z0Iw38LZzd82elJCCyO6vM3Dxfch9tOxgs+nz9CJNLjt
 SXoP2uAFNrDE4nkWAGU0ja9rAWgqpkzgW7rMUmW2u4x1TJVGadrePny2UmprzNZMZk/t
 hYP5U+28l+tdpBY6nYy/zRXv0nX8eZFo7kC9uDg1dXBWuIaLujB0Ufx7IWuYXSkynAWc
 HnGvM1NQ/bPf5fieDKnDOrccmjxZGTojRfNpQTw7GirgVFpaO2kbeD9LsuTSF9ZlBM/y
 Y7xIH4ceLn2gFu52Y+pi/fI3bTfSfQOUvkjQaM8stiYwMe4Fl5zskcuvs1b6vgFn61m/
 UrpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wx8ycIiWIOihuXWTOhv5yrf2QuqV/DQwaM1lzKGdWcxPR5xtaTpn/mXgrzQo/sejaChrCSwoXFpO2@nongnu.org
X-Gm-Message-State: AOJu0YzX6a+h39wHTiNbVw20KUJ7HvQT0gvlM8h2rbi9s0MFoUpfHnA2
 X8+NIuIi4jr/RNO5sDr41ALmstd3GX2p4j2neP6FbrWLmu3VZyfDOqwznqlMDdMsfKzdERv4PtX
 wMNaiOTwkLL9kRl1MA1m335BZemNuHQDrdMoZwP7dLE+QjOOgX+jsXxpqtA==
X-Gm-Gg: AfdE7cnvKZVono0UI+MD6VRRQRVaFh+3hhGsRI9FDIfVh27TNrOlkbQYidh9kWcaMv2
 KPTeitPhicgp7sINW0bBu4UDYfJ9JdqP7AEyp4UxSld+Yf19lb0rTUsDY+TbHZ5bEolxgQo3T9a
 16aiMpLhWMNbxvW/ey57m7vVQwSXvtrNRAtm/OVKuYIHXyleCoE2065XFLIoZ+Vfm1+Tflzu0WB
 FEMxrQa+2EzBpEik0pVsmy6L7J6ASCm+M+zxqr5ukyIS9IaO2rR03PA9K1hhaK2QykWqGUH2gXD
 IuV8T6qN/ZMvmjUp6GsjfK/2dbdoWaoDg7dtrwO5jc3eI4dhmbSJVWRui+8LUBpSLsgdCOoc6bf
 NGDwCb7FxGxbWF9fqq1QOX4Xg9s84sx5kONPusTV+6hVA
X-Received: by 2002:a05:622a:1f18:b0:519:e1b7:5ba with SMTP id
 d75a77b69052e-519e4a52925mr318466851cf.15.1782214702672; 
 Tue, 23 Jun 2026 04:38:22 -0700 (PDT)
X-Received: by 2002:a05:622a:1f18:b0:519:e1b7:5ba with SMTP id
 d75a77b69052e-519e4a52925mr318466311cf.15.1782214702193; 
 Tue, 23 Jun 2026 04:38:22 -0700 (PDT)
Received: from [192.168.15.10] ([187.35.50.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51afc29csm21296831cf.27.2026.06.23.04.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 04:38:21 -0700 (PDT)
Message-ID: <df4a5857-ec4f-4d4f-bc08-1a9c5caae100@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 08:38:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
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
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA8660BZOmX_KXeF7JJaJwgKO3zSRDEmJURg27FK=tqbZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 198BeKYFSfl6yRDRdAWEOMPBRc4inJha
X-Proofpoint-ORIG-GUID: 198BeKYFSfl6yRDRdAWEOMPBRc4inJha
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA5NCBTYWx0ZWRfX2QM5x7onD0qj
 yrBCBGlfCsTWwzFJ8bmqiqU2pRM6L7DmqeAcgd6ZfeoQ++eK11+URtFp0VtByTqnbnkAvifwClG
 Wda5yFa+/dUxrBsSnKQG86HTjDtOxFA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA5NCBTYWx0ZWRfXzyMwHQHlCE/e
 yqqgHJugPGQ7kMoAGjZgLa+8TqJCdaPdM+3Xi3LMDGyr5emlTqqI6+ReGYuMWQKHnZIiB1NxsCp
 4CdTPGW0/Wt22d8r5sNMWTKf1VTqnjadye4F0eln3lIh2U67oBUOyUAOg2tt52Q1jYCJdi7NFqb
 mG2Yy6eo9JRLVq6Thv09h3Yo/aK4eoOjxQCkWrY7m2KfwSuePzXo+sEfnha9FExHbAIMyV7TPyL
 738SDds/fMmeCiMXpNQiIujNiqC3srF0vUeiAUjirOaGuH52+id3DIVoRiyYjsRXuhOqYfC9e3Q
 VtKkqHAhMcIF244lBNw52ziQuXgb9GJqq2EXgDkKtTnW39d2A9nwmJQBd8+GIXeCKkJKWD5jWcL
 gw/d+Gt0RoHYpaqyJHs/nkjuJvxA0UAbEXdji0WCOjvCiZPtqfuoaoCYiQvh7Z7rjvL7e2LZ1q2
 e/WR45825SCeW2uy7+g==
X-Authority-Analysis: v=2.4 cv=OeKoyBTY c=1 sm=1 tr=0 ts=6a3a702f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4zNbLBpji/9weHA2+kqC8A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=4gx32tC3VWhf73K_kkgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 6/23/2026 6:58 AM, Peter Maydell wrote:
> On Tue, 23 Jun 2026 at 10:49, Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 6/22/2026 6:34 PM, Pierrick Bouvier wrote:
>>> On 6/22/2026 2:23 PM, Philippe Mathieu-Daudé wrote:
>>>> On 22/6/26 22:52, Pierrick Bouvier wrote:
>>>>> On 6/22/2026 12:31 PM, Daniel Henrique Barboza wrote:
>>>>>> Hello,
>>>>>>
>>>>>> This series looks scary but it's mostly trivial and mechanical work.
>>>>>>
>>>>>> It is yet another attempt at fixing --disable-tcg.  We have a recent
>>>>>> work sent to the ML [1] and we had Phil's attempt back in 2023 [2].
>>>>>> Phil's work didn't get merged and it's now too hard to rebase and
>>>>>> revive, the most recent attempt got misled into the 'what is common code
>>>>>> between TCG and KVM' dungeon.
>>>>
>>>>
>>>>> It seems like series does not apply on top of master, would that be
>>>>> possible to rebase it?
>>>>
>>>> For some reason the RISC-V series are handled distinctly than the
>>>> rest of QEMU, Alistair queues work on his repository and developers
>>>> are custome to base their series on top of it (otherwise Alistair
>>>> can not apply them on his tree and asks for reposts), see the
>>>> riscv-to-apply.next branch on https://github.com/alistair23/qemu.
>>>
>>> Unfortunately, it makes it hard to run any kind of automated testing,
>>> especially for series like this that target specific configs.
>>
>> Don't we have ways of saying in the commit message "these patches applies
>> on top of these other patches" and then the tooling would deal with it?
>> I remember patchew doing stuff like that with that "Based-on: <message-id>"
>> tag.
> 
> Yes, Based-on: is our convention for marking "this patchset needs some
> other one to be applied first". But that should be the exception rather
> than a common case -- if patchsets regularly need to be based on
> something other than head-of-git, this is I think a sign that
> maintainers are not sending out pull requests frequently enough.
> 
> I would prefer it if QEMU didn't develop kernel-style "subsystems
> have their own particular workflows" fragmentation -- I don't
> think we're big enough or that sub-parts of QEMU are sufficiently
> well separated for it to work out well.

I agree that rebasing things on master is better than rebasing it on the
maintainer's tree.  And we could make a better job at informing developers that
submitting a patch for qemu-riscv, vfio or any particular subtree, means that
the patch should be based on a maintainer tree X.

The thing is that sending patches on master only works if master is always up
to date, and that's not feasible with our current style of merging PRs.  This
series we're commenting on is an example: it doesn't apply to master because
there are pre-approved RISC-V patches in the maintainer's tree from 2 days ago
(also my patches, I might add) that caused conflicts that I wasn't aware that
would happen.  This conflict would have to be dealt with at some point by myself
or the maintainer, and it's not like 2 days is too much time without a PR.

We can argue "this is an exception that doesn't happen that often, we should
stick with using master as a base", and to a certain extend that's true.  But
then this sort of conflict happens again, then again, then again, it comes to
a point where it's easier to tell developers to use the maintainer's tree instead
of master.

Maybe I'm downplaying the problem because I've been sending stuff based on the
maintainer's tree since forever and got used to it.  IMO, unless we decide to be
like libvirt and create the "committer" role to allow trustworthy devs to push
stuff to master after acks, making it more feasible to expect master to be up to
date, I'm afraid we're closer to a kernel-style workflow.  For better or worse.


Thanks,
Daniel


> 
> thanks
> -- PMM


