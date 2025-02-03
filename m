Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FF2C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 10:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teu5E-0002rt-KA; Mon, 03 Feb 2025 05:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1teu5C-0002r5-4r; Mon, 03 Feb 2025 05:53:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1teu59-0001oP-3u; Mon, 03 Feb 2025 05:53:37 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ymjy24lQrz67CtD;
 Mon,  3 Feb 2025 18:52:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 30758140155;
 Mon,  3 Feb 2025 18:53:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 11:53:31 +0100
Date: Mon, 3 Feb 2025 10:53:30 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, Ani Sinha <anisinha@redhat.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 12/14] tests/acpi: virt: add a HEST table to aarch64
 virt and update DSDT
Message-ID: <20250203105330.00002c99@huawei.com>
In-Reply-To: <343a2a84c1cf4a3998d40a188658bd42bc689602.1738345063.git.mchehab+huawei@kernel.org>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
 <343a2a84c1cf4a3998d40a188658bd42bc689602.1738345063.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 31 Jan 2025 18:42:53 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> --- a/DSDT.dsl        2025-01-28 09:38:15.155347858 +0100
> +++ b/DSDT.dsl        2025-01-28 09:39:01.684836954 +0100
> @@ -9,9 +9,9 @@
>   *
>   * Original Table Header:
>   *     Signature        "DSDT"
> - *     Length           0x00001516 (5398)
> + *     Length           0x00001542 (5442)
>   *     Revision         0x02
> - *     Checksum         0x0F
> + *     Checksum         0xE9
>   *     OEM ID           "BOCHS "
>   *     OEM Table ID     "BXPC    "
>   *     OEM Revision     0x00000001 (1)
> @@ -1931,6 +1931,11 @@
>                  {
>                      Notify (PWRB, 0x80) // Status Change
>                  }
> +
> +                If (((Local0 & 0x10) == 0x10))
> +                {
> +                    Notify (GEDD, 0x80) // Status Change
> +                }
>              }
>          }
> 
> @@ -1939,6 +1944,12 @@
>              Name (_HID, "PNP0C0C" /* Power Button Device */)  // _HID: Hardware ID
>              Name (_UID, Zero)  // _UID: Unique ID
>          }
> +
> +        Device (GEDD)
> +        {
> +            Name (_HID, "PNP0C33" /* Error Device */)  // _HID: Hardware ID
> +            Name (_UID, Zero)  // _UID: Unique ID
> +        }
>      }
>  }
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Diff looks good.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

