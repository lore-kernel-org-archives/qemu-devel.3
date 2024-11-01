Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53D2E6F062
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 14:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6swP-0001Ac-Ng; Fri, 01 Nov 2024 10:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1t6swM-0001AH-Ie
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:47:55 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1t6swJ-0004r1-73
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:47:54 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e30116efc9so1621139a91.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730472468; x=1731077268;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsqzIOBSxzJIiuj59PaLwpaBuYqHWfQRZrBmGVh6rD8=;
 b=CB2KA8B7Ic6jH52sZS05QpN6R51j1j1t962jdy68cHf/faF2Eae91gMcuBd41kAzIM
 ZxdSMzuBzJCCvQ/EvuT2iYzRQv7fPpUt3zAWKnHnlRODt0JAmiJVuo0AgwisZjA+Wk+l
 ydzoBUpZ3POPdsa53x2hXonTiyePaJncowHyhgwh5iazP+oqbsavdaZ/ue2F7ucK6MwK
 dQeFTnkbTlLDqY3aOvSyT2N+AnHkFu6PE3YTOZcYL62hFXi02cZQFbZR4pg/MKXL0KtI
 3PbIhe7NvhTkiJF3i2MQaRD8Cjg3jKABPncmGpEaHe+1OizYmnPgSIz/C84UhUbznrXN
 a73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730472468; x=1731077268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KsqzIOBSxzJIiuj59PaLwpaBuYqHWfQRZrBmGVh6rD8=;
 b=qmgK0zDpuq0DH+XOWlaJQ0EEU4YGpnST7t2YN8HjqDlwZKza8girEKqUEqDuwk0Ut4
 upWtn37uwQ2ae6ooLqm59JXn4KFkIXoQyXdeGVYX8g0SjGfwyXe0v2QhnyNzfEWhiqPh
 KlY4LRRhZqW3Zq1M25G0BfJPR3nrLirFCP78YNgqec/CuXEnCIirMzbVhEnHOpJJeLsz
 1/CeT+QamiAXZYimrSZXv9rVNRaREVWAGxPAeHcvKWea3BP4h4T0c4vXuItwzh3gDppp
 /ZD0c/n200IpIM1fm2ZR0EfGQC/iI6eHhLB+36JJmgy/D/oH0bdjRPIizPqbQ7gx6U+l
 8fvw==
X-Gm-Message-State: AOJu0Yzm9irMGmH+NzdZYrqhX7lgnUPMER1Nw2kKdRISUJ0fHWZltjvY
 7LYnEY4D5LS8YfnfxiL3Hd+uMQhCDnYsfl6zmLMy4TymViCa+OV8dLchAKjsO+JdzUoayy/xd66
 3rZevYYku8rl2PPg43fkoeatO4SiU2RwUbKI7K81G3UUp/yHqng==
X-Google-Smtp-Source: AGHT+IEDxKLcKIKRu+yHCi7ytBe4Dt0mVCSI2+cw7uj0WGemxtuSSUdsWxl4IinW50riVhKi5SVyO2EuO/8lmEGSahg=
X-Received: by 2002:a17:90a:4802:b0:2cf:fe5d:ea12 with SMTP id
 98e67ed59e1d1-2e8f1073b73mr24960529a91.24.1730472468013; Fri, 01 Nov 2024
 07:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241031105718.110080-1-pbonzini@redhat.com>
In-Reply-To: <20241031105718.110080-1-pbonzini@redhat.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Fri, 1 Nov 2024 15:47:36 +0100
Message-ID: <CAGCz3vt+ZiMwsV6ET0pkEZu6kQKibowCdXCc7HVw9aYvrJYHbw@mail.gmail.com>
Subject: Re: [PATCH] target/i386/hvf: fix handling of XSAVE-related CPUID bits
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2607:f8b0:4864:20::1032;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

Paolo,

I've just manually tested this, also including some debug output, and
that looks good to me. I've got some concerns about edge cases though,
see comments inline.

