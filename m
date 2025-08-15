Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403D9CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 10:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umrr5-0002PB-Bi; Fri, 15 Aug 2025 06:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umrr3-0002Kl-5j
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:40:13 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umrr1-00079i-65
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:40:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AF84E6115D;
 Fri, 15 Aug 2025 10:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9F6C4CEF0;
 Fri, 15 Aug 2025 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755254409;
 bh=0Z6U6h5hL4e6LwCbBbORf/S1yqkxUl6fXX2jtrZsb20=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tEVBP3Pk9D839YPgefo5iS46uqn4ALyAZihaNVCg1yJQ4gKYa8P93OnYCVbAo2hQp
 cGpJrDLwV+eL5UVYieQd1IbZjT+dI73lFvFx2UpI3FEbU6VDBcrKDC7LOpTt7oo0RX
 xSr8GsMLOevR/8I1YWwGxAxJCMXpB0Bre/QUckYA7K+/8ruI9cPw/sE+3T5Z0TmCOu
 JDoHRBzIjpGSEwVKg/1bmEDbqzbqhi8TVwaOvsWB//1Hm7vTFEt2fAv8BzoYdZSsD3
 CqtDEQwY8nHTH94qjzyn7EsNzJ2GZiN3whSXAgAOBpwzu4hDJbBrZu6r+1ceUdCPsD
 zNSiY8Fih8iaw==
Date: Fri, 15 Aug 2025 12:40:05 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH for-10.2 8/8] MAINTAINERS: Put kernel-doc under the
 "docs build machinery" section
Message-ID: <20250815124005.6a93d35b@foz.lan>
In-Reply-To: <20250814171324.1614516-9-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
 <20250814171324.1614516-9-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Em Thu, 14 Aug 2025 18:13:23 +0100
Peter Maydell <peter.maydell@linaro.org> escreveu:

> We never had a MAINTAINERS entry for the old kernel-doc script; add
> the files for the new Python kernel-doc under "Sphinx documentation
> configuration and build machinery", as the most appropriate
> subsection.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a07086ed762..efa59ce7c36 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4436,6 +4436,8 @@ F: docs/sphinx/
>  F: docs/_templates/
>  F: docs/devel/docs.rst
>  F: docs/devel/qapi-domain.rst
> +F: scripts/kernel-doc
> +F: scripts/lib/kdoc/

If you want, feel free to add me there either as maintainer or
reviewer. I can gladly help you maintaining it.

Either way:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

-

PS.: On a side note, there is a RFC still under discussion about
moving the script location upstream to tools/docs. Nothing decided
yet. One of the points we're still unsure is where we would place
the library directory. So, this may end being slipping to the next
kernel cycle.


>  
>  Rust build system integration
>  M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



Thanks,
Mauro

