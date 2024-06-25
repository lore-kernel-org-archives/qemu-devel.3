Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D04EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 22:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sME6Y-0001HG-3k; Tue, 25 Jun 2024 17:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sME6K-0001CP-HZ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 17:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sME5h-00037Y-3F
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 17:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719352288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PtEx5Ys2Z6Te8ry2HAvk6jzSJqsxDILA8PjYfjH4L/w=;
 b=MUNOwNM5yHPaMldKEMc5/HjLkFrBjLk85VE2VB9FIyucQUVL9G+Ua+tdFfFAlUbWkAXIhG
 iXFStzw4BlIgmlm4YNAlcjQ3TDgviFrhnNK2IBNWL7IR2cY6p7tKML0ofDj5QwqE5lQ9UW
 T5HfqoMy4mWcPhsg42cOBzOBvuiNsY0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-7AQpNqztNP2uL193tSsI_Q-1; Tue, 25 Jun 2024 17:51:24 -0400
X-MC-Unique: 7AQpNqztNP2uL193tSsI_Q-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-43e2c5354f9so13165571cf.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 14:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719352284; x=1719957084;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PtEx5Ys2Z6Te8ry2HAvk6jzSJqsxDILA8PjYfjH4L/w=;
 b=BzP7f02PRcmVvU9f5DYXhEc8UOyzhuUVY4YmDFVHBMlEM57JxiZq6iDo1UnOoU+FFt
 0Lx0sbfYtjTdvfIhmp4QNKCldvaCE7od7H8y0lBlF7MKWbSHA/1194vgmsVv1Nono9KS
 D9R62a7oGLdhM5X797MjLtcX1KxazGge1ryDxOi2Qc3EMPn6+EIbVzU9q7dZ4juz6Rk0
 5RLlUfpdoaoNgRwdXalTQVIyAlkFKZtj3jaFiJB94BbJYTGJUdrbVfcOgF2JwviJtKMf
 IcbqeoSa2w5LtDiguAT0UHnM3hwG3RlE3gPmtBsHM/toOuY/iwlJVtRifL//RT+9MTvj
 m+Eg==
X-Gm-Message-State: AOJu0YyX0u5lCGOZrXBqcSpAW9LGuOjlEylNmQhBLOCnnmwc7bQw1p+s
 svZkiTZWlf8rO2xTiujEh2DNKeHz1ES0VL3SPfku/wM2JiXSp6NwfBbREnuxcJlRWosHoPN/fYp
 WWtvuzOm/CMCM42rGVjXZ3L4uAepLeQZne44rC4iqBmJYJJ7lXsB4
X-Received: by 2002:ac8:5f0a:0:b0:444:d0ac:55ca with SMTP id
 d75a77b69052e-444d0ac5ad1mr94252401cf.1.1719352283454; 
 Tue, 25 Jun 2024 14:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFclyD9N2aasjk+a7W2KXCAU8kAYrJ/VQxeWvdmVoC2YZ0kzmesEZB8/St7gMiEEROZWgjBpw==
X-Received: by 2002:ac8:5f0a:0:b0:444:d0ac:55ca with SMTP id
 d75a77b69052e-444d0ac5ad1mr94252211cf.1.1719352282770; 
 Tue, 25 Jun 2024 14:51:22 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-444c2c3e5b5sm60008411cf.75.2024.06.25.14.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 14:51:22 -0700 (PDT)
Date: Tue, 25 Jun 2024 17:51:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Shota Imamura <cosocaf@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 "open list:Overall KVM CPUs" <kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] migration: Implement dirty ring
Message-ID: <Zns71-6ksavoe5fd@x1n>
References: <20240620094714.871727-1-cosocaf@gmail.com>
 <20240620094714.871727-2-cosocaf@gmail.com> <ZnnEOJSSsjG0D009@x1n>
 <CAJo9nWxWrWYa9fpiDSphKaErR5XPFVzuxgXQd4_CPVtXfb7=Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJo9nWxWrWYa9fpiDSphKaErR5XPFVzuxgXQd4_CPVtXfb7=Qg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 25, 2024 at 08:10:23PM +0900, Shota Imamura wrote:
> Dear Peter Xu,
> 
> Thank you for your feedback.
> 
> > It looks like this patch will introduce a ring but still it keeps the
> > bitmaps around.
> >
> > Could you elaborate your motivation of this work? It’ll be interesting to
> > know whether you did any kind of measurement around it.
> 
> First of all, I apologize for the lack of explanation.
> To provide more details, the motivation for this work stems from the
> current QEMU implementation, where pages obtained from the KVM ring are set
> into the KVMSlot/RAMList/RAMBlock bitmaps. Consequently, when the migration
> thread sends data, it ends up scanning the bitmap (resulting in O(N) time
> complexity). I aimed to improve this situation.

So is this a research project?  Or do you have explicit goals, e.g. on
reducing migration time, or make migration easier to converge?

These information might be helpful for reviewers to understand the ultimate
goal of this series.

