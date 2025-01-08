Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA65E77197
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 02:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVLoP-00066U-U7; Tue, 07 Jan 2025 21:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1tVLoN-00066F-UY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 21:28:47 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1tVLoL-00028U-HU
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 21:28:47 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21661be2c2dso219673205ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 18:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736303323; x=1736908123; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gdMATMdNqGXSA5zA/QFYCU2yeywb7yP6sHUwbF0bQow=;
 b=lkroONX2usviugGjuAQCBFdZa4n8vNSo2alxwlD8i/Ccbt6mWwuZTKBQAjRjFu0NbJ
 IHj4+vo0tqfEQFZXH2KxBEXre9gLbJ9yr2SqnZSuTU8hIMCOYYYzMy3Em/i70aFVJEMp
 vjeE6UUbfiLohv78Cs0jYdfV0x2XEAUqzSnFwVOR+2vRnHHtIRqxMpY9zOP2TirRoSI2
 yIUOSyF3/w80+/+84MqNv/IYGq9N8A5zlkcHEEy9ZrOnRtXeBgk5EjosDrVfvFoxfPuI
 fQaEiMNZAhNy2udZVmNiV2QUmZuORA0QSgJDd+09gAd7A2en5ac3I29lUqihissp8+/X
 LyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736303323; x=1736908123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gdMATMdNqGXSA5zA/QFYCU2yeywb7yP6sHUwbF0bQow=;
 b=lu7XAS2oTszj5IvL3XY8dZuTyvO09ZR1kj4KVcHLSPCtwB4Qi4tlyUXsNYD06fxEXJ
 NZXNi++lswlKBxhS1wvBZo6A9EF3hqDFck7D7pD10O8GlvEJhvHxPfmdbbGKZgCUkWzU
 1jbyZXboUXD3FlyXzjG32d02Lr6+22r6hqSX8ynvNke6StqaqFSypNayXnlm+NaGO8gm
 vsJNreTlRAVivnu3XNx2Tuet4Rmb4ifq0cOxzPfMRYAa43HoMJgUa1dwed1lc0xmKsaF
 WYpXG3ZuuMcH0zGfRwT9FEiDMT+5n1stsapEtFVxQXyqfHLjTMb7nzsbTusgCBQhpx4M
 bxJg==
X-Gm-Message-State: AOJu0Ywqsry5hXP33yxDW1Qix/kUoPWuRWVx3Hx6c5G7F5G6Xj6mROjp
 tLhqkK9goxsawspRqezRJPhq9w1Xy5geijf/u9p56jAew+NOoAnbrTaX0k2wkhjJImHx6Vs2aYJ
 2w0KoAw5oBW5khXNBQx1rgnHw76kWc8mqEzw=
X-Gm-Gg: ASbGnctgk6/lRXIlxu90YXMJ42x13czionZtmtSj3tdK+GR/6pZaN8JoArK4Gh1lIdE
 q1oUmaiP0Rk+Ept0Tub7wJ/DdLOmGLEs31dmlw5k=
X-Google-Smtp-Source: AGHT+IEPiARp9IBxotBrZ2Se2sUF5XNN9+ziyY0Aw4ieEmNa42Oq7DHLw4Ra6Cp1y9wRJ55VKVycyosqnOMn63Ynqw0=
X-Received: by 2002:a05:6a21:158b:b0:1e6:531b:6e65 with SMTP id
 adf61e73a8af0-1e88d2f6ad3mr2147344637.33.1736303323434; Tue, 07 Jan 2025
 18:28:43 -0800 (PST)
MIME-Version: 1.0
References: <CAEekfLYJqvMDf5A_Yj=N6jMGQ4oj3rC+fv3xcCCfSBy8TDaY-Q@mail.gmail.com>
 <CAKmqyKPo=a=RHUvvgKZLB_DJnEXO=7u25MwNfXu5EDjak=y0vg@mail.gmail.com>
 <CAEekfLaW=-tpTo73or0Lv6zqOuCa67UoYSt9guyHFsw6yM37mg@mail.gmail.com>
 <CAKmqyKNeks-12czF7sWP7gr_t=WU9g309_y5Xk58iFBiVcAijg@mail.gmail.com>
In-Reply-To: <CAKmqyKNeks-12czF7sWP7gr_t=WU9g309_y5Xk58iFBiVcAijg@mail.gmail.com>
From: Sam Price <thesamprice@gmail.com>
Date: Tue, 7 Jan 2025 21:28:29 -0500
X-Gm-Features: AbW1kvbkqcZkYQBeQENQqnqLeFPp00PNkZ_Wg_vkgtppS1KyoY84ewMn0papD7E
Message-ID: <CAEekfLYFsdzgRiscqJ4NsvpMsOaLrj_6QbjH-0f42mdggXbyDQ@mail.gmail.com>
Subject: Re: Subject: [PATCH] loader: Add register setting support via cli
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=thesamprice@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

