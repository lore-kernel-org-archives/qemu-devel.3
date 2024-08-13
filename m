Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C74C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 13:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdrIj-00080K-Sh; Tue, 13 Aug 2024 09:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdrIg-0007zg-W5
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:10:59 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdrIf-00016T-3R
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:10:58 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7ad02501c3so657227266b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723554655; x=1724159455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Du+q+VgFapTsA6jU4HynJ1A8RRGo5uoaTSShJmb/uaY=;
 b=xZnv5JrZ4GvT46aunSyJMSReH+ekSy6mtSn05q/IeO4YkzEK5gJnigYhZ5kw7nh2Bu
 FGCL6YDmyWe7lX9U05Lq1Dh9XmvtOesLxWl1at3Kpt5Pjp3MeHdHbKgdgqTDbESEJzGh
 Z4AwWmqT/PhBZ7M8l4xRDam+OGrceDKC4Bm04NcjCqBCCqTFvMu68S4Vv8xIhX7qlygg
 HaAeoudSuhWDrgigrXgRcsyl0DgMoFm7ftUDa00kRs2Cyt+HJVxfUzLSe/s6jzWFBpH2
 hjqxlkWax9v/lIFNqvRPJX7rkxMcX8qNrN0P3vKkV026iVnvNtVgUmi3Zjm1eN3zuHHj
 C/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723554655; x=1724159455;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Du+q+VgFapTsA6jU4HynJ1A8RRGo5uoaTSShJmb/uaY=;
 b=ct+8uClgLHORqTg6fWdVd4inCWDcnuyhG+RttNVjffj/iZZeU3oofTA07r/ZiBMZhD
 ikWN92VeOud1gM1oPzyYT88Wj8aflrfVtEW4b4noYadStJj0Yyglzmei4WHFpTHDnmd9
 1gsiMAvU9wDbWwjDgBc79yTT9V33nwLiUhU/ld58Eik6DefEcwC5AZ4KdY931H39I4lU
 5rizXMnOPm/gxdMj+0H305EkmJ+CDhh6tEQ2ZHHoMa1X9izqMjZtEWa6nmNfKDHZYyve
 vt7RSbzpQwM0gz8Qr7p9INYsMrJ0U0Bx5k4k2B7h6LWmOZDmW+XPPYXM8ARPr6lwPjvG
 UTFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw71tYwBW6dgtq6AjVqbNMhO4Xwh7qc1lAcVrVV21/2hV7usrypXZR7jVhypel3LWzeda4suXLvKOZBmt4G5h23rUrGc4=
X-Gm-Message-State: AOJu0YzYbwq3d2bPPgvmIWxLjOcRIuvhP+lgMmETxgWBWo2wZnrK8rNI
 bn+2DdYFUYspYCFuM++GfnCvBa4hyXYbNXouhqMb/EkvUeNbyrdzV74csZw7bO0=
X-Google-Smtp-Source: AGHT+IGy1vglVVhsSAoaaJhuw9l6nNgJlpr8nILstLqsiuqTZjG0Rav14IfowCAVoMzGbRCRcNOLiQ==
X-Received: by 2002:a17:906:f59c:b0:a7d:9f92:9107 with SMTP id
 a640c23a62f3a-a80ed2dad5bmr201589666b.58.1723554654569; 
 Tue, 13 Aug 2024 06:10:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f411aecesm67807266b.124.2024.08.13.06.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 06:10:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 238745F792;
 Tue, 13 Aug 2024 14:10:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PULL 09/11] target/arm: add support for PMUv3 64-bit PMCCNTR
 in AArch32 mode
In-Reply-To: <CAFEAcA_-aBuXDK9e4X0ULXWZtXOnxjRuowc67hDBKOZC6+Bu=w@mail.gmail.com>
 (Peter Maydell's message of "Mon, 12 Aug 2024 12:40:45 +0100")
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
 <20240809180835.1243269-10-peter.maydell@linaro.org>
 <945e5e14-9a15-4dfc-856f-f3a7d401a5bc@linaro.org>
 <CAFEAcA9nnzwm-OSpiAWTOtf2On27B1Hi2Fr3h=5jSKRPdnnQDQ@mail.gmail.com>
 <875xs6atfb.fsf@draig.linaro.org>
 <CAFEAcA_-aBuXDK9e4X0ULXWZtXOnxjRuowc67hDBKOZC6+Bu=w@mail.gmail.com>
Date: Tue, 13 Aug 2024 14:10:53 +0100
Message-ID: <87wmkka7qa.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 12 Aug 2024 at 12:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
<snip>
>> >>
>> >> This fails testing:
>> >>
>> >> https://gitlab.com/qemu-project/qemu/-/jobs/7551982466
>> >>
>> >> FAIL: duplicate register {'name': 'PMCCNTR', 'regnum': 96} vs {'name'=
: 'PMCCNTR',
>> >> 'regnum': 79}
>> >> FAIL: counted all 219 registers in XML
>> >> FAIL: PMCCNTR 96 =3D=3D 79 (xml)
>> >
>> > Hmm, not sure why that didn't get caught by my local testing
>> > or by my gitlab run -- does it only get run on an aarch64 host?
>>
>> It will depend what your local GDB is like - a modern gdb-multiarch
>> should be fine but we do test for a minimum version to be able to probe
>> the supported architectures.
>
> Mmm, I found that a local "make check-tcg" does catch this for me,
> so I guess the answer is "the gdb on the non aarch64 host CI jobs
> is too old and/or we missed the coverage, and I forgot to run
> this in my local checkout".
>
> Why doesn't "make check" run "check-tcg" as a sub-test ?
> Having it be separate is asking for people to forget to
> run it, I think.

I think historically because not everyone cared about TCG testing and
you need to either setup docker or have cross compilers on your system.
Obviously we know this is the case when we run check-tcg in the CI.

We could certainly include it in the main "check" set if you want.

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

