Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351EECEFCFE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 20:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdDJJ-0001sI-4M; Tue, 06 Jan 2026 15:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdDJE-0001nf-Ly
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:05:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdDJC-0000YM-1c
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767729937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+25nAgI0UW2/RP3IDDhkU/XOqeokiDX9/aNvSbCSEw=;
 b=IDZY7oQGdUV7ckC9/S1pBbwcgZc+duWf/eJOSElufMFJZ+bJ90Spc/uijfhiVC84j2dP+K
 wzD2udPKK5se1C8inQmV4OmK0JwIB7I/v6JJG4TXn318zsTa1BA6DVQZwGAKfKcD9MuRws
 SYSRya8ogr7c1QuL18rFLdOXvtQpKzE=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-A0Q2SQXxN5G0WpWEQT8ERA-1; Tue, 06 Jan 2026 15:05:34 -0500
X-MC-Unique: A0Q2SQXxN5G0WpWEQT8ERA-1
X-Mimecast-MFC-AGG-ID: A0Q2SQXxN5G0WpWEQT8ERA_1767729933
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ae26a77b76so624215eec.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 12:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767729933; x=1768334733; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/+25nAgI0UW2/RP3IDDhkU/XOqeokiDX9/aNvSbCSEw=;
 b=C2KsfYHlmQMXt2XRPKKqwnrAgG4cduyljtTi/CRe4TAuuUi0z4/CQuJd73DjSkwHHm
 NU4C9T/nU1uwM/w2F5dNlC33LYRwMG87DE53yEzIUFmGZaTgHWTZ9WF61ZG2lQv8GPKn
 TBRfWJtVwbK81M4lSkzF1YYOvJt8yjA94yX7KnVQ4hM0iVAiAmMqcTB6VQGf2AWJI8FZ
 Ofx1AIuOKBnxUcOYzi1V/dDqlwfFSN0MniTeSbLH0kWnXZc9ahdE8t/wHNLeeqMUbsHo
 HP8dFe2vTPwQmXAiYhhat3xgB3n9V9ApECVLVNX6mPokvTRKVkg3CDChSXh5Ze3AfSCy
 IYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767729933; x=1768334733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+25nAgI0UW2/RP3IDDhkU/XOqeokiDX9/aNvSbCSEw=;
 b=LN4S8JYESGf/RBddUwVLq2Zw7wOZuBf18eHALoibEFx/lOVxU5txSU/LkHT5mzcHue
 IJT6YJ3NLPUPsX0/L36KjLsf5RISWFLHhGp9lQKSllvB/1z6/gxBAYFLOFRNJOr+Uz+0
 NGxdbS7VuvyZoW4DwspHaKbkh1gMKJ7zMJHwAwnrUMRlsNu5bcjreVDlzdQRqWs6KrWx
 xRJ94sAi48Emhsv6qo95jO63Mg8jUlz8ttwqY0s/6jFqZD8cf2mT44qVwzHTvuBmaQ5U
 pvPoo5fKLQZ2hW4l4codDzEl4smR3lBPo/qAb4h3PJvLRgdqeTdpqw6mtIaVNhKcMNAW
 tlbg==
X-Gm-Message-State: AOJu0YyvVX1lLF2P7N8NSmRMBVDIcDUI0B6JXFjxElGuv4JF9fWQkcRa
 Nev9mHXxeq/+VZ58s1svGkUxQfIrYGEhy18byFlpLty2WmEQ1uYMOClkR8G8NOoURKSqamiBCyR
 ErFj/OeAa+h2IxDu5ySSqirNS8a9mwFDy+Ray+Ecsg8NDQnOa20CqG+aj
