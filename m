Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20664F46455
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 12:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w26dg-0006v2-BR; Mon, 16 Mar 2026 08:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1w26dF-0006tL-68
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 08:01:13 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1w26dD-0008ND-Id
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 08:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=uFW1yqhSx996CG9f28N1De52ChQx1tF52wN5LNvVih8=; b=t/6SpZ/MYExX6X1
 KQUM7gzM3HER2rQR8dk7BoVj2vR+NOexOWNFxOFBi0SqHvCTM9iuZz0wxmXoEFekAksBy6hXYAIel
 uY/+kAbYMHlVB2u92BUhhA9HEvie3mTLj67nxlqB8Cb4jpKyA5jsh/mGvFhl666vVJBHIW5zk3hDa
 og=;
Date: Mon, 16 Mar 2026 13:04:51 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] target/i386: Replace target_ulong -> uint64_t for
 TARGET_X86_64
Message-ID: <abfxxDu_phL5-bfN@hive.localdomain>
References: <20260315165319.39727-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315165319.39727-1-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 15/03/26, Philippe Mathieu-Daudé wrote:
> These registers are only available on 64-bit builds, thus
> always handled as 64-bit. This isn't even a migration break
> because they are migrated as 64-bit since the beginning
> (see commit 02536f8b1f9 "x86_64 save/restore").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/cpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e5ae29f8af1..b0c730b3390 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2058,10 +2058,10 @@ typedef struct CPUArchState {
>      uint64_t vm_hsave;
>  
>  #ifdef TARGET_X86_64
> -    target_ulong lstar;
> -    target_ulong cstar;
> -    target_ulong fmask;
> -    target_ulong kernelgsbase;
> +    uint64_t lstar;
> +    uint64_t cstar;
> +    uint64_t fmask;
> +    uint64_t kernelgsbase;
>  
>      /* FRED MSRs */
>      uint64_t fred_rsp0;
> -- 
> 2.53.0
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

