Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C69EC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 12:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSz4l-0005cq-UJ; Thu, 25 Jan 2024 07:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSz4g-0005cD-QL
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 07:43:18 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSz4c-0003Uu-M7
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 07:43:17 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55cca88b6a5so1402442a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 04:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706186590; x=1706791390; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBo2p2FT+kQJVb1ClssDnQgpm0jNvb9prJhWz+pDlgs=;
 b=e/Tcl7z6W4mRpP66lwCByIXf2b7d3wQ3x/nwA5G4ugfa/UqpGyJpLujZoX54GfKpQB
 9gu+iI3wqwPR3bViiyzCx5GmG5efcXNJqUINIt0/xrXCxPRzWqaYzv07hUX73tCj5I/Z
 I6mPVJSBPK5I5+7p4X9jjYHUAovVIYu5jV38NASMqKHhRb8xpuFV4cDOZb1lU41fG7tQ
 fTxvTxGBKS3cNV62wSuJLu0S0yfkp99azbHgOpMPay/rZYCK4Kjr5wIeKG7F+vuRwpgh
 EIaHdZbwvrSAJ88HswnH7GYxLrWxrdRJ2SwKtsL/li33FGzH+QUUD8NXvIzUYx0dVmfj
 HdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706186590; x=1706791390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZBo2p2FT+kQJVb1ClssDnQgpm0jNvb9prJhWz+pDlgs=;
 b=LOxz+bG9lFiTy0QGbKmZxWv7bfnDhXJFSI8VlAIqea/NSNRi1uOdehJTL1Bd5Psvpc
 J7w8vEhs/fNIeAveC2EUTwHIKj0rcs8PPenELak4doEl2F68UJ7YDZa6JQLcYaAKYq2W
 5osnBS/Mx9HKaslYe3qGTbFSgIs8Lk/jHBE9gBtl1ZwlFjkLMSt6D9qrVG9YaoxyayR2
 LHHq956cgBwjlS+wDTGtms6V3BPkBGSoZZZtEwq9ddY5BlfXviQ7GX+6xluGtWXcjF+p
 LZqUYlnkwS41XDA7xTg4n1S9FFTisPTMrRcVj920beFszQio6XNxir1w1YENZIfVq46O
 b+Ww==
X-Gm-Message-State: AOJu0YxItojdcv5qjizK1tb0R1DM+mIUBHx/1bfhChwpDJ+2e+ekGC/2
 kaTUuQcIL+/6YyeNuFbjrCRa0Z9lDCv/xv9h5YYRugoMTVMEagyPnjhRyi+MvjfOFAn5Eoa8ZIJ
 S9tC8ZUYEwYxenk4VtbExyjfNDTqlGSlUe4Eg1g==
X-Google-Smtp-Source: AGHT+IHuSZRAOx0L/by82S3yKFUXyk9IudxIsKBTKEFHn3w+GEFvzVNrAL0MKAtUQhF/CYCTYfotIpIaV3+Ek6NEGE8=
X-Received: by 2002:aa7:dcd3:0:b0:55a:c0e7:1e03 with SMTP id
 w19-20020aa7dcd3000000b0055ac0e71e03mr627592edu.71.1706186590082; Thu, 25 Jan
 2024 04:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20240122173706.4019545-1-nabihestefan@google.com>
 <20240122173706.4019545-2-nabihestefan@google.com>
In-Reply-To: <20240122173706.4019545-2-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2024 12:42:59 +0000
Message-ID: <CAFEAcA_nvmAvoDvxabkbrkghAY1OwwNS52-ua1XeEdFPmvTqEg@mail.gmail.com>
Subject: Re: [PATCH v14 1/9] hw/misc: Add Nuvoton's PCI Mailbox Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 22 Jan 2024 at 17:37, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Hao Wu <wuhaotsh@google.com>
>
> The PCI Mailbox Module is a high-bandwidth communcation module
> between a Nuvoton BMC and CPU. It features 16KB RAM that are both
> accessible by the BMC and core CPU. and supports interrupt for
> both sides.
>
> This patch implements the BMC side of the PCI mailbox module.
> Communication with the core CPU is emulated via a chardev and
> will be in a follow-up patch.


> +// The device is using a Little Endian Protocol.
> +// If running into errors, please check what protocol is being expected.

(1) This is not the right format for a comment in our coding style.
(2) This is not sufficient to count as protocol documentation.

The protocol should be documented in enough detail that I could,
by reading *only the comment and not the code at all*, implement
something that connects to the chardev and talks to the device.

thanks
-- PMM

