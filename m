Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750DFCCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 23:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBiLT-0001aB-RO; Wed, 22 Oct 2025 19:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBiLS-0001Zd-AJ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 19:34:18 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBiLP-00017i-M4
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 19:34:17 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-63c3d913b3bso255116a12.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 16:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761176053; x=1761780853; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgoaNw7a1hxnlpDvQCoiYuh2TSG8BtlWTmckD92+Wpo=;
 b=MNErO1xJSG2GbxF50mhUghlPxicN0K5XyBJmcRC3nHSQceDAI9055HGm+0LJ2xOGa4
 w+s3XAQ1qObJkrcr4zCdSNiUUo1F+/cLtGqan8HTJ3Fk0D7uUq7hmWTx0nvVZc4PNKad
 sW0B/qPOSm1VH+/45tDxfsh8raIASJ0uU/miYbW4VZI+nl1Ysta1QoWLPPFkCgt/arQj
 VM32ELwycOuuo3CIizEp3qW8ZRq+KDnsFjc4j3DARajBc9jnOnqD5tgnd/e78iWIL3Fl
 QgilWGwoYWLoAU1LMQ8VGivb/sAvHR0jUxDNd/x+UojAabCogC+PiT+H/+HHsHzo6WK3
 +W6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761176053; x=1761780853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MgoaNw7a1hxnlpDvQCoiYuh2TSG8BtlWTmckD92+Wpo=;
 b=cDRNMt9T2K55d3gpctXwNgo0QKT+IcBPcZLyQI8Pxe9/tEOuM1FgKQKgJXtK83AGmU
 xF0J6LzKEFl8+fM7IQ+UeNedO8iEk0V28Vo9JwydnogQc80MvsXPckmmYW0T6sIQgDYt
 UGPOEVd8AxFal9OsZ0eLjZ3ijw5g8sx69zxs0EVKgm7BIQP8Gy/8liLkW2wEjEkOOYi7
 by18s7fRpInCB0RHbaOM3J8CC0usng+B4VsnxxHQPW9xw4L6/byGlDuQrqbPVYOhK2ye
 jXagtFOOpRN+r1Yd99mg0VaQ1YhWP6xkgA4+DTFnjIq1x5w0TeS4T/J9ixAf05T0xtJf
 pypg==
X-Gm-Message-State: AOJu0YyHh85Ntcv2otAKrT/51astRvM3u1nFJ/3S0kyUQK84JE2UgPy/
 HvdvxUbu4W3KN/vLh05ayt8ABVZ1SN+f6lNyJXEkRP90/UwNeN0C1tpsIR0dRPXlL0yXx8u3PrX
 KjH8iPxhnAiKRbN6kEriozfA/KZdtJ4rkoOqE
X-Gm-Gg: ASbGncujRlVTsK0u3VPEql4U75rpEXzq0qlU3p04rQXZKJM0tGUokU3SgP6WrYezwkX
 yfeiGd8u0QEeFpuxa4oGQGHfpGcug0dYCPoUyo/tZCAVHwHDemuUW89hMEHY9ZDBmKJzL7dGC7/
 e9yfPjgiyuxgFf1ZYrjjcfveY6AzUCM/94kYr/e3O1J4sc0hvTs8swfksXVSTLDZv83oAmfyhOd
 3clTBmKRH24gEEyP0zDYQ+Y8ujmY2f8uUFlRotERMNrL6xG+tEYojb0uD5opNW8McIzJqMknaY5
 QJ0DkOUIUOMZtSM=
X-Google-Smtp-Source: AGHT+IG5mDDdsFulmBzCInyinbWPPvCGVOfI8M6ljTQUzwaYLzy9Rsv994z3x+SuT+4G/Qv1WGEy3hCeDjh21kirtMk=
X-Received: by 2002:a05:6402:1e94:b0:634:544b:a755 with SMTP id
 4fb4d7f45d1cf-63e3e4783dbmr537052a12.19.1761176052840; Wed, 22 Oct 2025
 16:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20251022111105.483992-1-dbarboza@ventanamicro.com>
In-Reply-To: <20251022111105.483992-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 23 Oct 2025 09:33:45 +1000
X-Gm-Features: AS18NWAmxnNeqgRasTc_xXvRP5_Mc4DBAVHqzWDmMtOpExMV81DsJ8_nL2T36HI
Message-ID: <CAKmqyKPQ4nGOvEtiF+6pTfEt1q5oXxjr10gp5j7qJLaQOpXmLg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/kvm: fix env->priv setting in
 reset_regs_csr()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 22, 2025 at 9:12=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> This patch was originally made by Gitlab user Bo Gan (@ganboing) 4
> months ago in the context of issue [1]. I asked the author to send a
> patch to the mailing list ~3 months ago and got no reply. I'm sending
> the patch myself because we already missed 10.1 without this fix.
>
> I'll also just post verbatim Bo Gan comment in the commit msg:
>
> "In RISCV Linux with KVM enabled, gdbstub is broken. The
> get_physical_address isn't able to page-walk correctly and resolve the
> physical page. This is due to that the vcpu is being treated as starting
> in M mode even if KVM enabled. However, with KVM, the vcpu is actually
> started in S mode. The mmu_idx will give 3 (M), instead of 1 (S),
> resulting in Guest PA =3D=3D VA (wrong)!"
>
> Set env->priv to PRV_S in kvm_riscv_reset_regs_csr() since the VCPU is
> always started in S-mode for KVM.
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2991
>
> Cc: qemu-stable@nongnu.org
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2991
> Originally-by: Bo Gan (@ganboing in Gitlab)
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 0dd0d59d41..000e44b2b7 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -705,6 +705,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *e=
nv)
>      env->satp =3D 0;
>      env->scounteren =3D 0;
>      env->senvcfg =3D 0;
> +    env->priv =3D PRV_S;
>  }
>
>  static int kvm_riscv_get_regs_fp(CPUState *cs)
> --
> 2.51.0
>
>

