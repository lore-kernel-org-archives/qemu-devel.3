Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE7CCD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 16:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrK79-00027u-ML; Mon, 01 Apr 2024 12:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rrK6r-0001um-3h
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 12:02:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rrK6o-00013O-CG
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 12:02:08 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V7bMh4plcz6JBHc;
 Tue,  2 Apr 2024 00:00:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id B6BB71400D1;
 Tue,  2 Apr 2024 00:02:02 +0800 (CST)
Received: from localhost (10.48.156.172) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 17:02:02 +0100
Date: Mon, 1 Apr 2024 17:02:01 +0100
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Fan Ni <fan.ni@samsung.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH-for-9.0] hw/i386/pc: Restrict CXL to PCI-based machines
Message-ID: <20240401170201.000072d4@Huawei.com>
In-Reply-To: <20240327161642.33574-1-philmd@linaro.org>
References: <20240327161642.33574-1-philmd@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.48.156.172]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 27 Mar 2024 17:16:42 +0100
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> CXL is based on PCIe. In is pointless to initialize
> its context on non-PCI machines.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
Seems a reasonable restriction.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan

> ---
>  hw/i386/pc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e80f02bef4..5c21b0c4db 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1738,7 +1738,9 @@ static void pc_machine_initfn(Object *obj)
>      pcms->pcspk =3D isa_new(TYPE_PC_SPEAKER);
>      object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
>                                OBJECT(pcms->pcspk), "audiodev");
> -    cxl_machine_init(obj, &pcms->cxl_devices_state);
> +    if (pcmc->pci_enabled) {
> +        cxl_machine_init(obj, &pcms->cxl_devices_state);
> +    }
> =20
>      pcms->machine_done.notify =3D pc_machine_done;
>      qemu_add_machine_init_done_notifier(&pcms->machine_done);


