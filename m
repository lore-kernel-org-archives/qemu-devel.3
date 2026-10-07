Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4A8CA6004
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 19:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEXHl-0003y2-4a; Wed, 07 Oct 2026 15:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEXHi-0003xX-Vc
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:26:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEXHh-0006By-9w
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:26:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so14506175e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791401195; x=1792005995; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Um9PZavPCMADPIRC7deUkM9p970YLHb1nXB2YPmlTW4=;
 b=qBWcl6eRZ/cizUvzUHvFk/JBFQWUTR4Zksfccu7olWuIwkqnWZIcZJIdiTxpbEKWV5
 qXv+iAhLpmFYlZRN/HxTjHU/fhK/ssZRNp7CjyyywLd+03vxKkkBAoKO3Hn4Jclo+ycN
 G1NZK4JZGl5+e/00+VJg8zs3AH42jYn1M4dBWRagpKf8pLY1R4GIvrWYLllOW6YZtaaJ
 4Ycwdj461w3FxLwfgO3yGVGGPkFeyJ/B+zIp0DKDDueMTlITKwQe/a2Ii7kbQdJzL+OI
 XIhu1Hn8ozx5K1No5YmHfyzxiU0agaeJV5qant1y3D3vWXqRvBvl3wTcA6rtCKsYJW8f
 OfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791401195; x=1792005995;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Um9PZavPCMADPIRC7deUkM9p970YLHb1nXB2YPmlTW4=;
 b=Aou5TPhw8zwMOjpHBKyZjQ7aFgrZaYLW+oD229d4pbyaDpOmxWVP5QxUVT3p6mBexu
 We/HL0/pcB9vNMVtPRun8iTuqQ9bKBUAghyMUAlDGajrdhW4VTPmzJU5BlO97Ssq3uwb
 6W3FWnGVAF3XZJlfqvTstPrzlL7jnMIr0XPK1uc974qgVy6zSmx8oIGiLM0UNQgxrpf7
 nzgvmt1/EYMNgmzCEif+C7rZv99weWuhJgg5EW735PJKWkddQJy6MOL8KJSE0VY6uvyu
 Xz7HwnkljsWTospn/d6C3KtMeaKh13XacQ33EYXFrg2V9EUf7E0vbsTHc/1ebJ81pjSB
 aMSg==
X-Gm-Message-State: AFuF++mkbkDYX8QHMhBz3G87AR+jc9POCwT/4/wP/wds6mqj2fRPdaDF
 u1Rho/exqafhUQpSzCAdGNytRoRbpbLIvrL1HwYpUx18cJRLmzcMa45QnAzVGA==
X-Gm-Gg: AYBFou3/aJdUEaFlbxv+5lk8orgnNks8u+xgy+0OS80sjl5ubLqDUKwUTypF4z8Gr79
 V70cYpi/xn/m5B9I8514kd6uTbuxP0IxAr8odn8h5YtHhti9E4KWLaqhQux+Cfq/RhIkd2Zod2S
 TsupDVoJ2MmleBW9c80Ctsi0HrcuT0v/gMoZ731Us6N7CpyiqZ6dG7471jXnjQjFqANa58XFEgx
 Nx/6NBzwwoK9DY4gt4NBYWLpZaXrE6gI/NgxHzXiy6EtdcRTUIFw6OfRyRi98r/N6BeoxsE05Be
 1Up8M5VYdVxt++xixKWiQUjjn8v2/sam09+Lp4ociORkAM9mwr6J44cdgs1W77qj4aH9D9skFr0
 qedIF8dsHgv5eciV8VaC969tyoAuHXAffrsF5srijJHT94pMiQXzh0F8xKT62KU2tD23kpK1rWp
 zpn+wFrZ7bge+V/O7Jap4p2N3lVvbD0EHN+i+Mz52sSfletRnRA7B6N4bJRmhmcrqint9zl7UYJ
 7eHb+mkpohYNaYYlwZRwhXzbsM2yrEwmVl3QG3FYtMxbaGWmcyhI/3xA6RSYHezf8yLlMk=
X-Received: by 2002:a05:600c:468f:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4a1806508edmr54031515e9.30.1791401195362; 
 Wed, 07 Oct 2026 12:26:35 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf09ae009c631109991f49ce.dip0.t-ipconnect.de.
 [2003:fa:af09:ae00:9c63:1109:991f:49ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843bd060sm16971695e9.14.2026.10.07.12.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 12:26:34 -0700 (PDT)
Date: Wed, 07 Oct 2026 19:26:32 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] kvm: shuffle bios loading functions into kvm.c
In-Reply-To: <c76a70ea-f788-47a6-8a0e-229694e6c571@oss.qualcomm.com>
References: <20261007183545.1899945-1-jsnow@redhat.com>
 <c76a70ea-f788-47a6-8a0e-229694e6c571@oss.qualcomm.com>
Message-ID: <D8D4269B-F7B1-4732-B649-B6EE544814CC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 7=2E Oktober 2026 19:01:06 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@oss=2Equalcomm=2Ecom>:
>Hi John!
>
>Cc'ing Ani / Luigi & Mark=2E
>
>On 2026-10-07 20:35, John Snow wrote:
>> Currently, these functions are located in kvm-common=2Ec=2E However, wh=
en
>> configuring QEMU with `--without-default-devices`, we encounter a
>> linking error at final assembly time where these functions cannot be
>> located=2E
>>=20
>> As a quick hack, I've moved the functions into kvm=2Ec to allow
>> defaultless-compilations of x86_64 to succeed=2E This may not be the
>> correct or most elegant approach, but it does restore a compilation
>> feature that was working in v10=2E0=2E0 and broken by v11=2E0=2E0=2E
>>=20
>> Suggestions?
>>=20
>> Suggested-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>> Signed-off-by: John Snow <jsnow@redhat=2Ecom>
>> ---
>>   hw/i386/x86-common=2Ec | 125 ----------------------------------------=
-
>>   hw/i386/x86=2Ec        | 130 ++++++++++++++++++++++++++++++++++++++++=
++-
>>   2 files changed, 129 insertions(+), 126 deletions(-)
>
>Can we move to a new hw/i386/x86-bios=2Ec file instead?

Yes, good idea=2E Please also fix the commit message to something along "h=
w/i386: =2E=2E=2E" since this isn't specific to KVM=2E

Best regards,
Bernhard

> Otherwise:
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss=2Equalcomm=2Ecom>
>

