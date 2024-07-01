Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA777C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGMx-00022b-5M; Mon, 01 Jul 2024 08:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1sOGMv-00022B-2o
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:42:53 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1sOGMt-0002Jb-FI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:42:52 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-444fdb6c1cfso19752571cf.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enfabrica.net; s=google; t=1719837770; x=1720442570; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJ0IhviA2vf7Trus2oxOClKim1qYAetPJxNjLf49Z1w=;
 b=QWtidk3WAduXPJs80bAN40Nly17CcfFQr0WT+Hfnqcn1xI7x9+Pr+82bno2fQ9Mwlk
 2hJGwsB06z/ic954AXNamdI0cFDQaFacjQt2u5TwHccsQysLe++8na+J1d0X/oiucfQv
 iI405Lzq/KCX3fZdtcBD1U02i23voZx2VxcpVBZmCDqeXY56aiBbObN6j5q8ZOovmd9p
 +ZQlcao0QjTZzWSpf4Fcp+K1H49z/+7qxDaF8iNOmNhgFCOFi70xJTGD7WmiOryXAXMK
 SLwtKnpI558PGqKYL4hOXsKmiFTJn2PG9Qu1H5b/yiKwTsdQf21LvoKFNDkDar3THZ3E
 tslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719837770; x=1720442570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJ0IhviA2vf7Trus2oxOClKim1qYAetPJxNjLf49Z1w=;
 b=kQxefwq2x7Vf6g6GqIouQzzk0rFdzhXLpoIWw8Dtn/suZpw/q4LBD6UiIT89C4H0KE
 aSZKspPdStjnbmZAXnSRgckSZKGNJvuw8UuS8MmJ6sDOqeYH+VTvnAEGBg16+s/o0CvI
 0ShIC27R64RhnjON/ALNBZmM5zYbsBlLhA/BnSzCuBeqHM7ATBm/I2B+B+hthth7zwZX
 nvYUci7jB1YJ2XAZ7mfTBHSsiJzd2vif5TMgilG/dUGvv/IJjIS6W2O9PcAmEdzYpMJ+
 1Tz/vqqkuK3iudXpsNgrg+Wsr8r/2eyxpK8J91N7zSTjWVopN71INoqMw1YVgmjPO0XZ
 0G9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU84+ssutvba2pyh8iWfit5UDh1HWdfLv95rGsu/aO6iHW2cR7BGbmKe0Q46mrg97DJfAJeIyH/V4jib5q+avPERuD8Xc4=
X-Gm-Message-State: AOJu0Yzlek/v01uJDy9+QtfOpSoA0F/yiaj2Krjw86DXsNgyhpkm0J1L
 fbmMJmZM+VjQcHhApALnMc8ibjfXNhhdocjF7udkMHr0hOet/0NgVhpgNFrTRNDpbrCQ0iZXScU
 fDcsJ4hnp1M6EJL6jEDia0qx3pvstGZABIyAW8g==
X-Google-Smtp-Source: AGHT+IHk1eU4/diMbTbKpj2wfV2fEqMgAti/d9yMlURU3sn7Y9TFWYkpHRVAri6n0jljjKoml0CdOSaU27IRGuZNvvo=
X-Received: by 2002:a05:6214:242c:b0:6b0:8222:ba49 with SMTP id
 6a1803df08f44-6b5b709a9e4mr76718226d6.16.1719837769959; Mon, 01 Jul 2024
 05:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240625121843.120035-1-vsementsov@yandex-team.ru>
In-Reply-To: <20240625121843.120035-1-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael@enfabrica.net>
Date: Mon, 1 Jul 2024 08:42:39 -0400
Message-ID: <CAMDpr=cyULZmtaodbmET_NEfYMhfXT2ndQ8S8vjDrapG6PUsRg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] vhost-user-blk: live resize additional APIs
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org, 
 armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net, 
 berrange@redhat.com, pbonzini@redhat.com, hreitz@redhat.com, kwolf@redhat.com, 
 yc-core@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=raphael@enfabrica.net; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I have no issues with these APIs, but I'm not a QMP expert so others
should review those bits.

For the vhost-user-blk code:

Acked-by: Raphael Norwitz <raphael@enfabrica.net>

On Tue, Jun 25, 2024 at 8:19=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> v5:
> 03: drop extra check on is is runstate running
>
>
> Vladimir Sementsov-Ogievskiy (3):
>   qdev-monitor: add option to report GenericError from find_device_state
>   vhost-user-blk: split vhost_user_blk_sync_config()
>   qapi: introduce device-sync-config
>
>  hw/block/vhost-user-blk.c | 27 ++++++++++++++------
>  hw/virtio/virtio-pci.c    |  9 +++++++
>  include/hw/qdev-core.h    |  3 +++
>  qapi/qdev.json            | 24 ++++++++++++++++++
>  system/qdev-monitor.c     | 53 ++++++++++++++++++++++++++++++++++++---
>  5 files changed, 105 insertions(+), 11 deletions(-)
>
> --
> 2.34.1
>

