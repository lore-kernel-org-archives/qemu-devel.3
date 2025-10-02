Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3761BCCD182
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvu-0001H4-M0; Thu, 02 Oct 2025 13:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvT-000116-0d
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvF-0005rh-I6
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uB+V3u/aPrqwLddsF879FaTd8eb+vL09HILtMavahqo=;
 b=DNVyALBR8Myijppod88DUixh/GxOCssCWTODfaJV+8voH3jWUFlKh3T1qDI69pdkmE0P7Z
 xU1gPc08Z293P8H1lxXoY6do7o2eebtDSpfPXvVArrmb0lKUTuSlSaC8ao/mL7lDm1/IwL
 GqiSTxIPjq1UO01bsF5xTRuAaf5UrTU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-TrA5zC-mPSu1u3OI1nzpEA-1; Thu, 02 Oct 2025 13:16:47 -0400
X-MC-Unique: TrA5zC-mPSu1u3OI1nzpEA-1
X-Mimecast-MFC-AGG-ID: TrA5zC-mPSu1u3OI1nzpEA_1759425406
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-638f4eaf806so170156a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425405; x=1760030205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uB+V3u/aPrqwLddsF879FaTd8eb+vL09HILtMavahqo=;
 b=phDdo+KUqtwm62RPvgqLPmU0lT7wY21D6tvOZl9ODYQrvGNYTv6VvBJ/oQe7wScMWo
 9OuROzm510NmRHRZC+J1zkLBJ8Xh0rN037V6Z99pCSNFw7s72WWPUbVO3/JGXKBzIiaL
 7zZNJpVszTQwsxcRHCMtyObb+n/mYI17RSB0QldK5YA31CKgJLY7wAe+f/A5+pmq/xJA
 2C+aPw+C+FJ/EJrr5ALkoVqYZBB3ETWtD5np1wv5bEUabyfBwE2rFIFBe28w0VGVvI5T
 UAalYBbA4gVu8C/I4Bqi/R5aI4m4WIP0z6kDzvW4jzEkY6JZhnO275jRsDDgCvhF/eJ7
 mUog==
X-Gm-Message-State: AOJu0YzB188nE+/rdmz/xJZ0i7JmK6KkThBCBTXVkeeFqnLZXTm4z8qF
 C/w1TNr0ovUYqYSLrAe71zWFcMDRWhq8KKQ7Cwhpn3pTtahEbK5fEQSvibn1qV6EPh753fxyzYz
 2uSgVs4W12+hoGOTZlcWm9gIiNrUOA0NPxYGvvLs1dL1p7jTmqBmfa8kbmiZiSmqZKpDjJ11XnT
 Ns8ES8YYxrEaepFsMu5sO0cK4rmOJwGqytyelbunIe
X-Gm-Gg: ASbGncvDidLeu4M58pS6HyR5m1dwu1xFXn20XkGDLWdzRybyT00fBmTi0BDo+tHQjo4
 5vIC755niZBYp1syGnIe389AOHeTI1a8YKTu0mhpc9Py/sqR9YIiuNXMpI0n35wu1AIWhSuK8CE
 Ng3JC/0ULDNZ3yg7FbMMU53T9b60cfhB9iEH1Z6NRX4xiegA1bumQWolm+24hYCZgSx6aMT+plS
 EN0SOsf9Z3/H+zUCpdeglM86SOM5e6AQCa13FqplOYSVCVMfnK0VDnDdk7AY+TcjpCwRmaNuFGK
 hwuEgSIL4IUmx5WOHVSTz67Mo4YlXEVoGINddgORU5bLX4qNx1fisEaRUzKWVNJsbHKUptsTPvo
 +LyVKNzOLJaGvau483ZdTlNLkeUAoD862FzXnmIcBFez2OeLO
X-Received: by 2002:a05:6402:1e95:b0:638:3f72:125a with SMTP id
 4fb4d7f45d1cf-6383f72157dmr1138963a12.14.1759425404880; 
 Thu, 02 Oct 2025 10:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbKQa2ezHyz7vYFTCZhzvNhiHQnaV19wXBRfr3cnw3DL9rQHzWeiCP+1zjsVXlqth8vqWVlw==
X-Received: by 2002:a05:6402:1e95:b0:638:3f72:125a with SMTP id
 4fb4d7f45d1cf-6383f72157dmr1138904a12.14.1759425404194; 
 Thu, 02 Oct 2025 10:16:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63788111f1fsm2251293a12.36.2025.10.02.10.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 22/27] target/i386/mshv: Implement mshv_vcpu_run()
