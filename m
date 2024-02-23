Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D114EC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 05:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdOGk-0002wB-O6; Fri, 23 Feb 2024 00:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rdOGi-0002vu-Si; Fri, 23 Feb 2024 00:38:44 -0500
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rdOGh-0000wW-7i; Fri, 23 Feb 2024 00:38:44 -0500
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4b978e5e240so269614e0c.0; 
 Thu, 22 Feb 2024 21:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708666721; x=1709271521; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQyWEa2faigACBvbN3uc3QDRR3mRPc2U4I5Ftz5Ysa4=;
 b=LFpSTCKBbNqjG+iIm9N2UVsxxFSSWerUOeV0HFYljKC9cjFVolUJ3F1phlYda10305
 tCwxN+12fPgLOfijZNWtCAv7p2RvDgQ68a0jR/TKZ7++EANMbqpk6PYyRQ4Nen/J1nDg
 t1/k8j61o/9qwStUmed0Okip9G70YAbOn8pETqOyCW2qWZj1fHfFnH5iV8xeydD87LEg
 ktgeqOb/qZG7esJUE4avhcv86fLh5h2DK89zbl+2ZFCcedbKWWHgUB/yqBgaxyA5TPv1
 gL6uLRI43lp/JbFcSwWIIv5y3xJ+bJ4n6Hoj/2dhTKRbPefgZyt80ZpTelO22+WIaYXr
 9l/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708666721; x=1709271521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQyWEa2faigACBvbN3uc3QDRR3mRPc2U4I5Ftz5Ysa4=;
 b=KKyJFh6ACfh3YgaL24am/n28weR0dF4dOr/zEMjYRVRM4zwcqxrugsjUkQCEqH/gg/
 EuBb0osoR7XXVboLB0Vn/5LfmsvGnqJFx3xEsh5CrF9UDhwXTTQGS/G9XyWy/LlMAmTd
 /usJ3ckv4vxXZ50WCHvJY6tYyvVWu5VxsvYpin+YOWGkb8U0lOxQRTNxS2nia+pMdmp1
 OAkgdEnDJxT1D3xIkhiT2aGgkAQQ7xy6kBjqtFaEFU3YnVL+VM7D6UV/t18nejWkmrqr
 33fNO1w/FdS3jXA166ZtvSJ2cLJdANbKYY8d89LLB4oPnZfSNfuUr/D/+3j8riTLDDqr
 1V/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI8UsW8XRkUzsp5toGa5Crr3N58m6R7Ij5wJBsWo43L6hCMpMTeBWr9S8pBrSyY78tXa16qXV2V+dAVoH1GaAcZe/k9xU=
X-Gm-Message-State: AOJu0YwVEikyPVw2oGVJY6Slw8krTKc3F7k/8lOzHFthMSxJrLVzJWvE
 BzK3ymWfb4tKP6c/mkE9Gh23FyvNmrTKi3SXYTmC/PODbbTI5llcA6X4Vki4bcBozOUFLR1PZWr
 +xuz3bzAxUYYc2IWKB07TFKrvdRw=
X-Google-Smtp-Source: AGHT+IHfCYFacKUGRfe4nGSnpfjFB3Qm7maSDuP0UTVnjsEof4+qVuwroEcRUfVpTdo+vsYvQ5qDsuPykY9fWG6X90c=
X-Received: by 2002:a1f:6d03:0:b0:4c8:e834:6ce2 with SMTP id
 i3-20020a1f6d03000000b004c8e8346ce2mr1172296vkc.5.1708666721489; Thu, 22 Feb
 2024 21:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20240217192607.32565-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240217192607.32565-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Feb 2024 15:38:15 +1000
Message-ID: <CAKmqyKO9-r0GCuH=LeS=vLMiaBuF2uvrsNysOvZf3ghgSStzrw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] libqos, riscv: libqos fixes, add riscv machine
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, thuth@redhat.com, lvivier@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Feb 18, 2024 at 5:27=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This second version was rebased with current
> alistair/riscv.to.apply-next and has typo fixes in patch 1. No other
> changes were made.
>
> All patches reviewed/acked.
>
> Changes from v1:
> - patch 1: typos in the commit message fixed
> - v1 link: https://lore.kernel.org/qemu-riscv/20240213191736.733334-1-dba=
rboza@ventanamicro.com/
>
> Daniel Henrique Barboza (6):
>   libqos/virtio.c: init all elems in qvring_indirect_desc_setup()
>   libqos/virtio.c: fix 'avail_event' offset in qvring_init()
>   hw/riscv/virt.c: create '/soc/pci@...' fdt node earlier
>   hw/riscv/virt.c: add virtio-iommu-pci hotplug support
>   hw/riscv/virt.c: make aclint compatible with 'qtest' accel
>   tests/libqos: add riscv/virt machine nodes

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/riscv/virt.c                         |  97 ++++++++++++-----
>  tests/qtest/libqos/meson.build          |   1 +
>  tests/qtest/libqos/riscv-virt-machine.c | 137 ++++++++++++++++++++++++
>  tests/qtest/libqos/virtio.c             |  27 +++--
>  4 files changed, 228 insertions(+), 34 deletions(-)
>  create mode 100644 tests/qtest/libqos/riscv-virt-machine.c
>
> --
> 2.43.2
>
>

