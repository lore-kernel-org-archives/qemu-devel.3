Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2BEC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 15:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVYmH-00016D-Q8; Thu, 01 Feb 2024 10:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVYmF-00012u-7I
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:14:55 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVYmD-0004bp-Hh
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:14:54 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d061f1e2feso13683321fa.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 07:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706800490; x=1707405290; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kCkI+bLFBdNlyOStsAJ3MIuYSbqh55/4XRxkFXp/iD8=;
 b=eccbbhmRq6S25cMi4Y9VlwFpxAfTrhtWRFCPq9VzvwIGMoWYQn2opldJwOaM2TZ0g2
 /5ey857wiPvmSdHcaHf/8NF0sp6pFedgzDzvgvKumO01cvxeBWICQthEzlD4z54k+Av/
 Sho6t1/Razwvop4iSxY0daw0Ee7zjLm76OyRTA07BQHaD37qFqbh0Rt9FWttSo5DnbOQ
 VrqOLCxZAF4eRi/6moyXKsEK+PmI5deJSBPzKz6xAaRMcift+zrDXtKJHuRJk4t9OOU8
 g1PHfplZgFJNWL6h7y8n9HsxMkhOUNfzU4P9YcECdxh95DsA03tdU0t4J64kyp7xRJpr
 aCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706800490; x=1707405290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kCkI+bLFBdNlyOStsAJ3MIuYSbqh55/4XRxkFXp/iD8=;
 b=nV3aL698mDtHqAM6GiEtcJExKz5jTVmrt5jFl+8+IhnYrAyXYJ9pC9nXmv45Qtd3oC
 bZPR3YXZutty0WfTS/Od12m+PUe+Mf/eSSpXH6MHVhXUUYEIpUOKDMWOqA9S2cfsZAdi
 PZb0OdAk8fZsFQmJ6bHtwmONjziS9nkjWG2WeoE1yn2lznY+YW2Qhq4Vh4VSn+pNZ6Ki
 Pwlx/GSQ/XdJNtvPdF7T2rgvaB9UIREeXUP9idBSV7QNwwTqT3OjNPH+Hds5+F64t9/7
 ZKEZXPsKIzy5aDFwrd84zsG3ER2moQWh3WIbI8+R6GGyPN5oTFXEHC4Rvb+q3XXtLZYk
 jtNg==
X-Gm-Message-State: AOJu0YynemRwSjbEFZWuo3X4UGAfj+niTkn5NMCYj1+XD/EQJgyeV7S+
 tHuGZRs2j6a7O2BPrHtKfIRWA2cXd2JkrIQM771qh0Cn1iFPbb79QwcazD+QAhM/KUW2Ex90PBQ
 yk+yd72UcYmBsm+6TRVlp40YXbp9fWKzsBhAPMA==
X-Google-Smtp-Source: AGHT+IEM5aXIa13F4HSfJKOG3mPPgWykUhPuF3x16HlIH9r/DmGqWXSOGoK/ig/FovE0qs9xlVcYcyUh5CVxn7Bf3cc=
X-Received: by 2002:a2e:be07:0:b0:2d0:7fea:2920 with SMTP id
 z7-20020a2ebe07000000b002d07fea2920mr280736ljq.37.1706800490578; Thu, 01 Feb
 2024 07:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20240126005541.1839038-1-komlodi@google.com>
 <20240126005541.1839038-3-komlodi@google.com>
In-Reply-To: <20240126005541.1839038-3-komlodi@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 15:14:39 +0000
Message-ID: <CAFEAcA-98n13CVYhdnMRDgTDavz6HZUSXCSrxb3=UdGL5vXLFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/i2c/smbus_slave: Add object path on error prints
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, venture@google.com, minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

On Fri, 26 Jan 2024 at 00:56, Joe Komlodi <komlodi@google.com> wrote:
>
> The current logging doesn't tell us which specific smbus device is an
> error state.
>
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> ---
>  hw/i2c/smbus_slave.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
> index 1300c9ec72..e24a1ef472 100644
> --- a/hw/i2c/smbus_slave.c
> +++ b/hw/i2c/smbus_slave.c
> @@ -25,11 +25,15 @@
>  #define DPRINTF(fmt, ...) \
>  do { printf("smbus(%02x): " fmt , dev->i2c.address, ## __VA_ARGS__); } while (0)
>  #define BADF(fmt, ...) \
> -do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__); exit(1);} while (0)
> +do { fprintf(stderr, "%s: smbus: error: " fmt , \
> +             object_get_canonical_path(OBJECT(dev)), ## __VA_ARGS__); \
> +             exit(1); } while (0)
>  #else
>  #define DPRINTF(fmt, ...) do {} while(0)
>  #define BADF(fmt, ...) \
> -do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__);} while (0)
> +do { fprintf(stderr, "%s: smbus: error: " fmt , \
> +             object_get_canonical_path(OBJECT(dev)), ## __VA_ARGS__); \
> +             } while (0)
>  #endif

Ideally the uses of these macros should all be
tracepoints or uses of qemu_log_mask(LOG_GUEST_ERROR, ...),
but I'm OK with just making a minor improvement to the
existing macros.

However, object_get_canonical_path() returns a pointer
to allocated memory which the caller needs to free, so
this is leaking memory. You can fix that by making the
macros something like

#define BADF(fmt, ...) \
    do {               \
        g_autofree char *qom_path = object_get_canonical_path(OBJECT(dev)); \
        fprintf(stderr, etc); \
    } while (0)

The g_autofree will arrange for the memory to be freed when
execution leaves the {} block.

thanks
-- PMM

