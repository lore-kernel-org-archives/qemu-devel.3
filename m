Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2788FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 01:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdgbq-0005V3-IV; Mon, 12 Aug 2024 21:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sdgbn-0005UT-CV
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:45:59 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sdgbl-00009J-Li
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:45:59 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8EAA3CE1098;
 Tue, 13 Aug 2024 01:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FBCC4AF09;
 Tue, 13 Aug 2024 01:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723513543;
 bh=y7xq1E/AVCMdkVkPZZGZ9H2ZIIdZ94R5oUZ1GBbJ0EM=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=q6IONffbf9PePnTEjpMVzp/BFnjwhOSRDZUYQC/vXbIjaq5yrLw/f2nn1rmbA14iS
 2H/pvK9eDRg3/w/X0N02gNu8P8+VSGhB/9R1cTelc/Kfob5/5+BqJinWX2grM3JIvp
 eicAG9xCylyfm/HP1LPhNAq0Xx39p1iReKPwCnxB4OPm92sZ7GXGeHnCipzANzEtOB
 pleBhALP9lwvWXbm/W/muIFZHWF4IIZ0nBwEoEyjTUyBOtz7NpnuolUC2UKcM97Ky7
 mGX3+squm1cKIElDwSR+M5/rpvXjaUY4+3hKBYPbmYp8dZNWAG5C8SqWTYmXpQ/Qmu
 RWAFv3BR07o9Q==
Date: Mon, 12 Aug 2024 18:45:41 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 01/10] MAINTAINERS: Add docs/system/arm/xenpvh.rst
In-Reply-To: <20240812130606.90410-2-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2408121646290.298534@ubuntu-linux-20-04-desktop>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-2-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10af212632..a24c2e14d9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -559,6 +559,7 @@ F: include/hw/xen/
>  F: include/sysemu/xen.h
>  F: include/sysemu/xen-mapcache.h
>  F: stubs/xen-hw-stub.c
> +F: docs/system/arm/xenpvh.rst
>  
>  Guest CPU Cores (NVMM)
>  ----------------------
> -- 
> 2.43.0
> 

