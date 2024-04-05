Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74060C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 14:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rskWR-0005YF-06; Fri, 05 Apr 2024 10:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rskWP-0005Xm-0J
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:26:25 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rskWK-0006fI-5J
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:26:22 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-516d15d72c3so1975662e87.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712327178; x=1712931978; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9PMmZywclbaQRQPNoqGbY1UiA7EhTJ4HLYg86Zcitgk=;
 b=pdGdyHS5805tQbGghB4zCJAj7Z3IGCd6WJ6uZoJIqFDP0FcNxLryKh3J6gwVWn2Lb5
 4RPU5BDcilndE+DZGDiAXxsxAnTgyZiKuDviCgj07rDstFb5JIE65GyAxmU1CrSQ4T4z
 Z3blO5nJ+s6fY7u939zks7szWysX6qnRAh+CrvW6kOGEpk1YpiKzxCWObgB9xh7x8C/h
 WLuq00uVIs/Ktiz3AaRZHGx76gvOeJ38cytFJ6ZbMZKw2KiNw0ao99rghv2OIiJ1Z0cw
 KSRln4KXwFmdGORx7T6ebXGDtyvbbRlZ3XuAONhl26r8roqgP/6D5S7dpeNMS+0i88TO
 lbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712327178; x=1712931978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9PMmZywclbaQRQPNoqGbY1UiA7EhTJ4HLYg86Zcitgk=;
 b=PdiSXu/RXSZ26R7n7d0NkUEVFXI/B+hCZnkd11exD41U/x9Rkwfn2KVZIKByBD5IPs
 LdFVQLPes8OPFsoGshKo0CMsI6t0E30duOOGk9coSqFIUDPHvDOcDjdaOv7FE74zGBi2
 2bmhaYDwTIacBq20+Huwo8iHYCZafgbZ4w6t47NzRWxU0WLMkkIF9muZWkcpJGdXG/gK
 MbiKSvAxYtOan2ZHe4fY+VNTxqWtHpc9cvllyPVt6G0hDRUOpybUEcgA0RwGFN7EzL4J
 xxD2ZwBBXz3hqEsulZPt9YB6WtKqXVaDCX7ytGkhv/Rri1ZWKH8KAJXNlqmjwp6pEYg6
 CZQA==
X-Gm-Message-State: AOJu0Yx0TC1IxKeFXPGomsUBJRElsjMMLnamtq9HsGwqQG9wj4U05tMy
 CFPl0wK6sDve8yLDpgkrfgjw6R2hFuFnSmVxBkFW/nBVe4mu92cU7opUvVzT6IWjYmGORzQoH6H
 m57mK14xPAKJwOO1w4L5WbaBMQKEgoT4KVjMyWw==
X-Google-Smtp-Source: AGHT+IHOvYtEMnVNZxykGtRT4LAXCND7GdvS/DYFTGXphzPW9wXhsKNEZwWbT8vXoSbjnComucgXmGQIqH21faIm1WU=
X-Received: by 2002:a05:6512:3e17:b0:516:c764:b3e7 with SMTP id
 i23-20020a0565123e1700b00516c764b3e7mr1483708lfv.9.1712327178219; Fri, 05 Apr
 2024 07:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240329174402.60382-1-arnaud.minier@telecom-paris.fr>
 <20240329174402.60382-6-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240329174402.60382-6-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2024 15:26:07 +0100
Message-ID: <CAFEAcA8RhS_wMs-89YkKQq6Rc2FOX2VFZNG7Vcm7OKkbs2DgZQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] tests/qtest: Add tests for the STM32L4x5 USART
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Fri, 29 Mar 2024 at 17:45, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Test:
> - read/write from/to the usart registers
> - send/receive a character/string over the serial port
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

