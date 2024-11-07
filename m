Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFAED43360
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 13:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t92rR-0003R6-4N; Thu, 07 Nov 2024 08:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t92rP-0003Qw-O0
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:47:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t92rN-0007fE-Ii
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730987259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7bpuD4VXkRzZcC/uI2Sky0yj4/IHhJSciFTJcd/wXic=;
 b=e5rQY2cM7+nmoJZYytHxScaYa2nWnzZ0A4dS7J0sXlz3KusmbMrvO3+TeeK2j0UuExkPJY
 CDn7EGx+lWPxhOtiSEYSJgbSlT26N4b484cIi4z2xM2JkdUbJNjOrkDpeValSEf4SFSxBS
 eCtbvjTmg7hxbajQjHmZfOS5rT8nxLQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-EzhBn071OtebnwSGZFwHog-1; Thu, 07 Nov 2024 08:47:36 -0500
X-MC-Unique: EzhBn071OtebnwSGZFwHog-1
X-Mimecast-MFC-AGG-ID: EzhBn071OtebnwSGZFwHog
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43152cd2843so6262935e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 05:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730987255; x=1731592055;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7bpuD4VXkRzZcC/uI2Sky0yj4/IHhJSciFTJcd/wXic=;
 b=foMyeP+2tihAQhPA/+PnAwoLaMdcpc1ll+WlMtHeLKB9o7K9lRecqttDCwEvWt0Ku8
 JzdTj6G749epPACcFH5FIjz4pKE6OowNiPgyRV2eMBhKM3eC0qeYgwiH7s/Z4JFEtfq+
 XTwLbbmBj2mHc2QjG45ZSY3tU6KS5+pGlC3A2w3E3Gb1nIda0q687lhpWauZNXUwOtTS
 kRMr7XZ12Sj4mQgDF6IrhdzxeUFIyUltExHus2IWUODI57W2ULI8fBX+aTV77y45rXtu
 KtgRRf/pBmC/tch3L5qx2JszIzw1uYBT2AI4z8ohvEyIXz9sfwlb4m/+vpWjAmAxlog+
 o3jw==
X-Gm-Message-State: AOJu0YwiA2LDidwKRNF20MgcyGeNKCZPwJPjI3GvCaO+mVJU60iTQzoi
 ctnqU1RCMYEyRYrZYj43fVZupc1Y56W0BR0a9flO52L3xRT671N5i42hlPAmMYhVdJv2+T4OZYd
 /QReNQF8nZvwO1sKJ+uG4haHWqrWraX6gGsFLCi4Yb2aIZ2570IFt
X-Received: by 2002:a05:600c:1c8f:b0:431:5e53:2dc4 with SMTP id
 5b1f17b1804b1-432b5f93d9bmr256385e9.6.1730987255216; 
 Thu, 07 Nov 2024 05:47:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3/Btq0ZegC5t9NN+8ihRYRTa48qraBwmfQZUyttvfUUd7bKcd7QBCY2EhF3soQJVrqSvj0g==
X-Received: by 2002:a05:600c:1c8f:b0:431:5e53:2dc4 with SMTP id
 5b1f17b1804b1-432b5f93d9bmr256065e9.6.1730987254486; 
 Thu, 07 Nov 2024 05:47:34 -0800 (PST)
Received: from sgarzare-redhat ([5.77.70.124])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa74abb9sm62382075e9.42.2024.11.07.05.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 05:47:33 -0800 (PST)
Date: Thu, 7 Nov 2024 14:47:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, aesteve@redhat.com, marcandre.lureau@redhat.com
Subject: Re: [PATCH] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
Message-ID: <CAGxU2F5L5GBpk19aPDazYRFCDupa6+4FKk7Vjq9QNsFp0tu_kg@mail.gmail.com>
References: <20241107125201.1640759-1-dbassey@redhat.com>
 <2lsvukkntdselhhjw726kmnixmp7yue5sojhosyaqre5mwrlyq@7x4vwbniwulv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2lsvukkntdselhhjw726kmnixmp7yue5sojhosyaqre5mwrlyq@7x4vwbniwulv>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Thu, Nov 7, 2024 at 2:43 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Nov 07, 2024 at 01:52:01PM +0100, Dorinda Bassey wrote:
> >In `virtio_add_resource` function, the UUID used as a key for
> >`g_hash_table_insert` was temporary, which could lead to
> >invalid lookups when accessed later. This patch ensures that
> >the UUID remains valid by duplicating it into a newly allocated
> >memory space (persistent_uuid). The value is then inserted into
> >the hash table with this persistent UUID key to ensure that the
> >key stored in the hash table remains valid as long as the hash
> >table entry exists.
>
> It's a fix right, so maybe better to add a Fixes tag:
>
> Fixes: faefdba847 ("hw/display: introduce virtio-dmabuf")
>
> >
> >Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> >---
> > hw/display/virtio-dmabuf.c | 7 ++++++-
> > 1 file changed, 6 insertions(+), 1 deletion(-)
> >
> >diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> >index 3dba4577ca7..4353970bc87 100644
> >--- a/hw/display/virtio-dmabuf.c
> >+++ b/hw/display/virtio-dmabuf.c
> >@@ -39,7 +39,12 @@ static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
> >                                                g_free);
> >     }
> >     if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
> >-        g_hash_table_insert(resource_uuids, uuid, value);
> >+        QemuUUID *persistent_uuid = g_memdup2(uuid, sizeof(QemuUUID));
>
> Since now we allocate memory for the key, we should provide the
> `key_destroy_func` when calling g_hash_table_new_full(), otherwise
> this new memory will not be de-allocated.
>
> >+        if (persistent_uuid == NULL) {
>
> IIUC it can be null, only if `uuid` was null since glib memory
> API usually terminates the application if memory allocation fails,
> see https://docs.gtk.org/glib/memory.html
>
> So maybe we can just do:
>            g_hash_table_insert(resource_uuids, g_memdup2(uuid, sizeof(QemuUUID)),
>                                value);

Or even better:
             g_hash_table_insert(resource_uuids, g_memdup2(uuid, sizeof(*uuid)),
                                 value);

Thanks,
Stefano

>
> >+            result = false;
> >+        } else {
> >+            g_hash_table_insert(resource_uuids, persistent_uuid, value);
> >+        }
> >     } else {
> >         result = false;
> >     }
> >--
> >2.47.0
> >


