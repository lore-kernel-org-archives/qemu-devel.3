Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D47BC4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 13:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWGXa-0003r1-Nf; Sat, 03 Feb 2024 08:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWGXZ-0003qe-QF
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 08:58:41 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWGXW-0000bX-AK
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 08:58:41 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40fb020de65so26079075e9.2
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 05:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706968715; x=1707573515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9Pxu5n6m30JqSdPRav2U9PpOD+MM44CzvHTi70RuVQ=;
 b=INH724YDdAK7UkMOJsT7lyBtBd1wtyCqlZVVVwQUFUy19IyhLEpwGUzlPtIo966Jt7
 hstzbiSWnsl04kG5EeEg2KWsg5tA6pnciVllwvbMgMyUjLaoyVFhiFEv3C+A1YKBYHhM
 uEFQpPZjYyL/U3u89+0Vu4Hcj9X/3lRIELd84uQf3RfSBijY1i8EJjRzRPTm18RkMpqg
 inZEWEMTFHQ24mEcqKe01xkCzrwmHhfAshJc9xdAeUsVtucb0jWa+wdpl8c1/tETvZSa
 XcohH4dKrhfwtKN1nZf7Vuv/yJx2nd5WPJd/sOk2IPPb9HHS5UBxnfll+k7miq+AOsAI
 vAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706968715; x=1707573515;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U9Pxu5n6m30JqSdPRav2U9PpOD+MM44CzvHTi70RuVQ=;
 b=dkPjGFCumUzE/XWD8d24XiNOwXSs8CB9P75iHIcXOSKLt0O2nSjlo60olIV3Yij7IC
 4OMfaKxnMVrSfQ4kXtpZq0RvNFrQ7p/E9iucZ4k4skKHkH+80I6X8NjQWh7yks5qncMk
 1K/qPv4B1xoldn7KaywBj85xGzfS/Jj/BF7b18wGbOoSutvD02hUUua41KMR8k75bgaz
 u2dZDzFmfRUFmbEn3YEUAUrM0RSdMrhxXlgspPo0RPupQ/Y14B0kl0qBkZzKiCbQLF6v
 NEax6kD1yuoYyP6RwqTQkhHG+f7646haMn3by51F1FyLsOqKBm8CT6nOMVGnk92Saasl
 ozBQ==
X-Gm-Message-State: AOJu0Yzu6V+a4+1kQcfdG/zaqZTz+PbjnSUkOcnIfzwdn1wHgQRzAGZ5
 beAH7bypTe5hUSj4eFbamkMQCGIB6kahPfmggavJKZJvENNEu6ShvXMOD+m6F7c=
X-Google-Smtp-Source: AGHT+IEC6YFzi7UuWTcuM/WW45NVrVE73TPqwFD87P2bF3DWCITmbKbiPyIzNnwxmMseEtHWUZe/rQ==
X-Received: by 2002:adf:fa09:0:b0:33b:2633:b527 with SMTP id
 m9-20020adffa09000000b0033b2633b527mr2710902wrr.20.1706968715111; 
 Sat, 03 Feb 2024 05:58:35 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUQNG403doS+wDD3lMqEimiBuP7SjA9YDq9jhKMLfUa8ntkzfHSne93kQ4M3vSJmnR6z1gWMcCMm+UxNlFC9OWEgUapbpxyPo0YvvcmDcBKpb8RkoqC3Y/p3oF/xWxgcFmK3MqcrHWfVX7Hgq+xErsRfzOSmr01yw6xEyEfM8dQ8UE3IXsp4SuNzn8LfYPyPbUYlQTQeMaTQMePg2bhfPmNPfZbyRDEuJogqVlBtsw4VX8lx/tMFUT3pG3pBWLz0n92SSYtKXbLHmaLmFegQgjrWVXy7/WNVUiq6to8ewQBTawuOTBzdVjoMTXbh519RAQ6bTgTtlWBsFi/WJiXdHV3yLimqM3jd/pZuqGseKOZcOndihUoDEZy1yDfuvjR3w0IrtV6YY6CQPX8u/aNCahU3o2hiTuo23PiUBdltmhK3NVa
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e21-20020adfa455000000b003392b1ebf5csm4159481wra.59.2024.02.03.05.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 05:58:34 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 50CC85F7A9;
 Sat,  3 Feb 2024 13:58:34 +0000 (GMT)
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
 qemu-riscv@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v11 0/3] gdbstub and TCG plugin improvements
In-Reply-To: <b34c4013-1aca-466e-b94e-55d9802928b3@daynix.com> (Akihiko
 Odaki's message of "Sat, 3 Feb 2024 20:26:37 +0900")
References: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
 <87bk8xpzyl.fsf@draig.linaro.org>
 <b34c4013-1aca-466e-b94e-55d9802928b3@daynix.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Sat, 03 Feb 2024 13:58:34 +0000
Message-ID: <87zfwhodit.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> On 2024/02/03 20:08, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> This series extracts fixes and refactorings that can be applied
>>> independently from "[PATCH v9 00/23] plugins: Allow to read registers".
>>>
>>> The patch "target/riscv: Move MISA limits to class" was replaced with
>>> patch "target/riscv: Move misa_mxl_max to class" since I found instances
>>> may have different misa_ext_mask.
>> As this is re-based on Alistair's riscv-to-apply.next tree I'll wait
>> for
>> this to go through the RiscV trees and then re-base the plugin patches
>> and dropping the merged riscv patches from my tree.
>> In the meantime feel free to review:
>>    Message-Id: <20240122145610.413836-1-alex.bennee@linaro.org>
>>    Date: Mon, 22 Jan 2024 14:55:49 +0000
>>    Subject: [PATCH v3 00/21] plugin updates (register access) for 9.0 (p=
re-PR?)
>>    From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.or=
g>
>> For:
>>    contrib/plugins: extend execlog to track register changes
>>    gdbstub: expose api to find registers
>> So I can add this to my maintainer omnibus series for the next PR I
>> send.
>
> I added one trivial comment to: "gdbstub: expose api to find registers"
>
> "contrib/plugins: extend execlog to track register changes" depends on
> "plugins: add an API to read registers". The comments for the patch in
> the following email are not addressed yet:
> https://lore.kernel.org/all/4b2156ed-688d-4617-b52d-200413f01156@daynix.c=
om/

I don't think we need to serialise with the BQL as the structures are
per-CPU (and created on vCPU creation).

As far as the restructuring we can move it into gdbstub later if there
is a need to. At the moment the structure is just housekeeping for
plugins.


>
> Please check them out.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

