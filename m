Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCADC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 09:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpOsR-0002vi-Gd; Tue, 04 Mar 2025 04:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tpOsG-0002uK-OZ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 04:47:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tpOsC-0001v9-R5
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 04:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741081654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggbFt0jU8eEzLwKzJTv1bmj6YmWWiTmIpJewmQ4uF1w=;
 b=bLRCzoU3lGFo/Nh85D0Wg68GV4w6FzT3yeOW1jSPyUglSANItcI2j8AFn32yy3G8rHB0ZM
 D9sALnw+nYQ+ifuzXbzbJ8cewbjX7ee/7W83xJS/0rwaawH6Ct1WSOoQjr8E4X445wSYyZ
 6ZtZBPI/TjyAZDclEFCISBsagrsaPmY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-p3oi9K3qPWC113ffvoSSOA-1; Tue, 04 Mar 2025 04:47:32 -0500
X-MC-Unique: p3oi9K3qPWC113ffvoSSOA-1
X-Mimecast-MFC-AGG-ID: p3oi9K3qPWC113ffvoSSOA_1741081651
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4399a5afc72so24752775e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 01:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741081651; x=1741686451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ggbFt0jU8eEzLwKzJTv1bmj6YmWWiTmIpJewmQ4uF1w=;
 b=Ep8d1tPcD97bjQWPCfTzlhcPTPFQz4wvlzlkWlbgpopYXzqCQNXqULQ7Ck7SDVGYhP
 FnhKOdnSBK6hTvRbx2wbJ8b/lgv56ulOyMjJFcEFdo5YyZlNeu/zozOIHaUCKn5oog0a
 ql4klFMD42lbYqrGs7FqpvIlv+LL3eluNoUJ4yjlJf9u6MY1hxmEAvYsSaG0tdl/BGUY
 cIp1LXBDKIqJLyYUPvr0gg7TR8QxOsXpfxWt3KoX7K1sf6qEIKywNajVOcWnktUN9mHU
 G06I0zFt36snyopSI8ubZsr/n7smgWGMj5PKOlWv6Uck79zbqJXQyRhaqfQnQBt3JNN0
 7vHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwL4UliXdexI4Sm2d1E9tvLVsKD1AqRx7M47+pxshzUK2mx/k7wICccJc0ZyzGn0w2ndvp6WxDdUYh@nongnu.org
X-Gm-Message-State: AOJu0YwajzVfs3UVbQ7jC+2ncwHGWiqc1kFCYfF55ZZ0Jxr/mAbQua4x
 /FtXujMs4uHnLYTCBTxloXAK9fCxnQSdLRCv4KhhDXNaNN1pExasmdw1Ph3n2fE5gYQyoeN5bLy
 pJfvKzfWFNK8j96VvdY7S5tX0D6WWBPCbXtdl4243mvjrhz6xOVfvVUqPqZ2JzoxPlVLZqzQeVW
 5ahtwKS/0TqhrTdQErqRRKHSanVzY=
X-Gm-Gg: ASbGncuJ0Z1VG2NRo1KNvF33+THpcrdRGLDsBp4u9tFgEjGGgJt7I27f8hlMnux6dmz
 Ivx/bomIkrkl4Mm0xNlewViPsDtpntztmT6craiRK4kVCTsNS3rf1sqNvmn9G6ZvLN2RSoHnuqz
 c=
X-Received: by 2002:a05:600c:1d0b:b0:43b:c5a3:2e1a with SMTP id
 5b1f17b1804b1-43bc5a32fd2mr42537895e9.2.1741081651029; 
 Tue, 04 Mar 2025 01:47:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFxxkKyTgcRZ1DjpIrsg7/vWRV7hcire72bF8DFWf8ovrS9iDUByrkM7I6ngXMasKosOy5NVPjieI7BCGoZTo=
X-Received: by 2002:a05:600c:1d0b:b0:43b:c5a3:2e1a with SMTP id
 5b1f17b1804b1-43bc5a32fd2mr42537605e9.2.1741081650560; Tue, 04 Mar 2025
 01:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20250228121749.553184-1-ppandit@redhat.com>
 <87frjy2k8z.fsf@suse.de>
 <CAE8KmOwVoGJ2frVCY76W7UxSr90wAL2EMj5Nmtcrdc+BE1e9=g@mail.gmail.com>
 <Z8W4xVOLLAD1wXjC@x1.local>
