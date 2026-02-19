Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DE4E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 12:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt2sg-00034Q-0p; Thu, 19 Feb 2026 07:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vt2sb-000325-Sb
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:11:38 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vt2sX-00022a-Cu
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=GFrWxH5OEo/gKSHj3RjiYKvQnbhJ9FS6qkEUWbaM748=; b=MBTqvBTWn/GqDhN
 PChYFcDy7vsPtg36DLTh32i2EL9jmEC3jnfkXaHmqfKUrtXlf1kB+P0yHG88Eh6Ux0kUWfqZY7Cvw
 ONPZTbE2okO/nCj7Hzno4A7Jex8jZH7WqJCwJt5xttsCTb4vSGHOAWwlQusulOLNJRB1s+4VF7oNb
 zk=;
Date: Thu, 19 Feb 2026 13:15:08 +0100
To: deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 2/4] target/hppa: Update SeaBIOS-hppa to version 22
Message-ID: <aZb-q1ZALp2x_rVr@hive.localdomain>
References: <20260218201221.20958-1-deller@kernel.org>
 <20260218201221.20958-3-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260218201221.20958-3-deller@kernel.org>
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

On 18/02/26, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The new firmware includes support for an A400-44 machine
> with initial functional 64-bit PAT PDC support:
> - Linux 64-bit kernel runs nicely.
> - ODE 2006 works nicely on 715, B160L, and A400, but has problems on C3700.
> - MPE and 64-bit HP-UX11 need more work, although HP-UX11 boot up to a crash
>   where it reports where it had problems.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  pc-bios/hppa-firmware.img   | Bin 628952 -> 632048 bytes
>  pc-bios/hppa-firmware64.img | Bin 692032 -> 713608 bytes
>  roms/seabios-hppa           |   2 +-
>  3 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Anton Johansson <anjo@rev.ng>

