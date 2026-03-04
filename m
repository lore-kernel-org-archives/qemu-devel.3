Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EAEEF8FE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxm2C-0002Rv-SZ; Wed, 04 Mar 2026 08:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxm28-0002Q2-3X
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:13:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxm26-00070Y-Dr
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772629977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=06w7ivhzxzqxYmRkVrp0VcGzAKKtp45TLSL5UGbqZDA=;
 b=CKla0Ny1noCM9pFWYbH9TrNxrcCai42G07asT9kQQuBDrcVzndYr4GLbWrktwqta7U0/cf
 N024jwZFaDkmEitXN6WjxjBn2PJPDm4UREXXzCc7ka4mkTchMTEdvfnmzgPjjQXtwfUghO
 YtALaqK2xlNM8qFWuhLMGEOauiRILXU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-LpdwnDx7Mm6Ftv5PIR4OgA-1; Wed, 04 Mar 2026 08:12:55 -0500
X-MC-Unique: LpdwnDx7Mm6Ftv5PIR4OgA-1
X-Mimecast-MFC-AGG-ID: LpdwnDx7Mm6Ftv5PIR4OgA_1772629975
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4830e7c6131so73492335e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772629974; x=1773234774; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=06w7ivhzxzqxYmRkVrp0VcGzAKKtp45TLSL5UGbqZDA=;
 b=a0m6K1vbOoo6uJM7N6iSw8pdo1F2HMNVtLPuXGRXdo8raBc0Lz2YCAJeNcOKunkeve
 oMVBZ8XrEt05spDlAXdOk3LCPT0WDJ+bFT3KwOQ/L2ofAftTPB+dDjXs2YUB31poeD0R
 1A8tjnbTpEo7EpxknFH959jkZTvYNv+N7hXD/wjArB7VCJJvvWTmyE/otLD482Chu3AL
 Dbk9+/Mlqp9xnnbm28ot9Ps9kPWbuNdV7Y8nhbfgqDtHoUPdOipO4afv3hGaK3y8o4OJ
 ukGpUtqAYF+FLvyZU1jcfzHBH6Up1r6RMl2ll9Nnhe3CkhgXN3q+f5nzPjTnXLl/ukv7
 Pilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772629974; x=1773234774;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06w7ivhzxzqxYmRkVrp0VcGzAKKtp45TLSL5UGbqZDA=;
 b=JFxCp5o01JIWTBQjNMeTir8eqCLwiegL33kqgUMnEWsnu0HNoBH4vwqGE5M5/C7m99
 HhcWtwSiYcn3jX65aN0BY43rWYbJmcbD6zArQiM6iQapIYNMg9nv/g0ELdnUEyEWL3Th
 gatybkMXtrG1Am2EOJHt+8VPuOlCRZiHi4Lnt7S98UQhh3ZvBsdXd/TJCYO38K1yySgJ
 tP6sC2Hfn0ajQBd3sHLvkyt3wWPuvYe94owZpoMfQb529ipaaDL7kaXfr6nOKNFIi3fo
 9ZVYVaYF0mbh0lugasgVYC4JEVwdgOKLX7m4EC0drpib1ty0xmexLENCo8/YmeTAeM0j
 0i+w==
X-Gm-Message-State: AOJu0YyhWGTGhL551L4JfKqnh1GLZu/PzOhxpSQGMMMCi3DMmo7b7+ue
 Ap84hyGJVcPrZV6kQIV4wq3V6eg2e3D3/i1eUNV1xYgzES2pLzrxXo/zEBJnzvRgM0UDpzQCXiU
 UVNQ1avisVjzwkXyGiDnD8xuNOS9TFItIq7kZFjc1yXoOoBfgFjN8IkjK
X-Gm-Gg: ATEYQzxCljmAHSNRSExwEVCkrxgnUpL2w8igTOxaoh7Zl53j2xq4spZvCqBORk4Iqnt
 Tgo6Ce4CCoKIDdqdfromQiXLWNt45EL40rRp3/cwSHbglcsrlD8owqn5X97norSEvxylBCbvtY2
 XaRPSIZkaNtnowAZYgdjjVSwoyOYWr0jCgCNVU571Rr7j0KnYMEdsnxrsIdlLeq+uJHN/AaxpL+
 i73l/AoFZLNIE/vgdiQgJCBH2p3t5kBa4pSFdPVs6LtS2deWiEsCzv9s30VET+GklED+rMf3rgn
 1yzxI7/L+Z4tH5jV2KNf/WyWOZvInVmDK+Prh36jIT+SQsJvqWeI/T+prsd3fFkLgVx9UR4lebN
 ZwVe+ewUHdbBX80joEwGrzBDQyhENP2xPpaBJ6ek6FHahC1YKAUoW4EMCGGzQEGcOHFXHoU4=
