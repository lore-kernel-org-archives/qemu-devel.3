Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E204D59F5A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kIR-0006Uz-BD; Wed, 06 Nov 2024 12:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1t8kIP-0006UJ-52
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:58:21 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1t8kIN-0003V1-Fa
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:58:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so669365e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730915897; x=1731520697; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WAA4yL7DFxjSOgzfU7Ib8/m40rXSxLAhO7gNKSuiIV0=;
 b=HEQO4zjaa6ngNNYLPk7FBuEy8f/FIn17Ivyik7/t9hjX0P8juDrJ1zjFF2pQW+LNnt
 HEQWkchmM3Z2ZotxB/hK6sUlIdT3C+NhMPiLBLg8x7sG3S0UiofC/T/R+6LLc3tZ93+L
 qUecZsZQdqGq9WuruAAJV5W32TrdPxEeUUQldY+litBbdcPFV8a7W8rnLB5qS4b9XE5c
 /b5rbjlhfNImxb0EyBWmXQH/jELCsem1HciEkNM1GkzYFirnZczsmPY+r7XyGdK8fq4p
 uPJPBSogleXGdAh/J/MWCM93oo7QCTSu4aKyr8CZYWph/vI6fJWwV31Hx3YDvuQLE4bW
 qr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730915897; x=1731520697;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAA4yL7DFxjSOgzfU7Ib8/m40rXSxLAhO7gNKSuiIV0=;
 b=hpN1CfwZd9C9StdXBXcxxYRJLC8qF1tdzPJ1EKQkcvZudmvazkeKSRYCxrHS8k6vBG
 a4wSZ0/IUX3Ni8dJO3Mtfq0r6ELGUiDQ/6iXLexXU1mehM0ry62s+sXKx5M76zziPJ4s
 E350baAYaj2d9Pk9u8eMzcR3PtbUt2nVisYlv/BRAKF71uts/QuYha8DfQtKMygfZO5Z
 9B5v5zkJLG6hch7WTvN2hFbOveiZT6c6OED6SPHj24wpAQOEXglkawzb17NQz3CQMe57
 7sID9gJj0QsA0PwwkihMObfqA5PbUNLEflIgFfve6fkp2qunYYLepXgkG41FQo+RKyi2
 dwSw==
X-Gm-Message-State: AOJu0YyXaEtOOJf8k3OAm3fJjcP/ZHuJJsuAHBX+TqjX6U3jRrRBPBzK
 cEl70IOTQAFybhKscYqGibIBJ1jO/U1ffWmVNF9nScSG6lja1dpBF97xU2KO/26wKGjAghRukSt
 A
X-Google-Smtp-Source: AGHT+IEHLoWcR/ylhRv5o308ocQAYTCN5fnh1qdDtM+DfvHpXyDDILKiSooeqUM6++8/+JhzSk6Efw==
X-Received: by 2002:a05:600c:1c14:b0:431:57e5:b245 with SMTP id
 5b1f17b1804b1-4328328492amr166288255e9.23.1730915897522; 
 Wed, 06 Nov 2024 09:58:17 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6c62b3sm33750445e9.20.2024.11.06.09.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 09:58:16 -0800 (PST)
Date: Wed, 6 Nov 2024 18:58:15 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH for-10.0 0/7] hw/riscv: riscv-iommu-sys device
Message-ID: <20241106-45c7291760031b7896f9f668@orel>
References: <20241106133407.604587-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106133407.604587-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x332.google.com
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

On Wed, Nov 06, 2024 at 10:34:00AM -0300, Daniel Henrique Barboza wrote:
> Hi,
> 
> Now that we have merged the base IOMMU support we can re-introduce
> the riscv-iommu-sys platform device that was taken away from the initial
> posting.
> 
> Aside from adding support for the device in the 'virt' machine we're
> also adding MSI support for it, something that we weren't doing before.
> The Linux driver is then free to choose either MSI or WSI to use the
> device.

The driver (still only in linux-next) only knows how to use WSI, but with
a series I just posted[1] MSI is also possible.

[1] https://lore.kernel.org/all/20241106175102.219923-4-ajones@ventanamicro.com/

Thanks,
drew

> 
> Patches based on master.
> 
> Daniel Henrique Barboza (5):
>   hw/riscv/riscv-iommu.c: add riscv_iommu_instance_init()
>   hw/riscv/riscv-iommu: parametrize CAP.IGS
>   hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx support
>   hw/riscv/riscv-iommu: implement reset protocol
>   docs/specs: add riscv-iommu-sys information
> 
> Sunil V L (1):
>   hw/riscv/virt: Add IOMMU as platform device if the option is set
> 
> Tomasz Jeznach (1):
>   hw/riscv: add riscv-iommu-sys platform device
> 
>  docs/specs/riscv-iommu.rst  |  30 ++++-
>  docs/system/riscv/virt.rst  |  10 ++
>  hw/riscv/meson.build        |   2 +-
>  hw/riscv/riscv-iommu-bits.h |   6 +
>  hw/riscv/riscv-iommu-pci.c  |  21 +++
>  hw/riscv/riscv-iommu-sys.c  | 256 ++++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu.c      | 114 +++++++++++-----
>  hw/riscv/riscv-iommu.h      |   5 +
>  hw/riscv/trace-events       |   4 +
>  hw/riscv/virt.c             | 108 ++++++++++++++-
>  include/hw/riscv/iommu.h    |  10 +-
>  include/hw/riscv/virt.h     |   6 +-
>  12 files changed, 530 insertions(+), 42 deletions(-)
>  create mode 100644 hw/riscv/riscv-iommu-sys.c
> 
> -- 
> 2.45.2
> 
> 

