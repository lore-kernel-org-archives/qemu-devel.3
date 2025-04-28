Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F72C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 18:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9TBL-00032O-OQ; Mon, 28 Apr 2025 14:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1u9TBJ-00031v-5I
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:26:17 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1u9TBF-0006AV-9z
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=wFezQOD2yscSntukfZyFluygScON3XlQ63DIYS6cFHE=; b=L2D335qpVTXbSdv
 3vgvpukHTFaMxKniVf2CfcL+Vuw4AiwCak15u04HIIgzmc/ilEpWXgNlSc9IaylDnH6+pSo9oqa6T
 CaW6xwynT8JPtRSD95XdsJutpIgazylQlyeeDB9GDZUP5QnAmadGl4ZMjZhuTyC1YRIXaNByAz/CJ
 2s=;
Date: Mon, 28 Apr 2025 20:27:17 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v3 09/13] accel/tcg: Include 'accel/tcg/getpc.h' in
 'exec/helper-proto'
Message-ID: <ll6avykvfgf7yn27pwe7qvquq7udalqwzfaf6xdxxh7rfmh7q4@kwscgnbg5hb2>
References: <20250424202412.91612-1-philmd@linaro.org>
 <20250424202412.91612-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424202412.91612-10-philmd@linaro.org>
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

On 24/04/25, Philippe Mathieu-Daudé wrote:
> Most files including "exec/helper-proto.h" call GETPC().
> Include it there (in the common part) instead of the
> unspecific "exec/exec-all.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/exec/exec-all.h            | 1 -
>  include/exec/helper-proto-common.h | 2 ++
>  accel/tcg/translate-all.c          | 1 +
>  target/avr/helper.c                | 1 -
>  4 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 4c5ad98c6a9..816274bf905 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -26,7 +26,6 @@
>  #include "exec/vaddr.h"
>  
>  #if defined(CONFIG_TCG)
> -#include "accel/tcg/getpc.h"
>  
>  /**
>   * probe_access:
> diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
> index 16782ef46c8..76e6c25becb 100644
> --- a/include/exec/helper-proto-common.h
> +++ b/include/exec/helper-proto-common.h
> @@ -13,4 +13,6 @@
>  #include "exec/helper-proto.h.inc"
>  #undef  HELPER_H
>  
> +#include "accel/tcg/getpc.h"
> +

Non-TCG builds will fail since exec/helper-proto.h is sometimes
included outside CONFIG_TCG (e.g. target/arm/debug_helper.c).

-- 
Anton Johansson
rev.ng Labs Srl.

