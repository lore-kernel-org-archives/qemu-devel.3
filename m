Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FB6C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 17:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXkC8-0003cf-1B; Fri, 04 Jul 2025 13:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkC5-0003bo-8v
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:27:25 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkC3-0005ux-Hj
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:27:25 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7170344c100so1947377b3.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751650042; x=1752254842; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bOiOTqRcRNJJoDMRFcgcdMSWMsm2l6BNIFO/6a5P1cU=;
 b=Wu90Z/Fb1XAHUiButYZsehxUezAgcyKX+zp3TlfBPTmIUOrVuNuzhOXixFulMPYA7U
 hzV/AXVVTQelIBIlEUHqCej8AxDf+ZxcRC8OHBvrIL60JEUn9soSR25OLITW9PmUR5r4
 +GSfEjf6xNuBU9XWJOr+nQlcHXjGE91pmp7VXFsyq7WlLeY4i6ohFsCo+fc2gmc9gvnc
 U6EHzct3UGZAtXBfPBqqNw9DMxfTvYQXR4yUF+nC+9Ng1PB9sHR63PhG2a/ioXIzhOvF
 qblQDqEKn0k2UZCsNos/O5Wz/PHEQ9mmoF5kYHOT2zQk1yzv/xiDMxy4KhBtPiz0nSk8
 UmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751650042; x=1752254842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bOiOTqRcRNJJoDMRFcgcdMSWMsm2l6BNIFO/6a5P1cU=;
 b=HhkKwOAhvNrt7OvvTM1z39OFMUcqOJ7SDZP8hRYEh0rMEmhq6tQd6V61AH9fWQFtTS
 PV4PMMDidT4Z+DzWf31GKpzs7+q20XJHyA8fE6R1EKhfXdq86FAfw+uwYKDHkC2tkj1i
 nWQdS9TUGOgIdNdcvZOIJIJ1euD8T/GJdu6NOPyUYtb7faUBUkGu8d1+NIyVFPADUkAp
 IN8qJekfzqCULp4rkUu8jSiN15MhiJ13TT5dvbs5t2cSMI9DFHndQ8FWz09xmB6uhwFB
 O3xQ5fSZsEElomBary9x9CSfS6ZeKIS5e00f2z2hR/Mu58OyLpL3Cfl1071miYvdsD+G
 OmgA==
X-Gm-Message-State: AOJu0YwsQP6PrnGJkq9RQwd4hfILAgeLFXXVhVEta4XhyRJB2bonknsj
 nGS9suHlIK1Iqa40ZfqVpRqkAwwNo26Ieftf6Z/ysPI9RgDQtMgeQ0+PlvqTcxX01FSG3lJtdOv
 Os0odHmiGUFZN6KtFQpI1F8ARGV2ts4ssanjqYz2DG2JdmImqu1ok
X-Gm-Gg: ASbGncv7lCrS2G7NYdeDM8pLeqqp5d6tc7hFoAizjwpo76cS+us6ERo2uoAqxFRQ2wQ
 jWCg+YxkCywh2DA8qh/Q+4+sgf0HSWxuCckV3S9DYycMKdr2eyBG1XoekFfwVrbvSGgXqS0L8d/
 QBQZ1kv+KYnCznBMnl3N4PIw8ZVEh0EtbtNVFJVQ7DKiLu
X-Google-Smtp-Source: AGHT+IGHCrhCZRGfO1Ka/Ul1Q/TH2EYeV43hGiRlV8DMQfmqznCDa5n1UAwOr+b00raSI/P/Zk1qNsE0b2S+Xea5tmw=
X-Received: by 2002:a05:690c:38a:b0:712:d946:788e with SMTP id
 00721157ae682-7166b5f6d7emr33683587b3.14.1751650042358; Fri, 04 Jul 2025
 10:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250704165729.208381-1-jcksn@duck.com>
 <20250704165729.208381-8-jcksn@duck.com>
In-Reply-To: <20250704165729.208381-8-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 18:27:11 +0100
X-Gm-Features: Ac12FXwZXR6bs4p6fpRcl5BCjGIjSGSxKeNuX37eggC0NQrDm2ZcKPIRKuvhbFQ
Message-ID: <CAFEAcA_2t1FSK9frDLiS6fdOcGKVT20hgCZCxB52fp=uhGKrKA@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] MAX78000: Add GCR to SOC
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 4 Jul 2025 at 17:57, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit adds the Global Control Register to
> max78000_soc
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>

> @@ -94,12 +101,14 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>          return;
>      }
>
> +
>      for (i = 0; i < MAX78000_NUM_ICC; i++) {
>          dev = DEVICE(&(s->icc[i]));
>          sysbus_realize(SYS_BUS_DEVICE(dev), errp);
>          sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, max78000_icc_addr[i]);
>      }
>
> +
>      for (i = 0; i < MAX78000_NUM_UART; i++) {
>          dev = DEVICE(&(s->uart[i]));
>          qdev_prop_set_chr(dev, "chardev", serial_hd(i));

Stray whitespace changes.

> @@ -107,13 +116,22 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>              return;
>          }
>
> +        g_autofree char *link = g_strdup_printf("uart%d", i);
> +        object_property_set_link(OBJECT(gcrdev), link, OBJECT(dev),
> +                                 &err);

Our coding style wants variable declarations at the top of a block,
not in the middle.

> +
>          busdev = SYS_BUS_DEVICE(dev);
>          sysbus_mmio_map(busdev, 0, max78000_uart_addr[i]);
>          sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m,
>                                                         max78000_uart_irq[i]));
>      }
>
> -    create_unimplemented_device("globalControl",        0x40000000, 0x400);
> +    dev = DEVICE(&s->gcr);
> +    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
> +
> +
> +

One blank line is enough.

>      create_unimplemented_device("systemInterface",      0x40000400, 0x400);
>      create_unimplemented_device("functionControl",      0x40000800, 0x400);
>      create_unimplemented_device("watchdogTimer0",       0x40003000, 0x400);

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

