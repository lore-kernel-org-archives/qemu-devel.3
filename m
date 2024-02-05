Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D778EC48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 09:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWvK6-0007eX-BC; Mon, 05 Feb 2024 04:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWvJy-0007de-47
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:31:23 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWvJv-0002TN-Pj
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:31:21 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40fd72f721dso9508505e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 01:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707125478; x=1707730278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQyMMTvijXur08UgF+EuEbKAVDtp0h404jaHh4fZ3GY=;
 b=r/bEiQiaaQkOKbmW9pWgBAWHQB4PqS8CYAiqXE45mfiOfpU0/dRxeFdpzwOVNw4I0f
 bm7N6E76VKPtsA6WvAX9vab8hqkL68NofjU7ikPJOXdnJoZr/Es//Rwqtpj3yaNrP5cA
 x8UNj/tZxChd1YchSE76d+aC31/XmVP5JEhhAe61na/qxH7e7Ms5wDrnBgNQG6RdKdDP
 i43tGO2sWjOC9B7xSMoDCJPthb3DyjEcEedudT3TkqZt1PXp8hRMmnYntlxNtDLvkgjn
 3yow213CbxlbvgJOPgwxng/MXKaw73B8XOU3ya5PgK5/q7DncfyjzJ0t+PGdDl4fpnRz
 lrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707125478; x=1707730278;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EQyMMTvijXur08UgF+EuEbKAVDtp0h404jaHh4fZ3GY=;
 b=u3+ercM8k4NKxGC549f35x5q6YmTYqA42MyYtvCoJwYkIWF1kvryzwh7Ci5N3gRl8j
 VMTsWdy4EzhyK61xQesHTyxHQ3RMY7sRjFwzHgDiP+ycSEAqMII3hq91g+VsO8pyhvoD
 qd3IQ9ZmiFMIkB9gJsBCjmTPPpeaANu7HhZgqp5lSFnOl9CrgBnNSRi1dO2+bjkXIvbK
 pyHRAiHygWgnO54gkP0Ibt6OcRbm4wLhOAOLN79D9lkuuKDyQ6nUCtO7SKKpmsfJ9yXY
 FRtQmPyhqEJd1D6+9KHbApb7osLnGU/7QNNw8rbuRLxWQro7AKIjFksR2nJ3u4uRJ3QG
 If6g==
X-Gm-Message-State: AOJu0Yz9mWsPDXNpgXrixIcUbkdNFLWf/l+bujQnWQvHXyShzKLrkAXk
 4RPqZBvwseBn7P8Q7NpdeZGFkhr+ngxXSjFU6VOA9MA9Jwyy5JEjE+gPz/TW/G8=
X-Google-Smtp-Source: AGHT+IFCLrcy7Ax0GvlZzxf1x3664Y7piAHpIRn6aRKmBgXa6IVaqoSK0SNpJ0mAZ4YtrIPWl8Y6fw==
X-Received: by 2002:a05:600c:5795:b0:40e:f693:94dc with SMTP id
 jx21-20020a05600c579500b0040ef69394dcmr4052583wmb.11.1707125477803; 
 Mon, 05 Feb 2024 01:31:17 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWLBdGkPgBu2CAvixv0GSFy5EzDb6MqA2dLh6h3Ra8fwa4kd1GEvpOOvsoBf7NgcmiJ8bhVuTxn7xoTfHeeIbye+rkmGs1N8c8jEuwMaEpmHaLD5F/HKzkivC+i/qHPq38gsUdrlhgpleaCWYASW52u1jTbLVVYagU+opzRCuVI4JrR3pT7v/xsPCU4TlqNJKHY+7lsaqq1PZH+jLPBLjGNNo8Oc66rdxz7qNiL3Db21ldQr7sOPn0T9XsazASh4eD/pM0Yn4UCwAQ/x1Q5H1dMYRJJ/xbbnz7lFD+Y2fx4JxgUAzwbfLCWmgpUvVicGTdVw0zJN0B3NcgzViBvDZDIiM/iWTRuOrLStYIniUBrJBOK14jphZhoQPBtZm6VvP3AUh4z0QDnxdws3KlRBVQhNbZWYGSL/i5BeycZwgOVK5SQuJ/eH+uPa+9tfjRV/tUHG8krklspdWjHqs4ioQo=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c198a00b0040e4733aecbsm7979386wmq.15.2024.02.05.01.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 01:31:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 353965F760;
 Mon,  5 Feb 2024 09:31:15 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,  Alistair Francis
 <alistair.francis@wdc.com>,  Bin Meng <bin.meng@windriver.com>,  Weiwei Li
 <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mikhail Tyutin <m.tyutin@yadro.com>,  Aleksandr Anenkov
 <a.anenkov@yadro.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,  Andrew Jones <ajones@ventanamicro.com>,
 qemu-riscv@nongnu.org,  qemu-devel@nongnu.org, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v11 0/3] gdbstub and TCG plugin improvements
