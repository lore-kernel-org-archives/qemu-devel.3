Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE77E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8j9-000825-TP; Sun, 12 Jan 2025 19:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tX8j6-0007ra-9k; Sun, 12 Jan 2025 19:54:44 -0500
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tX8j3-00032N-Q8; Sun, 12 Jan 2025 19:54:43 -0500
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4aff04f17c7so3059701137.0; 
 Sun, 12 Jan 2025 16:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736729679; x=1737334479; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKziCxKEZvmGVoKSzZlgWvLs3ZtkNvBSB1Ne8OxhzuA=;
 b=cnX/Sjzb4tEuPytTeQ2qK3MLqdY6OYaW6xLJMW6NkamWOmTFgjrUOoCiqNSR5ZlVNX
 Zan4CiuGFJfRIuyCjvgY7FqQ5m5Ci931pPoau33n4tdjjhjKgRVGRvT0AJ8YGPJk+ZSS
 430x1ipJiy21dGrC2e4eVzfUIjbRDi35CeOK7+isTHpJlfDPONkClFY2tZK2/0RgXCjj
 7GRvNFrgARbZjgNbozudLlmh4o5wqVLifV7N9N+4bwqyqmCj5XggZzgwFLrFa3RjU+7w
 NAzft49VK2HEwL6OWswr67hZRXrgCtqTfgRwccHxWT7PRoEniBZr4xHwk86bgPf2u4tS
 O+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729679; x=1737334479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKziCxKEZvmGVoKSzZlgWvLs3ZtkNvBSB1Ne8OxhzuA=;
 b=Hu+YbknHkrAeVqv1ztT8FlXFQAQ7B57qn6KDvIwnRdmrUeasRRcxoZBtRe+KOTVQZV
 q4kdgSmfku+6fVsUVBOG1rwQQFfglhbfiv8kZwhek0Z1vMuICw7CL6dh6cZZ0FOzeOBr
 dB5lTT3l7Njp0lhqn8qlT9VhJWAleEKoQ/UJQ7i/Ey4KCp1DCusHZuf2cQGBPDYZHsSB
 Jv0iFiycUKx3Yu/f7/Y6lDJfpCX6vGjsMmcMRYWtTf85BQrCPoCs1jcr7jqwedLBygma
 bRv2E30nrzad6pUUa96SRcJ8Jkt/yn/tgsw6LuHTzKjbkkD9YKpl7KpuBaYYW/X7SaVa
 xKqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjrZ/JX4BD4iBjKSrLKdGqkW3ZKwV16dsHZHjxYmu1OhoBUTEe/I/fCFURQ/f27AmICDAO/g09y1Eo@nongnu.org
X-Gm-Message-State: AOJu0YxwL1Cx63XVH517LqRIYdJ6TIdCOS6pB7DJDnwIcLWcvamjCp3j
 BJnxtlxZwquX+Z8gtyq1rBiVuc05YQiEDYabSEM2CPVZYvvc/C7yDnTl3XuPTD0iHufEj9KS2xy
 aCcWGw5c6TuoafGcWYWN0JV4uWgc=
X-Gm-Gg: ASbGncs+m4HLSVNYVyHGVTjmndT5r8jlL4urJrSNbm4xjPVKs+8JOOn6E/AjGhE+rIX
 AL620sjPVuE1NqOz4OvtuOl2d7+OS+LrIuY9kOQyhlivEaX+BVtlwLbJEu1GkmlBNJiY=
X-Google-Smtp-Source: AGHT+IHqGuMGSj/TwH2qheBlFvFScQy7P/uT4wZf8HLPYvNER4JA+GmbuJkRjhjgV4hH9KfV/rCGTBq9NKsu7+5QnXI=
X-Received: by 2002:a05:6102:5112:b0:4af:cb0c:390b with SMTP id
 ada2fe7eead31-4b6092d86d7mr10044318137.7.1736729679261; Sun, 12 Jan 2025
 16:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20250112231344.34632-1-philmd@linaro.org>
In-Reply-To: <20250112231344.34632-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jan 2025 10:54:13 +1000
X-Gm-Features: AbW1kvZUuJ8fEQ452Rxjq0TJEciBshr_d1C8kmlBobMauJDhfR6xCwKQZcgZZ8g
Message-ID: <CAKmqyKMVFA6O_CunASBspYtuV=rfTckss=wNZHnAfr0XjfePDQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/riscv/virt: Remove unnecessary use of &first_cpu
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Jan 13, 2025 at 9:14=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Pass RISCVCPU to kvm_riscv_get_timebase_frequency(),
> then access the first vCPU via Virt::Array::Hart[]
> rather than the &first_cpu global, which is going to
> be removed as part of the heterogeneous emulation
> effort.
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   target/riscv: Have kvm_riscv_get_timebase_frequency() take RISCVCPU
>     cpu
>   hw/riscv/virt: Remove unnecessary use of &first_cpu

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/kvm/kvm_riscv.h | 4 +++-
>  hw/riscv/virt.c              | 2 +-
>  target/riscv/kvm/kvm-cpu.c   | 4 ++--
>  3 files changed, 6 insertions(+), 4 deletions(-)
>
> --
> 2.47.1
>
>

