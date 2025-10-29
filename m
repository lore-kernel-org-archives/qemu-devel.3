Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F0BCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 11:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE41E-0000f0-Uy; Wed, 29 Oct 2025 07:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vE414-0000bK-Um; Wed, 29 Oct 2025 07:06:59 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vE410-0004aq-54; Wed, 29 Oct 2025 07:06:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cxPYY2P6vzHnGh3;
 Wed, 29 Oct 2025 11:05:53 +0000 (UTC)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id B6E22140417;
 Wed, 29 Oct 2025 19:06:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 11:06:44 +0000
Date: Wed, 29 Oct 2025 11:06:43 +0000
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>, <qemu-block@nongnu.org>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 <qemu-arm@nongnu.org>, <qemu-s390x@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, "Song
 Gao" <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v3 13/25] hw/acpi: Use memory_region_get_address()
Message-ID: <20251029110643.0000361f@huawei.com>
In-Reply-To: <20251028181300.41475-14-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-14-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 28 Oct 2025 19:12:47 +0100
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> MemoryRegion::addr is private data of MemoryRegion, use
> memory_region_get_address() to access it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
>  hw/acpi/cxl.c                  | 8 ++++++--

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com> #for CXL

>  hw/i386/acpi-build.c           | 8 +++++---
>  hw/loongarch/virt-acpi-build.c | 4 ++--
>  3 files changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> index 77c99dfb184..92c032851cc 100644
> --- a/hw/acpi/cxl.c
> +++ b/hw/acpi/cxl.c
> @@ -105,6 +105,7 @@ static void cedt_build_chbs(GArray *table_data, PXBCX=
LDev *cxl)
>      PXBDev *pxb =3D PXB_DEV(cxl);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(cxl->cxl_host_bridge);
>      MemoryRegion *mr =3D sysbus_mmio_get_region(sbd, 0);
> +    hwaddr container_base_addr =3D memory_region_get_address(mr->contain=
er);
> =20
>      /* Type */
>      build_append_int_noprefix(table_data, 0, 1);
> @@ -125,7 +126,9 @@ static void cedt_build_chbs(GArray *table_data, PXBCX=
LDev *cxl)
>      build_append_int_noprefix(table_data, 0, 4);
> =20
>      /* Base - subregion within a container that is in PA space */
> -    build_append_int_noprefix(table_data, mr->container->addr + mr->addr=
, 8);
> +    build_append_int_noprefix(table_data,
> +                              container_base_addr
> +                              + memory_region_get_address(mr), 8);
> =20
>      /* Length */
>      build_append_int_noprefix(table_data, memory_region_size(mr), 8);
> @@ -154,7 +157,8 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml =
*cedt)
>      build_append_int_noprefix(table_data, 0, 4);
> =20
>      /* Base HPA */
> -    build_append_int_noprefix(table_data, fw->mr.addr, 8);
> +    build_append_int_noprefix(table_data,
> +                              memory_region_get_address(&fw->mr), 8);
> =20
>      /* Window Size */
>      build_append_int_noprefix(table_data, fw->size, 8);



