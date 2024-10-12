Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFF4CF2568
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 14:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szchW-0002Zm-Mu; Sat, 12 Oct 2024 10:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szchT-0002Ze-TN
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 10:02:32 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szchR-0006Ep-TI
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 10:02:31 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c95a962c2bso1007796a12.2
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728741748; x=1729346548; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K7pmsHaLUG5d9DOmfDbeYFCj16FD89Y17saK2WNiUyI=;
 b=VZOkNHysjccq3zMok2TlfpEqdcG56MxSkBx/hp/CYAIvnjcqZ+nd27mJOG1uc71u/D
 s0wuJM+OzD+zJj4O8Z1o+K5AQ19YWAM7SL+LBtb60Ox2Xz8htanAYLRSqskEsUkyQGyS
 SPUgvNiAZ6S68n5QmH/Jeuvlvr3/klOkhXf2dXU8A0XoGsPdU/KVLp8d7jUX623aF8B8
 slFUyAd4EHvAhfpwPnD4FRd/8I93dLCF4aanQa3JGH1+OSFdFtCzAugoB+6qrOpu4xHL
 KIICVGg1M/Jf1QaJMM8peAc/Df8gQeG3KAZZvraaWvdczWlZvPLsRdPnjvpZ5hoCD9rW
 ncGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728741748; x=1729346548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K7pmsHaLUG5d9DOmfDbeYFCj16FD89Y17saK2WNiUyI=;
 b=oAtoVRPXHJetSgreoJBnCwKLKptKRyTArTaXkfKRWV+rA+1mMK6U4gzoi+jnXPYYtn
 li1hheUuB2TlIYG3+SyF1BCTFAChdyfJwm3Tj/gk2YVUU6ZssCGUPT7Q3qYyvDudZDG+
 XYSIcFnv8cwpAM0l5T7mZLi/7CzYn6Ti34JRctsp0RyTPTmXjEBv8Zs9NtWbCnbp8dWc
 VOfEp+GUvJOfZy+fvKnnIo9eyfhxRBaZ7wOK5Cf5GnSSQKNO/RMpv08jLIrIi6Y6459V
 kClVrlWjfeAvR3wxeNOEp+S3KR70xM0ecb2BzMuBzPoqStk9+4oSW63gr61XVm2LOKhR
 kSyw==
X-Gm-Message-State: AOJu0Yx0hnCTtkq65WeeHZ1IVev+xan8CCexeoM4NwYdT58CkqBc4jtJ
 49f1AtM1vFUJqrU53gXUB67F7OKIRRM3pz0X5HVZ7I5S2L9baaZrfANuK7ojo6QljyYXp8UM35r
 HdD8BpcvZeN9LFAlC3sV7NUXpLXCRk8FBmhFEdw==
X-Google-Smtp-Source: AGHT+IHturYe7bOUDJpQOOXqLcEBBsJce5E/C1yXO+Lh8Wv2qmDfqKPoVNpiY3NXEvxNEDA26jJjbux9PadesqBSqeE=
X-Received: by 2002:a05:6402:5188:b0:5c9:59e6:e908 with SMTP id
 4fb4d7f45d1cf-5c959e6f56amr2304735a12.6.1728741747812; Sat, 12 Oct 2024
 07:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241011153227.81770-1-pbonzini@redhat.com>
 <CAFEAcA88y9gV-YMNxvQPdGR2tA-sjsaFYr_TiG=GmQGr8+QkKA@mail.gmail.com>
