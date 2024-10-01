Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F552CEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svePg-0005NN-9x; Tue, 01 Oct 2024 11:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sveOg-00055X-Es
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sveOe-00007y-Ko
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727794959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QBjl694dZRzTw8MMM7D4i49DF9KvCq0UAnuRtfQmI4g=;
 b=SIKUC1omnjsk+o21SS2uTI0C+KtFNsemPWMOvnW5MF5g3xEnbjQDjiUWGnFNulsWv2vxZD
 9bYg+YgcCCOqs97rztzVbql0FDzs7rPdPtvvMpbLKlfepqcaG3nrNtHWSERQ9Jc2NVsdLD
 NzjEhqK0A8jud8rm1Gyhj8o0RxRbgdQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-IHbeWuSGOqu2SFQ0zEgDLg-1; Tue, 01 Oct 2024 08:49:53 -0400
X-MC-Unique: IHbeWuSGOqu2SFQ0zEgDLg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7c6a9c1a9b8so3431780a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 05:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727786992; x=1728391792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBjl694dZRzTw8MMM7D4i49DF9KvCq0UAnuRtfQmI4g=;
 b=JRFXbiC3TfODdK32/zvXQ1Se5pOYSl+b6Fmgu04C11xcPpkjWd4NdyH4VI/Lpj8Ss7
 L9O3nIJ8OA66yLqfOvMyHbJBESeXD132XnNV274FKPdx9dDT7z+nd+cqJHllF+URrbPD
 pDDBtXxHBz3kSN32lt7Lc+ic54Hn7bC3u//HBPkouAZO4Dfce7rZAV3ibiNkzybUK7YZ
 QTOoCEQESkCOzh6n3AkV4xAAfZHc1nks4D8/aiCsp2ZDToMSbX93+2aGKfol5EZtwj5O
 re+LXVsSOFavz2W/vwRJ1zgmZ6SPdRkv274WfZtkGcn7N0BvZ+dMscEgPioCkTetphEg
 1New==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+DyNwkUV9PkBFCtB4xHQYUUjNV3qOdtGqCF9HbLd+ITU4c45dSwppjx+bip7gREXZ0sGtKbvrgF8c@nongnu.org
X-Gm-Message-State: AOJu0YyjGSOlkECLZ+TVkjvIsDmwy/DM1tRntdJ2jIXoELMqnUxbh4jf
 CVZiG9oqDxmnR+IV4yfmiLWJg9qEQufd90wEp90MdLlyGBVwugz6Zi1rfoDvjBJPmNzZjgKhQKL
 t6jPt3dQAIXrVRZGgGsW/n9x/Rt4ri/VPR8NtrpngMcuPYtOuToJT
X-Received: by 2002:a05:6a20:9c8e:b0:1c0:ef24:4125 with SMTP id
 adf61e73a8af0-1d4fa6feaa8mr20297145637.26.1727786992123; 
 Tue, 01 Oct 2024 05:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWWh7OvXqIoi2fArxikG6xwa+Azfi/JDOtD9AV9hh0XlVGbpBAbaeRv7l7M8ELFMdfrSKAmg==
X-Received: by 2002:a05:6a20:9c8e:b0:1c0:ef24:4125 with SMTP id
 adf61e73a8af0-1d4fa6feaa8mr20297123637.26.1727786991670; 
 Tue, 01 Oct 2024 05:49:51 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it.
 [79.46.200.231]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2652492csm8232840b3a.147.2024.10.01.05.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:49:51 -0700 (PDT)
Date: Tue, 1 Oct 2024 14:49:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, raphael@enfabrica.net, mst@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6 2/3] vhost-user-blk: split vhost_user_blk_sync_config()
Message-ID: <lemecbqh2krbemhpt2m7r2gc5reet7ikjoh2gxcbeig2l552tr@al2eoewutqwp>
References: <20240920094936.450987-1-vsementsov@yandex-team.ru>
 <20240920094936.450987-3-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240920094936.450987-3-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 20, 2024 at 12:49:35PM GMT, Vladimir Sementsov-Ogievskiy wrote:
>Split vhost_user_blk_sync_config() out from
>vhost_user_blk_handle_config_change(), to be reused in the following
>commit.
>
>Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>Acked-by: Raphael Norwitz <raphael@enfabrica.net>
>---
> hw/block/vhost-user-blk.c | 26 +++++++++++++++++++-------
> 1 file changed, 19 insertions(+), 7 deletions(-)
>
>diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>index 5b7f46bbb0..48b3dabb8d 100644
>--- a/hw/block/vhost-user-blk.c
>+++ b/hw/block/vhost-user-blk.c
>@@ -90,27 +90,39 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
>     s->blkcfg.wce = blkcfg->wce;
> }
>
>+static int vhost_user_blk_sync_config(DeviceState *dev, Error **errp)

I was going to ask why use `DeviceState *`, but then I saw the next 
commit where it's needed by `dc->sync_config` callback.

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>+{
>+    int ret;
>+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
>+
>+    ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
>+                               vdev->config_len, errp);
>+    if (ret < 0) {
>+        return ret;
>+    }
>+
>+    memcpy(vdev->config, &s->blkcfg, vdev->config_len);
>+    virtio_notify_config(vdev);
>+
>+    return 0;
>+}
>+
> static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
> {
>     int ret;
>-    VirtIODevice *vdev = dev->vdev;
>-    VHostUserBlk *s = VHOST_USER_BLK(dev->vdev);
>     Error *local_err = NULL;
>
>     if (!dev->started) {
>         return 0;
>     }
>
>-    ret = vhost_dev_get_config(dev, (uint8_t *)&s->blkcfg,
>-                               vdev->config_len, &local_err);
>+    ret = vhost_user_blk_sync_config(DEVICE(dev->vdev), &local_err);
>     if (ret < 0) {
>         error_report_err(local_err);
>         return ret;
>     }
>
>-    memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
>-    virtio_notify_config(dev->vdev);
>-
>     return 0;
> }
>
>-- 
>2.34.1
>


