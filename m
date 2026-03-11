Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CE01125857
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0N1M-0000pu-9G; Wed, 11 Mar 2026 13:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0N1K-0000l2-IA; Wed, 11 Mar 2026 13:06:54 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0N1I-0001sz-VE; Wed, 11 Mar 2026 13:06:54 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E123E6183B;
 Wed, 11 Mar 2026 17:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF26C19421;
 Wed, 11 Mar 2026 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773248809;
 bh=6do/x3nSHARoGumEr/ygC4hXYhlUITBqSvKCMz+BPHY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ne+p/bTaJnVDH2b1ykwhCbETpzfuq0S5wTy902sUkOpZw8edIPsVcO0Jf4CAH8EnX
 l3hKEdyChM9SR3rZA/hOMlbBkttjPDKj7QcU9o0DbAduBTBl21IJzCK9t1hQyYcs8r
 Dyl9GQ53yE0k4m5za9PTtUtBm6UDzQ4fie4bTbITUwvs+XWBLPlY29SeX/LEYjsYpf
 Q01lYBSf+WxVarf0aBfafyOYWLp8Q0pp3/onfboIFsnEMEBMgM1ayoCnO246+Q4hzy
 wFUSFM6qU1ivdJ5NwZfoW7J7tYR088tXyxnz4OwCzfkYYu0TRX0vW/y0KjxrBNpFP1
 0GDLAx2MFkwzg==
Date: Wed, 11 Mar 2026 17:06:48 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 02/14] accel/mshv: move msr.c to target/i386
Message-ID: <20260311170648.GA3612627@liuwe-devbox-debian-v2.local>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-2-c31699b7bc1f@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-2-c31699b7bc1f@anirudhrb.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=tor.source.kernel.org
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

On Wed, Mar 11, 2026 at 03:15:29PM +0000, Anirudh Rayabharam wrote:
> From: Aastha Rawat <aastharawat@linux.microsoft.com>
> 
> This file has x86 specific implementations. Move this file to i386
> folder in preparation for ARM64 MSHV support.
> 
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

