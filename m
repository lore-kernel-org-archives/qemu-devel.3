Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F23CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 11:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umsU2-0005Me-Q9; Fri, 15 Aug 2025 07:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1umsU0-0005LN-RT
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 07:20:28 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1umsTx-00055Z-Qk
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 07:20:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1755256811; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NEH1gClwHKfn1nKP4/D3em2TxlcitZnlWfbnrbNNVBrgw9WFv46V+BIJzkZ9ybZz4Ry7HQpWQUszhGbatkFnRANQacaA21x0OnZ9ZJ4lzj4qzO0q/kxVK1TWO/mF1ZYwxdujmSlN9f+g5r0viG2xxgMvo05QvmoA7ZV4qwPg5ZU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1755256811;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=x59mXNqTHH6DndKIEW6RkrV13w99ed2Gs1dTb8diOMU=; 
 b=HsZ7CZQ21wDpaJBM57/hIPviPM5n2nyBiWgHfgPSLT+7VdmpZ7B6cij0cF9HdMOsFHhbZoEJO/hrP+VK5NlK3kU1e/k73Q7ghhBiu62Voh3cFpnVdTg4b9PBS0L45eUkLLlgymYtAmMaXf0W6Ortm3qXRT2zrN5ByBl9BskDfb4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755256811; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=x59mXNqTHH6DndKIEW6RkrV13w99ed2Gs1dTb8diOMU=;
 b=Ad+ASycalJid+4Q9rM9rRhPuQD+I0CRVWcXrQ9k8vF8/MKRbdq4kR2uGvOjl8DBQ
 PaBlPfYkfS/psexLgmhn5if8cYH1N0/V26JdA86ZR/quQ58I9Io5lBVDHTrKfpWl+pK
 rNeq1urDJjiXICUW5PnzqcROFfE2NxyKLLBqdS1E=
Received: by mx.zohomail.com with SMTPS id 1755256809896175.31540564798138;
 Fri, 15 Aug 2025 04:20:09 -0700 (PDT)
Message-ID: <6efb8907-72bf-406a-9975-84f85b37c7cc@collabora.com>
Date: Fri, 15 Aug 2025 14:20:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v3 1/1] Default disable ignore guest PAT quirk
 (second revision)
To: ~myrslint <myrskylintu@proton.me>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <175519305258.21579.8228319741764786681-1@git.sr.ht>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <175519305258.21579.8228319741764786681-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/13/25 20:53, ~myrslint wrote:
> From: myrslint <qemu.haziness801@passinbox.com>
> 
> Most Intel CPUs in current use have self-snoop. The few added lines of
> code also check for availability of the quirk disablement option so if
> some CPU does not have this feature no change of behavior will occur.
> 
> Signed-off-by: Myrsky Lintu <qemu.haziness801@passinbox.com>
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2943
> ---
> Thanks to Alex Bennée <alex.bennee@linaro.org> for the kind code review
> and helpful guidance.
> 
>  target/i386/kvm/kvm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 369626f8c8..124818bf94 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -16,6 +16,7 @@
>  #include "qapi/qapi-events-run-state.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> +#include <asm-x86/kvm.h>
>  #include <math.h>
>  #include <sys/ioctl.h>
>  #include <sys/utsname.h>
> @@ -3367,6 +3368,24 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          }
>      }
>  
> +/* if kernel version does not have it there is no point compiling this in */
> +#ifdef KVM_X86_QUIRK_IGNORE_GUEST_PAT

QEMU uses own copy of kernel headers, I expect this define should be
always available.

-- 
Best regards,
Dmitry


