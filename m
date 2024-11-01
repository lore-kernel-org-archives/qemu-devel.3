Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A40E6F07D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 18:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6wiE-0005CY-Ki; Fri, 01 Nov 2024 14:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6wiA-0005BQ-Ah
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:49:30 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6wi8-0008I3-G3
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:49:30 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cec9609303so81227a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730486966; x=1731091766; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hd7lCgsBrjIMvOHFTBVk8ndUXVpuGihKgZWpcfmII6A=;
 b=fJqb5ndSht+dKefnp23EynRIR9WFWJBbItfGXqttr5BpeFUy9MyJubZpKE+Z1vEO/T
 r4TwKU43lPP2fhNJ43W6R86JXHS0SzDgY8MB2WTWj9we5dzNjwSHwm23Jtrfhu3OMzwU
 QLjlAAbbSowt+qGCwsi6aH/N3xGqTuKWH2E9i9oFdwY0n4+1ihg9V8iB+xOiHcJZPTB6
 Kht8TvnXhWdRpAA1jFuo9yCH20Q412OFyGDUYraLf5rZvBqhKfr39f8/gj3X0OFJU8Bk
 R9apH41HK/cqwCxdgk4i1y9O1k8hF0lqu0UT8TPjNgFaBXHwEf9u2c/KNt2kfvY4udzc
 AuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730486966; x=1731091766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hd7lCgsBrjIMvOHFTBVk8ndUXVpuGihKgZWpcfmII6A=;
 b=M7gbrNy9HR6PWoO1lS2JcbVGb6erMWx7ubeazzrWRAyy+0w72Ji55jrVnuqFQHbftY
 uRpJOh2rZhNbfzcks75/cG/2hZY7RPlpSOIOTrRdvPw9PH09DjkS9vlajsRPjaKvw35A
 ldqrbHQbCKqrSERwNvgxZcRXCuvO1lN2JAKeQLl7A410+5Yt0yTt9Qz/1kxGQpv+PYvW
 gzp94GvkmI0jiyOlkU2yTC+6ovln8twHLmSDiijsdMswFv1JsoflpcFnxZ7Zi7/OqnPV
 wGss1RafScof/X2WxNN4xVeNtoWakFMRjCqBCIP8qyhyr/PmQaMU8QNMsusOjiCCBWZ8
 fSdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKCiNJHvRLlv4e3SmgP82TXRFiPapVPQF/DkgypCCztbjeZJcw25jp8ENFWH27mdJUTfqK8k96Gssb@nongnu.org
X-Gm-Message-State: AOJu0Yys5r8GMdiJMek776qIhDk8shQL47PcfZQEomA/BThaE5Tc3soa
 2jt3I2q68C6j4U4/IvLnlBwK9i8TXGsy/Ey7npwJReqVsdDeFurIPI5v7lcm6YLzxxSrLk0usH5
 35ZyJ78W/OdvMd4wjedtpYW6KeHKwAT+iP2JRIA==
X-Google-Smtp-Source: AGHT+IHOELwVFg9FJlaRjLNVQ/3ZTogh21yWuEjEB29aiwIsipY/RvsgQibvU2RuN9liESEdjh2ra8cIAf5dIBCkT0E=
X-Received: by 2002:a05:6402:370c:b0:5cd:5732:ecf3 with SMTP id
 4fb4d7f45d1cf-5cd5732f0e0mr9605915a12.5.1730486966131; Fri, 01 Nov 2024
 11:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241101170833.1074954-1-pierrick.bouvier@linaro.org>
 <2e1af830-a90a-447f-ab47-1c3d49463134@ventanamicro.com>
 <CAFEAcA92CuvGUJQk5LFE1X3a8dH21ksE_QXETjVPnU3v1bVSzw@mail.gmail.com>
 <fd9ee34a-24e1-43fb-950b-aba585473085@ventanamicro.com>
