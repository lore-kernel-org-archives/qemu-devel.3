Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C43CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 17:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umyf6-0002Vm-LB; Fri, 15 Aug 2025 13:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umyf4-0002VI-HC
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 13:56:18 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umyf2-00074N-7y
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 13:56:17 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e9321ed5e5eso1438681276.3
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 10:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755280574; x=1755885374; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EUv6WNMhAWGqe25yhZcpcBNXuFlzNFTDYjQBZ6rbxs0=;
 b=TllUdNkZ8oOmpSep5iJskH6wcLtG3Esdzn8B5h/nmXOXIS1HAD+cyi2/oS/WRdweyi
 x1ZsmXqQhWRVl6hkGNDVyw2ovahzhE1xOA4OUIknmh4KJesWwy472+bLkpDeXnREsynp
 4j6hm7eJFjdbT/8pdN7a90m9Bucb5A4SX317twiJkO1znDTlJSJGj0oG6fnfNBUNbgrH
 qgM9MLGF3XX4eeXqvh6ef+kyoiXRbMH7MTF2/JUlkZ+t6OBeEOKEeB9LG9mDbAFUOfbB
 wMATxiaoEJkbKsQ868QRY0NUsMuCartb32CsupDcXMa8HsceXwTsJZ978hQncdNQyLbE
 8bzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755280574; x=1755885374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EUv6WNMhAWGqe25yhZcpcBNXuFlzNFTDYjQBZ6rbxs0=;
 b=VFLicUdaMWxZmMXuoDksqf6wFcwq4RqLAo2HgmtzFjpVhUAxO9uqta0yMrUsyyklB1
 OEFMonevDjbCNkBQPqkou9SuqYuaOhkOF81ZqmkPS+mF9y01nxOujedyOAYj5MR3gQop
 hSTgLV8RVHhssXpP59NuujuT8NVWm4MnEvMZDkFL5+AXJdOe51Q0DY3PUiLR/EVuGX6C
 TQS6o/PfFQPyqoSXcMlXykGU/ov8WPT5SSgYvn8Q2MitaG9QwW605VzNmoN7gPVCaEFF
 yvhrG7bsFsCcF2tqMy/ut9kWmU0l+onJiycThIiOCL7aYyLf31nNdTeQzBVk8QSMPix6
 lifg==
X-Gm-Message-State: AOJu0YwDbb+TX125QUvf2YAFlvunODUjal/jsnOQZ/U2K4+q5Zb8++iC
 xBk5nzKwcR87UyypO3xVBFf1/hDnjixektlWyAbSbsbit7erGxBtY7t0hHaYr41blBbOXXA/O1T
 iOmjz6bpljOOMzPr9KeFqIW6UkolYnerLFMkYJ+VznbZ40vnTS5aZ
X-Gm-Gg: ASbGncucm14y6i9RgGYg8qtV6vbAm4v9ymoPR1M2MDi8GFnE7oq9iqrgtAFmnbxkuXu
 wojioK9jtMNLysjmXWdHmQ9S4g06GuUZJfBWhHqn55eBaSISJhngNGx89yXDZlvxru42rE7jimp
 KnuyeLvWlzDK/tsJY/UOpgCIgUVasKFWa7POxlop0XQE5baQZqODwlHkW/40jZicEef318jxqkk
 ch15YsE
X-Google-Smtp-Source: AGHT+IGyCen5iSn7dkV0K51mLkOxngm4EgLLP5wfryHo++ErsO8oki13MF85FEJ2ZSmWU1TKrEwRaK3gOEZd8NtQrOQ=
X-Received: by 2002:a05:690c:6e08:b0:719:61b8:ffd2 with SMTP id
 00721157ae682-71e6dd8815emr38220157b3.1.1755280574469; Fri, 15 Aug 2025
 10:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250721201134.13270-1-fanyihao@rt-thread.org>
 <20250721201134.13270-2-fanyihao@rt-thread.org>
In-Reply-To: <20250721201134.13270-2-fanyihao@rt-thread.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 18:56:02 +0100
X-Gm-Features: Ac12FXzbB8nj-Ht_0R5t1lh5ryffBdC3Fc2LfL2DlngkX70lTLwQD_YomGGcb8A
Message-ID: <CAFEAcA8Dq_Pm8tVZP9VS-oJnO2VVgsFyqrj4vn0AdMcCqz9zWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Add-the-stm32f407-SoC
To: fanyihao@rt-thread.org
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Mon, 21 Jul 2025 at 21:11, <fanyihao@rt-thread.org> wrote:
>
> From: Yihao Fan <fanyihao@rt-thread.org>
>
> This patch introduces a new QEMU machine type for the STM32F407 SoC featuring a Cortex-M4 core.
> This will be used by the RT-Spark to create a machine.


The Subject line of this patch seems to have hyphens
instead of spaces. A "hw/arm:" prefix would also be helpful.

> diff --git a/hw/arm/stm32f407_soc.c b/hw/arm/stm32f407_soc.c
> new file mode 100644
> index 0000000000..0a91d4bb10
> --- /dev/null
> +++ b/hw/arm/stm32f407_soc.c
> @@ -0,0 +1,130 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

This seems very similar to the existing stm32f05_soc.c.
How different are these two SoCs? Would it make sense
to share code?

I've cc'd Alistair as the maintainer of the stm32f05.

thanks
-- PMM

