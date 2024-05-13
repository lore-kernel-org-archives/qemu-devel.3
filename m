Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB7DC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 12:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ug9-00016P-3X; Mon, 13 May 2024 08:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6Ug7-00015g-40
 for qemu-devel@nongnu.org; Mon, 13 May 2024 08:21:15 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6Ug4-0002UA-QB
 for qemu-devel@nongnu.org; Mon, 13 May 2024 08:21:14 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a59c448b44aso1111398966b.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 05:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715602870; x=1716207670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0FpwzmDIh/pYzgDKLIzIRbHkD9xfCa5MYy8mX9Qfb8Q=;
 b=SXsQ1QlUDttW5CEfObeFIZODcsLn6iCB86VtfPQ5f+NBviC3L+kzthC+fDWWrS2hFq
 i5gyfSGznab8TaewuPnKI9zueQ6TMraLQtfCky4IEA4is/nM/DrsnPgTRXrVveMt7Qcn
 9IJedXTWsFf2Y5EcNT4o4Ed0YHhtKBpLXzGAzyiL/7AxwdLLMcLk7Lne53lzAFP4SvSq
 jwN5RAyR97a+gfGb+mNj6472otKPUzcbi5uXyeUxkHYIfZpwSP8ETXgM/i6lUD3ypVOi
 Z4FF/a3x73idBy2hueFMsVibTtRE/iPGhx/IQ3hsRPjkNnKj2a+uvG/xS5p2lpS6Asgc
 EUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715602871; x=1716207671;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FpwzmDIh/pYzgDKLIzIRbHkD9xfCa5MYy8mX9Qfb8Q=;
 b=sJ+0+hW92WD3C6LVNxhhaFwXDMePcH749L5GAxklcZU0ybW3vpL2bw+flBEbDEh/FQ
 dMjNoKEdo1ymjIfLMwIYUq7wsgyU9+sFSFj33Ew+yfoLJ1o/MGNbeAph+PW05ZzWYXo5
 WVZ1sQBYpjgs93A7PPdRJiWXT06Xp7ejs27uYPhWvgtDkaTlxQj0iOg7QbVBhzzQLgjb
 0YYwZ0bZtd0OurTTyyQKklHbaw6u9aZ74ZxRXOrk72xPCu4s/1uk0D/rt/ARm+CyatD8
 bnZLXn/eHEkKD6XCmjP1Ofxky5c4Nu23I+rngNqeZMKn+baaZ/3Pl7MfmkfywwnWrmHu
 nf6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXREMyP6XLJsWH8Tx+7QQgA7UWPURz80XufWb5MNv5LG/dYQjdM7zpGku84vQes+g5zFKNVyfR/3dr4f9FKOHVW+qWk2n0=
X-Gm-Message-State: AOJu0Yw5DLN+LvMrFeT/pkb4YAEdESp2visqW5AG0ZzcTyKQ5sS2aJ/4
 FtJaFq+fMqBtaCFuNoRwpWQNbDev2n55e/yvYHoiRPlXVStLV50r86hk5BtLmjE=
X-Google-Smtp-Source: AGHT+IGN0t3NyTgvqxW9Tqx7/71PthTFrXd/J2o9o0q1CCJ1jygJNmy9VJUGBBtr7b+SUhpue/9LPQ==
X-Received: by 2002:a17:906:75a:b0:a5a:15f6:157f with SMTP id
 a640c23a62f3a-a5a2d54c7fdmr608028866b.14.1715602870590; 
 Mon, 13 May 2024 05:21:10 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17894d35sm585179166b.81.2024.05.13.05.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 05:21:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 872BF5F8B5;
 Mon, 13 May 2024 13:21:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathie?=
 =?utf-8?Q?u-Daud=C3=A9?=
 <philmd@linaro.org>,  Thomas Huth <thuth@redhat.com>,
 michael@amarulasolutions.com,  linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 1/1] tests/fp/meson: don't build fp-bench test if fenv.h
 is missing
In-Reply-To: <CABGWkvom8s3KEV=9wKxp1=UK+r1jaOns9MqK9OhuMUyxVskznA@mail.gmail.com>
 (Dario Binacchi's message of "Sat, 11 May 2024 13:09:21 +0200")
References: <20240430164752.645521-1-dario.binacchi@amarulasolutions.com>
 <63094227-235e-4274-b308-2d7c27e50b81@linaro.org>
 <CABGWkvrCNoWDB=V5f_7qwCd97dAfOC3XT2ukXYt-FsxuUKK-KQ@mail.gmail.com>
 <4ad368ae-74d0-4a38-b4d9-d907c1b8dc7c@linaro.org>
 <CABGWkvo_eaDFC15JQF8+Pu14M75CKWvVr8JWQ7XJuHc8fCc7LA@mail.gmail.com>
 <CABGWkvqXdJtiiO2gWC2VTcLvYD33KHe5Rb49Q=VDrtkEiODxOw@mail.gmail.com>
 <8b84b9ae-fda6-49c2-90dd-40d8660561c5@linaro.org>
 <CABGWkvom8s3KEV=9wKxp1=UK+r1jaOns9MqK9OhuMUyxVskznA@mail.gmail.com>
Date: Mon, 13 May 2024 13:21:09 +0100
Message-ID: <87h6f1rjgq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Dario Binacchi <dario.binacchi@amarulasolutions.com> writes:

> On Sat, May 11, 2024 at 12:25=E2=80=AFPM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 5/11/24 12:11, Dario Binacchi wrote:
>> > Gentle ping.
>>
>> Gentle reminder that I strongly suspect that your buildroot is corrupt.
>> There *should* be a <fenv.h> present.
>
> I don't think so. In fact, the patch has already been merged into Buildro=
ot:
> https://patchwork.ozlabs.org/project/buildroot/patch/20240502072327.74146=
3-1-dario.binacchi@amarulasolutions.com/
>
> As mentioned earlier:
> "The fenv support is not enabled in our default uClibc configurations"
> https://lists.buildroot.org/pipermail/buildroot/2013-May/072440.html

Given this is outside of the general QEMU support matrix (we have Musl
but we make no comment about uClibc) and doesn't address the other users
of fenv.h (check-tcg binaries built with host compiler) I think this
patch probably should just live on in the downstream.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

