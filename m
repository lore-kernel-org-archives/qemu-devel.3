Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C51C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 05:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF64w-000718-Dw; Thu, 06 Jun 2024 01:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1sF64t-00070n-P2
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 01:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1sF64s-0003rI-11
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 01:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717653260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2KJi6HZ+9K2s9dFyDCHddJDpiY9oMPJQjUcygCVeK/Q=;
 b=iFMO9Jc+CnNa5tMDEASlDrCP+GCKoeCgpBkd6G3+jJ4KHiQ5Cou7gt1iyzmMGyE6JydAdu
 rAGTQDRx1rcmakizjSHgqiNANdZAnsjl19D4kRiwhFmSrmBZw5TxwYwG/a556yU69yhWkQ
 /2smTw9QB0DesuV3SRhI9xPdIIEVIDA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-9x4KtIhhNQOPiJEpS7N4ww-1; Thu, 06 Jun 2024 01:54:18 -0400
X-MC-Unique: 9x4KtIhhNQOPiJEpS7N4ww-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2eaac984495so8290081fa.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 22:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717653257; x=1718258057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2KJi6HZ+9K2s9dFyDCHddJDpiY9oMPJQjUcygCVeK/Q=;
 b=MxJ4kF1/39GKSMpIw+fmDWl5c4oV2J1JHEYW8geiZblHgqvBVpHgiOKsiFqXkKXSTZ
 mNcmQVMQv26cWufATBDC2zmj3ScFpl2/IvcHu5aMtPeNc4qf715WX8vTSn0LSpqdaAqD
 3DjPqEUfV+gjyGzWogTldfOrqr4xzD+kh7479D/jjSYsWJzN9ju99LIlz4OqzLXXY1su
 SUncH43OaWOh4smc+oQdrGdk9iBh2rGYFD7QBlBxL2uqHSxNA1zIG3tNRp1vH1w3YlmK
 /+uOks2UUDMdCWVAA7cNTAonTMw0czMD5BlTf6tlMAHxAS8yCHd/XlxJrhb34Unr9GF+
 hftA==
X-Gm-Message-State: AOJu0YyA4z8f77RodUpIsc2fryfss7xvOeclQrla9cxp/ZJ5bNlZZUi0
 2DsdpOu34xtOCJpp3QCIrGPWaPabZr4U1VKX5f/PJR111o4V0d6fSdoOCIM8/xza7ZS4UijuHpV
 J2yDxOST7hmPT+v5PDes9LPcFDLLYx6SIn0E4Sny75Tv7/SLX0HDCYcvxNRU5DFibsrFb0Do/RS
 WbJfXdtiIsnal5YanKC0xS0WQl/d4=
X-Received: by 2002:a19:760c:0:b0:52b:90f5:4945 with SMTP id
 2adb3069b0e04-52bb2199373mr420546e87.27.1717653257156; 
 Wed, 05 Jun 2024 22:54:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH+xYNtLFIdddqXAcHP6m7gPFh4W4eyyC9ghq8OVf7f8+XxAu0Lvx9rQUKG9sEExi1E9w+FLuzuI05+G/Fkm0=
X-Received: by 2002:a19:760c:0:b0:52b:90f5:4945 with SMTP id
 2adb3069b0e04-52bb2199373mr420542e87.27.1717653256617; Wed, 05 Jun 2024
 22:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1717584048.git.mprivozn@redhat.com>
 <b5b9f9c6bba07879fb43f3c6f496c69867ae3716.1717584048.git.mprivozn@redhat.com>
In-Reply-To: <b5b9f9c6bba07879fb43f3c6f496c69867ae3716.1717584048.git.mprivozn@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Thu, 6 Jun 2024 07:54:05 +0200
Message-ID: <CAMXpfWsuaZXcKDrtwqKOTyiMg7DDoJsE1p3_1mwg1Xp8tfq7sw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] backends/hostmem: Report error when memory size is
 unaligned
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch has been successfully tested. Try to allocate some 2M
hugepages in the host, then boot up a VM with the memory size
unaligned and backed by a file, QEMU prompts the following message:
qemu-system-x86_64: backend 'memory-backend-file' memory size must be
multiple of 2 MiB

Tested-by: Mario Casquero <mcasquer@redhat.com>

On Wed, Jun 5, 2024 at 12:45=E2=80=AFPM Michal Privoznik <mprivozn@redhat.c=
om> wrote:
>
> If memory-backend-{file,ram} has a size that's not aligned to
> underlying page size it is not only wasteful, but also may lead
> to hard to debug behaviour. For instance, in case
> memory-backend-file and hugepages, madvise() and mbind() fail.
> Rightfully so, page is the smallest unit they can work with. And
> even though an error is reported, the root cause it not very
> clear:
>
>   qemu-system-x86_64: Couldn't set property 'dump' on 'memory-backend-fil=
e': Invalid argument
>
> After this commit:
>
>   qemu-system-x86_64: backend 'memory-backend-file' memory size must be m=
ultiple of 2 MiB
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Tested-by: Mario Casquero <mcasquer@redhat.com>
> ---
>  backends/hostmem.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 012a8c190f..4d6c69fe4d 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -20,6 +20,7 @@
>  #include "qom/object_interfaces.h"
>  #include "qemu/mmap-alloc.h"
>  #include "qemu/madvise.h"
> +#include "qemu/cutils.h"
>  #include "hw/qdev-core.h"
>
>  #ifdef CONFIG_NUMA
> @@ -337,6 +338,7 @@ host_memory_backend_memory_complete(UserCreatable *uc=
, Error **errp)
>      HostMemoryBackendClass *bc =3D MEMORY_BACKEND_GET_CLASS(uc);
>      void *ptr;
>      uint64_t sz;
> +    size_t pagesize;
>      bool async =3D !phase_check(PHASE_LATE_BACKENDS_CREATED);
>
>      if (!bc->alloc) {
> @@ -348,6 +350,14 @@ host_memory_backend_memory_complete(UserCreatable *u=
c, Error **errp)
>
>      ptr =3D memory_region_get_ram_ptr(&backend->mr);
>      sz =3D memory_region_size(&backend->mr);
> +    pagesize =3D qemu_ram_pagesize(backend->mr.ram_block);
> +
> +    if (!QEMU_IS_ALIGNED(sz, pagesize)) {
> +        g_autofree char *pagesize_str =3D size_to_str(pagesize);
> +        error_setg(errp, "backend '%s' memory size must be multiple of %=
s",
> +                   object_get_typename(OBJECT(uc)), pagesize_str);
> +        return;
> +    }
>
>      if (backend->merge &&
>          qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE)) {
> --
> 2.44.1
>
>


