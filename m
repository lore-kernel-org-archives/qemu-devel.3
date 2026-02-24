Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A07CE9B260
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 13:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vusLI-0000td-4q; Tue, 24 Feb 2026 08:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vusLE-0000tT-3d
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:20:44 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vusLA-000455-Px
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=O/gJeDJwDYsGM4bqCQYE+Se60q5nShQ4a1NktQfVP1o=; b=SooOd8bL87E1NGX
 soCH6lS49nc89c0BgKF1yAUy58oBwU9SHUj8WgmmuQrEEa2FgLUJgARvRQjD1ELn+TzwOoiA0gAyz
 G6MrTZlCJiCKAr50oyG8OszdiwISfXMcKjeDV8wwoJEi/fu8hHDtuXYRapy4gHvWIiVffgM5NPutY
 bU=;
Date: Tue, 24 Feb 2026 14:24:18 +0100
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, 
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng
Subject: Re: [PATCH v3 4/8] Hexagon (target/hexagon) Introduce
 tag_rev_info.c.inc
Message-ID: <aZ2mJz01cxh7PdLy@hive.localdomain>
References: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
 <20260217212245.95321-5-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260217212245.95321-5-ltaylorsimpson@gmail.com>
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
> From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> 
> Table that records which CPU revision introduced or removed
> for each opcode
> 
> Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/tag_rev_info.c.inc | 613 ++++++++++++++++++++++++++++++
>  1 file changed, 613 insertions(+)
>  create mode 100644 target/hexagon/tag_rev_info.c.inc
> 
> diff --git a/target/hexagon/tag_rev_info.c.inc b/target/hexagon/tag_rev_info.c.inc
> new file mode 100644
> index 0000000000..11c90f86ad
> --- /dev/null
> +++ b/target/hexagon/tag_rev_info.c.inc
> @@ -0,0 +1,613 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEXAGON_TAG_ARCH_TABLE_H
> +#define HEXAGON_TAG_ARCH_TABLE_H
> +
> +struct tag_rev_info { HexagonVersion introduced, removed; };
> +
> +static const struct tag_rev_info tag_rev_info[XX_LAST_OPCODE] = {
> +    [A5_ACS] = { .introduced = HEX_VER_V55, .removed = HEX_VER_NONE },

...

> +
> +    [A7_clip] = { .introduced = HEX_VER_V67, .removed = HEX_VER_NONE },
> +    [A7_croundd_ri] = { .introduced = HEX_VER_V67, .removed = HEX_VER_NONE },
> +    [A7_croundd_rr] = { .introduced = HEX_VER_V67, .removed = HEX_VER_NONE },
> +    [A7_vclip] = { .introduced = HEX_VER_V67, .removed = HEX_VER_NONE },
> +    [F2_dfmax] = { .introduced = HEX_VER_V67, .removed = HEX_VER_NONE },
> +    [F2_dfmin] = { .introduced = HEX_VER_V67, .removed = HEX_VER_NONE },
> +    [F2_dfmpyfix] = { .introduced = HEX_VER_V67, .removed = HEX_VER_NONE },
> +    [F2_dfmpyhh] = { .introduced = HEX_VER_V67, .removed = HEX_VER_NONE },
> +    [F2_dfmpylh] = { .introduced = HEX_VER_V67, .removed = HEX_VER_NONE },
> +    [F2_dfmpyll] = { .introduced = HEX_VER_V67, .removed = HEX_VER_NONE },
> +    [J2_callrh] = { .introduced = 0x73, .removed = HEX_VER_NONE },
> +    [J2_jumprh] = { .introduced = 0x73, .removed = HEX_VER_NONE },

I assume you missed HEX_VER_V73 here

With that fixed 

Reviewed-by: Anton Johansson <anjo@rev.ng>

