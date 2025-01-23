Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7443C0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 12:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taw2Y-0007N9-JC; Thu, 23 Jan 2025 07:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taw2P-0007MY-6Z; Thu, 23 Jan 2025 07:10:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taw2M-00032K-Ew; Thu, 23 Jan 2025 07:10:20 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf0B65SKVz6JB7w;
 Thu, 23 Jan 2025 20:09:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 617D7140119;
 Thu, 23 Jan 2025 20:10:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 13:10:08 +0100
Date: Thu, 23 Jan 2025 12:10:07 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, John Snow
 <jsnow@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/11] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20250123121007.000008a0@huawei.com>
In-Reply-To: <8c1f7e8e85f98aae26811ab88f8a85a3a51ff1f9.1737560101.git.mchehab+huawei@kernel.org>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <8c1f7e8e85f98aae26811ab88f8a85a3a51ff1f9.1737560101.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Wed, 22 Jan 2025 16:46:28 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Using the QMP GHESv2 API requires preparing a raw data array
> containing a CPER record.
> 
> Add a helper script with subcommands to prepare such data.
> 
> Currently, only ARM Processor error CPER record is supported.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
My Python is poor at best, so take that into account!

Some usage examples might be good to have as well.
Either in explicit docs or the patch description.

Jonathan


> ---
>  MAINTAINERS                    |   3 +
>  scripts/arm_processor_error.py | 377 ++++++++++++++++++
>  scripts/ghes_inject.py         |  51 +++
>  scripts/qmp_helper.py          | 702 +++++++++++++++++++++++++++++++++
>  4 files changed, 1133 insertions(+)
>  create mode 100644 scripts/arm_processor_error.py
>  create mode 100755 scripts/ghes_inject.py
>  create mode 100644 scripts/qmp_helper.py
> 

> diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
> new file mode 100644
> index 000000000000..357ebc6e8359
> --- /dev/null
> +++ b/scripts/qmp_helper.py



> +    def send_cper(self, notif_type, payload):
> +        """Send commands to QEMU though QMP TCP socket"""
> +
> +        # Fill CPER record header
> +
> +        # NOTE: bits 4 to 13 of block status contain the number of
> +        # data entries in the data section. This is currently unsupported.

Not controllable, so always set to 0 or 1?  Or not set?

...


> +        self.send_cper_raw(cper_data)
> +

Trivial but maybe can improve consistency on spacing.  1 or 2 lines
between functions. I don't care which.

> +
> +    def search_qom(self, path, prop, regex):

> +class cper_guid:
> +    """
> +    Contains CPER GUID, as per:
> +    https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html
> +    """

> +
> +    CPER_PROC_X86 = guid(0xDC3EA0B0, 0xA144, 0x4797,

Maybe follow the spec naming as IA32_X64?

> +                         [0xB9, 0x5B, 0x53, 0xFA,
> +                          0x24, 0x2B, 0x6E, 0x1D])
> +
> +    CPER_PROC_ITANIUM = guid(0xe429faf1, 0x3cb7, 0x11d4,
> +                             [0xbc, 0xa7, 0x00, 0x80,

To stop people falling down a hole, maybe call out that this
is not the format in the spec which is weird for this one case.

> +                              0xc7, 0x3c, 0x88, 0x81])
> +

> +

> +
> +    CPER_PLATFORM_MEM2 = guid(0x61EC04FC, 0x48E6, 0xD813,
> +                              [0x25, 0xC9, 0x8D, 0xAA,
> +                               0x44, 0x75, 0x0B, 0x12])
Huh. they missed this one in the big spec table but is
there in N.2.6



> +    CPER_PCI_DEV = guid(0xEB5E4685, 0xCA66, 0x4769,
CPER_PCI_COMPONENT would match N.2.9 naming.
If I recall PCI terminology right, component covers a bunch
of things that Device doesn't.


> +                        [0xB6, 0xA2, 0x26, 0x06,
> +                         0x8B, 0x00, 0x13, 0x26])
> +
> +    CPER_FW_ERROR = guid(0x81212A96, 0x09ED, 0x4996,
Another one oddly missing from the big table but not the broken
out sections.  Not our problem but this chunk of the
spec could do with tidying up!

> +                         [0x94, 0x71, 0x8D, 0x72,
> +                          0x9C, 0x8E, 0x69, 0xED])
> +
> +    CPER_DMA_GENERIC = guid(0x5B51FEF7, 0xC79D, 0x4434,
CPER_DMAR
Nothing to do with DMA in general.  All about x86 IOMMUs I think.

> +                            [0x8F, 0x1B, 0xAA, 0x62,
> +                             0xDE, 0x3E, 0x2C, 0x64])
> +

> +
> +    CPER_CXL_PROT_ERR = guid(0x80B9EFB4, 0x52B5, 0x4DE3,
> +                             [0xA7, 0x77, 0x68, 0x78,
> +                              0x4B, 0x77, 0x10, 0x48])

Maybe add the one for FRU Memory poison from the new 2.11 UEFI spec.
This will constantly need updating with new specs so no problem
if you'd rather stick to 2.10 only for now.
 



