Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AD3C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMUl-000763-IM; Thu, 03 Jul 2025 12:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMUe-00073H-DJ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:09:00 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMUc-0006t0-RI
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:09:00 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-70f94fe1e40so13923017b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751558937; x=1752163737; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9UiVuqsA2q9rqnblnN4LVVLr24ECC42x+6TQAhdcejg=;
 b=I8FNA8US38jo+KzkoCFqpCDyHYwWFPuL0HY7ZsvBPpVRFzFNYxNV7cvubI7yZVYw6C
 zhMJyX87WjObVi0J69bYGqJgl0crCPZLEt9OIC6Ed50qMm2VLK2cxcnjfCI3KeQJqv7U
 AQd25TjdgXW8hyMMQhaePVWCMME4+2s+Hu3z4l1JrymtY/VmghmGN/FalCOzJsaqvSJm
 dAI3DPPA2nVf051XUaqi+DnII4X/uN3eKK+5Zd35dBJnAlkHQvsoM7JQ+LCAMOdOI/mC
 CinXIzATCRbcH5aH52LFDZM4G5AW7Ob4LLyHrJRwIGUHxtO3YJHGKTlHa4qvHKs1ME0S
 N8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751558937; x=1752163737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9UiVuqsA2q9rqnblnN4LVVLr24ECC42x+6TQAhdcejg=;
 b=nLsIlG0iCdsEJCtLpjRgcOi5P7ohKcv/4Bw39D0OcbtBFcONxTU5vyUmGdEqGcdu72
 AJ3tnQjQVmLRB2TaucmlSG71X+OSgwkdaslLtScGKQP8znfwjGOpZZ4Aq5ARgmkzQ4kJ
 Q+NTuWQg6/XQbHoQfxzpjfZceYlkaHRv35yNH0Yvp/lm50VrgD4g11C7TMwXjksR6PRG
 NbOsSbSQ/sIulEIqie/0NIqkLTVREUPwHZtQl5QrbsJD47GHJeHhkPM3zicw5SMJjVM3
 GDbVG9+I8N+nlzf1CeVTDUejJ7b5vEWVPp/WWsWQlBvIVp8xc/gH4ZIN4VTDCRrp/icW
 Ih7w==
X-Gm-Message-State: AOJu0YwyKZOYBOuapPVGQot2hHDTW52BvBjqOAti9OAqzSB+A6dngVMG
 HoOSx9MAhC5pXMSSD39znuNIv5pEbCFgPgO95W3wj25N4Xni3QZPi4Ag+Tf35tJ+K5VuPEXhEJE
 ccYWDC5bs19xkyQkXZzDRjLrdJyDRZcgHO1wN8Hj+Wg==
X-Gm-Gg: ASbGncvtrSNKGoFFkix75qdo+UiBPO78Czl46hFkvDaJu0DkELmvW4iTck7uwpWgD6M
 aNm9EBNmKIA69UXCqX5WAxd0HzN1NKQHstxlHhwbVZvERd7yxN1eyIvcuy9qSXZKShpo4+HmBao
 KdOb4Z3Tc6phtkawYWo+YQGwoT5GtlkODnJ8UPjOOrdhkH
X-Google-Smtp-Source: AGHT+IE8ftNyvlltKFYBsduyW+1kr9g1svbX8mBQjJydVNYRnqE6S6ZsSI+QiMVXHuRJtVvx76dvjvdGRfJaFmiXEBg=
X-Received: by 2002:a05:690c:c07:b0:713:ffaa:5767 with SMTP id
 00721157ae682-7165ca5e39dmr35976387b3.7.1751558937115; Thu, 03 Jul 2025
 09:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250618230549.3351152-1-jcksn@duck.com>
 <20250618230549.3351152-3-jcksn@duck.com>
In-Reply-To: <20250618230549.3351152-3-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 17:08:45 +0100
X-Gm-Features: Ac12FXwxu_iNEyEMrOb_Ea4m65DuWvr4ZoJn0Z1I943iulFb_4qFhZmTeQ7Y4sQ
Message-ID: <CAFEAcA9_PyYPx6gr9JLFSsb8WcjxyKLjzvNgsc2+u1-uzy7jVw@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] MAX78000: ICC Implementation
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Thu, 19 Jun 2025 at 00:05, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit implements the Instruction Cache Controller
> for the MAX78000
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>  hw/arm/Kconfig                 |   1 +
>  hw/misc/Kconfig                |   3 +
>  hw/misc/max78000_icc.c         | 120 +++++++++++++++++++++++++++++++++
>  hw/misc/meson.build            |   1 +
>  include/hw/misc/max78000_icc.h |  33 +++++++++
>  5 files changed, 158 insertions(+)
>  create mode 100644 hw/misc/max78000_icc.c
>  create mode 100644 include/hw/misc/max78000_icc.h

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

