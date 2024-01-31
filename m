Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F13CC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 13:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVAmE-0007jS-58; Wed, 31 Jan 2024 08:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rVAmC-0007j6-H6
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:37:16 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rVAm2-0003K6-Fo
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:37:16 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-556c3f0d6c5so5623242a12.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 05:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706708224; x=1707313024; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bDJUctVkT3kWSnnDrCsTNbNMrF3paLp+kZxKMTN3tds=;
 b=fC8LCcmOKzyk9zSFYC/DCOezyXSndRFRvvBORR5Y1jndWEG85Mgz3HF6QHUT7yxLh+
 vXlYek8deW+pSshsUuJ2POvQUID7jZeXkGDnUo0vUxyHmEBizXHyGHlXrW6ZiY/t9Dcy
 ALzIuYkCqJ3PDeTjZ7bD1ePPMkK4P3k0EU9kcVGZsui9PijuvFCJwIme/WDvhNlJeciY
 bMKgJppduhYztnSLMZgYXx6klExuqiF1r6IxoHCXyihaI+V8DzGE/GB4OwYSKWLxOPdq
 H2C7CAeUiMmVtA1Xab+nsY13ENkk3OGhDfIpEcy/x+9fuajdptc78flyztXqGAfE1C2J
 z/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706708224; x=1707313024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDJUctVkT3kWSnnDrCsTNbNMrF3paLp+kZxKMTN3tds=;
 b=YQMMhTmASY/5EQ17Mk8b6wjQMKlvVcYN8qbveJYVfcpBmGDv8dzsZKnoW9QUIr/dKY
 y85rNQgWAgDN+Y8uk7e63giTF+S6mR+KMc9xseIThsbfEvd4OH88rOADvaniYdG6fYK9
 B0qcHc5I46jKc+gT5q92FGEGmAF5GQtB2AGv6GfPUGFD+ufHlTLomW95fAp8zB6p2rwE
 DUHEkG36qiCJtt3/PU2g42RJ2ZjIj0OwkBNqOW/p6me6SiF+CqYsNs2IiqWfwO3mV6Zb
 GcjkU2qbXRe3MsigUdKRSZLcyvPX6xW16601dqIhcl0oQzoK8KzduH3NtT6AzRQC7zSE
 s/xw==
X-Gm-Message-State: AOJu0Yz4/QAxeYrFYW5R/wUUbxxiI19EZpDPsXC2ibNY5IgZKqx3NLtt
 eLSSKTWoCriboifJ27OZtEv1yZVBzvYUcrt72RQiM3l9WETeGO47TU3rVsSCSbo=
X-Google-Smtp-Source: AGHT+IETPlPd+BGVm8MKG3dx+zA+kaEVGYvBspH9LeYe/FPvRST06jnTTsUNWtC7oiBm2RLYfRZaYQ==
X-Received: by 2002:a05:6402:1751:b0:55f:3f35:32c0 with SMTP id
 v17-20020a056402175100b0055f3f3532c0mr1107774edx.4.1706708224587; 
 Wed, 31 Jan 2024 05:37:04 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW9+sk4bWKb6sfC4ZEBTaRZbgPqaB6ZkaCC1FM6k01Vw+5YhTUFHCVofonnb3B9IRIy/uYqSPjQ0b84PwDf+Cqn2yTCYnbEZI4tY/BVRQqX8QjK1eJBEdtX2iieITc9bOdHmRGyDCAP46LQswxMdEVFejxoGItujQowtI96S79gQywd/yk+gWThReB7CxXPvMGUSP3G7wOBKC/9JD1voyEuORmq4el7goEjwxV4CV7L5RugD0UqHKR4A9X3US9g6Cck1ySE4pu+odcy1/yRELCeW68Zpmn32crP
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 di11-20020a056402318b00b0055ef0105f2fsm3592215edb.80.2024.01.31.05.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 05:37:04 -0800 (PST)
Date: Wed, 31 Jan 2024 14:37:03 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Vadim Shakirov <vadim.shakirov@syntacore.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH v3] target/riscv: mcountinhibit, mcounteren, scounteren,
 hcounteren is 32-bit
Message-ID: <20240131-51b46f334e960edf8a24ba17@orel>
References: <20240131123624.230982-1-vadim.shakirov@syntacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131123624.230982-1-vadim.shakirov@syntacore.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52f.google.com
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

On Wed, Jan 31, 2024 at 03:36:24PM +0300, Vadim Shakirov wrote:
> mcountinhibit, mcounteren, scounteren and hcounteren must always be 32-bit
> by privileged spec
> 
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
> ---
>  target/riscv/cpu.h     |  8 ++++----
>  target/riscv/machine.c | 16 ++++++++--------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

