Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFF5D37499
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SZZ-00017D-0G; Thu, 17 Oct 2024 11:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Ty8RZwYKCjIfceiSVUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--roqueh.bounces.google.com>)
 id 1t1SZY-00016q-2i
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:37:56 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Ty8RZwYKCjIfceiSVUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--roqueh.bounces.google.com>)
 id 1t1SZW-0003zw-E8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:37:55 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6e3705b2883so22171877b3.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1729179471; x=1729784271; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ehdp2Jc10Ed986kjvJKnnSj6NpKv0OtHdeeoEpYkPPs=;
 b=v1+GOu6ypAHdtxvZ4EFbhDGiR7kpo/AhNCIhIAMdB94qWhTNEbg1aVC3aUU2pd/fZs
 /ekrGGSJ1NRJz6kfp+N/4e5KDjtyGoXx2+YcU7IJvfpFHo/NcBETHKItXtxsh4iPdwuO
 MyGYD4KkjdbLiM9Vi1Ao3vB5lfykD4nfrb6QSzPWbrQOfxTOw2v8D0RUGWR9gtqoimsw
 cP7DnZPmLmrAZuVKyyAyYz+lvep4mHzG0LJTe3Cserihvn2BCOfPCSuvZnsNunKyZgQR
 t3qf1PU416ppZ5qvhJ3TenyYvXsZcuSpNFHB105alVD2lpF4dzY9ccrME9nRdsg8LP69
 F1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729179471; x=1729784271;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ehdp2Jc10Ed986kjvJKnnSj6NpKv0OtHdeeoEpYkPPs=;
 b=LS9rURkO0vFVc6b3kjPDil2071jhYzM+poqBZqSHQBXv6RTDP5LZ8HS8Qwnhd8SzDY
 OJs0kvzrqtXisaWSH/nLohVh2zOsGXbSVkrjt8FIG2Gyy9Uaqqs1bf72LdKOS0hWCMT0
 hQAvj4iUO1kcCptknIRtE2v7/PoUbhnljHkT1tk6awLfOqvA5LfhLvcbdPj34/XQs8n1
 nZewcY93urpZDByp2/48MAhz/trhMokQh1CAIoq9qUTKCxuSPaw02B/zDMTUiaXtCFBQ
 xnAisLJHNSzEMSioC+zArRnXXHHRdCjLSsshN/4Y3ivks9KK0NNoITCC8ZgCrn5pqQ2Y
 6RMg==
X-Gm-Message-State: AOJu0YzRAWP2RBaNrbRCwpgzsIRiF0/MvIHZXPir7NwZ7Z3rorXBAt96
 nH5DJ9u1WudW4fQRjVOAmRyTvKCMCeYFPmV07wYb/WawfbPu8aRRh02PgqefIH4i56gv69IRuj3
 QcA==
X-Google-Smtp-Source: AGHT+IGJH640c2igNcZnm9c9q82XHuTlLyQFti5sMb3unEMYkFns7WtJ88wHPWMOfEHM33QqgKU5JaNqxAE=
X-Received: from roqueh-desktop.svl.corp.google.com
 ([2a00:79e0:2e5b:9:1adf:42eb:8cf9:56e9])
 (user=roqueh job=sendgmr) by 2002:a05:690c:6e0a:b0:6e3:345e:5f89 with SMTP id
 00721157ae682-6e3d3bdc32bmr1692147b3.0.1729179471136; Thu, 17 Oct 2024
 08:37:51 -0700 (PDT)
Date: Thu, 17 Oct 2024 08:37:43 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017153745.509978-1-roqueh@google.com>
Subject: [PATCH v2 0/2] Fix for multi-process gdbstub breakpoints
From: Roque Arcudia Hernandez <roqueh@google.com>
To: richard.henderson@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org, 
 philmd@linaro.org, slongfield@google.com, komlodi@google.com
Cc: qemu-devel@nongnu.org, Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3Ty8RZwYKCjIfceiSVUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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
  gdbstub: Apply breakpoints only to the relevant CPUs

 accel/tcg/tcg-accel-ops.c | 37 +++++++++++++++++++++++--------------
 gdbstub/gdbstub.c         | 10 ++++++++--
 gdbstub/internals.h       | 13 +++++++++++--
 include/exec/gdbstub.h    | 12 ++++++++++++
 4 files changed, 54 insertions(+), 18 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


