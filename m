Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B77C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4MzX-0000Xd-Aw; Tue, 07 May 2024 11:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4MzU-0000Wn-Sz
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:44:28 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4MzS-0000eH-Nv
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:44:28 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e0a0cc5e83so36702391fa.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715096664; x=1715701464; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PgCWd3ozrnfYhYIfJMSsiKXQhJVHkqeKZcJjbYbl2r4=;
 b=ThYBRUQPY3cp/C6/u4kCLqjxRugrDLPrlR9/MUX8FpPmf2dtkkkKXfcP3pPTilPrBB
 hK9jrRNmkV0NFygp8UxQtU7Jyc4YqeCAcDfrZUKwzJ2JkDAb7JrPf7TeEdgBk+kN2bje
 rMf0/qEyPPLFbKN8sQV9UgEm1tfqhaJks9PsKfSNSOW92qsVpl8DlXgcJ526+2JXC3cr
 36cc1Tn60kvkbYRtPghR6f5vvoBG7rnmaGpgvPhs7nbNXpb/wDa7+VGvj0bVW5coVd0I
 Hog2CxNunz/We21JGfDkaU0DMLt7tQ6lly8Q0fD1wAdWS3MV2ZTPODaAQ9iHGr6UhRZ6
 hEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715096664; x=1715701464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PgCWd3ozrnfYhYIfJMSsiKXQhJVHkqeKZcJjbYbl2r4=;
 b=l9oWqYecTHMtFdGJ9KjsY4ZFWBDnz3IPGzgnAkCNhvnt91DP/UjZZ9YAHe7bftyzFT
 WqOUXy0utnCXbQbdRsdMsNcJAsNT/RsLEkQm546koWiK9zTLWkjI8aKr8qoZ/syd3+cJ
 3qPOO9d0qY/XN9PoLz2W1EJO7qaj2MLv8k4ZOXUqKWFyj0Q5tSDqeygWegKo61GQaMC2
 wlYDhiH2YxQUhpm1lUJi5KmrN71eBIzIq2YW9BMzREiR8gSPw5ZM9wRBUN+ueCES8/8p
 IV0NTZMvEAjK7Y+YOG6YclKkvDQckadqyNToZye7cwBQLL58lnGmxFWfmxcoj6M0T2jK
 Qz0A==
X-Gm-Message-State: AOJu0YwcwWbQ0OKgz8yO7TLpKC4sioIbg5+ygb7lk/hnWGeSWa61jD8b
 xcThUNyEeAZn9kEdRyILR+zExJ+dPAFtp3tdQm/FsZ8iqDyVmVrw1O8iTc6DLUYUywfVziP+9IF
 47HMM96GfMxxRCK/C81s0OzQCI6YcI9wGPbQifg==
X-Google-Smtp-Source: AGHT+IElj6IxXkWzHBSQLS9BijDiOIE+OySeSWbniQbQuAVeVcjhjlywJ4ANV4EEimwmNjt7wqCnyQLqCcxDGFzAdXY=
X-Received: by 2002:ac2:5a11:0:b0:51e:bc4f:ed2a with SMTP id
 q17-20020ac25a11000000b0051ebc4fed2amr8120205lfn.37.1715096664544; Tue, 07
 May 2024 08:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240503124244.8804-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240503124244.8804-1-dbarboza@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2024 16:44:13 +0100
Message-ID: <CAFEAcA_gu40QoTXUPP2f=8vGvEOTbGWKtqR3b-e7YYhbFG0aiw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] pci: allocate a PCI ID for RISC-V IOMMU
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Fri, 3 May 2024 at 13:43, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this RFC I want to check with Gerd and others if it's ok to add a PCI
> id for the RISC-V IOMMU device. It's currently under review in [1]. The
> idea is to fold this patch into the RISC-V IOMMU series if we're all ok
> with this change.

My question here would be "why is this risc-v specific?" (and more
generally "what is this for?" -- the cover letter and patch and
documentation page provide almost no information about what this
device is and why it needs to exist rather than using either
virtio-iommu or else a model of a real hardware IOMMU.)

thanks
-- PMM

