Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566BBC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwR-0002yd-Bv; Wed, 07 Feb 2024 11:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwP-0002wi-9B
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:29 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwM-0006BN-KO
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:29 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40fc22f372cso7350405e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323905; x=1707928705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUnXcCSSh6U29fLbXe/wbWbJ/XTPO8jPvZXYeKxJYts=;
 b=dYPKpNZat1kg7Bzk79dTrSh7xTWlZIFoV++5iZaestZEIoNvUJVpF5OK1mRVtEVluy
 rLdi0lYkpY7PPq0pyN4utdzDI0zI6n8ofDCsmQRYN8CpSh8My1m99ShWnuRkcIe7W8EQ
 fj+QxCv0eIAq1fNAmj4djbNJSKFiYyTRXPMFd45TpZ3fiZriYiNb/fXsF+Wn+bJIggzD
 syxZdBWg9TJkIxqvwAq9nK11Xk4jMjX/D0vxV9EfntcdwSZmkA2n/bQibSt82FVWLU1+
 rp2ZiRYH47yn6IyVRRkzlwYXoL8cYieQw4uuE56IzO1hlDM9/yZAmmS/5XwuCrWgjsZn
 IHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323905; x=1707928705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUnXcCSSh6U29fLbXe/wbWbJ/XTPO8jPvZXYeKxJYts=;
 b=CdxpRqCyWwZ/8P3qlk/rVTuBTYUun3zxUxB5iflr8bp5lptoNhf0n55KG34E5cC3MV
 RvbggMhzUwN3LdvC6OQktnlJFTFFzRGmg3fDnrvvT2wN1ZoUKzZJo9RE75amqOTwGXlk
 ulRIM4NDGHZuvR0GmpiB57Q1oEZ9ezmgW02xM8+JHXj/21scNnQRhONqlZWpOoFO6N2X
 oLhmpnb/1CgIplIZ5dSn5EmTVesAoJ8MCUe/ub7sdwuQqB+cWZJ0gGWzToP3fb0FcgOa
 DphPK4DHw+JPKN1iBkEww+TBqq55Ywi6JxNZhRaTIQn2nxeIGnnT3NnWMQ7LcIyQenOg
 yh9g==
X-Gm-Message-State: AOJu0YyuOF+B9SK1lSptlLXdxXbWNzi/eo9hDJJ/rWOx5O4qCvDFGOv5
 QN60x7GqKtfCpVF+JRbRg0mZ/YAQsmVcnDvotg3IUijZm/HvJaXihUe8j6NeVl4=
X-Google-Smtp-Source: AGHT+IHWOH3+Y6dzVMWPSwfE1ua+TKP+nXGejC30x3sF+o/N8E89jj4nClzW6MEa8GwnWbdEZrfvoA==
X-Received: by 2002:a05:600c:1910:b0:40e:c6a6:5111 with SMTP id
 j16-20020a05600c191000b0040ec6a65111mr4417992wmq.11.1707323905332; 
 Wed, 07 Feb 2024 08:38:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWhyaD1vupT/FNfVmORb9ZE7cv2foxFCinjPT9uXP8f9AAyFqzRcblYR8DkLUd4MRMpU80Kh9knP9Xp/N34knFALV1YwEDmfa7ufQFAswE8J+cey7zgurjX40sWDb76CMmQcWtgjhFid5dPrZ5F2JaYOv/gOeuJsNN+t0mwV+O98nDgqrr3vwyLp32/1OFZSInOM2CG9HHeV2CTPvZdVgjiruo0DPrSV3mKh/zx2iI1QWEZtR/RHTvC2exI9SZ1vivntZkp/LBWNESzL1xpg0XskBO1mkpcDf4N6XHvg6plb46ZKMlqtC+7x9yodxM8lUmdOMvZSB4cioBZlM4vXpWRmDkDM8Z03bdZYU4ueKRd0YCkV4kdotAwoSOZ7NmhY+B4cBlQSsnO+8VeVCJw3VKwELEOfjAdIPU3E4S47HZYsUAoGierf4mcmpttDPyD3Gqe601N75ZrTi9RiFD0zbekxRnK9NhLq3KjxF8RgGi5Cc9vN1+JgXylYaf0RY+0ivn1hx3SKXnE3cbJo4BNiArQ4JEGvoa8XfYBg2LTky/dTVCUfFQU2j4OK/l4cWDJCty0CONgxKRZxHLPhbCY+kDxa7u/FLQCjkXlzixFKruSeGJ+4y2acbF7QQxx7zPkkp63gM2cQZQzT0lexbqWcJ/hRVXfkM9kxgT4d3jlzF9O70i9EB728P9UP87Ok2RdcRE59YC02MTk3hW5QDMs/8cKlKdjfP06gRSarINiDPiiOd1mwPBx8oawc1HxlAPqZPcZo1pjaqesKNLItT6FGKhoi2IKFo6lDgaM5VOZVMhJxzwSlNvFs0+wBuDqIMJa9j49ehzX0nmZN0MBRaZr8MmTuLCaswIYsTk3GI1l
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w8-20020a05600c474800b00410219f126bsm779121wmo.37.2024.02.07.08.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 424755F94A;
 Wed,  7 Feb 2024 16:38:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 12/14] gdbstub: Add syscall entry/return hooks
