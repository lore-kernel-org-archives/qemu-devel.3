Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74C2606A331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hEkxWiZO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAw8-0000eW-Or; Wed, 25 Nov 2026 06:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWAw4-0000eC-Ro
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:13:13 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWAw2-0001oJ-QC
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:13:12 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b335eeb340so49279367b3.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:13:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795605189; cv=none;
 d=google.com; s=arc-20260327;
 b=hE+w828pKjds+qHfq+ty7ED1rOADleYmD3K5p1Cy0H2t5R7UgytYFkCz2NnJ1fxQdn
 HhS1HhExqAUNPeG51H6X4uvUa2WR1kINGERLof9o8z7eKeOd7TrnzDbi2A96He7qmcUa
 8scjvM1mPHcpCIGPSlPaEREA4mEuWO/wR7LZcgsEvMDQQoABhsE+m2NLQdg4q/3F7LcB
 Q8Jjs70cPNTdtZ3UNlwWZ0CToB/nXuGKXIUKatAR12KAOFQX2h3aB7iXoMh0xj9sA/Zn
 8IpC8+FWyxUh/IRa3AeEMDFzSPu5CWncOnl1qaFC/AWnVZjSGkOSY+dc4Q2i055McZ6X
 2Zgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ihh6WnWRIocBKgcvDm9qFXw+Cpz7VST8Al0SLo1uv0I=;
 fh=6CE8jxAqEF526HSqlaLPR86Lv+HXvioeH5JzMC05K3U=;
 b=mTucwjVgZ1EuuBVN2VzrvuJcrBAwy1+LTCejmCChV3R6+44NNbItz0eEFYLmSHH1Jx
 PsexAzHVPGrA5JPi+fZ2bBDs7yzzMKZkytK6nh7SMArxE72Q1AVtD5Yo4cdAyP7PVUpI
 +JVUtgtR6MECrvkhDhlQYYYZMH1fdvWLDBGxwJu2xUrjlOmaM/IBEb2MUri3NeD5QVmK
 veVVs3zOmtvwEBpUn0E5ZBHnFA8pl/kCwx31nlTbMdfJbMTcD5Th3apt5cvy6emSxaqX
 kVlffgBYkPLeo7OZWbswG/X41l06VgEnYqfuDXquc5WO7Dr8VylQaCoWLWuTBGzoB4Jc
 Tu3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795605189; x=1796209989; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ihh6WnWRIocBKgcvDm9qFXw+Cpz7VST8Al0SLo1uv0I=;
 b=hEkxWiZOMfei2e+M0uwVNH85ELSeOyQkBZfaLOl1l5A1RWZe8dKpsOdKz+3vjzWd/s
 uP+eiU4E1l4wvWMIvRNPDjgECqffTZJklVCczK5zGgtqyUitUbZXpeWq5IsXqam5Rcs+
 vgWUr6b9xwEZYmbwx+f9zCD5UT0M/GsT/Dhhe9YfclfL2LL5jOtQEjuUIIcBk29n0vYg
 0BeTzuGY7FKWO1Vwh54wXpVcPGVoMtlmGkkY0ok5EIwi8aAEMO6IhFKBrRJF1XJ7kTi4
 9TfYaguL3gX22h09rmCG+YLIHeHHnHTbyaPEDSXH0PQw1jgAIvStFt4tASxmY49rbsAn
 PHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605189; x=1796209989;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ihh6WnWRIocBKgcvDm9qFXw+Cpz7VST8Al0SLo1uv0I=;
 b=x920wUqh4qD+4P+CQzZKwCpNvIt6PFIAAeBnt+90D3TO+g8Uld1qrrvVxes/7HTMcZ
 h0/p/c3O/ul/tkUx9F0XryPx9CPlViSfFBpcWoLQ3v5+Z1ZV2aOyLn2tSoxa74Bfhqkn
 k/gALtrcJItiVyuEEb5xK6ajdM9Fq92vSsilpkC1sgVIX7e5dIlA4rxLdLH7qCO7GyY7
 LuMVGwYUHjIuS6EyWMMAwPWtkyqi8PRH/lBkdhGXVjCW35raPC2RQtmjGpSQUHJ15dz/
 Elu8MYgbqyP+x70zvSF60CVbqoxrh6euSO3UMX7wpushCLnYcjAcGrnq5j69iDmVAeGr
 iaWg==
X-Gm-Message-State: APuU4Z9mipS+LmKOzHUrjT7v7nlZgzFlENwv4W+n+uKk9E8fqT6l/Ehe
 4r5gp5oW9ulhtKNu+SG0fjS6xmUx6aqhBvnGRbcDu8b6jXYOEibzcWJ0cIR39EQdUDTkOHbiAE+
 of8uoLS3kBK60Y41L282GQjaGmFtepomjw1SLsjC2gg==
