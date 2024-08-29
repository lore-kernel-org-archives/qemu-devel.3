Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6C3CA0EC8
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjowJ-0002pL-Pl; Thu, 29 Aug 2024 19:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjowH-0002iG-RS
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:52:29 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjowG-0005Ie-Bj
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:52:29 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4fd0d7fe6f6so494650e0c.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724975547; x=1725580347; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPov0ePIZDavdgv5+sjg3OfjxeCncEkEtiOBvSqp6pI=;
 b=F74PKiKKxDJnsGPXAlC2wu52EtUj+QVfJktRFLoD/e3QIi8CMcrlXS501/8996ZJZC
 ViE8vge3vIBHowzUOGNMrLPTCfgEouGfE1/+a8EHZpffRiox+7G/1/ND0R0k0Ja9yUvy
 tPjCcjg5NoWDGq2Tw921Jwb0QIT2iEVImzhNyLHuoajJpGiphURM1lG2pyJdonx7Gu6X
 sDxyGQlGpOQel0YXjX5wHEBeuOTQeSItIP/hDFbPnKGgLiwHxILDl/NFD2RMYcxPs2z5
 L2r4bVyi8VM7fk3xFbJW11P7HBAyxsPUsuFGE3WZcLW0hF4QB7ryNylcd5/l8d+RiXJm
 bSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724975547; x=1725580347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bPov0ePIZDavdgv5+sjg3OfjxeCncEkEtiOBvSqp6pI=;
 b=LJlcKC3VBN9zNI2mAU8BUjZli6QswhpkI13BMOBAg3Ts4O1pieUxj7q2SnBSyoa1Jv
 Edj1xKGWcgmL0MGFxzOlkKbw6sMpLOQaqaKsRsiHKDblueGN8VrXLbWAsE3nEfqArVGe
 CdnNqXC6U6jnnwojor6I0ciyFK6+N+fWe8sXK8pORzTnK/wQtvk+dxc0ZFzHmYU0sKpd
 otij4ra03FD/qprJs7UfWL7uEpV6MrUxLkI3OQzTJCsfDPmSvK+J+JuziTZxw3grKJzn
 tFhxHaPED+hjKrsYxx7pSGp6LxuYi8WwW6dj90b1k8uNWjFFS33Pf9w8To7eyn3RZg8B
 QyCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVzVXEkwi8FT5PVHGpA9fe7eJnZqKEx7tQifh+fE7MInD+1NCYv80LkjR0nRwgjko/hi9gR4uNAAQa@nongnu.org
X-Gm-Message-State: AOJu0Yy11obHi8MHNhnolb4cuSxmBYt59YbEDJR/dyygMG6fBRK4IIqF
 kze9y7ih3eNS7oxabJtmloYx+TXeGLwKlo6AyxNvdOIB0rOvZsh9rxmBoiYFdfcf8JDsqezBtog
 4di/QYRO/XBT27CF9uNf/e4Nde0o=
X-Google-Smtp-Source: AGHT+IEkL2h/gkXjeupeGYt7XMVIubJ4zNojBEJd2IkoKVHmmdWyekY5dvn93AqL/FSuyvobbYZgXbwOXvVDhwltxhI=
X-Received: by 2002:a05:6122:c8c:b0:4fc:e4f5:7f83 with SMTP id
 71dfb90a1353d-4fff169e299mr5030776e0c.9.1724975547135; Thu, 29 Aug 2024
 16:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-5-mark.cave-ayland@ilande.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 Aug 2024 09:52:01 +1000
Message-ID: <CAKmqyKPLk4TuBZbxYFUPN-FJ8itHCYh7erKgJnyvX5k3YRBOFA@mail.gmail.com>
Subject: Re: [PATCH 4/9] fifo8: replace fifo8_pop_bufptr() with
 fifo8_peekpop_bufptr() in fifo8_pop_buf()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Aug 28, 2024 at 10:25=E2=80=AFPM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The upcoming peek functionality will require passing a non-zero value to
> fifo8_peekpop_bufptr().
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  util/fifo8.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 62d6430b05..efe0117b1f 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -116,7 +116,7 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, ui=
nt32_t destlen)
>      }
>
>      len =3D destlen;
> -    buf =3D fifo8_pop_bufptr(fifo, len, &n1);
> +    buf =3D fifo8_peekpop_bufptr(fifo, len, 0, &n1, true);
>      if (dest) {
>          memcpy(dest, buf, n1);
>      }
> @@ -125,7 +125,7 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, ui=
nt32_t destlen)
>      len -=3D n1;
>      len =3D MIN(len, fifo8_num_used(fifo));
>      if (len) {
> -        buf =3D fifo8_pop_bufptr(fifo, len, &n2);
> +        buf =3D fifo8_peekpop_bufptr(fifo, len, 0, &n2, true);
>          if (dest) {
>              memcpy(&dest[n1], buf, n2);
>          }
> --
> 2.39.2
>
>

