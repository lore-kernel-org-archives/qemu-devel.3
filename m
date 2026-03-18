Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B06410775F1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uYA-00085S-4p; Wed, 18 Mar 2026 13:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1w2uY8-00085H-Le
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:19:16 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1w2uY4-0000h8-0u
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=avXXuhXrFjPAEVSFAD00HB5uqC0GwPcCWuMc0ac9l6o=; b=hBl3Y2hpB/cgTkW
 0ftCJKUHj28bsARUbdAwRqRkweKrY/L5YP5J/G1ExbTXkPQWjq7dhv8JLwbwzHhJvOrQ8sCkO5hTu
 wtLhJZUTJhZMIrlruCPzaq318QW5NufEENGJxu+7sl7oNVN8bV3MDB+ItAn2YedEf/z+DQR8QJYhr
 OQ=;
Date: Wed, 18 Mar 2026 18:22:54 +0100
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/6] hw/hppa: Fix description of the HP A400-44 server
Message-ID: <abrfZsDjs8dPG2eO@hive.localdomain>
References: <20260317195149.8386-1-deller@kernel.org>
 <20260317195149.8386-2-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317195149.8386-2-deller@kernel.org>
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

On 17/03/26, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The HP A400-44 machine has a height of 2U and is a noisy server machine
> which was usually running in the datacenter.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/hppa/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index ec63dc1297..e72dda2a68 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -840,7 +840,7 @@ static void HP_A400_machine_init_class_init(ObjectClass *oc, const void *data)
>      };
>      MachineClass *mc = MACHINE_CLASS(oc);
>  
> -    mc->desc = "HP A400-44 workstation";
> +    mc->desc = "HP A400-44 server";
>      mc->default_cpu_type = TYPE_HPPA_CPU_PA_8500;
>      mc->valid_cpu_types = valid_cpu_types;
>      mc->init = machine_HP_A400_init;
> -- 
> 2.53.0
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

