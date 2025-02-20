Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525B7C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 11:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4OG-0004Ey-Ao; Thu, 20 Feb 2025 06:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tl4O5-0004A3-Md
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:06:38 -0500
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tl4O3-0002sE-Po
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:06:37 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MlNgx-1t43aX3R5Z-00izXL; Thu, 20 Feb 2025 12:06:32 +0100
Message-ID: <04cc2da6-ceb2-4795-8abb-4b3079d74a1f@vivier.eu>
Date: Thu, 20 Feb 2025 12:06:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] binfmt: Add --ignore-family option
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 David Abdurachmanov <davidlt@rivosinc.com>
References: <20250127182924.103510-1-abologna@redhat.com>
 <20250127182924.103510-4-abologna@redhat.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20250127182924.103510-4-abologna@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Xj23iby/1tOjKzV220LrZR6/VEMTRo8TrD1WZ0E36qLqBkkFE2E
 qv2UY5qpg6mlWGAhEuSZ83ESjn2a6tKq5WJomdYunsaRUViJ9mYnBl+c6VsIg0QmX6whuP4
 jnExAOT7ytmFtPJ5utTpksFSmWqB5lP+ejVWQ82vO6QBCfgWOJ0CDLm0luISr6qQS5xbpo5
 9M6wIvXeW9nDTzERH6S6Q==
UI-OutboundReport: notjunk:1;M01:P0:pPgqzNZ12Zc=;kB+ALGVHjlxs2CUTsc+4u72nHSi
 jN6j6qmZjqMnilNvbgISl1f+q8PRSGMMNWrQgxaRAOjCBPG7WfeaB4XpxU8VwB/hKDloocgh+
 zy98cia8YLsyBitUW3rvAluKEkb/Z3FcYyby5g8ybi9O7DWP0LVm/So6uYmVdyEY+SVdo9KFT
 Fe2UIqjRyyvTTUgHl0j1TQHxRgiV6Gk6g5WjtlhmmM2Ns0AEhvYSkhQuF/vjXzQp/p5kL2ICv
 GhWa1oaWI5brgC48lAUim9dnsnCeR2qSxfgollif60sSq4ZyIo+SBLoNWyouxGKhVeva4TPlt
 +Iats6GopWZ12JYrLuKUdlzjTdhWMNX63wBIuNqkck2ZZWHaHbpG23iTwQEmbljYN3JGy9bMK
 /DTfMhAbo1npy3K8uhzntCaqj313kiOB1NP0bWgmvRzeqw4BYchGIelecTu8m4m1AM5sIKAqM
 SO2mfkBCajv3CpRPztBV8IRxEjpZENdj9SK+uWv20hJHasSEKM6EDcMD3iXRTyf3ZVneCwbBj
 zZzAfSyExj/1UlQq2q53dDeMKmSuy2itzGz9ibfj0DjWXrk87l+w41qbLOOeRNfCz2YMNyDoC
 kq+G4nBsOYFJfBTMVfdmVXytyv8AVdM6Do534qTSTTqgbw8YXQGLFji1m2/6HTSUXxWERpd7R
 sPE9p5y5dp6Qej0uxAIEBP4+qtHTEo+EVL/hhYugavywq3bXXXiu1skxGE+ryaG3qwfFRtYPF
 TMO6BJOWWi+sSL1nwd7tzjlIBNwc/zcRT0XRcrIK/jzt/NuJwnWIq/6BVUqil/b50mmP86VLM
 6YXnxUOUae3vcq6b7RBn5mD80iuOzndTXCdLWUMT8vmILA+N6yfIdYNfUK0QLPmYPuL8M0vC/
 dIzhCt+lRgBOVUHAgCBfawMXpW1c6pbMrWfwropNFfX21Xv6dXJv93Mfs9AyhurNzoZa73dfm
 4cSPzC9eDx3MfOpd8YXhyC8CtT88AjxRJb7/l5Q4AtDxXu025tI/J+HQUOYqWaVNPozPICu5e
 2ool3Y8CeDvPJMxEl4R/jSvM1ldK+EfLXGlY3avHSSfym1AdZHScyoKied5r6L5FY+3Gz/oVU
 ag8YcXXDNI7nv+TltTtGvVUGFeaCWY53c1wAzfXpvJmHtl2d58VroEXn2QGEbgRxaE01qePwn
 0KgSUkOE0F5zdpBdyzYg/9GjPFoM1OWa8+PCSuHyZFtKMdovuslxrewJShzY1aXHuLyyLbFLY
 9nn3e1+hsiGiyAX4xyT/u3o5pbSBgTGBV0XHNLMqJJRX8QXhYmNMr6aTMl2kxn8Y2jvqja6gC
 LsNWwS5qjXb5oU3pnZcLWzfqZdO2xL9RYD95XFqhx6h1meykgrt7/+fwHXn0r1WkQ4n
