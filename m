Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B335C48295
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 14:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWzaM-0004Je-L3; Mon, 05 Feb 2024 09:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rWzaI-0004He-Ht
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:04:30 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rWzaG-0001FM-Dw
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:04:30 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40ef64d8955so40754105e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 06:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707141860; x=1707746660; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lyP+XV4MHSzTk5g/7LXBG1p4OWr3o1tEc9pWpMcSyH0=;
 b=DMmJB+zGMgCO+gP7fYW2IWaD6+Zq91zp/pMy1pf/KDfGhfFFN6oePb8pwhTIw3H4lc
 N/DZbqAqzix+X6a3T3rRy9mVXkckHC5T7+812gApbR4U81dNx7R78U866BJKUPmGSh31
 enBeH5PFLz/ZXpHVdPRBy/ymVcoMEPsgm8tZLstVOoFLGVt+OM8R3NLR0NZwsy0YhKxY
 V5qI8uX7D7L4zfY87QDS3gnOh8ld+ARKeYiPoTDo9MLHMzGcCXJJxRzNYKRo3rEZY4lI
 EvBUA7Nn98M//CRgCYz9ahE2SJskuHdz9amomusTKqz/HJGHNdfNPVX5RNV7KMkCqqle
 Kjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707141860; x=1707746660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyP+XV4MHSzTk5g/7LXBG1p4OWr3o1tEc9pWpMcSyH0=;
 b=gUHwZ06BakTFphVl9NwYK5GNxDC0/CjX7v3EGyP3Eg7/8d7wycGsQ7nO5ui35fw9us
 4iHNUGDXwRuHM/zFmnXBtTvktOq+WVQpJmLmhhYE2SAVW30Q0+32A/QVwDV1/QS1ZBlC
 0iXvpOLqiJjfRw1HVtsrp8EOzF/dJ38J7j1h8qzb0ciUFi9EcBzbDpg/36JJiSx6vcvY
 vq9Cg5whUqFRCYIy6PVT5Ua5IQffjlIhN0SUwbJ9J4cGRai/EnQbrXog9teTP85KNNBI
 jP3vUT9Dm5oYcqR/If3VxZMARj9+Upfai1JxmCSNbnoL79fe2gKkWioXABcod4ivoGgh
 N0iQ==
X-Gm-Message-State: AOJu0YwJW9O3yRjTTlT3xcXXoR3h5I6zyh8AU07r59DWMqTxzUtY0tbb
 SOelyjOOQ2OoTEv6J8+NsBysMK9icAhOZrcrYW1O/n37rO8Sz+x76Gyt3BfFnX0=
X-Google-Smtp-Source: AGHT+IFnqqXHjbNVf7w/scYXCkICeMBYALUylvEi7ul7O7pvy4gLlOoKaVkJ0pkF9dFtLUVLiB9qnQ==
X-Received: by 2002:a05:600c:3543:b0:40f:cb69:1164 with SMTP id
 i3-20020a05600c354300b0040fcb691164mr4801074wmq.37.1707141860231; 
 Mon, 05 Feb 2024 06:04:20 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXnJ5H/hV/bCoKbGt+cIjKyn9RqeGZuVf93wiQHsLRSh5hZfi2FM5ICRF1S+74U7bMjvwXOXd57/r0S9TcCJEkECd7yCsD8JkkiYAAvnyPFz5ERDGAmvDO8lL9bK/fsKMrYismCYHmxgKg4XI1GicoZqWB3NfYZQ9qfXVk2L5ZTSXahvsJbYkuHW8XQrc29afMx/2K643WzVgqBd6KBEjLsusQouj14F/hejVUPqW8NvJkZJpy3uviBgFo=
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a05600c474900b0040fde0ec31esm1339222wmo.31.2024.02.05.06.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 06:04:19 -0800 (PST)
Date: Mon, 5 Feb 2024 15:04:18 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v3 3/6] target/riscv: add remaining named features
Message-ID: <20240205-af844fdecb6d9bfc6a12616a@orel>
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <20240202152154.773253-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202152154.773253-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32f.google.com
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

On Fri, Feb 02, 2024 at 12:21:51PM -0300, Daniel Henrique Barboza wrote:
> The RVA22U64 and RVA22S64 profiles mandates certain extensions that,
> until now, we were implying that they were available.
> 
> We can't do this anymore since named features also has a riscv,isa
> entry. Let's add them to riscv_cpu_named_features[].
> 
> Instead of adding one bool for each named feature that we'll always
> implement, i.e. can't be turned off, add a 'ext_always_enabled' bool in
> cpu->cfg. This bool will be set to 'true' in TCG accel init, and all
> named features will point to it. This also means that KVM won't see
> these features as always enable, which is our intention.
> 
> If any accelerator adds support to disable one of these features, we'll
> have to promote them to regular extensions and allow users to disable it
> via command line.
> 
> After this patch, here's the riscv,isa from a buildroot using the
> 'rva22s64' CPU:
> 
>  # cat /proc/device-tree/cpus/cpu@0/riscv,isa
> rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrse_
> zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba_zbb_
> zbs_zkt_ssccptr_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         | 42 +++++++++++++++++++++++++++++++-------
>  target/riscv/cpu_cfg.h     |  6 ++++++
>  target/riscv/tcg/tcg-cpu.c |  2 ++
>  3 files changed, 43 insertions(+), 7 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

