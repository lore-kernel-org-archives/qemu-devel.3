Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07113CD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPKNT-0007QD-Q6; Tue, 19 May 2026 09:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPKNR-0007Pz-DQ
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:20:53 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPKNN-0005dC-Gy
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:20:51 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 101DF40396;
 Tue, 19 May 2026 13:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8951DC2BCB3;
 Tue, 19 May 2026 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779196839;
 bh=Shsn2ucz9vdtqsQ3u2+YrLOXH8SKCLEg3GBAo0LoOOg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uyp0n0U2EuCr4mKn85lyWClS3DKYvUQSR3MyW/zQ6ScQpXjVCwstkhAYOXI1XB56D
 anY+wGm1EA1g+FqsamyotI1crxt/oj0A+k3qC3lu1q0WYtQL0+ncKbb8ZFZQJ73JTn
 k5i2l5JnI0vNLDX91eTjsu9X2d0m+fPRbXgqM/sb3Jk+4FCVkJ7n4pjBU8fHRTveJa
 FvCcRYx2h5t40NraMiU1zChWcFOJpnJWpXyIIXatXBhvQDnFhUNr97GTGHZFFg/Gl3
 f9OLOeMS9Pf+8b18OESJCB/EWSFDEP0YKqzoh63DNJsgujmy1fbfoFpWS2MB8IZpSU
 Hi1qxWFFDGD7w==
Date: Tue, 19 May 2026 15:20:35 +0200
From: Helge Deller <deller@kernel.org>
To: Emmanuel Ugwu <emmanuelugwu121@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, deller@gmx.de
Subject: Re: [PATCH 1/1] hw/scsi: add initial SCSI tape device emulation
Message-ID: <agxjo4dekaTHOVyF@carbonx1>
References: <20260513025854.76594-1-emmanuelugwu121@gmail.com>
 <20260513025854.76594-2-emmanuelugwu121@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513025854.76594-2-emmanuelugwu121@gmail.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Emmanuel,

* Emmanuel Ugwu <emmanuelugwu121@gmail.com>:
> From: kantnero <emmanuelugwu121@gmail.com>
> 
> Add a new scsi-tape device that attaches to a VirtIO SCSI bus.
> Implements realize and unrealize lifecycle only. SCSI command
> handling will follow in subsequent patches.

Ok.
 
> Signed-off-by: Emmanuel Ugwu <emmanuelugwu121@gmail.com>
> Signed-off-by: kantnero <emmanuelugwu121@gmail.com>

Please use the first only.

> ---
>  hw/scsi/meson.build |   1 +
>  hw/scsi/scsi-tape.c | 221 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 222 insertions(+)
>  create mode 100644 hw/scsi/scsi-tape.c
> 
> diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
> index 69fde0cf84..1699b6e591 100644
> --- a/hw/scsi/meson.build
> +++ b/hw/scsi/meson.build
> @@ -7,6 +7,7 @@ scsi_ss.add(files(
>    'scsi-bus.c',
>    'scsi-disk.c',
>    'scsi-generic.c',
> +  'scsi-tape.c',
>  ))
>  scsi_ss.add(when: 'CONFIG_ESP', if_true: files('esp.c'))
>  scsi_ss.add(when: 'CONFIG_ESP_PCI', if_true: files('esp-pci.c'))
> diff --git a/hw/scsi/scsi-tape.c b/hw/scsi/scsi-tape.c
> new file mode 100644
> index 0000000000..650f75471f
> --- /dev/null
> +++ b/hw/scsi/scsi-tape.c
> @@ -0,0 +1,221 @@
> +/*
> + *  SCSI Tape Device Emulation
> + *
> + *  Copyright (c) Emmanuel Ugwu <emmanuelugwu121@gmail.com>

Add copyright year.


I'm no qemu SCSI maintainer, but for me the rest looks OK.

I'm really looking forward to your first implementation!

Thanks!
Helge


