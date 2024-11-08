Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB30FD5E14B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 09:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9LIw-0006y4-27; Fri, 08 Nov 2024 04:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t9LIu-0006xc-72
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 04:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t9LIr-0005Q8-NR
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 04:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731058155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mrCA2g0c2NYnRIDjLJlyjLPJnej8Cfo3hdNkSepq0d4=;
 b=d9DDm3oztFlzrL5bKwtPpbPZmKvxS6dilD3sT6QrkcTHRZZ4TuLrKHv91vw4PyadgQqA8S
 kTwfxBiq+nq6g5MX19XV0hC/mRUvCCIKKeBubggM/idlCiglGwfMuSUcwNP3LFwXBXv4U1
 VuuswYtmt0VW8zTFeN4iuKH0Jlwx/so=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-X0pxN4_xMymMGoYubWO11Q-1; Fri, 08 Nov 2024 04:29:12 -0500
X-MC-Unique: X0pxN4_xMymMGoYubWO11Q-1
X-Mimecast-MFC-AGG-ID: X0pxN4_xMymMGoYubWO11Q
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso11031505e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 01:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731058152; x=1731662952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrCA2g0c2NYnRIDjLJlyjLPJnej8Cfo3hdNkSepq0d4=;
 b=AgMzC7kh44F3u5+PguEG6i9o/A1GXAkPGNTAU+nocYiEB8BlSvRLEoyrqPQoRgDKmH
 AIA8Je/gmUYacoh41XCH2q56oCXRO6bRREILWEHQ+dk7AExNia+rTexrt83qx3FS8l8F
 ja7AykTWM40FzATzDNqUs1L2EbnJovoX0tdEcZXn/IfSBGzc078G/aQ+mE8M32z1jUy1
 8RqjPwNpPPW/GAQ0exk4H81hhbQyOhSOqc609V/3B4D0ma2q3kU6/QY5Zc3uQ+L5Jgcx
 2J+vybNUGrskr2D02Z1M5rzs+pFxOK+GxWV5jdU/7pDTUTxXes9MFaiX9YY7zBkn/Kx4
 1QaA==
X-Gm-Message-State: AOJu0Yzkh1K6dHOfXwAqZgVlEtfx/jQyy83oerLd6slAUWKBOlt93D9H
 ZU8jsdMhc9C7Mzt7fUhriOjUSO22aq6SKtuBq0VmoknSV/KmEOdYVRyrlX5rMo0jEwIqJapde7N
 DR4a8Vm1oIzx1uap/WsWT1dzh49ejASoQ3Ss6x1vncli724Kq+0bq
X-Received: by 2002:a05:600c:4fc3:b0:42c:baf1:4c7 with SMTP id
 5b1f17b1804b1-432b6858e60mr21142295e9.4.1731058151723; 
 Fri, 08 Nov 2024 01:29:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmJblpeju7nxKTRHQ/vf3KEdSwP/kCpC42kVroap/94zWf7yz2U8dq4ivjD+Faff5hkNeodg==
X-Received: by 2002:a05:600c:4fc3:b0:42c:baf1:4c7 with SMTP id
 5b1f17b1804b1-432b6858e60mr21142065e9.4.1731058151185; 
 Fri, 08 Nov 2024 01:29:11 -0800 (PST)
Received: from sgarzare-redhat ([193.207.101.111])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed997313sm4018915f8f.53.2024.11.08.01.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 01:29:10 -0800 (PST)
Date: Fri, 8 Nov 2024 10:29:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, aesteve@redhat.com, marcandre.lureau@redhat.com
Subject: Re: [PATCH v2] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
Message-ID: <v5p6ztswg7wrooyg4fnenbvbnwf2svm6j6jg7dm4pavwocft3x@ub5mgg5e3dyo>
References: <20241107180309.1713601-1-dbassey@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241107180309.1713601-1-dbassey@redhat.com>
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

On Thu, Nov 07, 2024 at 07:00:31PM +0100, Dorinda Bassey wrote:
>In `virtio_add_resource` function, the UUID used as a key for
>`g_hash_table_insert` was temporary, which could lead to
>invalid lookups when accessed later. This patch ensures that
>the UUID remains valid by duplicating it into a newly allocated
>memory space. The value is then inserted into the hash table
>with this persistent UUID key to ensure that the key stored in
>the hash table remains valid as long as the hash table entry
>exists.
>
>Fixes: faefdba847 ("hw/display: introduce virtio-dmabuf")
>
>Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
>---
> hw/display/virtio-dmabuf.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
>index 3dba4577ca7..5e0395be77c 100644
>--- a/hw/display/virtio-dmabuf.c
>+++ b/hw/display/virtio-dmabuf.c
>@@ -35,11 +35,13 @@ static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
>     if (resource_uuids == NULL) {
>         resource_uuids = g_hash_table_new_full(qemu_uuid_hash,
>                                                uuid_equal_func,
>-                                               NULL,
>+                                               g_free,
>                                                g_free);
>     }
>     if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
>-        g_hash_table_insert(resource_uuids, uuid, value);
>+        g_hash_table_insert(resource_uuids,
>+                            g_memdup2(uuid, sizeof(*uuid)),
>+                            value);
>     } else {
>         result = false;
>     }
>-- 
>2.47.0
>