X-Received: by 2002:a05:600c:4503:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-485198992cdmr34797895e9.28.1772629974524; 
 Wed, 04 Mar 2026 05:12:54 -0800 (PST)
X-Received: by 2002:a05:600c:4503:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-485198992cdmr34797395e9.28.1772629974018; 
 Wed, 04 Mar 2026 05:12:54 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it.
 [82.53.134.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485188923c2sm51896675e9.14.2026.03.04.05.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:12:53 -0800 (PST)
Date: Wed, 4 Mar 2026 14:12:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mst@redhat.com,
 dbassey@redhat.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 stefanha@redhat.com, manos.pitsidianakis@linaro.org, jasowang@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, 
 slp@redhat.com, hi@alyssa.is, stevensd@chromium.org
Subject: Re: [PATCH v13 5/7] vhost_user.rst: Add GET_SHMEM_CONFIG message
Message-ID: <aagvzHxU9FZCHnj7@sgarzare-redhat>
References: <20260219130334.787858-1-aesteve@redhat.com>
 <20260219130334.787858-6-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260219130334.787858-6-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 19, 2026 at 02:03:32PM +0100, Albert Esteve wrote:
>Add GET_SHMEM_CONFIG vhost-user frontend
>message to the spec documentation.
>
>Reviewed-by: Alyssa Ross <hi@alyssa.is>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---
> docs/interop/vhost-user.rst | 39 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 39 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>index ae4ad6f441..77a763c7c3 100644
>--- a/docs/interop/vhost-user.rst
>+++ b/docs/interop/vhost-user.rst
>@@ -371,6 +371,22 @@ MMAP request
>   - 0: Pages are mapped read-only
>   - 1: Pages are mapped read-write
>
>+VIRTIO Shared Memory Region configuration
>+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>+
>++-------------+---------+------------+----+--------------+
>+| num regions | padding | mem size 0 | .. | mem size 255 |
>++-------------+---------+------------+----+--------------+
>+
>+:num regions: a 32-bit number of regions
>+
>+:padding: 32-bit
>+
>+:mem size: an array of 256 64-bit fields representing the size of each
>+           VIRTIO Shared Memory Region. ``num regions`` specifies the
>+           number of valid regions (non-zero size). The array index
>+           corresponds to the shared memory ID (shmid).
>+
> C structure
> -----------
>
>@@ -397,6 +413,7 @@ In QEMU the vhost-user message is implemented with the following struct:
>           VhostUserShared object;
>           VhostUserTransferDeviceState transfer_state;
>           VhostUserMMap mmap;
>+          VhostUserShMemConfig shmem;
>       };
>   } QEMU_PACKED VhostUserMsg;
>
>@@ -1761,6 +1778,28 @@ Front-end message types
>   Using this function requires prior negotiation of the
>   ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
>
>+``VHOST_USER_GET_SHMEM_CONFIG``
>+  :id: 44
>+  :equivalent ioctl: N/A
>+  :request payload: N/A
>+  :reply payload: ``struct VhostUserShMemConfig``
>+
>+  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
>+  successfully negotiated, this message can be submitted by the front-end
>+  to gather the VIRTIO Shared Memory Region configuration. The back-end will
>+  respond with the number of VIRTIO Shared Memory Regions it requires, and
>+  each shared memory region size in an array. The shared memory IDs are
>+  represented by the array index. The information returned shall comply
>+  with the following rules:
>+
>+  * The shared information will remain valid and unchanged for the entire
>+    lifetime of the connection.
>+
>+  * The Shared Memory Region size must be a multiple of the page size
>+    supported by mmap(2).
>+
>+  * The size may be 0 if the region is unused.
>+
> Back-end message types
> ----------------------
>
>-- 
>2.52.0
>


