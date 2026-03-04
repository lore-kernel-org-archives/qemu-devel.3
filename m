Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CFBEF8FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnpi-0002KD-Ty; Wed, 04 Mar 2026 10:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnpY-0002JC-Nx
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:08:11 -0500
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnpW-0001LE-Gf
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:08:08 -0500
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso6478042eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772636881; x=1773241681; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uDxGOQoiYxgQduml34RYx2J7DdNlEpkK3SApBIxoQ50=;
 b=RfVR+NsNIJBlfMRlDD60ph1YVEW5d01QOPSL0X6eJxQmmjx2g7A/3N2KBe9sP14woz
 t8SyP5mIKQ09SblUIfR56bONrnoCG0Ya3xCza/jdUMUhdAF/KOjkWS2R0yh77lVVjPxv
 04z3oas/iXQyBR/g5MvKUNsBOwdDySLn+pWt1TBr/Ml3mhJoiqJfC4zkv2L8Z9DRhFaq
 uFi9mA2LR7TLRIMTnEURnpYyBZE4XJIByqbhljSjamN0lPMPJoa+f/P1kT+rDsdeR5fA
 EXf9Kkbz71XE64Q5QdjcgCo3pteTmMohyoWCDKl8tgP6gb8BDlzHmYlQDlvjLzY2G2pW
 WPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772636881; x=1773241681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDxGOQoiYxgQduml34RYx2J7DdNlEpkK3SApBIxoQ50=;
 b=fbOviQFlyE9pjLAnquDAKESJ7fdjx8clYEMfiRw3wGhb1yNoR7TzS/n4zzYGbwl31e
 AxbHOe4vjURGYuTKeQHP4aqfdhircZKvDGNONXk/JcQLXQ8BUJIyODIJGE8NspY3rGE6
 4lYsUDSn54+UgBVMgNA7iOJYE/Boq4scW/bd1ETmGbh5GBZMvJVWlS0suerXCDkRTILc
 OD4p7Fprzcwuhbed5BHdnznoqCGlpg6n2p3VT5O/dqlLqpd6VIzwH7Qac0+vKAJ1GqUa
 QKU9mXfq4WZZSIDoMzTBrvMNJEujCdvcwe0Dwh0cQqc8XyzbOP7Gnmgh+w895MuM0YxS
 h9hw==
X-Gm-Message-State: AOJu0Yx6WKwE5W5Ai0nw5S0qi4RNfDNEBiOE3mtkkoPzsoSrXWQPUsKR
 9LavsIcWYv+qD8NOPh2Y96tcezdK7o1Ei+15iSeGt6AEvPdharEBQklX
X-Gm-Gg: ATEYQzwsDTMjNAT7OPXFTF3SPzJMjuTyweyRip3vOSbt0Z7Zcse6NJoBkKmwIymvnaG
 rn4OeP4EV0sjzgwm+OtqCsJ8ZiJJWXcj1GkAjg3s1sHAMb1Nl1ZOb0TwGGKWEZ6a6bekH9nfhrc
 JayG9l381IJ2TrqZu5ttTsr+5YEPOPaFbKrXkyNvbDhbBV8YNHH0z1aqOoEyFWBCvO2dwEE0QY7
 qhi+RKX19hik427D0W6rVxbzs2BnGCcHtk1iMhZMsD+4MvgYh+7zWRFRfvNVaIkq+4ozyW0U8pX
 h1SRmzvFzlRUbc9tqAhmlhqayjJFe9mpqmlW4bJn5G1UbGPyqM2zY7vpS1acnVRvedywPdEbSD6
 D1wjq6pw8LZS3fb/H4bKOnp7PPZj2rb7nVESLwFg/RI3vy0vUP7QahIW05FvmMNQiSLEAUlTpgT
 0OZifh1Xbs0jahdxRJbv//WwkFPlGoznKXcHTtV+rbfROPS2hV/YwpUfW0PiMy/mPpSYmJQAeCk
 /m0xs7xldmmEWkqsbbWsKqzwhDdEWg=
X-Received: by 2002:a05:7301:1692:b0:2be:e4b:60bc with SMTP id
 5a478bee46e88-2be30fefc70mr761199eec.9.1772636880950; 
 Wed, 04 Mar 2026 07:08:00 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f23c01sm15287563eec.16.2026.03.04.07.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:08:00 -0800 (PST)
Date: Wed, 4 Mar 2026 23:07:35 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 10/14] target/riscv: Add cfg properity for Zvfofp4min
 extension
Message-ID: <aahKpkO1J-dABVEe@ZEVORN-PC.localdomain>
References: <20260304134006.2908449-1-max.chou@sifive.com>
 <20260304134006.2908449-11-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304134006.2908449-11-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 04, 2026 at 09:40:02PM +0800, Max Chou wrote:
> According to the ISA spec of Zvfofp4min extension,
> "The Zvfofp4min extension requires on the Zve32f extension."
> 
same "properity" -> "property" typo in subject.

Thanks,
Chao
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/cpu.c                | 1 +
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/tcg/tcg-cpu.c        | 5 +++++
>  3 files changed, 7 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9b98e18189..03eaa12028 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>      ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>      ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXT_DATA_ENTRY(zvfofp4min, PRIV_VERSION_1_12_0, ext_zvfofp4min),
>      ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
>      ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
>      ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 59302894af..353a932c36 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -104,6 +104,7 @@ BOOL_FIELD(ext_zvfbfmin)
>  BOOL_FIELD(ext_zvfbfwma)
>  BOOL_FIELD(ext_zvfh)
>  BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvfofp4min)
>  BOOL_FIELD(ext_zvfofp8min)
>  BOOL_FIELD(ext_smaia)
>  BOOL_FIELD(ext_ssaia)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index ba89436f13..b1097e55a3 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -715,6 +715,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (cpu->cfg.ext_zvfofp4min && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfofp4min extension depends on Zve32f extension");
> +        return;
> +    }
> +
>      if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
>          error_setg(errp, "Zvfh extensions requires Zfhmin extension");
>          return;
> -- 
> 2.52.0
> 

