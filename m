Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD88C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkH6h-0003OC-CN; Thu, 16 Jul 2026 04:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1wkH6f-0003O3-EL
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 04:06:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1wkH6c-0004ui-Qi
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 04:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784189157; bh=xg46MEDtuIUu6GlNoJKCKgRhn3sFSoY/GuzwEWdbBII=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NPxFhLNl2hj2kPu2X5gYQP0AWL/1H+5gILZ7CU3pSscbWQiKK0GKwrE+GwE3CVEiN
 nZ5DLcjGxuuwmCz0M3iD4+c/AODUBYZg0LZZmjwRCKlqMUGNloPNCq9rAxb+8EWdm6
 PfHaEbo266z4uV/aW1qdxw7nFVE1tIPrVBfhVADZLujHnIENZ3TXJ4IZI6uxKc8oH/
 88laykUKIvIGsfBW27OGzZvpqVROjt7r7nNWMLJU/RVgzH+5kvLQEuBq4H4cBxJ5nn
 lsXnjKI4ZbzVKMcvh9L961NNNKJcMFGknowFo/5WdfR2jaF9hBXOQZ4DONaQYaetIc
 UTKtEi1VzxS8Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8918D1C221F;
 Thu, 16 Jul 2026 11:05:57 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 909AB3EFDB2;
 Thu, 16 Jul 2026 11:06:02 +0300 (MSK)
Message-ID: <28be5573-2b49-41c9-9d0e-d5077c2ed37d@tls.msk.ru>
Date: Thu, 16 Jul 2026 11:05:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/sh4: add VDSO support for sh4 and sh4eb
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260523114128.2468754-1-mattst88@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260523114128.2468754-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/23/26 14:41, Matt Turner wrote:
> Provides replacement VDSO with sigreturn trampolines
> (__kernel_sigreturn, __kernel_rt_sigreturn) and syscall stubs
> (clock_gettime, clock_gettime64, clock_getres, gettimeofday).
> 
> Both LE and BE blobs are committed and selected at compile time via
> TARGET_BIG_ENDIAN. The BE variant requires an sh4eb-unknown-linux-gnu
> toolchain; sh4-unknown-linux-gnu does not support -mb.
> 
> CFI register numbers follow GCC's SH_DEBUGGER_REGNO:
> PR=17, GBR=18, MACH=20, MACL=21, FPUL=23, FPSCR=24, FR0-15=25-40.
> ---
>   linux-user/sh4/Makefile.vdso    |  18 ++++
>   linux-user/sh4/elfload.c        |  14 ++++
>   linux-user/sh4/meson.build      |  12 +++
>   linux-user/sh4/target_elf.h     |   1 +
>   linux-user/sh4/vdso-asmoffset.h |  45 ++++++++++
>   linux-user/sh4/vdso-be.so       | Bin 0 -> 2704 bytes
>   linux-user/sh4/vdso-le.so       | Bin 0 -> 2704 bytes
>   linux-user/sh4/vdso.S           | 142 ++++++++++++++++++++++++++++++++
>   linux-user/sh4/vdso.ld          |  67 +++++++++++++++
>   9 files changed, 299 insertions(+)
>   create mode 100644 linux-user/sh4/Makefile.vdso
>   create mode 100644 linux-user/sh4/vdso-asmoffset.h
>   create mode 100755 linux-user/sh4/vdso-be.so
>   create mode 100755 linux-user/sh4/vdso-le.so
>   create mode 100644 linux-user/sh4/vdso.S
>   create mode 100644 linux-user/sh4/vdso.ld
> 
> diff --git ./linux-user/sh4/Makefile.vdso ./linux-user/sh4/Makefile.vdso
> new file mode 100644
> index 0000000000..272c5d262d
> --- /dev/null
> +++ ./linux-user/sh4/Makefile.vdso
> @@ -0,0 +1,18 @@
> +include $(BUILD_DIR)/tests/tcg/sh4-linux-user/config-target.mak
> +
> +SUBDIR = $(SRC_PATH)/linux-user/sh4
> +VPATH += $(SUBDIR)
> +
> +all: $(SUBDIR)/vdso-le.so $(SUBDIR)/vdso-be.so
> +
> +LDFLAGS = -nostdlib -shared -Wl,-h,linux-gate.so.1 \
> +	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
> +	  -Wl,-T,$(SUBDIR)/vdso.ld
> +
> +$(SUBDIR)/vdso-le.so: vdso.S vdso.ld vdso-asmoffset.h
> +	$(CC) -o $@ $(LDFLAGS) -ml $<
> +
> +CC_BE = sh4eb-unknown-linux-gnu-gcc
> +
> +$(SUBDIR)/vdso-be.so: vdso.S vdso.ld vdso-asmoffset.h
> +	$(CC_BE) -o $@ $(LDFLAGS) $<

Where this sh4eb-unknown-linux-gnu-gcc comes from?  For one,
we don't have it in debian.  Can the same be produced with

  sh4-linux-gnu-gcc -Wl,-EB -Wa,--big

instead?  (Or -gcc -mb, which does not work on debian currenly).
I can pass this on command like as CC_BE="..".

But I know nothing about sh4, so dunno if this is the right
thing to do.  It builds, but I don't have any sh4eb binary
to test against.

Thanks,

/mjt

