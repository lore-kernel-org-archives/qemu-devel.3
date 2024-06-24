Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F7CC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgus-0001kt-Ot; Mon, 24 Jun 2024 06:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLgur-0001kj-HR
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:27:17 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLgup-0000xp-JM
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:27:17 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57d07673185so3800100a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719224834; x=1719829634; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HBK0Vy+vs/LZfKujLdNrgfZSRGMpe3jalDCBZm4GeQI=;
 b=SpfdtXBmw1ynSYdWUnfZvrraVorwL+TCh7CI3O65nepWzf8zjasqbd4n+OTilLtVWJ
 1u3BKn42PI5yKnLdRQ4z0PVUpLFm88MSNnsfvc/MPCw6OtS4r8+3thu1j34mDoijRZZu
 lPDkk2+WqFzB6TBTtWQSWSJm801wB3789gUbvVF/hZVmBf3p9a4OrorhqMdJjTfwhV4h
 BRz3S8P9euyG8onpfFRsXrEvhLykJ1WzJHIs00ju2sG+M36mHGX+rkRsCnqLkESxwiZa
 3bB/MMfcWW13/4FDSRnGxb93TuL2nm6lJUMDfScl4NnFI5jeqpz3ke4f4yeLVLajpbtF
 uqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224834; x=1719829634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HBK0Vy+vs/LZfKujLdNrgfZSRGMpe3jalDCBZm4GeQI=;
 b=nSFzxxI5G3hdYVAyg0S3e1XBS9okOxtx/ehkJmYa4vAde7+O0hZYvfVaNt5Ye1O4ev
 2XR9FPWBLjIuAuN1la3fg/FjtTLRg6lqbfblR/sZiqLCHnUiaUJSju4KLw/d3qyf6G01
 yr/wH15grTe6ZMelRop2KvnICicilm3J5AdEQfHRlPawGYDeWTT2Vlux81Zt7xL9EYDd
 7GRsLb78hTYdi2GlFvxDmcoah37RG60cOqiSgORldSv1k8hjtTQam+Uj4wQE6X/XAVQr
 HCzvc3IbRMccM5Os5DsILmF6qhToKeNEKp2aPRWDI5bpPLnJcolVnxfSvXos8zNXs2/z
 IS2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNIeIkjBupry7U0MGXr5TMbcqcs6Lm+J15ylwcoc2bzRusVcpKS1LVSpadOCEergdvh1hbF36GE9A+51MNhSO0/VVhl18=
X-Gm-Message-State: AOJu0Yyw5PvQrgfVm7to1XFvDDOBw/7Eej9aNc2v+gGPuJ/YfTg29Juo
 MK2oCDraT6oVrZOLt7UupJYSu3VD8sNzyQ0tZcn7sYs/plhdKiuZBNxXlPYMqlJ5TUFtMl9ZhMz
 etQnyS37pRXjplFFkoeaE75J85BtNgUmTPgNW3Q==
X-Google-Smtp-Source: AGHT+IFBDlZlKJK1nB9Z+jJDCR8sMwIoQR+C4qhYVw5TcD7fsvdaGC0Q0J7lXXcM6Ezhdp+kznK5q9qcCApjVLRCj8M=
X-Received: by 2002:a50:d7cf:0:b0:57d:2e1b:6c93 with SMTP id
 4fb4d7f45d1cf-57d4a2ed8a9mr2877278a12.42.1719224833640; Mon, 24 Jun 2024
 03:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240623024555.78697-1-minwoo.im.dev@gmail.com>
In-Reply-To: <20240623024555.78697-1-minwoo.im.dev@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 11:27:02 +0100
Message-ID: <CAFEAcA-NmcugQwa1u=Yt0GF4y1BAGUhi3ZnLhs6SPGP+s1sDLA@mail.gmail.com>
Subject: Re: [PATCH] hw/ufs: Fix potential bugs in MMIO read|write
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org, 
 Minwoo Im <minwoo.im@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sun, 23 Jun 2024 at 03:46, Minwoo Im <minwoo.im.dev@gmail.com> wrote:
>
> This patch fixes two points reported in coverity scan report [1].  Check
> the MMIO access address with (addr + size), not just with the start offset
> addr to make sure that the requested memory access not to exceed the
> actual register region.  We also updated (uint8_t *) to (uint32_t *) to
> represent we are accessing the MMIO registers by dword-sized only.
>
> [1] https://lore.kernel.org/qemu-devel/CAFEAcA82L-WZnHMW0X+Dr40bHM-EVq2ZH4DG4pdqop4xxDP2Og@mail.gmail.com/
>
> Cc: Jeuk Kim <jeuk20.kim@gmail.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>  hw/ufs/ufs.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index 71a88d221ced..bf2ff02ac6e5 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -55,17 +55,18 @@ static inline uint64_t ufs_reg_size(UfsHc *u)
>      return ufs_mcq_op_reg_addr(u, 0) + sizeof(u->mcq_op_reg);
>  }
>
> -static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr)
> +static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr, unsigned size)
>  {
>      uint64_t mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
> -    return addr >= mcq_reg_addr && addr < mcq_reg_addr + sizeof(u->mcq_reg);
> +    return (addr >= mcq_reg_addr &&
> +            addr + size <= mcq_reg_addr + sizeof(u->mcq_reg));
>  }
>
> -static inline bool ufs_is_mcq_op_reg(UfsHc *u, uint64_t addr)
> +static inline bool ufs_is_mcq_op_reg(UfsHc *u, uint64_t addr, unsigned size)
>  {
>      uint64_t mcq_op_reg_addr = ufs_mcq_op_reg_addr(u, 0);
>      return (addr >= mcq_op_reg_addr &&
> -            addr < mcq_op_reg_addr + sizeof(u->mcq_op_reg));
> +            addr  + size <= mcq_op_reg_addr + sizeof(u->mcq_op_reg));

Stray extra space after "addr".

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

