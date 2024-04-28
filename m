Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC9EC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CvJ-00054u-4E; Sun, 28 Apr 2024 18:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CvF-00054e-T5
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:23:02 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CvD-0006jk-J5
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:23:01 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a559b919303so505870366b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342977; x=1714947777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n8uuBUO7GENk2RPDInuaO+tkHKxpqAadVpWl7VuOv6U=;
 b=kUewJPh0SKFqSwExEzEHjySecojRV9yPrJm9YOVuNlZ6E7afBtFt/W6j3ZRsbPtebg
 t2ERynVgvh+4qoQQyMCFgkg4nUi9oXcz45G5KdKXiifm2muSeXmM2AYVTdq0fKnqM6tQ
 +JRCCkkXXWDX9YfvgNfIU0zjSJO0EKbSXCGqjEDEsYynPM26aDisw0wXxxdBvAKg6QuH
 t9ViOq6DH9WxekH+GFHV52BNHuDGoDoHGPF+w1y3H0MGBQPivzru9gvyFYnR2yrEsXP2
 ynUtUPfsqO7eeNJ5riHW6e/02Ot4vW9rDCXs/LNwfJUfaTAZiT7XR8oVimRKzJaUD5iC
 499Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342977; x=1714947777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n8uuBUO7GENk2RPDInuaO+tkHKxpqAadVpWl7VuOv6U=;
 b=M/69v9nd71Q+yI6bL7OIIFZbCer+epL6rmQE92YqdmIzRtv+BzO2oJQN1FUQoD3mgg
 CUn/OWpI6vnVH4NyaIISGXqxdR4pWh/Gb7TIVNtFbCxrsgsvRUkczIaRXk65RBC0fb0c
 nR45huPSxrbIgNQ8grhIaaJRSfj+UpLNyh6Lpg8EKrWTcj1Lep7FPqY6cCMtkMgx3XNY
 u8urj9Zu8bUHZqNAlmfTDVjfjLuMPbI2FCWj+m3gsu2KtohYhNDp0BjmwIokzhHsMCb3
 gAqyOxUH6SoamNdypY6/018POFqc4P8UOFZZjj2H+f3BaeKKxhebekVMkuKxk9s6k6CW
 Tk6w==
X-Gm-Message-State: AOJu0YyC4BQ2xDIQGHZlXJkicxQ2VWnXcKCSxunNg3dqC1/RBn/gh7Gj
 HhDTX15e4EgYQgfX0vsrPxj9NDF3ajGXRQ+sPraEtbBI5eOmTz62DRnZdoLxGaJrjK7ANjxr8kg
 X
X-Google-Smtp-Source: AGHT+IElKLeFrpgWWGrz7t9bTQbvkuqGM81yeMbQvNkVJiobsYuUnzkDZobRWpDJNfUw3KRaBYmc8g==
X-Received: by 2002:a17:906:3896:b0:a55:b7e3:8bf7 with SMTP id
 q22-20020a170906389600b00a55b7e38bf7mr5917647ejd.18.1714342976844; 
 Sun, 28 Apr 2024 15:22:56 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 d17-20020a1709063ed100b00a52222f2b21sm13196066ejj.66.2024.04.28.15.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 15:22:56 -0700 (PDT)
Message-ID: <c601427f-49e0-4545-8d5e-314271e39c27@linaro.org>
Date: Mon, 29 Apr 2024 00:22:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] exec: Rework around CPUState user fields (part 2)
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 29/4/24 00:14, Philippe Mathieu-Daudé wrote:
> Finish extracting TCG fields from CPUState:
> - Extract tcg_cpu_exit() from cpu_exit()
> - Introduce AccelOpsClass::exit_vcpu_thread()
> - cpu_exit() calls exit_vcpu_thread=tcg_cpu_exit for TCG
> - Forward declare TaskState and more uses of get_task_state()
> - Introduce TCG AccelCPUState
> - Move TCG specific fields from CPUState to AccelCPUState
> - Restrict "exec/tlb-common.h" to TCG
> - Restrict iommu_notifiers, icount to system emulation
> 
> Based-on: <20240428214915.10339-1-philmd@linaro.org>

The CPUState changes (part 1 & 2) can be resumed as:

$ git diff master.. -- include/hw/core/cpu.h accel/tcg/vcpu-state.h
-- >8 --
diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
new file mode 100644
index 0000000000..9bb8afac57
--- /dev/null
+++ b/accel/tcg/vcpu-state.h
@@ -0,0 +1,45 @@
+/**
+ * AccelCPUState:
+ * @cflags: Pre-computed cflags for this cpu.
+ * @icount_extra: Instructions until next timer event.
+ * @mem_io_pc: Host Program Counter at which the memory was accessed.
+ */
+struct AccelCPUState {
+    uint32_t cflags;
+    uint32_t cflags_next_tb;
+
+    sigjmp_buf jmp_env;
+    CPUJumpCache tb_jmp_cache;
+
+#ifdef CONFIG_USER_ONLY
+    TaskState *ts;
+#else
+    int64_t icount_budget;
+    int64_t icount_extra;
+
+    uintptr_t mem_io_pc;
+
+    /* track IOMMUs whose translations we've cached in the TCG TLB */
+    GArray *iommu_notifiers;
+#endif
+};
+#endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 46b99a7ea5..bdcb09b464 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -337,15 +337,28 @@ typedef union IcountDecr {
-/*
- * Elements of CPUState most efficiently accessed from CPUArchState,
- * via small negative offsets.
+/**
+ * CPUNegativeOffsetState: Elements of CPUState most efficiently accessed
+ *                         from CPUArchState, via small negative offsets.
+ * @can_do_io: True if memory-mapped IO is allowed.
+ * @plugin_mem_cbs: active plugin memory callbacks
+ * @plugin_state: per-CPU plugin state
   */
  typedef struct CPUNegativeOffsetState {
+#ifdef CONFIG_TCG
      CPUTLB tlb;
+#ifdef CONFIG_PLUGIN
+    /*
+     * The callback pointer are accessed via TCG (see 
gen_empty_mem_helper).
+     */
+    GArray *plugin_mem_cbs;
+    CPUPluginState *plugin_state;
+#endif
      IcountDecr icount_decr;
      bool can_do_io;
+#endif
  } CPUNegativeOffsetState;

  struct KVMState;
