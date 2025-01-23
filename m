Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EE8C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 09:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tatqd-0003gG-VQ; Thu, 23 Jan 2025 04:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tatqV-0003eZ-Kw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:49:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tatqT-0002Id-AV
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:49:55 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ydx243yFxz6M4MH;
 Thu, 23 Jan 2025 17:47:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 76A53140393;
 Thu, 23 Jan 2025 17:49:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 10:49:37 +0100
Date: Thu, 23 Jan 2025 09:49:35 +0000
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Paolo Bonzini
 <pbonzini@redhat.com>, <mst@redhat.com>
Subject: Re: [PATCH 1/2] hw/cxl: Remove unused
 component_registers::io_registers[] array
Message-ID: <20250123094935.00003937@huawei.com>
In-Reply-To: <20250122065624.34203-2-philmd@linaro.org>
References: <20250122065624.34203-1-philmd@linaro.org>
 <20250122065624.34203-2-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.043, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 22 Jan 2025 07:56:23 +0100
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> Avoid wasting 4K for each component, remove unused io_registers[].
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>

These may need to come back for correctness if anyone starts
actually accessing them in the OS, but for now this is fine.
We'd have to deal with filling them with plausible values anyway
if that becomes an issue.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I can pick these up and send on in a set to mst, or mst pick up
directly, or got through another tree. Don't mind!
> ---
>  include/hw/cxl/cxl_component.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_componen=
t.h
> index 945ee6ffd04..ac61c3f33a5 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -218,7 +218,6 @@ typedef struct component_registers {
>       *   0xe000 - 0xe3ff CXL ARB/MUX registers
>       *   0xe400 - 0xffff RSVD
>       */
> -    uint32_t io_registers[CXL2_COMPONENT_IO_REGION_SIZE >> 2];
>      MemoryRegion io;
> =20
>      uint32_t cache_mem_registers[CXL2_COMPONENT_CM_REGION_SIZE >> 2];


