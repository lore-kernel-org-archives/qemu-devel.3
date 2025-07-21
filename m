Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629E2C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 19:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwZB-0003yi-SY; Mon, 21 Jul 2025 15:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1udwYx-0003ew-AT
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:52:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1udwYv-0001Lu-0r
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=2iGQR7h0lZdFAXgBDxFVOEj8OkhY2Co3rK4SkodBdWY=; b=PUIFjV9T4Qkyz35pEH1QbbUD/l
 egXOgIgqDJINYGrW3meH8lUoygoUvh61bj2KGxU1kJRxX0eGiUnkHXyYfntJjVqzO4U8KnxEoOaNe
 +gSRUmILB8x5UiWGA5OS0UwoG1tngfqID/rFFe2qdZRrX3ECwGQZwXwsoDafbTDrp5QzPx7wupLzx
 zV90eEO5MB/VXwIv+CrrllS+5k4eVKiIw6QvVG6umTzeQeulUgYug43fety//EI6aHODLBgbMzaUv
 0pBrKFOzJIm6Pp+5igi+iD7H8XtyqiYbKZ1OxkpckgEA6mxHJkJSzM/1lNQos7XGHYFJoQS0HA+Kh
 JjnyynUvnb8UpL57kyqKd96pLRQC5DLcnKb/+a47BWCvsj3X7IIFvDKxDV/jCXVrH3wR7Ok5N3Rzl
 3DpBHfCgD6r0HQOZ4Ns4PjeGppwmLo5VZBVdGuL1m0tohBTFrLckZ+7sbl/43dgfzXKGxbZfKEltn
 WYEaZElZA1OucGu/fdWSgUKeQnbJGIZTuj25y2z1NV/HIvMwhI99xupeZqwRjSIicD7KnYJw3qFFK
 XQJbfzQ3mHrP8bP4Qu0mBfLRW+hg4oSWC+1xSUX02tTlDrldBmrk2iUF7gJrfPMOMsGEK2cbdvDhh
 U5DBzU0rd5U2Mibx0+vaaxwG/4/0mXiYKR8OI2D8E=;
Received: from [2a02:8012:2f01:0:a5c6:e422:a021:febf]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1udwXC-00017z-Gr; Mon, 21 Jul 2025 20:50:50 +0100
Message-ID: <f963b054-282c-4f3f-9a28-f0e56e433a1a@ilande.co.uk>
Date: Mon, 21 Jul 2025 20:52:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250716105414.2330204-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20250716105414.2330204-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:a5c6:e422:a021:febf
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [RFC PATCH 0/6] Fix building of sparc/sparc32plus test cases
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 16/07/2025 11:54, Alex Bennée wrote:

> We didn't have any reliable way to build sparc test cases. I have
> found someone who ships a compiler but the binaries still don't run
> due to the need for CASA.
> 
> I'm posting mainly for those who actually care who might want to fix
> up the remaining cases.
> 
> Alex.
> 
> Alex Bennée (6):
>    tests/tcg: special case sparc test cases
>    tests/tcg: special case sparc32plus test cases
>    configure: update sparc and sparc32plus target compiler detection
>    tests/docker: add sparc-leon-cross container image
>    configure: enable the container fallbacks for sparc/sparc32plus
>    docs/about: deprecate add sparc/sparc32plus-*-user
> 
>   docs/about/deprecated.rst                     |  8 ++++
>   configure                                     | 11 ++++-
>   .../dockerfiles/sparc-leon-cross.docker       | 40 +++++++++++++++++
>   tests/tcg/Makefile.target                     |  9 ++--
>   tests/tcg/sparc/Makefile.target               | 45 +++++++++++++++++++
>   tests/tcg/sparc32plus                         |  1 +
>   6 files changed, 108 insertions(+), 6 deletions(-)
>   create mode 100644 tests/docker/dockerfiles/sparc-leon-cross.docker
>   create mode 100644 tests/tcg/sparc/Makefile.target
>   create mode 120000 tests/tcg/sparc32plus

For reference: I did some experiments here to find out what was happening, and the 
problem is that glibc dropped support for sparcv8 some time ago. This leaves the 
SPARC 32-bit default implementation being that for the LEON cpu which *does* include 
the cas instruction and therefore it can appear in the output binary.

As an experiment I set up a new repository at 
https://github.com/mcayland/sparc-linux-cross/ containing a Dockerfile that can build 
a suitable toolchain using an older glibc, along with the final container at 
ghcr.io/mcayland/sparc-linux-cross. Using this I can get much further with the tcg tests:

make -C tests/tcg/sparc-linux-user  SPEED=quick run
make[2]: Entering directory 
'/home/mca/src/upstream/qemu/build/tests/tcg/sparc-linux-user'
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  catch-syscalls >  catch-syscalls.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  float_convd >  float_convd.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  float_convs >  float_convs.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  float_madds >  float_madds.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  fnmsub >  fnmsub.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  follow-fork-mode >  follow-fork-mode.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  late-attach >  late-attach.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  munmap-pthread >  munmap-pthread.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  overflow >  overflow.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  prot-none >  prot-none.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  segfault >  segfault.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  sha1 >  sha1.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  sha512 >  sha512.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  sigbus >  sigbus.out
   SKIPPED signals is broken on sparc because
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  sigreturn-sigmask >  sigreturn-sigmask.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  test-mmap >  test-mmap.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  test-plugin-mem-access > 
test-plugin-mem-access.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  testthread >  testthread.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  threadcount >  threadcount.out
   SKIPPED vma-pthread is broken on sparc because
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  linux-madvise >  linux-madvise.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  linux-shmat-maps >  linux-shmat-maps.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  linux-shmat-null >  linux-shmat-null.out
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  linux-sigrtminmax >  linux-sigrtminmax.out
   SKIPPED linux-test is broken on sparc because
timeout -s KILL --foreground 120  env 
QEMU=/home/mca/src/upstream/qemu/build/qemu-sparc 
/home/mca/src/upstream/qemu/build/qemu-sparc  test-vma >  test-vma.out
make[2]: Leaving directory '/home/mca/src/upstream/qemu/build/tests/tcg/sparc-linux-user'
make[1]: Leaving directory '/home/mca/src/upstream/qemu/build'


Using this there are 3 tests that are broken. The signals and vma-pthread tests are 
caused by the use of -latomic during linking, and closer examination shows that 
despite using sparcv8, libatomic is still being built as sparcv8plus in the container:

root@46da5c5071f0:/opt/local/sparc-linux-gnu/lib# file libatomic.so.1.2.0
libatomic.so.1.2.0: ELF 32-bit MSB shared object, SPARC32PLUS, V8+ Required, total 
store ordering, version 1 (SYSV), dynamically linked, with debug_info, not stripped

This could also be due to the use of atomic instructions only available on some more 
modern CPUs.

In summary it seems that things aren't completely broken, but certainly there is some 
concern that sparcv8 support does not appear to be being actively tested within the 
current toolchain, and could possibly disappear at some point as it already has done 
with glibc.


ATB,

Mark.


