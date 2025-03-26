Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9ACC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 16:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txTws-0003F5-M4; Wed, 26 Mar 2025 12:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1txTwo-0003En-Qu
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 12:49:47 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1txTwn-00074Y-1X
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 12:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=uqs3nVSEDLTX3WSzeUOrqrcwsd59qotMKHM6F6OwNkM=; b=oU/aWVya4Dbk12c
 dcTYmBBEXIsOe9r0gczv84S3wWVYZlMxj3NbNmfEao3sXbqMzWC2R76HOHJFPH1fWtEhdbuV8LTbn
 FZ0I2yirazm/I65fZ2RhXWCPqFCLlrIF0kTeNzLb2hdxEUZMy0AUYMzLoDw9p50ZZrwx1L9zsQF3s
 fs=;
Date: Wed, 26 Mar 2025 17:50:19 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH-for-10.1 0/8] target/mips: Make 'cpu-qom.h' target agnostic
Message-ID: <zqjy2bvjr7os5lklrtfvulkcsfkcfximusiqfpi746xvidjjoq@eudwr657y4x7>
References: <20250325154058.92735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325154058.92735-1-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/03/25, Philippe Mathieu-Daudé wrote:
> - Remove the TARGET_MIPS64 use in 'cpu-qom.h' to
>   make it target agnostic
> - Introduce mips_cpu_is_64bit() as a runtime check
>   for compile time TARGET_MIPS64 definition
> - Replace the ldtul_p() gdbstub call by ldn_p()
> - Rename few symbols to avoid future linkage clash
> 
> Philippe Mathieu-Daudé (8):
>   cpus: Open code OBJECT_DECLARE_TYPE() in OBJECT_DECLARE_CPU_TYPE()
>   target/mips: Declare CPU QOM types using DEFINE_TYPES() macro
>   target/mips: Make MIPS_CPU common to new MIPS32_CPU / MIPS64_CPU types
>   target/mips: Prefix MMU API with 'mips_'
>   target/mips: Replace ldtul_p() -> ldn_p(sizeof(target_ulong))
>   target/mips: Introduce mips_cpu_is_64bit() helper
>   target/mips: Get CPU register size using mips_cpu_is_64bit()
>   target/mips: Introduce mips_env_64bit_enabled() helper
> 
>  include/hw/core/cpu.h               |  7 ++++-
>  target/mips/cpu-qom.h               | 14 +++++-----
>  target/mips/internal.h              |  5 ++++
>  target/mips/tcg/tcg-internal.h      |  2 +-
>  target/mips/cpu.c                   | 42 ++++++++++++++++++++---------
>  target/mips/gdbstub.c               | 14 +++++++---
>  target/mips/tcg/system/tlb_helper.c |  2 +-
>  7 files changed, 61 insertions(+), 25 deletions(-)
> 
> -- 
> 2.47.1
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

