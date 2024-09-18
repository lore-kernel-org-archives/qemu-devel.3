Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5B7C3600F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 06:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqnob-0007S0-Jk; Wed, 18 Sep 2024 02:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sqnoY-0007Qe-95
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 02:05:22 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sqnoV-0000X0-Af
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 02:05:20 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso81973766b.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 23:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726639517; x=1727244317; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t5mGxf+CZ3zZYnX4JbiIfh5pZ7tAjdTRZMOnJjviD4c=;
 b=LF18ZYDNAnD49KmiYHK2PM5WdHqmXbq+00n3vApQiA3H0u+Xz7CcbIgqoa8GhoPYn8
 5bmYqUJVUXKRN4hPOSY8xXCNZmQnUFEUI4HFNojDszdTg0BfwDg7VU9MsTcZqCIYt2iF
 XWFLPG4hQSBlSzQbA0rHh+zmhyxpECUYVFXgFjq4qL0h6ldoNmcZKdlNkXyyucVTnMnd
 EPylH4vKGt9mPz2jtI318qBIwzZ+ZHPxRgVh6Cz5d0NFUAh2Njk6Jvra0RjfqhBOdtpe
 a6i2eEVQKKgH33q3VW63gxjXh8CYY2X2ht20Kd626D9WC3xQmAUh2m1isKP6QPiR77ux
 Zgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726639517; x=1727244317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5mGxf+CZ3zZYnX4JbiIfh5pZ7tAjdTRZMOnJjviD4c=;
 b=JRb52/Gxl28jPoiI5rYL6ur8TxRTzotHh38v63f16qnYtZoIVqvxvN/heZMhlGFZkd
 AA5Hfs3EgqyM18tkaXaBivfvKadDs3LxHDCT/HvACOYYwJXjz2r1OmLRGIz8rjRABysf
 VFFHPm2exK35/ojkD9oGqZvL/9R5pNFvRzUUSB/RJRXWamnSf2szuhZ0r1HTOJQ7+rzM
 qpvmbBovr1q6AKIhQnmp7ESm0/S5dB5m7YTDOIsGqMeO8kXMTUN9pwfe3J3B8X38YucY
 JtHcjtS7CwfRyslmFo80PsC/XF7kcuWr6xAl6lZXwOLe6mpKzEMg4CIpjRsWHnS9Yoj9
 aOUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU41xBbNKkdIMi0X04MGqbyQXMlLhc8tH1JN6Bg3tZ+XYKI2DW5Ow8H8A2T1ozwT+7Sr42tCYVc6+Kz@nongnu.org
X-Gm-Message-State: AOJu0YwipXMe++Fv3V2fM5mvJEo/OgCLcE9FHWb2mCOVd9L7aoWGer+9
 P6FSi9cX4TiPpk1MSrxtNg4J1lG0is9FQxXz8fVEnNhwkpGiYvM1WjByFAIF6/s=
X-Google-Smtp-Source: AGHT+IGHKR0qqgSX96tsaPbrMvlFd8LcDl6wWuDi67U5uzQHtG4PPaURsQoSA0G1nXDghe6Ahz69jQ==
X-Received: by 2002:a17:907:7ea7:b0:a8a:cc5a:7f30 with SMTP id
 a640c23a62f3a-a902a8c26ffmr2252797466b.25.1726639516625; 
 Tue, 17 Sep 2024 23:05:16 -0700 (PDT)
Received: from localhost ([213.235.133.41]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9061096aa2sm536689566b.35.2024.09.17.23.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 23:05:15 -0700 (PDT)
Date: Wed, 18 Sep 2024 08:05:13 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
Message-ID: <20240918-039d1e3bebf2231bd452a5ad@orel>
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel>
 <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
 <20240917-b13c51d41030029c70aab785@orel>
 <8b24728f-8b6e-4c79-91f6-7cbb79494550@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b24728f-8b6e-4c79-91f6-7cbb79494550@canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62a.google.com
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

On Tue, Sep 17, 2024 at 06:45:21PM GMT, Heinrich Schuchardt wrote:
...
> When thinking about the migration of virtual machines shouldn't QEMU be in
> control of the initial state of vcpus instead of KVM?
>

Thinking about this more, I'm inclined to agree. Initial state and reset
state should be traits of the VMM (potentially influenced by the user)
rather than KVM.

Thanks,
drew

