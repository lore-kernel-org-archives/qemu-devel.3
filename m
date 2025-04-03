Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761F7C3601B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 07:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Ewb-0000B5-5s; Thu, 03 Apr 2025 03:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0EwY-0000Af-Ub
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 03:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0EwW-0008TS-Ug
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 03:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743665091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QwUEY0bct/zmBxi9h/Rsmg1Phrg0cbyuoTNpG+MFCjI=;
 b=iXjMgQ2/GgrgerVFEOGako+R525cOWmkGbDqbat3IeKgRYR7Iv+5OVoVA/Lyl+cnlXN7uB
 V3YS/jesZcoGknczXAxs23g9WIEctFW5VTMWIWPokkaJnXPTHKKSKzJhz1LZS2qxSr6xb7
 DhbtuieFWDF3VWdZxzkfC9CZZjqnhA8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-BrQdxS8ANNCjd9kztnzvZQ-1; Thu, 03 Apr 2025 03:24:49 -0400
X-MC-Unique: BrQdxS8ANNCjd9kztnzvZQ-1
X-Mimecast-MFC-AGG-ID: BrQdxS8ANNCjd9kztnzvZQ_1743665088
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912b54611dso366285f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 00:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743665088; x=1744269888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QwUEY0bct/zmBxi9h/Rsmg1Phrg0cbyuoTNpG+MFCjI=;
 b=ejk7rCmh0pBD5A5oRrbz39WWXJAMBTp1CQos+m/65gko/3CQTJreerMBr1v1i2J9Ph
 KS3Ke/4hnfUONfQJGlPPO+jsizDNB5Ryq0Ot7zzTmMZkMGIm8UohhqssIWLIu32DU+0B
 Jh9YYArQ6ohhMyp6nT48SmLP4B0rHvXCTYXXuHNpRCAzPXqXfGmC1fmYnGWLjQlgMrxg
 4dV/aYtKXZNMEwKtClKhBZXrmebzM4dfb9eo+HY7+tCHJ5DVeOwHMsJ8lTxqrFumpQHM
 9XhWDUCuYD0egeM+81nSgB9yuhhEu8zwsW4ogU1X3i2Kt6BXQpGXcmYBO48TzZQbP2ZE
 RUzw==
X-Gm-Message-State: AOJu0YzVufZFnbQWhYS9Irrfl4zOm4DuTMW7LnzPZ8ZyQb7N9EWFK/aD
 m3QmX1fR6EizkvVDzJ+YM544enHYs15XMV4AuujQ2oDigPEFhYzslk9EMeeZC+g3rJWJAmhO/gb
 FpiNbn6h3f8Uq0P12l+v1e/SMxctxzgom0C3r2wReuFRBMIFCJuS2aJd5F9sWhY5wTRRsXVuR+y
 oz8tv88pc05l4/pq+pGCzqbC5KKSE=
X-Gm-Gg: ASbGnctpN2eYYH7/1rrfQLHNu7kvm3ff3lHsMKs/Icu+aJ5u4n9BxN6lE4B1Ns/lBBV
 xkH97/dO9Q2XRU3mjD4bqdkx41fAshl0scaE34BD0lhlxHBppvBUz46iSe8PyyeJWXmDseGmAs/
 A=
X-Received: by 2002:a5d:64c5:0:b0:38f:2413:2622 with SMTP id
 ffacd0b85a97d-39c1211b51cmr16998745f8f.47.1743665087992; 
 Thu, 03 Apr 2025 00:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHqs/UFhbEMba4qZZuopls69abuWulFLXSuxipeWvLjI1/ThMkGsGHfs1qwzGuZS++//ElRS0Pfhe7c75729k=
X-Received: by 2002:a5d:64c5:0:b0:38f:2413:2622 with SMTP id
 ffacd0b85a97d-39c1211b51cmr16998724f8f.47.1743665087568; Thu, 03 Apr 2025
 00:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <87plhwgbu6.fsf@suse.de>
