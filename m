Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485E2C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 20:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuz2W-000307-3G; Wed, 19 Mar 2025 15:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuz2S-0002yB-To
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:25:17 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuz2Q-0002pj-AM
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:25:16 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so5805070276.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742412313; x=1743017113; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r8Hlo3CmmHLMyn/BaPz47LNT2GKXhvSKNr1gsTzk/lU=;
 b=xps0E4n4woAWfPxPRnG2/rDuxemd1VYxFtQigoKLDM0CAy0rs1P9uhEQ7TUuYeVIFu
 6zSskD1wAw6ip01BHAJGVK3SLcROIGP9ecwqCet7q/ql+qsIkcUJmNRZ6/rMuTgpDlU1
 GN7Hahnqfqeb7jZtQcXh1fyTLD7UHoPUD1/LIdJ1X6Yt5qpgpdl0joN5sTmUrAUM/K8m
 emVT0lWap50WhE6hEXYktqNm7iinwQRdsD37kOk0ukWCTPAZSc4PG20ZHv/wYxkXa6hG
 41J0LkV1kpydKjhU8OtjUmcNunlYisbiFEZ4TMFlZpz8zU61swMD1fupX7h/WpUbWg7R
 ez9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742412313; x=1743017113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r8Hlo3CmmHLMyn/BaPz47LNT2GKXhvSKNr1gsTzk/lU=;
 b=DbyPGr5TvZcsAXxQHyUH6tIeTmHMbF2HeawgIx/u4uQfqy82CbO/hOA3cPotnMWPnp
 5Om/UHUEJQSrMKf2XNBSYZ4W/cgpiduWGUy++tNsUV/SpeDo5t6QpVZzWceoBQnZ0vxf
 Ntm5Vdhx6xe/SE/U+9inzRBtzfv8rwAMOePwyB/gwnwIlw4yMx5dK/UPFQJqN0gnn3KE
 osWCW0+7CU96mZggBYLI+erg2hRKbTiPqAZVYFJbqzzYHg+JwJKQxSPPsFRsOVVu+Mm/
 OnSSn9RNpJ8o8lVJOsbwMvrM7oONODpIYxyIRsnGmA2CNn2X1+jHTQBFFAYqbNlbSKcW
 o+sA==
X-Gm-Message-State: AOJu0YxETcqbKw8xRbYlihpGuIn+6mR9bF4FzFmus2cvQ+eZ4/iZUQ3b
 RKhbtRCmpVc+0SKOMgKAe7DBfSXAnjUetafLgtM6zjzHZ6M4LjMm9mjVw14BMmHkn/TQ6EdPzUk
 q6vc0ixMnq7JB3mKbInfyKp7+b9GR+zVSoQLDlw==
X-Gm-Gg: ASbGncvKqNavLrsMJNe6Zpw8l+jBUjasyiwx2oxVzUjLp92MqR0orzG4x7J04iikgqV
 2ncTS0uutrqSO7qITjGiNjJzWvqzzZbIjNBZw2xMoR+ksq6AdxBCnoWnyO0+XcfyiQBQfkk1Pdu
 dF21wfo8LBsu1YhStzgqYQJ/EFthc=
X-Google-Smtp-Source: AGHT+IEhHpwUYvPrnb7q1BlCo0wFO1Xn5lGuhYhySkJF/NyIHB86Wkfeiw9UGndw84Y21cE0SN5HCifvrzq0i4xuBJQ=
X-Received: by 2002:a05:6902:2304:b0:e63:f191:e8a7 with SMTP id
 3f1490d57ef6-e667b440c6bmr5114858276.31.1742412312707; Wed, 19 Mar 2025
 12:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250309103120.1116448-1-pbonzini@redhat.com>
 <20250309103120.1116448-20-pbonzini@redhat.com>
In-Reply-To: <20250309103120.1116448-20-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Mar 2025 19:25:00 +0000
X-Gm-Features: AQ5f1JrXXAIDXSH0DyCw3CRtfuCsqzynJe1Cs7s1QYbOHWnnFwp5dqzRgnxMzVw
Message-ID: <CAFEAcA_orQ2Na9+MWnbyScNjQsDQBKB=s3c8D86FUE=q_1Mkaw@mail.gmail.com>
Subject: Re: [PULL 19/25] rust: pl011: switch to safe chardev operation
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, 9 Mar 2025 at 10:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Switch bindings::CharBackend with chardev::CharBackend.  This removes
> occurrences of "unsafe" due to FFI and switches the wrappers for receive,
> can_receive and event callbacks to the common ones implemented by
> chardev::CharBackend.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi -- this commit seems to have broken use of the PL011 in
boards/SoCs that directly embed it in their state structs, so
"qemu-system-arm -M raspi2b -display none" now asserts on startup.

