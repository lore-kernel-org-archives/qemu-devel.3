Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3323CCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 02:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNLux-0005KB-RY; Sun, 23 Nov 2025 21:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vNLuh-0005HP-BH; Sun, 23 Nov 2025 21:02:56 -0500
Received: from out28-43.mail.aliyun.com ([115.124.28.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vNLud-00068L-Tl; Sun, 23 Nov 2025 21:02:45 -0500
Received: from 10.13.14.160(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.fUE66VN_1763949749 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 24 Nov 2025 10:02:30 +0800
Message-ID: <58606acd-6a62-41e1-94c7-bd9fce381b1a@zevorn.cn>
Date: Mon, 24 Nov 2025 10:02:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dbarboza@ventanamicro.com
Cc: ajones@ventanamicro.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 zhiwei_liu@linux.alibaba.com, wangjingwei@iscas.ac.cn
References: <20251111182944.2895892-2-dbarboza@ventanamicro.com>
Subject: Re: [PATCH v4 1/5] target/riscv/cpu.c: remove 'bare' condition for
 .profile
From: Chao Liu <chao.liu@zevorn.cn>
In-Reply-To: <20251111182944.2895892-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.28.43; envelope-from=chao.liu@zevorn.cn;
 helo=out28-43.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On Tue, 11 Nov 2025 15:29:40 -0300, Daniel Henrique Barboza wrote:
>We want to configure other CPU types to use profiles as an alternative
>to adding every profile extension explicitly, i.e. a profile is nothing
>more than an extension bundle.
>
>This means that a vendor CPU can set .profile=rva23s64 while having the
>same handling as any other vendor CPU. Same thing with all other CPU
>types.
>
>Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Tested-by: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>

Thanks,
Chao
>---
> target/riscv/cpu.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>index 73d4280d7c..975f7953e1 100644
>--- a/target/riscv/cpu.c
>+++ b/target/riscv/cpu.c
>@@ -2792,7 +2792,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c,
const void *data)
>         mcc->def->bare |= def->bare;
>         if (def->profile) {
>             assert(profile_extends(def->profile, mcc->def->profile));
>-            assert(mcc->def->bare);
>             mcc->def->profile = def->profile;
>         }
>         if (def->misa_mxl_max) {

