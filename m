Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B7606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TZJAYzwm;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U03f43FV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOGIQ-0001x9-2f; Tue, 03 Nov 2026 10:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xOGIM-0001wD-6C
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:19:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xOGIK-000288-In
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793719167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u1Jt2B9zK+qobZmiB8J4p175sHhTQ9JwAR18kts6hlc=;
 b=TZJAYzwmK2cwZLREaStfsus9c8gBBxdCLrEefy1oLUvl+hJyN2GkP7GROSzV05+tYW3Siw
 4DWKfAZ0FAXfkcvpkfrosRnzjJY0F+sn7mB8ocZ2BNBcZRm/4up1faylaqYEKxCNOCRElr
 2OydYpFXxAMeH8Y6aqdbxOFqXPvvcIE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-U-0901QnMi-MQAOVRLLN2Q-1; Tue, 03 Nov 2026 10:19:24 -0500
X-MC-Unique: U-0901QnMi-MQAOVRLLN2Q-1
X-Mimecast-MFC-AGG-ID: U-0901QnMi-MQAOVRLLN2Q_1793719162
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a77c1cbd15so43413365e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793719162; x=1794323962; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u1Jt2B9zK+qobZmiB8J4p175sHhTQ9JwAR18kts6hlc=;
 b=U03f43FV01YtnM1s6bA4sDSe/65KSLzZrI0gnxWLZU8iKxE219rfcOD/lUTrnO/QJV
 apesMqoga6X87bnNBlRrhCRpApiSmbvV0QThmUq1/ZFqIvLhB0FIbB7BHKej16auJ3UZ
 NI8gHZoMtU3ptE/42Dzug1EPknKHYi/6NdugBoWdofPB3OPugQxydCZ6JNJzEGHJ1DqF
 wVWtcDUETKti00lQg3dbhcRxs1rQXPW9KZWahHL23okzuvKV1q64ndwHTu+9C3uscAXX
 BkymRDAeG/fezDBz60Y1Y/4nvWddujnR8aPuvoRIzbFURcJosi18Frf7Q/gn5vYmwOP1
 OS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793719162; x=1794323962;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u1Jt2B9zK+qobZmiB8J4p175sHhTQ9JwAR18kts6hlc=;
 b=yCKFqeELq/Fh+qiCV98sSipLj/T3EcNV0NK2emL68tq5cg/ELhvkjXlXMSlQoWw1cn
 CJGCDnaK2svCvzvQ7P82wAgoI02tMvuQhLN5/auN4cTC2YSeEEYznuIjvET4Yt5MT6qW
 sJe3Kb+LbwhLl6sAs5qk1iaJTJnzIn65t3vx0cjelSLI8MMzen1Gpkj1K7jTiKGl96Gu
 xkCt95adfGGFpFLDhTkJaHM5kXTGFLuRpI4wlqZ1OEkChxVP0e1mPptb8t4bXxUJCIYc
 F8yTggDk6iBZ+IAg7+ZvNVA0ubx3rwYqZFC+WG98c+bM0OUDikwCrr/gdqvzP/Q6s5tq
 YiZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3AXx7+VfT9uMC+R3O+letUq/ex13ZYqrDDNXF8AN3lNipxuk84VD2GzomvpiO3pezBGSbLzj53bSY@nongnu.org
X-Gm-Message-State: APuU4Z8Za5+n3N6CAlsFtPcIIUfLWkDKdBBEsOci/+D0TMVniRVmkMgg
 EzA+h/eepCaMffiE011CmhMZ7u98r7MLp3VsQ3kysi66suOw1V/T2IRIAZ+tkUROpqgPoqDDE4h
 IkBXsiPkjAWZf63uwjUQDRnzYWNYJj1Z3zoZvYH9eWfPc2KPRXmgoGPJu
X-Gm-Gg: AYBFou3DES28hfnowhcFZaLZldYtBxDI8khzVtq9krbpygJkHUJCpMvGOScwtK8Qkc2
 HfGZ0v0259UJeQte21OI/F7r+ab/NI57oTov5so8yZyxAPOZpZ08w1/DQZMzmAsMBBJLTTwGcd1
 GX7FWQsmppXxxtrwrmU44k0kBqTYB68Pd/IcjdVsmXC6rZtyGxn7PAIEQ1mc+FpIlaK1Wc+lapw
 K/niQDDU3wMfUai77vH+xuWmI1BIBr6qynuWWRqBWWRi5qqWh9Js5zK5kX1l0ZOIi36/0/PmzUV
 z6KwEu2QVmm6oA7N/CBJJY7XZwakiLHDuwhGeGvPunEH3UXXR3NOGvxM5BhvZq+p07q36DEvE1H
 9W8IJDUW1ThwPCuXVPGuWqsk5IYsQ8iJsl04=
X-Received: by 2002:a05:600c:4752:b0:4a1:9661:14b5 with SMTP id
 5b1f17b1804b1-4ac18e5d4d0mr324413725e9.29.1793719162184; 
 Tue, 03 Nov 2026 07:19:22 -0800 (PST)
X-Received: by 2002:a05:600c:4752:b0:4a1:9661:14b5 with SMTP id
 5b1f17b1804b1-4ac18e5d4d0mr324413185e9.29.1793719161786; 
 Tue, 03 Nov 2026 07:19:21 -0800 (PST)
