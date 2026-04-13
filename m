Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75826E93810
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 11:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCFUu-0002xw-SK; Mon, 13 Apr 2026 07:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCFUr-0002wF-HJ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 07:30:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCFUo-0001kt-Kx
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 07:30:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-483487335c2so46678065e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 04:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776079824; x=1776684624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWtG8WcHxf4Xxq57DLRbd8kXq4RAnv0N9QDkaJJ0gxs=;
 b=JvX2GB1WfVQDIiBwJqqTNLmg7CnqH6kMfUDhV5hPhXavSGXTP0kq6rUd6T1QdjFZ1q
 G02MUP/LTZ9bet5lLZepvzjVWykwX078RWwfJ/7wH7VktAwWyrLUtL11ov+UDi1JxqlE
 yyE5tJ0Dq9RH6YvRrq5nG6+tj0zRhTIBpkeHtz63H42GfY9XTdRZKTB5MLkPJdZnX1Q0
 UScRSTqVzPBQuWpTCqzQPxwa78WH4yLg4M5J2jTg4PWflTz5DnGfJ3HpEWpumhIQqspy
 zLyg+fFNSci8rlF4FMvoj8IQkFjpXJnL6GggOpvbkYC6d+LVq8VdnbjLm5BJw633vPOo
 21Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776079824; x=1776684624;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rWtG8WcHxf4Xxq57DLRbd8kXq4RAnv0N9QDkaJJ0gxs=;
 b=l8iUBTYH5BGgwsGMmr/gY5wMtf2i1gfu+pRWTheWTeIP9xxTgIDO56xHtF6M63wzOs
 R2d6pKzWb5XgJ+EDkylfYirPlTyeAS2NsEAXZAWp9lzTuaA8Tktt1f0hlmakSyjZZHvV
 04SP5VthbWpguL4vrxJ6K2Lih1nBSozM1mgB2FEebwO4ynBHGf87LVQ3m4WRXcL42jV1
 P7zrh6INzYDVn1uGUNqklEJ6x1r1cpiLggXu7X+ULiAgumJfj26nkz8wYu+XVD/m+Z4V
 DyFtdBDLv1uskCKA7i5vqnWefywwYEF6HLqNNclITRcCT+NOGOKAK9fpxVNzHza22FZN
 QrQQ==
X-Gm-Message-State: AOJu0YxdBWQMtRpeDJ5z6h8sSkI1K7ZRzxEZiEUEhaRqbuUguBY3EHRW
 oe3BOVtAxL4LfpUF1bUC9ToJv83KUuWKTlwXKdLSE+vDWJx7bjGLxmmi
X-Gm-Gg: AeBDiesL+jIKidJQVt5mzNejzO1kPyK3x2R3cSscBJ5f9IdmKJ/scOsS7PKt4aBt21I
 cLSl04O6RK6Vv6zfnctRKCHJnVponLQU48opc08rl6auhwnbb5h+WgltrM+S6HsYchj/flP6YgW
 V/a8n/03dYrtN0bpHrJ0Abi22RHMzTXfTdo/NMxbiug6mn3ipxjcVdUoFP9sWkssOIbG1SkowqW
 ZgsAtoyT/jcdVYdjO4afdMn9IBPgeEAp8cnvOxfsklkyJx9SVUNojH7hVwNdfYdGGfXCW7VZvuu
 CP5F+WLdpozFui+jg5B4VWkJBHovNHumHKoVFwD8ItcjcDEDOBBzZApNkGxqHKJf7uj4Amghyhg
 xFTf1MsX5yKj9C9Vglfq2WFtIYkTULuqJMyVCRsBr8Pdcxdv8VKuLI1xjRcNnRXw8kk4k2FiZq+
 8berNdb+Jh37aiMDKku7Lqd0HcS+vRGnq/TplnVGTiYLJheTDCC3FkEn1khyosfqohz/rT/OT62
 /X9lOAQSa245JGysnEC
