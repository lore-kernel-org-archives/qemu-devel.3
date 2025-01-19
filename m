Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5478AC02183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 09:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZRVh-0008Mp-Je; Sun, 19 Jan 2025 04:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1tZRVf-0008MP-86
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 04:22:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1tZRVd-0004Og-D9
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 04:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737278537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=INJrnDMrAIuy/dzvEqXSIhqg5A+L4JCJ5fJeb5YQanY=;
 b=DFnQQuq1nURtwit9utKWCHwIDqDPFzff32q+i5u+rVyitX0OPqD8XbiWQOX38MvT2Z3Q2+
 jSlGopQDn9bycBv+O/XT0Godp08w/rhROpzveArKCQHTG7pEF4vg5SoOr8c2Dp/u9B2tao
 BExsDmC7E6oYL/B4vwmDk7xEJKmzyFk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-GGWqZ4J0NeKj2v_iDJArXA-1; Sun, 19 Jan 2025 04:22:15 -0500
X-MC-Unique: GGWqZ4J0NeKj2v_iDJArXA-1
X-Mimecast-MFC-AGG-ID: GGWqZ4J0NeKj2v_iDJArXA
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e48beea5778so8943616276.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2025 01:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737278535; x=1737883335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=INJrnDMrAIuy/dzvEqXSIhqg5A+L4JCJ5fJeb5YQanY=;
 b=j/q8DZWhg02wIT2CV6NknEoK1QAJQzNOiD82mIh2mjx4XhuEGMj5+o5tlifAaDGzja
 doNI8WybgAiIksseJ64kXH+oRjqYxf7NC5ybeTMGk7Fq5gEqnhvtoHuoGfw6N2Ptydr+
 Zj7C5+AlqYhIxdN/wFPN8soJj7lTzqZBT/xonlGTxPQtHMJ/yxVUOx0T2r/12ooSM/1f
 rdiJ0wNkb+mt7Ar9Y+gptrKW/iIiPWqtPxQo/3/60JfzLV4Vr8VOI+4+/g1LcIWfDv59
 zoS0jncrF1EwBSzcrkoKVyx4zLAVdzOJy4GVPf5BZdXfwyf3SFjSC+LzeLkcVSUzE2lB
 zKQw==
X-Gm-Message-State: AOJu0YwRZjmb4B0wE40IP2GEFvhylDER1vikrmXWoEbxz9faIcG0z4cI
 oB6v53fBBnP0abDcSOuttu1OPdda8pBXXO2UsLBCUBK4Ey2jY0PhZNYXplhF9K+an6ROvWR1a1M
 avA2hlqvHtEk2BJcg1lQ1xjB68+3Ehe+AI9O/qPD5t5fODho62lyoktNNflu84sXGPBWGLCPfU8
 h8+2gWVLVMTiXoLWLckl7B4z3xaWk=
X-Gm-Gg: ASbGncv1mkq0I+6iZoXJ2xW8CuKNjrk6fCB3tfj8R9RJ2SyzBQMsvLORZ6TCGbLDO0j
 RbhLYoeMZnW6f7FmuplM6Iroa7sagX7SJBGIcxev1kdunuK57Kg==
X-Received: by 2002:a05:6902:18c2:b0:e57:386b:6f2 with SMTP id
 3f1490d57ef6-e57b107b2c7mr6538662276.27.1737278535207; 
 Sun, 19 Jan 2025 01:22:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFs2Rpf3XUoOuDbKL+hBzdRoqcmMMHbNkyC1wfAbCTgzQavwTSLBCwuM/83dqyItEtGqPGJCXARux7DHtpm2sY=
X-Received: by 2002:a05:6902:18c2:b0:e57:386b:6f2 with SMTP id
 3f1490d57ef6-e57b107b2c7mr6538653276.27.1737278534939; Sun, 19 Jan 2025
 01:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20250117170306.403075-1-npiggin@gmail.com>
 <20250117170306.403075-4-npiggin@gmail.com>
In-Reply-To: <20250117170306.403075-4-npiggin@gmail.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Sun, 19 Jan 2025 11:22:03 +0200
X-Gm-Features: AbW1kvbL99fEXJiTr_UOfRluy_umarvnatfqZqRA2zRhhsMSbdywtN7lfkuXAZg
Message-ID: <CAGoVJZxkm_zj7RPBs9Lk3tpgYfzNi9UdsVOKsDibGZ98i+Ddew@mail.gmail.com>
Subject: Re: [PATCH 3/9] qtest/e1000e|igb: assert irqs are clear before
 triggering an irq
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f398da062c0bad47"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.787,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000f398da062c0bad47
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 7:05=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com>=
 wrote:

