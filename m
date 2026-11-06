Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0705606A32D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t3ITy+ZP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPLua-0004jN-SR; Fri, 06 Nov 2026 10:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPLuY-0004iF-1h
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:31:26 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPLuV-0007AU-UP
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:31:25 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b315dd057bso4764517b3.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 07:31:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793979082; cv=none;
 d=google.com; s=arc-20260327;
 b=p9Og8TbWxTAHXRQrCJhEUJW6pSBmlcnNvOmSuarEfGfprGJhkfThDI/2WQqh9IyNoe
 bC92QwDLGyRpC2YNaltlLXbSl0B061iMml7Ab+6bLPmuFXksquPy/eWMylItTcQzBieE
 O39jmlWLrz1nuQimM0UZ7Aov+ags3VsYZH6JZldDiH6ovN+HFRr8UH/oJrSDohAKLfvl
 oLpCace902ftGuEni8JOwf6/DmqLJemXgxS+PBEP0DIZo6FdCrTiONuF2GLnXU4IdlJX
 fV9iTqEPDxkMTGGKm15xVMn7llFS+G7rErAiOVRqlHAlnw/QXDGLPwB7uB3wBI3jTDEb
 fKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nbMewXiO61ml5gFWEqWb2NSo5jAl7EVEeUa88Ab1Zoo=;
 fh=VVG17rxBEiDHMN+NdIa2FUIrBoknqfQRtCU5ktI6kW0=;
 b=HJC4jG0LgDXKydcPJtAlr9x7TUUD8/iliVlnWMbUWN1NoWAFGfamiN3tS26Moyb7w9
 nqgOcA98nwz2EtgIAojRO5osJqZCe/iz1xK/GcOEdrJWF5pnsZATslYufmZqSxJDMBpM
 bj9KUbRjRAQ+YbiYaDaH/qhxqweingj7/BDAv41GvvafxTBSeREwSD4lgvmazPNf5lmM
 Wqo+gses1/xkGYaYqOQ3tNUlhP3ciYl+YSGaYngWhN0PM43lbhCXGI3Usq3+v/zgOsym
 2aoguK73mGimbfI4xYhbn2Z391mOCQ89orQzFewlEB3eAb37+1reuTgKwX3MYGeB9nS6
 XyJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793979082; x=1794583882; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nbMewXiO61ml5gFWEqWb2NSo5jAl7EVEeUa88Ab1Zoo=;
 b=t3ITy+ZPxCReM5EZVRejQ7MPPW8ygjm4Z6eIeqzFfjlgypUJ1fTyW2okSpMNXhRwMp
 Q06lme7ygGeQ34yuJh8YyazG2biCyBDIyXxojtvnTkqWQ8p4URXsgBkwOqKyal+alXlM
 nWm2x0LP9TedSmWWIkcMm278HzLidLdPQ/dw4a1Ad/quOK5K/LedQ+cEFx3yPphgaAId
 K/ZkMWJlHlnYECoTWUs7mSMWIJv5kl+arRO7tkvLEQ+/FoI1uor+DzEY9q/XYL4EddZj
 SHOvGF8X6s0cvuCP8K9NSET+lpKgUUZmJz4yEmtGWlscov7UWte48vNIc1fEDV9wfroP
 0Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793979082; x=1794583882;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nbMewXiO61ml5gFWEqWb2NSo5jAl7EVEeUa88Ab1Zoo=;
 b=UPEmC/XRYe4V20pSy1LyWstFFauHYOaXL9oy3AI1IpS7JV9Gn+XV3jUb+vpZTy+ML3
 DYNrIzsbXay0bmMYXlegmlx8945QAyBnRWDTa1UTOUO7ubcfFR/iwZ/qDI1Ts7ceG0GD
 FDHNOAWWF+PlWSWkIlbzePtrEYm/J4e1dB9JqBJ6RZhtUYSOgJ1vczfcDHTKRyPnLxqe
 3qjxc5kHDyBTiVI3+Ut4WM1X8t7cIBlpRkzQ7qDRC6C78S0PeWEYTDQhqFnYLE2exjra
 HCUFW7o0KpXG6gzSPIULEF1768ZyjgcIYBxd/nGh0PU0gI9ejc4zVACG86JeQ8ScvcEW
 joOQ==
X-Gm-Message-State: APuU4Z8FT5qE0Qet5W+rgbpPBla9ylMmIImRG0En9Surkjmj4mJKYp1b
 cLQ9+YHhKNBI+/fLPyfrM0DWY55qJ1iaC7idKDTkuFPhgtM+lqYcpLqFZaYHfy2+c6cU2hENtW5
 +1ykyqulo71TFnraqWRTDkYy3mBhJs/rE9gZgZvqd+A==
X-Gm-Gg: AYBFou0xuZrOE2pXF1cCP4PKmWxHWOUIT+F+L37xlWuPrfbkuXMp2BqCXjpfLeWiyth
 lpei5OYTT6JVBqCkjWUfMsFF56vNbX7uyOPJqKwcYD75sTZWOJ67mbtKxk3xWZ9EHUwdemBblaB
 7a/GgNsia0ACwShpoV+XKUnVwY/DRgsuVlyAHfEmRLW8K45g3YiB6wZUwyn0I49Zueq87br3tju
 4pfgwueksV4pNQOn/KmmNKwd5Px1v0L/mTbsAjL0yE/C1mI8hCQyBDozo/CU3rv7gexAh5t2Iq8
 ze8Oz6fOcpqIZgERUu04X5WuCFEk/yzHkJABjdvYEJ2axtWmsIqeUelzmIVWdQTVSwt+BmeuUcm
 7AnxGDYfRJKiGBneZvwSInET0uffoP9YlhlG1MWcNBzP+R/lujpd9M1wnr6zysEuf4Eds/NNp0q
 AC/7cscvp9RL3kV8/Izh+r
X-Received: by 2002:a05:690c:386:b0:8a8:6fac:1525 with SMTP id
 00721157ae682-8b341ac9315mr17573587b3.46.1793979082406; Fri, 06 Nov 2026
 07:31:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103145254.1543907-1-schober@cs.fau.de>
In-Reply-To: <20261103145254.1543907-1-schober@cs.fau.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2026 15:31:10 +0000
X-Gm-Features: AclHuK_PqW5yJQV_oGL2ZaCo-OYw1AiZLNTCGnuB22N_QxsgOtEK92_RQijFRqs
Message-ID: <CAFEAcA-wA_qKKXUaOBqqmb8M0QteUG3HcigC27pcupGbCmZzgA@mail.gmail.com>
Subject: Re: [PATCH] arm/cpu: fix GIC v3 flag for a64fx
To: Ferdinand Schober <schober@cs.fau.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 14:54, Ferdinand Schober <schober@cs.fau.de> wrote:
>
> The a64fx CPU model wrongfully set GIC bits in the
> processor feature register (ID_AA64PFR0).
>
> I traced this back to e31c70ac04001df5e540b79843834277e283fa71,
> where A64FX got added.
>
> This bit is supposed to get set conditionally in id_aa64pfr0_read,
> depending on whether or not a gicv3 is present, from what I can tell.
> Qemu picks gic-version=2 by default, while v3 gets advertised due to this flag.
> Recent EDK2 firmware accesses ICC_SRE_EL2 in this case and crashes.
>
> Clear the GIC field, as the other CPU models do.
>
> Cc: qemu-stable@nongnu.org
> Fixes: e31c70ac0400 ("target-arm: Add support for Fujitsu A64FX")
> Signed-off-by: Ferdinand Schober <schober@cs.fau.de>
> ---



Applied to target-arm.next, thanks.

-- PMM

