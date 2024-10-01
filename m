Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFD6CEACDD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfMx-0002nh-To; Tue, 01 Oct 2024 12:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1svfMt-0002l2-Sq
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:04:57 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1svfMs-0001wK-4Y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:04:55 -0400
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MOhx9-1sXbip0kdr-00Iuc8; Tue, 01 Oct 2024 11:29:28 +0200
Message-ID: <a5cd9528-9ffa-4042-9686-4453ffd7c006@vivier.eu>
Date: Tue, 1 Oct 2024 11:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] linux-user: add strace support for openat2
To: Michael Vogt <mvogt@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1727715697.git.mvogt@redhat.com>
 <4e65ab27fa0eda54034299802cb176ce78db9091.1727715697.git.mvogt@redhat.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <4e65ab27fa0eda54034299802cb176ce78db9091.1727715697.git.mvogt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dK6i+dMSzzsH1Ugt6uBw4b6jhvcscQHR1WGm7QlXqMuCX0eJFPM
 eDWQa0l6++2vOv2Jet3bk9TEnPfK6zH+KR2S1uzvo/GdwBtwDSbLLCNhmPHOtEsipIq5wJJ
 hzJ9yJo7l+SCiRJxK9o4Mwhpk44b0BWyBFvSXEvPatKmVXzxc+0pLDEgX+kFtaK1k/xi/mV
 QAdBXTmURjlYf+QHvdR4Q==
UI-OutboundReport: notjunk:1;M01:P0:74c1Z7GJeBg=;EaeZouY096c/9kNr7hiBTEsWsX/
 n8hRKW0SrPDKYDO1YluF8uGutCX4Eiz2arn0C8UTQdJ4viARB2LCpfpbJ2UQs9K1ImS8ItTKf
 L3oBcn8WwDBO+JAcq3a+gpkiJVzKedD/9RG+m79r5aK9fWJEPMMiAqDrZXRLEwFu1u0Y7C0Et
 obPGddUOjfXy0w2/qkfz89J9IGhUSm/hMvR6Yep/kmr/DSZX/ljAp3nYtmTKlyVaGY+nu0RSI
 E5knnQu8QgBKiA0uJvUulUdtLEQUOgyKxX9yIPmrjjZzyc4GL9I59eL6h7ink6k+TusM+NT/u
 qZI9s/wZ0P+YPsRGREN4YeJPyHAHlkCXYcToRBPHC7TmSRWN+0hua47L8X6W3ml0CHxYdr+bl
 m2jtaVbZk8bsmyjrIMaGBmFAdWlb+XYFNcH7hpga3GVW7SSBh3TEWIlLKnDldcQgGJoxf4hWg
 G7MHRQd3Ia0LbnZYwaLFYska7fahEZIR+5gWdmH6fGMpuws5qonIn6mny4ADybl7DpRpen4ZE
 nIkBq/OpUiCVKEvwu/LZqDxb641rMh4Gqth0qIzBpHwOJFlR5r3fyKnbazJN4u2aIT0K+/+WI
 eFh0uW6yh36DIOK4IqfhmzxHm7Su+775s6n0uQQ5udNzQGFIWQRkEoLAOtt2U9RK4Pa6bPjtU
 erMUGSEMFxRq+IQ8bEUPASTzISh0qjkQaZE/OlSffoxzXF9ewpauyMcwCqGdSLx0hqc9NuKSG
 VZnOHslivOxSQCzYKDIVEcqaob6Kx+dCQ==
Received-SPF: pass client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Le 30/09/2024 à 19:07, Michael Vogt a écrit :
> This commit adds support for the `openat2()` to `QEMU_STRACE`. It
> will use the `openat2.h` header if available to create user
> readable flags for the `resolve` argument but does not require
> the header otherwise.
> 
> It also makes `copy_struct_from_user()` available via `qemu.h`
> and `open_how_ver0` via `syscall_defs.h` so that strace.c can use
> them.
> 
> Signed-off-by: Michael Vogt <mvogt@redhat.com>
> ---
>   linux-user/qemu.h         |  9 +++++++++
>   linux-user/strace.c       | 40 +++++++++++++++++++++++++++++++++++++++
>   linux-user/strace.list    |  3 +++
>   linux-user/syscall.c      |  8 +-------
>   linux-user/syscall_defs.h |  5 +++++
>   meson.build               |  1 +
>   6 files changed, 59 insertions(+), 7 deletions(-)
...
> index b4d1098170..42a34e599d 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
...
> +#ifdef TARGET_NR_openat2
> +static void
> +print_openat2(CPUArchState *cpu_env, const struct syscallname *name,
> +              abi_long arg0, abi_long arg1, abi_long arg2,
> +              abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    struct open_how_ver0 how = {0};
> +
> +    print_syscall_prologue(name);
> +    print_at_dirfd(arg0, 0);
> +    print_string(arg1, 0);
> +    if (copy_struct_from_user(&how, sizeof(how), arg2, arg3) == 0) {
> +        print_open_flags(how.flags, 0);
> +        if (how.flags & TARGET_O_CREAT) {
> +            print_file_mode(how.mode, 0);
> +        }
> +        print_flags(openat2_resolve_flags, how.resolve, 0);

A tswap64() is needed with how.flags, how.mode and how.resolve.
(they use guest endianness, and print functions use host endianness)

Thanks,
Laurent