> Assert there is no existing irq raised that would lead to a false
> positive interrupt test.
>
> e1000e has to disable interrupt throttling for this test, because
> it can cause delayed superfluous interrupts which trip the assertions.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/qtest/libqos/e1000e.h |  1 +
>  tests/qtest/e1000e-test.c   | 10 ++++++++++
>  tests/qtest/igb-test.c      |  6 ++++++
>  tests/qtest/libqos/e1000e.c |  9 ++++++++-
>  4 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
> index 30643c80949..7154aec0339 100644
> --- a/tests/qtest/libqos/e1000e.h
> +++ b/tests/qtest/libqos/e1000e.h
> @@ -54,6 +54,7 @@ static inline uint32_t e1000e_macreg_read(QE1000E *d,
> uint32_t reg)
>      return qpci_io_readl(&d_pci->pci_dev, d_pci->mac_regs, reg);
>  }
>
> +bool e1000e_seen_isr(QE1000E *d, uint16_t msg_id);
>  void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);
>  void e1000e_tx_ring_push(QE1000E *d, void *descr);
>  void e1000e_rx_ring_push(QE1000E *d, void *descr);
> diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
> index 746d26cfb67..9ab81ecff5b 100644
> --- a/tests/qtest/e1000e-test.c
> +++ b/tests/qtest/e1000e-test.c
> @@ -61,6 +61,9 @@ static void e1000e_send_verify(QE1000E *d, int
> *test_sockets, QGuestAllocator *a
>                                     E1000_TXD_DTYP_D   |
>                                     sizeof(buffer));
>
> +    /* Ensure the interrupt has not been taken already */
> +    g_assert(!e1000e_seen_isr(d, E1000E_TX0_MSG_ID));
> +
>      /* Put descriptor to the ring */
>      e1000e_tx_ring_push(d, &descr);
>
> @@ -105,6 +108,9 @@ static void e1000e_receive_verify(QE1000E *d, int
> *test_sockets, QGuestAllocator
>      char buffer[64];
>      int ret;
>
> +    /* Ensure the interrupt has not been taken already */
> +    g_assert(!e1000e_seen_isr(d, E1000E_RX0_MSG_ID));
> +
>
I don't think potentially crashing the guest is the right solution.
I suggest maybe substituting with logging.


>      /* Send a dummy packet to device's socket*/
>      ret =3D iov_send(test_sockets[0], iov, 2, 0, sizeof(len) +
> sizeof(packet));
>      g_assert_cmpint(ret, =3D=3D , sizeof(packet) + sizeof(len));
> @@ -188,6 +194,10 @@ static void test_e1000e_multiple_transfers(void *obj=
,
> void *data,
>          return;
>      }
>
> +    /* Clear EITR because buggy QEMU throttle timer causes superfluous
> irqs */
> +    e1000e_macreg_write(d, E1000_EITR + E1000E_RX0_MSG_ID * 4, 0);
> +    e1000e_macreg_write(d, E1000_EITR + E1000E_TX0_MSG_ID * 4, 0);
> +
>      for (i =3D 0; i < iterations; i++) {
>          e1000e_send_verify(d, data, alloc);
>          e1000e_receive_verify(d, data, alloc);
> diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
> index cf8b4131cf2..1bbb4bea4c1 100644
> --- a/tests/qtest/igb-test.c
> +++ b/tests/qtest/igb-test.c
> @@ -64,6 +64,9 @@ static void igb_send_verify(QE1000E *d, int
> *test_sockets, QGuestAllocator *allo
>                                            E1000_TXD_DTYP_D   |
>                                            sizeof(buffer));
>
> +    /* Ensure the interrupt has not been taken already */
> +    g_assert(!e1000e_seen_isr(d, E1000E_TX0_MSG_ID));
> +
>      /* Put descriptor to the ring */
>      e1000e_tx_ring_push(d, &descr);
>
> @@ -119,6 +122,9 @@ static void igb_receive_verify(QE1000E *d, int
> *test_sockets, QGuestAllocator *a
>      memset(&descr, 0, sizeof(descr));
>      descr.read.pkt_addr =3D cpu_to_le64(data);
>
> +    /* Ensure the interrupt has not been taken already */
> +    g_assert(!e1000e_seen_isr(d, E1000E_RX0_MSG_ID));
> +
>      /* Put descriptor to the ring */
>      e1000e_rx_ring_push(d, &descr);
>
> diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
> index 925654c7fd4..4e4c387b0bf 100644
> --- a/tests/qtest/libqos/e1000e.c
> +++ b/tests/qtest/libqos/e1000e.c
> @@ -77,13 +77,20 @@ static void e1000e_foreach_callback(QPCIDevice *dev,
> int devfn, void *data)
>      g_free(dev);
>  }
>
> +bool e1000e_seen_isr(QE1000E *d, uint16_t msg_id)
> +{
> +    QE1000E_PCI *d_pci =3D container_of(d, QE1000E_PCI, e1000e);
> +
> +    return qpci_msix_pending(&d_pci->pci_dev, msg_id);
> +}
> +
>  void e1000e_wait_isr(QE1000E *d, uint16_t msg_id)
>  {
>      QE1000E_PCI *d_pci =3D container_of(d, QE1000E_PCI, e1000e);
>      guint64 end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND=
;
>
>      do {
> -        if (qpci_msix_pending(&d_pci->pci_dev, msg_id)) {
> +        if (e1000e_seen_isr(d, msg_id)) {
>              return;
>          }
>          qtest_clock_step(d_pci->pci_dev.bus->qts, 10000);
> --
> 2.45.2
>
>
>

--000000000000f398da062c0bad47
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 17,=
 2025 at 7:05=E2=80=AFPM Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmai=
l.com">npiggin@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Assert th=
ere is no existing irq raised that would lead to a false<br>
positive interrupt test.<br>
<br>
e1000e has to disable interrupt throttling for this test, because<br>
it can cause delayed superfluous interrupts which trip the assertions.<br>
<br>
Signed-off-by: Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com" tar=
get=3D"_blank">npiggin@gmail.com</a>&gt;<br>
---<br>
=C2=A0tests/qtest/libqos/e1000e.h |=C2=A0 1 +<br>
=C2=A0tests/qtest/e1000e-test.c=C2=A0 =C2=A0| 10 ++++++++++<br>
=C2=A0tests/qtest/igb-test.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++++++<br>
=C2=A0tests/qtest/libqos/e1000e.c |=C2=A0 9 ++++++++-<br>
=C2=A04 files changed, 25 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h<br>
index 30643c80949..7154aec0339 100644<br>
--- a/tests/qtest/libqos/e1000e.h<br>
+++ b/tests/qtest/libqos/e1000e.h<br>
@@ -54,6 +54,7 @@ static inline uint32_t e1000e_macreg_read(QE1000E *d, uin=
t32_t reg)<br>
=C2=A0 =C2=A0 =C2=A0return qpci_io_readl(&amp;d_pci-&gt;pci_dev, d_pci-&gt;=
mac_regs, reg);<br>
=C2=A0}<br>
<br>
+bool e1000e_seen_isr(QE1000E *d, uint16_t msg_id);<br>
=C2=A0void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);<br>
=C2=A0void e1000e_tx_ring_push(QE1000E *d, void *descr);<br>
=C2=A0void e1000e_rx_ring_push(QE1000E *d, void *descr);<br>
diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c<br>
index 746d26cfb67..9ab81ecff5b 100644<br>
--- a/tests/qtest/e1000e-test.c<br>
+++ b/tests/qtest/e1000e-test.c<br>
@@ -61,6 +61,9 @@ static void e1000e_send_verify(QE1000E *d, int *test_sock=
ets, QGuestAllocator *a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 E1000_TXD_DTYP_D=C2=A0=
 =C2=A0|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(buffer));<br>
<br>
+=C2=A0 =C2=A0 /* Ensure the interrupt has not been taken already */<br>
+=C2=A0 =C2=A0 g_assert(!e1000e_seen_isr(d, E1000E_TX0_MSG_ID));<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* Put descriptor to the ring */<br>
=C2=A0 =C2=A0 =C2=A0e1000e_tx_ring_push(d, &amp;descr);<br>
<br>
@@ -105,6 +108,9 @@ static void e1000e_receive_verify(QE1000E *d, int *test=
_sockets, QGuestAllocator<br>
=C2=A0 =C2=A0 =C2=A0char buffer[64];<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
+=C2=A0 =C2=A0 /* Ensure the interrupt has not been taken already */<br>
+=C2=A0 =C2=A0 g_assert(!e1000e_seen_isr(d, E1000E_RX0_MSG_ID));<br>
+<br></blockquote><div>I don&#39;t think potentially crashing the guest is =
the right solution.</div><div>I suggest maybe substituting=C2=A0with loggin=
g.=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;borde=
r-left-color:rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0/* Send a dummy packet to device&#39;s socket*/<br>
=C2=A0 =C2=A0 =C2=A0ret =3D iov_send(test_sockets[0], iov, 2, 0, sizeof(len=
) + sizeof(packet));<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(ret, =3D=3D , sizeof(packet) + sizeof(l=
en));<br>
@@ -188,6 +194,10 @@ static void test_e1000e_multiple_transfers(void *obj, =
void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /* Clear EITR because buggy QEMU throttle timer causes super=
fluous irqs */<br>
+=C2=A0 =C2=A0 e1000e_macreg_write(d, E1000_EITR + E1000E_RX0_MSG_ID * 4, 0=
);<br>
+=C2=A0 =C2=A0 e1000e_macreg_write(d, E1000_EITR + E1000E_TX0_MSG_ID * 4, 0=
);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; iterations; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e1000e_send_verify(d, data, alloc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e1000e_receive_verify(d, data, alloc);<br=
>
diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c<br>
index cf8b4131cf2..1bbb4bea4c1 100644<br>
--- a/tests/qtest/igb-test.c<br>
+++ b/tests/qtest/igb-test.c<br>
@@ -64,6 +64,9 @@ static void igb_send_verify(QE1000E *d, int *test_sockets=
, QGuestAllocator *allo<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0E1000_TXD_DTYP_D=C2=A0 =C2=A0|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0sizeof(buffer));<br>
<br>
+=C2=A0 =C2=A0 /* Ensure the interrupt has not been taken already */<br>
+=C2=A0 =C2=A0 g_assert(!e1000e_seen_isr(d, E1000E_TX0_MSG_ID));<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* Put descriptor to the ring */<br>
=C2=A0 =C2=A0 =C2=A0e1000e_tx_ring_push(d, &amp;descr);<br>
<br>
@@ -119,6 +122,9 @@ static void igb_receive_verify(QE1000E *d, int *test_so=
ckets, QGuestAllocator *a<br>
=C2=A0 =C2=A0 =C2=A0memset(&amp;descr, 0, sizeof(descr));<br>
=C2=A0 =C2=A0 =C2=A0descr.read.pkt_addr =3D cpu_to_le64(data);<br>
<br>
+=C2=A0 =C2=A0 /* Ensure the interrupt has not been taken already */<br>
+=C2=A0 =C2=A0 g_assert(!e1000e_seen_isr(d, E1000E_RX0_MSG_ID));<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* Put descriptor to the ring */<br>
=C2=A0 =C2=A0 =C2=A0e1000e_rx_ring_push(d, &amp;descr);<br>
<br>
diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c<br>
index 925654c7fd4..4e4c387b0bf 100644<br>
--- a/tests/qtest/libqos/e1000e.c<br>
+++ b/tests/qtest/libqos/e1000e.c<br>
@@ -77,13 +77,20 @@ static void e1000e_foreach_callback(QPCIDevice *dev, in=
t devfn, void *data)<br>
=C2=A0 =C2=A0 =C2=A0g_free(dev);<br>
=C2=A0}<br>
<br>
+bool e1000e_seen_isr(QE1000E *d, uint16_t msg_id)<br>
+{<br>
+=C2=A0 =C2=A0 QE1000E_PCI *d_pci =3D container_of(d, QE1000E_PCI, e1000e);=
<br>
+<br>
+=C2=A0 =C2=A0 return qpci_msix_pending(&amp;d_pci-&gt;pci_dev, msg_id);<br=
>
+}<br>
+<br>
=C2=A0void e1000e_wait_isr(QE1000E *d, uint16_t msg_id)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QE1000E_PCI *d_pci =3D container_of(d, QE1000E_PCI, e10=
00e);<br>
=C2=A0 =C2=A0 =C2=A0guint64 end_time =3D g_get_monotonic_time() + 5 * G_TIM=
E_SPAN_SECOND;<br>
<br>
=C2=A0 =C2=A0 =C2=A0do {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qpci_msix_pending(&amp;d_pci-&gt;pci_dev, =
msg_id)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (e1000e_seen_isr(d, msg_id)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qtest_clock_step(d_pci-&gt;pci_dev.bus-&g=
t;qts, 10000);<br>
-- <br>
2.45.2<br>
<br>
<br>
</blockquote></div></div>

--000000000000f398da062c0bad47--


