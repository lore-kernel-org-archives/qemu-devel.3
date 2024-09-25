Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31E6C369AA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 08:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stMw3-0006tg-4L; Wed, 25 Sep 2024 03:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1stMw0-0006ka-TH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 03:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1stMvz-0003l7-An
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 03:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727251178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vORUZ9yLt/DuyLPUQolVYTXxD/OK9j8T1sgweROpHE=;
 b=F8rUf/y7lHVoP+hgNvnkTS0Bn4q5Mr9HQdCPRMwg5KhELEbcqutgGdXWqNEeZxlPLwlTU/
 2XpSVif10ewSPrVHONxhBjoe1qpp6xDp32laZMsj4xjkBZrxImqHQwumHt/ZOXl06XVNo3
 hDm/EwXkXTP/ZoXKZDlbfPl4LpJ0KW4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-O8PZIaBWMGSuVdg4OIYRCw-1; Wed, 25 Sep 2024 03:59:37 -0400
X-MC-Unique: O8PZIaBWMGSuVdg4OIYRCw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5c4230b10a0so5270541a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 00:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727251176; x=1727855976;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9vORUZ9yLt/DuyLPUQolVYTXxD/OK9j8T1sgweROpHE=;
 b=RxpytyeVBAud9EyNDG8Wt2rRl5XQlnbSD71qb++ZBf9Mdgv4+abT31lcMFb3RnjXC6
 8mJekfwO0UguziSVU9sPawGeHHKLeUu4bqH6q+pG4kaTktHCum50zS+svowMzV0R/luv
 FdUIWyXKhvkftCAs2aQR4pzgxyPc4/myZ3jRJnv4mNjkCTR+IgLtAwNoElIh0vBcPj2Z
 ZZdUPMF/3urtE+OQ4lLCQ90Wkr/SWYnVNluYw8/TYdOe5LjI32X1lGwW47DrYhjcmmlc
 1+4UetjXdws7LQM1eTvchIpcFJX5dBt4HAoBKMuPE+x7AY4cQmySvTx+N6/L5s0qXtYJ
 OKPg==
X-Gm-Message-State: AOJu0YzDG/vFsOOLxHEhNFosApCARqvdUc19OtAFvyvq7OtAKzEE8LNV
 O9KmzPpASKlRlRcZUuMQUi9bl3B/lZqa83BC7GrwypsCTZS68h4dxVCI5wIY0Fj4ikd3DVeCp5U
 GKf7SUMsXfuPDENeuph5LuO49C8ECM/L6lnb546islrgKoqan1eBj
X-Received: by 2002:a17:907:6d17:b0:a8d:5d28:8e0d with SMTP id
 a640c23a62f3a-a93a0607b4emr181768066b.45.1727251176159; 
 Wed, 25 Sep 2024 00:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWi/7lFzJ0qEYQyfX1b7V/zsDGkndKZPcY8KlykF7bcZ9xeP6FYxU0BFcX1DL8Calc6/4poQ==
X-Received: by 2002:a17:907:6d17:b0:a8d:5d28:8e0d with SMTP id
 a640c23a62f3a-a93a0607b4emr181764766b.45.1727251175424; 
 Wed, 25 Sep 2024 00:59:35 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it.
 [79.46.200.231]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9392f65dafsm179935266b.97.2024.09.25.00.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 00:59:34 -0700 (PDT)
Date: Wed, 25 Sep 2024 09:59:29 +0200
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
Subject: Re: [PATCH v2 13/22] hw/virtio-blk: fix -Werror=maybe-uninitialized
 false-positive
Message-ID: <ppl7p4nqvok7wrrwwilxqmerecdqy75w7ozpm4wvlnqlmjp65b@ymkvzhnyky7x>
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-14-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924130554.749278-14-marcandre.lureau@redhat.com>
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

On Tue, Sep 24, 2024 at 05:05:44PM GMT, marcandre.lureau@redhat.com wrote:
>From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
>../hw/block/virtio-blk.c:1212:12: error: ‘rq’ may be used uninitialized [-Werror=maybe-uninitialized]
>
>Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> hw/block/virtio-blk.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>index 115795392c..9166d7974d 100644
>--- a/hw/block/virtio-blk.c
>+++ b/hw/block/virtio-blk.c
>@@ -1060,7 +1060,7 @@ static void virtio_blk_dma_restart_cb(void *opaque, bool running,
>     VirtIOBlock *s = opaque;
>     uint16_t num_queues = s->conf.num_queues;
>     g_autofree VirtIOBlockReq **vq_rq = NULL;
>-    VirtIOBlockReq *rq;
>+    VirtIOBlockReq *rq = NULL;
>
>     if (!running) {
>         return;
>-- 
>2.45.2.827.g557ae147e6
>