In-Reply-To: <fd9ee34a-24e1-43fb-950b-aba585473085@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Nov 2024 18:49:14 +0000
Message-ID: <CAFEAcA_SYAC_UsEs+xy7aZEHsA1bC0umnsAF5ZmtjmZKEVSA+Q@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: fix build error with clang
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 Cleber Rosa <crosa@redhat.com>, qemu-riscv@nongnu.org, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Weiwei Li <liwei1518@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Tomasz Jeznach <tjeznach@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 1 Nov 2024 at 18:13, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> (Ccing Tomasz)
>
> On 11/1/24 2:48 PM, Peter Maydell wrote:
> > On Fri, 1 Nov 2024 at 17:36, Daniel Henrique Barboza
> > <dbarboza@ventanamicro.com> wrote:
> >>
> >>
> >>
> >> On 11/1/24 2:08 PM, Pierrick Bouvier wrote:
> >>> Introduced in 0c54ac, "hw/riscv: add RISC-V IOMMU base emulation"
> >>>
> >>> ../hw/riscv/riscv-iommu.c:187:17: error: redefinition of '_pext_u64'
> >>>
> >>>     187 | static uint64_t _pext_u64(uint64_t val, uint64_t ext)
> >>>
> >>>         |                 ^
> >>>
> >>> D:/a/_temp/msys64/clang64/lib/clang/18/include/bmi2intrin.h:217:1: note: previous definition is here
> >>>
> >>>     217 | _pext_u64(unsigned long long __X, unsigned long long __Y)
> >>>
> >>>         | ^
> >>>
> >>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >>> ---
> >>>    hw/riscv/riscv-iommu.c | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> >>> index feb650549ac..f738570bac2 100644
> >>> --- a/hw/riscv/riscv-iommu.c
> >>> +++ b/hw/riscv/riscv-iommu.c
> >>> @@ -184,7 +184,7 @@ static void riscv_iommu_pri(RISCVIOMMUState *s,
> >>>    }
> >>>
> >>>    /* Portable implementation of pext_u64, bit-mask extraction. */
> >>> -static uint64_t _pext_u64(uint64_t val, uint64_t ext)
> >>> +static uint64_t pext_u64(uint64_t val, uint64_t ext)
> >>
> >> I suggest name it 'riscv_iommu_pext_u64' to be clear that this is a local scope function,
> >> not to be mistaken with anything available in clang or any other compiler.
> >
> > More generally, we should avoid using leading '_' in QEMU function
> > names; those are reserved for the system.
> >
> > Also, what does this function do? The comment assumes that
> > the reader knows what a "pext_u64" function does, but if you
> > don't then it's fairly inscrutable bit-twiddling.
> > "bit-mask extraction" suggests maybe we should be using
> > the bitops.h extract functions instead ?
>
> This is the function:
>
>
> /* Portable implementation of pext_u64, bit-mask extraction. */
> static uint64_t _pext_u64(uint64_t val, uint64_t ext)
> {
>      uint64_t ret = 0;
>      uint64_t rot = 1;
>
>      while (ext) {
>          if (ext & 1) {
>              if (val & 1) {
>                  ret |= rot;
>              }
>              rot <<= 1;
>          }
>          val >>= 1;
>          ext >>= 1;
>      }
>
>      return ret;
> }

Yes, but what does it actually *do* ? :-)  Presumably
it extracts some subpart of 'val' based on 'ext', but
what is the format it expects 'ext' to be in, and what
kinds of input are valid?

For comparison, our extract64 function says:

 * extract64:
 * @value: the value to extract the bit field from
 * @start: the lowest bit in the bit field (numbered from 0)
 * @length: the length of the bit field
 *
 * Extract from the 64 bit input @value the bit field specified by the
 * @start and @length parameters, and return it. The bit field must
 * lie entirely within the 64 bit word. It is valid to request that
 * all 64 bits are returned (ie @length 64 and @start 0).

so even if you haven't come across it before you can see
what the function is intended to do, what inputs are valid
and what are not, and so on, and you don't need to try to
reverse-engineer those from the bit operations.

I'm not necessarily opposed to having separate implementations
of these things if it means the code follows the architectural
specifications more closely, but if we do have them can
we have documentation comments that describe the behaviour?

thanks
-- PMM

