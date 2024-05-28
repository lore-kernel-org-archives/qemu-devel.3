Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CACC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzKT-0003V4-G8; Tue, 28 May 2024 12:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBzKI-0003IU-RS
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBzKG-0008CX-2B
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716912322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o7H2F0ri8rMw6PKqzpYKYHOTAptnQ28TWK8ylWHBnSc=;
 b=c6XQOQkwUj6fW2wEKw+tAQTIFsOc4zj05FiveK+1EDxxn8xc5TmxHqZfqcm4w6/q2O9PzX
 ipIyINTTGV2peTt+TebBQNT9fObwPSXPMIpitly0+1xTjFvMKvnNNIBZH34zVvpu6ez1c0
 0FdOetIp2E5YSUaZRQyt0rSmTpE6CSI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-NP_4wlk3NTGm3Ht8uQM2zA-1; Tue, 28 May 2024 12:05:21 -0400
X-MC-Unique: NP_4wlk3NTGm3Ht8uQM2zA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6ad803bc570so2917486d6.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912321; x=1717517121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7H2F0ri8rMw6PKqzpYKYHOTAptnQ28TWK8ylWHBnSc=;
 b=Qzayz4JU5PRm2qYU9q+JfLsKTbEiycBBE0sLf162MrWY03D9A/JP6/jsuzI9mjW8m/
 87STHA60Mk2r5SWeYo5ZKVX105WjJA4oKnmOyVFN7GScJvDasfKUDM8e0F4Ov/H5uWaj
 qx3GdwWNPYvDwKTtA6959ElhnY/EVV+P0rSIHGp49+hIO3ftGFTOy6t1S0rDkOJVflYb
 tj2VGPjCGpetSRntRkFp33CNsX+q2ZfxFFq8J6jXVeqmbGsQGl0piJVDBTdj7M6Sw+0W
 z76kdikQU8yrnMj1bf8lWlBsN+tD+XgWrouhAitazywodO6b7B8BYn/U++p/usdMU0ze
 9AkA==
X-Gm-Message-State: AOJu0YzVHpUcknI4tB9CYMSxMDS5A3sCfQs1i1CN2vMfqMHPDN6Mfy1f
 o8FAboK3PM1QDZJ9wZeaYeWV5FzOw4SxsQ5Ibc7J7Jn9fdd7CRuPapexaagRWAxfxQAJg2qzNWM
 r0i8Y0yN8FHMthkQrgXapseKEjnVBOzHr+0dNjbWoZNFixNffEdzU
X-Received: by 2002:ad4:4ea5:0:b0:6ab:2fd2:66ae with SMTP id
 6a1803df08f44-6abcd1866c4mr136537996d6.5.1716912319090; 
 Tue, 28 May 2024 09:05:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVrIafo/URKg7bpmNphnw3lHfnIMtB5j7u2983JUpEvDH3FuF+Rpik5wosEV53rpeqvV6aWQ==
X-Received: by 2002:ad4:4ea5:0:b0:6ab:2fd2:66ae with SMTP id
 6a1803df08f44-6abcd1866c4mr136537566d6.5.1716912318472; 
 Tue, 28 May 2024 09:05:18 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ac070c2d12sm45629346d6.14.2024.05.28.09.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 09:05:17 -0700 (PDT)
Date: Tue, 28 May 2024 12:05:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH] tests/qtest/migrate-test: Use regular file file for
 shared-memory tests
Message-ID: <ZlYAvIFodnTrQIkX@x1n>
References: <20240528042758.621589-1-npiggin@gmail.com> <ZlXdmi7PqKJdv3fP@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlXdmi7PqKJdv3fP@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, May 28, 2024 at 09:35:22AM -0400, Peter Xu wrote:
> On Tue, May 28, 2024 at 02:27:57PM +1000, Nicholas Piggin wrote:
> > There is no need to use /dev/shm for file-backed memory devices, and
> > it is too small to be usable in gitlab CI. Switch to using a regular
> > file in /tmp/ which will usually have more space available.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > Am I missing something? AFAIKS there is not even any point using
> > /dev/shm aka tmpfs anyway, there is not much special about it as a
> > filesystem. This applies on top of the series just sent, and passes
> > gitlab CI qtests including aarch64.
> 
> I think it's just that /dev/shm guarantees shmem usage, while the var
> "tmpfs" implies g_dir_make_tmp() which may be another non-ram based file
> system, while that'll be slightly different comparing to what a real user
> would use - we don't suggest user to put guest RAM on things like btrfs.
> 
> One real implication is if we add a postcopy test it'll fail with
> g_dir_make_tmp() when it is not pointing to a shmem mount, as
> UFFDIO_REGISTER will fail there.  But that test doesn't yet exist as the
> QEMU paths should be the same even if Linux will trigger different paths
> when different types of mem is used (anonymous v.s. shmem).
> 
> If the goal here is to properly handle the case where tmpfs doesn't have
> enough space, how about what I suggested in the other email?
> 
> https://lore.kernel.org/r/ZlSppKDE6wzjCF--@x1n
> 
> IOW, try populate the shmem region before starting the guest, skip if
> population failed.  Would that work?

Let me append some more info here..

I think madvise() isn't needed as fallocate() should do the population work
already, afaiu, then it means we pass the shmem path to QEMU and QEMU
should notice this memory-backend-file existed, open() directly.

I quicked walk the QEMU memory code and so far it looks all applicable, so
that QEMU should just start the guest with the pre-populated shmem page
caches.

There's one trick where qemu_ram_mmap() will map some extra pages, on x86
4k, and I don't yet know why we did that..

    /*
     * Note: this always allocates at least one extra page of virtual address
     * space, even if size is already aligned.
     */
    total = size + align;

But that was only used in mmap_reserve() not mmap_activate(), so the real
mmap() should still be exactly what we fallocate()ed.

Thanks,

-- 
Peter Xu


