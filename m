Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517DEC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk1HY-00068x-OC; Mon, 17 Feb 2025 08:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk1HO-00065z-N7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:35:23 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk1HL-0001pV-Lq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:35:22 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5dcc411189so792631276.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739799316; x=1740404116; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZR6Y/qym+TUDnCO10jd+iLCGX54+ExwaOMfFV0zUvk0=;
 b=yKVawzMpXTfTmkr9kfyQL0/4Gcyz7HpcmKQdnkzuwdP8NQ9PStMGfrH71YU9HOxdJv
 y8fNSyp5NQTB86aoa/74JyiDjV/my0qzzkwFU2mzmf47QkhwHJ5gC9C5JfJuE6mD4Zht
 rnQuBzcHS3dqzksV8R6sOeNj8wwLuxaL7MxmZtWkfiMxTUvW7Iwt86BcFzosXrWBAMM8
 5lwPEupgJJCpLTXVCFGF1mBpptl6QVpytCxJ2Xm6MM/4feBIiFdkxJEWDDkOGtk8MHhY
 TmhVinaKCDrD3/yK9IpvL3VLhWHCdGENCtLw6O5xvC0wY/unaEL1vd9CugHV3u/1e2hM
 Za7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739799316; x=1740404116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZR6Y/qym+TUDnCO10jd+iLCGX54+ExwaOMfFV0zUvk0=;
 b=K2ci68+aCKNqeG9ev+iosdY8yprNygt2oTOrCpz4Oda0b1fJED9YIniw6WtpqpuAc6
 xpB0+JUetLlVUegQZm+DvEJGVAoWQsMFHnr1xj9liQJAui7vQfhiIlsoB+v1kTLgJWQ7
 +0CE7uaE2rOwfHpQHCUTmS4g89gC/E0WNU9atyNTXrieKevySC6+hoYhBiVUUU72KhMk
 GmQjRJ3Sevr/U7ZSSrwHNgV4rDF+JEj91IB7g3ee51nNP5UEgETEUUeNGn14ifOOqo08
 CfDto7K8+iWz24n1HIr6y8dlGbPyGjCskqmkFq76+8Xy0H+veXKcB8PEbXnYfBGHmoaU
 QzDA==
X-Gm-Message-State: AOJu0Yy9tn1Advz+RJGu//aQVBsImc7x0cC1JYv1IF72R+Lv/6RYltT+
 CwWf9neU3SmsKleCKVVkdkkodwOEM7RTnz2hAnrbHBCSSUJTL50yan+LO0ys/VO4QFcFO/EU1Qj
 5EKr/lBGsooy20GAoWxN3eDo3vFQFZEWf2XWvlA==
X-Gm-Gg: ASbGncsvdoMiYbFOcw6UNssIDZsM8NIjUdMblJlLiY7FPt3ORCQViSqAav2tz9bNM2Y
 AgO0sIe+7ogaeDDGlmiOTv87t13M8n+OlR5fQypIWHBAKC3y/VmUN1YBKiqQkdtZWYSmqNtkhyw
 ==
X-Google-Smtp-Source: AGHT+IGjJ4pdTxQ1A/7iTktptyBcDeUenQNLJMM44vW8usd2mTtdKupl1E9WVuM4dSpt1M02RYPQfba7OD03ffgdX3Q=
X-Received: by 2002:a05:6902:707:b0:e58:14b:6f99 with SMTP id
 3f1490d57ef6-e5dc901f547mr7518787276.1.1739799316021; Mon, 17 Feb 2025
 05:35:16 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-4-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-4-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 13:35:04 +0000
X-Gm-Features: AWEUYZk-vW3VIOeZxiFcaM49NZ97YF0H0F53_o90tMEwkevB4ARspkvDT2rsPuY
Message-ID: <CAFEAcA8yayMSe+64VDV8TwSMi7u0_wLM+y9-TKsnaZS5seNKZA@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] hw/gpio/pca955*: Move Kconfig switches next to
 implementations
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail.com> wrote:
>
> While at it and since they are user-creatable, build them when
> CONFIG_I2C_DEVICES is set.

The patch subject says this is just a rearrangement
of the Kconfig stanzas with no behaviour change, but then the
commit message body includes one.

If you want to build these when CONFIG_I2C_DEVICES is set,
that should be its own patch that does that.

(The move of the Kconfig bits to hw/gpio is fixing a bug
in 6328d8ffa6cb9d ("misc/pca955*: Move models under hw/gpio"),
which moved the code but forgot to move the Kconfig sections.)

Separately, it's unclear to me how worthwhile it is to add
these to CONFIG_I2C_DEVICES, because they're GPIO devices,
which means there's not much you can do with them as a user:
as far as I know you can't wire the output/input GPIO lines
up to anything. We have the device models mainly for boards
which provide them, so that guest code that expects to see
them doesn't fall over on bootup, and because the board
model code does have the APIs to wire up the GPIO lines.

thanks
-- PMM

