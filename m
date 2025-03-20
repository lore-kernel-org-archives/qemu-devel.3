Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6002C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 11:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvERC-0001Yn-AI; Thu, 20 Mar 2025 07:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tvEQz-0001YJ-Ly
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:51:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tvEQu-0006W3-R8
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742471490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RK+cZDpCpIPJxlVNYq6EAIhf6iOUFut/T9hKAkyRa54=;
 b=Gv1DC9XCGkYS6OPcxiadaqLqqo7WhgCQrZar5K6/92PHxOCHa8yLjseSddvrXjf6vLSLmW
 qEJjx0MlSkJnfRmfKQ3APIaFcU+KqGt2MgftsL7QDz58uwSdgnQ/pca1r1F69zmk53ufrg
 JZHNwpChZAaW7SsT4d/z0UYzYDBwTcI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Ir6FtoQpPFeF81quIy0sXw-1; Thu, 20 Mar 2025 07:51:03 -0400
X-MC-Unique: Ir6FtoQpPFeF81quIy0sXw-1
X-Mimecast-MFC-AGG-ID: Ir6FtoQpPFeF81quIy0sXw_1742471462
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so4832075e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 04:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742471461; x=1743076261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RK+cZDpCpIPJxlVNYq6EAIhf6iOUFut/T9hKAkyRa54=;
 b=QoWnBgb5vNE6P5zQ835epG+SCLpd8rjhiUWljRU08kNoAl0M4XGpO06vrEHBLjDeZx
 gRiHzIK5YHr57U80+DgfoR+8FP88lKiwYthtEdb8TtlSUUzW2i01PBJegidmOxEksBCA
 tnKHzgZS8dQgbHhO/nKqWjI1wqCHrALDlooIZ5oBzVNIkMcz1aiCSl9VZiNHBh5jrYdp
 MCfdRWLZ3ML+ZGPc95HYp0x9MBcBjQvhbA5EMoalQaNqTCxFhjTggnOeDLg5HXmBQYWb
 Rnedi1mNbtfxuZ3N9aMsPCVIlsN4Kktp/h4pmhZ/pccYSKaXYPl5VzsP/d9kTq/uS+55
 Uw5A==
X-Gm-Message-State: AOJu0YxPaIhZ9tY/fpcYqe5THgPVAlw8vV73SymnHjjQRxArGUriRlh4
 wx7JExwnKZ/XaBGW2MPOOQXk31qVUuysc33lmLnfc9uYh8KhhZT/Q8VCswMa3i8pWTcXrXyUH4s
 8ybh8KS/IDYeXPdm/CDklQvIkIjLcpvpP5jEw1DdTYzg0pEiVR6luFBY74JHYA4+5dcIui9kNWR
 XT+11CO9cZ81IZCYUS0w+2imAeQmM=
X-Gm-Gg: ASbGncvajDrgF3gWusjQu1J669v1rhnlhOrTt5BR7dcMidnWaQfed2F9fCtd6Nc7iY6
 BDUNb4WzAXmocPuvOMU+ZMYepaybTd6+OqwS2cuAXRaFpXOi+HpYpn7j6K6hvn8rboM8sjqi7kx
 o=
X-Received: by 2002:a05:600c:3845:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-43d438a66afmr64742825e9.29.1742471460589; 
 Thu, 20 Mar 2025 04:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAymTrT51C/JCGMlq3/PEnUEIRWVZtphI8kZOqCFk/tz413MUSxMwuoWqvRTJjdJi3mVgsFgPuky816fqVKMI=
X-Received: by 2002:a05:600c:3845:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-43d438a66afmr64742505e9.29.1742471460165; Thu, 20 Mar 2025
 04:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-2-farosas@suse.de>
In-Reply-To: <20250307134203.29443-2-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 20 Mar 2025 17:20:43 +0530
X-Gm-Features: AQ5f1JoZjznct9vo44Nz4OUDlyw1JzvWPWAO1bAdY0pHetiv79dPUHkv-aiCa60
Message-ID: <CAE8KmOx0KQ7OfbyivQ_256JVRugtJ8ekykxtQw-uz91Uiuv-tg@mail.gmail.com>
Subject: Re: [PATCH 1/2] migration: Add some documentation for multifd
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Fabiano,

* First big thank you for starting/writing this document. It is a
great resource.

On Fri, 7 Mar 2025 at 19:13, Fabiano Rosas <farosas@suse.de> wrote:
> +++ b/docs/devel/migration/multifd.rst
> @@ -0,0 +1,254 @@
> +Multifd
> +Multifd is the name given for the migration capability that enables
> +data transfer using multiple threads. Multifd supports all the
> +transport types currently in use with migration (inet, unix, vsock,
> +fd, file).

* Multifd is Multiple File Descriptors, right? Ie. Does it work with
one thread but multiple file descriptors? OR one thread per file
descriptor is always the case? I have not used/tried 'multifd +
file://' migration, but I imagined there one thread might be able to
read/write to multiple file descriptors at a time.

> +Usage
> +-----
> +
> +On both source and destination, enable the ``multifd`` capability:
> +
> +    ``migrate_set_capability multifd on``
> +
> +Define a number of channels to use (default is 2, but 8 usually
> +provides best performance).
> +
> +    ``migrate_set_parameter multifd-channels 8``
> +

* I get that this is a QEMU documentation, but for users/reader's
convenience it'll help to point to libvirt:virsh migrate usage here ->
https://www.libvirt.org/manpages/virsh.html#migrate , just as an
alternative. Because doing migration via QMP commands is not as
straightforward, I wonder who might do that and why.


> +Restrictions
> +------------
> +
> +For migration to a file, support is conditional on the presence of the
> +mapped-ram capability, see `mapped-ram`.
> +
> +Snapshots are currently not supported.

* Maybe: Sanpshot using multiple threads (multifd) is not supported.

> +`postcopy` migration is currently not supported.

* Maybe - 'postcopy' migration using multiple threads (multifd) is not
supported. ie. 'postcopy' uses a single thread to transfer migration
data.

* Reason for these suggestions: as a writer it is easy to think
everything written in this page is to be taken with multifd context,
but readers may not do that, they may take sentences in isolation.
(just sharing thoughts)

> +Multifd consists of:
> +
> +- A client that produces the data on the migration source side and
> +  consumes it on the destination. Currently the main client code is
> +  ram.c, which selects the RAM pages for migration;

* So multifd mechanism can be used to transfer non-ram data as well? I
thought it's only used for RAM migration. Are device/gpu states etc
bits also transferred via multifd threads?

> +- A packet which is the final result of all the data aggregation
> +  and/or transformation. The packet contains: a *header* with magic and
> +  version numbers and flags that inform of special processing needed
> +  on the destination; a *payload-specific header* with metadata referent
> +  to the packet's data portion, e.g. page counts; and a variable-size
> +  *data portion* which contains the actual opaque payload data.

* It'll help to define the exact packet format here. Like they do in RFCs.

Thank you for writing this.
---
  - Prasad