The Rust PL011's state struct size is now larger than the
C state struct size, so it trips the assert in the QOM code
that we didn't try to initialize a type into less memory than
it needs. (I don't understand *why* the type size has changed,
because this commit doesn't at first glance seem to be adding
anything to the state struct...but it definitely goes up from
0x540 to 0x550.)

(It would be good if we had a compile time check that the state
struct sizes matched between Rust and C, rather than having it
only be caught in runtime asserts. This does cause failures in
check-functional, at least, so it's not completely untested.)

Here's the repro and gdb backtrace:

$ gdb --args ./build/rust/qemu-system-arm -M raspi2b -display none
[...]
**
ERROR:../../qom/object.c:562:object_initialize_with_type: assertion
failed: (size >= type->instance_size)
Bail out! ERROR:../../qom/object.c:562:object_initialize_with_type:
assertion failed: (size >= type->instance_size)

Thread 1 "qemu-system-arm" received signal SIGABRT, Aborted.
Download failed: Invalid argument.  Continuing without source file
./nptl/./nptl/pthread_kill.c.
__pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimised
out>) at ./nptl/pthread_kill.c:44
warning: 44     ./nptl/pthread_kill.c: No such file or directory
(gdb) bt
#0  __pthread_kill_implementation (no_tid=0, signo=6,
threadid=<optimised out>) at ./nptl/pthread_kill.c:44
#1  __pthread_kill_internal (signo=6, threadid=<optimised out>) at
./nptl/pthread_kill.c:78
#2  __GI___pthread_kill (threadid=<optimised out>,
signo=signo@entry=6) at ./nptl/pthread_kill.c:89
#3  0x00007ffff4a4527e in __GI_raise (sig=sig@entry=6) at
../sysdeps/posix/raise.c:26
#4  0x00007ffff4a288ff in __GI_abort () at ./stdlib/abort.c:79
#5  0x00007ffff6e58f5b in g_assertion_message
    (domain=domain@entry=0x0, file=file@entry=0x55555678fdeb
"../../qom/object.c", line=line@entry=562,
func=func@entry=0x5555567906d0 <__func__.33>
"object_initialize_with_type", message=message@entry=0x555557f7f400
"assertion failed: (size >= type->instance_size)") at
../../../glib/gtestutils.c:3331
#6  0x00007ffff6ec1a97 in g_assertion_message_expr
    (domain=0x0, file=0x55555678fdeb "../../qom/object.c", line=562,
func=0x5555567906d0 <__func__.33> "object_initialize_with_type",
expr=<optimised out>) at ../../../glib/gtestutils.c:3357
#7  0x0000555556188bc6 in object_initialize_with_type
(obj=0x555557d4e190, size=1344, type=0x555557a0bd40) at
../../qom/object.c:562
#8  0x0000555556188cb5 in object_initialize (data=0x555557d4e190,
size=1344, typename=0x5555566d9142 "pl011")
    at ../../qom/object.c:578
#9  0x0000555556188e3d in object_initialize_child_with_propsv
    (parentobj=0x555557d45710, propname=0x5555566d9148 "uart0",
childobj=0x555557d4e190, size=1344, type=0x5555566d9142 "pl011",
errp=0x5555578636f8 <error_abort>, vargs=0x7fffffffd360) at
../../qom/object.c:608
#10 0x0000555556188db6 in object_initialize_child_with_props
    (parentobj=0x555557d45710, propname=0x5555566d9148 "uart0",
childobj=0x555557d4e190, size=1344, type=0x5555566d9142 "pl011",
errp=0x5555578636f8 <error_abort>) at ../../qom/object.c:591
#11 0x0000555556188f3b in object_initialize_child_internal
    (parent=0x555557d45710, propname=0x5555566d9148 "uart0",
child=0x555557d4e190, size=1344, type=0x5555566d9142 "pl011")
    at ../../qom/object.c:645
#12 0x0000555555d446ea in raspi_peripherals_base_init
(obj=0x555557d45710) at ../../hw/arm/bcm2835_peripherals.c:100
#13 0x0000555556188639 in object_init_with_type (obj=0x555557d45710,
ti=0x5555579d4af0) at ../../qom/object.c:428
#14 0x000055555618861b in object_init_with_type (obj=0x555557d45710,
ti=0x5555579d4950) at ../../qom/object.c:424
#15 0x0000555556188c49 in object_initialize_with_type
(obj=0x555557d45710, size=597040, type=0x5555579d4950)
    at ../../qom/object.c:570
#16 0x0000555556188cb5 in object_initialize (data=0x555557d45710,
size=597040, typename=0x555556738ca5 "bcm2835-peripherals")
    at ../../qom/object.c:578
