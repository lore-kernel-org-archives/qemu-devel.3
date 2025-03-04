Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B47DC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 15:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpUfR-0007mj-Ax; Tue, 04 Mar 2025 10:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpUfO-0007mD-QN
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:58:46 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpUfM-00041Q-CC
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:58:45 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-abbd96bef64so912392566b.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 07:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741103922; x=1741708722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPxAnvFWcx7YD+me+vO+xA5sVaTRnES3/AiU1O3qTJ4=;
 b=JeVJgmEemH5StMb/lIPgVouIkdHxSd4790utb5TYg0i0dKjeiGf7/V/WzVVOZtu6Pu
 pz1YuZIFAYC6FabxTIedffDOplEghEH8gImdv7aKY+5XDZPB0eKKsTW3nJnmD4h+CfLf
 Lgvs62zoQtM7KMiXB29QsLAYB0JlQKrNfNIQ0SHpZH4pIV2rXMbv3eJTnPhAwODOipRr
 J62epYmzUAVYEVXNK6yHonNehqakxAO8/0GRSKYb43CA3jnj9iaIdCxL6At4oPjtSeH8
 eA+1GzHBcaEYgjCb5QG3fed3pWjNmBt0E+Un8Y80ftCY3/VE/Raqe3jYilJ8z5ywX27G
 FGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741103922; x=1741708722;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wPxAnvFWcx7YD+me+vO+xA5sVaTRnES3/AiU1O3qTJ4=;
 b=jswILe+zCk+CXCNxLtGgNt3QLYgAPuLz6/oM1QrY1llGIInyM82yQmm/6jda4ox/9j
 l9unh2zNbk+82N0BG+65Mtf+rViLKqXF2B4ZdjpyAc2AzgkC6WxhpZ4wCme8i9p+OtwR
 4BWu8IY7rsODkB1RMhkb+3NNV7SIOfvq91QMQTN9t2WMftSP4VzClUVwmgQ9pq8By45W
 /K5UeR3WnysuddAZ1SivqJ0liPcefA+eIE73gYo1ssgPPYhxLunZCIFWCm2So9n97Uz9
 bJJrGiXvsJe8yVaHqL3hSktTTnNHyEvC9Uf7kNgK2Uw2jZ64oWAxijXhfGwaFDxMeB5T
 A+fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxHtdpL78w9ge8e4A1tx1AQ6A6YDqf1IsYFUPhjQB4CtUtUBN9Gm+rC9rgHVTh5VB/nsEv/f8lAk9V@nongnu.org
X-Gm-Message-State: AOJu0YySt7ovaqf5sCAQq10xVfwc2XQ/g9ed0Yd4Lvbl1viWb9mf+8H5
 f8JOx2oGvRGvrDWIq0+4tx5weIen6fA9n2j6pO4HmBt7QcKs8D8WhPJg/3by4BY=
X-Gm-Gg: ASbGncuiGVvgMnfTptGgzhaub9liXos/UKlVTtjBK26eq/iuf9V8pAWzuvyVu57OmWA
 xWd1tULKG4GTyQ22/XKL8OoFUXsK5/82V55CpFQhvSniviCItHKmkJKtiWcQUU1BQD7G8nVgyb+
 C5Ef2PWBnnJHEXCExOSFQW5Z1Y0xaCuIgz1CohGCEkGmR7hNEzE3GGIFDIEGP1PbN4Ti/qH1MOI
 /RDMHfqvxGXc+U4BNdYJaX7SSsuSmfUFfNKQ+n+bxZh6pWt7I8TDmxL4XIovk9ov9dkQDJamwqD
 Lx2965QsKk2fDPHTskb8qvTNZa4Oow7dAF3uynWbTaCEkeY=
X-Google-Smtp-Source: AGHT+IFghzikPg3jPRp6H+GwPT5DvRM+N5zB7noQNWeuUsLiG0t+BpuqjHLBiAyjIgMpQDM3QqlpIg==
X-Received: by 2002:a17:907:2d2b:b0:ac1:cceb:d9b0 with SMTP id
 a640c23a62f3a-ac1ccebdc9bmr717782966b.16.1741103922179; 
 Tue, 04 Mar 2025 07:58:42 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf74e85fbfsm407913366b.15.2025.03.04.07.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:58:41 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ADBC15F93C;
 Tue,  4 Mar 2025 15:58:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Brian Cain
 <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH] tests/tcg: Suppress compiler false-positive warning on
 sha1.c
In-Reply-To: <CAFEAcA_nbax7qq7Lxc-Qo8xTaxxTn9dJ5VQYuQTy+Qp1_2mNXg@mail.gmail.com>
 (Peter Maydell's message of "Tue, 4 Mar 2025 14:36:42 +0000")
References: <20250227141343.1675415-1-peter.maydell@linaro.org>
 <87o6yh57r2.fsf@draig.linaro.org>
 <CAFEAcA9VDtWKoQ09dOt+ZxJ2MhdRTFY_X1ON58pEjYTM_NtZ-A@mail.gmail.com>
 <87ikoo6hbm.fsf@draig.linaro.org>
 <CAFEAcA9mFHo=U=F+7on-9m+VWh_b2rQXtEJovU3fuj3MZxHTyw@mail.gmail.com>
 <877c546f9r.fsf@draig.linaro.org>
 <CAFEAcA_nbax7qq7Lxc-Qo8xTaxxTn9dJ5VQYuQTy+Qp1_2mNXg@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 04 Mar 2025 15:58:40 +0000
Message-ID: <87v7so4wjz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 4 Mar 2025 at 14:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Tue, 4 Mar 2025 at 13:44, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>> >>
>> >> Peter Maydell <peter.maydell@linaro.org> writes:
>> >> > I think it's new-ish (gcc 11?). On the other hand
>> >> > -Wno-unknown-warning-option is quite old, and would suppress
>> >> > this error. If we do
>> >> >  CFLAGS+=3D-Wno-unknown-warning-option -Wno-stringop-overread
>> >> >
>> >> > does that work?
>> >>
>> >> Yes, I did:
>> >>
>> >> modified   tests/tcg/hexagon/Makefile.target
>> >> @@ -18,7 +18,7 @@
>> >>  # Hexagon doesn't support gdb, so skip the EXTRA_RUNS
>> >>  EXTRA_RUNS =3D
>> >>
>> >> -CFLAGS +=3D -Wno-incompatible-pointer-types -Wno-undefined-internal
>> >> +CFLAGS +=3D -Wno-incompatible-pointer-types -Wno-undefined-internal =
-Wno-unknown-warning-option
>> >>  CFLAGS +=3D -fno-unroll-loops -fno-stack-protector
>> >
>> > I think we should do this where we add -Wno-stringop-overread,
>> > not just for the hexagon tests -- or are the tcg tests
>> > guaranteed to be run with a fixed compiler from a container
>> > regardless of the local dev environment?
>>
>> I can move it, but hexagon is unusual in being clang based. However the
>> oldest compilers we use are 10.2 in the qemu/debian-legacy-test-cross
>> container.
>
> My question was more "do we only ever build this test with
> a fixed set of compilers that we control, or are we instead
> maybe sometimes using the user's clang/cc/gcc" ?

Its certainly possible - at least on a Debian system or with the
appropriate --cross-cc-$ARCH flags. I expect 99% of devs either have
Debian or Docker/Podman to fall back on.

> If the latter, we definitely need to associate the
> "don't warn about unknown warnings" with the place we are
> adding the option that's not known across all our supported
> compilers. If the former, then putting it in the hexagon
> specific file seems OK I guess.
>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

