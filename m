Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7577EFCC04D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZ2q-0004Sa-2V; Fri, 06 Mar 2026 12:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZ2V-0004R9-04
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:32:39 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZ2S-0004NC-Ay
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:32:38 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-899a5db525cso87709916d6.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772818354; x=1773423154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bkgbyf3gswKuEQIzITYNoeGmX6DnWgJ9oK8REkf0lQo=;
 b=HONng1JvS7JJuR2BjFyyobTeMD9sXgxm+DZWSXZedscFp5mPWL2uJyVOI/TOfCTi80
 b/d1dUPs39gX+bBrzbJMPrxmNormmu+JDXQ1I2PyWS8m/eiCYMA87SqijdcjtAc8KCeT
 iGbvHUQoRfV1TBzi+gAHunY7IoKYzKSCGTrF3ccKre8QNUMNGOsJNrDbsdBoHPNvOD4c
 PuKQaCdb/Xko66AAQRKGNq9OYuLqF8JLnzUjdkkAOqL8YWaoutoCmyBG45X4FW/5avqw
 NUqGACozvdqQMicXWdk6Kwufe+VMYsevJrW8+QpznsZ7EWXeQyUCmGxcI2uQsrgjwi6k
 +jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772818354; x=1773423154;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bkgbyf3gswKuEQIzITYNoeGmX6DnWgJ9oK8REkf0lQo=;
 b=JdissyhHltFpbqDANck6xnygoZkvvWjambjfA5gGGefa58IZ85O9RgVCWgvqQjeR4B
 3lvdD1PJnaqtzV5/OquxmFT+E3S+T30s+ugzY6G16Xf24vQY5Zsl5hhPG2XcvgUA+szl
 r49pl/9VppJ+9xDe3nzsUDgmBbc1p02GUQGDFOHpoeyHPL0HC78FaMchTr0NEd32NdPa
 VR90P2bmpot+HdiEessIX8eJF6PlX0GgXv/i36xAPbuU3PVzymNXNFQX5fT6L81dq/cd
 ljvonfu0JG7fdP8Qj4vKgj02H5ma6KMChctV+8QgjqvCKinRQRuzlVbH5++xCl6si7lr
 00Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcF7ba3y1V9+JmAYZkf10WVyx67uzTVscAGD28uQ9ksoq5fWELhtBO07m9UTNiVXHk7WOcVd5LkyA7@nongnu.org
X-Gm-Message-State: AOJu0YwCcA9UlMGatwrEIc1saPWOzjvNZtGnjDrICpv158ozaOWZGEC+
 15DkbDCbndXZH3n7Af7ie0csEcU2XOvOpmZT9QcnwTbwASVAXCNus5t7TelDJqagvYw=
X-Gm-Gg: ATEYQzxLkyiHNTf0ienvfyNVT2lY9K5PpX10NwH4n6LhWJ4wQ22y8Hk/IrOiMWZV8I4
 xOT6F4WmV0+Wu1q+4Yl0X/z8yjnVaVAcf41xa98v9BNT/1CPFNVKE9AspyVjDk2qIDvST/hIiuv
 zlJal9+DdAkoefDHRTatbqNi9gES+AWoFsz8oXNV+zfpMFhzaMjYrSNW1mqLFb5FWgP34YagBPk
 zeZMrkbumm/KPJhxTFio3mrUfhkHL/lWH0WoYmSO7ipySlfrG9CisvSm8iQECOUIGzqUgf7fT4x
 8uhpHByVGwLPITfHr87sGM/d9ZFz+s7hpLR/FzabViQ0Uj68/Tdo8+qMYQRXiRQDukh2yodOo5z
 9x80G4Ss6Kbw0WMEzk7GMmFoQbG1EnlGcJ1/vckJ6wiogxqV2GlRM5HLJfvDYMr32SF87mkPxyM
 itkvZte34dGDmf5+DeZC3NpEZUGIiHkaAkwr+gMq3zoanEP58C50W9NOX36bomUG5d3tKi
X-Received: by 2002:a05:6214:da7:b0:899:ea9e:31c4 with SMTP id
 6a1803df08f44-89a30acdb41mr40909806d6.51.1772818354252; 
 Fri, 06 Mar 2026 09:32:34 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a3140d77bsm15822706d6.5.2026.03.06.09.32.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 09:32:33 -0800 (PST)
Message-ID: <c957fe25-a0a2-405f-be83-d411261c21e6@linaro.org>
Date: Fri, 6 Mar 2026 09:32:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tests/docker: add gdb-multiarch to all-test-cross
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260306161728.2657486-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf31.google.com
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

On 3/6/26 8:17 AM, Alex Bennée wrote:
> This allows the gdb integration tests to be run as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/debian-all-test-cross.docker | 1 +
>   tests/lcitool/refresh                                 | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
> index b73776d95b5..287770a995a 100644
> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> @@ -59,6 +59,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>     apt install -y --no-install-recommends \
>     clang\
>     dpkg-dev\
> +  gdb-multiarch\
>     libclang-rt-dev
>   ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
>     libc6-dev-arm64-cross \
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 3e4b026035b..259e6ea0729 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -167,6 +167,7 @@ debian_all_test_cross_compilers = [
>       "  apt install -y --no-install-recommends \\\n",
>       "  clang\\\n",
>       "  dpkg-dev\\\n",
> +    "  gdb-multiarch\\\n",
>       "  libclang-rt-dev\n",
>       "ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \\\n",
>       "  libc6-dev-arm64-cross \\\n",

As long as ppc gdbstub is not fixed or Philippe series reverted, you'll 
need also:

diff --git a/tests/tcg/multiarch/Makefile.target 
b/tests/tcg/multiarch/Makefile.target
index a347efbadf0..b6209ee082d 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -156,12 +156,16 @@ else
  run-gdbstub-%:
         $(call skip-test, "gdbstub test $*", "need working gdb with 
$(patsubst -%,,$(TARGET_NAME)) support")
  endif
+
+# gdbstub broken on ppc
+ifneq ($(TARGET_NAME), ppc)
  EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
               run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
               run-gdbstub-registers run-gdbstub-prot-none \
               run-gdbstub-catch-syscalls 
run-gdbstub-follow-fork-mode-child \
               run-gdbstub-follow-fork-mode-parent \
               run-gdbstub-qxfer-siginfo-read run-gdbstub-late-attach
+endif

  # ARM Compatible Semi Hosting Tests
  #

