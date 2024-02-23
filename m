Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E59C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYtR-0005HG-El; Fri, 23 Feb 2024 11:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYcu-0003JW-1i
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:42:20 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYcs-00015G-9E
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:42:19 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso734297a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708706537; x=1709311337; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N++o/xZQDN2B/M4OL8iVIDR6P8lcXyUhAsIK1lW9Pf4=;
 b=FZCx0cAiRC1QNjCwcRUBmPVo7vHRKFjXPp1+j7iDLo9S8GZuLzZt6CIGxQGRehFVzu
 T1PlcSjemifkQiGo5NdnEBHqWGPXc9eX3LUVIe2GIsgSyStPH7+N6P5CnbBwO9r5zAio
 7iCyarjmCnoKURng0FJKv19TMuqqcJrWBT0TOMtOe/qU5yOIZW8E1+l2lVDZNZEFtZGP
 Mfmf6GxHZmiEhj8KBAWvUtxtTGuVBVriaqujzrkDYhmm5sfSojqZv45RLy8caqJTfIlW
 GiTepOsxGYwzuI3DzF83om70A1feJFvVb0Q50E3oihiZRyCq520spXuS6ojkhzgXyMGl
 ZUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708706537; x=1709311337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N++o/xZQDN2B/M4OL8iVIDR6P8lcXyUhAsIK1lW9Pf4=;
 b=RYRdvPgkl+TnC1B/QehP6vAvgeqHYykZViz29d3k9dsLOWXXkl9IYJTMqn9Vbp1hzD
 7MgpumoSDRxIkFyXrRGTHRPYKLIcMiS8G2xPtMcBzgr9yzSqoQWpHOZTLlVsgYPKkKEq
 yeQiEv4RWHBQyJOTsNsmlhr8zx3nS2uAjIQio5PyPdpgiZbA+CTrdvRc5fp8vrT3EhFl
 kaIKNSyNWwl0eX+MGJ3HSqyNS9HDf/t+beHk984ed4fjqxvb+ruGSatx5c+g6HT0DJt7
 X84a4FxY7YEE6DDQ2C9k1GalWBgsqlyTn1Vg7/yMq1JfAogx9lm21XkI3qAFevSAuYdl
 0/Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUslixTZ1Q4blCOJf2sGUR5U27CRa5jkyVogYEgn9dj3s0Oau8/X94Zp4qc9FrFAGaMtTxu1yqhoZ0vld0X2knL/PpVhDA=
X-Gm-Message-State: AOJu0YyeNUAiHsPy0MKMtbyFWXJYlvSNpcKptw1ZVcNuClGjuF2ODvvW
 XOd4sCaV70fQZsEJDHbiEguSi6KoPRX+63W8Aqs2YtT7zb8os1/gTKg3fIkwhuiHq2/swXahMbB
 cJmMJE/ZK6inQILfBhIWmTYPA6wU5xIkpNdcO2Q==
X-Google-Smtp-Source: AGHT+IHMcCLZWgr3SQDu+wNh8hJb0gs4oZj3ANldrKF/t73BKQn6gI17GToo0FvOrSMG6DOof/4y/5kKaNz4FyF4fCk=
X-Received: by 2002:aa7:d751:0:b0:565:396b:2c1 with SMTP id
 a17-20020aa7d751000000b00565396b02c1mr248955eds.8.1708706536839; Fri, 23 Feb
 2024 08:42:16 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-7-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-7-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 16:42:06 +0000
Message-ID: <CAFEAcA_0sa6bBUdja+bhMKKN+4ve6tTHC1Yqp+77=Fzede-4Dw@mail.gmail.com>
Subject: Re: [PATCH v5 06/41] Add BCM2838 GPIO stub
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 19 Feb 2024 at 01:19, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/gpio/bcm2838_gpio.c         | 153 +++++++++++++++++++++++++++++++++
>  hw/gpio/meson.build            |   5 +-
>  include/hw/gpio/bcm2838_gpio.h |  40 +++++++++
>  3 files changed, 197 insertions(+), 1 deletion(-)
>  create mode 100644 hw/gpio/bcm2838_gpio.c
>  create mode 100644 include/hw/gpio/bcm2838_gpio.h

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

