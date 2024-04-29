Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8F6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 20:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1XEu-0004oM-29; Mon, 29 Apr 2024 16:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1XEs-0004o3-ES
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 16:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1XEq-0005MN-He
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 16:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714421075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JrMd6fhUhpKRMyd2t2p1MjDqK932PlHgba2SJYJLHoo=;
 b=HHDsm2ej0WxeEByfnJQHwd3bS2zrnKYL0ty7mdDUudOTIZETkGixzSz6ij/wv2b4zU4bAk
 7bKqj4jvSJ4a0r0OKdxF9dYxMb7AAU+IGCZkUT87Z9hrxaPesGiX3Y5fadkihQCWZ1JmIx
 0gLo7OcwZflJKZasxCwSARQHI0HhYwQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-beRIJKeyOziZBVpq3G6WoA-1; Mon, 29 Apr 2024 16:04:33 -0400
X-MC-Unique: beRIJKeyOziZBVpq3G6WoA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2a536169eb0so1582156a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 13:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714421073; x=1715025873;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrMd6fhUhpKRMyd2t2p1MjDqK932PlHgba2SJYJLHoo=;
 b=f4ArHCd36EbBnRNaJFCkcfMpQkSpp5Ot8CevEX1osisjsl0cJcAvqEKGH4f8xKnzu3
 ZaH6niF+8a7NWmK9KF8++OGZlFK/YFPdKHFMFp4gdquBCNyYT5EXDT9LyflmPv2aDSnx
 E4BAi3KADMyCf2uw8wVuHVUVKJ6QP+8lxY+HtuD4+R4dSK8g39xraGorSZd1zI8lF7fJ
 IXlBeakgrf/GUshSWM+aCsRWMgXj/MN2C9TmnuQf10kSsJO6xe0Nl98kLB1mKtVVfPJU
 O6uInoffQKVDlOg1+zy4L2wfwX+cdNfn4eNwAyqq4DTPDfNbyDsli0YX8osGt/thu6Ut
 ox2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/QD8LoBSHAEh0EZPuV7lJCTxiiGcLi37yXhc8fL1PYxi/8KuVk4wTHHPVtRVnElVzFSwCfH7654msWEa4eA5rlDSvf2Y=
X-Gm-Message-State: AOJu0YznwV1I/va7dCjI/RDYRAkH+sTRy4SUQRTLh2NAUNTX1BJnDcpZ
 7aj2QdKVhQpIGG4pCsa9oIRKv5+/Gz0H/S7qWJo8q9NuVCcapf0mmGFUD73iTicdQfp5uRGnQx1
 FSNS+NdU4KtmwFy3Fl40r/X7cLnnbBnR9sYzIbREe07K7NApWJ4s2
X-Received: by 2002:a17:902:ea04:b0:1e2:b3d:8c67 with SMTP id
 s4-20020a170902ea0400b001e20b3d8c67mr13212448plg.6.1714421072474; 
 Mon, 29 Apr 2024 13:04:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD1umAJpqDh1P0pEBYz59vZs0LLLkCZU37HNqRpHYz0y+UC0YVZaFTzo6OFL5BjpoqT8wOOg==
X-Received: by 2002:a17:902:ea04:b0:1e2:b3d:8c67 with SMTP id
 s4-20020a170902ea0400b001e20b3d8c67mr13212384plg.6.1714421071657; 
 Mon, 29 Apr 2024 13:04:31 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 p2-20020a170902e74200b001e223b9eb25sm20776177plf.153.2024.04.29.13.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 13:04:31 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:04:27 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 23/26] migration/multifd: Device state transfer
 support - send side
Message-ID: <Zi_9SyJy__8wJTou@x1n>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
 <ec2f88766178ab461f19ff4fa1414ce828e9862f.1713269378.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec2f88766178ab461f19ff4fa1414ce828e9862f.1713269378.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 16, 2024 at 04:43:02PM +0200, Maciej S. Szmigiero wrote:
> +bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
> +{
> +    g_autoptr(GMutexLocker) locker = NULL;
> +
> +    /*
> +     * Device state submissions for shared channels can come
> +     * from multiple threads and conflict with page submissions
> +     * with respect to multifd_send_state access.
> +     */
> +    if (!multifd_send_state->device_state_dedicated_channels) {
> +        locker = g_mutex_locker_new(&multifd_send_state->queue_job_mutex);

Haven't read the rest, but suggest to stick with QemuMutex for the whole
patchset, as that's what we use in the rest migration code, along with
QEMU_LOCK_GUARD().

> +    }
> +
> +    return multifd_queue_page_locked(block, offset);
> +}

-- 
Peter Xu


