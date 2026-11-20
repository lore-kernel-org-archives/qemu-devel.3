Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446E5606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=KVF96pjS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xURSX-0005vy-IT; Fri, 20 Nov 2026 11:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xURSV-0005v8-T3; Fri, 20 Nov 2026 11:27:31 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xURSU-0001Pr-GW; Fri, 20 Nov 2026 11:27:31 -0500
Received: from example.com (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id B394B20B716A;
 Fri, 20 Nov 2026 08:27:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B394B20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795192046;
 bh=IcSuwhdaIF0AQ3NHWe6LRgGflJofWhyaXaOoheSiOK8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KVF96pjS4mmn70APZgWUad7Sv3LfWMd+Ei2vxMzpU8W1qS2D5Yo+C0pxznwE508Xc
 LUPWxOlxRfQB2Q8Vadzitm2iRLTMe2JqJ+gJF1kvIdFEwRQ8KNU6qV2cpHJW0El2O0
 t9Wq+kXfKycfUcc+1V6vUpWua20/RmhDuNmlNKKc=
Date: Fri, 20 Nov 2026 17:27:23 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Aastha Rawat <aastharawat@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v6 14/14] MAINTAINERS: updates for MSHV arm64 code
Message-ID: <awB06zoEFU0451Y4@example.com>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-14-aefe5e76a0e3@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-14-aefe5e76a0e3@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 01, 2026 at 10:52:59AM +0000, Aastha Rawat wrote:
> From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
> 
> Add myself and Aastha Rawat as maintainers.
> 
> Add Magnus Kulke as reviewer.
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1312bbd1bd..84a911ac26 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -624,6 +624,14 @@ S: Supported
>  F: target/i386/mshv/
>  F: hw/i386/mshv/
>  
> +ARM64 MSHV CPUs
> +M: Anirudh Rayabharam <anirudh@anirudhrb.com>
> +M: Aastha Rawat <aastharawat@linux.microsoft.com>
> +R: Magnus Kulke <magnus.kulke@linux.microsoft.com>
> +S: Supported
> +F: target/arm/mshv/
> +F: hw/intc/arm_gicv3_mshv.c
> +
>  X86 Instruction Emulator
>  M: Roman Bolshakov <rbolshakov@ddn.com>
>  R: Phil Dennis-Jordan <phil@philjordan.eu>
> 
> -- 
> 2.45.4

It might makes sense to add this earlier in the series and extend it as
we go ahead. this should address the checkpatch warnings in the series.

