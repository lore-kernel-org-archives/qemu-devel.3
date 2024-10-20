Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020D6D3C931
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 03:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2MQe-0003kb-I8; Sat, 19 Oct 2024 23:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1t2MQc-0003kL-FY
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 23:16:26 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1t2MQa-00066R-B5
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 23:16:26 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7180cc146d8so1724038a34.0
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 20:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wshooper-org.20230601.gappssmtp.com; s=20230601; t=1729394181; x=1729998981;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+EzQKM0C21mkbG/KbFED96iC/QZkZcYych3KJy0fVM=;
 b=JQIs+u3Z0KyyYnxGHsm11SefNOsZBt+JkObt1ZyY2383HUpl63anQhO9WlOhgLKLNm
 npvJJgQaJB+Vvnjqzu4fsG+Tqtl40x7SdcKogyMhIy9iW/NQ1E6fRNBbwXmFzzq+bIb2
 NR7r0XU3XqgCxZnbBFsFAhcMhzafGUYiTUqMCz1Ea0deYw9mIwCLr45+KpmJuHdYtlB5
 V2U3kzsOThTMfX7FyDZfWVqdVq6PSka18vhb3SQprZWE6LPFIzNQ+HVneOF35LJMMaEQ
 r/kjAY8HhsLF8T5DAj15R39QVT/bdn0DJbg0N8Tiu27BHBWbTyu2MVux8Qkgmc4KVdAc
 fU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729394181; x=1729998981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+EzQKM0C21mkbG/KbFED96iC/QZkZcYych3KJy0fVM=;
 b=B2gWmCcPUb0WB20KATBls0GXGNEWiNx9Jq0lOtSJO2MkQiXTeanNatsSlP7zjdgToV
 p10NtaSurYXvxepVJgi12jJr8ROSQ6NGMHdmtrxtip5I0OF2OvK+UVY1VBC4F9vK+UTh
 MYL7WhfF29a9RsAmCoXlU3vJjZjLyfjDnbXxlBD0Zqi0kX32rCPjUSPy9z3yO4yzU2ST
 EMyu/2R6EJQIfmZQuz/6TVxb3oiiX3jiE4J0OSaphMxYdZEHmi8VN5v/x64h1X9zw/oc
 In8ofp82AdASk+9wlh/QEXijQnCvCLvH9zaEtdburxzMuYyUfXBH/F3ZTM+a3RXUYhZ7
 Z8ug==
X-Gm-Message-State: AOJu0YyOL/XGEj2q3cqVyQDFG6n7ndifmAv7gh3gkYPRW1nt6I+fVZW8
 B2ymQQaydWKzq/bV8U6A0CUA2a8QVHME7zIgktKMsLww/ZLTd9dZ5MsNaOQ1QRJnlH8uSjymoFN
 Ar+4j+BqKqBwxTnZfU+R7vEyF8O5vF+uc94ZsZRcK16/4nJyM
X-Google-Smtp-Source: AGHT+IG9rPj/Q8TXBXU4wkEH2LdqYlpaz0ZWid+rPBQww8+W3E+zdNtJDM9HQhM9PnSK9uLtIlhggOrXAyihcgO/6Ug=
X-Received: by 2002:a05:6870:ac12:b0:278:466:77dc with SMTP id
 586e51a60fabf-2892c49ea47mr6180450fac.35.1729394181361; Sat, 19 Oct 2024
 20:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <CANto9c6QV-KAuUau_CqK-rVsyNB=42HQ3AHuQPn34yMs2-iPkg@mail.gmail.com>
 <20240818063344.6969-1-wsh@wshooper.org>
In-Reply-To: <20240818063344.6969-1-wsh@wshooper.org>
From: William Hooper <wsh@wshooper.org>
Date: Sat, 19 Oct 2024 20:16:10 -0700
Message-ID: <CANto9c5u+-Wg+XPxu4CCEE733MuXJbL35nWgTEPxk9y12PH7mA@mail.gmail.com>
Subject: Ping: [PATCH v2] net/vmnet: Pad short Ethernet frames
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=wsh@wshooper.org; helo=mail-ot1-x336.google.com
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

On Sat, Aug 17, 2024 at 11:33=E2=80=AFPM William Hooper <wsh@wshooper.org> =
wrote:
> At least on macOS 12.7.2, vmnet doesn't pad Ethernet frames, such as the
> host's ARP replies, to the minimum size (60 bytes before the frame check
> sequence) defined in IEEE Std 802.3-2022, so guests' Ethernet device
> drivers may drop them with "frame too short" errors.
>
> This patch calls eth_pad_short_frame() to add padding, as in net/tap.c
> and net/slirp.c. Thanks to Bin Meng and Philippe Mathieu-Daud=C3=A9 for
> reviewing an earlier version.
>
> Signed-off-by: William Hooper <wsh@wshooper.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2058
> ---
>  net/vmnet-common.m | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/net/vmnet-common.m b/net/vmnet-common.m
> index 30c4e53c13..bce1cc590d 100644
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
> @@ -147,10 +148,25 @@ static int vmnet_read_packets(VmnetState *s)
>   */
>  static void vmnet_write_packets_to_qemu(VmnetState *s)
>  {
> +    uint8_t *pkt;
> +    size_t pktsz;
> +    uint8_t min_pkt[ETH_ZLEN];
> +    size_t min_pktsz;
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
> +        ssize_t size =3D qemu_send_packet_async(&s->nc, pkt, pktsz,
>                                        vmnet_send_completed);
>
>          if (size =3D=3D 0) {
> --
> 2.37.1

Ping?

