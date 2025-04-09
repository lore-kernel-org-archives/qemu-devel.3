Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9658C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 09:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2RmK-00066Z-E0; Wed, 09 Apr 2025 05:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2RmF-00064y-Up
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 05:31:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2RmD-0002fL-Q6
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 05:31:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso69483645e9.3
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 02:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744191079; x=1744795879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIdsqU2+ysC7jA6LMmVzVUv//dkPeh3NGRc9p0W48yw=;
 b=O8cqDqhHBshRZkp50eJfP/jxiYvi2HSFHG59rKq86IlaNfAgUfkBFgLiCIDqWeFiN5
 OsowHSEe6QK3lFcw+5XxPTXJ+xSuE+6rYlSfZhd30q+v/c8rItslFbhW7Gxqn1LOVBtK
 az9+eI5IbWPYLHh3hf8XSSFfx6bjf0Utellb8HZ/gsb07j/489C4y0Ba83MLdfan9l+z
 H/eE1T9HSV6QgwuS9aADT2I/Tv3tDHzFmz213DjsH3atZCWi1K4C9aQ6yp6ibbNv5B/U
 nIy/a7mG0/X1s5P/YkFuUSYrMTSryngVdoaMcDiFUvX4ffOQGpsP1e9Dd0FAKXAVtR9h
 aDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744191079; x=1744795879;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OIdsqU2+ysC7jA6LMmVzVUv//dkPeh3NGRc9p0W48yw=;
 b=bYM8YtCeH2bVcMwp0SmMoSuhSxqJKFMtqZksY8habgxOWKmWA/MAd36J13L6qQ0YBg
 KDiYGTMIy76mg3HplQR7qSDqRGPGXt3PZu15uviAVOzCNXA7NGWS1iIrs/5XmZEiTSH6
 I2o+iObDp33FBASqofHuzhdilcL1yfufxgvfoWqBRWCy6vFNKUkcCnC/2k5fTPtapG3+
 TCik0aNczincRsnBfcGO9/cRumYjLoP1Wyk18VPhnirYnGlgmK/sTdelw+jgsaedPtGO
 l/MoIIl/uqeBvx62HDZxTjKLji/UhFoZ38bpeU3mcTe1pMPwi4PWWngvTSM4DnmzWurf
 1FEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtYm8Mt+wKOTWp8gpLtLVBHaTHCRyvxv//BixcR8DDfDTxDfsbpUy1lYlJImRqGF4Ced8iZeFoomaI@nongnu.org
X-Gm-Message-State: AOJu0Yy4v7NVe5s4BKg19hrcS6nEFH181xmdZgaYBDaorLHlamXioC4p
 C3Yd0q52eH2mG/9NMJ2vVT79PKOb7Lxj2DzG8ECZhlLNjFRmJ/0tpXIQZlh7SXA=
X-Gm-Gg: ASbGncuc/pXSsu846tmdvdpIGHC2HRpM4bcOJf1L4Ra1dybQwk8GNZ+AHA0CMmgXkeQ
 eiH1GUPA6OvAsq2QV+mgKm/n246EUxEhuw1DfB5NUlb4wWAw1GL3HMyPFrfN6E92Lf8Nz3lJlpT
 irAp4FD3hUhfiwnl0Zf33SFehA9cQtSr4GPD32VdsXgVP3lZQqbQroVJBmf4f/e5fs9nzXEKT/4
 fYMPczHEwjHbLqTrk4CvG1ywgfFL1Xk0ADvJ5vR936fa0evKU7bhQEfQqKH8wzJdPJ93KlQAvHY
 QmuLzPQ0Xvagba/hCJ6WHlJmqIbawRgwlyfnZRjJhgU=
X-Google-Smtp-Source: AGHT+IEZ8OhoB9zV1U/jI4/LLoUGGPt3ZUJdtPfZ0eCcE5DGOeyzXF5N2Yw4RBMxkZ7H1KFgQe12Ww==
X-Received: by 2002:a05:600c:3d16:b0:43c:f184:2e16 with SMTP id
 5b1f17b1804b1-43f1ec7cda0mr18556615e9.5.1744191078951; 
 Wed, 09 Apr 2025 02:31:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2066d26bsm14167215e9.22.2025.04.09.02.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 02:31:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9C0155F8B7;
 Wed,  9 Apr 2025 10:31:16 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 philmd@linaro.org,  christian.boenig@lauterbach.com