Date: Wed,  7 Feb 2024 16:38:10 +0000
Message-Id: <20240207163812.3231697-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163812.3231697-1-alex.bennee@linaro.org>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The upcoming syscall catchpoint support needs to get control on syscall
entry and return. Provide the necessary hooks for that, which are
no-ops for now.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240202152506.279476-4-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/user.h       | 13 +++++++++++++
 include/user/syscall-trace.h |  7 +++++--
 gdbstub/user.c               |  8 ++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 1fc43e04af5..68b6534130c 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -51,5 +51,18 @@ void gdb_signalled(CPUArchState *as, int sig);
  */
 void gdbserver_fork(CPUState *cs);
 
+/**
+ * gdb_syscall_entry() - inform gdb of syscall entry and yield control to it
+ * @cs: CPU
+ * @num: syscall number
+ */
+void gdb_syscall_entry(CPUState *cs, int num);
+
+/**
+ * gdb_syscall_entry() - inform gdb of syscall return and yield control to it
+ * @cs: CPU
+ * @num: syscall number
+ */
+void gdb_syscall_return(CPUState *cs, int num);
 
 #endif /* GDBSTUB_USER_H */
diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
index 557f881a79b..b48b2b2d0ae 100644
--- a/include/user/syscall-trace.h
+++ b/include/user/syscall-trace.h
@@ -11,6 +11,7 @@
 #define SYSCALL_TRACE_H
 
 #include "exec/user/abitypes.h"
+#include "gdbstub/user.h"
 #include "qemu/plugin.h"
 #include "trace/trace-root.h"
 
@@ -20,7 +21,7 @@
  * could potentially unify the -strace code here as well.
  */
 
-static inline void record_syscall_start(void *cpu, int num,
+static inline void record_syscall_start(CPUState *cpu, int num,
                                         abi_long arg1, abi_long arg2,
                                         abi_long arg3, abi_long arg4,
                                         abi_long arg5, abi_long arg6,
@@ -29,11 +30,13 @@ static inline void record_syscall_start(void *cpu, int num,
     qemu_plugin_vcpu_syscall(cpu, num,
                              arg1, arg2, arg3, arg4,
                              arg5, arg6, arg7, arg8);
+    gdb_syscall_entry(cpu, num);
 }
 
-static inline void record_syscall_return(void *cpu, int num, abi_long ret)
+static inline void record_syscall_return(CPUState *cpu, int num, abi_long ret)
 {
     qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
+    gdb_syscall_return(cpu, num);
 }
 
 
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 63edca131ab..2ba01c17faf 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -502,3 +502,11 @@ void gdb_syscall_handling(const char *syscall_packet)
     gdb_put_packet(syscall_packet);
     gdb_handlesig(gdbserver_state.c_cpu, 0);
 }
+
+void gdb_syscall_entry(CPUState *cs, int num)
+{
+}
+
+void gdb_syscall_return(CPUState *cs, int num)
+{
+}
-- 
2.39.2


