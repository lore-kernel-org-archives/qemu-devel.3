Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCDFE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 10:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKx5P-0001hZ-42; Tue, 10 Dec 2024 05:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKx5M-0001fd-IR
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:03:20 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKx5K-0002qI-54
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:03:19 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cec9609303so6195118a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 02:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733824995; x=1734429795; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHtBJ1CyMF+d9PDXK0pVFkHTD5t+GiBT31e85uHZiiw=;
 b=O5xY1wmhG8J1RETGrXFQbbYegMBvLW2QupEK1+Rsz/zjc1pg+QD9JvV5SpL28kkwsG
 lh6yRSesJ8JrkGdmbgmQg3GhCfQpGKO1S9ZwTNQiSxKUKjjb5dPHhc1z+kPim/Tb9JBM
 abfLJtZmZP/wTaoglH5AI5ujiTkW006UfqXT2VF8TvASSii3dp6oKNAUEwpSqyX/zd/+
 jmb3vxm4rxByccGOLFxDFxHJgv/oqVBq4dRN98Q+8K3jc4J9hl0Adv+kbj4Bk+v0dPHM
 Lv8O85NALVWbdpsjq4xCvfiWABDQFQhv5rKnJ3zl3XLs//WnwFXo+TZVbDAkUC9GvCPF
 XrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733824995; x=1734429795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHtBJ1CyMF+d9PDXK0pVFkHTD5t+GiBT31e85uHZiiw=;
 b=qpXvIp4w1UVTeYAqw3jVutpoikAIunzuQI9OLVDBdNaepH0DfxDDzsoHAj6xR+4ysR
 msIoQHY200KUvJu7TE8IHHEKRFjg18qcPAz99YHdsZ9wzL6174sJjJKK4umFfdFfTraf
 +VLl+LjEJ92eMZtDP19v+OyhqWMdQ8WSkBd1oTWtnlgjB+1bs19WYdOfDHADoIpwpP8B
 jQ6BDyAXFiun8nQTnMKzOQMekwAruT5QymC+FGioIse6VyLxz2WbZymdPMirgBU2cQui
 nJodNAUZ/hvNW6x3yvNMVCkzE9T8U2s+a3yAk8ax7ma/cZmL6+ADKUjsmO1wMbfYd6Q6
 6Fkg==
X-Gm-Message-State: AOJu0Yw5Tb92aIsPiXmqdWTQM3bSmVcyxoP8ryuoR06igqFP31Xatv/5
 3GHiZwQ6KzqohYzWchjkFXy41kMQGzWhJQq8VWj/jY0xaQCBcLrBjuwevMvlb48vkjfWAIInWi4
 wqim8z6lXvKE4XKaAETvEyi2SEPqbOoOFKQSbOA==
X-Gm-Gg: ASbGncsLVvdkwpqT+uASr1xrtxevPMIj9I7cx2AUnRmUhvS2yAY8PZ58uRqDv9ApcAc
 219Y02zjLw5tJh8bQlmbVnPg7kBR8Aq7x6t+4
X-Google-Smtp-Source: AGHT+IG6FaHDl/8b8C7W2kNvdayucCtfadlY98Tl5MJaQydmGsLfy9RMFX9reXrbaMarEdQ8reU0PKsaa7Bcm31vB0A=
X-Received: by 2002:a05:6402:4305:b0:5d0:9974:7da2 with SMTP id
 4fb4d7f45d1cf-5d3be6c6220mr15900881a12.19.1733824995505; Tue, 10 Dec 2024
 02:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20241127191914.34146-1-philmd@linaro.org>
In-Reply-To: <20241127191914.34146-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 10:03:04 +0000
Message-ID: <CAFEAcA-H2kS0GdXpDpA3mFm1eOZnudZCn8REYNo34+PsvimfmQ@mail.gmail.com>
Subject: Re: [PATCH-for-10.0] system/qtest: Access memory using
 cpu_physical_memory_rw() API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Wed, 27 Nov 2024 at 19:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> There is no vCPU within the QTest accelerator (well, they
> are stubs doing nothing, see dummy_cpu_thread_fn).
> Directly use the cpu_physical_memory_rw() API -- which
> amusingly prefixed 'cpu_' does not use vCPU -- to access
> memory. This reduces accesses to the global 'first_cpu'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  system/qtest.c | 42 ++++++++++++++----------------------------
>  1 file changed, 14 insertions(+), 28 deletions(-)
>
> diff --git a/system/qtest.c b/system/qtest.c
> index 12703a20455..a2de9a7d5a4 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -18,6 +18,7 @@
>  #include "chardev/char-fe.h"
>  #include "exec/ioport.h"
>  #include "exec/memory.h"
> +#include "exec/cpu-common.h"
>  #include "exec/tswap.h"
>  #include "hw/qdev-core.h"
>  #include "hw/irq.h"
> @@ -514,23 +515,19 @@ static void qtest_process_command(CharBackend *chr,=
 gchar **words)
>
>          if (words[0][5] =3D=3D 'b') {
>              uint8_t data =3D value;
> -            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIF=
IED,
> -                                &data, 1);
> +            cpu_physical_memory_write(addr, &data, 1);

I'm not a huge fan of this, because cpu_physical_memory_write()
is one of those old APIs that it would be nice to see less
use of, not more. Ideally anything issuing memory transactions
should know what it's issuing them to, i.e. should be using
address_space_* functions and passing an AddressSpace.

If you don't want to use first_cpu, then you could use
address_space_write(address_space_memory, ...), which is
what cpu_physical_memory_write() is doing under the hood.
The qtest protocol assumes a single address space anyway.

thanks
-- PMM