Subject: Re: [PATCH 00/16] Add Multi-Core Debug (MCD) API support
In-Reply-To: <b610c46f-3137-4fc9-a80a-6855e5884c6c@lauterbach.com> (Mario
 Fleischmann's message of "Wed, 9 Apr 2025 10:46:07 +0200")
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
 <87semkw3qx.fsf@pond.sub.org>
 <ea767dfa-d52b-44fc-baec-deea0223094f@lauterbach.com>
 <87semjp286.fsf@pond.sub.org>
 <0736943f-443b-4bfc-8d69-f30f42029d07@lauterbach.com>
 <87r023m422.fsf@pond.sub.org> <87a58qj3ay.fsf@draig.linaro.org>
 <87ldsakgp9.fsf@pond.sub.org> <87y0wahh65.fsf@draig.linaro.org>
 <87mscqiut6.fsf@pond.sub.org>
 <b610c46f-3137-4fc9-a80a-6855e5884c6c@lauterbach.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 09 Apr 2025 10:31:16 +0100
Message-ID: <875xjdheaj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:

> On 08.04.2025 16:37, Markus Armbruster wrote:
>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>=20
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>
>>>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>>>
>>>>> Markus Armbruster <armbru@redhat.com> writes:
>>>>>
>>>>>> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
>>>>>>
>>>>>>> Apologies for the line wrapping in yesterday's answer. Should be fi=
xed now.
>>>>>>>
>>>>>>> On 08.04.2025 09:00, Markus Armbruster wrote:
<snip>
>>>>
>>>> "Keep them separate" is only a gut feeling, though.  While I pay
>>>> attention to my gut feelings, I know they can be wrong.  I am soliciti=
ng
>>>> opinions.
>>>
>>> I forgot to add isn't the flexibility of the QMP API something we need
>>> to handle for single binary anyway?
>>=20
>> I have no idea :)
>
> Alex, thanks for chiming in! By "single binary", I assume you mean user
> space emulation? In that case, could you elaborate whether and how it's
> a concern related to MCD? Maybe I'm missing something here.

Not directly, it was aimed at Markus. As we work towards a single binary
build we have to consider how the QMP API is going to be presented when
the binary could run a number of different targets. Markus and Philippe
have discussed it before but I forget the details.

> MCD is
> specifically designed for debugging multi-core SoCs and therefore
> currently only supported in system emulation.

Eventually we hope to get to the position QEMU can emulation a
heterogeneous SoC so having multiple architectures under one binary will
present potential issues for debugging.=20

> For user-space debugging,
> I don't see any reason why not to use GDB's remote serial protocol.
>
>> Evolving a target-dependent interface into a target-independent
>> interface without breaking compatibility is always a bother.
>>=20
>> It's likely more of a bother when the interface is binary.  Textual
>> interfaces tend to have less target-dependence.
>>=20
>> Designing a target-independent interface is probably easier than
>> evolving it compatibly from a target-dependent one.
>
> Like the gdbstub, the MCD implementation does not have any
> target-specific dependencies. This is also a change compared to the last
> patch set and something I wanted to point out with
>
>> Architecture-independent MCD implementation
>
> But, again, maybe I'm missing something.
>
>> QMP is textual, and it's designed for certain kinds of compatible
>> evolution.  Using QAPI/QMP for a debugging interface may be a perfectly
>> sensible idea.  I don't know enough about debugging interfaces to judge.
>
> Even though MCD is a very stable API (developed in 2008, functions
> haven't changed since then), as you've already pointed out, it's bold to
> assume that it will never change in the future. For that reason, MCD
> provides the mcd_initialize_f function which can be used to communicate
> the requested and implemented API versions. As long as that function
> stays serializable over the RPC layer, evolution should be possible.
>
>> Use of QAPI/QMP does not imply use of the QMP monitor.  We can keep the
>> monitor and the debugging interface separate even though both are based
>> on QAPI/QMP.
>>=20
>> The monitor code is gnarly, I'm afraid.  It supports multiple monitors,
>> but they are not fully independent for historical reasons, chiefly
>> implied mutual exclusion for commands.  Adding a QAPI/QMP-based
>> debugging interface without undue coupling to monitors may pose a few
>> technical problems.  One way to find out.
>
> If I understand you correctly, when QAPI-MCD runs on a separate socket
> without using a monitor, it's still coupled to the monitor code
> internally? Does this have an influence on the either the usage of a
> monitor or the MCD interface or is it rather an implementation detail?

An implementation detail - we should try and avoid needless coupling if
we can though.

AFAIK not all monitor commands map to QMP equivalents but I'm not sure
if that's true the other way around - can you do everything you can over
QMP under HMP? If you don't have to then that implies we can over a
separate schema on a debug socket that doesn't need monitor bits tied
in.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

