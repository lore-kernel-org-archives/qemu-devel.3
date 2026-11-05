Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57265606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VNu2dqyK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RyJENKlc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP34N-0001LZ-Fx; Thu, 05 Nov 2026 14:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP34J-0001LD-Ma
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:24:16 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP34C-0006B5-JM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:24:12 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5JLnFm2294001
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 19:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WMyAKNgHzGy1NtDJQbmGvMrSHT0vZOMTD+G3aZbFS4A=; b=VNu2dqyKy3sdq+95
 82HduM+0qkQzGSXejUnvFO12068LSVFGtQrX1XnRxwCcuAUhc0sMuBlmevg0BE3R
 kEEy23kk6QejmeqdulN3C/gPR0TltWwtNrcru8t1XCO04ItcshSdo6ST1Y9Zw7qm
 UYuDAIUjQQ6SLyc7xYvdJa6tzQ4t11Y6NKoJk3+kNkL636cZv1vHSM6mfPiwibIf
 qbjOIBbNdetMsWF1AHKODpx+ISIxYT+4sRGJyts+tKRLw++erRUIrLpfCebhQwkM
 g0g4GCjupWL+I4AEoD7Bw34ysPmzISc+3b68oh3UsSCxbm+20pMF80+v3GgMhEQS
 /IcQFw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hryw180bx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 19:24:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso3838446eec.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793906645; x=1794511445; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WMyAKNgHzGy1NtDJQbmGvMrSHT0vZOMTD+G3aZbFS4A=;
 b=RyJENKlcJiBa7Cgt4qeaX3R7CjhWKo3tBm3Lo6ZNlF9HSTmqHB5Nr0ktRxpSZASCGj
 pzl43t94SLhDZwkdooyZUQzs39TUU1tEJqP4ZsaqfQIuN9ZFiApK/EBZYOWlBXnYFJjW
 MBsYsPgz8+v+TAK1ovrtEJAkKYx94So1PHPF3ygYDwLq4ONGLheUAmrZOMNDYV+RBEsv
 fpgIvXsiY+4NLqUyzoprBBumdTqTYtFRb9Da/edPKONAjvmk7nkzToCb4QIxpImtgCCO
 VHZnGnWTaejT9v+ETBQ4jjB7uue6eHT5RwDM+xTDih30SKS8yPotINRXxXwaZuXwM1XG
 FUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793906645; x=1794511445;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WMyAKNgHzGy1NtDJQbmGvMrSHT0vZOMTD+G3aZbFS4A=;
 b=Z9dsAiFcjlx9a7mrbJQ1JJOucI2c7mLVrniDsWLZqw0T2OsvapZIULuWRdJhnnLeB5
 GT48tlUSXSGuowiQQAQhu1iVJvQszxfVL+kBA7LjflDwc7nacC2dRF8pLJS2zSzYCQnp
 6xc/MEmRXIY0WpTzgXHDkfWGvobHpQg6kTIyqaQhGKRX892WTcIMEJw3acgF38KqaZ0G
 bSnsQcYjmOsVWghgEusnsSrid9yUxbdh+sloA/jinPkoDtMUOYg8w3NfMMVcreyNoQo6
 BtWru5FMe8J/aWOn0m8BlaFx9ZzULprKCIfaOwzsz5Nk3hB0e4nMLo8rVSY00ctP28Ev
 0e7g==
X-Gm-Message-State: APuU4Z+i5PY5yGb2DGN/UjOE+bHE1tEeBeMD21Ef4WEMyaM9FIu+zkGK
 kktB+IuTBst4luH8CbK53fwuMPp1EdsqrMZgZLSldEUaqRdNayH1uuRXXp2TQtQ1RNfibvKSAQn
 tGnkXIf1QVLG5vLlnadRrC0fQJ+uOwfVNsWMvNZP6EUmKsb3Qkpecryekkg==
X-Gm-Gg: AYBFou0C+ulFur5s/MTnqxeV6jkBrKYwhyGjaS1fSZFtDpQQ6L2Hb7ru8iBp8ktCgcy
 a5u9ZZGKuf1DqAglnQd6AGgpY/gEYFkusEcwZuvKx11hX7s7PByDKmwhj796PxEvWRxQzgWceCR
 xDeD2bvqMx3k6RdLoUci0MvLohu3xAuuKhYYFqrl2DMUrpzMiJippHBU7crgm++FnT2Xqn9Sorb
 n47AkSo83JH37LJCXoUpgtMCWr0oMAfQ6V9e6Hp7JWHUMIBfiVXz1Eykot6q+aY6+SGyUtNOvrC
 fgDY3WxGpUl15qUtAsu/IdVTMN9NKwykBmmHPFW7Vu3fSql4C2I+TzHvYyO6Kmb5LLe1L7l18Md
 x5loW05v25P2Q2ME+mJ34bEaZKa6ZC9RdmBsPsqBPkw9FbQhFvierzXDSCwuPMceb60K1OSJ71r
 HYQPHCSq822E/0DtOzjBaEEnRVQLkjexZWewDR7rYrDg==
