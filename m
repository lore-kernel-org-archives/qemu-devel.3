Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA47BC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 14:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3Jl-0000m0-6t; Thu, 06 Feb 2025 09:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3Jg-0000lY-Ka
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:57:21 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3Jf-0002xD-96
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:57:20 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e46c6547266so766079276.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 06:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738853833; x=1739458633; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1a2n0F410wlCJlpCR7hdiclHsymQOFkDNDCJ3Aks74=;
 b=r8Ft5jggYXX8Q7KniCVwBXYJ8eaaiRR83doPPNcBe+TX7zhK3XKgRkQfrdE2DJSjdZ
 Hn6vTuJWHX61IrWwkPLd6xqhKWNI2PUAsNKXLJw06rmGjpB9/OSqBvrqdj6ytrdcGPlo
 fuAmADv9fDpP0WVeWlHPWCcprWrO233Bpbgg0nYGosTLY/g9f1y9upBjJwZgYE50IhLi
 jIkNH7vcIv3zziCeS/ib7kVeBjbv8PmTg6DX1GibOP1SpwBNJ0jqVxN9nUrGdZS4Ozg1
 yURUkT+wr2NyU+UozHlbvuVutsAiwYnt9UWvfoNFo368B7CuLg043T7h5YAjzikZjG0O
 HTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738853833; x=1739458633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L1a2n0F410wlCJlpCR7hdiclHsymQOFkDNDCJ3Aks74=;
 b=Vu7NcudHJqAiSsNxePXf9To73ssXJejeOjIoVAPTxPdH5rjWZvomdgwBN8eClF/uJg
 9+9oUt0nczHgUwRc49nY2jTuSo+mBZ6wyIotTk2nlngEWOp+I9H6m0ob3NPSHu3IYdWz
 JkeNqB1E98EtpWuIPNIAlhwm6jvpYaUaOwOAu75275vpjbivIY0oncqGpMAoXzLU43JA
 eksYvaQ/rY/6gUAYyDak+ZIOlozsmD1ffnSreR0DJS3EkWXt5luKgg/nCetiAjxqEvij
 IvM2RWUKqkdFGimNuIFJy5X83Yz/onx7yzGXvkVPDIFZTFYuJEFtuu/jDE3n2uE/1J51
 GLtA==
X-Gm-Message-State: AOJu0YzZofTVL5aaDpcNEnT/bCsUHbR5vCReOfqHSLjWIb0XGffn2IKL
 SUBcI0RdioMoAUfq8Fa0ZrvLWOosQofV8BS0YJ3gSmNYlInPtbi1/SJKy9e1F3HDHHLPo9l6AHT
 1Umo793NnYsDUsbaIoYLDCOjbm+K1fUNKuOm2ew==
X-Gm-Gg: ASbGncv3cUdHB6v6S80KmOVdJLs24fFYy5fLH/XA3/5H+eEpB5V0kjAKofGNk31xgBH
 b3zODoscaiq3qYJWa/mY7wyhSvDzrZMhdUnM/MIctQYRCktWwFlofs1JH7996b5B1QqDh1RcLUA
 ==
X-Google-Smtp-Source: AGHT+IEp5SigU4ikB2xhMT8f02GRoT6m1WSVjU8TyB3lWYhY+YcMQvZBswTtsGvNNa0AKlY9HCAMdoX17IRqMkqBiiU=
X-Received: by 2002:a05:6902:250a:b0:e5a:e7eb:2809 with SMTP id
 3f1490d57ef6-e5b25b4956amr5730615276.24.1738853833531; Thu, 06 Feb 2025
 06:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20250124175053.74461-1-philmd@linaro.org>
 <20250124175053.74461-2-philmd@linaro.org>
In-Reply-To: <20250124175053.74461-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2025 14:57:02 +0000
X-Gm-Features: AWEUYZltzsQ7x-MJFdj1yYYFfIr7XDzaGL1uSsrizKElKYdZPn8zEo4ZKOWwTLY
Message-ID: <CAFEAcA8n8FkUUHkAehj=srGyHbLjEE=mDKsiWOGgcgxPGuyJYw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/char/sh_serial: Delete fifo_timeout_timer in
 DeviceUnrealize
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>, 
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Fri, 24 Jan 2025 at 17:51, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> fifo_timeout_timer is created in the DeviceRealize handler,
> not in the instance_init one. For parity, delete it in
> DeviceUnrealize, rather than instance_finalize.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

