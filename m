Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4111C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1YTj-0005Yx-Lh; Mon, 29 Apr 2024 17:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s1YTh-0005XT-Go
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:24:01 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s1YTf-0002AT-I9
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:24:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5979BCE0AE4;
 Mon, 29 Apr 2024 21:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE307C113CD;
 Mon, 29 Apr 2024 21:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714425833;
 bh=xqsmqm8rw3TovkzJT52C1+D+VhlYzMuH2fmslDrJilc=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=uhOIRTk26ZOhI4d4WeseDizHziZGux/HIrxhfylyBVZRoS5tZXRdGR+77AEvA0O6w
 sQJGrXHTME3c5pIq5lgs5uLgXNeUu/7+VzvHFmjJquGiqJZ++MHDlmjIV4UwPAIfpE
 +ZQ66nLjKaQBgKClR4EaUZSfZOJPQ1eCgkaDE+KYSlkmHrHYuxfvHlNATecZr6gkIR
 ezR3zpBwOac8j9uxvmIQLUQO0p0ceWayDSosCmdsUPiC4XDhdbC9gWp+JR/oZQkj7d
 tHfWbReo1VKgCzsCDIVuM5G9HQ9U28N5A874H5O2vhcnc/wcmloAmXkztHAFAk0t52
 Tp0Surhwhe0Eg==
Date: Mon, 29 Apr 2024 14:23:51 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Anthony PERARD <anthony.perard@citrix.com>
cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Paul Durrant <paul@xen.org>, Anthony PERARD <anthony@xenproject.org>
Subject: Re: [PATCH] MAINTAINERS: Update my email address
In-Reply-To: <20240429154938.19340-1-anthony.perard@citrix.com>
Message-ID: <alpine.DEB.2.22.394.2404291423440.3940@ubuntu-linux-20-04-desktop>
References: <20240429154938.19340-1-anthony.perard@citrix.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=145.40.73.55; envelope-from=sstabellini@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Mon, 29 Apr 2024, Anthony PERARD wrote:
> From: Anthony PERARD <anthony.perard@citrix.com>
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 302b6fd00c..ea9672fc52 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -532,7 +532,7 @@ Guest CPU Cores (Xen)
>  ---------------------
>  X86 Xen CPUs
>  M: Stefano Stabellini <sstabellini@kernel.org>
> -M: Anthony Perard <anthony.perard@citrix.com>
> +M: Anthony PERARD <anthony@xenproject.org>
>  M: Paul Durrant <paul@xen.org>
>  L: xen-devel@lists.xenproject.org
>  S: Supported
> -- 
> Anthony PERARD
> 

