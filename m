Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2903AD4335E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 13:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t92nj-0000jC-7h; Thu, 07 Nov 2024 08:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t92ne-0000ig-Jx
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:43:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t92nb-0006TH-PO
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730987024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OXxEpkdVgQx0YQCx+x11vO9gxACac1E+91avTNKTTGo=;
 b=G3ehHT29duAR3cCXhJgbUombRF6Xe9G6bC6HUFiukO7KksRgpuOV1kcCkTkm0HOJ5TvO65
 NnB2wV4Ewdyz7QGG7JZHs435oj7njGiNJ4khrZPXxFZ20/U2OZt1nGMhG1Yc1ipK/y8yT2
 v/CsOD9gGlIsqwjd0ChrhXXiq9kGI4I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-xrHbphUiPiy34pW8J0R7Og-1; Thu, 07 Nov 2024 08:43:43 -0500
X-MC-Unique: xrHbphUiPiy34pW8J0R7Og-1
X-Mimecast-MFC-AGG-ID: xrHbphUiPiy34pW8J0R7Og
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431673032e6so6369435e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 05:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730987022; x=1731591822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OXxEpkdVgQx0YQCx+x11vO9gxACac1E+91avTNKTTGo=;
 b=eSjEFj9b8wmd4zMccNDnsHbcKihH4QNrmNVjVAgPOuChV2n5aU0IUP9XfBQMjjUK5/
 jjBzIq/64tb7j8Y5+q4/L3SJjKC5lYYK1Du5FLtlp3lVkOGEFO1iDWEJ8T3TcGzOV7DH
 rkmS9DY43jUakbybfXiFgOu2Ez0wvSODCumE7Odx04o0XCPjfq9+0kPmQG2xkDPI52WS
 xm/NIo5+7a3Dy7QGUGiWvnJme4DVSCrqmULOhwuMUcc5JJjMohQy1DoKp4Ajj1kdodef
 Iu9+hFadN7jykVWXfxGKCy75iHBQ+mE/2RuHOhW6EDPBDDktdr9l0XOADbY/Nec7XtnK
 g5EQ==
X-Gm-Message-State: AOJu0YzlmU5NuF0tsywGjJY++kC50izgYmjbqFUl7aL95Upu+sHnXSgu
 NZz6qYfYgglIOXljOqaRzQhAkHSnjihODRFMIJcjylzfOkBkWhs/vH6f+0kYQPdAL1lQdiIwHvN
 ZP3qA+q81xKo4vDFaudS0pbOdwvjodJWXc8qRVYrQ5MA9zxpw+a8F
X-Received: by 2002:a05:600c:190e:b0:42c:a905:9384 with SMTP id
 5b1f17b1804b1-432b308d52cmr11768505e9.20.1730987021907; 
 Thu, 07 Nov 2024 05:43:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEjjFzRJRM12WNMOY6YRS+zzB1P3vLd/lol9somq6huzjMCInmTabEoODuyQU+E3i16KjWJA==
X-Received: by 2002:a05:600c:190e:b0:42c:a905:9384 with SMTP id
 5b1f17b1804b1-432b308d52cmr11768235e9.20.1730987021213; 
 Thu, 07 Nov 2024 05:43:41 -0800 (PST)
Received: from sgarzare-redhat ([5.77.70.124])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6bee9asm64162175e9.19.2024.11.07.05.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 05:43:40 -0800 (PST)
Date: Thu, 7 Nov 2024 14:43:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, aesteve@redhat.com, marcandre.lureau@redhat.com
Subject: Re: [PATCH] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
Message-ID: <2lsvukkntdselhhjw726kmnixmp7yue5sojhosyaqre5mwrlyq@7x4vwbniwulv>
References: <20241107125201.1640759-1-dbassey@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241107125201.1640759-1-dbassey@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Nov 07, 2024 at 01:52:01PM +0100, Dorinda Bassey wrote:
>In `virtio_add_resource` function, the UUID used as a key for
>`g_hash_table_insert` was temporary, which could lead to
>invalid lookups when accessed later. This patch ensures that
>the UUID remains valid by duplicating it into a newly allocated
>memory space (persistent_uuid). The value is then inserted into
>the hash table with this persistent UUID key to ensure that the
>key stored in the hash table remains valid as long as the hash
>table entry exists.

It's a fix right, so maybe better to add a Fixes tag:

Fixes: faefdba847 ("hw/display: introduce virtio-dmabuf")

>
>Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
>---
> hw/display/virtio-dmabuf.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
>index 3dba4577ca7..4353970bc87 100644
>--- a/hw/display/virtio-dmabuf.c
>+++ b/hw/display/virtio-dmabuf.c
>@@ -39,7 +39,12 @@ static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
>                                                g_free);
>     }
>     if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
>-        g_hash_table_insert(resource_uuids, uuid, value);
>+        QemuUUID *persistent_uuid = g_memdup2(uuid, sizeof(QemuUUID));

Since now we allocate memory for the key, we should provide the
`key_destroy_func` when calling g_hash_table_new_full(), otherwise
this new memory will not be de-allocated.

>+        if (persistent_uuid == NULL) {

IIUC it can be null, only if `uuid` was null since glib memory
API usually terminates the application if memory allocation fails,
see https://docs.gtk.org/glib/memory.html

So maybe we can just do:
           g_hash_table_insert(resource_uuids, g_memdup2(uuid, sizeof(QemuUUID)),
                               value);

>+            result = false;
>+        } else {
>+            g_hash_table_insert(resource_uuids, persistent_uuid, value);
>+        }
>     } else {
>         result = false;
>     }
>-- 
>2.47.0
>


