Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4155C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4KEs-000233-KP; Tue, 07 May 2024 08:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4KEX-0001sy-O8
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:47:52 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4KEU-0007Qj-Vy
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:47:49 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f055c08220so1278633a34.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715086065; x=1715690865;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QkjYhKuYckqGXBqljz5veNVkb5zgtVOQY6lxKhbYcGs=;
 b=w6mQS6WY05HDhKrLA6n2VM8GeKhg6C30T/VRlIPnpPAtRYKhRtEBDowJwhKCDN/qNo
 XwbiAyJZb9jHMBB1f1EgL+xeKvHpsnr0LcVGSH3HlM++LotgjxiQiWCYmREbv+IAQ1HU
 hWAxMEDV5RIkFfNwK+gkQ2ieFHBxIvGc4ITVNzictJuS4m6MIcSOQFCSBwsnoVIsArSf
 iYxaax/7cAHKqZxFazQUXSYj11aq0eUgtjxVoOlIprnDaGwof//XP3/w97UJDNTRWabz
 J2GLSxRJ5R9th4TQPPdDi25hdEp8HfOlwQgz9M1Y8jbX9PTFCfF9K0kcwLcrox6zK2D/
 jkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715086065; x=1715690865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QkjYhKuYckqGXBqljz5veNVkb5zgtVOQY6lxKhbYcGs=;
 b=TWqDU5DIZbw+i8Bxd88+qxiTzG/p3K9qR+7piyCVeRDuBKvkrrK7JMXY7Mm12hHfw3
 wfk510SaJaFVUALIOg3FqfwFA4nKdSAD8ijQTL8QOCDiHpjp1pNa+IdB1pkinaxj1NgE
 gwaNVY4pMersd+wUw+aVIdK5JFFwpSkfgbvCMBPSemsgh1enSHGl5FZHrSua5HIoDADh
 8lbUDoE8FVBnPxn0xHGLfKPTfDdmffkn7MFtPfl8ZS3BbjKQdvZ2lvrCvsLZpWn25Eui
 LJQdGRgnegcSWqG1seYRhoIaczzlrsa8VvVDkYH8NKzYn5UwoGMj8ah80oPceds6I9nt
 V6tg==
X-Gm-Message-State: AOJu0YwkqK9cdOmPAhZFBDWtMbhnPpQluPftmShQiLo2EA1EoJYUvJqy
 QtRo7JUfRpQBiZLwHQdo4nyg1wryOPRngA2Sujjr3a4Gti2vSlF8aaFa1uGQAfLPI4lWz3C5GJZ
 sXFTCAG8it0ZiRwo2E3WsOZF6MCGtuYUD5YC/Bg==
X-Google-Smtp-Source: AGHT+IEmRmGvsBpU7t9bZrF3oNv2N/7Udb0clIMBuqlPD4dOkNBcAPVG8BbuE9mRZd3hFwDxwmR8N1FKxNUEqBi4CHE=
X-Received: by 2002:a05:6870:658d:b0:238:f93f:66b6 with SMTP id
 fp13-20020a056870658d00b00238f93f66b6mr18630955oab.29.1715086064315; Tue, 07
 May 2024 05:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240507123025.93391-1-philmd@linaro.org>
In-Reply-To: <20240507123025.93391-1-philmd@linaro.org>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Tue, 7 May 2024 14:47:33 +0200
Message-ID: <CAGNS4Ta9aV7ch5DCdMe=Pk3eB_3+0xx8fCekvuiAPb6hz=Yx_g@mail.gmail.com>
Subject: Re: [PATCH 0/3] system/physmem: Propagate AddressSpace to MapClient
 helpers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, john.levon@nutanix.com, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=mnissler@rivosinc.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, May 7, 2024 at 2:30=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Respin of Mattias patch [1 split to ease review.
> Preliminary use QEMU_LOCK_GUARD to simplify.
>
> I'm OK to include this and the endianness fix [2]
> if Mattias agrees, once first patch is reviewed.

To be honest, given that this patch series has been lingering for
almost a year now, I'm fine with whatever gets us closer to getting
this landed. I believe Peter was also considering doing a pull request
for the series, so you may want to coordinate with him if you haven't
already.



>
>
> Regards,
>
> Phil.
>
> [1 https://lore.kernel.org/qemu-devel/20240507094210.300566-2-mnissler@ri=
vosinc.com/
> [2] https://lore.kernel.org/qemu-devel/20240507094210.300566-6-mnissler@r=
ivosinc.com/
>
> Mattias Nissler (2):
>   system/physmem: Propagate AddressSpace to MapClient helpers
>   system/physmem: Per-AddressSpace bounce buffering
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   system/physmem: Replace qemu_mutex_lock() calls with QEMU_LOCK_GUARD
>
>  include/exec/cpu-common.h |  2 -
>  include/exec/memory.h     | 45 +++++++++++++++++-
>  system/dma-helpers.c      |  4 +-
>  system/memory.c           |  7 +++
>  system/physmem.c          | 98 +++++++++++++++------------------------
>  5 files changed, 90 insertions(+), 66 deletions(-)
>
> --
> 2.41.0
>

