Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE4FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 08:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZRJX-0000w1-N5; Thu, 01 Aug 2024 04:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZRJJ-00005z-8N
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZRJF-0002TX-13
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722501436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1zaECNm3s5CKJFJc2z5d2kV3DHGCcU1/iCKTLB7+gws=;
 b=Ge++k25LQCa66X8WfJ9NrmZy8GzPp7ri3ym8qAprRlInzyGEVxGZ9uL6rFolSI6qQCJGoy
 StENXgEg6ByvDDezFDE2zs449lWzJc+7f8MYymL1D59JdjxA22tHOsLFdp/2z91ls9etN8
 0aGrGxOYjsmiKUimvSnCg5oP0DoJPSw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-ilMIx5SlNKe2AFC7tpSD1A-1; Thu, 01 Aug 2024 04:37:14 -0400
X-MC-Unique: ilMIx5SlNKe2AFC7tpSD1A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7a979cae97so586062466b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 01:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722501432; x=1723106232;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1zaECNm3s5CKJFJc2z5d2kV3DHGCcU1/iCKTLB7+gws=;
 b=mW2SGkQ0savqTRw+SROU2smjSBc/h8xhWEaSXDre08TLlWi+Y5w9w4YZPxx7HhrVUv
 XxNeIzZiBGSP6dtBrmVaHKnlwl8y5SWBy09ym09YfLf6BXJoctiWeIlG8eAUioDBNq4R
 pgDxXFZN3yUElGSoopwOhbivYROXDcq9wSDj/ka40qkclnFKKM9xC8VPwVkPqSOutvgp
 ZKr1h1FJ7jCWPhOkd9GJ2jkZH+xHsqQj+L5SH8GYOcSRTVmzmnWS2P1v23rLd5fXttrm
 5AbrJLQRz0LrYll7WjWW1pYgKwIjhL7HUxGcPllrb7Fxf/cnq6Q2Ob0mPo5itfRE02+/
 2EAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL/bQIZ5GsZEW7XALbtYJTT9IjZiBiJpC1aT5RXWuFTloQAghRViSXSebcHUXJBwRCFDrHkqb6AMxKulGhUg0vC1IvK00=
X-Gm-Message-State: AOJu0YxkimcoqAYDNIOzE/9iOehu0Nmm1OWePJQotJ14YMAj6ZLzDkrx
 9xF1gDzacYGXvPNG8dO0DVfKqVQFjU6qVYDOrOwHhrQkKblHbQrVxX0R8OOKPmHMciy2moTn42q
 5wNPcWS02+64S8z6aq/lr5Qv+QykHF/hJtWvo6oKVVQu9zyJ9Pm2+A8IlTY/+
X-Received: by 2002:a17:907:6d1a:b0:a77:cacf:58b5 with SMTP id
 a640c23a62f3a-a7daf4fbcc1mr120412666b.1.1722501432396; 
 Thu, 01 Aug 2024 01:37:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1Y+98HljwUdbfDHus6Axc5xBKXyu72N3s/a/9/k0IJGohHHs0QJyuWM/MYpmCDvILX7FDJg==
X-Received: by 2002:a17:907:6d1a:b0:a77:cacf:58b5 with SMTP id
 a640c23a62f3a-a7daf4fbcc1mr120409766b.1.1722501431721; 
 Thu, 01 Aug 2024 01:37:11 -0700 (PDT)
Received: from redhat.com ([2.55.14.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab4de6fsm871684666b.63.2024.08.01.01.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 01:37:09 -0700 (PDT)
Date: Thu, 1 Aug 2024 04:37:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Raphael Norwitz <raphael@enfabrica.net>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, berrange@redhat.com, pbonzini@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, yc-core@yandex-team.ru
Subject: Re: [PATCH v5 0/3] vhost-user-blk: live resize additional APIs
Message-ID: <20240801043643-mutt-send-email-mst@kernel.org>
References: <20240625121843.120035-1-vsementsov@yandex-team.ru>
 <CAMDpr=cyULZmtaodbmET_NEfYMhfXT2ndQ8S8vjDrapG6PUsRg@mail.gmail.com>
 <20240701165515-mutt-send-email-mst@kernel.org>
 <96c93d33-ac30-4c0d-97a4-4696825d436d@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96c93d33-ac30-4c0d-97a4-4696825d436d@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 01, 2024 at 11:35:19AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 01.07.24 23:55, Michael S. Tsirkin wrote:
> > On Mon, Jul 01, 2024 at 08:42:39AM -0400, Raphael Norwitz wrote:
> > > I have no issues with these APIs, but I'm not a QMP expert so others
> > > should review those bits.
> > > 
> > > For the vhost-user-blk code:
> > > 
> > > Acked-by: Raphael Norwitz <raphael@enfabrica.net>
> > 
> > Could the relevant bits get ack from qapi maintainers please?
> > 
> 
> We go them. Could you queue the patches please?


Tagged for after the freeze. Thanks!

> > 
> > 
> > > On Tue, Jun 25, 2024 at 8:19 AM Vladimir Sementsov-Ogievskiy
> > > <vsementsov@yandex-team.ru> wrote:
> > > > 
> > > > v5:
> > > > 03: drop extra check on is is runstate running
> > > > 
> > > > 
> > > > Vladimir Sementsov-Ogievskiy (3):
> > > >    qdev-monitor: add option to report GenericError from find_device_state
> > > >    vhost-user-blk: split vhost_user_blk_sync_config()
> > > >    qapi: introduce device-sync-config
> > > > 
> > > >   hw/block/vhost-user-blk.c | 27 ++++++++++++++------
> > > >   hw/virtio/virtio-pci.c    |  9 +++++++
> > > >   include/hw/qdev-core.h    |  3 +++
> > > >   qapi/qdev.json            | 24 ++++++++++++++++++
> > > >   system/qdev-monitor.c     | 53 ++++++++++++++++++++++++++++++++++++---
> > > >   5 files changed, 105 insertions(+), 11 deletions(-)
> > > > 
> > > > --
> > > > 2.34.1
> > > > 
> > 
> 
> -- 
> Best regards,
> Vladimir


