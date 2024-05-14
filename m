Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9A9C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 16:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6v1t-0000pP-F3; Tue, 14 May 2024 12:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6v1r-0000p1-BG
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:29:27 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6v1o-0005YC-5p
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:29:27 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 292D8612D8;
 Tue, 14 May 2024 16:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574D7C2BD10;
 Tue, 14 May 2024 16:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715704162;
 bh=SQUHsmp4KnShQLN7DNByE6XuVqjt+RCY/un63jjC/wQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iojuUk/g7zPPK0/HfNAk50Bgcqpk8G2Xm0D6AuH4Rd0zoiCiANbjAa6t5JQkzJTS7
 vBuHJXBpnn69xtN+9mWphMY4kfi2Vb/FRPqxKFYUCnw0+IODifQBglPq0MCooF0/4n
 Ee83MODr9UnYG2doOIlJkOkygqFWIu8V0+hYhoPvjd1K9IqI/ttHNNsBsPld5ifW6X
 cmweihgssxgh8gUX9QPJa8BKw2yXR3HhRTDy4IV8reC9IidP48RiP0Ar3wLQzoHRMd
 An3v0mc03GY9yNwOThOE8aZpLNSdlAEEzJ+ssXO48G198x12uTNBBc1XAuHSICs6h4
 +VnUNrHt22oZg==
Date: Tue, 14 May 2024 18:29:18 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 23/45] target/hppa: Use TCG_COND_TST* in do_unit_addsub
Message-ID: <ZkORXsKOvrs0Ivmc@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-24-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-24-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Richard Henderson <richard.henderson@linaro.org>:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

