Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F3AC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 19:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZx0x-0007q9-FU; Thu, 10 Jul 2025 15:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZx0s-0007oX-So
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 15:33:01 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZx0r-000293-1I
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 15:32:58 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e8276224c65so1254903276.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752175975; x=1752780775; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YAHu5jqoLYr6MvTMyMW/lTzhTdvXKMYHhsf8uSqjSoM=;
 b=ZLG9otTN3r+zg3iNKbLucMUNvdfALFLqW5EykDKvGt9u8frhvDsNyGi8Xm1+GxKTzO
 6kQAHqTVBDP81hFQM8QisLUa0R3xMCmMRSaQg+CHwgRQLKwGgbZhTlqagJSPyIpZPuqy
 DQoUOW04sXQAvj5l704s+eBEg/btfo/z9I0RYJpMBjMPXcW3f1D6dGVPUFY3byThwQiJ
 an4/neghF1+htJ/pHr1IZd8pwR8fn1S8Y7ivw5hquLyDbLe0jYok6KgsjOLQjkKVmkZQ
 NMW6zfwj55in9qU/7SZHUPifo0to1SZ/Mg5/D4I5AXNv5bk+JCnbbpJEv9j4Yr7Iu0iP
 lJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752175975; x=1752780775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YAHu5jqoLYr6MvTMyMW/lTzhTdvXKMYHhsf8uSqjSoM=;
 b=kUT2O+fXUwf8qrB3IL1R/dJedZNyzcQI2orU6BjAL+tw0J57vgp8t9Aav1yr7uGFGC
 sU3eQjDMEV5zp6aSpzZ9HWUADU5k0nobuRLXohqDn73x2Mld1A2EXe+0azgrDmepkcJb
 OynxSb7Cm+vDZ2pSiZuj+C9bAKrshzzRFPSLuJtZzMRTTDKaDsnO3TMXD62LA8flBxEB
 FrXZwPEE0k6TlxY+F6Az1kVwp79WSrMjLliDf0bIqJQmOiPdmPNs3wmM68/PeCL+cRoP
 5lGy84PhbvU31x/ekU6Nqo9TARdCoBMgVJO+jGHDLoV62O2iTpB01l0NckvWphWARyAO
 fjmQ==
X-Gm-Message-State: AOJu0YxMLe4GcgoNif8PB8jp0N2gUR108CZkkrSP/Ryw1zLPcPMk1CgJ
 M6/aLY945QU25E+t6JI/e3OJ9jmvm4u3QwG5AMBXx1PrG2ixv9FUOKRlzb0GnGzSKHSvt6p54PT
 LxUKcbDnjGN7+XK7SOUXDAwbmDYC4WpZEIvia0o/tfg==
X-Gm-Gg: ASbGncsL9tjShrhe++V1iswSJLF2/DbDOhyfAKuh0XGUmnw7lyKqGg6KRgWMb/kaWDa
 GWy2/RnWwPEfNk7AsRbo45qUqUwceQ7QQd/3dpv9WKXIexW7tMwtP38vhACkSvthdr0QXfY54qY
 4FvedBhWO74q8V1JRPJ1eqiBINcSawG61TTouPfj1Lf5mK
X-Google-Smtp-Source: AGHT+IEuWvDFjrVNPvT+90jNev/pAZsX8MvbXUjqlT26+cXINs5G49QX13sdBtg8FlMV9ieAQLgtfkbiqfwoksT++4c=
X-Received: by 2002:a05:690c:6a12:b0:70e:1d14:2b76 with SMTP id
 00721157ae682-717d5dc93aemr13831817b3.23.1752175975063; Thu, 10 Jul 2025
 12:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <CA+z0mrds11nuuiANc6UHsTSSctYfN-AFqj61Q38kXA+iKFB0qw@mail.gmail.com>
In-Reply-To: <CA+z0mrds11nuuiANc6UHsTSSctYfN-AFqj61Q38kXA+iKFB0qw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 20:32:43 +0100
X-Gm-Features: Ac12FXzUejmavEoqIOd7RwM5ujklgDhY_mc7OYM7w8U6zno5LGdARlnCqfaHuXg
Message-ID: <CAFEAcA-DWPm14HMrNpdt32zuAYdjgQ145FrpzPCGn4j=mwEVLw@mail.gmail.com>
Subject: Re: [PATCH] USB MSD: Set s->req to NULL after handling a packet
To: Hannes Bredberg <hannesbredberg@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 10 Jul 2025 at 18:54, Hannes Bredberg <hannesbredberg@gmail.com> wrote:
>
> This fixes compatibility for OSes which enqueue multiple data transfers
> on the same endpoint without waiting for the previous one to be ACKed by
> the mass storage device.

Which OSes are these? If there's a specific one that users
might be having problems with and we're fixing a bug for
them, that's worth noting.

thanks
-- PMM

