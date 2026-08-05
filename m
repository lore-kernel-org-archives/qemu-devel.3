Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB4BC55822
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrXhs-0002DF-3j; Wed, 05 Aug 2026 05:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wrXhq-0002D3-G2
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:14:34 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wrXhn-0000zg-IR
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:To:From:Message-ID:Date:MIME-Version:
 Content-Type; bh=mgW+HnnO8ikenCr2Z8Zrcu6eOQ/h1WsvbBalJHPMuvE=;
 b=lcjuIZI6dBESrUYGzhIEDqh9QAN5SmSo3/7J8OQbLVWquse7kqXJjOGCqYIAtw
 GHrK/kO/O5kWzdtyN5sext6ph9BurQ3+j3tzQI6EuM1BgKKSXwbFoNqvc9WeLvad
 W9HzxUFRwtoTBJxM49B9wa7eiyRAMJkSO8pDjmSKr03y0=
Received: from [10.2.10.30] (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wDXX5vd_nJq4TAuNg--.57242S2; 
 Wed, 05 Aug 2026 17:14:06 +0800 (CST)
Subject: Re: [PATCH v6 056/103] tests/tcg/loongarch64: user tests
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
 <20260728044248.137626-57-pierrick.bouvier@oss.qualcomm.com>
From: Song Gao <17746591750@163.com>
Message-ID: <9a1988c6-c899-839a-5cc5-b49046882761@163.com>
Date: Wed, 5 Aug 2026 17:14:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260728044248.137626-57-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: _____wDXX5vd_nJq4TAuNg--.57242S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWUAr1kAFW7Jw1kZw4ktFb_yoW5GFyxp3
 43Cr4rKr4fJF97Kr1fGFyUuF4ftws7C3Wj9F13Kr40vrsIkryUZwn7KrW0qFy3J3y0gw1S
 vwnakr1Sga1DJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRFAprUUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: jprxlkywvzilivq6il2tof0z/xtbC8h4uN2py-t66NwAA3A
Received-SPF: pass client-ip=117.135.210.5; envelope-from=17746591750@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, NICE_REPLY_A=-2.999, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
>   tests/tcg/loongarch64/Makefile.target | 20 ------------------
>   tests/tcg/loongarch64/meson.build     | 30 +++++++++++++++++++++++++++
>   tests/tcg/meson.build                 |  1 +
>   3 files changed, 31 insertions(+), 20 deletions(-)
>   delete mode 100644 tests/tcg/loongarch64/Makefile.target
>   create mode 100644 tests/tcg/loongarch64/meson.build
Reviewed-by:  Song Gao <17746591750@163.com>

Thanks.
Song Gao
> diff --git a/tests/tcg/loongarch64/Makefile.target b/tests/tcg/loongarch64/Makefile.target
> deleted file mode 100644
> index 00030a10266..00000000000
> --- a/tests/tcg/loongarch64/Makefile.target
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -# -*- Mode: makefile -*-
> -#
> -# LoongArch64 specific tweaks
> -
> -# Loongarch64 doesn't support gdb, so skip the EXTRA_RUNS
> -EXTRA_RUNS =
> -
> -LOONGARCH64_SRC=$(SRC_PATH)/tests/tcg/loongarch64
> -VPATH += $(LOONGARCH64_SRC)
> -
> -LDFLAGS+=-lm
> -
> -LOONGARCH64_TESTS  = test_bit
> -LOONGARCH64_TESTS  += test_div
> -LOONGARCH64_TESTS  += test_fclass
> -LOONGARCH64_TESTS  += test_fpcom
> -LOONGARCH64_TESTS  += test_pcadd
> -LOONGARCH64_TESTS  += test_fcsr
> -
> -TESTS += $(LOONGARCH64_TESTS)
> diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
> new file mode 100644
> index 00000000000..209179fd96c
> --- /dev/null
> +++ b/tests/tcg/loongarch64/meson.build
> @@ -0,0 +1,30 @@
> +cc = 'loongarch64-unknown-linux-gnu-gcc'
> +cc_dockerfile = 'debian-loongarch-cross'
> +cc_docker_host_arch = ['x86_64']
> +
> +tests = []
> +
> +tests += tcg_tests['multiarch-linux-user']['tests']
> +
> +tests += {
> +  'test_bit.c': {},
> +  'test_fclass.c': {},
> +  'test_fcsr.c': {},
> +  'test_fpcom.c': {},
> +  'test_div.c': {},
> +  'test_pcadd.c': {},
> +}
> +
> +if 'qemu-loongarch64' in emulators
> +  tcg_tests += {
> +    'loongarch64-linux-user': {
> +      'cc': cc,
> +      'cc_dockerfile': cc_dockerfile,
> +      'cc_docker_host_arch': cc_docker_host_arch,
> +      'folder': 'loongarch64',
> +      'gdb_arch': 'loongarch64',
> +      'qemu': emulators['qemu-loongarch64'],
> +      'tests': tests,
> +    }
> +  }
> +endif
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 82217fcb6ff..30d7f1a7344 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -143,6 +143,7 @@ subdir('arm')
>   subdir('hexagon')
>   subdir('hppa')
>   subdir('i386')
> +subdir('loongarch64')
>   
>   image_targets = {}
>   exe_targets = []


