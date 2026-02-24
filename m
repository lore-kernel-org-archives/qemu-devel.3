Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FAFE9B258
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 12:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vurw8-0001NM-Te; Tue, 24 Feb 2026 07:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vurw3-0001M9-8j
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:54:43 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vurw1-0005zJ-NS
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=v+XzCnWgfephktn8rEWmsPunufruAOVczZ4xGS7u6eE=; b=rfs19pxN/zH7Sa4
 vZi1OoJvCFg4T9pyDMhBqi+Up925Gasl0RYIoFN11dg8Dcy3EgdE6EVD8+ax9O6S6aldFNN1dHGHw
 z15ZBjByV4sSMaoPTel1c42VnK2VlUWElR+45NphJ+Ewrz+N0Gn24AiKF8V+DsDTNpRe6ETqp3Goa
 fA=;
Date: Tue, 24 Feb 2026 13:58:09 +0100
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, 
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng
Subject: Re: [PATCH v3 1/8] Hexagon (target/hexagon) Properly handle Hexagon
 CPU version
Message-ID: <aZ2gG-UGIYSXnEQe@hive.localdomain>
References: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
 <20260217212245.95321-2-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260217212245.95321-2-ltaylorsimpson@gmail.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

On 17/02/26, Taylor Simpson wrote:
> Add the following CPU versions that were previously missing
>     v5
>     v55
>     v60
>     v61
>     v62
>     v65
> 
> Create a CPUHexagonDef struct to represent the definition of a core

           HexagonCPUDef :)



>     Currently contains an enum with the known Hexagon CPU versions
> Add a field to HexagonCPUClass to note the Hexagon definition
> 
> Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/cpu-qom.h | 27 +++++++++++++++++++++++
>  target/hexagon/cpu.h     |  2 ++
>  target/hexagon/cpu.c     | 46 ++++++++++++++++++++++++----------------
>  3 files changed, 57 insertions(+), 18 deletions(-)

Otherwise looks good,

Reviewed-by: Anton Johansson <anjo@rev.ng>

