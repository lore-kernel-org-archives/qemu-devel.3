Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D60D3F083
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 17:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl9IS-0004ep-UA; Wed, 28 Jan 2026 12:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl9IB-0004Wy-Tx
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:25:25 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl9IA-0003XU-B5
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:25:23 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso630235e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 09:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769621121; x=1770225921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8QqYCnKrjiz9+NWGKAi55+g6r0mx85LrFTQmqhVnAA=;
 b=uqrNb+d0KHrl9kvp4gbzWbaL2fQFCs0LpX9WZNhX6iW/XXtT8khFaQAWJsUDGXkeCz
 +FKzlnAXObtlgRcsbMjbFmlTsLSB4u5/LMhyqUSyyE8+IzqSiPm0hA987jwheQjG0UbB
 kNfcelijRdGgJfRdRtUKStmbCDblxLtfOhHN3G9xk/nmKO5S33FQUE9mdDVcX9bjOu/0
 WEJOeydHk3Cgkur6tJtG56jO1PWRylS4rXeAkq2oACVj4ziZlRzTOSWRa90QbqZMpZ/X
 QIbqY+xIJPyDiawjKd/tO3gRiU8ezzWAUyJOw2LHsDDPhIgc1OuAuQV94TmpFV+W/2w1
 WUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769621121; x=1770225921;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F8QqYCnKrjiz9+NWGKAi55+g6r0mx85LrFTQmqhVnAA=;
 b=C4tb2K2m7/DLCQCIOx78M945g4hiK1jZeqmxCWIzoi6nFnOw8k5AgO+LwZNp7l9HXo
 iMbKchpB7WI/jDs6ksobo5eUUmqJYOdvctIzMYJrgjkI6poahZjeEHkHyq9oUWgBMECJ
 ajuEG1aV+5xIj/h9i9g76VzYst+KFcAwvVq+Fkma0TH4huYI10xwsx9gcXRY0MQI8rBs
 nBHFH+HDjoEt2glHy2mm79nzVqBZm6hcAhTzmBbTfyQdD/uJFg8ecB4iWJOvsG4dwCbu
 Vx7yU2+la9qCSXuEEAHbE0dUDWp3s0KyY7AKhBWDljuBAD3Z4lWYN/4XRf/E6D4+lEuO
 jgCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXArrUx9r7Xp8vXlU4RrFMAygZWLdzDGDv3DkwYwdbkkV3zPehwAwSsWjSUwU+4ER8GMIASY3AKAx3b@nongnu.org
X-Gm-Message-State: AOJu0YwyR/xuEDYS4/9jM5hU32gKbSVvp0MZjxN3N0jF5ZN+TNrAFM9g
 FCbw22+LV7DOi5rlK7oT8Ob/MwBQJxN2M8oHbMaPF64/bz2DZ7C3zK2uX5Bcf4m6zAI=
X-Gm-Gg: AZuq6aJDaCFE7ocwcJoLYukK6k4JHPHnq0Ax8gmD1c49mWx35cswZ/4DgQfPhPI6O4R
 504Uwr/MKRslajol1wqaeGpBbdJQ8GPxMNv3a2o4P3Xeg88u2TlpIcn7UoD4yjINqoMG7J7T/p+
 JXcQLffiTuX2G4uH02TgBdrPef3JdI0E7cuVULC2R3m067XXj0c4CBno5MpKdNWEwrz1Ji1k2/H
 n7fEmpaNbxoNuE5Yb/vFWUDtQbDFxSuq4ZgZ/vT9r/qKIpUumFTFtC15EoM/jet80Uiuhf97vlt
 4tP1xm3e2vnS9lQRTRzkWqC3vmylhmL0q14Uo3H6G2JAjorqEtbsbcOR1Av3jgI5bTXAQctmUbW
 bAGd/njVPTYUZBg5fCxBY9aKZNuBb2ez+Vv4hddu9uV39CPGbT4r0zFOH/f+GWtqlmypo5hBbOi
 alrL5Niyb3ZZQ=
X-Received: by 2002:a05:600c:1990:b0:47b:deb9:15fb with SMTP id
 5b1f17b1804b1-48069c8a660mr81670055e9.33.1769621120821; 
 Wed, 28 Jan 2026 09:25:20 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bfb59asm133458855e9.7.2026.01.28.09.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:25:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7205A5F895;
 Wed, 28 Jan 2026 17:25:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Kostiantyn Kostiuk
 <kkostiuk@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Gustavo Bueno Romero
 <gustavo.romero@linaro.org>,  Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v4 03/11] plugins: use complete filename for defining
 plugins sources
In-Reply-To: <1daa47ef-c2b5-4fae-aec7-744c5411a7e0@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 28 Jan 2026 18:05:26
 +0100")
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
 <20260124182921.531562-4-pierrick.bouvier@linaro.org>
 <87cy2uat5e.fsf@draig.linaro.org>
 <1daa47ef-c2b5-4fae-aec7-744c5411a7e0@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Wed, 28 Jan 2026 17:25:19 +0000
Message-ID: <87pl6tabuo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 28/1/26 12:11, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   contrib/plugins/meson.build   | 10 +++++-----
>>>   tests/tcg/plugins/meson.build |  7 +++++--
>>>   2 files changed, 10 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>>> index 6915ffa5fbc..3d2d7862e0c 100644
>>> --- a/contrib/plugins/meson.build
>>> +++ b/contrib/plugins/meson.build
>>> @@ -1,15 +1,15 @@
>>> -contrib_plugins =3D ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hot=
blocks',
>>> -                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrig=
ger',
>>> -                   'traps', 'uftrace']
>>> +contrib_plugins =3D ['bbv.c', 'cache.c', 'cflow.c', 'drcov.c', 'execlo=
g.c',
>>> +                   'hotblocks.c', 'hotpages.c', 'howvec.c', 'hwprofile=
.c',
>>> +                   'ips.c', 'stoptrigger.c', 'traps.c', 'uftrace.c']
>> Argh this keeps conflicting with other changes. Maybe we should make
>> this a dumb list:
>>    contrib_plugins =3D [ ]
>>    contrib_plugins +=3D 'bbv.c'
>>    contrib_plugins +=3D 'cache.c'
>> etc?
>
> This applies fine as of commit 9ad7f544c69, on what are you based?

plugins/next ;-)

Pierrick is going to deal with the pain now in his first PR!

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

