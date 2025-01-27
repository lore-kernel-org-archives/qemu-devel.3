Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C999C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPCB-0007XC-IZ; Mon, 27 Jan 2025 08:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPBw-0007Te-Sy
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:30:23 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPBu-0004Vl-Gk
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:30:16 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso7679619276.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737984613; x=1738589413; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TP1cbAw/IjvjEyESIJl01mjrOkupl42uCO4TJMA9egs=;
 b=j14ranulWiYVselltfW9WVHiUwRUWz7Kxnu+Yix0DXzONwIkgmHC19CDcBzLxgBZhO
 SIn8EgbGJt4MbJ2yU9nQvsJdBkpYPpwttlaaHbhDJT2hEE9QUlTyo4qZg26NOos71y1U
 zsSeOq5dwRpWDNo6jVp6rJ0viPU7Tm/QqI2fFX0u20rVrmAEmFRTBq4YLYcNJp0l9WZU
 6bTR9ekzInyglJ24wOZD7a3SBB7Uy/oaigO0mPE6ppcUHmmcxf/XnTI3rM4whLuZtaIb
 SeYcIFCjCKcYS/HDDr65L+TQ2zMYcFYaq6TBZiKSHKefe1GtLibwamckoHZRRRzCUo8g
 gG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737984613; x=1738589413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TP1cbAw/IjvjEyESIJl01mjrOkupl42uCO4TJMA9egs=;
 b=L/SaHyfZhGe3dGM8XNRDn0O+hS2G96+jlZ9lGarIkma8+ZQXKarEVQyMaRpaj2CydQ
 WgjbJQo7vQhrPdw97X5IcjQSX0fZ9V1hW16nrBrmi2Yc8KSQ5uh+p5k/xBF4Qa4URrUZ
 fTH3oNIw+RTicrglVyA5RDB0EnfqIjhoRt306EL7XXR6dvnPpn9DcUzjr3wIAfyTbcQX
 nwPalfRtfvY4IwIRCHT0s9oM3VisqS8vllBFlu7Jbp8haGdHiLxTWZycqeOxpXwp0vvp
 LCutRojs0gUUQNp0doT+FcsOX4RlEHA+4UM+uPVMH9rHc+yuNmWkd+I4W4bhbhQHssZI
 4Gbw==
X-Gm-Message-State: AOJu0Yx9GsgCyUEgeijNL3kfhOzNw8wjpr379YWVMYjDXQLrLqE8OoPp
 nHRp1xwuZvq3dHZu2Txv5HxCOGWjPDt3DUu6rLMl4VXs8AC0HHqBSPCSJNkEbm/GydVli64pQp5
 Xrs5gAQi3IUaAI5l1K2zinhBTw2b+6y08DJe1hA==
X-Gm-Gg: ASbGnct4hqPiwUFUbrTD25byeo1dMT1RSUVjqCkk08bO9UFUg4e+kLZGcArfLSz1Fnz
 UDLdH6nLzvbkfkkwLYrCIN0lCgO33Vnmm+mSUpIiZ7u3WDtH56S4TIRkyrCtvQgYL3Lqd3UbcvQ
 ==
X-Google-Smtp-Source: AGHT+IHCvLcWF+ukMnizH4cL23S27QzwkKhNsoaF2DOFSjhWnmV3jtj/j5jfjU9PGVEqKcZ17T0GF1cZXdyN4EwGWDQ=
X-Received: by 2002:a05:6902:2312:b0:e57:48ae:147c with SMTP id
 3f1490d57ef6-e57b10638acmr30074264276.16.1737984612959; Mon, 27 Jan 2025
 05:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20250111183711.2338-1-shentey@gmail.com>
 <20250111183711.2338-5-shentey@gmail.com>
In-Reply-To: <20250111183711.2338-5-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 13:30:01 +0000
X-Gm-Features: AWEUYZnpmmp3uF88rJdZK180oAtDF4s9m5Qe9Vvss4rdU8-ObZJ8_POX8ZPe1X4
Message-ID: <CAFEAcA-uv-CSVphmJj1wkL23z3tc0nwrX5Un=zoRUp33EcveWQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] hw/pci-host/designware: Expose MSI IRQ
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Sat, 11 Jan 2025 at 18:37, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Fixes INTD and MSI interrupts poking the same IRQ line without keeping track of
> each other's IRQ level. Furthermore, SoCs such as the i.MX 8M Plus don't share
> the MSI IRQ with the INTx lines, so expose it as a dedicated pin.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

