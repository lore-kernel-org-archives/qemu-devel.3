Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4192C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rednQ-0005Hg-Mr; Mon, 26 Feb 2024 11:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rednO-000548-Hk
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:25:38 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rednK-0001gk-Hx
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:25:36 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so4415433a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708964733; x=1709569533; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nElDGtBS5T/6qd8QCponMvUB3AnJDsvyWP+1b7EH2jg=;
 b=eIdRicZAMGGwwibwqB5oymlzxW5Ph8SKQPVozfRezoUJtXS1yx3POHGF0ZNlJ16x03
 YALfqOEhNJpT98wNKVGohwHkwNMoRrSL5eyw3avDLEbZ1jjpYu0E4fK3c/NSmGpD8/qk
 iIF1nzIjapsw4hPawijPL6LQrY18gjt72TcrOHszyh8LaOsFNOofW0/44aQTJy0SqbZx
 3L2XAcBSvDEtivurzI1TAiN4vz+9t5sMV7/wmuMIgwLRDfYRN97B1tqyAJBOUH2wQ2eT
 NQAdjNnUQGBeT/iWSVtzBDPxuTpWySMp6dhEFhfMuCMVJgh+0zLat4ahxjMOp0Qcgbf0
 sjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708964733; x=1709569533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nElDGtBS5T/6qd8QCponMvUB3AnJDsvyWP+1b7EH2jg=;
 b=dlQi9X/+964qrJ3ZWaDDHQt7Kd6JLW3b4Ot4PCOVcHLwTMI2RxB9oZL73h9h4i8ZL/
 VjPcUqh5PSgiQtyWmIwjEu6KyzmeKj8fpVYCj8JAR9H3RA5Mth6pM7L+GO4n7ulUlxpE
 prvpJEOzm3/HGbpSY8aue10BVDk449Qap5ZBozDgcxB74qZgvIcIPY3htOTABUHC3vL1
 JLSUZh2jLRFyhhjue+1km5IgXt82NUR9ta8yVvUDzVRYHRTlsNqwVeIGrhNWu3aC8Uzq
 yQJumArUDZTj7YmPm4SBEleb7oqwpBECFI1gue9ObdtHpXH/ihs9gQVa11GZWerm4oXq
 AEew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNYTqAv0VyUqhcmkycEfi3pK5bywbaUG7KCdTzTS7jalR9XhDKNcLScz95uz9ocHnuthPyvHH47brwshLSlNWWWcnnfYo=
X-Gm-Message-State: AOJu0YwK+a7e6Wd4yZMLmd6vtXJrjj/5cYF4xZ5BoDmcpkDVvLpC7dcv
 Kxsav3W0oA9hQYy3NCH2aQKraYN6TvWDXYKmKu8UojsOjB6b6yWTqwScPyiRfCh446R8GV4AgCw
 pokv5X9RZANqZWzVMK+qt37IOUhn0TjP3Z2MfWrBhFb1BxqEN
X-Google-Smtp-Source: AGHT+IEfqYcYsjfEoSbsZ9oZBQW6v2BJaQSKmww8A+Rrp/fh8wlyL1uIVp9osKgKZ0IwtUgZfbrKxxwxAuuegEqWM28=
X-Received: by 2002:aa7:c898:0:b0:566:1745:162d with SMTP id
 p24-20020aa7c898000000b005661745162dmr1064889eds.24.1708964733234; Mon, 26
 Feb 2024 08:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-40-sergey.kambalin@auriga.com>
In-Reply-To: <20240226000259.2752893-40-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:25:22 +0000
Message-ID: <CAFEAcA8SEGvDOW0swyTYJiOPjmd+buoYPGVHXYGjTEY8nTAFWA@mail.gmail.com>
Subject: Re: [PATCH v6 39/41] Add missed BCM2835 properties
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 26 Feb 2024 at 00:09, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/misc/bcm2835_property.c           | 21 +++++++++++++++++++++
>  include/hw/arm/raspberrypi-fw-defs.h | 11 +++++++++++
>  2 files changed, 32 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

