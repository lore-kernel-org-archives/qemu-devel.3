Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED0BC83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 04:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf9eY-0006K6-4B; Fri, 25 Jul 2025 00:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uf9eP-00069R-4x
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:03:17 -0400
Received: from sg-1-13.ptr.blmpb.com ([118.26.132.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uf9eG-0007nJ-Jr
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1753416161;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=8TN9tUSLCYWXExmcc29tGcALWAliTign8XV4t6pbJi8=;
 b=zXWt7P2JKLhld9UEFMruZ/0jvGmsPulVCiPljP0uZnayGlhsO6u4w5mYPPaoYefRwPx9X7
 Npn3fZm0guLoo8BjJ9YRnBq2QOH+iwfisvy9vr2xwxT6Nr6TwEZ7PuvyW5O+EeGDm9A5TB
 ZnOMH4ddQnHNgdjHVO0j+H0S5/uVXWJAskAdimZehwEm4XZ2ceg94QDdBC0qC0QVXHAVRe
 RNRS9vMY6PhlKP7GmAo/PrFmwosznz2aYitYXkpwigfEijQaKZyJo3nJ+xzRWr5LLQ8YVd
 rcr0anrn+nlhYl1FBzC484TCy/mc95zQvjzkFMLYSD0Uadt/KlA5g1taOQHkwQ==
Message-Id: <225afcba-0865-4caa-8fc4-b425026f1c7f@lanxincomputing.com>
Content-Language: en-US
X-Lms-Return-Path: <lba+2688301df+cf6d1f+nongnu.org+liujingqi@lanxincomputing.com>
To: "Sunil V L" <sunilvl@ventanamicro.com>, <qemu-riscv@nongnu.org>, 
 <qemu-devel@nongnu.org>
In-Reply-To: <20250724110350.452828-2-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
References: <20250724110350.452828-1-sunilvl@ventanamicro.com>
 <20250724110350.452828-2-sunilvl@ventanamicro.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>, 
 "Andrew Jones" <ajones@ventanamicro.com>, 
 "Anup Patel" <anup@brainfault.org>, 
 "Atish Kumar Patra" <atishp@rivosinc.com>
Date: Fri, 25 Jul 2025 12:02:36 +0800
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS;
 Fri, 25 Jul 2025 12:02:38 +0800
Subject: Re: [PATCH v2 1/3] bios-tables-test-allowed-diff.h: Allow RISC-V FADT
 and MADT changes
Received-SPF: pass client-ip=118.26.132.13;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-13.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/24/2025 7:03 PM, Sunil V L wrote:
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>

Thanks,
Nutty
>   tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..0c3f7a6cac 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,3 @@
>   /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/riscv64/virt/APIC",
> +"tests/data/acpi/riscv64/virt/FACP",

