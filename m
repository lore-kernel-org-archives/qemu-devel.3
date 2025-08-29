Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C8FCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNF0-0005E0-LO; Sat, 30 Aug 2025 11:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urx0r-0001U0-2J
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 07:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urx0o-0002U6-D9
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 07:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756465876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v4Pgwn/s1Wopgq9AjceDCQ17GgVUfzkRnb7tRsEkHfo=;
 b=YMpuBbgo3/Nwgqt9KKER/yETUd8nELG4ijNA90j6+1PZmO2y6OHPr82U17o9vNuUFkmnsP
 AabFV/Su0mN058aYD8JOCpDyA6FJq4ab1qa2zAK9NKzZCsT+SmMQeeINvGHakh3P3tuWat
 pzv45M+bTrTcTq45gbdnEqPgQ8Oe6LY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-YHsA40TLO1mxPbv_oNkjGA-1; Fri, 29 Aug 2025 07:11:14 -0400
X-MC-Unique: YHsA40TLO1mxPbv_oNkjGA-1
X-Mimecast-MFC-AGG-ID: YHsA40TLO1mxPbv_oNkjGA_1756465873
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b7f0d1449so3798675e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 04:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756465873; x=1757070673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v4Pgwn/s1Wopgq9AjceDCQ17GgVUfzkRnb7tRsEkHfo=;
 b=ZveYAGw70iNlsy8gbllf1OFg8OxzBBMEVDVIu40CcmBhYTmmMKw8cw41InvozZZPMA
 iExk8yXqM7jgr13tbq7PY0utMJ8iaaaMbA8hI0eD09xF7qMyvKmPKXmm7xuc6Ofhx2I7
 rdI8MWyLoBpBMu7uD88wfOeLSXi2H6rqI5nq52S2v00Xk3xJWQeV6I4ubCKQcOL40TPP
 voNkIhVehllP+P9NbUKnBMiHmuQjg5K9TFfI3HEXMN8Yo3ZUcgk8uOhwMCUXg/eT7vJg
 OSa0hmYXBw9u77Oasl9rr8ORbvizy6uTHTrrtZNmnSA8tHI4LP2TyYveWOgZdK29gFuW
 rx2w==
X-Gm-Message-State: AOJu0YyiMRq8H7QGjfpBhGtqdzlo0bDemvEF83EcQ8mqOvdV4oZ3oi0x
 gu2S+OIIC6McOSKDjaUV3cZWpDTcWo5LUF+alHZpaOsVFPpFziMkeiUYzjO7fe8I8yKR7ChqKtf
 z9YHpPH9lwiswEpuQNgILGrw/oXgclf4kW5oe0t60IVi1exC8Avbf4CqqwjLgjgxSqMhMBf0d7Q
 F8HWjoz7oF5nPrXfDf4MpFMq7iD3Mq1InKXsbf6Fgo
X-Gm-Gg: ASbGnctdqxgNqJombaftWBHStZ5zFsvYrewpOd/fVVR1SsagjxGRqpgSpuCkYcXLAt5
 EnijDNo3R/xUNtK1SW5IwOa2F9enAKdeSh0EgjM03HDrowTLPmurzAWx0s8K4UWqKFinErnybBs
 ps0uanB1lVZI8fhr/QFkb+qjp5o7dq6OqGZHmx4YpRHckTIQDKt5JFu1Xy+zMXcn7y1GhtTL0DQ
 8cU6GF/lPQFr/ae+q08By/y0qcmgYlgPkE88OC3MyHyN9jC5wnWvhwlPsSONwlUGhmH+wFrt/9Y
 JsLNm5pKy5oAKPI9CDAl7hIvgTmzfGM7sFx0B1FC9sxASrwTHxhOafzW8v7FXEkqWw4W+W1JuMY
 oQOYMCqtQqUsCGy7tAMwczjYFERaCAsKoG86lrr7lP7o=