I made the changes, and added documentation.
https://gitlab.com/thesamprice/qemu/-/compare/master...loader?from_project_id=11167699

I left it as [PREFIX]<RegNumber>

I can switch this to just RegNumber if desired.

I am still struggling with the email format sorry.
---
docs/system/generic-loader.rst | 98 ++++++++++++++++++++++++++++++++
hw/core/generic-loader.c | 46 +++++++++++----
include/hw/core/generic-loader.h | 7 +++
3 files changed, 139 insertions(+), 12 deletions(-)

diff --git a/docs/system/generic-loader.rst b/docs/system/generic-loader.rst
index 4f9fb005f1..71d4aaa097 100644
--- a/docs/system/generic-loader.rst
+++ b/docs/system/generic-loader.rst
@@ -117,4 +117,102 @@ future the internal state 'set_pc' (which exists
in the generic loader
now) should be exposed to the user so that they can choose if the PC
is set or not.
+Loading Data into Registers
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The `loader` device allows the initialization of CPU registers from the command
+line. This feature is particularly useful for setting up the processor state
+before starting an executable. By configuring registers prior to execution, the
+`loader` can mimic the state that a bootloader would leave the processor in
+before transferring control to an ELF file or another executable.
+
+The syntax for loading data into registers is as follows::
+
+ -device loader,reg=<reg>,data=<data>,data-len=<data-len>
+
+**Parameters:**
+
+``<reg>``
+ The target register to set. Format must pass the following regex
+ ``[a-zA-Z]+[0-9]+``. The numeric part corresponds to the processor's GDB \
+ register index. For general-purpose registers, this is typically the
+ number in the register's name (e.g., ``r5`` translates to ``5``).
+ Special-purpose registers have specific IDs defined in their processor's
+ `gdbstub.c` file. Note that these IDs vary between processors.
+
+``<data>``
+ The value to load into the specified register. The data must not exceed 8
+ bytes in size.
+
+``<data-len>``
+ The length of the data in bytes. This parameter is mandatory when using
+ the ``data`` argument.
+
+**Examples:**
+
+Set a general-purpose register
+""""""""""""""""""""""""""""""
+
+To set register ``r5`` to ``0xc0001000`` (4 bytes) on CPU 0::
+
+ -device loader,reg=r5,data=0xc0001000,data-len=4
+
+Set a special register
+""""""""""""""""""""""
+
+To set the Program Counter (PC, register ``32``) to ``0x80000000`` on CPU 0::
+
+ -device loader,reg=pc32,data=0x80000000,data-len=4
+
+You must look in your processor's `gdbstub.c` file to special register to index
+mappings.
+
+**Special Registers:**
+
+Special registers are defined in the processor's ``gdbstub.c`` file
with numeric IDs.
+Examples from the MicroBlaze processor at one point looked like. include::
+
+ enum {
+ GDB_PC = 32 + 0,
+ GDB_MSR = 32 + 1,
+ GDB_EAR = 32 + 2,
+ GDB_ESR = 32 + 3,
+ GDB_FSR = 32 + 4,
+ GDB_BTR = 32 + 5,
+ GDB_PVR0 = 32 + 6,
+ GDB_PVR11 = 32 + 17,
+ GDB_EDR = 32 + 18,
+ GDB_SLR = 32 + 25,
+ GDB_SHR = 32 + 26,
+ };
+
+For example, to set the Machine State Register (``GDB_MSR``) on a MicroBlaze
+processor::
+
+ -device loader,reg=MSR33,data=0x00000001,data-len=4
+
+**Register Loading Notes:**
+
+1. **Processor-Specific IDs**:
+ The numeric IDs for registers vary between processors. Always refer to the
+ `gdbstub.c` file for the target processor to identify the correct register
+ mappings.
+
+2. **Pre-Execution State**:
+ This capability is ideal for initializing a simulated environment to match
+ the state expected by an ELF file. For example, you can configure stack
+ pointers, machine state registers, and program counters to prepare the
+ processor to run a bootstrapped application.
+
+3. **Validation**:
+ Register numbers are validated by the `gdb_write_register` function. Ensure
+ the specified register is supported by the target architecture.
+
+4. **Endianess**:
+ The `data` value is written using the processor's native endian format.
+
+By using the `loader` device to initialize registers, you can simulate
+realistic execution environments, enabling detailed testing and debugging
+of embedded software, including bootloaders interactions and operating
+system kernels.
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index ea8628b892..9408ecd150 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -55,6 +55,14 @@ static void generic_loader_reset(void *opaque)
}
}
+ if(s->reg.name) {
+ CPUClass *cc = CPU_GET_CLASS(s->cpu);
+ int bytes_written = cc->gdb_write_register(s->cpu, (uint8_t*)
&s->reg.value, s->reg.num);
+ if(bytes_written != s->reg.data_len) {
+ printf("Error setting register %d to value %lX expected to write %d,
but wrote %d\n", s->reg.num, s->reg.value, s->reg.data_len,
bytes_written);
+ }
+ }
+
if (s->data_len) {
assert(s->data_len <= sizeof(s->data));
dma_memory_write(s->cpu->as, s->addr, &s->data, s->data_len,
@@ -89,14 +97,12 @@ static void generic_loader_realize(DeviceState
*dev, Error **errp)
} else if (s->data_len > 8) {
error_setg(errp, "data-len cannot be greater then 8 bytes");
return;
- }
- } else if (s->file || s->force_raw) {
- /* User is loading an image */
- if (s->data || s->data_len || s->data_be) {
- error_setg(errp, "data can not be specified when loading an "
- "image");
+ }else if (s->addr) {
+ error_setg(errp, "data can not be specified when setting a "
+ "program counter");
return;
}
+ } else if (s->file || s->force_raw) {
/* The user specified a file, only set the PC if they also specified
* a CPU to use.
*/
@@ -105,17 +111,13 @@ static void generic_loader_realize(DeviceState
*dev, Error **errp)
}
} else if (s->addr) {
/* User is setting the PC */
- if (s->data || s->data_len || s->data_be) {
- error_setg(errp, "data can not be specified when setting a "
- "program counter");
- return;
- } else if (s->cpu_num == CPU_NONE) {
+ if (s->cpu_num == CPU_NONE) {
error_setg(errp, "cpu_num must be specified when setting a "
"program counter");
return;
}
s->set_pc = true;
- } else {
+ } else {
/* Did the user specify anything? */
error_setg(errp, "please include valid arguments");
return;
@@ -166,6 +168,25 @@ static void generic_loader_realize(DeviceState
*dev, Error **errp)
}
}
+ if (s->reg.name) {
+ int reg_num;
+ CPUClass *cc = CPU_GET_CLASS(s->cpu);
+ char prefix[32]; /* Read up to 32 characters prior to the register number*/
+ int scan_num = sscanf(s->reg.name, "%31[a-zA-Z]%d",prefix, &reg_num);
+ if ( scan_num != 2){
+ error_setg(errp, "Unsupported register: %s, Failed to deterimine
register number", s->reg.name);
+ s->reg.name = 0x0;
+ }else if( reg_num < 0 || cc->gdb_num_core_regs < reg_num){
+ error_setg(errp, "Unsupported register: %s, register number must be
less than %d, got %d", s->reg.name, cc->gdb_num_core_regs, reg_num);
+ s->reg.name = 0x0;
+ }else{
+ s->reg.value = s->data;
+ s->reg.num = reg_num;
+ s->reg.data_len = s->data_len;
+ s->data_len = 0;
+ }
+ }
+
/* Convert the data endianness */
if (s->data_be) {
s->data = cpu_to_be64(s->data);
@@ -187,6 +208,7 @@ static Property generic_loader_props[] = {
DEFINE_PROP_UINT32("cpu-num", GenericLoaderState, cpu_num, CPU_NONE),
DEFINE_PROP_BOOL("force-raw", GenericLoaderState, force_raw, false),
DEFINE_PROP_STRING("file", GenericLoaderState, file),
+ DEFINE_PROP_STRING("reg", GenericLoaderState, reg.name),
DEFINE_PROP_END_OF_LIST(),
};
diff --git a/include/hw/core/generic-loader.h b/include/hw/core/generic-loader.h
index 19d87b39c8..ba826806d3 100644
--- a/include/hw/core/generic-loader.h
+++ b/include/hw/core/generic-loader.h
@@ -39,6 +39,13 @@ struct GenericLoaderState {
bool force_raw;
bool data_be;
bool set_pc;
+
+ struct {
+ char * name;
+ int num;
+ int data_len;
+ uint64_t value;
+ } reg;
};
#define TYPE_GENERIC_LOADER "loader"
-- 
2.45.2

