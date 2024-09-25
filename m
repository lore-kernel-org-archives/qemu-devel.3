Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4260EC369A8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 08:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stN4U-0002zS-7x; Wed, 25 Sep 2024 04:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1stN4Q-0002yJ-1y
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 04:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1stN4B-0005P1-Tw
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 04:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727251683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjISAM0fM8RpNIELd+UI12/QOnGKe9EDw8ruXsMM+cM=;
 b=VMe9wFvAynfNVDwRJG6IkIOEYqeBpMqMI2xlq7cICVDcDvT9yPDfW/MDJWj0+G1fxBGqrD
 HdZvkwmunp8XBYqtz6d7DD8gzLKgxobjvoHkOrmOLMoggzXTxUOGsvJ8/S+ISP1lpOrcu0
 jJ83cn61A+IFBYi57VSmqv4lb3IIbF0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-m5r_FosmOtKvgSjauvQp2w-1; Wed, 25 Sep 2024 04:08:01 -0400
X-MC-Unique: m5r_FosmOtKvgSjauvQp2w-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5c2504ab265so2727450a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 01:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727251680; x=1727856480;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BjISAM0fM8RpNIELd+UI12/QOnGKe9EDw8ruXsMM+cM=;
 b=QznBSYuREPgeSZTTaevgeqN71aUNQlcza7PIRPR060Zvz7MOb7XERkies5dcmAJ6vU
 A6mrNcTX0giJ8SDALq/dMLv60IJaVXpMw3ZQxHZ4BErnEdRQS9gYBM26fDH3vUa9M6Pa
 9EKs0eKpRk8mvPewdtDjmm0bthji+rztJT0i60DKb3hZmgCruYSwEhd3mPf8NnPI/3lI
 gsQl83OADQ576l4uO2jj2ypp52nqL9N/GTxsH3TAFUwevNIQkhS+AWbNH9YOdNR4jYHq
 3cDHbw0Lf6VM1zxyw+GteAlNTXmxc42+x7y1NTeVAV3xn7/pRCfohfog6magWDmOyckr
 R4Mg==
X-Gm-Message-State: AOJu0YwoY1zGLuvCOJ812vW5vcFj309CfIGyAynqDByJij1X/rounbAT
 H0iKAxhkdwtZ+iPPhMiCPGKGbk1Ae3nhwyuOFVxg7AnzPfyPuN+fIgJ8/59zJ9u//WJFBU3KvSq
 eOF76SSzukjXo/2CRgUD3YGkP3waFO9g0xvlg8HYwv1kZkl9t5BKXYRSIXIMKYnM+V2wb
X-Received: by 2002:a05:6402:2342:b0:5c7:1934:aa5a with SMTP id
 4fb4d7f45d1cf-5c720755693mr1511831a12.30.1727251680147; 
 Wed, 25 Sep 2024 01:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvPnSYphh/PKs1bcRvHPW2F9JUHLx/SZAELes+fISF5jMXoo38ElIfLC+IVJm/PpddsJqDyw==
X-Received: by 2002:a05:6402:2342:b0:5c7:1934:aa5a with SMTP id
 4fb4d7f45d1cf-5c720755693mr1511787a12.30.1727251679340; 
 Wed, 25 Sep 2024 01:07:59 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it.
 [79.46.200.231]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4d79a8sm1589853a12.86.2024.09.25.01.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 01:07:58 -0700 (PDT)
Date: Wed, 25 Sep 2024 10:07:53 +0200
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
Subject: Re: [PATCH v2 18/22] hw/virtio: fix -Werror=maybe-uninitialized
 false-positive
Message-ID: <swzpet5rpne5arwq32i5vrinpguremvrq4sqb73byfw5n2uuzx@s4hi7thksiif>
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-19-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924130554.749278-19-marcandre.lureau@redhat.com>
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

On Tue, Sep 24, 2024 at 05:05:49PM GMT, marcandre.lureau@redhat.com wrote:
>From: Marc-André Lureau <marcandre.lureau@redhat.com>

For the title: I don't think it is a false positive, but a real fix,
indeed maybe not a complete one.

>
>../hw/virtio/vhost-shadow-virtqueue.c:545:13: error: ‘r’ may be used uninitialized [-Werror=maybe-uninitialized]
>
>Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
> hw/virtio/vhost-shadow-virtqueue.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
>index fc5f408f77..cd29cc795b 100644
>--- a/hw/virtio/vhost-shadow-virtqueue.c
>+++ b/hw/virtio/vhost-shadow-virtqueue.c
>@@ -526,7 +526,7 @@ static void vhost_svq_flush(VhostShadowVirtqueue *svq,
> size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
> {
>     size_t len = 0;
>-    uint32_t r;
>+    uint32_t r = 0;
>
>     while (num--) {

I think we should move the initialization to 0 here in the loop:

           uint32_t r = 0;

>         int64_t start_us = g_get_monotonic_time();

...

           vhost_svq_get_buf(svq, &r);
           len += r;
       }

This because we don't check vhost_svq_get_buf() return value.

IIUC, in that function, `r` is set only if the return value of
vhost_svq_get_buf() is not null, so if we don't check its return value,
we should set `r` to 0 on every cycle (or check the return value of
course).

Thanks,
Stefano


