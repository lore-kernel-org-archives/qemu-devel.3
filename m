Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D290C28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJdV-0006qb-KB; Wed, 12 Mar 2025 06:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tsJdN-0006q7-PX
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:48:22 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tsJdM-0003ta-32
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=cZ1mBT5/d8E3rCtiVWB857TR4DFOkzhlKjIhkYLPGbU=; b=vwLY+i0l3j2wpWn
 eUb/9BVO0NC9Ti5GTvaWLrxbGHeRIu3N6x/OWM3og87jeKV0inkF6iL4Ih/Ks9mA3d/SPWR/qsN/1
 gGgedoieyaS0rO5l4GuF+RxXeAFySe3g+1h6zJa7etkXEIod4FDjMPco0MtbvZecvvtngk7lFVb5b
 D8=;
Date: Wed, 12 Mar 2025 11:48:26 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Alessandro Di Federico <ale@rev.ng>
Subject: Re: [PATCH-for-10.1 0/2] target/hexagon: Remove use of MO_TE
 definition
Message-ID: <whiqdt7kjmgkhldemb3sjisggdz4xtyqvust53cy4fo44by63t@vndlilk5bmci>
References: <20250312103238.99981-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250312103238.99981-1-philmd@linaro.org>
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

On 12/03/25, Philippe Mathieu-Daudé wrote:
> In order to make QEMU core components endian agnostic,
> we need to remove the use of the target-specific MO_TE
> definition. For Hexagon it is easy as it is equivalent
> of MO_LE, since the target is only little-endian.
> 
> Philippe Mathieu-Daudé (2):
>   target/hexagon: Explode MO_TExx -> MO_TE | MO_xx
>   target/hexagon: Replace MO_TE -> MO_LE
> 
>  target/hexagon/macros.h                     | 10 +++++-----
>  target/hexagon/genptr.c                     |  8 ++++----
>  target/hexagon/idef-parser/parser-helpers.c |  2 +-
>  target/hexagon/translate.c                  |  6 +++---
>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> -- 
> 2.47.1
> 

Series:

Reviewed-by: Anton Johansson <anjo@rev.ng>