On Thu, 31 Oct 2024 at 11:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The call to xgetbv() is passing the ecx value for cpuid function 0xD,
> index 0. The xgetbv call thus returns false (OSXSAVE is bit 27, which is
> well out of the range of CPUID[0xD,0].ECX) and eax is not modified. While
> fixing it, cache the whole computation of supported XCR0 bits since it
> will be used for more than just CPUID leaf 0xD.
>
> Furthermore, unsupported subleafs of CPUID 0xD (including all those
> corresponding to zero bits in host's XCR0) must be hidden; if OSXSAVE
> is not set at all, the whole of CPUID leaf 0xD plus the XSAVE bit must
> be hidden.
>
> Finally, unconditionally drop XSTATE_BNDREGS_MASK and XSTATE_BNDCSR_MASK;
> real hardware will only show them if the MPX bit is set in CPUID;
> this is never the case for hvf_get_supported_cpuid() because QEMU's
> Hypervisor.framework support does not handle the VMX fields related to
> MPX (even in the unlikely possibility that the host has MPX enabled).
> So hide those bits in the new cache_host_xcr0().

The commit message is much more helpful now, thank you.

> Supersedes: <20241029130401.525297-1-pbonzini@redhat.com>
> Cc: Phil Dennis-Jordan <lists@philjordan.eu>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  host/include/i386/host/cpuinfo.h |  1 +
>  target/i386/hvf/x86_cpuid.c      | 56 +++++++++++++++++++-------------
>  util/cpuinfo-i386.c              |  1 +
>  3 files changed, 35 insertions(+), 23 deletions(-)
>
> diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cp=
uinfo.h
> index 81771733eaa..9541a64da61 100644
> --- a/host/include/i386/host/cpuinfo.h
> +++ b/host/include/i386/host/cpuinfo.h
> @@ -9,6 +9,7 @@
>  /* Digested version of <cpuid.h> */
>
>  #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
> +#define CPUINFO_OSXSAVE         (1u << 1)
>  #define CPUINFO_MOVBE           (1u << 2)
>  #define CPUINFO_LZCNT           (1u << 3)
>  #define CPUINFO_POPCNT          (1u << 4)
> diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
> index e56cd8411ba..3a116548a3d 100644
> --- a/target/i386/hvf/x86_cpuid.c
> +++ b/target/i386/hvf/x86_cpuid.c
> @@ -21,28 +21,38 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/cpuid.h"
> +#include "host/cpuinfo.h"
>  #include "cpu.h"
>  #include "x86.h"
>  #include "vmx.h"
>  #include "sysemu/hvf.h"
>  #include "hvf-i386.h"
>
> -static bool xgetbv(uint32_t cpuid_ecx, uint32_t idx, uint64_t *xcr)
> +static bool cached_xcr0;
> +static uint64_t supported_xcr0;
> +
> +static void cache_host_xcr0()

Nit: Should be (void) parameter list, not empty.

>  {
> -    uint32_t xcrl, xcrh;
> -
> -    if (cpuid_ecx & CPUID_EXT_OSXSAVE) {
> -        /*
> -         * The xgetbv instruction is not available to older versions of
> -         * the assembler, so we encode the instruction manually.
> -         */
> -        asm(".byte 0x0f, 0x01, 0xd0" : "=3Da" (xcrl), "=3Dd" (xcrh) : "c=
" (idx));
> -
> -        *xcr =3D (((uint64_t)xcrh) << 32) | xcrl;
> -        return true;
> +    if (cached_xcr0) {
> +        return;
>      }
>
> -    return false;
> +    if (cpuinfo & CPUINFO_OSXSAVE) {
> +        uint64_t host_xcr0 =3D xgetbv_low(0);
> +
> +        /* Only show xcr0 bits corresponding to usable features.  */
> +        supported_xcr0 =3D host_xcr0 & (XSTATE_FP_MASK |
> +                                      XSTATE_SSE_MASK | XSTATE_YMM_MASK =
|
> +                                      XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi=
256_MASK |
> +                                      XSTATE_Hi16_ZMM_MASK);
> +        if ((supported_xcr0 & (XSTATE_FP_MASK | XSTATE_SSE_MASK)) !=3D
> +            (XSTATE_FP_MASK | XSTATE_SSE_MASK)) {
> +            supported_xcr0 =3D 0;
> +        }
> +    }
> +
> +    cached_xcr0 =3D true;
>  }
>
>  uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
> @@ -51,6 +61,7 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_=
t idx,
>      uint64_t cap;
>      uint32_t eax, ebx, ecx, edx;
>
> +    cache_host_xcr0();
>      host_cpuid(func, idx, &eax, &ebx, &ecx, &edx);
>
>      switch (func) {
> @@ -66,7 +77,8 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_=
t idx,
>          ecx &=3D CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 =
|
>               CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
>               CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_MOVBE |
> -             CPUID_EXT_POPCNT | CPUID_EXT_AES | CPUID_EXT_XSAVE |
> +             CPUID_EXT_POPCNT | CPUID_EXT_AES |
> +             (supported_xcr0 ? CPUID_EXT_XSAVE : 0) |
>               CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND;
>          ecx |=3D CPUID_EXT_HYPERVISOR;
>          break;
> @@ -107,16 +119,14 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uin=
t32_t idx,
>          eax =3D 0;
>          break;
>      case 0xD:
> +        if (!supported_xcr0 ||
> +            (idx > 1 && !(supported_xcr0 & (1 << idx)))) {

If I'm not mistaken, we have undefined behaviour here for idx > 30?
(Literal 1 is int, left shift by 31 or more is undefined)

Based on a quick reading of Intel's SDM section 13.2, only idx <63 are
specified. So perhaps the condition should be:

if (!supported_xcr0 || idx >=3D 63 || (idx > 1 && !(supported_xcr0 &
(UINT64_C(1) << idx)))) {

> +            eax =3D ebx =3D ecx =3D edx =3D 0;
> +            break;
> +        }
> +
>          if (idx =3D=3D 0) {
> -            uint64_t host_xcr0;
> -            if (xgetbv(ecx, 0, &host_xcr0)) {
> -                uint64_t supp_xcr0 =3D host_xcr0 & (XSTATE_FP_MASK |
> -                                  XSTATE_SSE_MASK | XSTATE_YMM_MASK |
> -                                  XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MA=
SK |
> -                                  XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_=
MASK |
> -                                  XSTATE_Hi16_ZMM_MASK);
> -                eax &=3D supp_xcr0;
> -            }
> +            eax =3D supported_xcr0;
>          } else if (idx =3D=3D 1) {
>              hv_vmx_read_capability(HV_VMX_CAP_PROCBASED2, &cap);
>              eax &=3D CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1;

Not actually part of your patch, but I've just been reading around
this code to make sense of the patch, and it seems like the existing
idx =3D=3D 1 case is also buggy. At the end of the above snippet (eax &=3D
=E2=80=A6), eax can at most be 0x3. The two subsequent lines,

            if (!(cap & CPU_BASED2_XSAVES_XRSTORS)) {
                eax &=3D ~CPUID_XSAVE_XSAVES;

Are therefore effectively a no-op, I believe? Should the line,

eax &=3D CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1;

therefore perhaps be,

eax &=3D CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES;

?

(I have to admit I'm no expert on the XSAVE mechanism, so I'm mostly
going by how this code would make the most sense, not by Intel's
spec.)

> diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
> index 90f92a42dc8..c8c8a1b3705 100644
> --- a/util/cpuinfo-i386.c
> +++ b/util/cpuinfo-i386.c
> @@ -35,6 +35,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void=
)
>          __cpuid(1, a, b, c, d);
>
>          info |=3D (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
> +        info |=3D (c & bit_OSXSAVE ? CPUINFO_OSXSAVE : 0);
>          info |=3D (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
>          info |=3D (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
>          info |=3D (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
> --
> 2.47.0
>

All the best,
phil

