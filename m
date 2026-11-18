Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E15606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kuu9ctTS;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FZdqnsjx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTisW-0003ym-6m; Wed, 18 Nov 2026 11:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xTiru-0003ty-RS
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:50:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xTirt-0006R0-72
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795020643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHlZWEo3yx66pT59UmpUP915z91xRsa4+VZ3YpsIBJA=;
 b=Kuu9ctTSVmWnTbLgVg0XiHS7eb9vq7f3dbXjVJ9/BG1VnbRHd5EhETZ6motfLbAPl49yIm
 QADNycMpiMZ2ojyyiHSQ7YhZ+GB06Mx8GUUjhc36jOFeAgjFHkW2n5wzLAGi5tDD7zEPue
 VhLt4lbDLqo7bBQjI58IIfBoL+W1viU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-9UmMbUgXPy6H0zGni0_vVA-1; Wed, 18 Nov 2026 11:50:42 -0500
X-MC-Unique: 9UmMbUgXPy6H0zGni0_vVA-1
X-Mimecast-MFC-AGG-ID: 9UmMbUgXPy6H0zGni0_vVA_1795020641
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1f03f2e8aso9491055e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 08:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795020641; x=1795625441; darn=nongnu.org;
 h=in-reply-to:references:content-transfer-encoding:mime-version:to
 :from:subject:cc:message-id:date:content-type:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tHlZWEo3yx66pT59UmpUP915z91xRsa4+VZ3YpsIBJA=;
 b=FZdqnsjxbX//Y96GicSK2LAj49aA4uC6bSzali35NXEQptEt3VCPulKD1mTH2pRgv9
 w6Cf/CM/VEfxMnZ5Pa9b1ZIiUyiS+S89P6Y05TCplYmtAMUIXov/7ugqHu/uy9dLGVV+
 SBklU+/iIFBDyW+fmOhGgJ5EDVT+esciJXK96L8IMmfv/1UH/NC5OBY86omcnog6a0Oh
 CVKllAEVyXhsPuwbZCEhuDYCqJ9zHwujQG4P0Bog09vDVT5mij3uiGIzlr/+AERbjNXn
 607Fmc6ArltGhlmeCTypcNJt/Kpct3wVwaZzoYaaRTfppqXsso2Bhu80+YflMkl7fokb
 WQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795020641; x=1795625441;
 h=in-reply-to:references:content-transfer-encoding:mime-version:to
 :from:subject:cc:message-id:date:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tHlZWEo3yx66pT59UmpUP915z91xRsa4+VZ3YpsIBJA=;
 b=Y68m/Ei4fyYP4Hvr5w+OzEk8F/0ENfAo1Q0qlQw34fixq7X2fLVDKINH7OrfdUeTvn
 MbPCUCTeKlfBouZJxdePB8K5nbMv9jfSoME0eQhhy0ER2AJYY6aNNgdQB38YwfCy/1HZ
 VRoJ3MsWssq+SB2wlaxXmlZF2IH+eSLm1XamLEXxs/7WzvGxI+Dox0K845Jmyb6gmuPI
 ssdVuePi2MnOkQBbObn2vgUD3ApaFyov8VNJxdxRcIoI2zTh2+qGZ97d0WnQdpDSlJNM
 u51H9nxr6Z7lqbfqD58/wkizvA5YeqitlhjX8i9vgaAaO1kmFJZ/99UErXOjdjSsxvb3
 MGvA==
X-Gm-Message-State: APuU4Z8C5bf/b2nmwXJJZuValcGsPj8YKl61aUhFiOaOxna70akxmCEA
 zsLX8OJTIDWa1LGvaA7oHeIl8f0tT0vJc7O+zBA5yne81uQrTuN3ZvjEx0U/9Da6Rjtj33Gf9/J
 YaLg+18OBscIn7GtPSrR0ILZufsSmrCIP96QII6nzJV8s9Fy67nmqcM4K
