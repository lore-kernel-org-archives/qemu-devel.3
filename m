Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3D1CF2564
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 10:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szZm6-0005Li-2K; Sat, 12 Oct 2024 06:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szZm4-0005La-HD
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 06:55:04 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szZm2-0001ij-9y
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 06:55:04 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a998a5ca499so401234666b.0
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 03:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728730499; x=1729335299; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o6t6Tm426l81ydUf84ZAgZr0/FePQjAIUCmNaJBJ74I=;
 b=BqKJZH4584CxkzJUvKaJ1X59Z0XlvMLgJ1JgF4Vf3XsLPE38dfj252wdoUrvSsYWXb
 R2eQjOEcMxR6NnPM5hOpsebHLLYnGlW4JWNPbh3pP+3tG5kUY+4NRZqq+9nzkkTtExc0
 TnxZ7jdVT2qPIzoMeeR9npdyZ0L7l57UfpvvmjZr3tuCUcYjHF2/jQasLkQTIVBxXjcI
 VMX9+id1s6q1ZHx63lA1+a7Sr0el1M8LZXjWCVTZKNfO/wTNjeW04MZhRAJeW0NLzTTJ
 std0JozkEqKvTgRE/hTkHO1OqzM8QsaVp0/rwSwFCDOz52EFfu37hzK4hi7DogRSaK0L
 Bw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728730499; x=1729335299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o6t6Tm426l81ydUf84ZAgZr0/FePQjAIUCmNaJBJ74I=;
 b=wmfoKZYGAPylqrnAt12IyH2urbCNF6ryibBQfBi3DVlUlvIhaGofva1p/2DcrvM5Tk
 CbhoT4mM3aq8EbqzC8x2+GVUaAQvGigL/u42xVIEu1N0aQZlSvcMbsCu1fkUBFHsgBkH
 iJ8Lttz2wnshJ7gsF7wJQJoBAomvT9d5lMPH0ndoQU8K5CPUbEXcmqpTynvmFPTPwqOM
 u909SO2BRN5w/c+1JKsw8bWV79ubMzhTcHSnq/AK3uekZnQ68R4XVz2I1YjjdAbgxxb0
 FaXxLU6wpmrAyQ0PPV2jK3+6Lxbvuv47z/Rvl83gH/JB+zcwU7hdpE6L0KRrpYekGAhR
 L2fA==
X-Gm-Message-State: AOJu0Yw2+7sjtcUyIITtgD+uafx1KqI4Qspc9vcPIrZ4/lvoVfnJCyk4
 QkHVi5zUfjlgXECYd25Eo2HISNq0cso9t8xuknvV6HBDyNZKifs416uuWyhX/iLxK9MexQcpIHM
 /iJnUvuhiB4cdXk7s4nqyXHt2gmHMSEwGwJ35AA==
X-Google-Smtp-Source: AGHT+IFYB39MqubqnSYxkevCThBLeBD7gVuBFIK+VlH5oUT7BfbGx/ekxofPhsZ3M8HZYj5scpRSXEOjXeyJlxMw0V0=
X-Received: by 2002:a17:906:da83:b0:a99:77f0:51f7 with SMTP id
 a640c23a62f3a-a99e3e9c139mr217286066b.61.1728730498684; Sat, 12 Oct 2024
 03:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241011153227.81770-1-pbonzini@redhat.com>
In-Reply-To: <20241011153227.81770-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 12 Oct 2024 11:54:47 +0100
Message-ID: <CAFEAcA88y9gV-YMNxvQPdGR2tA-sjsaFYr_TiG=GmQGr8+QkKA@mail.gmail.com>
Subject: Re: [PULL v3 00/18] Rust initial PoC + meson changes for 2024-10-07
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Fri, 11 Oct 2024 at 18:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-04 19:28:37 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 381d2c36e1242f849a55f4622e50b9a69cb92842:
>
>   docs: use consistent markup for footnotes (2024-10-11 13:08:32 +0200)
>
> v2->v3: new patches
> - scripts/archive-source: find directory name for subprojects
> - docs: fix invalid footnote syntax
> - docs: avoid footnotes consisting of just URLs
> - docs: use consistent markup for footnotes
>
> ----------------------------------------------------------------
> * first commit for Rust support
> * add CI job using Fedora + Rust nightly
> * fix detection of ATOMIC128 on x86_64
> * fix compilation with Sphinx 8.1.0
>

Hi; 'make vm-build-openbsd' seems to still fail. It looks
like the wrap file subprojects/unicode-ident-1-rs.wrap says
"directory = unicode-ident-1.0.12" and the script correctly
parses that out of the file, but the directory is actually
named "unicode-ident-1-rs" (differently from the other rust ones),
so we don't find it.


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
/home/peter.maydell/qemu-openbsd/build/vm-test-w7gx56ds.tmp/data-993a1.tar
for src_dir dir: /home/peter.maydell/qemu-openbsd
Download keycodemapdb...
  -> Already downloaded
Download libvfio-user...
  -> Already downloaded
Download berkeley-softfloat-3...
  -> Already downloaded
Download berkeley-testfloat-3...
  -> Already downloaded
Download arbitrary-int-1-rs...
  -> Already downloaded
Download bilge-0.2-rs...
  -> Already downloaded
Download bilge-impl-0.2-rs...
  -> Already downloaded
Download either-1-rs...
  -> Already downloaded
Download itertools-0.11-rs...
  -> Already downloaded
Download proc-macro2-1-rs...
  -> Already downloaded
Download proc-macro-error-1-rs...
  -> Already downloaded
Download proc-macro-error-attr-1-rs...
  -> Already downloaded
Download quote-1-rs...
  -> Already downloaded
Download syn-2-rs...
  -> Already downloaded
Download unicode-ident-1-rs...
  -> Already downloaded
tar: subprojects/unicode-ident-1.0.12: Cannot stat: No such file or directory
tar: Exiting with failure status due to previous errors
failed to append subproject unicode-ident-1-rs to
/home/peter.maydell/qemu-openbsd/build/vm-test-w7gx56ds.tmp/data-993a1.tar
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
'/home/peter.maydell/qemu-openbsd/build/vm-test-w7gx56ds.tmp/data-993a1.tar']'
returned non-zero exit status 1.
make: *** [/home/peter.maydell/qemu-openbsd/tests/vm/Makefile.include:110:
vm-build-openbsd] Error 2
make: Leaving directory '/home/peter.maydell/qemu-openbsd/build'

-- PMM

