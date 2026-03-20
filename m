Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC6D109193D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3WI8-0007Ti-9V; Fri, 20 Mar 2026 05:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w3WHx-0007Rz-0e
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:37:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w3WHv-0008F6-8c
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:37:04 -0400
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fccs0376DzHnGcX;
 Fri, 20 Mar 2026 17:36:36 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id A32274056F;
 Fri, 20 Mar 2026 17:37:01 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 09:37:01 +0000
Date: Fri, 20 Mar 2026 09:36:59 +0000
To: Xianglai Li <lixianglai@loongson.cn>
CC: <qemu-devel@nongnu.org>, Song Gao <gaosong@loongson.cn>, Bibo Mao
 <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen
 <zltjiangshi@gmail.com>
Subject: Re: [PATCH V3 1/2] hw/loongarch: add rtc acpi table
Message-ID: <20260320093659.00006061@huawei.com>
In-Reply-To: <c11b8bb41d36b5317171641f8f8bd4faab3ee101.1773911364.git.lixianglai@loongson.cn>
References: <cover.1773911364.git.lixianglai@loongson.cn>
 <c11b8bb41d36b5317171641f8f8bd4faab3ee101.1773911364.git.lixianglai@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 20 Mar 2026 08:36:52 +0800
Xianglai Li <lixianglai@loongson.cn> wrote:

> Add the acpi table to the loongson rtc hardware so that the virtual machine
> kernel can use the loongson RTC-related drivers.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>

Hi

No data updates for

tests/dta/acpi/loongarch64/virt?

> ---
> Cc: Song Gao <gaosong@loongson.cn> 
> Cc: Bibo Mao <maobibo@loongson.cn> 
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com> 
> Cc: Huacai Chen <zltjiangshi@gmail.com>
> 
>  hw/loongarch/virt-acpi-build.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
> index 3e34bedcd6..42820001d7 100644
> --- a/hw/loongarch/virt-acpi-build.c
> +++ b/hw/loongarch/virt-acpi-build.c
> @@ -460,6 +460,30 @@ static void acpi_dsdt_add_tpm(Aml *scope, LoongArchVirtMachineState *vms)
>  }
>  #endif
>  
> +static void acpi_dsdt_add_rtc(Aml *scope)
> +{
> +    Aml *dev = aml_device("RTC");
> +
> +    aml_append(dev, aml_name_decl("_HID", aml_string("LOON0001")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +
> +    Aml *crs = aml_resource_template();
> +    aml_append(crs,
> +        aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
> +                         AML_NON_CACHEABLE, AML_READ_WRITE,
> +                         0, VIRT_RTC_REG_BASE,
> +                         VIRT_RTC_REG_BASE + VIRT_RTC_LEN - 1,
> +                         0, VIRT_RTC_LEN));
> +    /*
> +     * The virtual machine model does not support suspend and wake-up,
> +     * and rtc is no longer the wake-up source. Therefore, the current
> +     * rtc table no longer provides the rtc alarm interrupt number to
> +     * avoid the software initializing alarm.
> +     */
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}
> +
>  /* build DSDT */
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
> @@ -475,6 +499,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>      for (i = 0; i < VIRT_UART_COUNT; i++) {
>          build_uart_device_aml(dsdt, i);
>      }
> +    acpi_dsdt_add_rtc(dsdt);
>      build_pci_device_aml(dsdt, lvms);
>      build_la_ged_aml(dsdt, machine);
>      build_flash_aml(dsdt, lvms);


