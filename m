Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14822108B91C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZDD-00038p-Fn; Fri, 20 Mar 2026 08:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1w3Tcg-0000QP-OG; Fri, 20 Mar 2026 02:46:20 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1w3Tcf-000242-3L; Fri, 20 Mar 2026 02:46:18 -0400
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id 27BCE20B710C; Thu, 19 Mar 2026 23:46:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 27BCE20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1773989171;
 bh=dCe0MLM8VyaaLRLj+6zU6AK+y91M0mnBqK4SKUqzzm4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lr121H6vpn3XxH5Z5trIHuYAIVxBBu72x2q4xbr2JViJjOvycRxpXCWpUJd7ys3v8
 msldDoTqTZYToPS/6IFZAMlEvSWJwlYDSUYXXOTS6hEhAN2LlpbM3diOK0zOC4hf4V
 bck6pbH5dJ0yUCfdZvJ60YE+dr6Vq38p8p7IMf/w=
Date: Thu, 19 Mar 2026 23:46:11 -0700
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-devel@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH 08/14] accel/mshv: Add access_vp_regs synthetic proc
 features
Message-ID: <abztM7TsKfvY+FZH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-8-c31699b7bc1f@anirudhrb.com>
 <20260311205142.GC3612627@liuwe-devbox-debian-v2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311205142.GC3612627@liuwe-devbox-debian-v2.local>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Mar 2026 08:44:20 -0400
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

On Wed, Mar 11, 2026 at 08:51:42PM +0000, Wei Liu wrote:
> > +    features.access_vp_regs = 1;
> 
> What's the side effect for enabling this for x86?
> 
> Wei

Enabling this bit is primarily a permission granting flag, it doesn't
have any functional side effects. X86 guests will continue to use wrmsr
rather than hypercalls to manage their state. This is similar to what we
have implemented in cloud-hypervisor for ARM64.

Thanks,
Aastha

