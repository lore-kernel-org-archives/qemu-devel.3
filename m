Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4EFC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 23:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYwE8-0004yh-8K; Fri, 17 Jan 2025 18:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tYwE6-0004yP-8G
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 18:58:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tYwE4-0000D5-8S
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 18:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737158285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eoww19piJASZPGvRWJGpm3+pPmYYbdkcoy96LyslOwo=;
 b=ExO3xRk2JmtK2uh95HEsq+pfa6q5tBWIqEMi7V2c/ziTqy6zxji7Sl8uKdYCAvUj9W+adE
 q1bxl+EwPgPAp3S371yAWvtwxtRCdtFoTGC5zMdqg0zNriJNdssf8tf5uWqbY0OaPhE1v7
 7t8UN0nlFhmzE/u2Du4bwZn6WSBN9b8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-h1FGVoWpNJy8FlZrKnL14g-1; Fri, 17 Jan 2025 18:58:04 -0500
X-MC-Unique: h1FGVoWpNJy8FlZrKnL14g-1
X-Mimecast-MFC-AGG-ID: h1FGVoWpNJy8FlZrKnL14g
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-21648c8601cso47631485ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 15:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737158283; x=1737763083;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eoww19piJASZPGvRWJGpm3+pPmYYbdkcoy96LyslOwo=;
 b=an61D3dvQyMKJ+E8I8fNqVFnKFj3IMSMgp4fI3HqpKvARIzyMTo4j3WSCDh4ULNcvm
 +oH30V0aZgOPgtp26262l4PAmMpXCKSjaiqoCfEONohmVVv/3JYdz7wbc93hKUrDUkZF
 12xfo/GS0nSIar/MUbphMbnBGLqZBtlY999MKXyzGAkkviUEMy1Cyl65zOgfg0rRCeKw
 /oKnIGbQbR9JRu36Og86l1fG/KKBwkiukDyGYhJf7kyaJZAJ8ajIW9q6J2bD8e3DdiYV
 cfETL9nfJNmCSjJ6/aKvvD6JX8caa21zwN0nMhsLSSSUVpC0bB+bwII/O+2umDL2y3xv
 9PCg==
X-Gm-Message-State: AOJu0YzlWIwjVOFfYcihwoNplxITxISx5O4cwFgX1qsa6NpCJlcz6kIx
 NyQM8UK2yIPuPXVhUmLmb0QxNcAECbRCPD/LQmEH4c+t+6Lmq0A7XCzt3glNMHnWrQdWYBlbeqn
 6Tl40iVdKsrTfr3wshhma+CwXJJe4J6cW2R+b1DMKlWWE6linfrtU
X-Gm-Gg: ASbGncsbjZmIxSIWN4DMI5pouU3hMWv8EfH0lhhfjujPXLNVWw08r1hMJxJLyAPllit
 ovNG0ocSjO1w1BAjQEPyjIJh3mH6tgx8ZQKjT1XwU9FCKuW/pN0NVm2YS2vfZMUaeJPd8ekaGuT
 0wYoTAGWuZxGaKf5nADGjF2Ds4XTZo1APvhKLD4ScL+fm9z+b6pBVsmuwPnQu1UtIksWPVIICxp
 shH/REn/0YJSHJZJCESTVL2J66rIQIrYb7Jp/HHphUSJrZvSeQJc/qcPfmWcAyEfvfPmNIpxO2T
 W7daMsaHDKy8Sf9fcyLIAYyaDFBEgdA=
X-Received: by 2002:a17:902:e94f:b0:216:53fa:634f with SMTP id
 d9443c01a7336-21c355f6e31mr71736575ad.48.1737158283392; 
 Fri, 17 Jan 2025 15:58:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtff4f2ThdhN4/VgpRFhXWPsVQ2HHzCRWJ9OgPb+fL5MtgK6wnuLMQ/MXHJO2Hu5rtmUFk+w==
X-Received: by 2002:a17:902:e94f:b0:216:53fa:634f with SMTP id
 d9443c01a7336-21c355f6e31mr71736315ad.48.1737158282974; 
 Fri, 17 Jan 2025 15:58:02 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ce9efe3sm21594115ad.20.2025.01.17.15.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 15:58:02 -0800 (PST)