X-Received: by 2002:a05:600c:3546:b0:488:a82f:bbb0 with SMTP id
 5b1f17b1804b1-488d6889a3fmr176825145e9.27.1776079823330; 
 Mon, 13 Apr 2026 04:30:23 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf1c6100004fcff454cbdf8f.dip0.t-ipconnect.de.
 [2003:fa:af1c:6100:4f:cff4:54cb:df8f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d531f2b6sm313844605e9.2.2026.04.13.04.30.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 04:30:22 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:30:20 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Vivien LEGER <vivien.leger@gmail.com>, qemu-ppc@nongnu.org
CC: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/ppc/e500=3A_fix_bus-frequency?=
 =?US-ASCII?Q?_property_hardcoded_to_zero_in_CPU_FDT_node?=
In-Reply-To: <20260411154535.1451361-1-vivien.leger@gmail.com>
References: <20260411154535.1451361-1-vivien.leger@gmail.com>
Message-ID: <2B283171-55E2-4DC1-9F5F-BE2254E8DB7D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

+ qemu-stable

Am 11=2E April 2026 15:45:35 UTC schrieb Vivien LEGER <vivien=2Eleger@gmai=
l=2Ecom>:
>The bus-frequency property in the CPU FDT node was hardcoded to 0=2E
>This is incorrect - it should reflect the actual platform bus clock
>frequency, as firmware and RTOSes use it to derive peripheral clock
>rates=2E
>
>Notably, the RTEMS QorIQ BSP uses bus-frequency to program the MPIC
>global timer interval=2E With bus-frequency=3D0, the timer interval
>overflows to ~85 seconds, preventing any clock interrupts from firing=2E
>
>Fix by adding a bus_freq field to PPCE500MachineClass and using it in
>the FDT generator=2E Set bus_freq =3D PLATFORM_CLK_FREQ_HZ (400MHz) for
>existing machines, matching the existing clock_freq value=2E
>
>Signed-off-by: Vivien LEGER <vivien=2Eleger@gmail=2Ecom>
>---
> hw/ppc/e500=2Ec      | 2 +-
> hw/ppc/e500=2Eh      | 1 +
> hw/ppc/e500plat=2Ec  | 1 +
> hw/ppc/mpc8544ds=2Ec | 1 +
> 4 files changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>index d6ca2e8=2E=2E5be2f20 100644
>--- a/hw/ppc/e500=2Ec
>+++ b/hw/ppc/e500=2Ec
>@@ -518,7 +518,7 @@ static int ppce500_load_device_tree(PPCE500MachineSta=
te *pms,
>                               env->icache_line_size);
>         qemu_fdt_setprop_cell(fdt, cpu_name, "d-cache-size", 0x8000);
>         qemu_fdt_setprop_cell(fdt, cpu_name, "i-cache-size", 0x8000);
>-        qemu_fdt_setprop_cell(fdt, cpu_name, "bus-frequency", 0);
>+        qemu_fdt_setprop_cell(fdt, cpu_name, "bus-frequency", pmc->bus_f=
req);
>         if (cpu->cpu_index) {
>             qemu_fdt_setprop_string(fdt, cpu_name, "status", "disabled")=
;
>             qemu_fdt_setprop_string(fdt, cpu_name, "enable-method",
>diff --git a/hw/ppc/e500=2Eh b/hw/ppc/e500=2Eh
>index 11f8ae5=2E=2E6d56c7b 100644
>--- a/hw/ppc/e500=2Eh
>+++ b/hw/ppc/e500=2Eh
>@@ -40,6 +40,7 @@ struct PPCE500MachineClass {
>     hwaddr pci_mmio_bus_base;
>     hwaddr spin_base;
>     uint32_t clock_freq;
>+    uint32_t bus_freq;
>     uint32_t tb_freq;
> };
>=20
>diff --git a/hw/ppc/e500plat=2Ec b/hw/ppc/e500plat=2Ec
>index ca56472=2E=2E85cec81 100644
>--- a/hw/ppc/e500plat=2Ec
>+++ b/hw/ppc/e500plat=2Ec
>@@ -94,6 +94,7 @@ static void e500plat_machine_class_init(ObjectClass *oc=
, const void *data)
>     pmc->pci_mmio_bus_base =3D 0xE0000000ULL;
>     pmc->spin_base =3D 0xFEF000000ULL;
>     pmc->clock_freq =3D PLATFORM_CLK_FREQ_HZ;
>+    pmc->bus_freq =3D PLATFORM_CLK_FREQ_HZ;
>     pmc->tb_freq =3D PLATFORM_CLK_FREQ_HZ;
>=20
>     mc->desc =3D "generic paravirt e500 platform";
>diff --git a/hw/ppc/mpc8544ds=2Ec b/hw/ppc/mpc8544ds=2Ec
>index 5826985=2E=2Ed022761 100644
>--- a/hw/ppc/mpc8544ds=2Ec
>+++ b/hw/ppc/mpc8544ds=2Ec
>@@ -56,6 +56,7 @@ static void mpc8544ds_machine_class_init(ObjectClass *o=
c, const void *data)
>     pmc->pci_pio_base =3D 0xE1000000ULL;
>     pmc->spin_base =3D 0xEF000000ULL;
>     pmc->clock_freq =3D PLATFORM_CLK_FREQ_HZ;
>+    pmc->bus_freq =3D PLATFORM_CLK_FREQ_HZ;
>     pmc->tb_freq =3D PLATFORM_CLK_FREQ_HZ;
>=20
>     mc->desc =3D "mpc8544ds";

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>


