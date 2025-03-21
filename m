Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346D8C28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 01:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvR66-0003MP-Pi; Thu, 20 Mar 2025 21:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tvR65-0003MF-UI
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 21:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tvR64-0007p4-1e
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 21:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742520167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oXHq4/ezx+pRWUflYNeTIWXfpA/U/rs5XQSdt7VacGQ=;
 b=KiS/CrNwzZmumfVAzNZuzo2NvmwWOwGBHOwtla1AyByfgPIHBznjcWZr7+wDy08lsIL2pR
 GklaWxXc0np74lw+qrwNkRP/Az7FwjhWOtw4o2doReiln8Ucx5hCJZgYUYDEkFC+Fz2E+Y
 rxHbhl9lNNe4zGBxkTe+zqBLIR4w6Hk=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-_oH7OXocPpuvPq54yOJD9g-1; Thu, 20 Mar 2025 21:22:46 -0400
X-MC-Unique: _oH7OXocPpuvPq54yOJD9g-1
X-Mimecast-MFC-AGG-ID: _oH7OXocPpuvPq54yOJD9g_1742520165
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5240cd60cdbso1738233e0c.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 18:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742520165; x=1743124965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXHq4/ezx+pRWUflYNeTIWXfpA/U/rs5XQSdt7VacGQ=;
 b=Ql+IOUP3/tn4enZJA3UQziKPsHmFosazifejMy6koihwFC47QHMpjaEn2y4Ox6lfvw
 TrPiTV1qbr6D1Hn1V6ZIR0AAznQvMZaaAYquB5ITN4hjSqLQvkiL0zyoRKEv6Lyq2Hho
 mIpPzDU4onUJNr25GSx54w0RU2/OBPUWh+7WnE/nuhP+ITJ94JTBQG2o9t4b0fULQyLu
 OgmkG3Fsr8LTjenzLXbGNaHpSfJP1kwMyolnQTwqgmL/PjG8PVTz51lmSBNqE5dt5UZt
 rWJnh9N2cW/W86zcyXt8Y6QLhoxgUz08zb8fr40IHeWMklxFDyyt+XnySg2sZBZRKMQv
 5zZw==
X-Gm-Message-State: AOJu0YypvwP6rCY7skJIofKGGBG9cw4LWJfFIzba0uf51txP1mbfAlO/
 qWcPqgyRTJO34YTTRYrrha4ExhoTAdL6JC+d1Dd/q16TwovEEnDGOywVgAo5rQCeNTV5jgnjSnc
 4GrsRpabv3DCvzwcZqf5y5ZCNCxfbUyDHqxIT+4atTf1K85DIRyPf0db0KoeuL6/cy3tQgGTABZ
 iD7tJFXB8ciDXF8wf6qDzc30TBfQU=
X-Gm-Gg: ASbGncv2Ii7+FvHhg8K6K2gobacEjllLkMxDalQdssk2hY6EjPYHdq7OJnalL/Zlajm
 MqyFLfXdSmsGfbk9pF4xrmubB27c6g6g0ZNM/y1CJMyRbTqtMZX+hCHXrTGSRHuo+GyhXTrlp
X-Received: by 2002:a05:6122:201a:b0:521:b3ee:4970 with SMTP id
 71dfb90a1353d-52595d6a50dmr5514212e0c.2.1742520165631; 
 Thu, 20 Mar 2025 18:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfG4H/WbVZYJeA68T5wOSEu0A3dwQLqVRCYK1doXH2DY8sBK2gdIijcwH0394ayyX/Po4o4WkR+SxTTEyFrro=
X-Received: by 2002:a05:6122:201a:b0:521:b3ee:4970 with SMTP id
 71dfb90a1353d-52595d6a50dmr5514208e0c.2.1742520165327; Thu, 20 Mar 2025
 18:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <553b11b5-4cc4-4e59-9211-74c8cce51a96@linux.ibm.com>
 <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
 <fa821773-225f-4e2b-8642-72d269802d96@linux.ibm.com>
In-Reply-To: <fa821773-225f-4e2b-8642-72d269802d96@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Mar 2025 09:22:32 +0800
X-Gm-Features: AQ5f1JoZcG8_BZA0nBidapyfgVgOVUh7rZRkzxr19YxIrmbw3NT8bfJ2W7CCPwk
Message-ID: <CACGkMEsOx5bdpny3y9BfJsefNKbiXk2bG3+TPKtFyr7CWhz1FA@mail.gmail.com>
Subject: Re: VDPA MAC address problem
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: qemu-devel@nongnu.org, dtatulea@nvidia.com, Cindy Lu <lulu@redhat.com>, 
 eperezma <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Mar 21, 2025 at 12:45=E2=80=AFAM Konstantin Shkolnyy <kshk@linux.ib=
m.com> wrote:
>
> On 3/19/2025 19:58, Jason Wang wrote:
> > On Thu, Mar 20, 2025 at 12:34=E2=80=AFAM Konstantin Shkolnyy <kshk@linu=
x.ibm.com> wrote:
> >> Upon reading this forum, I see that VHOST_VDPA_SET_CONFIG is
> >> =E2=80=9Cdeprecated=E2=80=9D, and so VIRTIO_NET_CTRL_MAC_ADDR_SET must=
 be the right
> >> method, but it=E2=80=99s apparently called too late.
> >
> > VHOST_VDPA_SET_CONFIG requires the vDPA parent support which is not
> > necessarily there.
>
> The mlx5 driver doesn't do anything for VHOST_VDPA_SET_CONFIG. Intel's
> driver, however, apparently stores the configuration. So, it appears,
> Intel will avoid the problem... Perhaps mlx5 could do the same so that
> QEMU can set the address before it starts the VM (QEMU doesn't have to
> later let the VM change the config).

The problem is that config space is not allowed to be written, that is
why mlx5 doesn't implement the write method.

> Conceptually, setting the address
> by QEMU cmdline doesn't look different from setting it by "vdpa dev add".

It's kind of different.

E.g the device may not even have VIRTIO_NET_F_MAC feature etc.

Thanks

>


