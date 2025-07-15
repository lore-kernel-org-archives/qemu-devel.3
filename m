Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D2BC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubcZ7-0000xf-9E; Tue, 15 Jul 2025 06:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcZ5-0000wS-Qq
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:07:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcZ3-00029L-JB
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:07:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4560cdf235cso15127925e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 03:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752574026; x=1753178826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ptqoZ55tBMoXVh25fn85EYsaDzQkgTXiiNRuyERDgz8=;
 b=AIgy6UManHrCULZC/+NRaTXrX+cN9J+4d4uyOUmvFB8YkwEatGohG612uoX4UQAUlq
 CGO3SgdlaKZ9lC0DmWQP4f4ukLAsY6bZxulRNXpdfbLBB3RhQ2fAiFTOdkoVjDymrb6w
 oeP8mvVpp3CIvmg8tYsuurg/dZrMIp2hH1uCiqnVi1FmArQSRpEcrzri0bpe3uONllSB
 GfKfYFr1zleVS+SXdOyzv/GZOJ+m0EVAEwQqrO5S/W2+Wfmzq9tvhVoPzA7Zovmco7Dq
 HUQKYpyd08FW2GZovnMnyiFAXLEWQ+07aG4o4wUG0qwpDfIjIOFqQpqvKaCMhN5jkTeB
 cQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752574026; x=1753178826;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ptqoZ55tBMoXVh25fn85EYsaDzQkgTXiiNRuyERDgz8=;
 b=t2Wv7X6PUwPlA7v5UaUblrH9WQIyLmn10gcNME4ifo95re3dX3GeivFivwII7QJPmn
 jj183o5MvrIGA3wccfJB0CbgOfDGfJzhR+WNxj6joXcpuZbujPEOy4w8efDxdl+KjDJ+
 ZC5MLPGjW+WjKO+oBDiirwontZEDq8XZ1DBiXVja7frHnqKUjMezGlCE3Z5RN4BcUWZK
 k9TcRudahHvuvaFu0Zb0cOmJ/jcrgDvujMWZzXRwDTzkCdxua8Qzov6wHZmeLLD01yQT
 QR9u71QF2APIHPN7TJEV61PSz5VXvruzdleWPJOPmwZ1sTIXVfZeMDSJZDgQYEe5/e0e
 D22w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKahENo63JZqCzDMI+S+riTJPFF+qgRHHXY/mI6T1EGMAaFevbx3TWM86DepGZUGPBrKQFgt3qmwcW@nongnu.org
X-Gm-Message-State: AOJu0Yx3qMB5qa4Dx5tMAmwm7lE7UQFjdHWlZ+qeOuIHPChT63QmTMM/
 MPNzdeHooIv2dNqimBlLFkdSp8+bfC0dAXXhYCR0RhyV9wrzKq4JwAriz9+dOBKGhB4=
X-Gm-Gg: ASbGncstpdz0iUuDExRURuOWAuwl7WRc+xD+5KPVYywYBsOy0wd6ebOO/dO4FlFVrW3
 Kqq0ouVDc3iAZzYV0yL3yIOtOAdTLgInaub24TOf85/V3nkM3svT5oEHfoSFmw/m48XyLiXFJzM
 s79t3NzQjuEysPtLcAgn/B1Wm49Te3d/KnZXy0wO0jeOciiPCpNQz2AmsQVXBLjxcKX87P4l+uN
 9zn3RTpVkV+IVbwT1ZYW7fkknYclRxTf+r3f5qjgeUVT1feuzOMT6LAsjOMSwjfVUpxdd4o6jlk
 UhRztIHsVrktyuPIWGShI2nuA6vPZFfMujpy6fSiDALlfxwx8gFq0PFVkP3cWYMQTcuAn3/fCAD
 qHwO3Re7CdkxI6MuHYepZq1reFKuJ6LBlQPWkmvgRUtJVlAtBp4gFFETB3jFbESv+iRmuUiE=
X-Google-Smtp-Source: AGHT+IGqlyJq9r+9hdMszPNZErV7UUPsxvoJwXbZnrbRMDALKSxJrgeIzroJ/hNrv7olEEb2cwvz/Q==
X-Received: by 2002:a05:600c:1913:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-4561a16064fmr78933425e9.12.1752574026151; 
 Tue, 15 Jul 2025 03:07:06 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14e82sm14792905f8f.71.2025.07.15.03.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 03:07:05 -0700 (PDT)
Message-ID: <97a9b456-9983-4c1f-8fb2-5bba94c95655@linaro.org>
Date: Tue, 15 Jul 2025 12:07:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/11] hw/riscv: Add support for MIPS Boston-aia board
 model
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
 <20250703104925.112688-10-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250703104925.112688-10-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 3/7/25 12:49, Djordje Todorovic wrote:
> The board model supports up to 64 harts with MIPS CPS, MIPS GCR,
> MIPS CPC, AIA plic, and AIA clint devices. The model can create
> boot code, if there is no -bios parameter. We can specify -smp x,
> cores=y,thread=z.
> 
> Ex: Use 4 cores and 2 threads with each core to
> have 8 smp cpus as follows.
>    qemu-system-riscv64 -cpu mips-p8700 \
>    -m 2G -M boston-aia \
>    -smp 8,cores=4,threads=2 -kernel fw_payload.bin \
>    -drive file=rootfs.ext2,format=raw -serial stdio
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   configs/devices/riscv64-softmmu/default.mak |   1 +
>   docs/system/riscv/mips.rst                  |  25 +
>   docs/system/target-riscv.rst                |   1 +
>   hw/riscv/Kconfig                            |   6 +
>   hw/riscv/boston-aia.c                       | 484 ++++++++++++++++++++
>   hw/riscv/cps.c                              | 187 ++++++++
>   hw/riscv/meson.build                        |   1 +
>   include/hw/riscv/cps.h                      |  75 +++
>   8 files changed, 780 insertions(+)

Patch is too big. Please provide the CPS as a preliminary patch,
then the Boston AIA board, then add tests for this new board. You
can find various examples in the tests/functional/ directory.

Regards,

Phil.

