Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEBFC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 19:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rifqi-0000K5-Dr; Fri, 08 Mar 2024 14:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rifqc-0000Fa-RB
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 14:25:39 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rifqX-00016o-9g
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 14:25:38 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e6aca1ca9so1668585f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 11:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709925931; x=1710530731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kBN2KBXo6ZUfERB2NM20zRe30X6+WFQXBRBHAO4PAI=;
 b=TJk7NM6lSSKFeV8VkSorBGozXG3Bx81vasWxrFVSk/Wylm3O/W3X97kSNlEOHsTXzb
 Ti82tA+BMGWkhLLoh3cxNRQvf5WGnbGMhfco7TvXWe+9hrlccEKlJ4NQeOWCLTfRpqcB
 EqidApsPlw/itFYSEg92x7nPkw50FWeaAiAXzYaKl9iQss1muIHJjIQuNAXlh0ABgf4n
 SXG1mdgBwjb2U5LDmG06PoMMQ/pPkHXyLB+UeVNIGLMaF5lLt915OH36ZKQWyEbHmW/T
 1FcCL8f4TobjT2bG3lQNb6wr8mdlVdWIITR5474qwBfVj17ZoYrnx1HAyR+vfHi7aG99
 PErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709925931; x=1710530731;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kBN2KBXo6ZUfERB2NM20zRe30X6+WFQXBRBHAO4PAI=;
 b=Ln4AFaMuz+njO5TiXAtTK+5EeVK2YVXpw/hHSOJtm68EOJkLdtTi3FfI4fsfM6QxUK
 c6k5CDhMDQSb794IqOh3z9PNWNwowqLPgYYsHn9OWJsaIxqyOzihqvLcKlHE7moUcCj4
 yRK/3DO41RfCPj3myAKo/elGm75Kb3RuojWKyjO6sFxNWApOcznC0L9NieIeIZ5Ygjc1
 OLWj9fI94YaI9N3CexM8rTg/vkCgu5GVFhMMdT5M68m7yzHp9Xn3Qzv4+yj/zkrEA80X
 3DJ0Wxn1Eh8rgP/EwQm2CDp41cr/Im8ZGUlVfaEZ1HE4LNrBm79HifLsPC5qXeyn0gPC
 v1xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCjRLlbjk8YOA25PxH5GR3WvOgX+GCR/fl6dcU3HO7W5xev5NyoKCBNEEcdi334axA88S+saJRjQ9/zdmcLkBDnIzDNDo=
X-Gm-Message-State: AOJu0YyPJie4Uy28L8+aFu96UPYLwj1LHjjSfKpNgnNwVjrz0+yzktkF
 uIVxX0UBbSbO7pPZDsHwUMSDePAKIVNgmOj9wDyN7Az5fxcBxqoJ8/SxBK3eZBE=
X-Google-Smtp-Source: AGHT+IHBqpxIXhUj11uCOZc1XlWZXoEKjyCbq6I+jSEspqZEJLtnh6270ufqwmrFZdfZz216jU2yFA==
X-Received: by 2002:adf:ce08:0:b0:33d:746b:f360 with SMTP id
 p8-20020adfce08000000b0033d746bf360mr67233wrn.51.1709925930642; 
 Fri, 08 Mar 2024 11:25:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s9-20020a5d4ec9000000b0033d56aa4f45sm145056wrv.112.2024.03.08.11.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 11:25:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 452905F7A4;
 Fri,  8 Mar 2024 19:25:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  peter.maydell@linaro.org,  laurent@vivier.eu,
 philmd@linaro.org
