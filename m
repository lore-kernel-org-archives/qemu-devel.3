Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604E4F4643A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w24RJ-0002S3-16; Mon, 16 Mar 2026 05:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w24RI-0002Ro-B3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 05:40:44 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w24RG-0006xU-7f
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 05:40:44 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-665634cb208so1213591a12.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 02:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773654039; x=1774258839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WkNzkMAEYb+K/91dReIcHmZW+SjDKlL9QrJ1tA5lcio=;
 b=j4edvi1OAbfV31fGWBN3pCZx9G+CUh+on3DFYdKEAGTUYbVh3Pu98/Z5HLaIHgUJF+
 kj8gDLlU+hDwske6FCOIxytH/FG/kTYZGDOBHKucaREfiEDPSSQJ2jHlR6IhnVxC9JGS
 hOeLfzJFvGNb1Z3+k4LyN4sbcxxgtjg7ICa0apmLII50EdJqp6gGK1DBdGAv6ymzSij/
 89sDbuX6b2JxJTblDzyyiS21/O7TYryid8VztovkSMSIqegaWx1R+UV/dBZXWUid+IMa
 HGZmvm//elkhqy30xdrsg0CzW2iyT9AlL4X5G7kGEh+2F0YMbF7BIVr7hYp071NO2BCE
 UTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773654039; x=1774258839;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WkNzkMAEYb+K/91dReIcHmZW+SjDKlL9QrJ1tA5lcio=;
 b=St6Vx2jZHw8u8Z/+6hg2DIBg8Y/y4I5O0daEI3+Je2cVox8RqyZVBqCNMiHBy6ejCg
 hSHdjQikfZgV37w/pfrmclYlHCkzlURBFDa+KhNTln1hp4TDHaH1wYCFhwmcECcybWaM
 B5A2FgyCVWrZER4bJMjwyvbAMbllu4q0pk5z3E2ybkIdD8q8C3kY1UmlYbyQC/pNFlKl
 W5asa92Vmd5MJQM05vp8L/D0i+wySdi2tHpnA3XT5C2qSsJtllJP47+jIx7Rwj+g5kGw
 z9qDcR+SLZ/B+nvSHp+PVhaZca3Mcw7PVgzyecn1Ywzw433a0U99LnspIYyqWF2+YC+s
 Zl5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8Nq6kklC5V+jKjLEnT/ZYWxRGsQPkOcRHsbcfrTnIi7ZMEleoRAMf/645pCc49n/TuaQWw1rG0DBT@nongnu.org
X-Gm-Message-State: AOJu0YxnnVYKneq+HQpzNQpty/iSB32kpcp2AMf4WN68J+4GXS3N0uiw
 KHrauHbWPFbGO1X6KzKRprbRtPQHKZymcRUlu0uUB/0ToGjpuRy/wTZASwa+NsEBvrw=
X-Gm-Gg: ATEYQzzfsUd08KZWGBoQxdmME4pI3h98hXirxR/WCCKW4mMeaFk4zltax2lyHuWzBUV
 Q7LpPEsPRaNlRpOFxTrasko59dIii9uPIsj0j/q75UBDN92bqEJGKizN/LgqXgxeu0ryNkeV1Tz
 M25E9lcCho/xcbv585PCgCP0rDbsdS8ja3dL5AxxU/SZZKrZmPk50UPiB0AXDBncq8Uqlm0Gekh
 FeF+sx/i5UIgjOXOHFcoeZAZgd04+CzR5UeAhBriYAGeEA4SjnDnLHnavBUFP+wBOlykE3jlPle
 id/0QO6to4iCf/GBL3uPCgnqX+AsIzPXKpT5pBzTDTsriTDvH3OFon2egKvLoqjFLMgIRSiGk1p
 ljmG9qUIu9JVC7rhL7NkVdpUsy+5dK/n5c+VdDX3qpm5Ajjbh0mKlKndQFgQiUQhWGh09ufQGRb
 V/Khrw7GS59KybhVIuQzSYqmM=
X-Received: by 2002:a17:907:3e8d:b0:b97:d126:c007 with SMTP id
 a640c23a62f3a-b97d126c3f8mr1799066b.30.1773654039386; 
 Mon, 16 Mar 2026 02:40:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66350d6fe24sm4827652a12.29.2026.03.16.02.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 02:40:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 97B655F7E0;
 Mon, 16 Mar 2026 09:40:37 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  agraf@csgraf.de,
 peter.maydell@linaro.org
