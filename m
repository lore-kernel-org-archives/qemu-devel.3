Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E72C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIEe-0002hT-F1; Tue, 06 May 2025 09:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCIEc-0002gm-Je
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:21:22 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCIEa-0007Hp-RU
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:21:22 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e731a56e111so4791072276.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 06:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746537679; x=1747142479; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qsOJ6RiZETL6qZFBxc1blmCwCUn7EGIAVwx88TXfxTs=;
 b=wzTfX2jyErqNZuV927SLiQmP5+5UfDWwxCsOglAErhPQuvVRfGU/RlR0Pkk78C44FK
 FpV053Eg85Jh3Q+A9U1bDCGSK3fsFxrktgvXZm2tN+G8XmvqiAhYNWuJdQjHRbcEJPdF
 PQdr+GAEcQkbqakrQFSsg956ng3SVlzBNzCPChY6EiSkXDohwuV7mcAwvvkWfx22GYAh
 /o60PcldplZ8ZIrwobsgzIAlD2xrD/u7t0yhqhKxq3AaXHM/f+zUI9WkScu/xHLTQKJF
 h6sYhfba/gzaVYi5KLtkswqwkzyuKbq3ZWvKmTXwcWQQ7lKVPO8Q0WQG8hn689io8pdN
 GqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746537679; x=1747142479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qsOJ6RiZETL6qZFBxc1blmCwCUn7EGIAVwx88TXfxTs=;
 b=OT0G0vkBUBFJ5pkTBpEaYdvQm+fpjdE2byIVHrk+PEO3DAvH3eITIFap11Fi54QDG0
 nvQaKAVmBf1JuOj7DpwgKDYhcoEANwn/FlickIWb69wOKq4J6g+xeJRCszkAf2AebTj6
 96bJEFYbg5gLkutsEMVl9OISiKvv/C+La8BFa9wg7FhN7YDO/LpHi35Y8P+X8lzHlGK0
 pIOf1NRida8z/AqmdZfrJrV6QWuLJrQWet89gVLJJkHJfw8RUzSx/qgHl1+4GyktyJIJ
 HiobFKAhQ7vCr4vPe0lRx1SRrj7rS4CSYtZiD2Nwo1Y+cvy4d3dDRkNGRYVJ8JuXvO++
 f16w==
X-Gm-Message-State: AOJu0YxyNQ7i3hw9VJPcwQ1KUPc7a4ZfOa37vd4oYzuHUVoK6RWfAk2T
 Xpl/vtkEBY+mMDeRs44tLf6CrSZUy7uZ1Zh0X1ns4+uR7blhZUihNBhk4+saFAQV2VJm53igtaw
 bI8+2tYWxrUlVrR0BgCpaLM+ypMSgbRdd694XMw==
X-Gm-Gg: ASbGncsJ6ZTI9jTz31WI5lRSXJEu6ta/Tm4YK6z4PfeCtR1VInY0zWP2D4CQNnjgpQg
 ULGgWAhMAbhrf4QuKuBGym1W2xGaQ4okwnLOeC0yJO+7YxmOf6KUvvei35bwgTNdNcW5VMcl0it
 eDwNjxxswfD/22c0tvp9RVXkw=
X-Google-Smtp-Source: AGHT+IEoxKQf3KZ6nPGN/iRJrEQbUml+UBYPKPGS6tM57l/BXvlgZJf1G5bIRnRM0b6fkTYXwL9AmrEssJnvE+wJmX4=
X-Received: by 2002:a05:6902:188b:b0:e6d:fe4e:2fea with SMTP id
 3f1490d57ef6-e757d2e7cb1mr13449368276.22.1746537679447; Tue, 06 May 2025
 06:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250505222236.1616628-1-komlodi@google.com>
In-Reply-To: <20250505222236.1616628-1-komlodi@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 May 2025 14:21:08 +0100
X-Gm-Features: ATxdqUF_g-z3wSHZSzZG2W_Afo8bmCqHWDgFArRKJdgE3jmkS_dtQWDyuAxe1tQ
Message-ID: <CAFEAcA_65vRzAp1DzcZSDPWG+vX1C6xuh_2afdHqmXVFKZADmg@mail.gmail.com>
Subject: Re: [PATCH] system/physmem: Fix UBSan finding in
 address_space_write_rom_internal
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com, 
 david@redhat.com, philmd@linaro.org, venture@google.com, pefoley@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Mon, 5 May 2025 at 23:23, Joe Komlodi <komlodi@google.com> wrote:
>
> address_space_write_rom_internal can take in a NULL pointer for ptr if
> it's only doing cache flushes instead of populating the ROM.
>
> However, if building with --enable-ubsan, incrementing buf causes ubsan
> to go off when doing cache flushes, since it will trigger on pointer
> arithmetic on a NULL pointer, even if that NULL pointer doesn't get
> dereferenced.
>
> To fix this, we can move the buf incrementing to only be done when
> writing data to ROM, since that's the only point where it gets
> dereferenced and should be non-NULL.
>
> Found by running:
> qemu-system-aarch64 \
> -machine virt \
> -accel kvm
>
> When built with --enable-ubsan.
>
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> ---
>  system/physmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/system/physmem.c b/system/physmem.c
> index 16cf557d1a..ccd2b50da3 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3204,6 +3204,7 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
>              case WRITE_DATA:
>                  memcpy(ram_ptr, buf, l);
>                  invalidate_and_set_dirty(mr, addr1, l);
> +                buf += l;
>                  break;

very minor, but I think the buf += l would be slightly better
one line up, next to the memcpy(). That way we keep the
"copy more data from buf" and "advance buf the corresponding
amount" next to each other, rather than separating them by
the set-dirty operation on the MR.

Anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

