Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3767BCED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 00:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyMl-000631-F4; Mon, 07 Oct 2024 20:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxyMa-00061w-GG; Mon, 07 Oct 2024 20:46:09 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxyMV-0005K7-Oc; Mon, 07 Oct 2024 20:46:08 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-505a9e521b8so1631161e0c.0; 
 Mon, 07 Oct 2024 17:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728348362; x=1728953162; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwrZU7+WRXa2SBCQtrdGDwpBC/7fI0xHGdzxrY4bl/4=;
 b=CY5edREhnxt49jyL5uzt8oJ1vvxzO+QeYeSyU/XsWCSJ9wKrQxxVeLldtDhmDLhMX6
 P4s7W1kvXbzvfZ1BtSoVgz/xXZdh+RD5WK6+Jmmr55N+b0j+LK7G9HzVNsI1d4nkYml5
 SnWoe8mgKtIPRUZcDl5dzQCthUKJNmExtxY6/Bj6kTsMTvusupPtI6wi77qaBkiOKgo6
 tNpFoxGhWZMVZDUhO5mne3D/K+UL3Ev988frFBM+HKr96mo+AQUrR5TNFwbXeckerQ5I
 6ih6NIYExDgR30NVx2aNypzavrCcKwV8ZPURdzIV4wQzUvqXMdmA2EZIYmgN3JKVdkxX
 WVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728348362; x=1728953162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DwrZU7+WRXa2SBCQtrdGDwpBC/7fI0xHGdzxrY4bl/4=;
 b=KZQ0Qodnu2scRg36HskJmIU0FWEhvHT4Jy0X3zcwXr309aMZWHj0O0DY6pIOvLH1Y2
 FpEgcP5dxYSgeOLwApWZhpYgOCb/v30e3OZ2nLWAhYyZGhp6K+VAqzWw5isjyWJmgQxk
 LB3tiwUqH/SC2wd17Nvl3uVD5WZsEdl7MdKaq+8H4d8+CsDPNH26dkjKw0L3s92GPGUL
 wllakUGrzyb1kLb8/BmaXQecZZWTIqxE5sVoC+Y/ANqpO4C7w5M6odz4ONpJHbT3sbtH
 A/WDRGqdWPo95nt8ftN9guXUCttmTJg9l1sLjlViEIEtAPKSmwDXafeaJ4rm6BXMEVOf
 Mc4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNrFNpiyLvUxGa8xgmZsFEMeuFE/deCQSmXx+2qCiFHTtMiZHJHesLhuxyQGnsSUUiF+yvvRwkqEva@nongnu.org,
 AJvYcCVkLYv45LbL2pKoWhP6VlMjEq93VGxJB26M0DmusD0VPEfGmwBFlPXCvJxnurhj/0HIrphSzreZRGG4eg==@nongnu.org
X-Gm-Message-State: AOJu0YzttwHb9j9qUT32GuKpyQ9lkTDv9vQhHaU27BsD5UJVpLrLUwUP
 zx4bJYLIH4M28ahSLyvDmzlVjNgyWDNAwEqnuk/E8frv/BvSQzJefblPTRVwPdKWfD/hBtb+jOT
 816rTh1ERZiT+c5p94XISMWn7jTQ=
X-Google-Smtp-Source: AGHT+IHSJlvK4jZXDTbKT7zFv1I0YNJsGBRL7BUreec71rnnZExDUt435St1qHWdGUc4qJLEHqo7Brx0xwV9I6zN6Oo=
X-Received: by 2002:a05:6102:440b:b0:4a3:c830:81e9 with SMTP id
 ada2fe7eead31-4a40574966fmr11623307137.6.1728348362222; Mon, 07 Oct 2024
 17:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel>
 <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
 <20240917-b13c51d41030029c70aab785@orel>
 <8b24728f-8b6e-4c79-91f6-7cbb79494550@canonical.com>
 <20240918-039d1e3bebf2231bd452a5ad@orel>
 <CAFEAcA-Yg9=5naRVVCwma0Ug0vFZfikqc6_YiRQTrfBpoz9Bjw@mail.gmail.com>
 <bab7a5ce-74b6-49ae-b610-9a0f624addc0@canonical.com>
 <CAFEAcA-L7sQfK6MNt1ZbZqUMk+TJor=uD3Jj-Pc6Vy9j9JHhYQ@mail.gmail.com>
 <f1e41b95-c499-4e06-91cb-006dcd9d29e6@canonical.com>
 <CAFEAcA_ePVwnpVVWJSx8=-8v2h_z2imfSdyAZd62RhXaZUTojA@mail.gmail.com>
In-Reply-To: <CAFEAcA_ePVwnpVVWJSx8=-8v2h_z2imfSdyAZd62RhXaZUTojA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2024 10:45:36 +1000
Message-ID: <CAKmqyKPoom+iQbrNn7xuebRdd9DfX3GAJQQM+8fswEqfRi3e_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 19, 2024 at 1:34=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 18 Sept 2024 at 14:49, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 18.09.24 15:12, Peter Maydell wrote:
> > > On Wed, 18 Sept 2024 at 14:06, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >> Thanks Peter for looking into this.
> > >>
> > >> QEMU's cpu_synchronize_all_post_init() and
> > >> do_kvm_cpu_synchronize_post_reset() both end up in
> > >> kvm_arch_put_registers() and that is long after Linux
> > >> kvm_arch_vcpu_create() has been setting some FPU state. See the outp=
ut
> > >> below.
> > >>
> > >> kvm_arch_put_registers() copies the CSRs by calling
> > >> kvm_riscv_put_regs_csr(). Here we can find:
> > >>
> > >>       KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
> > >>
> > >> This call enables or disables the FPU according to the value of
> > >> env->mstatus.
> > >>
> > >> So we need to set the desired state of the floating point unit in QE=
MU.
> > >> And this is what the current patch does both for TCG and KVM.
> > >
> > > If it does this for both TCG and KVM then I don't understand
> > > this bit from the commit message:
> > >
> > > # Without this patch EDK II with TLS enabled crashes when hitting the=
 first
> > > # floating point instruction while running QEMU with --accel kvm and =
runs
> > > # fine with --accel tcg.
> > >
> > > Shouldn't this guest crash the same way with both KVM and TCG without
> > > this patch, because the FPU state is the same for both?
>
> > By default `qemu-system-riscv64 --accel tcg` runs OpenSBI as firmware
> > which enables the FPU.
> >
> > If you would choose a different SBI implementation which does not enabl=
e
> > the FPU you could experience the same crash.
>
> Ah, so KVM vs TCG is a red herring and it's actually "some guest
> firmware doesn't enable the FPU itself, and if you run that then it will
> fall over, whether you do it in KVM or TCG" ? That makes more sense.
>
> I don't have an opinion on whether you want to do that or not,
> not knowing what the riscv architecture mandates. (On Arm this
> would be fairly clearly "the guest software is broken and
> should be fixed", but that's because the Arm architecture
> says you can't assume the FPU is enabled from reset.)

RISC-V is the same. Section "3.4 Reset" states that:

"All other hart state is UNSPECIFIED." (the paragraph doesn't mention
the FS state).

So it's unspecified what the value is on reset. Guest software
shouldn't assume anything about it and it does seem like a guest
software bug.

In saying that, we are allowed to set it then as the spec doesn't say
it should be 0. So setting it to 0x01 (Initial) doesn't seem like a
bad idea, as the name kind of implies that it should be 0x01 on reset

Alistair

>
> I do think the commit message could use clarification to
> explain this.
>
> thanks
> -- PMM
>

