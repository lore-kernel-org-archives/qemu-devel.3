Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9558C5320E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 17:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siH4N-0004BY-2d; Sun, 25 Aug 2024 13:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1siH4L-0004AI-7v
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 13:30:25 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1siH4J-0007LZ-IC
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 13:30:24 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f409c87b07so40071781fa.0
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724607020; x=1725211820; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HtQ7hBQMyhMjsCwFnCOdf1hCeU6tMdM05XkRMYXCadw=;
 b=ncT7rp5umJ6u2SpNEsNh/vA+z8vVzp+R9VFKDQO0BxqJfTJHD3sNuVgm6PPOc48ymE
 XVx5FiTIp0w7Qg+F6hJsHKl4PP9AXDetywVBG3eVUB4IrUPn707dGl/unbUJ0/Lk3Bpf
 o0abqHaXS/UFlNNiIMl0ELtDoo8UmXhn0xA4sO50n/kaQ8Js1nNxm4v9MVgucczl24E3
 VwAJ64XSh/7/hMGELtwoTJxGBYdnk99s+7kzZtxZzUa0/j8IlCkIqKLjeYwEpRxmDpVs
 ed8d3b+63bZ6iyBu/N/NwliqNKlKwD9WwDtVMghKMv6kEUxaKQRtvcxZzo45ijMXG65Z
 +yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724607020; x=1725211820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HtQ7hBQMyhMjsCwFnCOdf1hCeU6tMdM05XkRMYXCadw=;
 b=gVz37TYT+1CLqCYVK9LtNA0jGX3vjxhBPw5eyiX6e19UQydWVgZAd0V/kYAd+xDCeO
 jpgNQ90OFKCtS+KFevBWJzSC3fcktR0FEjUqCa40raIPRNLb6jHT1ke4iGDfA9wie6OQ
 1yhNBVveoCA8CKhmqbSWBxiTK6OazYUDQKuZ8hDFYhVuu4yED1QzDWK56jWL5MmWrSg0
 cyD3L9xf3nrkNCR2KWp2x/N5XgAMOr6+qSL1rxO2mY8UmxBAtchDFuv17hEj4hgdJiwN
 fuunEe22WysODm4zz6SHnqv82C/eyDGy9oMqmp2XH5lX+mLFARIGNlEbDdwiXh9fAzCm
 XDiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4zWGL0kNlIhGpv04CpY8NJIwt2Ldf0gDhNhqFjw+sNVsmhJyeyoPR05jN13Ld8fgd5sFPG4CTEBqQ@nongnu.org
X-Gm-Message-State: AOJu0Yxaq81ydjyGSgrVs8UYLet75+kRjYpFAWWSeoZwraaC580anEjs
 4JWCk5ca77tEoAPywgztAmlw28RefeqnGSAJ9uSvn14i5n/79G+LiX6rNf+yufNt4sAb/NxrLvZ
 siEJIfsZkNcUImS/HVUwqejVNCuvG5ysrHKA/SQ==
X-Google-Smtp-Source: AGHT+IFbnnPm29xxq0INHW5RiH2Lv5pKY1vZArdNDZpzty3uSBaJS4a6pMozyl01j+1+rBu67jyr9TvZ9MkSButSs6s=
X-Received: by 2002:a05:651c:54a:b0:2ef:290e:4a39 with SMTP id
 38308e7fff4ca-2f4f4927e50mr64076051fa.35.1724607020253; Sun, 25 Aug 2024
 10:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240816163504.789393-1-doug@schmorgal.com>
 <202408210857.20254.pisa@fel.cvut.cz>
 <fdce5258-59f7-486c-bfd1-a4befdf72e3e@schmorgal.com>
 <202408220311.01551.pisa@fel.cvut.cz>
 <5aef262f-b1a7-4317-802e-8681451ac54f@schmorgal.com>
In-Reply-To: <5aef262f-b1a7-4317-802e-8681451ac54f@schmorgal.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Aug 2024 18:30:08 +0100
Message-ID: <CAFEAcA-G1JocxSfs=bcNFqECPGZ6M=RrJ7vipqjg4CCNWYMRzQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
To: Doug Brown <doug@schmorgal.com>
Cc: Pavel Pisa <pisa@fel.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Sat, 24 Aug 2024 at 02:55, Doug Brown <doug@schmorgal.com> wrote:
> Now, all of these patches are reviewed but there are a few other issues
> we talked about here (dlc2len/len2dlc and issues with the flags), and I
> also found a FIFO issue. Would it make the most sense for me to submit a
> V2 of this series with a few extra patches tacked on the end, or should
> I wait for this series to be applied first? I can do it either way, I
> just wasn't sure what would be preferred.

We're currently still in codefreeze for the upcoming 9.1 release,
so I would recommend sending a v2 with the extra patches. Nothing
except critical bugfixes is going to be applied upstream for
the next week or two.

(Since this is xilinx related I'm happy to pick it up in
a target-arm pullreq once we reopen for 9.2, unless anybody
wants to grab it some other way.)

thanks
-- PMM