X-Received: by 2002:a05:701b:4542:20b0:1b2:42eb:7e11 with SMTP id
 a92af1059eb24-1b242eb8877mr11334472c88.26.1793906644435; 
 Thu, 05 Nov 2026 11:24:04 -0800 (PST)
X-Received: by 2002:a05:701b:4542:20b0:1b2:42eb:7e11 with SMTP id
 a92af1059eb24-1b242eb8877mr11334427c88.26.1793906643758; 
 Thu, 05 Nov 2026 11:24:03 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c748eesm17784701c88.23.2026.11.05.11.24.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 11:24:03 -0800 (PST)
Message-ID: <11937e5d-0f06-4b3e-87ad-c0ddff9ef16f@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 11:24:01 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw: support machine filtering without is_available
To: luoyonggang@gmail.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
References: <20261105102432.1131493-1-berrange@redhat.com>
 <CAE2XoE8xNP=kwSROoHQEdRBLjmPGnY61mkQd=_t1oRHpD1QiXw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE8xNP=kwSROoHQEdRBLjmPGnY61mkQd=_t1oRHpD1QiXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 13wTn2X4Jzak3lhwGTJqGXVa3Xvb11K5
X-Proofpoint-GUID: 13wTn2X4Jzak3lhwGTJqGXVa3Xvb11K5
X-Authority-Analysis: v=2.4 cv=RdYFmFtv c=1 sm=1 tr=0 ts=6aecd7d5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=kjWcN1VGAlVaIRif3qoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3NyBTYWx0ZWRfX5gud2OS+Xznx
 tModHFI8mtRGRfeP8VwiHlFG1l3LqnGsL7DweMklotRuLnYLd2KMNkFM+pwfwkkSW9mVtPw5Apr
 hYwd+j0DE/br9Mh16AxQAkK34SQSsDHpW0LXlZ2ksBvQRx0hRAHSlrrBaUN2EYKyZrk/WBD56GD
 9rfIZx2bVl/Z+cpO2+t6j+ZUT+fXOTsvVe4i+Mspq3bBWU8o1qciNQwAI00oTPTgx8+XJWC5I5T
 9uGtWb6HKacJzgwOzm0NYxVhNk8xhMDewE7U5Pgd1yyfDki8wnSLcb5ORU4dwHx+kLjJjX/ee1i
 6JBPUhNzyDI8L1VNdWwAZrVtkPu51Jmc5ed7kgcd/wzWoGpK+stIwyHt9+aD+DcWXtlJjewrt2S
 x2AQHfnU9OBxd3FH0ooQ0Ud020orgVk98q1ynF59gpQg8oqTAfAkpkYhpctxBfyCZNJ2igc5Cmp
 4BrvglnSo2alGJVxohg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3NyBTYWx0ZWRfX6aGei/olexsV
 qiCZ0TKj3e+4nu3g4IdY/GhgNZ9rEFgs1aGhW7cJpPjzBrh/3aRex/+ZDXnK2UU8wKQNXXXPNUb
 2ow+FejXtCGD051oVfDcJWlr64ih6B8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050077
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/2026 11:18 AM, Yonggang Luo wrote:
> On Thu, Nov 5, 2026 at 6:24 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> The 'is_available' callback on TypeInfo is based on a mistaken
> 
> Thanks, we realized the limitation of 'is_available', and discussed
> with Pierrick a lot
> about this, I implemented both ways to remove 'is_available' in my local branch.
> 
> One is this idea(these patches), add targets in MachineClass::targets,
> but we have to rename "virt-machine" that
> in conflict.
> 
> The other one also achieves the same effect, except no need to rename
> "virt-machine" QOM type names, by introducing a private
> TypeBucket in object.c I post a small series to answer you question,
> in my local branch, "is_avaiable" is removed.
> https://lore.kernel.org/qemu-devel/20261105190346.1539-1-luoyonggang@gmail.com/T/#t
> 
> 
> In both local branches, there is no more QOM name conflict, and target
> is selected till the machine selection. so that
> have no target_info() access in class_init or type_init.
> object_class_get_list(NULL, true); can be called without target
> selection, the current question which direction is better.
> Both ways works fine, and both ways have their advantages and disadvantages.
>

