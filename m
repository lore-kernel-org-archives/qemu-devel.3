Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD50C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 13:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tab01-0005CS-Va; Wed, 22 Jan 2025 08:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1taazz-0005C4-JE
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:42:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1taazx-000776-BN
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737553342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nwq/XVUe50r3bRtM6BoABxWCfhWdvZt8f3LeGb202bg=;
 b=WymTMp4j4OeNTAYBfJE1ynZfzN2MTSmaSwxVIxsB8E1zqSOYKyOckkmhgcGdTcl4cK+pYc
 zWjFHVAQZ4t5nMJVX6K59BZXImGeRB6jBPzKsEECJ9y7SgD6oYnmi5kbV+pYwwajk/mQll
 21tWNKisZ76TSFDkiLn1dqV7kV+RzUQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-oCO0baWxNbKhTYa9-oo7Pg-1; Wed, 22 Jan 2025 08:42:21 -0500
X-MC-Unique: oCO0baWxNbKhTYa9-oo7Pg-1
X-Mimecast-MFC-AGG-ID: oCO0baWxNbKhTYa9-oo7Pg
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5dbaaed8aeeso5102208a12.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 05:42:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737553340; x=1738158140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwq/XVUe50r3bRtM6BoABxWCfhWdvZt8f3LeGb202bg=;
 b=kCvpvncaiHJLaZCxfFeFDovX2AfST+Kn0ycvVHspOg1iRP5jnc0ObKr/jWQtk78nFR
 NAJp8lzhGKE9rKKB9G9gz3vmXQKuADoeSvkyyd5/ljrh8OCrb8STS8tO7nbaw0ithD2b
 tCBZM9c3cPzWQWzoMJrJRjPZ0s+grnqrMjktY6jW2o3krQhtkAzzsqskfGAFJtGEtVv4
 30KR9q4U26umAhVKN2xfkb/IfHAY2K/bg3ht/PxQD2mHfMGyq3ySbfgGzfsG1n16JasO
 jzflx7UR+OF4/tlz44L9t7zJunJaWtrqFDoQm9YrrnrvHf7nIWDdy6U/jj1QboMbHHLu
 rX5g==
X-Gm-Message-State: AOJu0YzefL2Y9BQnNHVRR/kq2XP5e+FbPz3ESukkH7o2Gsr4fC9Pxre3
 x1pZo4naDfZgbJeGXcBZGXD/hu3V7YDodn0LbvermeXWbW+P5u+8tNfx6bDXeTSX4LFy4252uQC
 GT3wWQ9R93DiCmMJ2zsOJrnOIdJeTYiz6o4y0CZ+iVj8oQYoduiuQ
X-Gm-Gg: ASbGncvM1HMP3Nx/uogLuzCbfIVS5PPiVbiw2uufn/fmarCu2iXKfGS4tnSnoqQ1KN6
 T/TL17FkgbUysztN3ViEdI55FziUBCehGu6YjuV6nLknjOV2yrbKBbUdLYr+gv6OXVyJVfyWjrB
 SgaljYyLnz8Xkz1GckYzDjiSPP/jnAAcLKvn9bUIefTRAZuAiCbfeYKUGExwFs4Pphl28u+1Zm6
 dQjRHGMdqhavuUG5O00teDsG6WqZ6pMKmQhqQQIsKtrT6Go6SXFT8vRk+SFzAHi6rZJh8VbJ/SV
 GlOaSsZsDvpqR0g4puAiSu5yxeFpcaVwscXFn9Zj6dwYmA==
X-Received: by 2002:a17:907:3f23:b0:ab6:4fa2:80c1 with SMTP id
 a640c23a62f3a-ab64fa2839bmr342750766b.52.1737553339741; 
 Wed, 22 Jan 2025 05:42:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKmEjHyM/VG581KdwDx9cXU70WdTg+Nq6wItYaPvDb2VW66xeM+wTWI59uEqHy610YsAZdNA==
X-Received: by 2002:a17:907:3f23:b0:ab6:4fa2:80c1 with SMTP id
 a640c23a62f3a-ab64fa2839bmr342747366b.52.1737553338977; 
 Wed, 22 Jan 2025 05:42:18 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it.
 [82.53.134.100]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c5ad7bsm909449066b.36.2025.01.22.05.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 05:42:18 -0800 (PST)
Date: Wed, 22 Jan 2025 14:42:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
Message-ID: <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
References: <20250121100029.1106973-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250121100029.1106973-1-lvivier@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

On Tue, Jan 21, 2025 at 11:00:29AM +0100, Laurent Vivier wrote:
>In vhost_user_receive() if vhost_net_notify_migration_done() reports
>an error we display on the console:
>
>  Vhost user backend fails to broadcast fake RARP
>
>This message can be useful if there is a problem to execute
>VHOST_USER_SEND_RARP but it is useless if the backend doesn't
>support VHOST_USER_PROTOCOL_F_RARP.
>
>Don't report the error if vhost_net_notify_migration_done()
>returns -ENOTSUP (from vhost_user_migration_done())
>
>Update vhost_net-stub.c to return -ENOTSUP too.
>
>Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>---
> hw/net/vhost_net-stub.c | 2 +-
> net/vhost-user.c        | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
>index 72df6d757e4d..875cd6c2b9c8 100644
>--- a/hw/net/vhost_net-stub.c
>+++ b/hw/net/vhost_net-stub.c
>@@ -93,7 +93,7 @@ void vhost_net_config_mask(VHostNetState *net, VirtIODevice *dev, bool mask)
>
> int vhost_net_notify_migration_done(struct vhost_net *net, char* mac_addr)
> {
>-    return -1;
>+    return -ENOTSUP;
> }
>
> VHostNetState *get_vhost_net(NetClientState *nc)
>diff --git a/net/vhost-user.c b/net/vhost-user.c
>index 12555518e838..636fff8a84a2 100644
>--- a/net/vhost-user.c
>+++ b/net/vhost-user.c
>@@ -146,7 +146,7 @@ static ssize_t vhost_user_receive(NetClientState *nc, const uint8_t *buf,
>
>         r = vhost_net_notify_migration_done(s->vhost_net, mac_addr);
>
>-        if ((r != 0) && (display_rarp_failure)) {
>+        if ((r != 0) && (r != -ENOTSUP) && (display_rarp_failure)) {
>             fprintf(stderr,
>                     "Vhost user backend fails to broadcast fake RARP\n");
>             fflush(stderr);
>-- 
>2.47.1
>

IIUC the message was there since the introduction about 10 years ago
from commit 3e866365e1 ("vhost user: add rarp sending after live
migration for legacy guest"). IIUC -ENOTSUP is returned when both F_RARP
and F_GUEST_ANNOUNCE are not negotiated.

That said, I honestly don't know what F_RARP or F_GUEST_ANNOUNCE is for,
but my understanding is that the message was to notify that the
migration was finished (reading that commit).

If neither feature is supported, could this be a problem for the user
and that's why we were printing the message?

Thanks,
Stefano


