Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45588C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeJ3-0008Et-BN; Mon, 26 Feb 2024 11:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeJ1-00087F-1e
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:58:19 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeIz-00088c-Jz
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:58:18 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-565a2c4cc1aso3067059a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966696; x=1709571496; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2hBTiUiKlIrbsy1mY0gurx7qrfA7VwktbNBJNWgaEsc=;
 b=pxASy44gS4xq/7+tAtPr/MfuFJ5PXzIasi4UrTWV6cpU1zeNN/R+e3ULQd8tvZ7rre
 l7jTZRlpUAdouY76kV3J5UQ9LDREy/37bJ8Zm31Vc9e+vk37GcriZt0DUJJw/oawIQEl
 qrFooGl7ImJmLlRTQJe9rqtTD693hyFLTGbUaCaJorpfoVCziOqUnPmQhvjaN3i9iW7y
 7e0EB4ByglPWld3C/Cr6/xW/E3R9KFj8Y1xvJMpeCOUE6qzLFrbgbwGTTVbLntaE5BZT
 UFVSsdIl7KcE/k365NJyhmL1u5G0Jw6Br49YDcJGirqtNg6LAbwEOAs4fXdIdji0naRj
 cbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966696; x=1709571496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2hBTiUiKlIrbsy1mY0gurx7qrfA7VwktbNBJNWgaEsc=;
 b=u73wll2g/GfYPySviu7qpmir7PesaZIS+PjFDhSqdee9D7NpmWS9KJcV8gQQyxRDrJ
 ccklDGk1/p7jALDa9WnEZzMYpjTXgynW8LERL51IckJYTnph1ceshLtQDRAItEiPbTl+
 X2IAV6mFHBlppk7t0Rwsx1KvjORhe/5RQSULPPpmLEaiC1ek8LCcFujkatHOj6MtbxLO
 iCtfa5ekQT0wrC3k0F71TQMo+HC5y+3ndNt+XsNWErmzILZ2ONYGU46wps6AlkgJpzLl
 /QtnBIyd3sGg4IUk9Yc0l/DqLWtHwbUznJZ9Eeqv4IHk3n/fP8u23/inbbPQiq1GhZM1
 CPBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc2VF0dK7ZhWczjhgMlGM6P3WVEaP/eC0VEwdivbv/GitcpHyMQehaw3pWTHnI52QUB/bxen/m9DU2rB/jVwZ9CdRbCh4=
X-Gm-Message-State: AOJu0YylcrNg2mYxhbWp+AuN8HVFjbPnAjSuV+P2G8NYnKm4iFLYBLek
 lYxHrJcFsh+pPezOgaqJd8wtelZMaPVu9u+A1++7oxpXUdQHj/s9nQEgDR1IFmpINloKj4P8p1m
 SX9Pk0r7Li+ZKRN2lKq3Rc6NY0umQNca3LORWRw==
X-Google-Smtp-Source: AGHT+IEENXAdERoq2CaXAa8028s4Jwnj0gEsi2CIDNbZxfRle6heLLG6hI22SFsjolY+6SN4Njsy38ucNy8z5sOe7zE=
X-Received: by 2002:aa7:d513:0:b0:564:aa72:78e1 with SMTP id
 y19-20020aa7d513000000b00564aa7278e1mr4715985edq.9.1708966696043; Mon, 26 Feb
 2024 08:58:16 -0800 (PST)
MIME-Version: 1.0
References: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
 <20240224-cocoa-v12-1-e89f70bdda71@daynix.com>
In-Reply-To: <20240224-cocoa-v12-1-e89f70bdda71@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:58:05 +0000
Message-ID: <CAFEAcA8-dTpqK=H+D-s+3j+eUmK59xqp6eiioy4ZoSeWDqRyNA@mail.gmail.com>
Subject: Re: [PATCH v12 01/10] ui/cocoa: Split [-QemuCocoaView
 handleEventLocked:]
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sat, 24 Feb 2024 at 12:43, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Currently [-QemuCocoaView handleEventLocked:] parses the passed event,
> stores operations to be done to variables, and perform them according
> to the variables. This construct will be cluttered with variables and
> hard to read when we need more different operations for different
> events.
>
> Split the methods so that we can call appropriate methods depending on
> events instead of relying on variables.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

