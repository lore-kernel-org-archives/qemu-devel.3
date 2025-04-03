Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86003C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 19:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0QGf-0007lu-J7; Thu, 03 Apr 2025 15:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1u0QGV-0007ky-P0
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 15:30:17 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1u0QGT-0004P6-V0
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 15:30:15 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3f9a7cbc8f1so381944b6e.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 12:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743708611; x=1744313411; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pu1Fyhvs9X8jA14NDAXZPHekZZLe3gtvclvJpLpc2sc=;
 b=f3JTsnvHom02hJ8K8QvKK3p8P7gMQ4dJE8+AQFPbYCNjZGf622wbW9ndOwDOtSPCYw
 Qovi3kE5S3H3CAhb0LWw9cVUeoWWMsDSvfPknMl8gep7c2qgfPMDNlAHaeI+m3w6JMBG
 0osGBc24441r/q9jOsXEIHxGKJxXY628ypHmlsUYRDg6XI1eLBHKYiQ9gqIWo49baHAO
 Kt5W/kj7AMsn75Hwke5hyKnNryp/IZy2InuCpaLCC4H/Cninl6ZpiAZ2pV2OvMVs9WZN
 4cLXtC/+vX/LagP1OBfI1WJ3tlSEYSsTJPuTlPD5MtV/HN0uvC0WQRWZM/6MwzjhOD2d
 bRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743708611; x=1744313411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pu1Fyhvs9X8jA14NDAXZPHekZZLe3gtvclvJpLpc2sc=;
 b=jRSz3qwF7wMp+lSNWGDepkkm9xRgmrk1y7DJJEXDdD/Jd7xt3EN2hg3132DGEsOo7p
 SI5HaLis+f4nqznyy5WEvHlDHMgaMEv1qoh9RuLGTZV+edyoH1oZmak+HUsAML2aPHt4
 fY0eLCO5xSm7KHAewTNJCU9qXvKWISOcJzt206vFu1Bq7NLcUqAtYYjeDto7/Zx6mysz
 xHoCzSLlQmHAneIRsSMf0t4yrQ1FXCYdI+PcrQADvCDbgWvgw5njGS1ye8iVX/KvUHgj
 32G+i6h1qAUJit+7eJ4RuRxHQwwBXogaQb5uD3v7EgyokiFkfxH1wJ3vF7rhxpkbl0lt
 WHhQ==
X-Gm-Message-State: AOJu0YwIVgapkzL72iazQ4XnUiD4d7gKb87+8//ZS/ek2MZ6PaM26WKL
 2NN40DPqouIPIHIhabb0rQQxX57PIkdzGWutjk3/2kIrCQVfYz5zddTlYwyljdcLzZMrtUETCbS
 4FAk0se2gH6AHeS9DpHvMYXcIqOMP7LQy
X-Gm-Gg: ASbGnctbdzLrXX8iz07nYk6OHzSJWBzDDPL6T5H+xu1kDSrzGliG9Nx+CL5rrZ7rJ7y
 ABHhtXnFZd2Y9JAejLLpR6en7QpHdDMZjmNIzi8tFGXQGANQAEHaSbEnEQ6Ji3shejDfb4nZzCK
 XdtJ/zwY4wwVtXHxmjYq6WdAE6YCEh+W0v42XyDjEUczzadp6tYaENcR3Qlepw
X-Google-Smtp-Source: AGHT+IGoJe+9oDSvfNS1UOhMz3S4KLJT9hu62HIZQ1JA5afzFTw9zPaA0xmy7zf3RS9Z1SmdOBO7Tmxt+KRW5yhxEks=
X-Received: by 2002:a05:6808:144c:b0:3f4:bc5:d478 with SMTP id
 5614622812f47-4004567ed22mr284764b6e.25.1743708610917; Thu, 03 Apr 2025
 12:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
In-Reply-To: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Thu, 3 Apr 2025 21:29:59 +0200
X-Gm-Features: ATxdqUGh3kLZPThUX8A48JMktz4CSKPVATpPyHX8Sr3XGS5plfRuzjt2UF243UM
Message-ID: <CAO8sHckT2Ko8TTJjzUsX0znafaL_4jp97QCtSxoZDnHow0bEAQ@mail.gmail.com>
Subject: Re: [PATCH] smbios: Fix buffer overrun when using path= option
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

Unless I'm missing something, I don't think the patch has been merged
yet. Any chance it might have been missed?

Cheers,

Daan

On Sun, 23 Mar 2025 at 22:36, Daan De Meyer <daan.j.demeyer@gmail.com> wrote:
>
> We have to make sure the array of bytes read from the path= file
> is null-terminated, otherwise we run into a buffer overrun later on.
>
> Fixes: bb99f4772f54017490e3356ecbb3df25c5d4537f ("hw/smbios: support loading OEM strings values from a file")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2879
>
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  hw/smbios/smbios.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 02a09eb9cd..ad4cd6721e 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1285,6 +1285,9 @@ static int save_opt_one(void *opaque,
>              g_byte_array_append(data, (guint8 *)buf, ret);
>          }
>
> +        buf[0] = '\0';
> +        g_byte_array_append(data, (guint8 *)buf, 1);
> +
>          qemu_close(fd);
>
>          *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
> --
> 2.49.0
>

