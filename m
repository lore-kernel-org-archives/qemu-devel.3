Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE59C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD9zW-0001sp-WD; Thu, 08 May 2025 18:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_DMdaAwKCiEK78FEBPQBC7KDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--nabihestefan.bounces.google.com>)
 id 1uD9zV-0001sW-FZ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:45:21 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_DMdaAwKCiEK78FEBPQBC7KDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--nabihestefan.bounces.google.com>)
 id 1uD9zT-00060G-E4
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:45:21 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-22e50d4f49bso19151745ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1746744316; x=1747349116; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iRyxdK0tGKEdkT9uJ8FtYCABBgq7tX0Tr4OkuwB043A=;
 b=GIchXrZ2jkTr4WUr5zsSCTbWZw1OHbcKWsUms78qfgJqRxAGnxijbw7FrA7SOFu5Gz
 omeSYbOZ7SVh2seF2qUUHichAmqACfNhU4xV+VTKF7z9knDw5xcLclbaiduxcqcasmI2
 hOQa8TY6A3C5sNaaP9dna8N3yq3TR7QPO5/W7Pa3+I25cj1tsAqURgQlh1TIgjHjxUQO
 69Va6RmRXhz6KhG+CrqGZ5XQuv5mUyaGRyZQ13RzP7BuXfBy7m7Y5WCsgrQDrQNL/aqs
 T1LH0mMBbzTmXVJoLykUlE5wjQhiI9W14OzQhYBBbAeSq+szcnfGbr4jj7EtOGrJbXBF
 fm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746744316; x=1747349116;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iRyxdK0tGKEdkT9uJ8FtYCABBgq7tX0Tr4OkuwB043A=;
 b=nzEnayt6oSEHhNV0ownzdTN6N3QCzQiAO2b+wsZXluCY2FDsvcFU2ylchw9+B6HgBq
 FCssFZr4JDCkkU5i4HhF+RdMqw+BjJa1HE3yccsAVxOHSbPV1JuxvirDfKjFGwRHCeZ/
 Y8iZ4DdB466bppIgQABo3pCLlU9AV1ckC3+y3fF2yuJSoY4/hV57zpv9aZk/QlZZ1KzY
 pSNU0FcZJcOZi4kg82cCAgpRth4omKiIpv+WO6fetkhgezDj3C6hj8NZj91LF86ug6Yi
 HKFN0jHZvm6LIAPD5Zi6Q1NgJe+p2N8QQAMHI2diaO31lLCdek2Csny6rSxIprIkG6Wy
 7m9g==
X-Gm-Message-State: AOJu0YyqtD9DfLhnjuPt/HdV2MiOjSpEIu/gkWuM91I014ubZZCDWZeX
 NbtmUUbBa5DaHJ+pbJN5EGYdH8N37xnn3/0ogoqrlJ4NiQz+KrPfCnx74r2+O5UMCllrXTHHAGC
 NOs9P3bTbJ3uGmaqInhAS1Z7LJbNCfyl2YnO2C0kfBw+7xvgDjsWHETNh/6HTfSD5FpyzCh6u1b
 h5eUJqWVhHC88A9j9M4onWqEs+ZeJFDkniVE6NQtMkdzbzHUGnDZS8BnlJRZomoHk=
X-Google-Smtp-Source: AGHT+IFuJ5Jn45V+uCyQlahru51NYRyAwDWoymyJesFT7X4WHQ2A+IKxYoHGylKh4wFkSJQH9cGoPyVb9WrEgqgyjuc=
X-Received: from plbma8.prod.google.com ([2002:a17:903:948:b0:223:432c:56d4])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2349:b0:223:6744:bfb9 with SMTP id
 d9443c01a7336-22fc8e99130mr17247395ad.41.1746744316602; 
 Thu, 08 May 2025 15:45:16 -0700 (PDT)
Date: Thu,  8 May 2025 22:45:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508224514.805456-1-nabihestefan@google.com>
Subject: [PATCH 0/2] Fix for multi-process gdbstub breakpoints
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org, 
 philmd@linaro.org, Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3_DMdaAwKCiEK78FEBPQBC7KDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--nabihestefan.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This patch series modifies the gdbstub to address a bug running a