Date: Thu,  2 Oct 2025 19:15:31 +0200
Message-ID: <20251002171536.1460049-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Add the main vCPU execution loop for MSHV using the MSHV_RUN_VP ioctl.

The execution loop handles guest entry and VM exits. There are handlers for
memory r/w, PIO and MMIO to which the exit events are dispatched.

In case of MMIO the i386 instruction decoder/emulator is invoked to
perform the operation in user space.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-23-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 444 +++++++++++++++++++++++++++++++++++-
 1 file changed, 442 insertions(+), 2 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 33a3ce8b110..7edc032cea3 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1082,10 +1082,450 @@ void mshv_arch_amend_proc_features(
     features->access_guest_idle_reg = 1;
 }
 
+static int set_memory_info(const struct hyperv_message *msg,
+                           struct hv_x64_memory_intercept_message *info)
+{
+    if (msg->header.message_type != HVMSG_GPA_INTERCEPT
+            && msg->header.message_type != HVMSG_UNMAPPED_GPA
+            && msg->header.message_type != HVMSG_UNACCEPTED_GPA) {
+        error_report("invalid message type");
+        return -1;
+    }
+    memcpy(info, msg->payload, sizeof(*info));
+
+    return 0;
+}
+
+static int emulate_instruction(CPUState *cpu,
+                               const uint8_t *insn_bytes, size_t insn_len,
+                               uint64_t gva, uint64_t gpa)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    struct x86_decode decode = { 0 };
+    int ret;
+    x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
+
+    ret = mshv_load_regs(cpu);
+    if (ret < 0) {
+        error_report("failed to load registers");
+        return -1;
+    }
+
+    decode_instruction_stream(env, &decode, &stream);
+    exec_instruction(env, &decode);
+
+    ret = mshv_store_regs(cpu);
+    if (ret < 0) {
+        error_report("failed to store registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int handle_mmio(CPUState *cpu, const struct hyperv_message *msg,
+                       MshvVmExit *exit_reason)
+{
+    struct hv_x64_memory_intercept_message info = { 0 };
+    size_t insn_len;
+    uint8_t access_type;
+    uint8_t *instruction_bytes;
+    int ret;
+
+    ret = set_memory_info(msg, &info);
+    if (ret < 0) {
+        error_report("failed to convert message to memory info");
+        return -1;
+    }
+    insn_len = info.instruction_byte_count;
+    access_type = info.header.intercept_access_type;
+
+    if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_EXECUTE) {
+        error_report("invalid intercept access type: execute");
+        return -1;
+    }
+
+    if (insn_len > 16) {
+        error_report("invalid mmio instruction length: %zu", insn_len);
+        return -1;
+    }
+
+    trace_mshv_handle_mmio(info.guest_virtual_address,
+                           info.guest_physical_address,
+                           info.instruction_byte_count, access_type);
+
+    instruction_bytes = info.instruction_bytes;
+
+    ret = emulate_instruction(cpu, instruction_bytes, insn_len,
+                              info.guest_virtual_address,
+                              info.guest_physical_address);
+    if (ret < 0) {
+        error_report("failed to emulate mmio");
+        return -1;
+    }
+
+    *exit_reason = MshvVmExitIgnore;
+
+    return 0;
+}
+
+static int set_ioport_info(const struct hyperv_message *msg,
+                           hv_x64_io_port_intercept_message *info)
+{
+    if (msg->header.message_type != HVMSG_X64_IO_PORT_INTERCEPT) {
+        error_report("Invalid message type");
+        return -1;
+    }
+    memcpy(info, msg->payload, sizeof(*info));
+
+    return 0;
+}
+
+static int set_x64_registers(const CPUState *cpu, const uint32_t *names,
+                             const uint64_t *values)
+{
+
+    hv_register_assoc assocs[2];
+    int ret;
+
+    for (size_t i = 0; i < ARRAY_SIZE(assocs); i++) {
+        assocs[i].name = names[i];
+        assocs[i].value.reg64 = values[i];
+    }
+
+    ret = mshv_set_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
+    if (ret < 0) {
+        error_report("failed to set x64 registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+static inline MemTxAttrs get_mem_attrs(bool is_secure_mode)
+{
+    MemTxAttrs memattr = {0};
+    memattr.secure = is_secure_mode;
+    return memattr;
+}
+
+static void pio_read(uint64_t port, uint8_t *data, uintptr_t size,
+                     bool is_secure_mode)
+{
+    int ret = 0;
+    MemTxAttrs memattr = get_mem_attrs(is_secure_mode);
+    ret = address_space_rw(&address_space_io, port, memattr, (void *)data, size,
+                           false);
+    if (ret != MEMTX_OK) {
+        error_report("Failed to read from port %lx: %d", port, ret);
+        abort();
+    }
+}
+
+static int pio_write(uint64_t port, const uint8_t *data, uintptr_t size,
+                     bool is_secure_mode)
+{
+    int ret = 0;
+    MemTxAttrs memattr = get_mem_attrs(is_secure_mode);
+    ret = address_space_rw(&address_space_io, port, memattr, (void *)data, size,
+                           true);
+    return ret;
+}
+
+static int handle_pio_non_str(const CPUState *cpu,
+                              hv_x64_io_port_intercept_message *info)
+{
+    size_t len = info->access_info.access_size;
+    uint8_t access_type = info->header.intercept_access_type;
+    int ret;
+    uint32_t val, eax;
+    const uint32_t eax_mask =  0xffffffffu >> (32 - len * 8);
+    size_t insn_len;
+    uint64_t rip, rax;
+    uint32_t reg_names[2];
+    uint64_t reg_values[2];
+    uint16_t port = info->port_number;
+
+    if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
+        union {
+            uint32_t u32;
+            uint8_t bytes[4];
+        } conv;
+
+        /* convert the first 4 bytes of rax to bytes */
+        conv.u32 = (uint32_t)info->rax;
+        /* secure mode is set to false */
+        ret = pio_write(port, conv.bytes, len, false);
+        if (ret < 0) {
+            error_report("Failed to write to io port");
+            return -1;
+        }
+    } else {
+        uint8_t data[4] = { 0 };
+        /* secure mode is set to false */
+        pio_read(info->port_number, data, len, false);
+
+        /* Preserve high bits in EAX, but clear out high bits in RAX */
+        val = *(uint32_t *)data;
+        eax = (((uint32_t)info->rax) & ~eax_mask) | (val & eax_mask);
+        info->rax = (uint64_t)eax;
+    }
+
+    insn_len = info->header.instruction_length;
+
+    /* Advance RIP and update RAX */
+    rip = info->header.rip + insn_len;
+    rax = info->rax;
+
+    reg_names[0] = HV_X64_REGISTER_RIP;
+    reg_values[0] = rip;
+    reg_names[1] = HV_X64_REGISTER_RAX;
+    reg_values[1] = rax;
+
+    ret = set_x64_registers(cpu, reg_names, reg_values);
+    if (ret < 0) {
+        error_report("Failed to set x64 registers");
+        return -1;
+    }
+
+    cpu->accel->dirty = false;
+
+    return 0;
+}
+
+static int fetch_guest_state(CPUState *cpu)
+{
+    int ret;
+
+    ret = mshv_get_standard_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to get standard registers");
+        return -1;
+    }
+
+    ret = mshv_get_special_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to get special registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int read_memory(const CPUState *cpu, uint64_t initial_gva,
+                       uint64_t initial_gpa, uint64_t gva, uint8_t *data,
+                       size_t len)
+{
+    int ret;
+    uint64_t gpa, flags;
+
+    if (gva == initial_gva) {
+        gpa = initial_gpa;
+    } else {
+        flags = HV_TRANSLATE_GVA_VALIDATE_READ;
+        ret = translate_gva(cpu, gva, &gpa, flags);
+        if (ret < 0) {
+            return -1;
+        }
+
+        ret = mshv_guest_mem_read(gpa, data, len, false, false);
+        if (ret < 0) {
+            error_report("failed to read guest mem");
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+static int write_memory(const CPUState *cpu, uint64_t initial_gva,
+                        uint64_t initial_gpa, uint64_t gva, const uint8_t *data,
+                        size_t len)
+{
+    int ret;
+    uint64_t gpa, flags;
+
+    if (gva == initial_gva) {
+        gpa = initial_gpa;
+    } else {
+        flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
+        ret = translate_gva(cpu, gva, &gpa, flags);
+        if (ret < 0) {
+            error_report("failed to translate gva to gpa");
+            return -1;
+        }
+    }
+    ret = mshv_guest_mem_write(gpa, data, len, false);
+    if (ret != MEMTX_OK) {
+        error_report("failed to write to mmio");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int handle_pio_str_write(CPUState *cpu,
+                                hv_x64_io_port_intercept_message *info,
+                                size_t repeat, uint16_t port,
+                                bool direction_flag)
+{
+    int ret;
+    uint64_t src;
+    uint8_t data[4] = { 0 };
+    size_t len = info->access_info.access_size;
+
+    src = linear_addr(cpu, info->rsi, R_DS);
+
+    for (size_t i = 0; i < repeat; i++) {
+        ret = read_memory(cpu, 0, 0, src, data, len);
+        if (ret < 0) {
+            error_report("Failed to read memory");
+            return -1;
+        }
+        ret = pio_write(port, data, len, false);
+        if (ret < 0) {
+            error_report("Failed to write to io port");
+            return -1;
+        }
+        src += direction_flag ? -len : len;
+        info->rsi += direction_flag ? -len : len;
+    }
+
+    return 0;
+}
+
+static int handle_pio_str_read(CPUState *cpu,
+                               hv_x64_io_port_intercept_message *info,
+                               size_t repeat, uint16_t port,
+                               bool direction_flag)
+{
+    int ret;
+    uint64_t dst;
+    size_t len = info->access_info.access_size;
+    uint8_t data[4] = { 0 };
+
+    dst = linear_addr(cpu, info->rdi, R_ES);
+
+    for (size_t i = 0; i < repeat; i++) {
+        pio_read(port, data, len, false);
+
+        ret = write_memory(cpu, 0, 0, dst, data, len);
+        if (ret < 0) {
+            error_report("Failed to write memory");
+            return -1;
+        }
+        dst += direction_flag ? -len : len;
+        info->rdi += direction_flag ? -len : len;
+    }
+
+    return 0;
+}
+
+static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
+{
+    uint8_t access_type = info->header.intercept_access_type;
+    uint16_t port = info->port_number;
+    bool repop = info->access_info.rep_prefix == 1;
+    size_t repeat = repop ? info->rcx : 1;
+    size_t insn_len = info->header.instruction_length;
+    bool direction_flag;
+    uint32_t reg_names[3];
+    uint64_t reg_values[3];
+    int ret;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    ret = fetch_guest_state(cpu);
+    if (ret < 0) {
+        error_report("Failed to fetch guest state");
+        return -1;
+    }
+
+    direction_flag = (env->eflags & DESC_E_MASK) != 0;
+
+    if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
+        ret = handle_pio_str_write(cpu, info, repeat, port, direction_flag);
+        if (ret < 0) {
+            error_report("Failed to handle pio str write");
+            return -1;
+        }
+        reg_names[0] = HV_X64_REGISTER_RSI;
+        reg_values[0] = info->rsi;
+    } else {
+        ret = handle_pio_str_read(cpu, info, repeat, port, direction_flag);
+        reg_names[0] = HV_X64_REGISTER_RDI;
+        reg_values[0] = info->rdi;
+    }
+
+    reg_names[1] = HV_X64_REGISTER_RIP;
+    reg_values[1] = info->header.rip + insn_len;
+    reg_names[2] = HV_X64_REGISTER_RAX;
+    reg_values[2] = info->rax;
+
+    ret = set_x64_registers(cpu, reg_names, reg_values);
+    if (ret < 0) {
+        error_report("Failed to set x64 registers");
+        return -1;
+    }
+
+    cpu->accel->dirty = false;
+
+    return 0;
+}
+
+static int handle_pio(CPUState *cpu, const struct hyperv_message *msg)
+{
+    struct hv_x64_io_port_intercept_message info = { 0 };
+    int ret;
+
+    ret = set_ioport_info(msg, &info);
+    if (ret < 0) {
+        error_report("Failed to convert message to ioport info");
+        return -1;
+    }
+
+    if (info.access_info.string_op) {
+        return handle_pio_str(cpu, &info);
+    }
+
+    return handle_pio_non_str(cpu, &info);
+}
+
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 {
-    error_report("unimplemented");
-    abort();
+    int ret;
+    enum MshvVmExit exit_reason;
+    int cpu_fd = mshv_vcpufd(cpu);
+
+    ret = ioctl(cpu_fd, MSHV_RUN_VP, msg);
+    if (ret < 0) {
+        return MshvVmExitShutdown;
+    }
+
+    switch (msg->header.message_type) {
+    case HVMSG_UNRECOVERABLE_EXCEPTION:
+        return MshvVmExitShutdown;
+    case HVMSG_UNMAPPED_GPA:
+    case HVMSG_GPA_INTERCEPT:
+        ret = handle_mmio(cpu, msg, &exit_reason);
+        if (ret < 0) {
+            error_report("failed to handle mmio");
+            return -1;
+        }
+        return exit_reason;
+    case HVMSG_X64_IO_PORT_INTERCEPT:
+        ret = handle_pio(cpu, msg);
+        if (ret < 0) {
+            return MshvVmExitSpecial;
+        }
+        return MshvVmExitIgnore;
+    default:
+        break;
+    }
+
+    *exit = MshvVmExitIgnore;
+    return 0;
 }
 
 void mshv_remove_vcpu(int vm_fd, int cpu_fd)
-- 
2.51.0


