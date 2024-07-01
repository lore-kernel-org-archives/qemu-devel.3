Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE22C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 20:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOO44-0002Qh-73; Mon, 01 Jul 2024 16:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOO42-0002Pe-Rf
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:55:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOO41-0002MG-Cj
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719867352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OksLQoJZL3O26+Jbm1nROE46FmsThCOxTJF001/yZIg=;
 b=aqYDdSkShJQfx4+4eMYZdns6jq+Wcfv1pT9FdAiuoA2S8Gdzv44r2xWN6hBYrAfG3qhqeB
 uXgO/A+G38c7X0AdBCekkg3ETW+jks8bcJXEdKNmg4tb/VgUOA8obAjPDd8fT+OUOE9Ixt
 pxWgPdlp1ZGdrZJRUyZ0GoQnBE3SG1Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-38ODNo8GOfytc3jDh3A2Pw-1; Mon, 01 Jul 2024 16:55:50 -0400
X-MC-Unique: 38ODNo8GOfytc3jDh3A2Pw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-364b75a8194so2145577f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 13:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719867349; x=1720472149;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OksLQoJZL3O26+Jbm1nROE46FmsThCOxTJF001/yZIg=;
 b=Mbx15fBjeW1HZZUaXk0kikHZ0B4pgAuhK9yUKJW7ClQwvkuPvfoavvwUKYHGFbIEay
 5qGHtjecpte0IV2wRXQegzgPuJlBgvkYUDW6RFpy6wUGTnaf8TphKcGKnY9HNprfSF3q
 tObH8zNK8fXPGv9hnBhjxOdvW0qcFClEpcwmqGRmNtbqml2weSIm68lWQZuLj8uQ82/J
 kjrmtNQD8d5ifTfpFQsll2j8HxPUmjmNWN4IXr/YJJ3EJ1fX8vk8m2a/i6kU+W4sKGlr
 RgdUd3LuHV8Pr1IrflPTuz5t2uij+YfvjnOOjOCq/tshpMrIIb4I4DSCjq1RODZb97vy
 yo6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWji5QIOHXJ86sZM7BShCvFVcGdTESO4adUiCXh2cAgMeirABmA55V1M/haiitowp6WrGRfqnUymzDkR9Qz7NeHh0DI3tw=
X-Gm-Message-State: AOJu0Yw+Wa8qLcDFY0R8qENsUAsN+ILJYndqitFjCWxG/LNauDpjzQIh
 8xXIVQGFpZlo43eKpRKf9KyqVLJEibkF1meJhtWihIxaZUWC/JC5xAhYktFz3Qt0UPxCfCu+srS
 a+qhuKN9IIbit90wjTWkR2TqmlonyGs23jr+PbHn31vSixJO6LZWa
X-Received: by 2002:a5d:55ca:0:b0:365:80af:f69e with SMTP id
 ffacd0b85a97d-367756c7298mr4053135f8f.37.1719867349654; 
 Mon, 01 Jul 2024 13:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4kkwCUCGMEIEbRn4gNGBN8cPAR846j0/VHOzHedYyVyLFXvCaPj6M6MWqHnWUzz1uc65gZw==
X-Received: by 2002:a5d:55ca:0:b0:365:80af:f69e with SMTP id
 ffacd0b85a97d-367756c7298mr4053119f8f.37.1719867349036; 
 Mon, 01 Jul 2024 13:55:49 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd623sm11082064f8f.16.2024.07.01.13.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 13:55:48 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:55:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael@enfabrica.net>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 yc-core@yandex-team.ru
Subject: Re: [PATCH v5 0/3] vhost-user-blk: live resize additional APIs
Message-ID: <20240701165515-mutt-send-email-mst@kernel.org>
References: <20240625121843.120035-1-vsementsov@yandex-team.ru>
 <CAMDpr=cyULZmtaodbmET_NEfYMhfXT2ndQ8S8vjDrapG6PUsRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMDpr=cyULZmtaodbmET_NEfYMhfXT2ndQ8S8vjDrapG6PUsRg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 01, 2024 at 08:42:39AM -0400, Raphael Norwitz wrote:
> I have no issues with these APIs, but I'm not a QMP expert so others
> should review those bits.
> 
> For the vhost-user-blk code:
> 
> Acked-by: Raphael Norwitz <raphael@enfabrica.net>

Could the relevant bits get ack from qapi maintainers please?



> On Tue, Jun 25, 2024 at 8:19 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
> >
> > v5:
> > 03: drop extra check on is is runstate running
> >
> >
> > Vladimir Sementsov-Ogievskiy (3):
> >   qdev-monitor: add option to report GenericError from find_device_state
> >   vhost-user-blk: split vhost_user_blk_sync_config()
> >   qapi: introduce device-sync-config
> >
> >  hw/block/vhost-user-blk.c | 27 ++++++++++++++------
> >  hw/virtio/virtio-pci.c    |  9 +++++++
> >  include/hw/qdev-core.h    |  3 +++
> >  qapi/qdev.json            | 24 ++++++++++++++++++
> >  system/qdev-monitor.c     | 53 ++++++++++++++++++++++++++++++++++++---
> >  5 files changed, 105 insertions(+), 11 deletions(-)
> >
> > --
> > 2.34.1
> >


