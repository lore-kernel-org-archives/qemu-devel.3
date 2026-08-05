Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8939C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrXir-0002gF-8U; Wed, 05 Aug 2026 05:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wrXih-0002cr-LR
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:15:27 -0400
Received: from m16.mail.163.com ([220.197.31.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wrXie-0001Jv-W2
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:To:From:Message-ID:Date:MIME-Version:
 Content-Type; bh=VHK4R5sOJaa5f5je9RWMe008Ueyis2JygboSIDHlaMU=;
 b=bIHzQi8xqAz6NBq7T7khQcrsA1aypnP0+lm6buMTA1fYizdxHzAjAxS+PPC2D8
 Ev1FE01eQE3qwlB3DHkaHJpBU2FOn6saKKPqbeApQdwIGrJfQ4mmqordvuoULKPP
 XRnhEbBaUFhqPJkNYWl7wTbUSB/Nkq37KGujppSWRM2KE=
Received: from [10.2.10.30] (unknown [])
 by gzsmtp1 (Coremail) with SMTP id PCgvCgBH_ZAU_3JqLAYeJQ--.57085S2;
 Wed, 05 Aug 2026 17:15:02 +0800 (CST)
Subject: Re: [PATCH v6 057/103] tests/tcg/loongarch64: system tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-58-pierrick.bouvier@oss.qualcomm.com>
From: Song Gao <17746591750@163.com>
Message-ID: <968d727e-35ea-81c1-ff99-75f7c6095677@163.com>
Date: Wed, 5 Aug 2026 17:15:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260728044248.137626-58-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: PCgvCgBH_ZAU_3JqLAYeJQ--.57085S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1UJry7GFW5GF15tF1xAFb_yoWrAF13p3
 4akF4rKr4kJFy7Jr1xKa45uF4rJrs7C3W7Za43Kr18ZFW7CF1jqr1fKrW5JFy3t3s29w4S
 vwnYkrya9F1DJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRrwIPUUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: jprxlkywvzilivq6il2tof0z/xtbCzxY8RWpy-xY4qAAA3B
Received-SPF: pass client-ip=220.197.31.2; envelope-from=17746591750@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, NICE_REPLY_A=-2.999, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


在 2026/7/28 下午12:42, Pierrick Bouvier 写道:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/loongarch64/Makefile.softmmu-target | 33 -------------
>   tests/tcg/loongarch64/meson.build             |  2 +
>   tests/tcg/loongarch64/system/meson.build      | 47 +++++++++++++++++++
>   3 files changed, 49 insertions(+), 33 deletions(-)
>   delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
>   create mode 100644 tests/tcg/loongarch64/system/meson.build
Reviewed-by:  Song Gao <17746591750@163.com>

Thanks.
Song Gao
> diff --git a/tests/tcg/loongarch64/Makefile.softmmu-target b/tests/tcg/loongarch64/Makefile.softmmu-target
> deleted file mode 100644
> index 6d4a20fde73..00000000000
> --- a/tests/tcg/loongarch64/Makefile.softmmu-target
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -#
> -# Loongarch64 system tests
> -#
> -
> -LOONGARCH64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/loongarch64/system
> -VPATH+=$(LOONGARCH64_SYSTEM_SRC)
> -
> -# These objects provide the basic boot code and helper functions for all tests
> -CRT_OBJS=boot.o
> -
> -LOONGARCH64_TEST_SRCS=$(wildcard $(LOONGARCH64_SYSTEM_SRC)/*.c)
> -LOONGARCH64_TESTS = $(patsubst $(LOONGARCH64_SYSTEM_SRC)/%.c, %, $(LOONGARCH64_TEST_SRCS))
> -
> -CRT_PATH=$(LOONGARCH64_SYSTEM_SRC)
> -LINK_SCRIPT=$(LOONGARCH64_SYSTEM_SRC)/kernel.ld
> -LDFLAGS=-Wl,-T$(LINK_SCRIPT)
> -TESTS+=$(LOONGARCH64_TESTS) $(MULTIARCH_TESTS)
> -CFLAGS+=-nostdlib -g -O1 -march=loongarch64 -mabi=lp64d $(MINILIB_INC)
> -LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc -Wl,--no-warn-rwx-segments
> -
> -# building head blobs
> -.PRECIOUS: $(CRT_OBJS)
> -
> -%.o: $(CRT_PATH)/%.S
> -	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
> -
> -# Build and link the tests
> -%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
> -	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
> -
> -memory: CFLAGS+=-DCHECK_UNALIGNED=0
> -# Running
> -QEMU_OPTS+=-serial chardev:output -kernel
> diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
> index 209179fd96c..1d62de64ed6 100644
> --- a/tests/tcg/loongarch64/meson.build
> +++ b/tests/tcg/loongarch64/meson.build
> @@ -2,6 +2,8 @@ cc = 'loongarch64-unknown-linux-gnu-gcc'
>   cc_dockerfile = 'debian-loongarch-cross'
>   cc_docker_host_arch = ['x86_64']
>   
> +subdir('system')
> +
>   tests = []
>   
>   tests += tcg_tests['multiarch-linux-user']['tests']
> diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
> new file mode 100644
> index 00000000000..b46d2234032
> --- /dev/null
> +++ b/tests/tcg/loongarch64/system/meson.build
> @@ -0,0 +1,47 @@
> +tests = []
> +
> +minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
> +minilib_printf = files(minilib_dir / 'printf.c')[0]
> +link_script = files('kernel.ld')[0]
> +boot = files('boot.S')[0]
> +cflags = ['-nostdlib',
> +          '-Wa,--noexecstack',
> +          '-I', minilib_dir, minilib_printf, boot,
> +          '-Wl,-T', link_script,
> +          '-march=loongarch64',
> +          '-mabi=lp64d',
> +          '-Wl,--no-warn-rwx-segments',
> +          '-lgcc']
> +qemu_def_args = ['-display', 'none',
> +                 '-serial', 'stdio',
> +                 '-kernel']
> +
> +# Multi arch tests
> +multi_src = []
> +foreach t: tcg_tests['multiarch-softmmu']['tests']
> +  foreach src, setup: t
> +    new_cflags = cflags
> +    if fs.stem(src) == 'memory'
> +      new_cflags += '-DCHECK_UNALIGNED=0'
> +    endif
> +    if src not in multi_src
> +      setup += {'cflags': [new_cflags]}
> +      multi_src += src
> +    endif
> +    tests += {src: setup + {'qemu_args': qemu_def_args}}
> +  endforeach
> +endforeach
> +
> +if 'qemu-system-loongarch64' in emulators
> +  tcg_tests += {
> +    'loongarch64-softmmu': {
> +      'cc': cc,
> +      'cc_dockerfile': cc_dockerfile,
> +      'cc_docker_host_arch': cc_docker_host_arch,
> +      'folder': 'loongarch64/system',
> +      'gdb_arch': 'loongarch64',
> +      'qemu': emulators['qemu-system-loongarch64'],
> +      'tests': tests,
> +    }
> +  }
> +endif


