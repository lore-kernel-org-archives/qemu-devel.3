Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3201C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcNo-0008Gi-Qv; Fri, 07 Mar 2025 13:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqcNm-0008Et-Mc
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:25:14 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqcNk-0002MH-E3
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:25:14 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so1656321276.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741371909; x=1741976709; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+gpEaRqeugAKq7EAHSDpLMF/PS6nC1XVz3bMKspA2KU=;
 b=Wd3sju18zB89y7wnH4T+lFhVQr20GV0i4CBAXQfLQ/jyh9MCwHr9YtDSZfZ+iKQNgE
 /pT0b0kg0i2pYNmZ3cWp0g5csbzLUMLQH3FRbvCGSN1BDeuGBYf6aDJP+qCc8zrs6Dv6
 p2WkoZFbxnsIQ6CH/eJDh0o4C/0HsHII/LXrprOtGnvOzD3nSD9QkZshZjUM5dXLHY1O
 Wb2cjnaxsbJfE0v9gw9YPctIgk3wEBnC4L1gVU5UkQ2y8+9GXos5ithoFS772/c718Gb
 VqamOt6WC1IiCwITK1FAJFw39c3ZrMbBGH3hZ9u/liXiCA9cwH5K4w+DMAQD3TQgTSFj
 FjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741371909; x=1741976709;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+gpEaRqeugAKq7EAHSDpLMF/PS6nC1XVz3bMKspA2KU=;
 b=cVtj/0Bzsqm9rclNhWYQi0KOqdgiaM0dwL2onP/AOUvlhTGIpTwE/zfrwQCgwcZnGR
 /opp/CdqUKISc+DUG/AnY1T0mNN4rUY50Xqxapt4CwaMzLeelxM1tQ/IkBY17u9KXsRY
 UELT5IJi4lXOnpxz40KnBLFlSgwBr9QUCo1canroYNyEnTcaFzWZkI/GK0cpZpIecYI5
 Xq9u0AegH6LIonxOvMcsHSfTefl6yzOpeuqrJzEWxNCkb8RBEVMl6Hs+Rx1c7jTJ5k35
 G7ppeYlykZ4/7RFQMUwzXjy/ahyXFzgnbJ8AO0YgXGO3QGQH1eOMXnucoRZgBfobTI1A
 KcQg==
X-Gm-Message-State: AOJu0YwXWHQLtYXB/PL6J/Dc6rH5CiNTcFLHhyjL82mqYPXLYU6zUQ8G
 6ojSYiSFG2q9Q6Dl4V89z/gtJGyuHOeamI53xe7iqKprJkA6j3gMDZVPHbF6NzGFH7NPEz04gOG
 wx8XAN5cqy0U/+IyLchhIuS0hfiNBLai6WbBahlyJGDlPqBZl
X-Gm-Gg: ASbGncuTPUKxObmVSZ/XRBWSMbLmPb1WZM53+vQim28OZ1exdy//pvg85HeJ2kNrtYO
 C7hXNUjp12CbBL9uWOzudjsj9S069gpdZ3Bt7/wKs1CpMD/MqitkygiHpOxtq0YfHpmEWwPgfYE
 yvQJJ7WFi8yy+5U3jgJ39Ui4IXXsQ=
X-Google-Smtp-Source: AGHT+IHS2yNOgScVap31TTmmTbIVaG/pP0J7240vmiy/VIchceiPphyIygRUBE+/ut2NSnlRwMz4U7NPHIC5XZZKWcw=
X-Received: by 2002:a05:6902:288e:b0:e5d:ac3c:9dec with SMTP id
 3f1490d57ef6-e635c1da737mr5294567276.35.1741371909349; Fri, 07 Mar 2025
 10:25:09 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 18:24:57 +0000
X-Gm-Features: AQ5f1JqhFcSacCEFeFhrY5Dpryr8QC3Nxm2oS8ZsCf6dDyACjQckTQFHZKe2bHk
Message-ID: <CAFEAcA8ozGhFJWc41M6ziB3mPtEQ_bpWcQTCj1Ue_W66-MYf2w@mail.gmail.com>
Subject: make check-functional failures with --enable-rust: unsafe
 precondition(s) violated: NonNull::new_unchecked
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

I noticed that 'make check-functional' for arm targets doesn't all
pass when QEMU is built with --enable-rust:

11/46 qemu:func-thorough+func-aarch64-thorough+thorough /
func-aarch64-aarch64_virt            TIMEOUT         720.03s   killed
by signal 15 SIGTERM
 9/46 qemu:func-thorough+func-arm-thorough+thorough /