Subject: Re: [PATCH rfc] hvf: arm: Inject SEA when executing insn in invalid
 memory range
In-Reply-To: <20260315163840.30741-1-zenghui.yu@linux.dev> (Zenghui Yu's
 message of "Mon, 16 Mar 2026 00:38:40 +0800")
References: <20260315163840.30741-1-zenghui.yu@linux.dev>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Mon, 16 Mar 2026 09:40:37 +0000
Message-ID: <87ikawnmcq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Zenghui Yu <zenghui.yu@linux.dev> writes:

> It seems that hvf doesn't deal with the abort generated when guest tries =
to
> execute instructions outside of the valid physical memory range, for
> unknown reason. The abort is forwarded to userspace and QEMU doesn't hand=
le
> it either, which ends up with faulting on the same instruction infinitely.
>
> This was noticed by the kvm-unit-tests/selftest-vectors-kernel failure:
>
>   timeout -k 1s --foreground 90s /opt/homebrew/bin/qemu-system-aarch64 \
>     -nodefaults -machine virt -accel hvf -cpu host \
>     -device virtio-serial-device -device virtconsole,chardev=3Dctd \
>     -chardev testdev,id=3Dctd -device pci-testdev -display none \
>     -serial stdio -kernel arm/selftest.flat -smp 1 -append
>   vectors-kernel

Have you got patches for teaching kvm-unit-tests about hvf or are you
running these all manually? I tried building on the Mac we have but it
failed the build and the docs only mention x86.

>
>   PASS: selftest: vectors-kernel: und
>   PASS: selftest: vectors-kernel: svc
>   qemu-system-aarch64: 0xffffc000: unhandled exception ec=3D0x20
>   qemu-system-aarch64: 0xffffc000: unhandled exception ec=3D0x20
>   qemu-system-aarch64: 0xffffc000: unhandled exception ec=3D0x20

I think this is running:

  static bool check_pabt(void)
  {
          enum vector v =3D check_vector_prep();

          install_exception_handler(v, ESR_EL1_EC_IABT_EL1, pabt_handler);

          test_exception("adrp	x9, check_pabt_invalid_paddr\n"
                         "add	x9, x9, :lo12:check_pabt_invalid_paddr\n"
                         "ldr	x9, [x9]\n",
                         "blr	x9\n",
                         "", "x9", "x30");

          install_exception_handler(v, ESR_EL1_EC_IABT_EL1, NULL);

          return pabt_works;
  }

which is expecting 0x21 - instruction abort at the same exception level.
I wonder why there is the difference.


>   [...]
>
> It's apparent that the guest is braindead and it's unsure what prevents h=
vf
> from injecting an abort directly in that case. Try to deal with the insane
> guest in QEMU by injecting an SEA back into it in the EC_INSNABORT
> emulation path.
>
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> ---
>  target/arm/hvf/hvf.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index aabc7d32c1..54d6ea469c 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -2332,9 +2332,32 @@ static int hvf_handle_exception(CPUState *cpu, hv_=
vcpu_exit_exception_t *excp)
>          bool ea =3D (syndrome >> 9) & 1;
>          bool s1ptw =3D (syndrome >> 7) & 1;
>          uint32_t ifsc =3D (syndrome >> 0) & 0x3f;
> +        uint64_t ipa =3D excp->physical_address;
> +        AddressSpace *as =3D cpu_get_address_space(cpu, ARMASIdx_NS);
> +        hwaddr xlat;
> +        MemoryRegion *mr;
> +
> +        cpu_synchronize_state(cpu);
>=20=20
>          trace_hvf_insn_abort(env->pc, set, fnv, ea, s1ptw, ifsc);
>=20=20
> +        /*
> +         * TODO: If s1ptw, this is an error in the guest os page tables.
> +         * Inject the exception into the guest.
> +         */
> +        assert(!s1ptw);
> +
> +        mr =3D address_space_translate(as, ipa, &xlat, NULL, false,
> +                                     MEMTXATTRS_UNSPECIFIED);
> +        if (unlikely(!memory_region_is_ram(mr))) {
> +            uint32_t syn;
> +
> +            /* inject an SEA back into the guest */
> +            syn =3D syn_insn_abort(arm_current_el(env) =3D=3D 1, ea, fal=
se, 0x10);
> +            hvf_raise_exception(cpu, EXCP_PREFETCH_ABORT, syn, 1);
> +            break;
> +        }
> +
>          /* fall through */
>      }
>      default:

I need the check the exception paths for KVM and TCG. I guess for the
KVM case it is all in the kernel?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

