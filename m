Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7345E103E2E6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 20:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0QZx-0002rw-71; Wed, 11 Mar 2026 16:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0QZs-0002mm-PM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 16:54:49 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0QZk-0007nM-Mr
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 16:54:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A6CC41A32;
 Wed, 11 Mar 2026 20:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7C1C4CEF7;
 Wed, 11 Mar 2026 20:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773262479;
 bh=preRj9j4tgiKLdnaVHOGcdlVGMadVe2cgyQAb7D4owI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DBe3D47gYuDiqvJY8QlyypMTzgRSBerxExj0g0vcnHpeaOQzgvz+lmyPyRGnU+puP
 L3og9DRUP+QxcImobA0fsylw9VjiV1GwwiYsftyXMlGeUs6+Ko+CNnh0GlJKwd/NjE
 BpxECZ/QtwUzlBDS35adf8nmahl4515ZfmXvIfgIjzbMVv1LsC+LdB8nG9ANMBLXF5
 er2kUWJlWXj2uVBQPgeJqkqAnePacD2aFJfXXkoCMw4cMi4BiB6RcgXq4zqEAMW1MH
 9Z3IBL5aHegljyOGBF97IEI2zcSlRM1n0nbi2IC/dIrHWlWeA/AX/421t+IuYP2iPH
 Vu3Yggd91eXHw==
Date: Wed, 11 Mar 2026 20:54:37 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 1/9] accel/mshv: use mshv_create_partition_v2 payload
Message-ID: <20260311205437.GD3612627@liuwe-devbox-debian-v2.local>
References: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
 <20260311113505.1177878-2-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311113505.1177878-2-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=wei.liu@kernel.org;
 helo=sea.source.kernel.org
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

On Wed, Mar 11, 2026 at 12:34:57PM +0100, Magnus Kulke wrote:
> When using the extended request format we can instruct the hypervisor to
> provision enough space for requested XSAVE features. This is required
> for supporting QEMU models provided via the -cpu flag properly.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

