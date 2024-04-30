Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85221C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1p6c-0003lq-Jv; Tue, 30 Apr 2024 11:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1p6Q-0003Gt-Gd
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:09:06 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1p6N-0000yS-Gp
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:09:06 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e37503115so6297391a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714489742; x=1715094542; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kstWA/A41b+HIEwe5CE0/GXOQwIeOb+3kH17kJQI4m4=;
 b=n+7c+GKC2s9kUBlJF3dHpvWu4yf8p8ewYTJusuHfkRP3YTDLw2vTYhgQrA5SPcc+o3
 b3OLWHKCaprLzgcR5WVPW9Z10ABdbZ8Z3pmb/E14H63+3jLH47MkjlAEgp4DKHhaFEYL
 hoIIGPjZkBhV2gtrXQFS98IzN9G0fFw+ADVKsqZMRQz2KO5Ei3DL7NiWt/t3Ge6+oC0s
 FhNVFcal4G/m9RVAiCZ7ibLb58BPgIy0omrBRkHnvnqlawaTILIN1OOKAxag2hOh0huK
 h1OfAzWeXaIMpDVr2K5VZn7UTqOBxsHn7M/Ag+JUtOcSf2NSpY+kFUINPW0t7b3NySC5
 Wjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714489742; x=1715094542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kstWA/A41b+HIEwe5CE0/GXOQwIeOb+3kH17kJQI4m4=;
 b=WWIkgZsi1R+TkYh6XGu1LytpNfhPRanNkClf9rwIU6xzpDyyxg41BfOxzQ2RrvNOQ+
 0OyOQlPZcncah2LnLdpDQg7cw8aJqvxA+gO/2YF554Y7EHQMemruwLdRSAr/bGl26bfw
 eATi27ap685QjPU51Lx0ks3OdawiEnRNyrfWun/X0TyijWiaa0RCm7vB7Z1KNs0rIOxq
 Fg6BccrpDYtyYaYbr7FJNrccOMetWd9fnQ6WRgIpdn/Nm7EvAmn9JUkBce5gQWEoC/u4
 dEyDUDyGmgCv6L61JwsCroL9FGt8DeoYGXe28ucQ/OxbEs7MDE2g678NLbK4oGWfDHqP
 x1/g==
X-Gm-Message-State: AOJu0YxzfHKIONdmVPKlVu8iDTg2MA0t8uliii1owYNY2PwrXlNYke1A
 e/lTpkxwJlai4TBsMsPP4qfmCvOPH5aESKZewt+Y9PYGy0lS1FY04mLAT2l5botH7nlpYKUVogh
 zeL/LIeXsqZfR2SXI+jy2+J+s6ng9wP7fL7lRxQ==
X-Google-Smtp-Source: AGHT+IF6gYi4OIpotj3DhL/Y78FmeK6gT1FkpgXfKWFWVRk7GQ+4VFsgPdmCu1ACT72f6q4Prt9nkhgKz6SPDr75T74=
X-Received: by 2002:a50:8d5a:0:b0:572:7bae:7e74 with SMTP id
 t26-20020a508d5a000000b005727bae7e74mr47119edt.32.1714489741704; Tue, 30 Apr
 2024 08:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240424200929.240921-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240424200929.240921-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2024 16:08:50 +0100
Message-ID: <CAFEAcA9ssyX3knVnJAi3N6_aGgQ6HQYw-5iPxirWweJFkd64NQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Add device DM163 (led driver, matrix colors shield
 & display)
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Samuel Tardieu <sam@rfc1149.net>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 24 Apr 2024 at 21:09, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> This device implements the IM120417002 colors shield v1.1 for Arduino
> (which relies on the DM163 8x3-channel led driving logic) and features
> a simple display of an 8x8 RGB matrix. This color shield can be plugged
> on the Arduino board (or the B-L475E-IOT01A board) to drive an 8x8
> RGB led matrix. This RGB led matrix takes advantage of retinal persistanc=
e
> to seemingly display different colors in each row.
>



Applied to target-arm.next, thanks.

-- PMM

