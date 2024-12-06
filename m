Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A25E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZXn-0004kk-1o; Fri, 06 Dec 2024 09:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZXk-0004k6-Uz
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:42:56 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZXj-0005r6-GD
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:42:56 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cecbddb574so2471788a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 06:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733496174; x=1734100974; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zNNjniwqUhMlBfoCOuzJRb4aiH2/raOgGs4PxJ7xGnY=;
 b=xz0KwP4cluQ4FTeOZ+WteCM+/AAfwFJpncCbubqYgBOqZRsedGhvuh7av1wLmy4PYH
 x930P8bfGzuar9RPLagsoaLk+A2Wqu9ryNCj3be490CyvD1xCOTV9GF3Ub55SMU6caGx
 XLlZPr1X7XKmgm3I5/VdebFh1JGuTqthaZiBI1NOs/ll7w6STdW7rR+8nNtAQltXtUB0
 bANaFmCEyW28CbItue1jLb3l/aV+bvOLaxascVwdAJ94HMKmKpv5dnw7q1wLbsuHauen
 igXySKxrOBk4vI8ecrJZMNU7rCHVcTbNA3vEup5erScz8o//cEGPjolRvLHhfWinsC1I
 UkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733496174; x=1734100974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zNNjniwqUhMlBfoCOuzJRb4aiH2/raOgGs4PxJ7xGnY=;
 b=bHWzoOe/FwuYxUeDG/8QKNs9dvFofG7xYU4LfRee4R/oc0zCBSyuGATupif6p5tYZg
 tjvqZ8+hOmisVIp5gl1GuymyrTkKIe0okb6Ks3DGKCPyd+xod1hkABXo8WT18VT70nNW
 TSBGxNWA7gxxtghk00J9GqX+XyvfT80ga1Sz/WYyvz2zxZ6mqEvwme7C5mFGsB/N2nGl
 K9hQfMPYihzZjBOVmc5CkDk105Gj7RxZX0D//NPGx8vVP6uIlQV4B9j0j+mL+JMTIMIf
 QFB+5b1xBQ879hPBxhFqXPc7MH0EoErjVGfhDPGJxR3UqYdebavwNVpuZWxqcXACTrfO
 SsQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTrC8MyqW+YZgpN1FBN9sYKdrdyy2lYvSY9KgPuAdXnjNi9/hp8fNpe3i8b188GqR3oqRoNb58yFDr@nongnu.org
X-Gm-Message-State: AOJu0YxJabyScZKtJnwAJe/mXfxx0Z/UeeJ3E/zrh5YCYhlv3jSYisiN
 z7TlUWXBAXnFydJsvjFpJlpR+a8SB3ycoWhgnmzyEwF3iQwvwHnHQ565545rqG2t1crq+/van4Y
 mDXhk61aslocu8C/Y2PRXsvoXrnbmEQUlMWKI+g==
X-Gm-Gg: ASbGnctSq4pXXntMpFzivP3HsqlxIGW0WUMaQf78ZYMYK5WAHFSrKRBR7llr5fTRcsZ
 xVB1nMuu/HQ8de7duUylQITSvdj1eVl1j
X-Google-Smtp-Source: AGHT+IG+4QjcRBK/DasgfnyR9UQQiv1EsnNQR1FmEULqMJInJmDgYpCFJgEJdG6WWAuCRqvny0P3ZtVzXUv2UCN2YR0=
X-Received: by 2002:a05:6402:254e:b0:5d0:d30b:d53e with SMTP id
 4fb4d7f45d1cf-5d3be697749mr2745482a12.19.1733496174107; Fri, 06 Dec 2024
 06:42:54 -0800 (PST)
MIME-Version: 1.0
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
 <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
 <CAFEAcA9SCfMcrhpd_x0LmgwtD-5XwT4TY+QXBJMOjWbdtBPCUg@mail.gmail.com>
 <CABgObfZSR2s5AYEAcJfsdF0jKQGf_AVcDafKQq47qzLmBuX0RQ@mail.gmail.com>
In-Reply-To: <CABgObfZSR2s5AYEAcJfsdF0jKQGf_AVcDafKQq47qzLmBuX0RQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 14:42:43 +0000
Message-ID: <CAFEAcA_dVnpN2Vn+VAf1XZSAdj183wJhQZ3pVNtb=NHeMOF2Jg@mail.gmail.com>
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 6 Dec 2024 at 14:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
>
> Il ven 6 dic 2024, 05:59 Peter Maydell <peter.maydell@linaro.org> ha scritto:
>>
>> > is still decently packed and simplifies things a lot.
>>
>> The old struct is 4 bytes, and the new one is 8 bytes.
>
>
> Yes, hence "decently" packed. But I think in both cases it's passed in registers, and for 64-bit machine that shouldn't change anything.

True. Though it does mean we go from "space to add new fields
without making it overflow from one register to two" to
"completely full and no space for expanding it".

-- PMM

