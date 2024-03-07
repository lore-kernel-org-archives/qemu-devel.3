Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA8EC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDUZ-0005D3-4o; Thu, 07 Mar 2024 08:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDUT-0005CY-Qe
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:08:54 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDUQ-0001YS-Gd
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:08:53 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d33986dbc0so8790051fa.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 05:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709816928; x=1710421728; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cWJwhaSwHKxp03sDG/VnMcq/PNZ+KoxVwNr+Wsof9c4=;
 b=H3efZcVfWdZjrDRO/tSnsLQxXdGuoO989GcQK3T0JMAl4xr971+SQENuibquVBmjfd
 rPZN93wtgQ+nIiVDqPXfprhBLqEB74FFtaMftkmZm8bz849Hub0Wm9FOagHdj3+k4BIi
 nbN5TF3eq4tCr59SDzB0pdC+rA2z9P4JvDsrEzmSipHqalCE1iOW9hwa6A5EIDF7b4nG
 OLyL/uMXALuht5xFx4/sLAx3xNvbrAptoqaU5O3SvSjaI5GZXmAaNrFnXH646hVhHwps
 OlZ6xhlLvUIzsqS+ohzjEmU4kwBnsaJHeFY7OfqKK77JYqP3wc5ZbyploNtbkqznmR+r
 CCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709816928; x=1710421728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cWJwhaSwHKxp03sDG/VnMcq/PNZ+KoxVwNr+Wsof9c4=;
 b=NIUQ6iPpB/NfPjMw+IV0QAJP4q6LQkqnGs/TXgQfc2FCeZaiNzS0vn/OHkn0WHHvo8
 HeVTdGdNx+ejYXSpXqnDrhU9BeE7eyo0ZwMSfakXn9YsfeO8ejGBJ1z5HM/kp0KIiqVX
 WuAXO4qcck8gG7CAhjfUcYb/HUg4ciMx1lw2dLnGIHr3eRuOZ4ytH2al9Epb4rJZoziP
 p81XVhxy0Gf5yecKursZz43k21+dGciTmR864nW8AIE1NieZHb+mJUrk3bArduyAFR8X
 ToJryuj4zel4tYwwCWyfnwcZOdL1okoLabFPYyYjfFCQw8e4AIfMQJZg/UoBtV1D8xa+
 SjBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4qL0gRaV41wNSdpo7kjtK7wGfZHcWxfAQ/z+MfSOc0XMtgwnp8iwds9G0/8e4ettIuJgk0pIGP6brHhnW720BPDuECqY=
X-Gm-Message-State: AOJu0Yz8THbsUaEdRjEF5TSyuxUrwJIV5qsXax0uBtUkLSQypkt8HBId
 gj0LUUgFFzOBhEd8q7Fk+rEARoPlXeBMBtQ5Yu2EGKPXT7hnj51d78u581BUOTgK79SMCTSZmAt
 JHtAAre/BwvL9UG5QVE5rV5Wkvq5rdR2K4T+JBg==
X-Google-Smtp-Source: AGHT+IF8WCQl2uLw9r7Qx8+Z027SZfZK9H1eVKgXJWgKN4WmVTr2VnC5c6Y9P3uC+fYWMdbQLt9OEdDLy7qT7MDZ47I=
X-Received: by 2002:a2e:2a04:0:b0:2d4:986:76a1 with SMTP id
 q4-20020a2e2a04000000b002d4098676a1mr1260864ljq.5.1709816927946; Thu, 07 Mar
 2024 05:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
 <20240307-elf2dmp-v4-6-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-6-4f324ad4d99d@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2024 13:08:36 +0000
Message-ID: <CAFEAcA9b5bROP55Eyy7uO7vK+XJLJVmegg7Gwr5mu8034OGtdg@mail.gmail.com>
Subject: Re: [PATCH v4 06/19] contrib/elf2dmp: Fix error reporting style in
 download.c
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Thu, 7 Mar 2024 at 10:21, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> include/qapi/error.h says:
> > We recommend
> > * bool-valued functions return true on success / false on failure,
> > ...
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