multi cluster machine in QEMU using TCG. The machine where the
problem was seen had several clusters of CPUs with similar
architectures and similar memory layout all working with physical
addresses. It was discovered under gdb debugging that a breakpoint
targeting one cluster misfired on the wrong cluster quite frequently
with no possible workaround since gdb was also unaware of any
breakpoint in that cluster and simply reported SIGTRAP.

The sequence that discovered the bug adds N inferiors and adds a
breakpoint on inferior N. Then after continuing an unrelated thread
stops the execution when its PC hits the same address of the break
targeting a different inferior.

target extended-remote :1234
add-inferior
inferior 2
attach 2
...
add-inferior
inferior N
attach N
add-symbol-file /path/to/foo.elf
break foo
> Breakpoint 1 at 0xf00add
info break
> Num     Type           Disp Enb Address    What
> 1       breakpoint     keep y   0x00f00add in foo
>                                            at foo.c:1234 inf N
continue
> Continuing.
>
> Thread 2.1 received signal SIGTRAP, Trace/breakpoint trap.
> [Switching to Thread 2.2]
> 0xf00add in ?? ()

The main problem is the current implementation of
'tcg_insert_breakpoint' and 'tcg_remove_breakpoint' insert and remove
breakpoints to all the CPUs in the system regardless of what the
remote gdb protocol implements.

If we look at the current source code of GDB we can see that the
function 'remote_target::insert_breakpoint' in file gdb/remote.c has
the intention to select the process ID of the inferior where the
break was inserted.

int
remote_target::insert_breakpoint (struct gdbarch *gdbarch,
                                  struct bp_target_info *bp_tgt)
{
...
  /* Make sure the remote is pointing at the right process, if
     necessary.  */
  if (!gdbarch_has_global_breakpoints (current_inferior ()->arch ()))
    set_general_process ();
...
}

https:sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/remote.c;h=2c3988cb5075655e8a799d1cc5d4760ad8ed426e;hb=HEAD#l11023

This would not happen when we input the 'break' in gdb but it is
deferred until the time we execute the 'continue' command. Because we
might be currently selecting an inferior that is not the one where we
previously set the breakpoint, the remote gdb has to make sure we
move the focus to the process ID of the inferior where we inserted
the break.

In the previous example this will translate to something like:

HgpN.M
Z0,00f00add,4

Another thing that is wrong with the current implementation (and it
affects both TCG and KVM mode) is that the remote gdb protocol uses
'Hg' and not 'Hc' to select the process. Functions
'gdb_breakpoint_insert' and 'gdb_breakpoint_remove' receive wrongly
'gdbserver_state.c_cpu' instead of 'gdbserver_state.g_cpu'.

This is supported by the documentation of 'H op thread-id' where op =
'c' is reserved to the step and continue:

https:sourceware.org/gdb/current/onlinedocs/gdb.html/Packets.html

And it can be verified that the function 'set_general_process' in the
previous code snippet will eventually call
'remote_target::set_general_thread' and not
'remote_target::set_continue_thread' if it needs to change focus.

A third scenario that has to be taken into account is the case of a
break on a specific thread, for instance the sequence:

inferior 1
break bar thread 1.3
break bar thread 1.4

The remote protocol expects the gdbstub to apply the break to the
process ID of inferior 1 and considers the specific thread-id as a
breakpoint condition (not too different from a 'break if').

In this case the packet exchange may look like:

Hgp1.1
Z0,00ba2add,4

There wouldn't be an independent set of packets for 'Hgp1.3' and
'Hgp1.4'.

In the gdb source code, the handling of the specific thread-id
happens during breakpoint evaluation in function
'bpstat_check_breakpoint_conditions' of file gdb/breakpoint.c

https:sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/breakpoint.c;h=17bd627f867cf3d4dc81322ed1919ba40cbb237d;hb=HEAD#l5550

The proposed fix inserts or removes a breakpoint to all the cpus
sharing the same process ID as the one selected with the latest
received 'Hg' packet.

Roque Arcudia Hernandez (2):
  gdbstub: Fix wrong CPUState pointer in breakpoint functions
  gdbstub: Apply breakpoints only to the selected PID

 accel/tcg/tcg-accel-ops.c | 37 +++++++++++++++++++++++--------------
 gdbstub/gdbstub.c         | 10 ++++++++--
 gdbstub/internals.h       | 13 +++++++++++--
 include/exec/gdbstub.h    | 12 ++++++++++++
 4 files changed, 54 insertions(+), 18 deletions(-)

-- 
2.49.0.1015.ga840276032-goog


