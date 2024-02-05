Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB1AC48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 11:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWx1K-0000mY-9l; Mon, 05 Feb 2024 06:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWx1H-0000mB-1k
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:20:11 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWx1E-0006Kl-Q9
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:20:10 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-511490772f6so1531760e87.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 03:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707132007; x=1707736807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jbWkREPVqHkpdc8LVigTQLwlkrC5A6gQ+ZV4XNhibo=;
 b=t95gX69Q/HnJqqaeGuYUYXqqXDQZJo7u+sbk9MMepA+KOmF8xyTVZLCjgGEcrEg44N
 CjIikUeS3z9PxXloGbvlJc3ug6qjk/F5Mik1kOyoqxzF2rU1wkkT7izQaCTJTYndQH1B
 7U/SoHYGxDLdOGcw/yUmuZLG88x+bXtlTBEfVIZ8g+k1wo+qNOMg753yuVS45ZgzC6BV
 LrhY1qb+TAQvUju3r/6SOiylarp0DAbMRCp0Sf9BZPO8CG3IkPyfBucMe6AsZ59681YP
 zUMmYLxbXJL0mSLB8EEXgQbolEoX3wQWR1JbZihsAaAa9/NL4/CphJ29q1b1xMSr/zOj
 Pa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707132007; x=1707736807;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9jbWkREPVqHkpdc8LVigTQLwlkrC5A6gQ+ZV4XNhibo=;
 b=Z4wDuyUpgzG6Ms1RixFKzJVJrg4dljTBZ0Kmuiy66z09IYaPnw0UR1Ee+F87TfdSTB
 d//YvytwaYS5D0HN+Fgo6ZtpKDe7t/BjtoC3bREI4NTbWjZRE5khnpvXKDoBUiSBEzK6
 E39eHtiBO/v+4whbQ0D2lJly2Ca1HVrCHcC51ujUd/P1QenLnd3Lsy8Udj+zW1PVbeLR
 IvdKpHgeQalao2y/rJUJ01Rggk/sUlpxY03l2VSPxVHaqzBhExI4lRtJwyD4xOW9EiMY
 ASQ9KIq2MhXftclu9ejnkQbY9ALhztY39ekYScuiztvU5HzBwN/VCyiaY8xuSM+DngZK
 tWaQ==
X-Gm-Message-State: AOJu0Yz1ne7Ilarn/7KxIrGp6KceqQ1NIfQKCeU/tJnYDBHI/xYlmRoJ
 uF4DP/75Yq4bRzdFp6AuGATelwfESCpuHPA17DbdBdtDGCuuKTn4AANDYPpUm20=
X-Google-Smtp-Source: AGHT+IE6EI12X7pzCleMS+y7xlL2qwc8mmaWpwsKr1dY0g4fCBP0vrIYJQ9vrXKzloUCCjHhYG/JcQ==
X-Received: by 2002:ac2:58cd:0:b0:511:4a19:baa7 with SMTP id
 u13-20020ac258cd000000b005114a19baa7mr2619834lfo.50.1707132006914; 
 Mon, 05 Feb 2024 03:20:06 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUK96HfZNX0CVEI84PzGBL2hE7OhihaBNsnm99fo9cz6ip2mnMAsaMI2TLlE9AtC72AbZwfO81KB0sGN5o7sa3naVyLxnfKSeKKKS2M8EleZsH134NbUVKEIN20K9OxZqV20k0U9Q8pNQJTCynLZR7o1etiJCwaiJJLZn7ukR2IuXihJwCW2j2bJuWl4X+1UPPnRljogvRVXBT+jRpF5AFD68gKu8OIPBURlMu/gIgEYZE3CF6BDTRI49bwfvIvtOKz2k4SxPb3fxTtSJZvGVcCqkY4+PFci56iz2wWZyPix+fnNTwrBL9tPyGg4BtiTXyCZyBmMbaptHcNa9XuTdGSKq3Bq1A/Yk5uWaScDVVoILnWk5xaX7jU78LUozz3R84Uo2KhOypi9BcER7xGPEddNPUUgNevvR3p5BnpOYNESmZ2LA5M2rGaml/qhz5j4aVZnB1g+ko=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c444a00b0040fde25f9acsm814364wmn.0.2024.02.05.03.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 03:20:06 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 28C5E5F888;
 Mon,  5 Feb 2024 11:20:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Alistair Francis <alistair.francis@wdc.com>,  Bin
 Meng <bin.meng@windriver.com>,  Weiwei Li <liwei1518@gmail.com>,  Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?=
 <philmd@linaro.org>,  Fabiano Rosas <farosas@suse.de>,  Andrew Jones
 <ajones@ventanamicro.com>,  qemu-riscv@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v11 0/3] gdbstub and TCG plugin improvements