#17 0x0000555556188e3d in object_initialize_child_with_propsv
    (parentobj=0x555557d34760, propname=0x555556738cb9 "peripherals",
childobj=0x555557d45710, size=597040, type=0x555556738ca5
"bcm2835-peripherals", errp=0x5555578636f8 <error_abort>,
vargs=0x7fffffffd630) at ../../qom/object.c:608
#18 0x0000555556188db6 in object_initialize_child_with_props
    (parentobj=0x555557d34760, propname=0x555556738cb9 "peripherals",
childobj=0x555557d45710, size=597040, type=0x555556738ca5
"bcm2835-peripherals", errp=0x5555578636f8 <error_abort>) at
../../qom/object.c:591
#19 0x0000555556188f3b in object_initialize_child_internal
    (parent=0x555557d34760, propname=0x555556738cb9 "peripherals",
child=0x555557d45710, size=597040, type=0x555556738ca5
"bcm2835-peripherals") at ../../qom/object.c:645
#20 0x0000555555f07080 in bcm283x_init (obj=0x555557d34760) at
../../hw/arm/bcm2836.c:49
#21 0x0000555556188639 in object_init_with_type (obj=0x555557d34760,
ti=0x5555579af8a0) at ../../qom/object.c:428
#22 0x000055555618861b in object_init_with_type (obj=0x555557d34760,
ti=0x5555579af6e0) at ../../qom/object.c:424
#23 0x0000555556188c49 in object_initialize_with_type
(obj=0x555557d34760, size=666592, type=0x5555579af6e0)
    at ../../qom/object.c:570
#24 0x0000555556188cb5 in object_initialize (data=0x555557d34760,
size=666592, typename=0x555556739030 "bcm2836")
    at ../../qom/object.c:578
#25 0x0000555556188e3d in object_initialize_child_with_propsv
    (parentobj=0x555557d34500, propname=0x55555673917b "soc",
childobj=0x555557d34760, size=666592, type=0x555556739030 "bcm2836",
errp=0x5555578636f8 <error_abort>, vargs=0x7fffffffd8f0) at
../../qom/object.c:608
#26 0x0000555556188db6 in object_initialize_child_with_props
    (parentobj=0x555557d34500, propname=0x55555673917b "soc",
childobj=0x555557d34760, size=666592, type=0x555556739030 "bcm2836",
errp=0x5555578636f8 <error_abort>) at ../../qom/object.c:591
#27 0x0000555556188f3b in object_initialize_child_internal
    (parent=0x555557d34500, propname=0x55555673917b "soc",
child=0x555557d34760, size=666592, type=0x555556739030 "bcm2836")
    at ../../qom/object.c:645
#28 0x0000555555f0859b in raspi_machine_init (machine=0x555557d34500)
at ../../hw/arm/raspi.c:313
#29 0x00005555559d4674 in machine_run_board_init
(machine=0x555557d34500, mem_path=0x0, errp=0x7fffffffda90)
    at ../../hw/core/machine.c:1680
#30 0x0000555555d8615b in qemu_init_board () at ../../system/vl.c:2709
#31 0x0000555555d8650c in qmp_x_exit_preconfig (errp=0x555557863700
<error_fatal>) at ../../system/vl.c:2805
#32 0x0000555555d891bf in qemu_init (argc=5, argv=0x7fffffffde48) at
../../system/vl.c:3838
#33 0x000055555634c832 in main (argc=5, argv=0x7fffffffde48) at
../../system/main.c:68
(gdb) frame 7
#7  0x0000555556188bc6 in object_initialize_with_type
(obj=0x555557d4e190, size=1344, type=0x555557a0bd40) at
../../qom/object.c:562
562         g_assert(size >= type->instance_size);
(gdb) print *type
$2 = {name = 0x555557a0bec0 "pl011", class_size = 208, instance_size =
1360, instance_align = 16,
  class_init = 0x55555634ede0
<qemu_api::qom::rust_class_init<pl011::device::PL011State>>,
class_base_init = 0x0, class_data = 0x0,
  instance_init = 0x55555634f0f0
<qemu_api::qom::rust_instance_init<pl011::device::PL011State>>,
  instance_post_init = 0x55555634f1e0
<qemu_api::qom::rust_instance_post_init<pl011::device::PL011State>>,
  instance_finalize = 0x55555634eb40
<qemu_api::qom::drop_object<pl011::device::PL011State>>, abstract =
false,
  parent = 0x555557a0bee0 "sys-bus-device", parent_type =
0x55555798c650, class = 0x555557a72370, num_interfaces = 0, interfaces
= {
    {typename = 0x0} <repeats 32 times>}}
(gdb) print /x type->instance_size
$3 = 0x550
(gdb) print /x size
$4 = 0x540

thanks
-- PMM

