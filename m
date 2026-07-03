Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52E2C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfa60-0001UO-0K; Fri, 03 Jul 2026 05:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wfa5x-0001Ty-LJ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:22:01 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wfa5u-00056w-3c
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783070506;
 bh=quaLGm9YXXKuirAoMlsG3+1l08cmGxjhb3Wat/twfZY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mkdPZl+u4uCZkwYk1iy6zOY04oRbb158trKKCnY2rQMbIWYzoqHXUlt2L56BbvzXr
 B1mg5qHjmunVr0hsTr7T2inVHK1v6q6vt9zOz6WNBBK6P9VKWK0w40fPq21Q8tn9CI
 XoWeLPfDyxjQyGs2UKp2RAQ74pPVXa16dDha1H7WSK3H9i+WPBOa1K3wRz+WonZmeH
 74mBRLDVIa8COZqzBha4NPEDF6TRlQ6uoxlggcSv1+QjxMJvT1B+NxZoJ+nmHiGT4D
 xctxLCOKvrEyDlOd5pDMprkyujauyIkCq/im3Osfv9Hmk6I1DDWi5GjkEWX8qB3Pur
 zt0cspl+nh9Ug==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 6B35A300139;
 Fri,  3 Jul 2026 09:21:46 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id BDCCC37C8C7;
 Fri,  3 Jul 2026 17:21:44 +0800 (CST)
Message-ID: <3cd4e663-d443-499f-9655-39328ec5a763@sjtu.edu.cn>
Date: Fri, 3 Jul 2026 17:21:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] contrib/plugins: add dlcall to call host functions
 from a guest
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260701155705.1737328-1-functioner@sjtu.edu.cn>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <20260701155705.1737328-1-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed,  1 Jul 2026 23:57:03 +0800, Ziyang Zhang wrote:
> Hi,
> 
> This patch adds a single plugin, contrib/plugins/dlcall.c (~240 lines,
> no changes to QEMU core), that lets a linux-user guest call functions in the
> host's native shared libraries instead of emulating them.
> 

This PATCH is deprecated. I will add the ready-to-use toolchain and
submit another PATCH very soon.

> Changes since v4:
> 
>    * Added a documentation patch for docs/about/emulation.rst (Pierrick
>      Bouvier): what the plugin does, its trusted-guests and guest_base == 0
>      constraints, how to load it, and a minimal example, with a pointer to
>      Lorelei.
>    * The plugin's header comment now points to Lorelei as one complete
>      userspace implementation. The plugin code is otherwise unchanged.