In-Reply-To: <CAFEAcA88y9gV-YMNxvQPdGR2tA-sjsaFYr_TiG=GmQGr8+QkKA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 12 Oct 2024 15:02:15 +0100
Message-ID: <CAFEAcA9vXEexRC4kZWEXoyMHQm_M33NRuZnSi7hq2wdPyCVGNQ@mail.gmail.com>
Subject: Re: [PULL v3 00/18] Rust initial PoC + meson changes for 2024-10-07
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sat, 12 Oct 2024 at 11:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 11 Oct 2024 at 18:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:
> >
> >   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-04 19:28:37 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 381d2c36e1242f849a55f4622e50b9a69cb92842:
> >
> >   docs: use consistent markup for footnotes (2024-10-11 13:08:32 +0200)
> >
> > v2->v3: new patches
> > - scripts/archive-source: find directory name for subprojects
> > - docs: fix invalid footnote syntax
> > - docs: avoid footnotes consisting of just URLs
> > - docs: use consistent markup for footnotes
> >
> > ----------------------------------------------------------------
> > * first commit for Rust support
> > * add CI job using Fedora + Rust nightly
> > * fix detection of ATOMIC128 on x86_64
> > * fix compilation with Sphinx 8.1.0
> >
>
> Hi; 'make vm-build-openbsd' seems to still fail. It looks
> like the wrap file subprojects/unicode-ident-1-rs.wrap says
> "directory = unicode-ident-1.0.12" and the script correctly
> parses that out of the file, but the directory is actually
> named "unicode-ident-1-rs" (differently from the other rust ones),
> so we don't find it.
>
>
> make: Entering directory '/home/peter.maydell/qemu-openbsd/build'
> /home/peter.maydell/qemu-openbsd/build/pyvenv/bin/meson introspect
> --targets --tests --benchmarks |
> /home/peter.maydell/qemu-openbsd/build/pyvenv/bin/python3 -B
> scripts/mtest2make.py > Makefile.mtest
> { \
>   echo 'ninja-targets = \'; \
>   /usr/bin/ninja -t targets all | sed 's/:.*//; $!s/$/ \\/'; \
>   echo 'build-files = \'; \
>   /usr/bin/ninja -t query build.ninja | sed -n '1,/^  input:/d; /^
> outputs:/q; s/$/ \\/p'; \
> } > Makefile.ninja.tmp && mv Makefile.ninja.tmp Makefile.ninja
> /home/peter.maydell/qemu-openbsd/build/pyvenv/bin/python3 -B
> /home/peter.maydell/qemu-openbsd/tests/vm/openbsd  --debug
> --genisoimage /usr/bin/genisoimage    --source-path
> /home/peter.maydell/qemu-openbsd --image
> "/home/peter.maydell/.cache/qemu-vm/images/openbsd.img"  --build-image
> /home/peter.maydell/.cache/qemu-vm/images/openbsd.img
> Image file exists, skipping build:
> /home/peter.maydell/.cache/qemu-vm/images/openbsd.img
> Use --force option to overwrite
> /home/peter.maydell/qemu-openbsd/build/pyvenv/bin/python3 -B
> /home/peter.maydell/qemu-openbsd/tests/vm/openbsd  --debug  --jobs 8
> --verbose    --image
> "/home/peter.maydell/.cache/qemu-vm/images/openbsd.img"  --snapshot
> --build-qemu /home/peter.maydell/qemu-openbsd --
> DEBUG:root:Creating archive
> /home/peter.maydell/qemu-openbsd/build/vm-test-w7gx56ds.tmp/data-993a1.tar
> for src_dir dir: /home/peter.maydell/qemu-openbsd
> Download keycodemapdb...
>   -> Already downloaded
> Download libvfio-user...
>   -> Already downloaded
> Download berkeley-softfloat-3...
>   -> Already downloaded
> Download berkeley-testfloat-3...
>   -> Already downloaded
> Download arbitrary-int-1-rs...
>   -> Already downloaded
> Download bilge-0.2-rs...
>   -> Already downloaded
> Download bilge-impl-0.2-rs...
>   -> Already downloaded
> Download either-1-rs...
>   -> Already downloaded
> Download itertools-0.11-rs...
>   -> Already downloaded
> Download proc-macro2-1-rs...
>   -> Already downloaded
> Download proc-macro-error-1-rs...
>   -> Already downloaded
> Download proc-macro-error-attr-1-rs...
>   -> Already downloaded
> Download quote-1-rs...
>   -> Already downloaded
> Download syn-2-rs...
>   -> Already downloaded
> Download unicode-ident-1-rs...
>   -> Already downloaded
> tar: subprojects/unicode-ident-1.0.12: Cannot stat: No such file or directory
> tar: Exiting with failure status due to previous errors
> failed to append subproject unicode-ident-1-rs to
> /home/peter.maydell/qemu-openbsd/build/vm-test-w7gx56ds.tmp/data-993a1.tar
> Failed to prepare guest environment
> Traceback (most recent call last):
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/basevm.py", line 654, in main
>     vm.add_source_dir(args.build_qemu)
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/basevm.py", line
> 277, in add_source_dir
>     subprocess.check_call(["./scripts/archive-source.sh", tarfile],
>   File "/usr/lib/python3.10/subprocess.py", line 369, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command
> '['./scripts/archive-source.sh',
> '/home/peter.maydell/qemu-openbsd/build/vm-test-w7gx56ds.tmp/data-993a1.tar']'
> returned non-zero exit status 1.
> make: *** [/home/peter.maydell/qemu-openbsd/tests/vm/Makefile.include:110:
> vm-build-openbsd] Error 2
> make: Leaving directory '/home/peter.maydell/qemu-openbsd/build'

Deleting the whole subprojects/unicode-ident-1-rs/ subdirectory
seems to have fixed this -- it then realised it needed to
do the download and put it in the right place. I guess that was a
leftover from trying to build the previous version of the pullreq.
But it suggests that something is missing in the dependencies,
since it thought it had already downloaded it even though
the directory it needed to put it in wasn't on disk...

thanks
-- PMM