Received: from localhost ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa5781c9sm71029925e9.8.2026.11.03.07.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:19:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 16:19:20 +0100
Message-Id: <DMLODIG6DEM2.2FULUML3XX45H@redhat.com>
Cc: <thuth@redhat.com>, <jamin_lin@aspeedtech.com>,
 <philmd@oss.qualcomm.com>, <clg@redhat.com>, <peter.maydell@linaro.org>,
 <kraxel@redhat.com>, <marcandre.lureau@redhat.com>, <farosas@suse.de>,
 <lvivier@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel-bounces+tcalifano=redhat.com@nongnu.org>
Subject: Re: [PATCH 1/2] hw/usb/hcd-ehci: idle the schedule after a failed
 descriptor read
From: "Tommaso Califano" <tcalifano@redhat.com>
To: "Junjie Cao" <junjie.cao@linux.dev>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.22.0
References: <20261103123350.1253202-1-junjie.cao@linux.dev>
 <20261103123350.1253202-2-junjie.cao@linux.dev>
In-Reply-To: <20261103123350.1253202-2-junjie.cao@linux.dev>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 3, 2026 at 1:33 PM CET, Junjie Cao wrote:
> Since get_dwords() started checking the DMA result, a failed descriptor
> read raises HSE, clears Run/Stop and makes the state function return
> without advancing.  That leaves the schedule in WAITLISTHEAD, FETCHQH,
> FETCHSITD or FETCHQTD, none of which ehci_advance_async_state() or
> ehci_advance_periodic_state() accept: the next frame hits their
> g_assert_not_reached().
>
> A guest gets there by pointing ASYNCLISTADDR, a QH's next qTD or a
> frame list entry at an address outside guest memory; QEMU aborts on the
> second frame.
>
> Return the schedule to EST_ACTIVE at those four sites, so the next pass
> sees Run/Stop clear and tears it down the way a stopped schedule is.
> The iTD and fill-queue reads already take the existing controller-reset
> path on error and are left alone.
>
> Fixes: 2b2a0e4f465a ("hw/usb/hcd-ehci: Check for DMA errors in get_dwords=
()/put_dwords()")
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
> ---
>  hw/usb/hcd-ehci.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index f371e567f3..938707043f 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -330,6 +330,15 @@ static int ehci_get_state(EHCIState *s, int async)
>      return async ? s->astate : s->pstate;
>  }
> =20
> +/*
> + * get_dwords() has raised HSE and cleared Run/Stop.  Park the schedule
> + * in EST_ACTIVE so the next advance pass idles it instead of asserting.
> + */
> +static void ehci_abandon_pass(EHCIState *ehci, int async)
> +{
> +    ehci_set_state(ehci, async, EST_ACTIVE);
> +}
> +

I'm not entirely convinced a wrapper is needed here, but I see the value
of keeping the comment in a single place, so I'm fine with it.

>  static void ehci_set_fetch_addr(EHCIState *s, int async, uint64_t addr)
>  {
>      if (async) {
> @@ -1600,6 +1609,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,=
  int async)
>      for (i =3D 0; i < MAX_QH; i++) {
>          if (!get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &qh,
>                          ehci_qh_dwords(ehci))) {
> +            ehci_abandon_pass(ehci, async);
>              return 0;
>          }
>          ehci_trace_qh(NULL, NLPTR_GET(entry), &qh);
> @@ -1703,6 +1713,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehc=
i, int async)
>      memset(&qh, 0, sizeof(qh));
>      if (!get_dwords(ehci, NLPTR_GET(q->qhaddr),
>                      (uint32_t *) &qh, ehci_qh_dwords(ehci))) {
> +        ehci_abandon_pass(ehci, async);
>          q =3D NULL;
>          goto out;
>      }
> @@ -1807,6 +1818,7 @@ static int ehci_state_fetchsitd(EHCIState *ehci, in=
t async)
> =20
>      if (!get_dwords(ehci, NLPTR_GET(entry), (uint32_t *)&sitd,
>                      sizeof(EHCIsitd) >> 2)) {
> +        ehci_abandon_pass(ehci, async);
>          return 0;
>      }
>      ehci_trace_sitd(ehci, entry, &sitd);
> @@ -1867,6 +1879,7 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
> =20
>      addr =3D NLPTR_GET(q->qtdaddr);
>      if (!get_dwords(q->ehci, addr +  8, &qtd.token,   1)) {
> +        ehci_abandon_pass(q->ehci, q->async);
>          return 0;
>      }
>      barrier();
> @@ -1878,6 +1891,7 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
>          (q->ehci->caps_64bit_addr &&
>           !get_dwords(q->ehci, addr + offsetof(EHCIqtd, bufptr_hi),
>                       qtd.bufptr_hi, ARRAY_SIZE(qtd.bufptr_hi)))) {
> +        ehci_abandon_pass(q->ehci, q->async);
>          return 0;
>      }
>      ehci_trace_qtd(q, NLPTR_GET(q->qtdaddr), &qtd);

Reviewed-by: Tommaso Califano <tcalifano@redhat.com>

Regards,
Tommaso Califano


