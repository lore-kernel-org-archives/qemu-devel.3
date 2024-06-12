Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC17C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNmc-0002R8-Cq; Wed, 12 Jun 2024 09:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNma-0002Qs-QW
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:12:57 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNmY-0001wR-F7
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:12:56 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a63359aaacaso314041566b.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718197972; x=1718802772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WGdvINElSypOvxxuwSmZcwesekuGEiSORliMaHF2TzI=;
 b=uGyDGHKALY8gi4hTA20Hr6ypAXW6zJItgPUG94XynyNgrbwHpdlH/Ntlz1CzzPuvqQ
 7OBdu3zOz4GWzL0QPH1RxiDcAAlbOprcUun5MRBW9q4/hALdq25jjWTgtw1SXxOepX96
 QTlKiTRsVYd6PCIrVEEPqVF1L+UzQBELX9Zz2Ew9YtXJFOAKRKWeMlhwt4MP/DB3nzgw
 IjzTr5ArcNsJnCwJUcbZnJdLz0o9BDYoOe6li7btj0gWn2I+VqSXYfBH/XuopmxOILxt
 8eqFcJ0fU6LkE/f4hctQyzLwvBOAfFoKRsH7SCDBv9faRhrYCW4TN1f4HfLrBlhiqdKD
 LrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718197972; x=1718802772;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WGdvINElSypOvxxuwSmZcwesekuGEiSORliMaHF2TzI=;
 b=Akg1fPPLQwQsCBfRYwVnuoBsjRIoCxA8wAhds04yUkPPwrI2SdLf+pFK+jqbvyjRBx
 X8Fw9UaURNQXOQwXYFiUT4nw17HEIReZVq9Zvksv5PrqdBM24pazIEfEi+6Zw0XX99Rz
 heiEy6lgCL/I+OcBBJb2VmFxjBmyZdnrEDcWd32bwoydlj1pDzfdmYBH5uOqyEKNcj1m
 hZsvw70nrc9mrta4yTxihc/ukSuG54RPW8AnY72oRDPYdCOOr9wUEAFFr9R3cqzKtak5
 qBsLlxAah5q9tDRcU3dKbiTklodV7bzpeHlNQl+3yo1ollm91l6zQIUouYLpt8zqhR4U
 hvbg==
X-Gm-Message-State: AOJu0YwOG4m8f9YJCri6AUncBJZWa7XVPm35k08Zm/IaDYe7MOw0J+8d
 /XNu64933nAQHMBqXyRukYxD3OA4yqA/1X5pBuBPL0txBFbmGJuXmk3/lZDwD5w=
X-Google-Smtp-Source: AGHT+IH45iWEVBgoyTm4o50RqSKNiHyNk7GWOEOwzU23GXMunpvHJ5HLSatpB6ZLTIxP9hlpcIm1vw==
X-Received: by 2002:a17:907:980a:b0:a6f:506d:2d03 with SMTP id
 a640c23a62f3a-a6f506d3c72mr10806066b.1.1718197972343; 
 Wed, 12 Jun 2024 06:12:52 -0700 (PDT)
Received: from [192.168.69.100] (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cae785da2sm415854a12.13.2024.06.12.06.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 06:12:51 -0700 (PDT)
Message-ID: <5c913504-d917-4fd1-86d5-85d3bc293623@linaro.org>
Date: Wed, 12 Jun 2024 15:12:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] semihosting: Restrict to TCG
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20240529155548.5878-1-philmd@linaro.org>
 <20240529155548.5878-4-philmd@linaro.org>
 <CABgObfYmuvMq80Xz0ZBZQiHmKgoiSTVVqio8FmmpttT8rg64kA@mail.gmail.com>
 <7ce86375-779d-43d6-9871-7f9587c95ba6@linaro.org>
 <CABgObfbvjG9bBgCwM-kL+YhjhMw1qLnQdQToCEkKW+V3trskoA@mail.gmail.com>
 <d2b81c56-a57c-4fbe-a65e-86e9755e7c48@linaro.org>
Content-Language: en-US
In-Reply-To: <d2b81c56-a57c-4fbe-a65e-86e9755e7c48@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Paolo,

