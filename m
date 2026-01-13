Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551ADD29DFE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 10:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfbNu-0004mL-9h; Tue, 13 Jan 2026 05:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vfbNt-0004lp-1I
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:12:21 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vfbNr-0008Ii-JN
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=cW4Jpa7P58idfvRllxXShWKJjqY3peYavFk+J7WNFZE=; b=xfXT2KVJbVehPDY
 mDj8E5DCLlVfwYZ0KkOomqwF6dgDiWr+fVz3TVhfxoPS0Dwl1wejwBeIvHPn96eXKfbjMd1sP6Hdn
 ZBtm02tMtuxMrVwRuXjUYuMTdnoB/qjnjFMLalXdPoKrnwQRe23767kMaQH2hyh/fIhmVU5f9wnQp
 CU=;
Date: Tue, 13 Jan 2026 11:15:52 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 4/7] target/xtensa: Build system units in common source set
Message-ID: <jgziopu6sjnnyj6hrrrkoookx7t7ekdjvvrlx7rz46zv5tkfsg@sfdeent7vwnr>
References: <20260107202556.55787-1-philmd@linaro.org>
 <20260107202556.55787-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107202556.55787-5-philmd@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 07/01/26, Philippe Mathieu-Daudé wrote:
> These files are now free of target-specific symbols,
> build them as common files (thus forbidding further
> uses of such target-specific symbols).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/xtensa/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/xtensa/meson.build b/target/xtensa/meson.build
> index f8d60101e3d..69c6946420a 100644
> --- a/target/xtensa/meson.build
> +++ b/target/xtensa/meson.build
> @@ -24,4 +24,4 @@ xtensa_system_ss.add(files(
>  ))
>  
>  target_arch += {'xtensa': xtensa_ss}
> -target_system_arch += {'xtensa': xtensa_system_ss}
> +target_common_system_arch += {'xtensa': xtensa_system_ss}
> -- 
> 2.52.0
> 
> 

all of dbg_helper.c, mmu_helper.c, monitor.c, and xtensa-semi.c include
cpu.h, change to target/xtensa/cpu.h.

Otherwise,

Reviewed-by: Anton Johansson <anjo@rev.ng>

