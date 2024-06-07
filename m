Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69854C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 14:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFaCp-0004LP-5f; Fri, 07 Jun 2024 10:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sFaCn-0004Kw-JZ; Fri, 07 Jun 2024 10:04:33 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sFaCl-0002Ew-4r; Fri, 07 Jun 2024 10:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=GIYnsST43nefCECPfrzEHy5iEPGuAaIBorJIrZwMoX4=; b=U7vugKpFZdPqg4F0
 vgEyaHgZLPH97e3nA+g+uSBD6CBFSGKwuOJMn8nAD7n8Q43eo09qTUBtegdp5Byab6ihFt3eyZYQG
 OWJ6Q64FECDiiHFzkj/4ANEH4OAlrup2zBbSAqeeupU2UCx5muQbGxvp26ppSETuNYIbAHsWsmJAY
 VPqsH0oSKr89nLUOsEzGthohyi5xTT4r/BLaIPTubFDh7JO1Evhk2GPLi6sovDhkCOIwTcNfTyteO
 Xk1efhMWjQe7Tr+zvr02wi0CuVLUWlZraJ9CPYw/xulYnM2ACxG/H5BDRZPYCN17n08ncXHfUUWB4
 keJOUAxvP1NmPBM1Xw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sFaCg-0050k1-3A;
 Fri, 07 Jun 2024 14:04:26 +0000
Date: Fri, 7 Jun 2024 14:04:26 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: peter.maydell@linaro.org, laurent@vivier.eu, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/7] Remove some unused structures
Message-ID: <ZmMTPvLUaB4tGvbk@gallifrey>
References: <20240505171444.333302-1-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240505171444.333302-1-dave@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:01:06 up 30 days, 1:15, 1 user, load average: 0.02, 0.04, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* Dr. David Alan Gilbert (dave@treblig.org) wrote:
> A bunch of structs that are currently unused,
> found with a simple script and a bit of eyeballing.
> 
> The only one I'm that suspicious of is the SPARC
> one, where the patch which removed the use is a bit
> confusing to me.

Copying in Trivial; I think there are 4 of these that
are still outstanding:

   [PATCH 1/7] linux-user: cris: Remove unused struct 'rt_signal_frame'
      (Although cris is going)
   [PATCH 3/7] linux-user: sparc: Remove unused struct 'target_mc_fq'
   [PATCH 5/7] hw/arm/bcm2836: Remove unusued struct 'BCM283XClass'
   [PATCH 7/7] net/can: Remove unused struct 'CanBusState'

Can Trivial pick these up please?

Dave

> Tested with a 
>   --target-list=ppc-softmmu,m68k-softmmu,x86_64-softmmu,arm-softmmu,aarch64-softmmu,cris-linux-user,i386-linux-user,sparc-linux-user
> and 'make check' on x86 linux.
> 
> Dave
> 
> Dr. David Alan Gilbert (7):
>   linux-user: cris: Remove unused struct 'rt_signal_frame'
>   linux-user: i386/signal: Remove unused fp structs
>   linux-user: sparc: Remove unused struct 'target_mc_fq'
>   hw/usb/dev-network: Remove unused struct 'rndis_config_parameter'
>   hw/arm/bcm2836: Remove unusued struct 'BCM283XClass'
>   target/ppc: Remove unused struct 'mmu_ctx_hash32'
>   net/can: Remove unused struct 'CanBusState'
> 
>  hw/arm/bcm2836.c          | 12 ------------
>  hw/usb/dev-network.c      |  8 --------
>  linux-user/cris/signal.c  |  8 --------
>  linux-user/i386/signal.c  | 10 ----------
>  linux-user/sparc/signal.c |  5 -----
>  net/can/can_host.c        |  6 ------
>  target/ppc/mmu-hash32.c   |  6 ------
>  7 files changed, 55 deletions(-)
> 
> -- 
> 2.45.0
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