X-Gm-Gg: AYBFou1G/FKr4GSo/C5JA6TWhLE/b0iSYHZzi3w+yVpzBybm+dBSs5u9RKkWBwVQLmL
 Fck+gVOfnp22i3RVrrqXbQ0g+g14AOhRCIaf6ExbLR/MDZ3F5DB72OE8dKztXF66Qydxll6+EZJ
 qWsuCNM5iafqTfurSzceQTzQuOQiGN2zbJpbU54bwF4nwYB2kkxbA4SJQyrBM3w/SfgL4BIEKLo
 YeS1iT0CwjHIUCsZPezAvSNovIdEp9cq0MpOlJGS6BAnsDJN3Wmq2ZlSaWOhzg9HMiVUmAvw1Qp
 2pO21s4Ai1nyx7gSpEAlSw81s4844JHSEVnlG+sVRkpwIje43i7mvngPOXkbFBQzttPfipiAi0K
 ACDhO8nNG9lyq5YZMbt32sKH6NmKxGaSEFuLmV6HjG2D2
X-Received: by 2002:a05:600c:a54:b0:4a3:5d64:df91 with SMTP id
 5b1f17b1804b1-4bb7da3e3e0mr60757455e9.18.1795020640870; 
 Wed, 18 Nov 2026 08:50:40 -0800 (PST)
X-Received: by 2002:a05:600c:a54:b0:4a3:5d64:df91 with SMTP id
 5b1f17b1804b1-4bb7da3e3e0mr60757095e9.18.1795020640451; 
 Wed, 18 Nov 2026 08:50:40 -0800 (PST)
Received: from localhost ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8326b81esm873945e9.14.2026.11.18.08.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 08:50:40 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 17:50:39 +0100
Message-Id: <DMYHPLN68VZR.1N2Y3IUDLVD6I@redhat.com>
Cc: <qemu-devel@nongnu.org>, "Markus Armbruster" <armbru@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 <qemu-stable@nongnu.org>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH 6/9] hw/usb/dev-mtp: Detect end of SendObject data
 correctly
From: "Tommaso Califano" <tcalifano@redhat.com>
To: "Junjie Cao" <junjie.cao@linux.dev>, "Tommaso Califano"
 <tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.22.0
References: <20261112174907.158825-1-tcalifano@redhat.com>
 <20261112174907.158825-7-tcalifano@redhat.com>
 <20261115142800.1299746-1-junjie.cao@linux.dev>
In-Reply-To: <20261115142800.1299746-1-junjie.cao@linux.dev>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun Nov 15, 2026 at 3:28 PM CET, Junjie Cao wrote:
> On Thu, Nov 12, 2026 at 06:49:03PM +0100, Tommaso Califano wrote:
>> +        if ((p->iov.size % p->ep->max_packet_size) || !p->iov.size ||
>
> max_packet_size is 0 until the guest sets a configuration
> (usb_ep_reset()), and dev-mtp handles bulk packets before that. From
> qtest, OpenSession, SendObjectInfo and SendObject without
> SET_CONFIGURATION write the file on master; with the series applied
> QEMU dies with SIGFPE on this line.
>

Thanks for pointing it out, I'll modify the guard in:
  !p->iov.size ||
  (p->ep->max_packet_size && (p->iov.size % p->ep->max_packet_size)

This should prevent the crash in that case.

>> +         *  - A Zero Length Packet
>
> usb_mtp_handle_data() stalls every OUT packet shorter than the
> container header before it gets here, so the !p->iov.size arm is not
> reached. With libmtp 1.1.20 in a Linux guest on xHCI or EHCI, a 500
> byte file (512 with the header) now lands intact, but mtp-sendfile
> still fails with "PTP I/O Error": the ZLP that ends the data phase
> (MTP 1.1, Appendix H) gets the "packet too small" STALL.
>

I'll add a new check before the stall response.

Thanks,
Tommaso


