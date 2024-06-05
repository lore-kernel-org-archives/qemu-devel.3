Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88759C27C54
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 00:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEel9-0004TB-Lv; Tue, 04 Jun 2024 20:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEel8-0004Si-44; Tue, 04 Jun 2024 20:44:10 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEel6-0008Gq-15; Tue, 04 Jun 2024 20:44:09 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-48bd4cefe5cso959739137.0; 
 Tue, 04 Jun 2024 17:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717548246; x=1718153046; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jOnQhGH+rNrbgwmTuemA85hqYhTTiZIEkEqdvHMaZGg=;
 b=i8RTCP1CN8eFsF7Dpquap/G0O+yB2WknuDXDdfTNUIOmn7pmtJPz/zneZoVBVE72vn
 wmFkIWG+WoIJelv3/Weuir0crC/fA4f+Kz8N0uP39Jl6+3KYFMl4Hl+AtdDR+o1vU3g1
 8e3CObBaulDDVUbFgJT31ZdI57IAssMhts5MdcihsBUXeqZJ2hUm45SAgiHs80GmxYuU
 DD+wf3gUfmQ6rdSm3/1An5zFJ71zRiDJNinR60FsuRsVv/qyU71edMMR8pqhFvwUbb50
 aqOGF8IchT1Oma/KBCuHn8NrzZc++7oI98MDfowNo/WJ6YjD3GnJGbc1vi4fPyAKGMh9
 mDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717548246; x=1718153046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOnQhGH+rNrbgwmTuemA85hqYhTTiZIEkEqdvHMaZGg=;
 b=wJpTf+ksk4LsF5kXUaaGMizDnJCesv4Nesza0/KBzKRBVVFX59tIdfMEjjLUdZNoa0
 2CAG+oV/9C6g0F6qJwMFzeoRHo3NZCjLAIkenRdrLcCSnyjL1KLyVp6+3Kemo7oC5NIZ
 SKBUgGc6OAQKo8IkJI121HXPFe3Fv6guChQXOMDrzY58HHPg3+Vl8R8gWQQGEmHUHGD/
 DsZdvj+zRT94GdXKJsioKRex18rEk36iqAHHPABMyb4xSdx/wIRVy42IpG+PXiZNX3us
 K2wdGQVsH7R2wc5EDRF13Gm4Ey6UWCDJwzdZ2PkCgbTGSua8ejXI2C97Sbs8tALRGI/s
 inww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXozywil+Hc8/BYvmavjdmACHwOIrByLchHNNsrVSHEsi2jnxO2Zmuv31DYr/ZtUUWp4lugHENcr9CoQkvlsxtZjYBCzec=
X-Gm-Message-State: AOJu0Yzw1OlIjp2GblgZCo7Y5CjlM325IPeROzIxPkKx5aRa73L722u+
 QHDhFhZGfO+AtGbYoeBD3pjMD3NoTJ+m3zCQR12xCjwNvVWTtgR05eg+QNsTxY+euzPOD3FFuAr
 H15AEOKRBswBqbFt3cmfTkZPmhC0=
X-Google-Smtp-Source: AGHT+IHbclVyWw7PcP7ktcd5wQGHPV6NUh8843i+z18dT22zs0IjQAEcEgFGwRupJ2JV6clRXJBAhn5iFZaradSw1fE=
X-Received: by 2002:a67:f790:0:b0:48b:ae47:c11 with SMTP id
 ada2fe7eead31-48c047f37d9mr1326150137.4.1717548246219; Tue, 04 Jun 2024
 17:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240531202759.911601-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 10:43:40 +1000
Message-ID: <CAKmqyKNidQcVM6Vw07pmOz_7O_=SSZckhxUKKxcjhRN_xhLthQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] hw/riscv/virt.c: aplic/imsic DT fixes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Sat, Jun 1, 2024 at 6:30=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This is a series that is being spun from the reviews given on patch 1
> [1]. We'll fix some DT validation issues we have in the 'virt' machine
> [2] that aren't related to missing extensions in the DT spec.
>
> I'll leave to maintainers to squash the patches as they see fit. I
> split it this way to make it easier to bissect possible bugs that these
> individual changes can cause.
>
> These are the types of DT warnings solved by this series:
>
> /home/danielhb/work/qemu/riscv64_virt.dtb: aplic@d000000: $nodename:0: 'a=
plic@d000000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,aplic.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: aplic@d000000: compatible:0: '=
riscv,aplic' is not one of ['qemu,aplic']
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,aplic.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: aplic@d000000: compatible: ['r=
iscv,aplic'] is too short
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,aplic.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: aplic@d000000: Unevaluated pro=
perties are not allowed ('compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,aplic.yaml#
> (...)
> /home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: $nodename:0: =
'imsics@28000000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,imsics.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: compatible:0:=
 'riscv,imsics' is not one of ['qemu,imsics']
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,imsics.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: compatible: [=
'riscv,imsics'] is too short
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,imsics.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: '#msi-cells' =
is a required property
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,imsics.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: Unevaluated p=
roperties are not allowed ('compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,imsics.yaml#
>
> [3] explains how to run 'dt-validate' to reproduce them. To generate a
> 'processed schema' file what I did was:
>
> - in the Linux kernel tree, run 'make dt_binding_check'. Please note
>   that this might require installation of additional python stuff
>   (e.g.swig, python3-devel)
>
> - I used the generated file 'Documentation/devicetree/bindings/processed-=
schema.json'
>   as a 'processed schema'.
>
> Series applicable on both master and alistair/riscv-to-apply.next.
>
> Changes from v1:
> - added patches 2 to 7 to fix the dt-validate warnings on imsics and
>   aplic notes
> - v1 link: https://lore.kernel.org/qemu-riscv/20240530084949.761034-1-dba=
rboza@ventanamicro.com/
>
> [1] https://lore.kernel.org/qemu-riscv/20240530084949.761034-1-dbarboza@v=
entanamicro.com/
> [2] https://lore.kernel.org/all/20240529-rust-tile-a05517a6260f@spud/
> [3] https://lore.kernel.org/qemu-riscv/20240530-landed-shriek-9362981afad=
e@spud/
>
> Daniel Henrique Barboza (8):
>   hw/riscv/virt.c: add address-cells in create_fdt_one_aplic()
>   hw/riscv/virt.c: add aplic nodename helper
>   hw/riscv/virt.c: rename aplic nodename to 'interrupt-controller'
>   hw/riscv/virt.c: aplic DT: add 'qemu,aplic' to 'compatible'
>   hw/riscv/virt.c: aplic DT: rename prop to 'riscv,delegation'
>   hw/riscv/virt.c: change imsic nodename to 'interrupt-controller'
>   hw/riscv/virt.c: imsics DT: add 'qemu,imsics' to 'compatible'
>   hw/riscv/virt.c: imsics DT: add '#msi-cells'

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/riscv/virt.c         | 36 +++++++++++++++++++++++++++---------
>  include/hw/riscv/virt.h |  1 +
>  2 files changed, 28 insertions(+), 9 deletions(-)
>
> --
> 2.45.1
>
>