@@ -383,9 +396,8 @@ struct qemu_work_item;
   *   to a cluster this will be UNASSIGNED_CLUSTER_INDEX; otherwise it will
   *   be the same as the cluster-id property of the CPU object's 
TYPE_CPU_CLUSTER
   *   QOM parent.
- *   Under TCG this value is propagated to @tcg_cflags.
+ *   Under TCG this value is propagated to @accel->cflags.
   *   See TranslationBlock::TCG CF_CLUSTER_MASK.
- * @tcg_cflags: Pre-computed cflags for this cpu.
   * @nr_cores: Number of cores within this CPU package.
   * @nr_threads: Number of threads within this CPU core.
   * @running: #true if CPU is currently running (lockless).
@@ -399,8 +411,6 @@ struct qemu_work_item;
   * @unplug: Indicates a pending CPU unplug request.
   * @crash_occurred: Indicates the OS reported a crash (panic) for this CPU
   * @singlestep_enabled: Flags for single-stepping.
- * @icount_extra: Instructions until next timer event.
- * @neg.can_do_io: True if memory-mapped IO is allowed.
   * @cpu_ases: Pointer to array of CPUAddressSpaces (which define the
   *            AddressSpaces this CPU has)
   * @num_ases: number of CPUAddressSpaces in @cpu_ases
@@ -411,13 +421,10 @@ struct qemu_work_item;
   * @gdb_num_g_regs: Number of registers in GDB 'g' packets.
   * @node: QTAILQ of CPUs sharing TB cache.
   * @opaque: User data.
- * @mem_io_pc: Host Program Counter at which the memory was accessed.
   * @accel: Pointer to accelerator specific state.
   * @kvm_fd: vCPU file descriptor for KVM.
   * @work_mutex: Lock to prevent multiple access to @work_list.
   * @work_list: List of pending asynchronous work.
- * @plugin_mem_cbs: active plugin memory callbacks
- * @plugin_state: per-CPU plugin state
   * @ignore_memory_transaction_failures: Cached copy of the MachineState
   *    flag of the same name: allows the board to suppress calling of the
   *    CPU do_transaction_failed hook function.
@@ -460,14 +467,10 @@ struct CPUState {
      bool crash_occurred;
      bool exit_request;
      int exclusive_context_count;
-    uint32_t cflags_next_tb;
      /* updates protected by BQL */
      uint32_t interrupt_request;
      int singlestep_enabled;
-    int64_t icount_budget;
-    int64_t icount_extra;
      uint64_t random_seed;
-    sigjmp_buf jmp_env;

      QemuMutex work_mutex;
      QSIMPLEQ_HEAD(, qemu_work_item) work_list;
@@ -477,8 +480,6 @@ struct CPUState {
      AddressSpace *as;
      MemoryRegion *memory;

-    CPUJumpCache *tb_jmp_cache;
-
      GArray *gdb_regs;
      int gdb_num_regs;
      int gdb_num_g_regs;
@@ -490,12 +491,9 @@ struct CPUState {
      QTAILQ_HEAD(, CPUWatchpoint) watchpoints;
      CPUWatchpoint *watchpoint_hit;

-    void *opaque;
-
      /* In order to avoid passing too many arguments to the MMIO helpers,
       * we store some rarely used information in the CPU context.
       */
-    uintptr_t mem_io_pc;

      /* Only used in KVM */
      int kvm_fd;
@@ -510,19 +508,9 @@ struct CPUState {
      /* Use by accel-block: CPU is executing an ioctl() */
      QemuLockCnt in_ioctl_lock;

-#ifdef CONFIG_PLUGIN
-    /*
-     * The callback pointer stays in the main CPUState as it is
-     * accessed via TCG (see gen_empty_mem_helper).
-     */
-    GArray *plugin_mem_cbs;
-    CPUPluginState *plugin_state;
-#endif
-
      /* TODO Move common fields from CPUArchState here. */
      int cpu_index;
      int cluster_index;
-    uint32_t tcg_cflags;
      uint32_t halted;
      int32_t exception_index;

@@ -544,9 +532,6 @@ struct CPUState {
      /* Used for user-only emulation of prctl(PR_SET_UNALIGN). */
      bool prctl_unalign_sigbus;

-    /* track IOMMUs whose translations we've cached in the TCG TLB */
-    GArray *iommu_notifiers;
-
      /*
       * MUST BE LAST in order to minimize the displacement to CPUArchState.
       */
---

