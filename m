Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4F5FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIhI-0006YX-HB; Mon, 27 Apr 2026 05:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wHIh1-0006Ov-DW; Mon, 27 Apr 2026 05:56:05 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wHIgy-0007gp-6d; Mon, 27 Apr 2026 05:55:53 -0400
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id 2484A20B7169; Mon, 27 Apr 2026 02:55:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2484A20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777283751;
 bh=zY5Tw0hdsualF2Laut24t77kj/NHyUM6wI6JUYjCPmQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WRfFN0l9lqcrPXB920czyVbZSbDpjUdneb6imiB0jBa8iRTo3Xqz3mpHNkmVaX9W7
 5HD0n5f0H2/KVIs5vpYT/BIrF9mtWJ/GpNtk8D31LcmVJRbBy+9WhwIoM3q2bWZyIT
 NKQAdgdaVNXgCEeNR3rEd4Ymc6hq2Vxd4KKQ+RQQ=
Date: Mon, 27 Apr 2026 02:55:51 -0700
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH v3 01/14] accel/mshv: move msr.c to target/i386
Message-ID: <ae8ypzlA7dMOTfg7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-1-469f544778ba@linux.microsoft.com>
 <20260422052649.GA797788@liuwe-devbox-debian-v2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422052649.GA797788@liuwe-devbox-debian-v2.local>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 22, 2026 at 05:26:49AM +0000, Wei Liu wrote:
> On Tue, Apr 21, 2026 at 05:21:46AM +0000, Aastha Rawat wrote:
> > This file has x86 specific implementations. Move this file to i386
> > folder in preparation for ARM64 MSHV support.
> > 
> > Acked-by: Wei Liu <wei.liu@kernel.org>
> > Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> > Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> 
> Normally these tags go in chronological order.
> 
>  Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
>  Acked-by: Wei Liu <wei.liu@kernel.org>
>  Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> No need to resend. Just something to keep in mind for the future.
> 
> Wei

Got it, thanks!

Aastha