> 
> Here are the steps and considerations in my implementation plan:
> 
> 1. Call MigrationOps::ram_save_target_page inside kvm_dirty_ring_reap_one.
> 
> The approach involves QEMU holding neither bitmaps nor rings and sending
> immediately. However, this would require non-migration threads (like accel
> threads) to send pages, necessitating a synchronization mechanism with the
> migration thread, which I deemed would increase code complexity.
> Additionally, if future non-KVM accels provided their rings, we would have
> to write similar code in different places, increasing future maintenance
> costs. For these reasons, I decided against an implementation where page
> sending occurs within accel/kvm and opted for a separate ring within QEMU.

Yes this won't trivially work cleanly, as ram_save_target_page() requires
migration context.  It may also not be thread-safe too.  E.g. qemufile
isn't thread-safe.

"maybe" it'll be easier to do it the other way round: allowing migration to
fetch entry from a ring by calling a registered ring op.

> 
> 2. Use a ring as an alternative to bitmaps.
> 
> The approach involves implementing a ring within QEMU and inserting pages
> into the ring instead of setting them into bitmaps in functions like
> kvm_dirty_ring_mark_page, cpu_physical_memory_set_dirty_lebitmap, and
> cpu_physical_memory_set_dirty_range. Then, pages are retrieved from the
> ring in ram_find_and_save_block.

(I think this might be what I mentioned above)

> However, this approach necessitates immediate sending of pages when the
> ring is full, which might involve non-migration threads sending pages,
> leading to the same issues as mentioned in step 1. Given the ring has a
> limited capacity, if there are enough dirty pages to fill the ring, the
> cost difference between operating the ring and scanning the entire bitmap
> would be negligible.  Hence, I decided to fall back to bitmaps when the
> ring is full.

Right, that was also what I found - the ring may not work as well when the
guest is very busy.  Here the question is migration is normally more
challenging when that is the case.. and when with a pretty idle guest it's
easier to migrate anyway even with bitmap-only.  I think I noticed that
pretty late.

> 
> 3. Use bitmaps when the ring is full.
> 
> The approach involves setting bitmaps while simultaneously inserting pages
> into the ring in functions like kvm_dirty_ring_mark_page,
> cpu_physical_memory_set_dirty_lebitmap, and
> cpu_physical_memory_set_dirty_range. If the ring is not full, it is used in
> ram_find_and_save_block; otherwise, bitmaps are used. This way, only the
> migration thread sends pages. Additionally, by checking if a page is
> already in the ring (O(1) complexity), redundant entries are avoided.
> However, enqueuing and dequeuing are handled by different threads, which
> could result in a situation where pages exist in the bitmap but not in the
> ring once it is full. Identifying these pages would require locking and
> scanning the entire bitmap.

Yes, is this series using this approach?

I think the ring effect may be minimum if there is the bitmap already,
because as long as the ring can fallback (to avoid hanging a vcpu for a
long time) it means the bitmap can contain useful data and the bitmap scans
will be needed, then it kind of invalidates the ring's benefit, IMHO.

What I was thinking a long time ago was something like this: we only use
ring, as you said in (2) above, so no bitmap.  Then the migration core can
look like this:

  migration_thread():
    count=0
    while () {
        count++
        if ((count % ENFORCE_BACKGROUND_COUNT == 0) ||
            ring_empty())
            send_page(background.pop())
        else
            send_page(ring.pop())
    }