I was waiting for Daniel to explicitly describe what is expected:
implement it is even better. Now that we have the two approaches clearly
described, I'll let Daniel pick and finalize the one he wants to see for
this new binary.
Only requirement is that it has to build and pass the multi target test,
so we know there is no regression.

Thanks for your work and persistence on this Yonggang.

> 
> 
>> notion that we should filter out classes at registration time
>> based on architecture.
>>
>> This creates new problems however, some already present and
>> some which will impact a future multi-target binary
>>
>>  * For introspection of the binaries' features, we have
>>    a dependancy on selecting a target before we can
>>    introspect features. It would require re-launching
>>    QEMU for each target, leading to lots of redundant
>>    introspection and a big time sink. It would also not
>>    be possible to introspect targets
>>
>>  * It creates a circular dependancy on QOM initialization
>>    inside the QOM initialization code, since 'target_info()'
>>    itself uses QOM. This then requires further work to break
>>    by initializing QOM target info before the rest of QOM.
>>
>>  * We have no means to introspect what targets a machine
>>    type can be used with, as this information is expressed
>>    as code (in target_XXXX() methods), instead of as data.
>>
>>  * New fields in TypeInfo requires more changes to macros
>>    used for initializing machines.
>>
>> There is no inherant conceptual reason why we must filter out
>> classes at type registration time. This is just a shortcut to
>> workaround historical technical debt where certain classes
>> have clashing names. This is an undesirable approach, as it
>> is trading one set of problems for a new set of problems.
>>
>> This series proposes removal of the 'is_available' concept
>> from QOM, and illustrates handling machines with full introspection
>> support available from the MachineClass.
>>
>> This implies fixing the root cause, of clashing class names,
>> but does not include patches since various series have already
>> been posted for machine class name fixes.
>>
>> The machine changes are fairly simple
>>
>>  * MachineClass gains a 'targets' field which is a bit mask
>>    of SysEmuTarget
>>  * machine_class_is_available() matches 'targets' against
>>    'target_info()'
>>  * -machine CLI enforces machine_class_is_available()
>>  * query-machines filters on machine_class_is_available
>>    by default
>>  * query-machines gains 'all-targets': 'bool' to opt-in
>>    to returning the unfiltered list, with a 'targets'
>>    list present
>>
>> NB, this removes filtering from riscv CPUs with no
>> alternative proposed. I'm unclear what this was trying
>> to address to begin with, but utlimately it should be
>> possible to address it with runtime filtering/matching
>> of classes, instead of hiding TypeInfo registration.
>> If someone gives me info on the CPUs problem I can a
>> make a design suggestion.
> 
> 
> 
>>
>> Daniel P. Berrangé (4):
>>   hw/core: record permitted targets against MachineClass
>>   hw: replace 'is_available' with 'targets' in machines
>>   target/riscv: remove 'is_available' from riscv CPUs
>>   qom: drop the 'is_available' callback from TypeInfo
>>
>>  hw/arm/aspeed_ast27x0-fc.c  |  3 ++-
>>  hw/arm/aspeed_ast27x0_evb.c |  5 +++--
>>  hw/arm/raspi.c              | 21 +++++++++++++--------
>>  hw/arm/raspi4b.c            |  3 ++-
>>  hw/arm/virt.c               |  5 +++--
>>  hw/core/machine-qmp-cmds.c  | 18 ++++++++++++++++++
>>  hw/core/machine.c           | 13 +++++++++++++
>>  hw/hexagon/virt.c           |  3 ++-
>>  hw/m68k/virt.c              |  4 ++--
>>  hw/or1k/virt.c              |  3 ++-
>>  hw/riscv/virt.c             |  4 +++-
>>  include/hw/core/boards.h    |  3 +++
>>  include/qom/object.h        |  3 ---
>>  qapi/machine.json           | 12 +++++++++++-
>>  qom/object.c                |  4 ----
>>  rust/qom/src/qom.rs         |  1 -
>>  system/vl.c                 |  9 +++++++++
>>  target/riscv/kvm/kvm-cpu.c  |  1 -
>>  target/riscv/tcg/tcg-cpu.c  |  1 -
>>  19 files changed, 86 insertions(+), 30 deletions(-)
>>
>> --
>> 2.56.0
>>
> 
> 