X-Gm-Gg: AZFdTZc5SjjgUxh2KHeVquP4UgtHELVnEoS1gv2NRElxMrwe7yRIwS8DTvaMxhyxYSb
 sbA7JXoVvkpkF3br2iZfn5tBlrAXeZ2/82z/erLJ5zJqDgPNK24EY8LjAZAGJz034RCd1xqJq45
 TO6wlEZetqJX+AJeG0V5iLlQqGUxpiqpG7wIfV28aBB1BCZfomubWS1lzt6kfvvRKHoVcY6qj/m
 db+oNTHHIqI8DzSqwhTA0BFBezNwo4JSuhO1JKJA/Rux/78tjMguM6P33CtgnVswlGHsfrmB346
 aXjw5l32o2PDfmIOSdI7VXtZOJssUcjEAW19TyS69uy6+D4bQ69sAoZ+KiWm3i1q/50FifdE0Kp
 NNSW3EqqI+ELR1Bf8u3Vnx/wrwt/3ioWMDTh/WGzD+qEM79zLJfGNNp6brnj5OT4VbrC/TWS0wI
 wLgBxLJmI8t7AWuRueQSli
X-Received: by 2002:a05:690c:2a83:b0:8b3:5a91:61ce with SMTP id
 00721157ae682-8b52031b979mr65446877b3.13.1795605189336; Wed, 25 Nov 2026
 03:13:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-4729-out-of-bounds-rx-interrupt-idx-v2-0-cd18eec4f369@gmail.com>
 <20261124-4729-out-of-bounds-rx-interrupt-idx-v2-2-cd18eec4f369@gmail.com>
In-Reply-To: <20261124-4729-out-of-bounds-rx-interrupt-idx-v2-2-cd18eec4f369@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Nov 2026 11:12:57 +0000
X-Gm-Features: Aa3M54pGUCij9R_PRZUSylgSTCv4fmR1_nDsttx1luQ8Hb4-gdgTw-g6k-hwvwM
Message-ID: <CAFEAcA-vsrPyJ3dPZokqSZhTkdpv0haDDtB0v5DyVYsu83A+wg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/net: at least one TX queue and RX queue
To: Andrew Nguyen <xmphyr@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Karl Mehltretter <kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 at 04:35, Andrew Nguyen <xmphyr@gmail.com> wrote:
>
> Require a VMXNET3 configuration to have at least one TX queue and one RX
> queue.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4729
> Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
>
> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
> ---
>  hw/net/vmxnet3.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 58bb7fb869..875c998d63 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -1367,15 +1367,13 @@ static bool vmxnet3_validate_interrupts(VMXNET3State *s)
>          }
>      }
>
> -    i = 0;
> -    do {
> +    for (i = 0; i < s->rxq_num; i++) {
>          int idx = s->rxq_descr[i].intr_idx;
>          VMW_CFPRN("Verifying RX queue %d interrupt index (%d)", i, idx);
>          if (!vmxnet3_validate_irq_idx("RX", s->msix_used, idx)) {
>              return false;
>          }
> -        i++;
> -    } while (i < s->rxq_num);
> +    }
>
>      return true;
>  }

This change is just undoing what you did in patch 1. Drop
that patch, which we don't need, and just make the
change we do want:

> @@ -1384,17 +1382,18 @@ static bool vmxnet3_validate_queues(VMXNET3State *s)
>  {
>      /*
>      * txq_num and rxq_num are total number of queues
> -    * configured by guest. These numbers must not
> -    * exceed corresponding maximal values.
> +    * configured by guest. These numbers must be at
> +    * least one and not exceed corresponding maximal
> +    * values.
>      */
>
> -    if (s->txq_num > VMXNET3_DEVICE_MAX_TX_QUEUES) {
> +    if (s->txq_num <= 0 || s->txq_num > VMXNET3_DEVICE_MAX_TX_QUEUES) {
>          qemu_log_mask(LOG_GUEST_ERROR, "vmxnet3: Bad TX queues number: %d\n",
>                        s->txq_num);
>          return false;
>      }
>
> -    if (s->rxq_num > VMXNET3_DEVICE_MAX_RX_QUEUES) {
> +    if (s->rxq_num <= 0 || s->rxq_num > VMXNET3_DEVICE_MAX_RX_QUEUES) {
>          qemu_log_mask(LOG_GUEST_ERROR, "vmxnet3: Bad RX queues number: %d\n",
>                        s->rxq_num);
>          return false;

This part looks correct.

thanks
-- PMM

