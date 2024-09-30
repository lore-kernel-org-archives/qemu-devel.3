Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A782CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBlg-00078A-5K; Mon, 30 Sep 2024 04:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1svBle-000736-U4
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1svBlc-0007SO-Oy
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727684906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGNEfnqiQHJivL5soFqG+rVzxvFYMsJ8fRYRRKcbcHE=;
 b=E60v/gW+CFRehjWZDgdXSbLsmYI+cqTEaawnIrtoQRF4IQBBOr43weOHjeIEY2ncOL5b6O
 8v1/PyHpxAydy9cms3efvbnO7eUcT/S1DFwmR9USlyZVXRH3dsaS3+iYl6Yt2EKqv42uCs
 OYiKet/QdG0iuot5rREdKAWKxP7FJYw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-0SBx47aNPmiTYU6uFNaYSw-1; Mon, 30 Sep 2024 04:28:24 -0400
X-MC-Unique: 0SBx47aNPmiTYU6uFNaYSw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7acdd745756so819708885a.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 01:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727684904; x=1728289704;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NGNEfnqiQHJivL5soFqG+rVzxvFYMsJ8fRYRRKcbcHE=;
 b=Asn27hKAhRrnyKeJhBraqE4jjxR86WX0mBifLs7N2o5herNsoJgtjGiyPYX3T0ha+v
 m9+0SSg7cWdF/zUe+hZixNw39H+Fy50xUerDRa+zpMESt7+ZL55HsLh2NpdrHAbkweP1
 mng1TQxfmjXnAJU2nfbUE8khZwfCzACm6idkQUn+xtq/NpmbVcVQYsZYPt+FIfFo5o24
 qJqCRvqRry9bu/DYPBjtOeuFq/zbsv1/x9jYo/Ro3Ya5ZtbPK7/8Ifg9uU9U2rQAo4lW
 veKi7UcczAYVgQx4Fbf5xGScS3r7CvfWuHySC4/5+hagbGUO8QMg2dGn+3r1RCfqwA+M
 ciAA==
X-Gm-Message-State: AOJu0YxWQrqvYS64zhz6wIxFqi2K05fM5lvdzoGiT8bS4aQ6+P/mRxs7
 CU31lieAYz/y2FnWut4BDiQCOR6kiiRFdzZ7B7pli8ZgTJHrM+TISI7Gasq+PW+yzMQxao3eVPg
 s3j1LzmvXJ8q891RwvIByazjD+CT2IYEsPaYGWi4B5JEEV4Wgmq8C
X-Received: by 2002:a05:620a:3711:b0:7a9:bf31:dbc7 with SMTP id
 af79cd13be357-7ae378c5f07mr1875947585a.53.1727684904160; 
 Mon, 30 Sep 2024 01:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJcetpsX4WTOzdDcr3XHIDlfPFCjIjenoFW5yoV0cf0fuB2ILUPZ2MGtmkSz7sHuxvXMuO8A==
X-Received: by 2002:a05:620a:3711:b0:7a9:bf31:dbc7 with SMTP id
 af79cd13be357-7ae378c5f07mr1875943785a.53.1727684903691; 
 Mon, 30 Sep 2024 01:28:23 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it.
 [79.46.200.231]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae377bc898sm396035785a.8.2024.09.30.01.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 01:28:23 -0700 (PDT)
Date: Mon, 30 Sep 2024 10:28:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-block@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Greg Kurz <groug@kaod.org>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Hyman Huang <yong.huang@smartx.com>, 
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>, 
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Bin Meng <bin.meng@windriver.com>
Subject: Re: [PATCH v3 18/22] hw/virtio: fix -Werror=maybe-uninitialized
Message-ID: <hymnkttsk7we76n5of6n6tgjoddxcezuwcdxsm5hx625wfqouw@jpkcw4pbkui4>
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-19-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930081458.1926382-19-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 30, 2024 at 12:14:53PM GMT, marcandre.lureau@redhat.com wrote:
>From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
>../hw/virtio/vhost-shadow-virtqueue.c:545:13: error: ‘r’ may be used uninitialized [-Werror=maybe-uninitialized]
>
>Set `r` to 0 at every loop, since we don't check vhost_svq_get_buf()
>return value.
>
>Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
> hw/virtio/vhost-shadow-virtqueue.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
>index fc5f408f77..3b2beaea24 100644
>--- a/hw/virtio/vhost-shadow-virtqueue.c
>+++ b/hw/virtio/vhost-shadow-virtqueue.c
>@@ -526,10 +526,10 @@ static void vhost_svq_flush(VhostShadowVirtqueue *svq,
> size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
> {
>     size_t len = 0;
>-    uint32_t r;
>
>     while (num--) {
>         int64_t start_us = g_get_monotonic_time();
>+        uint32_t r = 0;
>
>         do {
>             if (vhost_svq_more_used(svq)) {
>-- 
>2.45.2.827.g557ae147e6
>


