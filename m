Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35632C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 07:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtjZK-00064H-77; Mon, 08 Apr 2024 03:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1rtjZI-00063u-56
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1rtjZG-0002Fe-MX
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712561845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jEtYmbfQjqgnJ3kHRalouPy2RRmrhg+WCoqzQNyLPM0=;
 b=YKffnYQO9IIPezPoQ9TnzCSxOVLpIHEPj7ux7cdwU7eT7P1vVew/cdKtysRyFQfhHr9bqm
 28uAQLomKWQynmsje9V0AJhY40QZnbSmtHrgO2EVZfH/89KE2vW+ljiEQiTx9E7BcXQMPs
 lVWH932NopJUoRnXsXc81An1WBhPo+w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-DSFhBqYIPLOoRyPjFo4WtQ-1; Mon, 08 Apr 2024 03:37:24 -0400
X-MC-Unique: DSFhBqYIPLOoRyPjFo4WtQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2a4f128896aso595980a91.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 00:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712561843; x=1713166643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jEtYmbfQjqgnJ3kHRalouPy2RRmrhg+WCoqzQNyLPM0=;
 b=L2igrRRTlZy3vgXWpTOEYL/fQQWo2chSjHR1gBaXtafsW/yZ4I7kxzb98bLvBa4hc2
 BfuCrJ2QU3LtaAPMd8tYjfjI6qa5fwpcVRoDOpbSFIMuDspKZl50ZOyifVgDJ24bTz08
 Ka5Z3y/1ZmxXL7vdwryqJmALQ/A5XsE2hfCZTN35rcM72Mc7gg16dxYsisYt+r8sGw/z
 Hym+u0htJeed9kJdxgpxJdNWeK6xWMUVITBxrfLWJBXYSX8YXcdi9SgLQc3UyY3a83lt
 e7taV6oEr4kea6o9wamL9S9/YZ+N/nWI785sBIDRPjLYhw1Lh8oV/qsHNcFzR4i572U2
 nA3w==
X-Gm-Message-State: AOJu0YwhZkjrMr30+cYNO7rHMSuLRDnTg6CVhG/SfaIMK6K7j//EgxlR
 rrNY4cRqInp6i+6oMps56tmSF4AUXssqqKSaPOkvAo4t9/D5LfkW4I6NHA6NpuiSKCXrKOA390o
 7XFiktNQtmaQgzcSK1cyLN6gI+MpwmLrckvJPnq9vM/OSpKAvpaumcuzmQKPrje+1edBHvVXIHc
 sOz7ViGMSRWReziCca7G3iQT5T1jo=
X-Received: by 2002:a17:90a:6447:b0:2a4:6ce7:37ad with SMTP id
 y7-20020a17090a644700b002a46ce737admr10460743pjm.5.1712561842999; 
 Mon, 08 Apr 2024 00:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDQ1ale+32xIsZDnAfGAGIhpz3Blqh7fGO7vfP69+ivjAOwqZYeXWbjJHNxooMkbBQouIq1l9ilCyCOgazyTs=
X-Received: by 2002:a17:90a:6447:b0:2a4:6ce7:37ad with SMTP id
 y7-20020a17090a644700b002a46ce737admr10460733pjm.5.1712561842729; Mon, 08 Apr
 2024 00:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240404191339.5688-1-philmd@linaro.org>
In-Reply-To: <20240404191339.5688-1-philmd@linaro.org>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Mon, 8 Apr 2024 09:37:11 +0200
Message-ID: <CAA8xKjVEL_AE7vM+tB=ypJ2YhuW7uYHOZdcAJDeUqEuO5iP6yw@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 0/4] hw/virtio: Protect from more DMA re-entrancy
 bugs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Amit Shah <amit@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Bulekov <alxndr@bu.edu>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Apr 4, 2024 at 9:13=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Gerd suggested to use the transport guard to protect the
> device from DMA re-entrancy abuses.

This was assigned CVE-2024-3446.

> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/virtio: Introduce virtio_bh_new_guarded() helper
>   hw/display/virtio-gpu: Protect from DMA re-entrancy bugs
>   hw/char/virtio-serial-bus: Protect from DMA re-entrancy bugs
>   hw/virtio/virtio-crypto: Protect from DMA re-entrancy bugs
>
>  include/hw/virtio/virtio.h  |  7 +++++++
>  hw/char/virtio-serial-bus.c |  3 +--
>  hw/display/virtio-gpu.c     |  6 ++----
>  hw/virtio/virtio-crypto.c   |  4 ++--
>  hw/virtio/virtio.c          | 10 ++++++++++
>  5 files changed, 22 insertions(+), 8 deletions(-)
>
> --
> 2.41.0
>

Thanks,
--
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


