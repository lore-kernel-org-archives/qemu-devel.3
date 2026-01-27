Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34DAD2FECD
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknbT-0005xv-0l; Tue, 27 Jan 2026 13:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vknbQ-0005xD-Hb
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:15:49 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vknbO-0000U4-8n
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:15:48 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso61452105e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769537743; x=1770142543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUqZ/DspZmmcEA3lwG/AtmN9Ylol1i8j/acLwdsXAj4=;
 b=gNs+ax0BXOIruVDmQ78Z5hEbvpuA7fZy32/t57p9BfkkfA6bbUUbBm8us/TRgVKyFy
 nUwIjY4oPeNKm9o18BIXL178AtplWb25rKCNyOHGmNUrVCM64K24v/uBa7PPemiftS4D
 QkGzfOyapDiC3+mUbLEeKaKEASf1HCfm/uBMhW08yM3/yckcfW35IFBco9+K5npSAHww
 SsAf/JWi9N6kgHbaGcdX60AteNJqPeQrou9hAYl3FResrXCn34LRWLIfOvh8poC28q8F
 Ro47GDqZIBwAP6QbENKekiyUhn663mRQ5DpY29PauWiWJ6Jnqp/96w2sv5dB3dexb8Wz
 4uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769537743; x=1770142543;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PUqZ/DspZmmcEA3lwG/AtmN9Ylol1i8j/acLwdsXAj4=;
 b=gcBsgiwLHd0TUg2nuqcfpqqPbte9e+nAkRaw0K7O79AAustQzN2AZwHZHiQeNd2wKv
 yXwZNQp7T4f3i9sWPTOaBgSRGyiXV1daqCu6xY9COmE6erkiAsg6KX2lZpTyd+8k4erG
 LrvJtIl44azyB7emtQ/YDIrp8rWMWAEpWbokpLZgIAeHaM5jU36DNNtlb7YGbOiRCAE0
 9T6am46UkYgB/XMaJKawMWD1FzepXLgCWALsZzgYfCgbtGCTHJSIxdJ1pa3eGHq1dBJm
 ZxcBGNsoE/xd0hmwqcQzb8/nL5kM3yvkSKl/6ccAf3N92Ps1zRtnUY01+VJaXtoGVJS2
 /jzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE5eZNpFe1tcA9tQWgB8hMcmXAs8aEqzhpRBuBqQVfnAuBjt+NCrX3NJp2hCbCVF8LAd7uKb/JyYlU@nongnu.org
X-Gm-Message-State: AOJu0Ywj0qb1Kquujfesy6PSIxWFP0S9WGWeIi54i+/3wdliMBDzhaFE
 rfS7f7RMsgSfyYRvpGME52lIyPGvhfy6Dwldv/Bq9I5MjTQFpLcxBbXwYC4PjyNuvsc=
X-Gm-Gg: AZuq6aKqs7zeTfSy5CEsU9enesRwPWaHW49K1A45zLHNj4yZctyOgqdqDEyAiLCKBh+
 HdsVCN29TqOTsJQTpsRl54FXl8BZfLJiZQN9cBgmT3C1iHL8gthAltuI7fU1guh/FTYXvnXcsqS
 cuIkzFuTldFHbLPfF85Xo3J5DaUxMxgi9bvN5ofFepQUzY1sNER7nDuHXGD7uH805gktTmma4Am
 JP0IWeH+ovK2tdY2vy8/BUwVmFMpNFgZm85kJC9GKt2ayLPPApZGzFBPkxH/RPQne5awaE2BtUO
 /xi8+pB9I03Swf7ZTxc7LKzExskchn3zsj365tmOA7OzrNtWyl5K1aATRYX7dCYczy4uRMCJ30K
 aMEXnRicUM+HieJNV2rfgEMfWFkxfeFAauvvmLZFTJiEVrQFE79HN33oMIl1n84R3bfXPgVRQOE
 JbhYXXfCmlDmo=
X-Received: by 2002:a05:600c:154e:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-48069b8dfe3mr33856665e9.0.1769537743542; 
 Tue, 27 Jan 2026 10:15:43 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm7248155e9.12.2026.01.27.10.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:15:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1706B5F7DC;
 Tue, 27 Jan 2026 18:15:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Stefan Hajnoczi
 <stefanha@gmail.com>,  qemu-devel <qemu-devel@nongnu.org>
Subject: Re: gitlab docker registries
In-Reply-To: <7574812c-c200-49bf-8367-927c3cc7295b@linaro.org> (Pierrick
 Bouvier's message of "Tue, 27 Jan 2026 09:10:29 -0800")
References: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
 <CAJSP0QWQEr8+dEGD7jkUQ--Oq+D2PKv_ArRB_ApiZM++xN9TCQ@mail.gmail.com>
 <c12f3294-1ef1-41fe-a453-1422063b991d@linaro.org>
 <87ecncc4sg.fsf@draig.linaro.org>
 <90520ad2-8256-4bc7-94e3-010455659394@linaro.org>
 <878qdjcslb.fsf@draig.linaro.org>
 <7574812c-c200-49bf-8367-927c3cc7295b@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Tue, 27 Jan 2026 18:15:42 +0000
Message-ID: <87qzrac46p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 1/27/26 1:28 AM, Alex Benn=C3=A9e wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> On 1/27/26 10:50, Alex Benn=C3=A9e wrote:
>>>> I think it was broken by 4203ea0247f (gitlab-ci: Add build tests for
>>>> wasm64) because we base the tests of the existence of dockerfiles and =
it
>>>> now generates multiple targets.
>>>> Do we actually use the wasm32 stuff anymore? Maybe we can just
>>>> rename it?
>>>
>>> All of the wasm32 stuff is supposed to be gone.
>> I think 20260127092745.2978371-1-alex.bennee@linaro.org should fix
>> it,
>> but I need to re-read how to trigger the weekly build on my test branch
>> to test it.
>>=20
>>>
>>> r~
>>=20
>
> What if docker-verify was depending on building the container locally
> instead? It would allow to have a self-contained command, that works
> the same in local, or in CI, without any yaml dependencies.
>
> With current approach, it's tricky to reproduce locally as it depends
> on global gitlab registry, while we are just trying to see if images
> is buildable from scratch or not.

No - the point of verify was to check we where building in the
registry.

A lot of the Makefile.include stuff is legacy now (although its a useful
wrapper for building tests locally) because gitlab invokes the
containers directly. We used to do all sorts of dependency handling as
well but the lcitool approach is a lot cleaner even if we don't get
layered containers.

>
> The fact it's hard to guess how to test such a change exposes that
> there is a problem to reproduce this, even for the original author.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