In-Reply-To: <7fae3d1a-5af2-4557-a2b3-13b911e73382@daynix.com> (Akihiko
 Odaki's message of "Sun, 4 Feb 2024 15:54:47 +0900")
References: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
 <87bk8xpzyl.fsf@draig.linaro.org>
 <b34c4013-1aca-466e-b94e-55d9802928b3@daynix.com>
 <87zfwhodit.fsf@draig.linaro.org>
 <7fae3d1a-5af2-4557-a2b3-13b911e73382@daynix.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 05 Feb 2024 09:31:15 +0000
Message-ID: <8734u7gsv0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2024/02/03 22:58, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> On 2024/02/03 20:08, Alex Benn=C3=A9e wrote:
>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>
>>>>> This series extracts fixes and refactorings that can be applied
>>>>> independently from "[PATCH v9 00/23] plugins: Allow to read registers=
".
>>>>>
>>>>> The patch "target/riscv: Move MISA limits to class" was replaced with
>>>>> patch "target/riscv: Move misa_mxl_max to class" since I found instan=
ces
>>>>> may have different misa_ext_mask.
>>>> As this is re-based on Alistair's riscv-to-apply.next tree I'll wait
>>>> for
>>>> this to go through the RiscV trees and then re-base the plugin patches
>>>> and dropping the merged riscv patches from my tree.
>>>> In the meantime feel free to review:
>>>>     Message-Id: <20240122145610.413836-1-alex.bennee@linaro.org>
>>>>     Date: Mon, 22 Jan 2024 14:55:49 +0000
>>>>     Subject: [PATCH v3 00/21] plugin updates (register access) for 9.0=
 (pre-PR?)
>>>>     From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro=
.org>
>>>> For:
>>>>     contrib/plugins: extend execlog to track register changes
>>>>     gdbstub: expose api to find registers
>>>> So I can add this to my maintainer omnibus series for the next PR I
>>>> send.
>>>
>>> I added one trivial comment to: "gdbstub: expose api to find registers"
>>>
>>> "contrib/plugins: extend execlog to track register changes" depends on
>>> "plugins: add an API to read registers". The comments for the patch in
>>> the following email are not addressed yet:
>>> https://lore.kernel.org/all/4b2156ed-688d-4617-b52d-200413f01156@daynix=
.com/
>> I don't think we need to serialise with the BQL as the structures
>> are
>> per-CPU (and created on vCPU creation).
>
> qemu_plugin_get_registers() has vcpu parameter, which can refer to a
> different vcpu the caller is on (or the caller may not be in a vcpu
> context at all).

It should only be called from the current cpu context. We can either
assert that or make it implicit like qemu_plugin_insn_disas does.
However we will need to ensure current_cpu is set before the vcpu_init
callback.

Pierrick has had to move these initialisations around for the scoreboard
work so they are now run with safe work once the thread starts.

>
>> As far as the restructuring we can move it into gdbstub later if
>> there
>> is a need to. At the moment the structure is just housekeeping for
>> plugins.
>
> Certainly we can move it later, but adding the code in the plugin
> infrastructure now won't help in that case.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