Subject: Re: [PATCH v2 3/5] gdbstub: Save target's siginfo
In-Reply-To: <9fea440d-f0c5-0a7c-a60e-b75e4dcf73c3@linaro.org> (Gustavo
 Romero's message of "Fri, 8 Mar 2024 14:01:21 -0300")
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-3-gustavo.romero@linaro.org>
 <637e4407-4519-4d87-981a-acd9b5124970@linaro.org>
 <87y1atu0y8.fsf@draig.linaro.org>
 <9fea440d-f0c5-0a7c-a60e-b75e4dcf73c3@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Fri, 08 Mar 2024 19:25:29 +0000
Message-ID: <87h6hgttjq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Hi Alex,
>
> On 3/7/24 7:33 PM, Alex Benn=C3=A9e wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> On 3/7/24 08:26, Gustavo Romero wrote:
>>>> Save target's siginfo into gdbserver_state so it can be used later, for
>>>> example, in any stub that requires the target's si_signo and si_code.
>>>> This change affects only linux-user mode.
>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>    gdbstub/internals.h    |  3 +++
>>>>    gdbstub/user-target.c  |  3 ++-
>>>>    gdbstub/user.c         | 14 ++++++++++----
>>>>    include/gdbstub/user.h |  6 +++++-
>>>>    linux-user/main.c      |  2 +-
>>>>    linux-user/signal.c    |  5 ++++-
>>>>    6 files changed, 25 insertions(+), 8 deletions(-)
>>>> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
>>>> index 56b7c13b75..a7cc69dab3 100644
>>>> --- a/gdbstub/internals.h
>>>> +++ b/gdbstub/internals.h
>>>> @@ -58,6 +58,9 @@ typedef struct GDBState {
>>>>        int line_csum; /* checksum at the end of the packet */
>>>>        GByteArray *last_packet;
>>>>        int signal;
>>>> +#ifdef CONFIG_USER_ONLY
>>>> +    uint8_t siginfo[MAX_SIGINFO_LENGTH];
>>>> +#endif
>>>
>>> If we this in GDBUserState in user.c -- no need for ifdefs then.
>> Although it does break on FreeBSD's user target:
>>    FAILED: libqemu-arm-bsd-user.fa.p/gdbstub_user-target.c.o
>>    cc -m64 -mcx16 -Ilibqemu-arm-bsd-user.fa.p -I. -I.. -Itarget/arm -I..=
/target/arm -I../common-user/host/x86_64 -I../bsd-user/include -Ibsd-user/f=
reebsd -I../bsd-user/freebsd -I../bsd-user/host/x86_64 -Ibsd-user -I../bsd-=
user -I../bsd-user/arm -Iqapi -Itrace -Iui -Iui/shader -I/usr/local/include=
/capstone -I/usr/local/include/glib-2.0 -I/usr/local/lib/glib-2.0/include -=
I/usr/local/include -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror =
-std=3Dgnu11 -O2 -g -fstack-protector-strong -Wempty-body -Wendif-labels -W=
expansion-to-defined -Wformat-security -Wformat-y2k -Wignored-qualifiers -W=
init-self -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs =
-Wold-style-definition -Wredundant-decls -Wstrict-prototypes -Wtype-limits =
-Wundef -Wvla -Wwrite-strings -Wno-gnu-variable-sized-type-not-at-end -Wno-=
initializer-overrides -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negat=
ive-value -Wno-string-plus-int -Wno-tautological-type-limit-compare -Wno-ty=
pedef-redefinition -Wthread-safety -iquote . -iquote /tmp/cirrus-ci-build -=
iquote /tmp/cirrus-ci-build/include -iquote /tmp/cirrus-ci-build/host/inclu=
de/x86_64 -iquote /tmp/cirrus-ci-build/host/include/generic -iquote /tmp/ci=
rrus-ci-build/tcg/i386 -pthread -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_L=
ARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var=
-init=3Dzero -fPIE -DNEED_CPU_H '-DCONFIG_TARGET=3D"arm-bsd-user-config-tar=
get.h"' '-DCONFIG_DEVICES=3D"arm-bsd-user-config-devices.h"' -MD -MQ libqem=
u-arm-bsd-user.fa.p/gdbstub_user-target.c.o -MF libqemu-arm-bsd-user.fa.p/g=
dbstub_user-target.c.o.d -o libqemu-arm-bsd-user.fa.p/gdbstub_user-target.c=
.o -c ../gdbstub/user-target.c
>>    In file included from ../gdbstub/user-target.c:18:
>>    ../gdbstub/internals.h:62:21: error: use of undeclared identifier 'MA=
X_SIGINFO_LENGTH'
>>       62 |     uint8_t siginfo[MAX_SIGINFO_LENGTH];
>>          |                     ^
>>    1 error generated.
>>    [2084/6731] Compiling C object libqemu-arm
>> See: https://gitlab.com/stsquad/qemu/-/jobs/6345829419
>
> argh, I've tested all targets for linux-user, but missed bsd-user. I've t=
ried
> once to build it but that requires a BSD-like host, which I don't have at=
 the
> moment, then I forgot about it... Let me setup one and review the change =
in
> the light of the comments from you and Richard.

  make vm-build-[open|net|free]bsd

see make vm-help for details.

>
> Thanks!
>
>
> Cheers,
> Gustavo

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

