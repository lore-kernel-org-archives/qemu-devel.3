Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70AEC87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 09:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udn4M-0007kr-0H; Mon, 21 Jul 2025 05:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1udn4J-0007i4-V0; Mon, 21 Jul 2025 05:44:23 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1udn4G-0000JS-Il; Mon, 21 Jul 2025 05:44:23 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4blwRx4Jtxz6M4vZ;
 Mon, 21 Jul 2025 17:42:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id C3D5414044F;
 Mon, 21 Jul 2025 17:44:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 21 Jul
 2025 11:44:15 +0200
Date: Mon, 21 Jul 2025 10:44:13 +0100
To: Vadim Chichikalyuk <chichikalyuk@gmail.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Peter
 Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/4] tests: acpi: update expected blobs
Message-ID: <20250721104413.00004c54@huawei.com>
In-Reply-To: <20250718162045.49012-5-chichikalyuk@gmail.com>
References: <20250718162045.49012-1-chichikalyuk@gmail.com>
 <20250718162045.49012-5-chichikalyuk@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 18 Jul 2025 19:20:45 +0300
Vadim Chichikalyuk <chichikalyuk@gmail.com> wrote:

> Previous patch changed the SPCR ACPI table for AArch64 virt:
> @@ -15,2 +15,2 @@
> -[008h 0008 001h]                    Revision : 02
> -[009h 0009 001h]                    Checksum : B1
> +[008h 0008 001h]                    Revision : 03
> +[009h 0009 001h]                    Checksum : 0B
> @@ -49 +49 @@
> -[04Ch 0076 004h]                    Reserved : 00000000
> +[04Ch 0076 004h]                    Reserved : 016E3600

Hmm. No support in acpi-tools?  Old version maybe?

Looks like v4 support was added in this pull request last year
https://github.com/acpica/acpica/pull/931

Jonathan


> @@ -53 +53 @@
> -0000: 53 50 43 52 50 00 00 00 02 B1 42 4F 43 48 53 20  // SPCRP.....BOCHS
> +0000: 53 50 43 52 50 00 00 00 03 0B 42 4F 43 48 53 20  // SPCRP.....BOCHS
> @@ -57 +57 @@
> -0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
> +0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 36 6E 01  // .............6n.
> 
> In a revision 3 SPCR table, the "Reserved" field is the UART clock frequency
> field.
> 
> Signed-off-by: Vadim Chichikalyuk <chichikalyuk@gmail.com>
> ---
>  tests/data/acpi/aarch64/virt/SPCR           | Bin 80 -> 80 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
> 
> diff --git a/tests/data/acpi/aarch64/virt/SPCR b/tests/data/acpi/aarch64/virt/SPCR
> index cf0f2b75226515097c08d2e2016a83a4f08812ba..76ac417fbdc4dc6a473c51b82164f40bc5320c58 100644
> GIT binary patch
> delta 20
> bcmWFt;0g|K4hmpkU|{B+$mPszmd6MHD|7?L
> 
> delta 20
> acmWFt;0g|K4hmpkU|`xfk;|DG$N&H@90SJy
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 2a30472d57..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/aarch64/virt/SPCR",
> \ No newline at end of file


