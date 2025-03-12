Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31900C28B30
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 11:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsK2E-0002wT-Tb; Wed, 12 Mar 2025 07:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsK2D-0002po-0N
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 07:14:01 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsK29-0007n2-Ty
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 07:13:59 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso5639577276.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 04:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741778036; x=1742382836; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhzZB3cmCvqy+v6KBzdJC1uQTQ0w3MoyiUQS6HJITl8=;
 b=mG7jyZMNLPfOEzZv/JOcSrwPcSMY8rGybIU0LD7Pkmu93K0VXWbhg1S5cU9ZX+ltab
 wEZ5VTUxMjEwxd/3jNITBfR6cVOJfI/WRf0YcRVWpV+/7ztp7T3Qipm/uIBkV71FhtCh
 NvdQWZ5DtJYBPm6kx+Mo+DZGqF9wMW7K2WJJSHNHTAOeOsgG3pMUR/QAfyR7ZzGZZr/m
 c0OWX9g6uk3A6BNyA93C8nLv7QBa5PQ6L28OECfH8JeSfyipOObzppY1xkRvgu+FqwO6
 cWFIpp4Xjxl74uira3bfj2R/VGx7xEb2Sd/cW0J2gbeEJgaGrk5Gx119UUUJBbqQHllu
 +stQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741778036; x=1742382836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhzZB3cmCvqy+v6KBzdJC1uQTQ0w3MoyiUQS6HJITl8=;
 b=p3YFoCPZYJEkYxHcHNP6f/Jd8Kdxfu4Rlk/dOvwJ4r6uRKLB/MCkZYsP1QXHZbbsDT
 1qPXlsuHFmZaPoy3pTzR1LPGQzOJodSv982SKl1N0X6Tnmpv/lr1JV7LY6cDntaHduY7
 x0Qt62IL/NvxN3W2AUVfQ8Z7FV9/HsPw1/Y/DAYapZflgYnVs6z8UtROmkoZCqtDJCR1
 fAwyFLawh5zL+kc8UnHN856S9V8h9n06RrU7eBlvhOaSr3SZoqf/NSCuAkTyPc9akGtK
 pAveuq3g1WNSgCXVX5FvmuEfPuCAEZa7AvxGqa98VvJsBIXiTZOmXklimR+CGlRpn1iL
 Xm0Q==
X-Gm-Message-State: AOJu0YySAb/n1XAqv9+O5cNgLC4CGE9pMIqVUnzULQVu9uP2Xtmwp17V
 wlW8YtU/Mgm6vrIk2QvQd7fgccybc5BaSnhO29wbbBqzN77V9f7gFUrZkBUjF2jqNMrNNMZsCQW
 azK62l41OFhK9LUtpacQqst8KJ52uNRnfufL4Dg==
X-Gm-Gg: ASbGncv06H14lOdO+P6G5Q+mOtIHSrhfKlrdoW/T/ElkCso875vzjYl7c+8OZdSSr9R
 PqSi0Wx1VQDVU46ldbTXBwNawjRqpIeGNdBTNPEn5zW7DHzg9AZPsPd0SDgBwvhBEBUZbZmOngP
 Qusi6Dk63pnUzS853ZEjqdq3QaAeQ=
X-Google-Smtp-Source: AGHT+IE/ZBLwSu76pVIObIiyVtV9SxruaUTP4iIDLHmgLyTbnKmKApSKsklsgHNCAkt0dYW6GcjQiAD3zgSW3qR2jxs=
X-Received: by 2002:a05:6902:2a8b:b0:e5d:c6e8:2e32 with SMTP id
 3f1490d57ef6-e635c179f67mr21203049276.24.1741778036002; Wed, 12 Mar 2025
 04:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250312104821.1012-1-philmd@linaro.org>
In-Reply-To: <20250312104821.1012-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Mar 2025 11:13:43 +0000
X-Gm-Features: AQ5f1JoAta6Q4X12zfwZQgZSgicS89Jl6oI4HLAaekQPl3jhjy2waOywjSSNCPE
Message-ID: <CAFEAcA_EL1M3ajqmJq8CO-t=q4KmY1z3UYiciCsKAmWWbCBe2A@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 v2] hw/arm/armv7m: Expose and access System
 Control Space as little endian
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Tony Nguyen <tony.nguyen@bt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Wed, 12 Mar 2025 at 10:48, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> We only build ARM system emulators using little
> endianness, so the MO_TE definition always expands to
> MO_LE, and DEVICE_TARGET_ENDIAN to DEVICE_LITTLE_ENDIAN.
>
> Replace the definitions by their expanded value, making
> it closer to the Armv7-M Architecture Reference Manual
> (ARM DDI 0403E) description:
>
>   The System Control Space (SCS, address range 0xE000E000 to
>   0xE000EFFF) is a memory-mapped 4KB address space that provides
>   32-bit registers for configuration, status reporting and control.
>   All accesses to the SCS are little endian.
>
> Fixes: d5d680cacc ("memory: Access MemoryRegion with endianness")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