func-arm-arm_tuxrun                      ERROR            51.71s
exit status 1
30/46 qemu:func-thorough+func-arm-thorough+thorough /
func-arm-arm_vexpress                    ERROR             1.62s
exit status 1
44/46 qemu:func-thorough+func-arm-thorough+thorough /
func-arm-arm_replay                      TIMEOUT          90.02s
killed by signal 15 SIGTERM

The first of these is the virt/gpu breakage that's not Rust related.

tuxrun fails because of a Rust panic, though:

        Command:
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/rust/qemu-system-arm
-display none -vga none -chardev socket,id=mon,fd=5 -mon
chardev=mon,mode=control -machine versatilepb -chardev
socket,id=console,fd=10 -serial chardev:console -cpu arm926 -kernel
/home/petmay01/.cache/qemu/download/3931a3908dbcf0ec0fe292d035ffc4dfed95f797dedd4a59ccfcf7a46e6f92d4
-append printk.time=0 root=/dev/vda console=ttyAMA0 -blockdev
driver=raw,file.driver=file,file.filename=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/rust/tests/functional/arm/test_arm_tuxrun.TuxRunArmTest.test_armv5/scratch/60ff78b68c7021df378e4fc2d66d3b016484d1acc7e07fb8920c1d8e30f4571f,node-name=hd0
-device virtio-blk-pci,drive=hd0 -dtb
/home/petmay01/.cache/qemu/download/50988e69ef3f3b08bfb9146e8fe414129990029e8dfbed444953b7e14809530a
        Output: thread '<unnamed>' panicked at core/src/panicking.rs:221:5:
unsafe precondition(s) violated: NonNull::new_unchecked requires that
the pointer is non-null
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
thread caused non-unwinding panic. aborting.

and the vexpress and replay failures are the same panic.

Is this a known issue ? (I'm using git commit 98c7362b1efe.)

Here's the RUST_BACKTRACE=1 version:

thread '<unnamed>' panicked at core/src/panicking.rs:221:5:
unsafe precondition(s) violated: NonNull::new_unchecked requires that
the pointer is non-null
stack backtrace:
   0: rust_begin_unwind
             at
/rustc/f6e511eec7342f59a25f7c0534f1dbea00d01b14/library/std/src/panicking.rs:662:5
   1: core::panicking::panic_nounwind_fmt::runtime
             at
/rustc/f6e511eec7342f59a25f7c0534f1dbea00d01b14/library/core/src/panicking.rs:112:18
   2: core::panicking::panic_nounwind_fmt
             at
/rustc/f6e511eec7342f59a25f7c0534f1dbea00d01b14/library/core/src/panicking.rs:122:5
   3: core::panicking::panic_nounwind
             at
/rustc/f6e511eec7342f59a25f7c0534f1dbea00d01b14/library/core/src/panicking.rs:221:5
   4: core::ptr::non_null::NonNull<T>::new_unchecked::precondition_check
             at
/rustc/f6e511eec7342f59a25f7c0534f1dbea00d01b14/library/core/src/ub_checks.rs:70:21
   5: core::ptr::non_null::NonNull<T>::new_unchecked
             at
/rustc/f6e511eec7342f59a25f7c0534f1dbea00d01b14/library/core/src/ub_checks.rs:77:17
   6: qemu_api::qom::Owned<T>::from
             at ./rust/qemu-api/libqemu_api.rlib.p/structured/qom.rs:741:19
   7: pl011_create
             at ./../../rust/hw/char/pl011/src/device.rs:716:24
   8: vexpress_common_init
             at ./../../hw/arm/vexpress.c:647:5
   9: machine_run_board_init
             at ./../../hw/core/machine.c:1682:5
  10: qemu_init_board
             at ./../../system/vl.c:2711:5
  11: qmp_x_exit_preconfig
             at ./../../system/vl.c:2807:5
  12: qemu_init
             at ./../../system/vl.c:3843:9
  13: main
             at ./../../system/main.c:68:5
  14: __libc_start_call_main
             at ./csu/../sysdeps/nptl/libc_start_call_main.h:58:16
  15: __libc_start_main_impl
             at ./csu/../csu/libc-start.c:360:3
  16: _start

(side note: should we set RUST_BACKTRACE=1 for our
make check/check-functional infra? it would probably be better
to capture the backtrace in the logfiles rather than needing
the user to re-run by hand, especially for the CI case.)

thanks
-- PMM

