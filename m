Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432DC606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=HlYgJDsl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPFjX-0007Ms-PZ; Fri, 06 Nov 2026 03:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xPFjR-0007LW-TO; Fri, 06 Nov 2026 03:55:35 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xPFjN-00022a-58; Fri, 06 Nov 2026 03:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793955323; bh=PUtj3wOivg04jg4kaPJh3JGuCpVLUgFzNn5gL7Po7Tw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=HlYgJDslgjASUL7/8DT6fY3Iyz/vI7GhwvW46ktmASuG1mKuKrFpA488qUxuSpni7
 tscdiZ49jwKmXtWn7tErhOP0LYp8qE/f4VN9BKYsPkEPC1p4zlX5E8XpcYnixokY9f
 YqBCjEb9fMnm++Yq9TFZ+ciQC4RNS33PbbyKhVJaX+WRXK1THK1EhyOcTsHhb2evqW
 8PGEX7YOwotjRPyQWsl1TtNwPt0sQy5wmXsztn7pk9naTV9z2SWjh+vott+PFN57tP
 Ne50M75lca26K1NmdQJ6cdOgktzx8z/Jpr+22zoJMlxWvg7h2P0Lr6Ne/A8rCh5boQ
 rgBlbQ9xYQEQA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8DF251E441F;
 Fri, 06 Nov 2026 11:55:23 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 79B7E45533D;
 Fri, 06 Nov 2026 11:55:23 +0300 (MSK)
Message-ID: <5493e42d-72ca-4522-9839-102036e488f6@tls.msk.ru>
Date: Fri, 6 Nov 2026 11:55:23 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] hw/loogarch: Fix UART ACPI properties and FDT
To: pillow <waysorrypub@gmail.com>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, QEMU Stable <qemu-stable@nongnu.org>
References: <20261025135559.236356-1-waysorrypub@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261025135559.236356-1-waysorrypub@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/25/26 16:55, pillow wrote:
> This series fixes the UART description for LoongArch virt.
> 
> The ACPI _DSD property built for the UART has three problems: the
> property name is misspelled, the key and value order is reversed, and
> it describes a 100 MHz clock that does not match the device model.
> The property can be dropped directly because the UART model's input
> clock matches the Linux 8250 PnP driver default of 1,843,200 Hz, so no
> _DSD override is needed.
> 
> The _CCA property is also unnecessary.  _CCA describes a device's DMA
> cache coherency attribute, and this UART does not support DMA, so there
> is no reason to declare it.
> 
> The UART clock frequency in the FDT is corrected to 1,843,200 Hz, and
> the expected ACPI tables are updated accordingly.
> 
> pillow (5):
>    bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
>    hw/loongarch/virt-acpi-build: Drop invalid _DSD UART clock property
>    hw/loongarch/virt-acpi-build: Drop UART _CCA declaration
>    hw/loongarch/virt: Fix UART clock frequency in FDT
>    tests/data/acpi/loongarch64: Update expected DSDT.*
> 
>   hw/loongarch/virt-acpi-build.c                |  11 -----------
>   hw/loongarch/virt-fdt-build.c                 |   2 +-
>   tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4351 bytes
>   tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5572 bytes
>   tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4357 bytes
>   .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4653 bytes
>   6 files changed, 1 insertion(+), 12 deletions(-)
> 

Hi!

Should this change be picked up fr current qemu stable releases?

Thanks,

/mjt