In-Reply-To: <87plhwgbu6.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 3 Apr 2025 12:54:31 +0530
X-Gm-Features: ATxdqUFIBi2fZj6G-XYCtMoVW0GTacCon38qWwP5CwtY724yu_5rvj9dDWwyyZg
Message-ID: <CAE8KmOyS+nPexU_NbF0yhK_=ubnGgKs5Lv+j7bH=xowgqQ2zkA@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] Allow to enable multifd and postcopy migration
 together
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Tue, 1 Apr 2025 at 02:24, Fabiano Rosas <farosas@suse.de> wrote:
> The postcopy/multifd/plain test is still hanging from time to time. I
> see a vmstate load function trying to access guest memory and the
> postcopy-listen thread already finished, waiting for that
> qemu_loadvm_state() (frame #18) to return and set the
> main_thread_load_event.
>
> Thread 1 (Thread 0x7fbc4849df80 (LWP 7487) "qemu-system-x86"):
> #0  __memcpy_evex_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:274
> #1  0x0000560b135103aa in flatview_read_continue_step (attrs=..., buf=0x560b168a5930 "U\252\022\006\016\a1\300\271", len=9216, mr_addr=831488, l=0x7fbc465ff980, mr=0x560b166c5070) at ../system/physmem.c:3056
> #2  0x0000560b1351042e in flatview_read_continue (fv=0x560b16c606a0, addr=831488, attrs=..., ptr=0x560b168a5930, len=9216, mr_addr=831488, l=9216, mr=0x560b166c5070) at ../system/physmem.c:3073
> #3  0x0000560b13510533 in flatview_read (fv=0x560b16c606a0, addr=831488, attrs=..., buf=0x560b168a5930, len=9216) at ../system/physmem.c:3103
> #4  0x0000560b135105be in address_space_read_full (as=0x560b14970fc0 <address_space_memory>, addr=831488, attrs=..., buf=0x560b168a5930, len=9216) at ../system/physmem.c:3116
> #5  0x0000560b135106e7 in address_space_rw (as=0x560b14970fc0 <address_space_memory>, addr=831488, attrs=..., buf=0x560b168a5930, len=9216, is_write=false) at ../system/physmem.c:3144
> #6  0x0000560b13510848 in cpu_physical_memory_rw (addr=831488, buf=0x560b168a5930, len=9216, is_write=false) at ../system/physmem.c:3170
> #7  0x0000560b1338f5a5 in cpu_physical_memory_read (addr=831488, buf=0x560b168a5930, len=9216) at qemu/include/exec/cpu-common.h:148
> #8  0x0000560b1339063c in patch_hypercalls (s=0x560b168840c0) at ../hw/i386/vapic.c:547
> #9  0x0000560b1339096d in vapic_prepare (s=0x560b168840c0) at ../hw/i386/vapic.c:629
> #10 0x0000560b13390e8b in vapic_post_load (opaque=0x560b168840c0, version_id=1) at ../hw/i386/vapic.c:789
> #11 0x0000560b135b4924 in vmstate_load_state (f=0x560b16c53400, vmsd=0x560b147c6cc0 <vmstate_vapic>, opaque=0x560b168840c0, version_id=1) at ../migration/vmstate.c:234
> #12 0x0000560b132a15b8 in vmstate_load (f=0x560b16c53400, se=0x560b16893390) at ../migration/savevm.c:972
> #13 0x0000560b132a4f28 in qemu_loadvm_section_start_full (f=0x560b16c53400, type=4 '\004') at ../migration/savevm.c:2746
> #14 0x0000560b132a5ae8 in qemu_loadvm_state_main (f=0x560b16c53400, mis=0x560b16877f20) at ../migration/savevm.c:3058
> #15 0x0000560b132a45d0 in loadvm_handle_cmd_packaged (mis=0x560b16877f20) at ../migration/savevm.c:2451
> #16 0x0000560b132a4b36 in loadvm_process_command (f=0x560b168c3b60) at ../migration/savevm.c:2614
> #17 0x0000560b132a5b96 in qemu_loadvm_state_main (f=0x560b168c3b60, mis=0x560b16877f20) at ../migration/savevm.c:3073
> #18 0x0000560b132a5db7 in qemu_loadvm_state (f=0x560b168c3b60) at ../migration/savevm.c:3150
> #19 0x0000560b13286271 in process_incoming_migration_co (opaque=0x0) at ../migration/migration.c:892
> #20 0x0000560b137cb6d4 in coroutine_trampoline (i0=377836416, i1=22027) at ../util/coroutine-ucontext.c:175
> #21 0x00007fbc4786a79e in ??? () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:103
>
>
> Thread 10 (Thread 0x7fffce7fc700 (LWP 11778) "mig/dst/listen"):
> #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
> #1  0x000055555614e33f in qemu_futex_wait (f=0x5555576f6fc0, val=4294967295) at qemu/include/qemu/futex.h:29
> #2  0x000055555614e505 in qemu_event_wait (ev=0x5555576f6fc0) at ../util/qemu-thread-posix.c:464
> #3  0x0000555555c44eb1 in postcopy_ram_listen_thread (opaque=0x5555576f6f20) at ../migration/savevm.c:2135
> #4  0x000055555614e6b8 in qemu_thread_start (args=0x5555582c8480) at ../util/qemu-thread-posix.c:541
> #5  0x00007ffff72626ea in start_thread (arg=0x7fffce7fc700) at pthread_create.c:477
> #6  0x00007ffff532158f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>
> Thread 9 (Thread 0x7fffceffd700 (LWP 11777) "mig/dst/fault"):
> #0  0x00007ffff5314a89 in __GI___poll (fds=0x7fffc0000b60, nfds=2, timeout=-1) at ../sysdeps/unix/sysv/linux/poll.c:29
> #1  0x0000555555c3be3f in postcopy_ram_fault_thread (opaque=0x5555576f6f20) at ../migration/postcopy-ram.c:999
> #2  0x000055555614e6b8 in qemu_thread_start (args=0x555557735be0) at ../util/qemu-thread-posix.c:541
> #3  0x00007ffff72626ea in start_thread (arg=0x7fffceffd700) at pthread_create.c:477
> #4  0x00007ffff532158f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>
> Breaking with gdb and stepping through the memcpy code generates a
> request for a page that's seemingly already in the receivedmap:
>
> (gdb) x/i $pc
> => 0x7ffff5399d14 <__memcpy_evex_unaligned_erms+86>:    rep movsb %ds:(%rsi),%es:(%rdi)
> (gdb) p/x $rsi
> $1 = 0x7fffd68cc000
> (gdb) si
> postcopy_ram_fault_thread_request Request for HVA=0x7fffd68cc000 rb=pc.ram offset=0xcc000 pid=11754
> // these are my printfs:
> postcopy_request_page:
> migrate_send_rp_req_pages:
> migrate_send_rp_req_pages: mutex
> migrate_send_rp_req_pages: received
>
> // gdb hangs here, it looks like the page wasn't populated?
>
> I've had my share of postcopy for the day. Hopefully you'll be able to
> figure out what the issue is.
>
> - reproducer (2nd iter already hangs for me):
>
> $ for i in $(seq 1 9999); do echo "$i ============="; \
> QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test \
> --full -r /x86_64/migration/postcopy/multifd/plain || break ; done
>
> - reproducer with traces and gdb:
>
> $ for i in $(seq 1 9999); do echo "$i ============="; \
> QTEST_TRACE="multifd_* -trace source_* -trace postcopy_* -trace savevm_* \
> -trace loadvm_*" QTEST_QEMU_BINARY_DST='gdb --ex "handle SIGUSR1 \
> noprint" --ex "run" --args ./qemu-system-x86_64' \
> QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test \
> --full -r /x86_64/migration/postcopy/multifd/plain || break ; done

* Thank you for the reproducer and traces. I'll try to check more and
see if I'm able to reproduce it on my side.

Thank you.
---
  - Prasad


