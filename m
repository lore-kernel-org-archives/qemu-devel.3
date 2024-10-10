Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F90CCF11F9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 13:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sytYG-0008TF-FR; Thu, 10 Oct 2024 09:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sytYD-0008Sy-RZ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 09:49:57 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sytYB-0003Ta-8Y
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 09:49:57 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fac9eaeafcso10414261fa.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728568191; x=1729172991; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TmKTRQd1oDumBbznAhnaiV7wzEZHymId5pde/0mHmT0=;
 b=lf1Gp28dOwdtdYGLYTK8DC9nb7BHtACoSmUQRi8e1dr8HhsTWZbk+kXgK7ebwB0ImY
 igU+zcQlDBVi5+ceblZh7a9yXY9xgBwxbOQtS2VeFQJ1fjFC2CSgO6ZWKbJ+bg5INlIJ
 QTF8kbIUdkiKDR4vs8nOMCZPJn9zLBF9HauHXCzeT8GlrXavwxRPgcCekyiq5x88M+hE
 mmv2nLgiJef8Vo37Bfvud5mq+qecUjw283o3RvtFb9d7tYxGVc0vMf0i060HyQnju3j9
 WTKipAkz7ls9i83V/a6HseKhN859j9solLxF+k0uMrGhd7jLJ402TXnB2kFBQF0PCDqY
 3DSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728568191; x=1729172991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TmKTRQd1oDumBbznAhnaiV7wzEZHymId5pde/0mHmT0=;
 b=dLBRXQqc/kXjA400KYv15t3f3cZ9mCEou7yNxzZcmpdMa66evl+6BJWCb4Wz7Wy4g5
 rWX0+lEw0I5Dw3sUIfORdoz/yWQbgTtnqunvuzepyD22vpH0P4YVT+pPEYFTlsGaaa3L
 zJcZTx3M9cuBdikZKUuJSjuTfG5kA/VVzcnW1zfo9Bon0xLuKHJEy1rgP1bA8Uxxps5I
 QIEWWXDXDHRVPWY7QFDMUjsIH3IOEYZitu5bhOfmNAQgDGLPLucSC91v17Egg+3oJhEM
 Y8P36H+hmW6jOUWPvQhKIQzGwIjZGFh8cmt/P5VU9oYpiqkA9sxeq3O5hWRH/wWAYq9r
 vluw==
X-Gm-Message-State: AOJu0YxZzn8acuG3Oioph1IShKvS6hsKyS7ugKfeIRmZjCN5ZZnCgKOE
 Ic0wPCbxsxRrxuhCYjDJBorvDz+ZQLVPjW11GwU8wajc3Tgi3xztPKwwSd1uP1Dn8T8wEABqrDe
 fkeBn7u1idwzMiucYoxmfpNvqcqF/2eWi1Cv/8g==
X-Google-Smtp-Source: AGHT+IFYzsxMBAxHbRC8c6+Kk/i84DZ3fLpKXpPod4rItz3eu9c7Eh0jH2lvncZtbuIF6FlP2jmJEPRtwra7uKMeETk=
X-Received: by 2002:a05:651c:2206:b0:2fa:c9ad:3d3c with SMTP id
 38308e7fff4ca-2fb1870db20mr44647601fa.6.1728568191031; Thu, 10 Oct 2024
 06:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241009094616.1648511-1-pbonzini@redhat.com>
In-Reply-To: <20241009094616.1648511-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Oct 2024 14:49:39 +0100
Message-ID: <CAFEAcA9tdi6iHkTMJXrMGzF4w-YTW2hED=KpzZmYT1SxVupU_w@mail.gmail.com>
Subject: Re: [PULL v2 00/14] Rust initial PoC + meson changes for 2024-10-07
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

On Wed, 9 Oct 2024 at 10:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-04 19:28:37 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 5011e4c2aca4831204aea15223359d29af9a853e:
>
>   gitlab-ci: add Rust-enabled CI job (2024-10-09 11:37:51 +0200)
>
> ----------------------------------------------------------------
> * first commit for Rust support
> * add CI job using Fedora + Rust nightly
> * fix detection of ATOMIC128 on x86_64
>
> ----------------------------------------------------------------

Something about the 'subprojects' changes seems to have
broken 'make vm-build-openbsd':

make: Entering directory '/home/peter.maydell/qemu-openbsd/build'
/home/peter.maydell/qemu-openbsd/build/pyvenv/bin/meson introspect
--targets --tests --benchmarks |
/home/peter.maydell/qemu-openbsd/build/pyvenv/bin/python3 -B
scripts/mtest2make.py > Makefile.mtest
{ \
  echo 'ninja-targets = \'; \
  /usr/bin/ninja -t targets all | sed 's/:.*//; $!s/$/ \\/'; \
  echo 'build-files = \'; \
  /usr/bin/ninja -t query build.ninja | sed -n '1,/^  input:/d; /^
outputs:/q; s/$/ \\/p'; \
} > Makefile.ninja.tmp && mv Makefile.ninja.tmp Makefile.ninja
/home/peter.maydell/qemu-openbsd/build/pyvenv/bin/python3 -B
/home/peter.maydell/qemu-openbsd/tests/vm/openbsd  --debug
--genisoimage /usr/bin/genisoimage    --source-path
/home/peter.maydell/qemu-openbsd --image
"/home/peter.maydell/.cache/qemu-vm/images/openbsd.img"  --build-image
/home/peter.maydell/.cache/qemu-vm/images/openbsd.img
Image file exists, skipping build:
/home/peter.maydell/.cache/qemu-vm/images/openbsd.img
Use --force option to overwrite
/home/peter.maydell/qemu-openbsd/build/pyvenv/bin/python3 -B
/home/peter.maydell/qemu-openbsd/tests/vm/openbsd  --debug  --jobs 8
--verbose    --image
"/home/peter.maydell/.cache/qemu-vm/images/openbsd.img"  --snapshot
--build-qemu /home/peter.maydell/qemu-openbsd --
DEBUG:root:Creating archive
/home/peter.maydell/qemu-openbsd/build/vm-test-7c_u6jxf.tmp/data-993a1.tar
for src_dir dir: /home/peter.maydell/qemu-openbsd
Download keycodemapdb...
  -> Already downloaded
Download libvfio-user...
  -> Already downloaded
Download berkeley-softfloat-3...
  -> Already downloaded
Download berkeley-testfloat-3...
  -> Already downloaded
tar: subprojects/unicode-ident-1.0.12: Cannot stat: No such file or directory
tar: Exiting with failure status due to previous errors
failed to append subproject unicode-ident-1.0.12 to
/home/peter.maydell/qemu-openbsd/build/vm-test-7c_u6jxf.tmp/data-993a1.tar
Failed to prepare guest environment
Traceback (most recent call last):
  File "/home/peter.maydell/qemu-openbsd/tests/vm/basevm.py", line 654, in main
    vm.add_source_dir(args.build_qemu)
  File "/home/peter.maydell/qemu-openbsd/tests/vm/basevm.py", line
277, in add_source_dir
    subprocess.check_call(["./scripts/archive-source.sh", tarfile],
  File "/usr/lib/python3.10/subprocess.py", line 369, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command
'['./scripts/archive-source.sh',
'/home/peter.maydell/qemu-openbsd/build/vm-test-7c_u6jxf.tmp/data-993a1.tar']'
returned non-zero exit status 1.
make: *** [/home/peter.maydell/qemu-openbsd/tests/vm/Makefile.include:110:
vm-build-openbsd] Error 2
make: Leaving directory '/home/peter.maydell/qemu-openbsd/build'

thanks
-- PMM

