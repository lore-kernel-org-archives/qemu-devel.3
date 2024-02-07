Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF0DC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 11:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXgIJ-0003Yv-9p; Wed, 07 Feb 2024 06:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXgID-0003Wv-0v
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:40:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXgIB-0002iH-G9
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707306038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HG7u+FCeBeIXCusATgJ4sSuhIdXoQVBWwDBBKPtQ5k=;
 b=Be0rq56TKyHKivtl04FwFF/vz/tMZymW9hLscBbUvDPx+Qy8vtVBPlm3HhpRms1+/+WmRW
 sJKZkomKXTo9ShcwH04lnHEgzCmbcBr7a0VWaHajn8FNtr2cpzlnUcyQSufLDdKpnvkepp
 j3Sf6I/8IXCuynGH50tUJlIjCoPkdlQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-RJJdsIjXM0SJDCQgIlfHuA-1; Wed, 07 Feb 2024 06:40:36 -0500
X-MC-Unique: RJJdsIjXM0SJDCQgIlfHuA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5605a2937d4so243676a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 03:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707306035; x=1707910835;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9HG7u+FCeBeIXCusATgJ4sSuhIdXoQVBWwDBBKPtQ5k=;
 b=Mgsl3ajwBqx46uM7skLoLHAon4sS6DwvJ5EUnWXo5IzdoOrthSjLNHt3Z+lLEunGVz
 b2KzyetDelAmRH0c6AZzWI6ZjYBcSCh9tLX6DFnTKoyq6vWNF4UiC5tPBhzD/eCzHtCJ
 JR9puS5V0J/j55jRvLMRGLFUtDamTY3PeusKmNxL5E1zcnWiSwg9VfTHVouf98Gu/oTl
 Iq1YHM6ek3+BiCm9yzHwGCyg/Ox/Z8Hi5kFZW+I0Grguxhv1UUbJ+d3tuAjZmS8ftrDR
 YD6KGlPin0ELFCWx1CT1R0d//umFQVA58p1spjItWDmDlYOBT8w10fAUxkNSjit5LhQO
 /v7w==
X-Gm-Message-State: AOJu0YyXo4yD4l7HxQFsr2zmGODZkFMp+RNNGaruauJeQVsTn0TjS9Gt
 W4xexEbBiP4w5WtWuvWaJfn3HYHw6PKYotml8cXEuh4hnohJz6JHDOmCVCv7pzr+ipnm311qdf3
 fEEFnyGr7386O4ACOb778OpccBCV1hi6umWbs3XA7RZk/Rq8Hz+YH
X-Received: by 2002:a50:ed12:0:b0:560:e621:5f34 with SMTP id
 j18-20020a50ed12000000b00560e6215f34mr678292eds.36.1707306035687; 
 Wed, 07 Feb 2024 03:40:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBSPDyoCsfYG2U9Iua4KlmRpjmoDGYmOJ+W0SG0awT3ufRIKdkbES4+uf7meqU7FI0MvgGpA==
X-Received: by 2002:a50:ed12:0:b0:560:e621:5f34 with SMTP id
 j18-20020a50ed12000000b00560e6215f34mr678274eds.36.1707306035349; 
 Wed, 07 Feb 2024 03:40:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXsv5oImknL51QLJmm0UaoWb/Rg8uYvcbbmLLXWobP5psA5JVqF+Mr96tZ62qQEkqIKpNvul4n6mrBkdvOLSIebgh4LR/6r0A7AvBQjzpwVBXkRo1PaIgOqrwKudgNm5FgG+7+zZUVuF+8pgtrWOu1aerA8X4ZcBAxJrjBXRLCQZ5XHxevsIjCOm4AmlLnhjHrHL2TNXF88ugI=
Received: from sgarzare-redhat (host-87-12-25-87.business.telecomitalia.it.
 [87.12.25.87]) by smtp.gmail.com with ESMTPSA id
 v30-20020a50d59e000000b005606b3d835fsm608691edi.50.2024.02.07.03.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 03:40:34 -0800 (PST)
Date: Wed, 7 Feb 2024 12:40:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v1 00/15] libvhost-user: support more memslots and
 cleanup memslot handling code
Message-ID: <m4ss6m67yk43tasdutjey544dwfvznd2r7ytwe5bccvsiiuhdt@ejefxhpxnm2u>
References: <20240202215332.118728-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240202215332.118728-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 02, 2024 at 10:53:17PM +0100, David Hildenbrand wrote:
>This series adds support for more memslots (509) to libvhost-user, to
>make it fully compatible with virtio-mem that uses up to 256 memslots
>accross all memory devices in "dynamic-memslot" mode (more details
>in patch #3).
>
>One simple fix upfront.
>
>With that in place, this series optimizes and extens memory region
>handling in libvhost-user:
>* Heavily deduplicate and clean up the memory region handling code
>* Speeds up GPA->VA translation with many memslots using binary search
>* Optimize mmap_offset handling to use it as fd_offset for mmap()
>* Avoid ring remapping when adding a single memory region
>* Avoid dumping all guest memory, possibly allocating memory in sparse
>  memory mappings when the process crashes
>
>I'm being very careful to not break some weird corner case that modern
>QEMU might no longer trigger, but older one could have triggered or some
>other frontend might trigger.
>
>The only thing where I am not careful is to forbid memory regions that
>overlap in GPA space: it doesn't make any sense.
>
>With this series, virtio-mem (with dynamic-memslots=on) +
>qemu-storage-daemon works flawlessly and as expected in my tests.

I don't know much about this code, but I didn't find anything wrong with 
it. Thank you also for the great cleanup!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