X-Gm-Gg: AY/fxX5TBoBxh2p9DiAOdQz9oxuFhugknQEH9KNt8eKgfIsFY4hjoV0ziXVVe+8+vOj
 pgYoPVX/1T6ulTy9K+nOgWlbSN7eqmH3HGgOSqFETP9bbix5VGxqRhlvNj7MGDwRs3qWB+R7BJB
 1NFCb6qkog0r61PPi/tR1xTzJMdbz9dj58dLWvpxYgbZWmaJh1CpVgOo09qwoU8Um8q32kKctm/
 sGTbqfonX1v3jKjUVZLikpovOB68LOtfH33+mn8BOQH0ZWFYAmK/7wr8cC3f6D+PZbG+zeefz7G
 gBVFG6JLRh0RWWGHgHHG4iGkWlZ+HZGRdOdqWyCwZ+4ahn+AmzK/RcCgRuhc63QVC0+C/LpGXKx
 vC0U=
X-Received: by 2002:a05:7301:46a5:b0:2ae:565e:719 with SMTP id
 5a478bee46e88-2b17d1f0596mr78548eec.4.1767729932966; 
 Tue, 06 Jan 2026 12:05:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoac47h+rndXD8X92yjkKwmHyqusz7hE58UPVMbjkJhXmMTH6emTCH8Ne2eIAgNMyJjqP6yw==
X-Received: by 2002:a05:7301:46a5:b0:2ae:565e:719 with SMTP id
 5a478bee46e88-2b17d1f0596mr78523eec.4.1767729932335; 
 Tue, 06 Jan 2026 12:05:32 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b170673266sm5021102eec.1.2026.01.06.12.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 12:05:31 -0800 (PST)
Date: Tue, 6 Jan 2026 15:05:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH 0/3] migration: Add COLO multifd support and COLO
 migration unit test
Message-ID: <aV1rBn2fLWWVLLZC@x1.local>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 30, 2025 at 03:05:43PM +0100, Lukas Straub wrote:
> Hello everyone,
> This adds COLO multifd support and migration unit tests for COLO migration
> and failover.
> 
> Regards,
> Lukas
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
> Lukas Straub (3):
>       multifd: Add colo support
>       migration-test: Add -snapshot option for COLO
>       migration-test: Add COLO migration unit test
> 
>  migration/meson.build              |   2 +-
>  migration/multifd-colo.c           |  57 ++++++++++++++++++
>  migration/multifd-colo.h           |  26 +++++++++
>  migration/multifd.c                |  14 ++++-
>  tests/qtest/meson.build            |   7 ++-
>  tests/qtest/migration-test.c       |   1 +
>  tests/qtest/migration/colo-tests.c | 115 +++++++++++++++++++++++++++++++++++++
>  tests/qtest/migration/framework.c  |  69 +++++++++++++++++++++-
>  tests/qtest/migration/framework.h  |  10 ++++
>  9 files changed, 294 insertions(+), 7 deletions(-)
> ---
> base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591
> change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46
> 
> Best regards,
> -- 
> Lukas Straub <lukasstraub2@web.de>
> 

Lukas,

I gave it a shot on the tests locally.  I saw a lot of errors even if qtest
didn't think it's failing.  I do not know if it's only me.  Let's discuss
deprecation first, then if we want to keep COLO, then please have a look.
Log attached.

===8<===

$ QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/colo
TAP version 14
# random seed: R02Sa4f442d17819fa84c9ab14620fa9dd5e
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -machine none -accel qtest
# Start of x86_64 tests
# Start of migration tests
# Start of colo tests
# Start of plain tests
# Running /x86_64/migration/colo/plain/secondary_failover
# Using machine type: pc-i440fx-10.2
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name source,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/src_serial -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name target,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/dest_serial -incoming tcp:127.0.0.1:0  -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
qemu-system-x86_64: Can't receive COLO message: Input/output error
qemu-system-x86_64: Unable to write to socket: Broken pipe
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
qemu-system-x86_64: Can't send COLO message: Input/output error
ok 1 /x86_64/migration/colo/plain/secondary_failover
# slow test /x86_64/migration/colo/plain/secondary_failover executed in 2.96 secs
# Running /x86_64/migration/colo/plain/primary_failover
# Using machine type: pc-i440fx-10.2
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name source,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/src_serial -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name target,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/dest_serial -incoming tcp:127.0.0.1:0  -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
qemu-system-x86_64: Can't receive COLO message: Input/output error
qemu-system-x86_64: Can't receive COLO message: Input/output error
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
ok 2 /x86_64/migration/colo/plain/primary_failover
# slow test /x86_64/migration/colo/plain/primary_failover executed in 2.54 secs
# Running /x86_64/migration/colo/plain/primary_failover_checkpoint
# Using machine type: pc-i440fx-10.2
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name source,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/src_serial -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name target,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/dest_serial -incoming tcp:127.0.0.1:0  -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
qemu-system-x86_64: Failed to load section ID: stream error: -5: Channel error: Input/output error
ok 3 /x86_64/migration/colo/plain/primary_failover_checkpoint
# slow test /x86_64/migration/colo/plain/primary_failover_checkpoint executed in 2.87 secs
# Running /x86_64/migration/colo/plain/secondary_failover_checkpoint
# Using machine type: pc-i440fx-10.2
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name source,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/src_serial -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name target,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/dest_serial -incoming tcp:127.0.0.1:0  -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
qemu-system-x86_64: Failed to load section ID: stream error: -5: Unable to read from socket: Connection reset by peer
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
qemu-system-x86_64: Can't send COLO message: Input/output error
qemu-system-x86_64: Can't send COLO message: Input/output error
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
ok 4 /x86_64/migration/colo/plain/secondary_failover_checkpoint
# slow test /x86_64/migration/colo/plain/secondary_failover_checkpoint executed in 3.30 secs
# End of plain tests
# Start of multifd tests
# Running /x86_64/migration/colo/multifd/secondary_failover
# Using machine type: pc-i440fx-10.2
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name source,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/src_serial -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name target,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/dest_serial -incoming defer  -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
qemu-system-x86_64: Can't receive COLO message: Input/output error
qemu-system-x86_64: Can't send COLO message: Input/output error
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
ok 5 /x86_64/migration/colo/multifd/secondary_failover
# slow test /x86_64/migration/colo/multifd/secondary_failover executed in 2.70 secs
# Running /x86_64/migration/colo/multifd/primary_failover
# Using machine type: pc-i440fx-10.2
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name source,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/src_serial -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name target,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/dest_serial -incoming defer  -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
qemu-system-x86_64: Can't receive COLO message: Input/output error
qemu-system-x86_64: Can't receive COLO message: Input/output error
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
ok 6 /x86_64/migration/colo/multifd/primary_failover
# slow test /x86_64/migration/colo/multifd/primary_failover executed in 2.00 secs
# Running /x86_64/migration/colo/multifd/primary_failover_checkpoint
# Using machine type: pc-i440fx-10.2
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name source,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/src_serial -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name target,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/dest_serial -incoming defer  -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
qemu-system-x86_64: Failed to load section ID: stream error: -5: Channel error: Input/output error
ok 7 /x86_64/migration/colo/multifd/primary_failover_checkpoint
# slow test /x86_64/migration/colo/multifd/primary_failover_checkpoint executed in 2.26 secs
# Running /x86_64/migration/colo/multifd/secondary_failover_checkpoint
# Using machine type: pc-i440fx-10.2
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name source,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/src_serial -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2106378.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2106378.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-10.2, -name target,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-WWZRI3/dest_serial -incoming defer  -drive if=none,id=d0,file=/tmp/migration-test-WWZRI3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot   -accel qtest
qemu-system-x86_64: Failed to load section ID: stream error: -5: Unable to read from socket: Connection reset by peer
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
qemu-system-x86_64: Can't send COLO message: Input/output error
qemu-system-x86_64: Can't send COLO message: Input/output error
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
qemu-system-x86_64: Unable to shutdown socket: Transport endpoint is not connected
ok 8 /x86_64/migration/colo/multifd/secondary_failover_checkpoint
# slow test /x86_64/migration/colo/multifd/secondary_failover_checkpoint executed in 3.07 secs
# End of multifd tests
# End of colo tests
# End of migration tests
# End of x86_64 tests
1..8


-- 
Peter Xu


