Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8345DD41144
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 09:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgJUd-0002x8-Mf; Thu, 15 Jan 2026 04:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vgJUb-0002rp-1U
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 04:18:13 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vgJUZ-0006EG-JN
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 04:18:12 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81f3fba4a11so656181b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 01:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1768468690; x=1769073490; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vSj5BDga0TFqP2p20/d5VAsLxQgWK3a6F1txGxwp6dI=;
 b=CteSutCXtfb/UmVmP776WKiWJP04K5QuQkWkch4L6XUZKLae5jGiEYS2Cvsyb7s4on
 QC8TZ2b2zEUEeNgc2Gzj4k3aObPsHcJ/+5fN3XEe1EI4VI5ZuxwvSPrk0EWo6EkC4GQ6
 ebnF+sxg5DTl/1WCVezcgX6sijD7MQrOVJZuHQ4Vg7UCRvYyhQdgjp57bcCLpQR6lsf+
 LWVwoSIFvG1T7q+dG550VfN1eBCz/MpOZUqNIT6lSc2x4qKxhFy12VXhscyBvvCHe8Uv
 8wu0NZiCnHV9VxhF75EKVhZv9c1G8hDzWA2WzNmPHbtyn7MJPD3EUpCLskKaOG+jytK+
 RYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768468690; x=1769073490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vSj5BDga0TFqP2p20/d5VAsLxQgWK3a6F1txGxwp6dI=;
 b=eiBosDx6mnbQxOIS8mwfCGuh+DRpo/V1+NF/K3RTCWiBMrNTbOfJbWpxQTO7/3EX2A
 BYYjYDfzoiJWkWEV9EcmRhNS4E8bTabuxFKJLjznJtkWZ/FcBBCMzhECUFRdNgHFtt9o
 RI/PEP0tUzt5DhOxitKIAO9n6X++YvFjzvW60hQNPVBGtPbo3n7vds6Y+UTjo8VPYrQq
 XMeTB0a9bkAE7Jedh9+puippP0gIZ6d4a/oHa1Ez5+9NIikXzYsbFB5m3qeaqzRR8VDQ
 TP65jgpvOSptcEaFWlw2jJ37X9b0S9dTSZuafbBm4T3Rx3IeT2iPj5NLJf0tCJzXFOV+
 wZtA==
X-Gm-Message-State: AOJu0YwUDCYu9YgBBblaZJUFyxVBjurfvwLT6FMcfXIL96/M18jHLaod
 DK+XFt9EXwjFkzxsOeQW6aXqJV1szyT6lRZDV0txmdAJaXXsM//s9Si1P/PwrrwDDU0=
X-Gm-Gg: AY/fxX4jYELrPpDGTd1BZ+Nv8uNvlJvZL+HR9s09EI4bMlbKiPIOBzZgd1e8fELBUS2
 irDt/AWBVz4WBfWsyOzOG9hJsDRe1wVzOLPmZlHzNU5mIAeuJ3EmYFmD8Bds11c9tihwJybzo7Y
 O8409IxvZ5zVAWqShrVP8HNQ3s+W1e9jue3JdTqNuEEvnKGlKqcSPYMUgjvYuGATDIhOq2Cu890
 Tz3R3SF7Zrfvg+iGxliKDBw7QxwL9iSkBNapFyE6oACNjVY0TjQrLDxOkiH0MzNVMHsa0ugTiEX
 zWUkI9PSKzNlDz7i7/fQr1AOguWcVm26BBG6GvGxmJwy5x7ImIB1ShQoqXTZ6bWZuD3wmMQt+R/
 +5fL3f4tti+t7/FQtUSHM5U1/RTayX3yIV91JnecIYSOcCXBcMUpiKR2Cg94YqoCr/NVwgnafWr
 qSMILizV/YWWbSIp+/49oqF3q8y/viWyqJ3hev9wCtBQRtbNy++TB4rVONJQhvy3s=
X-Received: by 2002:a05:6a00:bb91:b0:81e:dcb2:52d4 with SMTP id
 d2e1a72fcca58-81f8200e5bcmr5981461b3a.68.1768468690086; 
 Thu, 15 Jan 2026 01:18:10 -0800 (PST)
Received: from sifive.com ([136.226.240.171]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f8e6a972dsm1887195b3a.61.2026.01.15.01.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 01:18:09 -0800 (PST)
Date: Thu, 15 Jan 2026 17:18:06 +0800
From: Max Chou <max.chou@sifive.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 06/18] target/riscv: Add cfg properity for Zvfofp8min
 extension
Message-ID: <aWiwBzeMDXfw8r3p@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
 <20260108151650.16329-7-max.chou@sifive.com>
 <59a65f5a-3d77-46af-aff4-8f490441faef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59a65f5a-3d77-46af-aff4-8f490441faef@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x429.google.com
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

On 2026-01-09 15:05, Chao Liu wrote:
> > +    set_ocp_fp8_same_canonical_nan(true, &env->fp_status);
> > +    set_ocp_fp8e5m2_no_signal_nan(true, &env->fp_status);
> Should ocp_fp8_* flags be conditional on Zvfofp8min instead of always enabled at
> reset? Better for maintainability.
> 

Thanks for the suggestions. I will consider it at v2.

rnax

> Thanks,
> Chao

