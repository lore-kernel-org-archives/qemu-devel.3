Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B26103E2E6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 20:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0QX2-0001iQ-62; Wed, 11 Mar 2026 16:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0QX0-0001hf-22; Wed, 11 Mar 2026 16:51:50 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0QWw-0007DN-DU; Wed, 11 Mar 2026 16:51:49 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DEC6360054;
 Wed, 11 Mar 2026 20:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C565C4CEF7;
 Wed, 11 Mar 2026 20:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773262304;
 bh=zqB3f7gRlQT9hszh/V7dueCCjvnPWrQ76qWZkZlR53o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OPb2DLpGqEJ2sHQC2gKUrQTTP4a9+muvwk+y59nnStsHcbmr+uiY9zWy+XJHWjuRO
 b6sJ83J2PTE9urrBOYqQEKFsS60XKXx98QDjjMHRG3Kiznk/c3LCLWb9BwMQyf1ZyX
 2KGzMBYEqHJmsJ7ZauQZHeO6kYmuUySd9ewB4fBFHGIZ/2yJENu8mttphrwFR0yg2C
 qYECQjEnxP/MRQ19vf3icU5OaaOtizXHpr3xepywWRvgaibw8GNc/ksiFEcIAeM+0N
 Qe/XOz2WPI5152jVPa7gTVDNEwiN6fMlH1qI8oV5K7JTQ+pqmPmXKCDAqbDlDEPVv5
 1lYBpmSpxjy8w==
Date: Wed, 11 Mar 2026 20:51:42 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 08/14] accel/mshv: Add access_vp_regs synthetic proc
 features
Message-ID: <20260311205142.GC3612627@liuwe-devbox-debian-v2.local>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-8-c31699b7bc1f@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-8-c31699b7bc1f@anirudhrb.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=wei.liu@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 03:15:35PM +0000, Anirudh Rayabharam wrote:
> From: Aastha Rawat <aastharawat@linux.microsoft.com>
> 
> Enable access_vp_regs feature for regs. In arm64, this feature bit
> allows the guest to set VP registers using hypercall. This wasn't
> required for x86 because such registers are set using wrmsr instead of
> hypercall.
> 
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c     |  1 +
>  include/hw/hyperv/hvhdk.h | 87 +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 85 insertions(+), 3 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index d63b3a53bf..563599ef6a 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -199,6 +199,7 @@ static int set_synthetic_proc_features(int vm_fd)
>      features.tb_flush_hypercalls = 1;
>      features.synthetic_cluster_ipi = 1;
>      features.direct_synthetic_timers = 1;
> +    features.access_vp_regs = 1;

What's the side effect for enabling this for x86?

Wei

