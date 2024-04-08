Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6956C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 07:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtjdr-0000HV-L2; Mon, 08 Apr 2024 03:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rtjdo-0000H6-0k
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rtjdi-0002ir-6u
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712562121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=636XWh6AmDSjZtDCfvbIRdXoumFJy25dlfeIw61qc1c=;
 b=Rrl162V/jaDXe6Ju520O3E0D+wvMn1j7FiBeHy4P//hENCteC9cmu7KXrtAsaQZvmm5D0q
 2DfNAEj2SIxJvUfZEygbWzzFv5GzRiqfDx4sgty+uAL/9YtLp162FtDgk+CDvfi2hGzHyI
 WdIDM1wGFWHJg62zIaBPi/kr9A8TUsI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-BrkvonQVPqSi9fAt5b5R-g-1; Mon, 08 Apr 2024 03:41:59 -0400
X-MC-Unique: BrkvonQVPqSi9fAt5b5R-g-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-78bd232b170so492834885a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 00:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712562119; x=1713166919;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=636XWh6AmDSjZtDCfvbIRdXoumFJy25dlfeIw61qc1c=;
 b=PxQQAYns/1T50daCqyxGUtEQugsK4/JnFw0oWzlF/YZmJlasNuugkKp2ZCcZmXT+wy
 kT+crsWXhgk0dZo9q9Gek3hbwIvdZup245Nj1MXtJ+HpUAIpAJwjNmHRDh854CXG7a51
 VPQ6eVEmRl41+KMzoLb3v8XC8IRN5OCoMt5YbfAEKaYbASBYASeBVzZxoEVSaSVBC2nJ
 3QYrg1gvnWr1/r0wBwbw0fGF86Cc50MrnqE3snka21S2KVJ6pTT74ZAI4hSzllOQUdpC
 BjfXKVntEYbl4u7VuMKaN20WSyHUBciEcK3PCOMZiV0upd6qj1oIorn1KSc/1GlXcTzc
 adXw==
X-Gm-Message-State: AOJu0Ywnu1agmbQID7Jk6l3sMzQ+D1iEx5kBKeRxtO84HZbC2t7wRJ2u
 Ziz/Smdv4WRshA0YedTwhlZjBT7hxvAw7HcrqubfKQr8qoYcjKNeg2aoeIa5jims217PLDU4Vh9
 FXROF+nXD5gPw+gTGKRMKgeij5xIEZaAKzjnjl7EtKaL/wzYQkKXl
X-Received: by 2002:a05:620a:2806:b0:78d:6572:ea56 with SMTP id
 f6-20020a05620a280600b0078d6572ea56mr3032707qkp.13.1712562118981; 
 Mon, 08 Apr 2024 00:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPfYhWhEJ35b7dAxZQ4ALtIRcb+mvEAIug4nw8OM0pd1E4Xo+0Sb//9HnFgQwZ7F/k5mD1XA==
X-Received: by 2002:a05:620a:2806:b0:78d:6572:ea56 with SMTP id
 f6-20020a05620a280600b0078d6572ea56mr3032694qkp.13.1712562118704; 
 Mon, 08 Apr 2024 00:41:58 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.101.253])
 by smtp.gmail.com with ESMTPSA id
 vv23-20020a05620a563700b0078d68b23254sm328366qkn.107.2024.04.08.00.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 00:41:58 -0700 (PDT)
Date: Mon, 8 Apr 2024 09:41:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>, 
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 gmaglione@redhat.com, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH for-9.1 v3 08/11] contrib/vhost-user-blk: enable it on
 any POSIX system
Message-ID: <la3m3jiogtzpwsqjbyro6k3e7m6g45sy2uxpat73dyom3x52ig@yk3szljbva2p>
References: <20240404122330.92710-1-sgarzare@redhat.com>
 <20240404122330.92710-9-sgarzare@redhat.com>
 <84c9d3f2-9aab-4dd6-b6f8-223acf6364fb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84c9d3f2-9aab-4dd6-b6f8-223acf6364fb@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Apr 04, 2024 at 04:00:38PM +0200, Philippe Mathieu-Daudé wrote:
>Hi Stefano,

Hi Phil!

>
>On 4/4/24 14:23, Stefano Garzarella wrote:
>>Let's make the code more portable by using the "qemu/bswap.h" API
>>and adding defines from block/file-posix.c to support O_DIRECT in
>>other systems (e.g. macOS).
>>
>>vhost-user-server.c is a dependency, let's enable it for any POSIX
>>system.
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>  meson.build                             |  2 --
>>  contrib/vhost-user-blk/vhost-user-blk.c | 19 +++++++++++++++++--
>>  util/meson.build                        |  4 +++-
>>  3 files changed, 20 insertions(+), 5 deletions(-)
>
>
>>diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
>>index a8ab9269a2..462e584857 100644
>>--- a/contrib/vhost-user-blk/vhost-user-blk.c
>>+++ b/contrib/vhost-user-blk/vhost-user-blk.c
>>@@ -16,6 +16,7 @@
>>   */
>>  #include "qemu/osdep.h"
>>+#include "qemu/bswap.h"
>>  #include "standard-headers/linux/virtio_blk.h"
>>  #include "libvhost-user-glib.h"
>
>
>>@@ -267,13 +282,13 @@ static int vub_virtio_process_req(VubDev *vdev_blk,
>>      req->in = (struct virtio_blk_inhdr *)elem->in_sg[in_num - 1].iov_base;
>>      in_num--;
>>-    type = le32toh(req->out->type);
>>+    type = le32_to_cpu(req->out->type);
>>      switch (type & ~VIRTIO_BLK_T_BARRIER) {
>>      case VIRTIO_BLK_T_IN:
>>      case VIRTIO_BLK_T_OUT: {
>>          ssize_t ret = 0;
>>          bool is_write = type & VIRTIO_BLK_T_OUT;
>>-        req->sector_num = le64toh(req->out->sector);
>>+        req->sector_num = le64_to_cpu(req->out->sector);
>>          if (is_write) {
>>              ret  = vub_writev(req, &elem->out_sg[1], out_num);
>>          } else {
>Can we switch to the bswap API in a preliminary patch,

Sure, I tried to minimize the patches because it's already big,
but I can split this.

>converting all the source files?
>

What do you mean with "all the source files"?

"le64toh" is used here and in some subprojects (e.g. libvduse,
libvhost-user), where IIUC we can't use QEMU's bswap.h because we
don't want to put a dependency with the QEMU code.

BTW I'll check for other *toh() usage in QEMU code and change in the
preliminary patch you suggested to add.

Thanks for the review,
Stefano