X-Received: by 2002:a05:600c:4715:b0:458:f70d:ebd7 with SMTP id
 5b1f17b1804b1-45b517c2f25mr216234985e9.20.1756465872852; 
 Fri, 29 Aug 2025 04:11:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKQqMpYP+cgR/RbTwR6J5vzqOgwmNAeY/7JPkmBen7X5OE9qClG8CXzih3R8frPOen8zMAeA==
X-Received: by 2002:a05:600c:4715:b0:458:f70d:ebd7 with SMTP id
 5b1f17b1804b1-45b517c2f25mr216234775e9.20.1756465872396; 
 Fri, 29 Aug 2025 04:11:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e88785bsm33839645e9.14.2025.08.29.04.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 04:11:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH] user-exec: abort if interrupt_request is used
Date: Fri, 29 Aug 2025 13:11:10 +0200
Message-ID: <20250829111110.1490546-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

cpu_interrupt() is only called by a few user-mode emulation targets:
i386, ppc, sparc, arm.  For all of them it is dead code:

- i386 uses it for the A20 line

- ppc uses it in cpu_interrupt_exittb(), whose uses (but not the definition)
  are guarded by CONFIG_USER_ONLY

- likewise for sparc's cpu_check_irqs()

Arm has various uses in arm_cpu_update_v* and omap_wfi_write, but they are
also dead; disentangling the various cpregs accessors from user-mode
emulation is a work in progress.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        A quick and dirty patch that I'd like to place before Igor's
        https://patchew.org/QEMU/20250814160600.2327672-1-imammedo@redhat.com/,
        to document that interrupt_request is dead for user-mode emulation.

        v2 of https://patchew.org/QEMU/20250808185905.62776-1-pbonzini@redhat.com/
        will also remove callers of cpu_interrupt() treewide.

 include/hw/core/cpu.h | 1 +
 accel/tcg/cpu-exec.c  | 6 ++++--
 accel/tcg/user-exec.c | 4 +---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5eaf41a566f..f73b4357c7b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -423,6 +423,7 @@ struct qemu_work_item;
  * @created: Indicates whether the CPU thread has been successfully created.
  * @halt_cond: condition variable sleeping threads can wait on.
  * @interrupt_request: Indicates a pending interrupt request.
+ *   Only used by system emulation.
  * @halted: Nonzero if the CPU is in suspended state.
  * @stop: Indicates a pending stop request.
  * @stopped: Indicates the CPU has been artificially stopped.
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 713bdb20564..b44dd1e8205 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -778,6 +778,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      */
     qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
 
+#ifdef CONFIG_USER_ONLY
+    g_assert(!qatomic_read(&cpu->interrupt_request));
+#else
     if (unlikely(qatomic_read(&cpu->interrupt_request))) {
         int interrupt_request;
         bql_lock();
@@ -792,7 +795,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             bql_unlock();
             return true;
         }
-#if !defined(CONFIG_USER_ONLY)
         if (replay_mode == REPLAY_MODE_PLAY && !replay_has_interrupt()) {
             /* Do nothing */
         } else if (interrupt_request & CPU_INTERRUPT_HALT) {
@@ -840,7 +842,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
              * reload the 'interrupt_request' value */
             interrupt_request = cpu->interrupt_request;
         }
-#endif /* !CONFIG_USER_ONLY */
         if (interrupt_request & CPU_INTERRUPT_EXITTB) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;
             /* ensure that no TB jump will be modified as
@@ -851,6 +852,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         /* If we exit via cpu_loop_exit/longjmp it is reset in cpu_exec */
         bql_unlock();
     }
+#endif /* !CONFIG_USER_ONLY */
 
     /* Finally, check if we need to exit to the main loop.  */
     if (unlikely(qatomic_read(&cpu->exit_request)) || icount_exit_request(cpu)) {
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f25d80e2dc2..748bfab04a7 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -48,9 +48,7 @@ __thread uintptr_t helper_retaddr;
 
 void cpu_interrupt(CPUState *cpu, int mask)
 {
-    g_assert(bql_locked());
-    cpu->interrupt_request |= mask;
-    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+    g_assert_not_reached();
 }
 
 /*
-- 
2.51.0