In-Reply-To: <612315ae-2132-4e41-8d16-6635dab54a1b@linaro.org> (Pierrick
 Bouvier's message of "Mon, 5 Feb 2024 14:03:59 +0400")
References: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
 <87bk8xpzyl.fsf@draig.linaro.org>
 <b34c4013-1aca-466e-b94e-55d9802928b3@daynix.com>
 <87zfwhodit.fsf@draig.linaro.org>
 <7fae3d1a-5af2-4557-a2b3-13b911e73382@daynix.com>
 <8734u7gsv0.fsf@draig.linaro.org>
 <612315ae-2132-4e41-8d16-6635dab54a1b@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 05 Feb 2024 11:20:06 +0000
Message-ID: <87le7zf995.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 2/5/24 13:31, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> On 2024/02/03 22:58, Alex Benn=C3=A9e wrote:
>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>
>>>>> On 2024/02/03 20:08, Alex Benn=C3=A9e wrote:
>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>>
>>>>>>> This series extracts fixes and refactorings that can be applied
>>>>>>> independently from "[PATCH v9 00/23] plugins: Allow to read registe=
rs".
>>>>>>>
>>>>>>> The patch "target/riscv: Move MISA limits to class" was replaced wi=
th
>>>>>>> patch "target/riscv: Move misa_mxl_max to class" since I found inst=
ances
>>>>>>> may have different misa_ext_mask.
>>>>>> As this is re-based on Alistair's riscv-to-apply.next tree I'll wait
>>>>>> for
>>>>>> this to go through the RiscV trees and then re-base the plugin patch=
es
>>>>>> and dropping the merged riscv patches from my tree.
>>>>>> In the meantime feel free to review:
>>>>>>      Message-Id: <20240122145610.413836-1-alex.bennee@linaro.org>
>>>>>>      Date: Mon, 22 Jan 2024 14:55:49 +0000
>>>>>>      Subject: [PATCH v3 00/21] plugin updates (register access) for =
9.0 (pre-PR?)
>>>>>>      From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@lin=
aro.org>
>>>>>> For:
>>>>>>      contrib/plugins: extend execlog to track register changes
>>>>>>      gdbstub: expose api to find registers
>>>>>> So I can add this to my maintainer omnibus series for the next PR I
>>>>>> send.
>>>>>
>>>>> I added one trivial comment to: "gdbstub: expose api to find register=
s"
>>>>>
>>>>> "contrib/plugins: extend execlog to track register changes" depends on
>>>>> "plugins: add an API to read registers". The comments for the patch in
>>>>> the following email are not addressed yet:
>>>>> https://lore.kernel.org/all/4b2156ed-688d-4617-b52d-200413f01156@dayn=
ix.com/
>>>> I don't think we need to serialise with the BQL as the structures
>>>> are
>>>> per-CPU (and created on vCPU creation).
>>>
>>> qemu_plugin_get_registers() has vcpu parameter, which can refer to a
>>> different vcpu the caller is on (or the caller may not be in a vcpu
>>> context at all).
>> It should only be called from the current cpu context. We can either
>> assert that or make it implicit like qemu_plugin_insn_disas does.
>> However we will need to ensure current_cpu is set before the vcpu_init
>> callback.
>> Pierrick has had to move these initialisations around for the
>> scoreboard
>> work so they are now run with safe work once the thread starts.
>>=20
>
> As a complement, in the series I'll post, the work is run
> asynchronously, but not "safe_async", which means it's not under an
> exclusive section.
>
> If you need this guarantee for registers API, it's better to add this.

We don't. We just want to ensure they line up and are not cross-vCPU.

>
>>>
>>>> As far as the restructuring we can move it into gdbstub later if
>>>> there
>>>> is a need to. At the moment the structure is just housekeeping for
>>>> plugins.
>>>
>>> Certainly we can move it later, but adding the code in the plugin
>>> infrastructure now won't help in that case.
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