Date: Fri, 17 Jan 2025 18:57:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] migration: ram block cpr blockers
Message-ID: <Z4ruhpH28-GnnTq7@x1n>
References: <1737135971-132839-1-git-send-email-steven.sistare@oracle.com>
 <Z4qelNxnBcgO87go@x1n>
 <814d9205-8ba5-48a8-9940-6f16bbb097eb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <814d9205-8ba5-48a8-9940-6f16bbb097eb@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
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

On Fri, Jan 17, 2025 at 02:10:14PM -0500, Steven Sistare wrote:
> On 1/17/2025 1:16 PM, Peter Xu wrote:
> > On Fri, Jan 17, 2025 at 09:46:11AM -0800, Steve Sistare wrote:
> > > +/*
> > > + * Return true if ram contents would be lost during CPR.
> > > + * Return false for ram_device because it is remapped in new QEMU.  Do not
> > > + * exclude rom, even though it is readonly, because the rom file could change
> > > + * in new QEMU.  Return false for non-migratable blocks.  They are either
> > > + * re-created in new QEMU, or are handled specially, or are covered by a
> > > + * device-level CPR blocker.  Return false for an fd, because it is visible and
> > > + * can be remapped in new QEMU.
> > > + */
> > > +static bool ram_is_volatile(RAMBlock *rb)
> > > +{
> > > +    MemoryRegion *mr = rb->mr;
> > > +
> > > +    return mr &&
> > > +        memory_region_is_ram(mr) &&
> > > +        !memory_region_is_ram_device(mr) &&
> > > +        (!qemu_ram_is_shared(rb) || !qemu_ram_is_named_file(rb)) &&
> > > +        qemu_ram_is_migratable(rb) &&
> > > +        rb->fd < 0;
> > > +}
> > 
> > Blocking guest_memfd looks ok, but comparing to add one more block
> > notifier, can we check all ramblocks once in migrate_prepare(), and fail
> > that command directly if it fails the check?
> 
> In an upcoming patch, I will be adding an option analogous to only-migratable which
> prevents QEMU from starting if anything would block cpr-transfer.  That option
> will be checked when blockers are added, like for only-migratable. migrate_prepare
> is too late.
> 
> > OTOH, is there any simpler way to simplify the check conditions?  It'll be
> > at least nice to break these checks into smaller if conditions for
> > readability..
> 
> I thought the function header comments made it clear, but I could move each
> comment next to each condition:
> 
>     ...
>     /*
>      * Return false for an fd, because it is visible and can be remapped in
>      * new QEMU.
>      */
>     if (rb->fd >= 0) {
>         return false;
>     }
>     ...
> 
> > I wonder if we could stick with looping over all ramblocks, then make sure
> > each of them is on the cpr saved fd list.  It may need to make
> > cpr_save_fd() always register with the name of ramblock to do such lookup,
> > or maybe we could also cache the ramblock pointer in CprFd, then the lookup
> > will be a pointer match check.
> 
> Some ramblocks are not on the list, such as named files.  Plus looping in
> migrate_prepare is too late as noted above.
> 
> IMO what I have already implemented using blockers is clean and elegant.

OK if we need to fail it early at boot, then yes blockers are probably
better.

We'll need one more cmdline parameter. I've no objection, but I don't know
how to judge when it's ok to add, when it's better not.. I'll leave others
to comment on this.

But still, could we check it when ramblocks are created?  So in that way
whatever is forbidden is clear in its own path, I feel like that could be
clearer (like what you did with gmemfd).

For example, if I start to convert some of your requirements above, then
memory_region_is_ram_device() implies RAM_PREALLOC.  Actually, ram_device
is not the only RAM_PREALLOC user..  Say, would it also not work with all
memory_region_init_ram_ptr() users (even if they're not ram_device)?  An
example is, looks like virtio-gpu can create random ramblocks on the fly
with prealloced buffers.  I am not sure whether they can be pinned by VFIO
too.  You may know better.

So, to me ram_is_volatile() is harder to follow, meanwhile it may miss
something to me?  IMO it's still better to explicitly add cpr blockers in
the ram block add() path if possible, but maybe you still have good reasons
to do it only until vmstate_register_ram() which I overlooked..

-- 
Peter Xu


