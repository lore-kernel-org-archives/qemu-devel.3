Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40DFC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfoM-00011U-UB; Thu, 30 May 2024 09:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfoL-0000rt-5f
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:27:17 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfoJ-00017F-Ju
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:27:16 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5785c1e7448so861978a12.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717075634; x=1717680434; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nvK0Kt2NNELo3256QNX/h5HK9KE6QrWVrfLHacMI0Oc=;
 b=PTkZWe1TSUux4ByuUEic3kwi1mYae52YhEWE77hrU5d4qY5zJqS8DGslCfQQker2j3
 +oaO53Wm+ckAm4mt0O0uzf0R49DME6Rae4Lc9uuF4jdYT9NKbw2xxySwDztqPMLAAUZS
 UrMDMu1tYLhV4gbLGQKdD+JlCWpXR8nuVx9TPfGYL9uHQrsfH69MoOMqiVXAn6BgJ5Eg
 ypr8RxLG57JqzCguA0Hw30Ka2/88a0QSjvy6XYfCVj8TK1klSwT9HYfCljpfkRg/0dI0
 8DHi6PRO/6BrsyEF0OVi5lsbP+eaHImtGiaiBMF81YQf4lB1yvx0nJu3BDe3DWW/fT01
 WbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717075634; x=1717680434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nvK0Kt2NNELo3256QNX/h5HK9KE6QrWVrfLHacMI0Oc=;
 b=vTCE/tgtvQSFSjPxW7fqLZaRREDwU3FvGL0mCG7ba9StfI7J0TEx1VZBKkoynI1sF5
 SxWYlxh5UUeUTMM6pxDlqKPb2MWgzh8ojQN7dj4O9yhWwh+qdcLgm4w3c3j6QbIleSY8
 WEaTCxr2eQ/KUErDzSlguTYKMOX8/2ji8flCSDV3h1dAUrR1aOwVwi4QtDxuiD5k+pvS
 yq9JgGDarB0StuIjJV7RveEwTmk2GM3gfwiFx/1w31sCSff0uvSZoTcno8PRR22R2/pl
 XJXb9RV424A++vT3uYUbzGm7BgvYH6uLWQWTbJyxF0ST+jV0x4KVuP3A2s3Ah+a4+gJQ
 NJ+w==
X-Gm-Message-State: AOJu0YwPETnvnj2rLffM5oSEIcogPiUzZSSIKgbTor9GbkNsoloCkrgR
 qVX935fxCtDUSxekK7/+bUjCSDvIiDBTbatW0ijk6Nw5V1bc9sPrekImwXRSIlPm9y7vW9gFKO+
 HwC8DyaBWRL2FJKvZgjh2yAObiGTEBi0A5fSxrA==
X-Google-Smtp-Source: AGHT+IFuX7yvVc7/XWNn9ID2K3uAc1jAmpfZKzTyZH8gXXqmzzs/A5t+oTk1l+Keiej3KQZoZGcwLrsI7SJx0N+pgwE=
X-Received: by 2002:a50:9b56:0:b0:57a:2ccb:b3f2 with SMTP id
 4fb4d7f45d1cf-57a2ccbb4eamr275587a12.16.1717075633951; Thu, 30 May 2024
 06:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240519094106.2142896-1-rayhan.faizel@gmail.com>
In-Reply-To: <20240519094106.2142896-1-rayhan.faizel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 14:27:02 +0100
Message-ID: <CAFEAcA_zBhe+HxOqtAzWSCbzApEhknr+NeheA1uLj641EXMM5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Initial support for One-Time Programmable Memory
 (OTP) in BCM2835
To: Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-arm@nongnu.org
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

On Sun, 19 May 2024 at 10:42, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>
> All BCM2835 boards have on-board OTP memory with 66 32-bit rows. Usually,
> its contents are accessible via mailbox commands.
>
> [Changes in v3]
>
> - Forgot to replace constant with macro in one particular spot.
>
> [Changes in v2]
>
> - Replace read/write with get/set in bcm2835_otp.c.
> - Use impl instead of valid in bcm2835_otp.c.
> - Replace all constant values with macros defined in bcm2835_otp.h.
> - Change memory region size of OTP device to 0x80.
> - After further testing on a real Raspberry Pi 3, I noticed a few things
> contrary to my initial assumptions:
> -- The customer OTP lock bit is bit 6 of row 32, NOT bit 30 of row 30. This is
> currently undocumented to my knowledge.
> -- The above lock indeed applies to the private key as well.
>
> Rayhan Faizel (3):
>   hw/nvram: Add BCM2835 OTP device
>   hw/arm: Connect OTP device to BCM2835
>   hw/misc: Implement mailbox properties for customer OTP and device
>     specific private keys



Applied to target-arm.next, thanks.

-- PMM