To explain it a bit:

  - we will have two page iterators:

    - background.pop() means we pop one background page.  Here since we
    don't have a bitmap, we can't scan anything, the background page will
    be an iterator that will migrate the guest memory from page 0 to page
    N-1 (considering there's N guest pages), once and for all.  It means we
    pop guest page 0, then 1, ... until N-1, then it's all done.  After
    this iteration, nothing will be needed in background, all dirty will
    only reside in the ring.

    - ring.pop() means we fetch one entry from the ring.

  - here ENFORCE_BACKGROUND_COUNT will guarantee the background work can
    always make some progress over time, so that at some point it'll flush
    empty and only ring entries left.  Otherwise if we do things like "if
    (!ring_empty()) send_page(ring.pop())" it can happen that we keep
    sending ring pages but we never sent the initial round of RAMs, so it
    will never completes.

Then the background migration doesn't need to keep iterating but only
happen once, and then we know we've finished.

That will be a totally different way to describe migration.  I don't know
whether it'll make sense at all.  There're a lot of hard questions to
answer, e.g. besides MIGRATION we also have TCG/VGA bitmap consumers, and
we need to know how to handle them.  It's also just challenging to remove
all bitmap layers because there're just a huge lot of them in QEMU..

I'm not sure whether above would help at all, but let me still put this
here, maybe it'll let you think about something useful.

> 
> 4. Use two rings to revert to the ring after falling back to the bitmap
> within a round.
> 
> As mentioned earlier, once the fallback to the bitmap occurs, pages that
> get dirty after the ring is full cannot be captured by the ring. This would
> necessitate using bitmaps until the final round or periodically locking and
> scanning the entire bitmap to synchronize with the ring. To improve this, I
> considered using two rings: one for enqueueing and one for dequeuing. Pages
> are inserted into the enqueue ring in functions like
> kvm_dirty_ring_mark_page and cpu_physical_memory_set_dirty_range, and the
> rings are swapped in migration_sync_bitmap, with pages being retrieved in
> ram_find_and_save_block. This way, each call to migration_sync_bitmap (or
> ram_state_pending_exact) determines whether to use the ring or the bitmap
> in subsequent rounds.
> 
> Based on this reasoning, I implemented a system that combines bitmaps and
> rings.
> 
> Regarding performance, my local environment might be insufficient for
> proper measurement, but I obtained the following results by migrating after
> booting the latest Linux and Buildroot with an open login shell:
> 
> Commands used:
> ```
> # src
> sudo ./qemu-system-x86_64 \
> -accel kvm,dirty-ring-size=1024 \
> -m 8G \
> -boot c \
> -kernel ~/path/to/linux/arch/x86/boot/bzImage \
> -hda ~/path/to/buildroot/output/images/rootfs.ext4 \
> -append "root=/dev/sda rw console=ttyS0,115200 acpi=off" \
> -nographic \
> -migration dirty-logging=ring,dirty-ring-size=1024
> 
> # dst
> sudo ./qemu-system-x86_64 \
> -accel kvm,dirty-ring-size=1024 \
> -m 8G \
> -boot c \
> -kernel ~/path/to/linux/arch/x86/boot/bzImage \
> -hda ~/path/to/buildroot/output/images/rootfs.ext4 \
> -append "root=/dev/sda rw console=ttyS0,115200 acpi=off" \
> -nographic \
> -incoming tcp:0:4444
> 
> # hmp
> migrate_set_parameter max-bandwidth 1250
> migrate tcp:0:4444
> info migrate
> ```
> 
> Results for each memory size, measured 5 times:
> ```
> # ring -m 8G
> total time: 418 ms
> total time: 416 ms
> total time: 415 ms
> total time: 416 ms
> total time: 416 ms
> 
> # bitmap -m 8G
> total time: 434 ms
> total time: 421 ms
> total time: 423 ms
> total time: 430 ms
> total time: 429 ms
> 
> # ring -m 16G
> total time: 847 ms
> total time: 852 ms
> total time: 850 ms
> total time: 848 ms
> total time: 852 ms
> 
> # bitmap -m 16G
> total time: 860 ms
> total time: 862 ms
> total time: 858 ms
> total time: 859 ms
> total time: 861 ms
> 
> # ring -m 32G
> total time: 1616 ms
> total time: 1625 ms
> total time: 1612 ms
> total time: 1612 ms
> total time: 1630 ms
> 
> # bitmap -m 32G
> total time: 1714 ms
> total time: 1724 ms
> total time: 1718 ms
> total time: 1714 ms
> total time: 1714 ms
> 
> # ring -m 64G
> total time: 3451 ms
> total time: 3452 ms
> total time: 3449 ms
> total time: 3451 ms
> total time: 3450 ms
> 
> # bitmap -m 64G
> total time: 3550 ms
> total time: 3553 ms
> total time: 3552 ms
> total time: 3550 ms
> total time: 3553 ms
> 
> # ring -m 96G
> total time: 5185 ms
> total time: 5186 ms
> total time: 5183 ms
> total time: 5191 ms
> total time: 5191 ms
> 
> # bitmap -m 96G
> total time: 5385 ms
> total time: 5388 ms
> total time: 5386 ms
> total time: 5392 ms
> total time: 5592 ms
> ```
> 
> It is natural that the implemented ring completes migration faster for all
> memory sizes, given that the conditions favor the ring due to the minimal
> memory workload. By the way, these are total migration times, with much of
> the overhead attributed to page sending and other IO operations.

It's interesting to know there's already a perf difference.  I wonder how
that happened, though, if the bitmap is still there, and it looks like the
scan will still be needed anyway.

I didn't look where a ring full event in kvm can imply halting the vcpu
threads, if with that, and if the vcpu is dirtying something it can even
dirty it slower, it can contributes to a less total dirty pages to move.
Then maybe the total migration time is reduced because of that.  But I'm
not sure.

> 
> I plan to conduct more detailed measurements going forward, but if you have
> any recommendations for good measurement methods, please let me know.
> 
> > I remember adding such option is not suggested. We may consider using
> > either QMP to setup a migration parameter, or something else.
> 
> I apologize for implementing this without knowledge of QEMU's policy.
> I will remove this option and instead implement it using
> migrate_set_parameter or migrate_set_capability. Is this approach
> acceptable?
> 
> This is my first time contributing to QEMU, so I appreciate your guidance.

Not sure how you nail this, but IMHO this can be a very research-level
projects.  I'm not sure what's your goal, if it's about contributing to
qemu there can be more solid problems to solve.  Let me know if it is the
case. At least I am not crystal clear on how to best leverage the rings
yet, I guess, even though it feels like a pretty neat design.

Thanks,

-- 
Peter Xu