On 30/5/24 15:58, Philippe Mathieu-Daudé wrote:
> On 30/5/24 09:31, Paolo Bonzini wrote:
>> On Thu, May 30, 2024 at 9:22 AM Philippe Mathieu-Daudé
>> <philmd@linaro.org> wrote:
>>>
>>> On 30/5/24 08:02, Paolo Bonzini wrote:
>>>> On Wed, May 29, 2024 at 5:56 PM Philippe Mathieu-Daudé
>>>> <philmd@linaro.org> wrote:
>>>>> It is pointless to build semihosting when TCG is not available.
>>>>
>>>> Why? I would have naively assumed that a suitable semihosting API
>>>> could be implemented by KVM. The justification (and thus the commit
>>>> message) needs to be different for each architecture if it's a matter
>>>> of instruction set or insufficient KVM userspace API.
>>>
>>> I wasn't sure where semihosting could be used so asked on IRC and
>>> Alex told me TCG only. Maybe the current implementation is TCG
>>> only, and I can reword. It certainly need some refactor to work
>>> on KVM, because currently semihosting end calling the TCG probe_access
>>> API, which I'm trying to restrict to TCG in order to ease linking
>>> multiple libtcg for the single binary (see
>>> https://lore.kernel.org/qemu-devel/20240529155918.6221-1-philmd@linaro.org/).
>>
>> Ok, that goes in the commit message though.
>>
>> "Semihosting currently uses the TCG probe_access API. It is pointless
>> to have it in the binary when TCG isn't".
>>
>> and in the first two patches:
>>
>> "Semihosting currently uses the TCG probe_access API. To prepare for
>> encoding the TCG dependency in Kconfig, do not enable it unless TCG is
>> available".
>>
>> But then, "select FOO if TCG" mean that it can be compiled out; so
>> perhaps "imply SEMIHOSTING if TCG" is better? Same for RISC-V's
>> "select ARM_COMPATIBLE_SEMIHOSTING if TCG".

Building qemu-system-mips configured with --without-default-devices:

Undefined symbols for architecture arm64:
   "_qemu_semihosting_console_write", referenced from:
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
   "_semihost_sys_close", referenced from:
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
   "_uaccess_strlen_user", referenced from:
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
   ...

So this one has to use "select".

Similarly m68k:

Undefined symbols for architecture arm64:
   "_semihost_sys_close", referenced from:
       _do_m68k_semihosting in target_m68k_m68k-semi.c.o
   ...

I can link m68k using semihosting stubs but I'm not sure it is right:

-- >8 --
diff --git a/semihosting/stubs-target-all.c b/semihosting/stubs-target-all.c
new file mode 100644
index 0000000000..1f33173f43
--- /dev/null
+++ b/semihosting/stubs-target-all.c
@@ -0,0 +1,97 @@
+/*
+ * Semihosting Stubs
+ *
+ * Copyright (c) 2024 Linaro Ltd
+ *
+ * Stubs for semihosting targets that don't actually do semihosting.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/exec-all.h"
+#include "semihosting/syscalls.h"
+
+void semihost_sys_open(CPUState *cs, gdb_syscall_complete_cb complete,
+                       target_ulong fname, target_ulong fname_len,
+                       int gdb_flags, int mode)
+{
+}
+
+void semihost_sys_close(CPUState *cs, gdb_syscall_complete_cb complete, 
int fd)
+{
+}
+
+void semihost_sys_read_gf(CPUState *cs, gdb_syscall_complete_cb complete,
+                          GuestFD *gf, target_ulong buf, target_ulong len)
+{
+}
+
+void semihost_sys_read(CPUState *cs, gdb_syscall_complete_cb complete,
+                       int fd, target_ulong buf, target_ulong len)
+{
+}
+
+void semihost_sys_write_gf(CPUState *cs, gdb_syscall_complete_cb complete,
+                           GuestFD *gf, target_ulong buf, target_ulong len)
+{
+}
+
+void semihost_sys_write(CPUState *cs, gdb_syscall_complete_cb complete,
+                        int fd, target_ulong buf, target_ulong len)
+{
+}
+
+void semihost_sys_lseek(CPUState *cs, gdb_syscall_complete_cb complete,
+                        int fd, int64_t off, int gdb_whence)
+{
+}
+
+void semihost_sys_isatty(CPUState *cs, gdb_syscall_complete_cb 
complete, int fd)
+{
+}
+
+void semihost_sys_flen(CPUState *cs, gdb_syscall_complete_cb fstat_cb,
+                       gdb_syscall_complete_cb flen_cb, int fd,
+                       target_ulong fstat_addr)
+{
+}
+
+void semihost_sys_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
+                        int fd, target_ulong addr)
+{
+}
+
+void semihost_sys_stat(CPUState *cs, gdb_syscall_complete_cb complete,
+                       target_ulong fname, target_ulong fname_len,
+                       target_ulong addr)
+{
+}
+
+void semihost_sys_remove(CPUState *cs, gdb_syscall_complete_cb complete,
+                         target_ulong fname, target_ulong fname_len)
+{
+}
+
+void semihost_sys_rename(CPUState *cs, gdb_syscall_complete_cb complete,
+                         target_ulong oname, target_ulong oname_len,
+                         target_ulong nname, target_ulong nname_len)
+{
+}
+
+void semihost_sys_system(CPUState *cs, gdb_syscall_complete_cb complete,
+                         target_ulong cmd, target_ulong cmd_len)
+{
+}
+
+void semihost_sys_gettimeofday(CPUState *cs, gdb_syscall_complete_cb 
complete,
+                               target_ulong tv_addr, target_ulong tz_addr)
+{
+}
+
+#ifndef CONFIG_USER_ONLY
+void semihost_sys_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
+                           int fd, GIOCondition cond, int timeout)
+{
+}
+#endif
diff --git a/semihosting/meson.build b/semihosting/meson.build
index 34933e5a19..aa8b7a9913 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -7,7 +7,7 @@ specific_ss.add(when: ['CONFIG_SEMIHOSTING', 
'CONFIG_SYSTEM_ONLY'], if_true: fil
    'config.c',
    'console.c',
    'uaccess.c',
-))
+), if_false: files('stubs-target-all.c'))

  common_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], 
if_false: files('stubs-all.c'))
  system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_false: 
files('stubs-system.c'))
---

For mips more stubs are needed:

Undefined symbols for architecture arm64:
   "_qemu_semihosting_console_write", referenced from:
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
   "_uaccess_lock_user", referenced from:
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
       _uhi_fstat_cb in target_mips_tcg_sysemu_mips-semi.c.o
   "_uaccess_lock_user_string", referenced from:
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
       _mips_semihosting.cold.6 in target_mips_tcg_sysemu_mips-semi.c.o
       _mips_semihosting.cold.6 in target_mips_tcg_sysemu_mips-semi.c.o
   "_uaccess_strlen_user", referenced from:
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
   "_uaccess_unlock_user", referenced from:
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
       _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
       _uhi_fstat_cb in target_mips_tcg_sysemu_mips-semi.c.o
       ...