Received-SPF: pass client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Le 27/01/2025 à 19:29, Andrea Bolognani a écrit :
> Until now, the script has worked under the assumption that a
> host CPU can run binaries targeting any CPU in the same family.
> That's a fair enough assumption when it comes to running i386
> binaries on x86_64, but it doesn't quite apply in the general
> case.
> 
> For example, while riscv64 CPUs could theoretically run riscv32
> applications natively, in practice there exist few (if any?)
> CPUs that implement the necessary silicon; moreover, even if you
> had one such CPU, your host OS would most likely not have
> enabled the necessary kernel bits.
> 
> This new option gives distro packagers the ability to opt out of
> the assumption, likely on a per-architecture basis, and make
> things work out of the box for a larger fraction of their user
> base.
> 
> As an interesting side effect, this makes it possible to enable
> execution of 64-bit binaries on 32-bit CPUs of the same family,
> which is a perfectly valid use case that apparently hadn't been
> considered until now.
> 
> Link: https://src.fedoraproject.org/rpms/qemu/pull-request/72
> Thanks: David Abdurachmanov <davidlt@rivosinc.com>
> Thanks: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> ---
>   scripts/qemu-binfmt-conf.sh | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 8d9136a29f..5fd462b1d1 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -205,6 +205,9 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
>          --persistent:    if yes, the interpreter is loaded when binfmt is
>                           configured and remains in memory. All future uses
>                           are cloned from the open file.
> +       --ignore-family: if yes, it is assumed that the host CPU (e.g. riscv64)
> +                        can't natively run programs targeting a CPU that is
> +                        part of the same family (e.g. riscv32).
>          --preserve-argv0 preserve argv[0]
>   
>       To import templates with update-binfmts, use :
> @@ -337,7 +340,12 @@ qemu_set_binfmts() {
>           fi
>   
>           if [ "$host_family" = "$family" ] ; then
> -            continue
> +            # When --ignore-family is used, we have to generate rules even
> +            # for targets that are in the same family as the host CPU. The
> +            # only exception is of course when the CPU types exactly match
> +            if [ "$target" = "$host_cpu" ] || [ "$IGNORE_FAMILY" = "no" ] ; then
> +                continue
> +            fi
>           fi
>   
>           $BINFMT_SET
> @@ -355,10 +363,11 @@ CREDENTIAL=no
>   PERSISTENT=no
>   PRESERVE_ARG0=no
>   QEMU_SUFFIX=""
> +IGNORE_FAMILY=no
>   
>   _longopts="debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,\
> -persistent:,preserve-argv0:"
> -options=$(getopt -o ds:Q:S:e:hc:p:g:F: -l ${_longopts} -- "$@")
> +persistent:,preserve-argv0:,ignore-family:"
> +options=$(getopt -o ds:Q:S:e:hc:p:g:F:i: -l ${_longopts} -- "$@")
>   eval set -- "$options"
>   
>   while true ; do
> @@ -418,6 +427,10 @@ while true ; do
>           shift
>           PRESERVE_ARG0="$1"
>           ;;
> +    -i|--ignore-family)
> +        shift
> +        IGNORE_FAMILY="$1"
> +        ;;
>       *)
>           break
>           ;;

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