In-Reply-To: <Z8W4xVOLLAD1wXjC@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 4 Mar 2025 15:17:14 +0530
X-Gm-Features: AQ5f1JpNyVXerixjYjh6NQrZL22ohgvqFgluJm5N91qJBXI1dn9A73pexazwwkQ
Message-ID: <CAE8KmOzkVpG5iUqwShWWMF4+96-cbNm1AU8b=s3187EyWXXT4g@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Allow to enable multifd and postcopy migration
 together
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi,

On Mon, 3 Mar 2025 at 19:42, Peter Xu <peterx@redhat.com> wrote:
> On Mon, Mar 03, 2025 at 04:17:53PM +0530, Prasad Pandit wrote:
> > * I think we (you, me, Peter) are all looking at things differently.
> >     - In my view Patch-2 is the minimal change _required_  to enable
> > multifd & postcopy. In your view we are _revamping_ channel discovery
> > parts while _sneaking_ in a feature of enabling multifd & postcopy
> > together.
> >     - In my view Patch-5 in this series is an isolated change because
> > it adds a new migration command to allow multifd threads sync from
> > source side. But Peter thinks without that 'flush and sync' Patch-2 is
> > incomplete, so we should merge it back there.
>
> Just to mention, my suggestion does not conflict with splitting patch 2, as
> long as you keep every patch complete on its own.
>
> Patch 5 needs to be squashed to either patch 2 or a split patch out of
> patch 2, because current patch 2 (or any possible way to split it into
> smaller ones, then one of them which enables the feature) is buggy.

* I'll try to segregate different parts, then we can discuss how to
split them across patches:

Terminology:
    _requires_  => is without which migration shall not work at all.
    _essential_ => is without which there may be issues.

1. Enable Multifd and Postcopy together
    - It _requires_ removal of the Multifd capability check in
migration/options.c
    - It _requires_ identification of the CH_POSTCOPY connection when it arrives
        - so enum { CH_MAIN, CH_MULTIFD, CH_POSTCOPY } is defined
        - To identify channels, related changes are made to the
channel discovery part (if .. else conditionals) in
migration_ioc_process_incoming() function.
        - These changes help to establish all channel connections.
After that, the migration proceeds as usual until it's time to start
the Postcopy phase.
    - When time comes to start Postcopy phase, we shutdown multifd channels.
        - it _requires_ calling multifd_send_shutdown()
        - It _requires_ moving
file_cleanup_outgoing/socket_cleanup_outgoing calls to
migration_cleanup() function.
    - When Postcopy phase starts, we don't want ram_save_target
_page() function to call ram_save_multifd_page() function, because
migrate_multifd() is still true.
        - It _requires_ adding the !migration_in_postcopy() checks.

* Above changes are minimal _required_ to enable multifd and postcopy
together, while also ensuring that migration continues to work when
those options are not enabled together. With these changes, guest
migration across two machines works without any observed failures.

2. The multifd_ram_flush_and_sync() call/command and the
assert(!migration_in_postcopy()) call in multifd_recv_thread()
    - These calls help to ensure that no multifd data is left behind
when the Postcopy phase starts.
    - And that multifd_recv threads shall not be active when the
Postcopy is running.
    - They protect the guests from potential state corruption.

* It is up to us to decide whether (2) is _required_ OR _essential_
for the feature. Individual opinions can vary here.

3. Revamp of the channel discovery parts by moving those bits to
connection.c or other places.
    - This entails moving the channel discovery parts from
migration_ioc_process_incoming() function to somewhere else because it
makes more sense to move it there and maybe it reduces complexity and
makes the sources easier to understand.*

* It is up to us to decide whether (3) is _required_  OR  _essential_
for the feature. Individual opinions can vary here.

* IMHO (1) is _required_,  (2) is _essential_,  and (3) is neither
_required_ nor _essential_ for the - Enable multifd and postcopy
together - feature. (3) is a completely unrelated change to this
feature.

Since it is an individual opinion, we all can think differently here
and that is perfectly fine. Once we have some consensus, we can decide
how to split or merge patches and move forward.

Hope it helps. Thank you.
---
  - Prasad


