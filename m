Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC80ACD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 06:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrXqd-0006vj-Tn; Tue, 02 Apr 2024 02:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1rrXqb-0006um-Bv; Tue, 02 Apr 2024 02:42:18 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1rrXqZ-0002s4-7e; Tue, 02 Apr 2024 02:42:17 -0400
Received: from localhost (sekoia-laptop.home.lmichel.fr [192.168.61.102])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 809C0C60172;
 Tue,  2 Apr 2024 08:42:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1712040131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ftWxsJLpk+n6OGLzL+MJBExDwuhHf9jlwwOi9Ck5Flk=;
 b=Fgx8vkzPjjg6bRUR0z/pECMZ7VSzKyitWZbHXjGRK+gLt8kBQh6aPdGYnWk2vsN3Yg5EKZ
 2NKCzqVFGLnYkNH+6hPe58k2vtF5TeuUxMN/prsPeirlCYDZkAxrw9l5F8VgMXlKOTwaSL
 cGXKI4M2U7+unSOOZNv0TbD2MCIHO0HIs9MounSQC7iY4pPgewOuBNIwMZShWDX6alXa1G
 s8F4suDCurXDNVtzRHBdZWzh/QzJRFIfDsNhljr07dNbFV+Ch4Hlc+3RXSkYUIiYGQSgG4
 vUwpo37WsTFaCVz3BQbZZ73O6fGM5Wcg7euCk3McXsYSRegOkSesJbt7oHg9Rw==
Date: Tue, 2 Apr 2024 08:42:11 +0200
From: Luc Michel <luc@lmichel.fr>
To: Stefan Weil <sw@weilnetz.de>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH for-9.0] Fix some typos in documentation (found by
 codespell)
Message-ID: <Zguow643FFMzxbfk@michell-laptop.localdomain>
References: <20240331161526.1746598-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331161526.1746598-1-sw@weilnetz.de>
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 18:15 Sun 31 Mar     , Stefan Weil wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Luc Michel <luc@lmichel.fr>

> ---
>  docs/devel/atomics.rst     | 2 +-
>  docs/devel/ci-jobs.rst.inc | 2 +-
>  docs/devel/clocks.rst      | 2 +-
>  docs/system/i386/sgx.rst   | 2 +-
>  qapi/qom.json              | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
> index ff9b5ee30c..b77c6e13e1 100644
> --- a/docs/devel/atomics.rst
> +++ b/docs/devel/atomics.rst
> @@ -119,7 +119,7 @@ The only guarantees that you can rely upon in this case are:
>    ordinary accesses instead cause data races if they are concurrent with
>    other accesses of which at least one is a write.  In order to ensure this,
>    the compiler will not optimize accesses out of existence, create unsolicited
> -  accesses, or perform other similar optimzations.
> +  accesses, or perform other similar optimizations.
>  
>  - acquire operations will appear to happen, with respect to the other
>    components of the system, before all the LOAD or STORE operations
> diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
> index ec33e6ee2b..be06322279 100644
> --- a/docs/devel/ci-jobs.rst.inc
> +++ b/docs/devel/ci-jobs.rst.inc
> @@ -115,7 +115,7 @@ CI pipeline.
>  QEMU_JOB_SKIPPED
>  ~~~~~~~~~~~~~~~~
>  
> -The job is not reliably successsful in general, so is not
> +The job is not reliably successful in general, so is not
>  currently suitable to be run by default. Ideally this should
>  be a temporary marker until the problems can be addressed, or
>  the job permanently removed.
> diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
> index b2d1148cdb..177ee1c90d 100644
> --- a/docs/devel/clocks.rst
> +++ b/docs/devel/clocks.rst
> @@ -279,7 +279,7 @@ You can change the multiplier and divider of a clock at runtime,
>  so you can use this to model clock controller devices which
>  have guest-programmable frequency multipliers or dividers.
>  
> -Similary to ``clock_set()``, ``clock_set_mul_div()`` returns ``true`` if
> +Similarly to ``clock_set()``, ``clock_set_mul_div()`` returns ``true`` if
>  the clock state was modified; that is, if the multiplier or the diviser
>  or both were changed by the call.
>  
> diff --git a/docs/system/i386/sgx.rst b/docs/system/i386/sgx.rst
> index 0f0a73f758..c293f7f44e 100644
> --- a/docs/system/i386/sgx.rst
> +++ b/docs/system/i386/sgx.rst
> @@ -6,7 +6,7 @@ Overview
>  
>  Intel Software Guard eXtensions (SGX) is a set of instructions and mechanisms
>  for memory accesses in order to provide security accesses for sensitive
> -applications and data. SGX allows an application to use it's pariticular
> +applications and data. SGX allows an application to use its particular
>  address space as an *enclave*, which is a protected area provides confidentiality
>  and integrity even in the presence of privileged malware. Accesses to the
>  enclave memory area from any software not resident in the enclave are prevented,
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8d4ca8ed92..85e6b4f84a 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -802,7 +802,7 @@
>  #
>  # @fd: file descriptor name previously passed via 'getfd' command,
>  #     which represents a pre-opened /dev/iommu.  This allows the
> -#     iommufd object to be shared accross several subsystems (VFIO,
> +#     iommufd object to be shared across several subsystems (VFIO,
>  #     VDPA, ...), and the file descriptor to be shared with other
>  #     process, e.g. DPDK.  (default: QEMU opens /dev/iommu by itself)
>  #
> -- 
> 2.39.2
> 

-- 

