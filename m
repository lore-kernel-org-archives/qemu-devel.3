Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0681E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 21:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSMwz-00080T-0j; Mon, 30 Dec 2024 16:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1tSMwx-00080K-Jc
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 16:05:19 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1tSMwu-0003yi-At
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 16:05:19 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ebc678b5c9so5153458b6e.3
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 13:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wshooper-org.20230601.gappssmtp.com; s=20230601; t=1735592714; x=1736197514;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKjdsaPS3xJtqeOLFIP5v+KOIOi47TAq2JhucXWfrl4=;
 b=oehMaGYo9mtQDIlzpxi6tf/xmEZcD4Jirp8FBXbO+pJ2kkrZfJZogZRm10/RDMjIh9
 KaABvvBBVDUs7ANOwenuB89mMpzh2pv+fDW/xutQF43gzIYqsLpNihPJHuq2EAyAKGVt
 K5o9nZ4rSW8BQ5O69l/+t+qx1XksncEQ6BW3YRSgLGu+3zMV4bakI+3Fq5xg3O/N1gp1
 zuxvvNw93cPqsq42ltZt6G9snSCJHYnwmtKcc2cKozL0A0vUTN6epIfAAkg8VrbVXaDv
 VCE2VsouK3oY7GSDYr5S7ltliuxul5ZCg+vpnRkyI9WgaHIe4Cjkf2vB+ODPQxpLXIU+
 hHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735592714; x=1736197514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iKjdsaPS3xJtqeOLFIP5v+KOIOi47TAq2JhucXWfrl4=;
 b=w2MUip3S6lzqjd0QAtKrhONVGxg0gf2ww/VogX21OU5rqSiHbTPG3GAn3pk3ksLUM1
 mq+HMan4jPbs+dCRNjqbO7oQ075vt6ihMj4O4Vut/Wg+qABcvHKwUHVqgzHhwbVNWno+
 jBhRzk9QYOFQeztrEZ7QLj9aSHcVQ/MQj1ydaVT4XIxbsbna/TZF8fnMUctJXG1x9UL/
 aNRlS8CCxi4zjS8QGS5ikC6a9xKdFSGvXG9+ODhFyaOVtR84O80lfk2FlPyoOxDhlT0x
 +l7d9QhcpsxmYfemcyD8dP03JM5tEP4/gEqDGOFYzH/exrBXGRBRQWdebNGf+BX5+ARv
 uwwQ==
X-Gm-Message-State: AOJu0YxoJC7rfCdZRk725zP29orabxG4ZGQ+MyxUkc4U66RFLKCdrlwf
 jocA94DzeXi5wIbBPxkECBiOXVcs7LjchhZkWQz5K274Lsa6HtZ2rZTxJbQ8dlVtbbuocF1cvtq
 1FzeAKGo7QEC2PhXfYAJ10yYH0fEMyrAVe3YrHJ65rDLWotSezfk=
X-Gm-Gg: ASbGncvrMsJ41IcjqfhihNttmIu37PS7REyjjHdBs/0VWdP/zFnOnFkM5hLC2VKeLel
 agPbdgsyh8tcCD6JG9sZirA1PGIZD2aSodrih
X-Google-Smtp-Source: AGHT+IH2Kfa7tjqecFKtX0zH3fcXSjKdx/e9hfTIEBaZMkR39kaOZ9K2BaghCWdhfvCmHpBQB8cfV62NStiMOJH8OiE=
X-Received: by 2002:a05:6808:23cf:b0:3ec:d34f:4c6f with SMTP id
 5614622812f47-3ed88f3def7mr19699147b6e.15.1735592714365; Mon, 30 Dec 2024
 13:05:14 -0800 (PST)
MIME-Version: 1.0
References: <CAGCz3vsusRSsT8-Fi3a2Z4aeQMtxCzDZ73D8ZgefxVZvm=qY6Q@mail.gmail.com>
 <20241102205653.30476-1-wsh@wshooper.org>
In-Reply-To: <20241102205653.30476-1-wsh@wshooper.org>
From: William Hooper <wsh@wshooper.org>
Date: Mon, 30 Dec 2024 13:05:03 -0800
Message-ID: <CANto9c7n-vZmTDV=eKTTNVN+JA_PGyar=KbibtLhvmfHf8xYkA@mail.gmail.com>
Subject: Ping (2): [PATCH v3] net/vmnet: Pad short Ethernet frames
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Phil Dennis-Jordan <lists@philjordan.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=wsh@wshooper.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Sat, Nov 2, 2024 at 1:56=E2=80=AFPM William Hooper <wsh@wshooper.org> wr=
ote:
> At least on macOS 12.7.2, vmnet doesn't pad Ethernet frames, such as the
> host's ARP replies, to the minimum size (60 bytes before the frame check
> sequence) defined in IEEE Std 802.3-2022, so guests' Ethernet device
> drivers may drop them with "frame too short" errors.
>
> This patch calls eth_pad_short_frame() to add padding, as in net/tap.c
> and net/slirp.c. Thanks to Bin Meng, Philippe Mathieu-Daud=C3=A9, and Phi=
l
> Dennis-Jordan for reviewing earlier versions.
>
> Signed-off-by: William Hooper <wsh@wshooper.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2058
> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>  net/vmnet-common.m | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/net/vmnet-common.m b/net/vmnet-common.m
> index 30c4e53c13..4b7e330c05 100644
> --- a/net/vmnet-common.m
> +++ b/net/vmnet-common.m
> @@ -18,6 +18,7 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "sysemu/runstate.h"
> +#include "net/eth.h"
>
>  #include <vmnet/vmnet.h>
>  #include <dispatch/dispatch.h>
> @@ -147,10 +148,26 @@ static int vmnet_read_packets(VmnetState *s)
>   */
>  static void vmnet_write_packets_to_qemu(VmnetState *s)
>  {
> +    uint8_t *pkt;
> +    size_t pktsz;
> +    uint8_t min_pkt[ETH_ZLEN];
> +    size_t min_pktsz;
> +    ssize_t size;
> +
>      while (s->packets_send_current_pos < s->packets_send_end_pos) {
> -        ssize_t size =3D qemu_send_packet_async(&s->nc,
> -                                      s->iov_buf[s->packets_send_current=
_pos].iov_base,
> -                                      s->packets_buf[s->packets_send_cur=
rent_pos].vm_pkt_size,
> +        pkt =3D s->iov_buf[s->packets_send_current_pos].iov_base;
> +        pktsz =3D s->packets_buf[s->packets_send_current_pos].vm_pkt_siz=
e;
> +
> +        if (net_peer_needs_padding(&s->nc)) {
> +            min_pktsz =3D sizeof(min_pkt);
> +
> +            if (eth_pad_short_frame(min_pkt, &min_pktsz, pkt, pktsz)) {
> +                pkt =3D min_pkt;
> +                pktsz =3D min_pktsz;
> +            }
> +        }
> +
> +        size =3D qemu_send_packet_async(&s->nc, pkt, pktsz,
>                                        vmnet_send_completed);
>
>          if (size =3D=3D 0) {

Ping?

https://patchew.org/QEMU/20241102205653.30476-1-wsh@wshooper.org/

