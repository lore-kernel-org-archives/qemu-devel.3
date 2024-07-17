Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C466C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUC60-0006mI-PE; Wed, 17 Jul 2024 17:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUC5z-0006lo-EL
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUC5x-0003CG-PX
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721251311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=js3S84Z15ZhWXmeT7D/3iloxt/WDDBrpAqoTsdA+u6U=;
 b=cmF/7S06rNTNHeJhIz4Vjn05IKOSqFvV+sai9w3hX7fGaNJiuIf3iKYqhcojvUwr+T3E3k
 S0I6ahqBKJ1qJtlo55g0YtdjT8JpSlaXJ7HfJ/J/2uplC7V4iNHfH52obaUNz7dAi3deBA
 TM8WKQHIFmmlIMSlrZHlLlhCK99d8vs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-75jr3Tx7P4y3onq_mbLk3g-1; Wed, 17 Jul 2024 17:21:49 -0400
X-MC-Unique: 75jr3Tx7P4y3onq_mbLk3g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b60afbf5d1so476336d6.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721251308; x=1721856108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=js3S84Z15ZhWXmeT7D/3iloxt/WDDBrpAqoTsdA+u6U=;
 b=msNQpccn5r9qFalpDhFkUNt519r929TLh4gPLfGmLyNciurswEvp8CBrvaeJ5pekSr
 ZbTlJzdhTaY72jx3ibFcH3Bm+ywgrUOYWy8yO/m9oQLX30fc8Na0wt2LQtFGZpOc3wl+
 C5z7Aagjw+4ralp2t1JRSkyfj/O0SCh1sxu84xLHoE2KYOxVAUWU6BwFl3NDz+ChE1G7
 Xt6Ot5yY1bLPU/p3tLEDCW5dR9/PPmjkfwCvFa4nQ/o426Cf+ZwWzgnrlYdS7oBny4jn
 V2NUxy7pei5IgyED6zljvLVj3Pn9AJEzoSc1q9g0JFzFZ98NhsgPJC3bH2BJcAnfq04B
 4y+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5gWxmcaX9aLrJMvJVmrfQK7V4ws/juE6B9j5LEkbwVIhnq6yXaquP2Kh7luHCdFKm8aOyaTwTc9eJ2drW40ny1P/v+T0=
X-Gm-Message-State: AOJu0YzkZIkBrwDQPVnSGaoaZBXHUTft1RtnOoPAuIypp/SugK0C/t+j
 h6wS7CkRlC+6oJ/nGsELaUf7N8ls8R0K88ikZ28OhzGYkPFrrvHOhTBcYcoNW3v3/F63LVL8/qy
 ehJwyLj5o50OnjfHTGSovQg6buQHzNYrc0H2DW2bHqr6CDdA3jvy9
X-Received: by 2002:a05:6214:31a1:b0:6b7:64a2:3189 with SMTP id
 6a1803df08f44-6b79cb4f37cmr4312586d6.8.1721251308442; 
 Wed, 17 Jul 2024 14:21:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsSuWm6s22xXbeqlanWS0ZCH3KNbqy9McSReE7csbZiiIQQsW8BfRM2tQBGalAAPVxWbMi/Q==
X-Received: by 2002:a05:6214:31a1:b0:6b7:64a2:3189 with SMTP id
 6a1803df08f44-6b79cb4f37cmr4312466d6.8.1721251308063; 
 Wed, 17 Jul 2024 14:21:48 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b79c606828sm2253276d6.101.2024.07.17.14.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 14:21:47 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:21:44 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 00/13] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <Zpg16Gik1RzynCb3@x1n>
References: <9e85016e-ac72-4207-8e69-8cba054cefb7@maciej.szmigiero.name>
 <Znt0FQHJEtGxcLxj@x1n>
 <2066bb2e-ccb3-45b8-aaf7-c39303e7f993@maciej.szmigiero.name>
 <ZnxAZDcjlZ5oerq-@x1n>
 <73630858-3b65-4fc5-8f5f-a1f494c5c111@maciej.szmigiero.name>
 <Zn19kaeFiYuwwc4B@x1n>
 <35969f33-f6f3-4c34-8b9d-8c1ebac3305e@maciej.szmigiero.name>
 <ZpgSTCAGbKwWi_o8@x1n> <87msmf22m4.fsf@suse.de>
 <2e0319ef-aba0-4a14-b49f-9e3c5724e438@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e0319ef-aba0-4a14-b49f-9e3c5724e438@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jul 17, 2024 at 11:07:43PM +0200, Maciej S. Szmigiero wrote:
> > Don't wait on me. I think I can make the changes Peter suggested without
> > affecting too much the interfaces used by this series. If it comes to
> > it, I can rebase this series "under" Maciej's.
> 
> So to be clear, I should base my series on top of your existing RFC patch set
> and then we'll swap these RFC patches for the updated versions, correct?

I'm not sure that's good.. since the VFIO series should depend heavily on
that RFC series IIUC, and if the RFC is prone to major changes, maybe we
should still work that out (or the next rebase can change a lot, void again
most of VFIO tests to carry out)?

-- 
Peter Xu


