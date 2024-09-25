Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C403AC369AA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 07:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stMuZ-0003UA-2a; Wed, 25 Sep 2024 03:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1stMuX-0003Tg-PA
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 03:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1stMuV-0003a7-Tz
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 03:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727251086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WqzX0PV3OArbYOuyuFGxJuSMi6W9uisoy9et5b64Sb0=;
 b=GJwFyhZITsZkgBSpj8JW2cPdLb1HXxfZOkn05rlVu3BJ86KLN3RwEtp2oaKqdbzGKuJ6W0
 y71vDZ7hToeWJrS3iMZYUWEgwWONua7P/yzaNu0OadBp6gm13HISQgkmEeXxegru9f7H0B
 4w9hpy3oPb3tDGFz3xPp15BSOw4MTDE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-cKQkRYU9M6-ISxSVkRljpg-1; Wed, 25 Sep 2024 03:58:02 -0400
X-MC-Unique: cKQkRYU9M6-ISxSVkRljpg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5c3c205df73so3449599a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 00:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727251082; x=1727855882;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WqzX0PV3OArbYOuyuFGxJuSMi6W9uisoy9et5b64Sb0=;
 b=fmWouOupY+dt/JmFG/TKDP/DbPAqhe+72zloo6HeOQ3b6qVce0aRue/+SJRPXE6pX5
 Kmo7TTxJTF6IEO0EmV3Svcl7bUXRaGudGlIf2rDIlCbW+j2Q574MylITkAwo94wu3uVO
 njUyFreUiLX0iEbOsbuFV7BQR//64dYRNLGHzQfa+b/a2uw2bPBOUD6wM/y30JxUqDkJ
 vnYMifFZFl7AnVzc7yVxoZR3Xj88pBEyXjAQztiWCDI0EqiCC0GeKGNmPSUo2uQqH7io
 2BhBI8rPSn7LlZRKZss5lfd1GG3ozkHZ003oykzIHa0UIKQJ0vkfjWX3sy2UyVb0VnoN
 dTIw==
X-Gm-Message-State: AOJu0Yzrg5ezjurWXbNjR27roTw9jS/QRmMM5rDsGMPLyO89g0nCv8t5
 J2bEE1TWnPGE/HhLk12j2yKa3/GnoXqE39dwc4pJ9ZUbrMx20IM8QhdrlxH5ValIruTum/3QYmW
 W2WDJUwuxkwAR1jkC+9RCTbJthSuwjp96b0S+t83mUKnWQIbBfQPs
X-Received: by 2002:a05:6402:34c6:b0:5c2:7699:fb6f with SMTP id
 4fb4d7f45d1cf-5c720624c8fmr989245a12.15.1727251081723; 
 Wed, 25 Sep 2024 00:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6GlX/kZMmsqXiMzeG89EtbwC8Mtv3OSGori/C918WzZSJ63yMHVB5VSn40zdGxl70J5iOhA==
X-Received: by 2002:a05:6402:34c6:b0:5c2:7699:fb6f with SMTP id
 4fb4d7f45d1cf-5c720624c8fmr989210a12.15.1727251081082; 
 Wed, 25 Sep 2024 00:58:01 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it.
 [79.46.200.231]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf48c238sm1575412a12.7.2024.09.25.00.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 00:58:00 -0700 (PDT)
Date: Wed, 25 Sep 2024 09:57:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>, 
 Peter Xu <peterx@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Hyman Huang <yong.huang@smartx.com>, 
 Klaus Jensen <its@irrelevant.dk>, Alexandre Iooss <erdnaxe@crans.org>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Jesper Devantier <foss@defmacro.it>, Bin Meng <bin.meng@windriver.com>,
 Greg Kurz <groug@kaod.org>, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, 
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 09/22] hw/vhost-scsi: fix -Werror=maybe-uninitialized
Message-ID: <muurrvm7xjkjsdlq3ux6fvfdu5pjnhsl3j4o5ripnmoqs6bh4o@rvpokrpdmdoe>
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924130554.749278-10-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 24, 2024 at 05:05:40PM GMT, marcandre.lureau@redhat.com wrote:
>From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
>../hw/scsi/vhost-scsi.c:173:12: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>
>It can be reached when num_queues=0. It probably doesn't make much sense
>to instantiate a vhost-scsi with 0 IO queues though. For now, make
>vhost_scsi_set_workers() return success/0 anyway, when no workers have
>been setup.

I agree, for vhost_scsi_set_workers() point of view, it doesn't need to
add a new worker in that case, so it should be fine to return 0.

If we really want to fail when num_queues=0, maybe it should be in
vhost_scsi_realize().

>
>Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
> hw/scsi/vhost-scsi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>index 49cff2a0cb..22d16dc26b 100644
>--- a/hw/scsi/vhost-scsi.c
>+++ b/hw/scsi/vhost-scsi.c
>@@ -172,7 +172,7 @@ static int vhost_scsi_set_workers(VHostSCSICommon *vsc, bool per_virtqueue)
>     struct vhost_dev *dev = &vsc->dev;
>     struct vhost_vring_worker vq_worker;
>     struct vhost_worker_state worker;
>-    int i, ret;
>+    int i, ret = 0;
>
>     /* Use default worker */
>     if (!per_virtqueue || dev->nvqs == VHOST_SCSI_VQ_NUM_FIXED + 1) {

Another option could have been to edit this check:
       if (!per_virtqueue || dev->nvqs <= VHOST_SCSI_VQ_NUM_FIXED + 1) {
           return 0;
       }

But I'm fine with your change:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


