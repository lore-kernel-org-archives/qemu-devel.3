Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A97AC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 16:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPNu7-0006a7-B8; Wed, 11 Jun 2025 12:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPNsW-00061q-It
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 12:00:52 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPNsU-0000aT-AK
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 12:00:40 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70e5e6ab7b8so59436727b3.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749657636; x=1750262436; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5OaoxdfKJkwmPnOp0r6tkgXcRA6CzoBt3lerX9GW0no=;
 b=rq0OTI/CT2F8P5xXSlkjvIqLR9qQ5Tv2PZ0N4d/kkhms7ZOhUustdbtQco9nxlI+SO
 iVF8tvV5tASKvlxVxgesKwqZhPUrxR2KYt2H/YHz55UoinaesH9CuZTxQR3WEf4ukj0n
 qRaNy3QLzja/IcJVymuFyDBkdnLHrWoyRiSqZjz+SBXhW8RA/PnWfdgyfkcYDMD4zE5T
 x5WQ0L0QShZYNNBdEyzPMWj5LNeO61zU81MsR2pEp07eU+/VRWoVNCRDsRzNB6IN3KU/
 Fcgr4P7Tex0PXCmHsPtqHhw+rFXYo5T1Ur2iHyAVnR3mknUo/MapWeHN7ceg54OcPZVP
 qRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749657636; x=1750262436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5OaoxdfKJkwmPnOp0r6tkgXcRA6CzoBt3lerX9GW0no=;
 b=HpWcOQBhls11eNx2mean9SuqzeaimOslx8c5PK9O0WIOul/+hB10GUAqwGSxspCPJ4
 dC1RkcgAkKOLJZ1v58sLm16RGsxcGzU/uWocvVldOKMPKsZhDc8AdYvrlck6W10exsee
 AAjxxK6basn5DY3T3d6CseL0soUGfmmnZRWGhJ8uNKhMBoN8bZLF7hOciN3Nfq9zIVA8
 AEvqn8pOmp3m4eiq+4ky3h1ivrgvowR+cv3ejhTuJEr7uCuAAeaP+azlxXKWs3YnQsVr
 19znkI2J3l/WV1e8pz4qTgoQFogkuxxTg9Nq2O9fol4bSwfjb5eND0bKftmjqBoYxufn
 gQXA==
X-Gm-Message-State: AOJu0Yy42keYLxE+9C6eLUqhifYNgfbVOmaWCnfpVkbeBUF6K4QJyvHS
 fu0atYU4D4+uu3BfK3uKWcz1S+WKNeDshFQub/IziEU0m9+nb+LU7bTUA/Z4/kfCEupdMzkdWbh
 aJfJESF2+Ih/UydiaOfuxcEtT3j78aeBFX52Ni83lvw==
X-Gm-Gg: ASbGncvVrqO160r/3s8Jl8I+7eYGbqxsQaVBDBU2IElPsg2b9ZODKdbwZSF74BUFql5
 d4pDQDhlT8YUC3Ch01HyUVp6GEKzIfw7hFKh3yEdfDWKXLu9F+PNLPUeHdey4Tijx3XRSO2GNtF
 3Ulo7fyB+hPAl78DZMMMyv6jXc7jRJqjhAzusbQr1rlu8D
X-Google-Smtp-Source: AGHT+IFDr3emsa9a55tI1ZK8djEJ09y2rAcRlrcPyoDuOCjBa/S5e4lUUTz92zninjuyr87/rxnFTTreh3AtnsDJw1c=
X-Received: by 2002:a05:690c:19:b0:70e:73ce:80de with SMTP id
 00721157ae682-71140af625cmr52801557b3.25.1749657635560; Wed, 11 Jun 2025
 09:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250611130315.383151-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20250611130315.383151-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Jun 2025 17:00:23 +0100
X-Gm-Features: AX0GCFtAvscHchBzHWFHpyRoDv8WQCNvH78__LXOvUZY83NpbpBNhd8AKwxiFuU
Message-ID: <CAFEAcA-MSZiHZbq-BxsH=VoyMr0JT+gCf+B8hLgQeffN0gePFg@mail.gmail.com>
Subject: Re: [PATCH] target/i386: fix TB exit logic in gen_movl_seg() when
 writing to SS
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 11 Jun 2025 at 14:05, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> Before commit e54ef98c8a ("target/i386: do not trigger IRQ shadow for LSS"), any
> write to SS in gen_movl_seg() would cause a TB exit. The changes introduced by
> this commit were intended to restrict the DISAS_EOB_INHIBIT_IRQ exit to the case
> where inhibit_irq is true, but missed that a DISAS_EOB_NEXT exit can still be
> required when writing to SS and inhibit_irq is false.
>
> Comparing the PE(s) && !VM86(s) section with the logic in x86_update_hflags(), we
> can see that the DISAS_EOB_NEXT exit is still required for the !CODE32 case when
> writing to SS in gen_movl_seg() because any change to the SS flags can affect
> hflags. Similarly we can see that the existing CODE32 case is still correct since
> a change to any of DS, ES and SS can affect hflags. Finally for the
> gen_op_movl_seg_real() case an explicit TB exit is not needed because the segment
> register selector does not affect hflags.
>
> Update the logic in gen_movl_seg() so that a write to SS with inhibit_irq set to
> false where PE(s) && !VM86(s) will generate a DISAS_EOB_NEXT exit along with the
> inline comment. This has the effect of allowing Win98SE to boot in QEMU once
> again.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: qemu-stable@nongnu.org
> Fixes: e54ef98c8a ("target/i386: do not trigger IRQ shadow for LSS")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2987

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

