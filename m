Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA556CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSVA-0007VG-Vs; Wed, 10 Apr 2024 03:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1ruSUm-0007Pf-Kn
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1ruSUi-0006ZQ-A6
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712734540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lrLayFUfoZ0ymDtj9HUjpsKQGi5aMTuDCsxyMoqv16A=;
 b=iKcAD/qqP4JEEw9gbmiDmhp4dMMBXcP6bIsBMJoHrz3XWlZlxZ7p5xr5FHGBkHv+wTJJHs
 BygQj/mbWZ78o23XaQKBzSXxcHD9Z+rwd2rXpd0jm1PK6jk9YwHlKp05iww95edps/ewPV
 x9tMj/pL/FzQXPVgQ2F8WxhI+QuOFvY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-m5uC1wmwPCWv8NoTLv2yuQ-1; Wed, 10 Apr 2024 03:35:39 -0400
X-MC-Unique: m5uC1wmwPCWv8NoTLv2yuQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2a5c5e69461so431537a91.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 00:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712734538; x=1713339338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lrLayFUfoZ0ymDtj9HUjpsKQGi5aMTuDCsxyMoqv16A=;
 b=iN0t4Xx9LaIeV/spfElWH7INXELZ5pmvz50qqup5NwDg21RX+XJ7RlftldIANoyABh
 Q2l7TishjCOiMFnvbT+/5g65kMP66NmA5BfDTF0awV86dI0AxroGZF7jydRiOFVRsEiS
 npg7O85juUf1dYDHvQTfyDvs1zhFiauQd6QIYlbhThUAbOTK2c1k70JTLzRCIZVukB0g
 79T84ZvJ88+rQyRd+NAzzE89D+pRSKX4W8GJk6AzYkvVdwUxKhI6BaCmjmKOvdGm9JFJ
 5cgPXsZqGRVvukUVj9gh/CnNTff+Dw3JYOQqlDeIWSD3kTaRZCabACyi7Eze+5e7iQgb
 XTGQ==
X-Gm-Message-State: AOJu0Yxpi/RrZC1UoEgKNzH+rrIB91lXhw+HvFW5YVJJx4ecbk+wUzfj
 fXk5nCp4rTU9Na7wnqMor029bDgQvGyZdqC8GM894b1K9+0sDbzke6plLaD6i3dRroe0v2l2A3Q
 EYhgD4ATeuf8dWw7f68UTrnpv8vz4lbm6safJZiutjDWrx5v0uFOFXFf5ssH6pLLx7nmAyH1trr
 XhC+OhQkiZk3FZ2sEWtJfhOIxU+oh4KZWit09bvQ==
X-Received: by 2002:a17:90b:243:b0:2a5:e1e7:b98f with SMTP id
 fz3-20020a17090b024300b002a5e1e7b98fmr385072pjb.5.1712734537981; 
 Wed, 10 Apr 2024 00:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFZYxP6cUolaufv9BZVVGk5Tb3NBsxdV9jYc7bn9U/zU16JG2j1i8Z5JjuW6gdx3OR3ffpze+/CGp/SKQmXbI=
X-Received: by 2002:a17:90b:243:b0:2a5:e1e7:b98f with SMTP id
 fz3-20020a17090b024300b002a5e1e7b98fmr385052pjb.5.1712734537640; Wed, 10 Apr
 2024 00:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240410070459.49112-1-philmd@linaro.org>
In-Reply-To: <20240410070459.49112-1-philmd@linaro.org>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Wed, 10 Apr 2024 09:35:26 +0200
Message-ID: <CAA8xKjVrv5cnpuLiNsZxoA8RfX8-jN3PvKYCAcPXY2Xcmw-wFw@mail.gmail.com>
Subject: Re: [PATCH-for-9.0? v2] hw/net/net_tx_pkt: Fix overrun in
 update_sctp_checksum()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, qemu-stable@nongnu.org, 
 Zheyu Ma <zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 10, 2024 at 9:05=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> If a fragmented packet size is too short, do not try to
> calculate its checksum.

This was assigned CVE-2024-3567.

Thanks,

> Reproduced using:
>
>   $ cat << EOF | qemu-system-i386 -display none -nodefaults \
>                                   -machine q35,accel=3Dqtest -m 32M \
>                                   -device igb,netdev=3Dnet0 \
>                                   -netdev user,id=3Dnet0 \
>                                   -qtest stdio
>   outl 0xcf8 0x80000810
>   outl 0xcfc 0xe0000000
>   outl 0xcf8 0x80000804
>   outw 0xcfc 0x06
>   write 0xe0000403 0x1 0x02
>   writel 0xe0003808 0xffffffff
>   write 0xe000381a 0x1 0x5b
>   write 0xe000381b 0x1 0x00
>   EOF
>   Assertion failed: (offset =3D=3D 0), function iov_from_buf_full, file u=
til/iov.c, line 39.
>   #1 0x5575e81e952a in iov_from_buf_full qemu/util/iov.c:39:5
>   #2 0x5575e6500768 in net_tx_pkt_update_sctp_checksum qemu/hw/net/net_tx=
_pkt.c:144:9
>   #3 0x5575e659f3e1 in igb_setup_tx_offloads qemu/hw/net/igb_core.c:478:1=
1
>   #4 0x5575e659f3e1 in igb_tx_pkt_send qemu/hw/net/igb_core.c:552:10
>   #5 0x5575e659f3e1 in igb_process_tx_desc qemu/hw/net/igb_core.c:671:17
>   #6 0x5575e659f3e1 in igb_start_xmit qemu/hw/net/igb_core.c:903:9
>   #7 0x5575e659f3e1 in igb_set_tdt qemu/hw/net/igb_core.c:2812:5
>   #8 0x5575e657d6a4 in igb_core_write qemu/hw/net/igb_core.c:4248:9
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Fixes: f199b13bc1 ("igb: Implement Tx SCTP CSO")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2273
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Since v1: check at offset 8 (Akihiko)
> ---
>  hw/net/net_tx_pkt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 2134a18c4c..b7b1de816d 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -141,6 +141,10 @@ bool net_tx_pkt_update_sctp_checksum(struct NetTxPkt=
 *pkt)
>      uint32_t csum =3D 0;
>      struct iovec *pl_start_frag =3D pkt->vec + NET_TX_PKT_PL_START_FRAG;
>
> +    if (iov_size(pl_start_frag, pkt->payload_frags) < 8 + sizeof(csum)) =
{
> +        return false;
> +    }
> +
>      if (iov_from_buf(pl_start_frag, pkt->payload_frags, 8, &csum, sizeof=
(csum)) < sizeof(csum)) {
>          return false;
>      }
> --
> 2.41.0
>

--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


