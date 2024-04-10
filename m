Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ADFCD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 08:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruTG7-00049t-90; Wed, 10 Apr 2024 04:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ruTG5-00048W-It
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 04:24:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ruTFz-0006Fp-Qn
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 04:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712737473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8rXnc6tRZHrfgSSR5HAxGrAPGuzNJrA7c8mQaGHxGE8=;
 b=Fx1NDhKCbI+MCVNjFjhrbbIbGKL2q2wJb4ZdFxlsfmtLOUFJeco/GQZwVHeqz+RPm+17fH
 Jpogjs07MJuGOg7+V6VqlQlTaNVVe22PC19/mJixC6dj8rFuzYZfWAvCUbJKxcS5mZRu/n
 RQ6pguGvf8z3EDa1Z+M9BVfjjsP5nGw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-Uuy8vRIVMWmcmf6-gHzJXQ-1; Wed, 10 Apr 2024 04:24:32 -0400
X-MC-Unique: Uuy8vRIVMWmcmf6-gHzJXQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6ed613bb4d1so2014153b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 01:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712737471; x=1713342271;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rXnc6tRZHrfgSSR5HAxGrAPGuzNJrA7c8mQaGHxGE8=;
 b=cvN9HRWsmSE+Kt7ezPFeSodOf7ik4LzfwwAMC13WzeyXCrPZcLQnMgVUTLAWXAugK4
 srZnwAUT26znSgtMkJd90LIa33AcGN1EBe5Bqye5BO6kIlaikjuB2ghcYTLjiR0u4jg6
 oXMnp2gCyvZRv1cwNAjIMbaxu8AOItlqGhi6PeqFVCr1/5Wlo9tTlZv3Xoe/cL+kdfc9
 3lV0GeLRU4GlxdDl6YwAI082xnMtHLUReOICsIemsIYxqOyqtr6j+G92MA7XAMhMWbTM
 oEujefTWnYA4lPeZHfWQOVRntSIVGsW8Bth4gV5CMx0clW0HYJ6DAews8Jj5Q1LLeknO
 wFew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWtQ4s7ZC/B/nowOCWBD3w/jcZSUfEvn8sw7+i63ZkEXo7HDtPhRX8MLx8q8Rp97oFkD88OK/qV6Expp+YTpbvtb7erjA=
X-Gm-Message-State: AOJu0YyRhDjljuwIZ+Yo9qPiFSwgMl3lFmt1/5pvy/IWvMJCBi2G8298
 4RVysOSHYrO3p8I8bii+kPnfcfJ+Z6HTPbtONJ3l5TqELVGKMpaSwFtp39jeAreE49NmMVoZGJ3
 w7jwbLx1bTwrg7o8gu+cOgRQ2zddaED9rkvmo5kiPviWHhcgErQspYFwKeXl/IcZRUJ/DIBFwPQ
 9wM3oK0U+k1qkoNKXPH1bPsLZpzVo=
X-Received: by 2002:a05:6a20:3216:b0:1a7:4ab0:719e with SMTP id
 hl22-20020a056a20321600b001a74ab0719emr2026904pzc.23.1712737471049; 
 Wed, 10 Apr 2024 01:24:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIb7y6jwi3GyC9X2O8O0QPN8PYBe5KOnD0eAHvTqFxsEPPX8qwYmabdp40OGA7zQitIp2AHBvGFNhJd6arj7Q=
X-Received: by 2002:a05:6a20:3216:b0:1a7:4ab0:719e with SMTP id
 hl22-20020a056a20321600b001a74ab0719emr2026890pzc.23.1712737470702; Wed, 10
 Apr 2024 01:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240410070459.49112-1-philmd@linaro.org>
 <722e10bc-f038-4873-ad14-891f3485e8be@daynix.com>
In-Reply-To: <722e10bc-f038-4873-ad14-891f3485e8be@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 16:24:19 +0800
Message-ID: <CACGkMEv0_DWNYrQz5_=zmX9h6i2XcG=Pnero9HQorEvkwu5uzw@mail.gmail.com>
Subject: Re: [PATCH-for-9.0? v2] hw/net/net_tx_pkt: Fix overrun in
 update_sctp_checksum()
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-stable@nongnu.org, 
 Zheyu Ma <zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Apr 10, 2024 at 3:06=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/04/10 16:04, Philippe Mathieu-Daud=C3=A9 wrote:
> > If a fragmented packet size is too short, do not try to
> > calculate its checksum.
> >
> > Reproduced using:
> >
> >    $ cat << EOF | qemu-system-i386 -display none -nodefaults \
> >                                    -machine q35,accel=3Dqtest -m 32M \
> >                                    -device igb,netdev=3Dnet0 \
> >                                    -netdev user,id=3Dnet0 \
> >                                    -qtest stdio
> >    outl 0xcf8 0x80000810
> >    outl 0xcfc 0xe0000000
> >    outl 0xcf8 0x80000804
> >    outw 0xcfc 0x06
> >    write 0xe0000403 0x1 0x02
> >    writel 0xe0003808 0xffffffff
> >    write 0xe000381a 0x1 0x5b
> >    write 0xe000381b 0x1 0x00
> >    EOF
> >    Assertion failed: (offset =3D=3D 0), function iov_from_buf_full, fil=
e util/iov.c, line 39.
> >    #1 0x5575e81e952a in iov_from_buf_full qemu/util/iov.c:39:5
> >    #2 0x5575e6500768 in net_tx_pkt_update_sctp_checksum qemu/hw/net/net=
_tx_pkt.c:144:9
> >    #3 0x5575e659f3e1 in igb_setup_tx_offloads qemu/hw/net/igb_core.c:47=
8:11
> >    #4 0x5575e659f3e1 in igb_tx_pkt_send qemu/hw/net/igb_core.c:552:10
> >    #5 0x5575e659f3e1 in igb_process_tx_desc qemu/hw/net/igb_core.c:671:=
17
> >    #6 0x5575e659f3e1 in igb_start_xmit qemu/hw/net/igb_core.c:903:9
> >    #7 0x5575e659f3e1 in igb_set_tdt qemu/hw/net/igb_core.c:2812:5
> >    #8 0x5575e657d6a4 in igb_core_write qemu/hw/net/igb_core.c:4248:9
> >
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> > Fixes: f199b13bc1 ("igb: Implement Tx SCTP CSO")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2273
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Fixes: CVE-2024-3567
Acked-by: Jason Wang <jasowang@redhat.com>

Peter, would you want to pick this for 9.0?

Thanks

>
> > ---
> > Since v1: check at offset 8 (Akihiko)
> > ---
> >   hw/net/net_tx_pkt.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> > index 2134a18c4c..b7b1de816d 100644
> > --- a/hw/net/net_tx_pkt.c
> > +++ b/hw/net/net_tx_pkt.c
> > @@ -141,6 +141,10 @@ bool net_tx_pkt_update_sctp_checksum(struct NetTxP=
kt *pkt)
> >       uint32_t csum =3D 0;
> >       struct iovec *pl_start_frag =3D pkt->vec + NET_TX_PKT_PL_START_FR=
AG;
> >
> > +    if (iov_size(pl_start_frag, pkt->payload_frags) < 8 + sizeof(csum)=
) {
> > +        return false;
> > +    }
> > +
> >       if (iov_from_buf(pl_start_frag, pkt->payload_frags, 8, &csum, siz=
eof(csum)) < sizeof(csum)) {
> >           return false;
> >       }
>


