Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DCEC369AA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 08:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stNEp-0008N8-JR; Wed, 25 Sep 2024 04:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1stNEl-0008Ki-Nx
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 04:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1stNEj-0006fB-Nf
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 04:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727252337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpkyUdOzGGtgiYaf9SMUo11EoLRQMvJlyHEEAsAF+KQ=;
 b=AlTHRnV234hVZP7gpB4hjS08+eqWVKM+vpnvEgevNlLt0hw/wMdXbFJr6eTolu/b2ej8vb
 notgQKG6YrxhOh3hW/buNEhu/QwcTMpbxLzvWxEcl+cQ8qNdd0Z6VigCwRsSmQ39HXCEdN
 CJf/0T6iiKxXalCmTNIxvjpjLHTegSI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-om3I5JEvO6K3VctKGY35vQ-1; Wed, 25 Sep 2024 04:18:56 -0400
X-MC-Unique: om3I5JEvO6K3VctKGY35vQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a8a6fee3ab1so556326366b.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 01:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727252335; x=1727857135;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HpkyUdOzGGtgiYaf9SMUo11EoLRQMvJlyHEEAsAF+KQ=;
 b=NOyu67PCTz6ycq2kpcdAmnY47AdSGaQM++q54mi2MdoF8UJy9ywrYZxTp7FK7xFYKV
 qQQ890hn4kuVqWqSKy7SMHWkm3Y9EWw1p7rwoA8o9hlmwr4yj4t4iqWA6QrLvv3ewluR
 ABOjzZlo0ucytZWQdRvXIq7i/8E9oHx+g6OnGTBSM7RbH8KJAZvbbfRO2DMjkpZzSgIH
 MH0AiucDhAJymixZZgSn0yY/A35po6uKK+Q66aJgksHoPfw57hc43q4GLtvWRnSkzgoM
 alc+qWO4uiMC2lv3fFXZGHe3kf7S5qUTBj1n2thth+mLenc1rWnF67mEjSr+YHrMAvOy
 MRNg==
X-Gm-Message-State: AOJu0YyR3qZu5MP+Nt6BNp6DZfCwwVJcfwbv3TiTeoyEl+fQQRUB2A0o
 /Kn1csPzpoNrHdK6D5Tp0PoOGIKPocBlvtBpptQShpdshs9Ucm78v0yU4LMeL0TpnbZNugNIjwt
 UVnoAPyafh9yzUOopE0EsNC4OO/RCFbYxP56leXJi9X4jPIGOxNr7
X-Received: by 2002:a17:906:bc14:b0:a8d:2e3a:5303 with SMTP id
 a640c23a62f3a-a93a03c529amr144412066b.39.1727252334908; 
 Wed, 25 Sep 2024 01:18:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7MN3WMhLdu2CJsXgAz1l8t1ed2J+yuZu+KojuCxVD9rOvYP7VC29wEdYYMf3BeDK5G7c9KA==
X-Received: by 2002:a17:906:bc14:b0:a8d:2e3a:5303 with SMTP id
 a640c23a62f3a-a93a03c529amr144407166b.39.1727252334256; 
 Wed, 25 Sep 2024 01:18:54 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it.
 [79.46.200.231]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930caf21sm181725266b.98.2024.09.25.01.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 01:18:53 -0700 (PDT)
Date: Wed, 25 Sep 2024 10:18:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: marcandre.lureau@redhat.com, eperezma@redhat.com
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
Subject: Re: [PATCH v2 22/22] RFC: hw/virtio: a potential leak fix
Message-ID: <ix3rgyh4bepu23qazun5ywx7qnhce7s5eq76k5nqq37v27ngpv@bbfnw5fax5qo>
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-23-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924130554.749278-23-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Tue, Sep 24, 2024 at 05:05:53PM GMT, marcandre.lureau@redhat.com wrote:
>From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
>vhost_svq_get_buf() may return a VirtQueueElement that should be freed.
>
>It's unclear to me if the vhost_svq_get_buf() call should always return NULL.
>
>Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
> hw/virtio/vhost-shadow-virtqueue.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
>index cd29cc795b..93742d9ddc 100644
>--- a/hw/virtio/vhost-shadow-virtqueue.c
>+++ b/hw/virtio/vhost-shadow-virtqueue.c
>@@ -414,6 +414,7 @@ static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
>     return i;
> }
>
>+G_GNUC_WARN_UNUSED_RESULT
> static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
>                                            uint32_t *len)
> {
>@@ -529,6 +530,7 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
>     uint32_t r = 0;
>
>     while (num--) {
>+        g_autofree VirtQueueElement *elem = NULL;

Yes, indeed it sounds like we should release the buffer, although from
the name of the function here, it sounds like we are just trying to
figure out if the queue has elements, so I expect there is another
function that is then called to process the buffers.

There's still a potential problem here that I pointed out in the other
patch, but I think we need Eugenio here.

>         int64_t start_us = g_get_monotonic_time();
>
>         do {
>@@ -541,7 +543,7 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
>             }
>         } while (true);
>
>-        vhost_svq_get_buf(svq, &r);
>+        elem = vhost_svq_get_buf(svq, &r);
>         len += r;
>     }
>
>-- 
>2.45.2.827.g557ae147e6
>


