Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA224103E2E6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 21:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RE5-0007hN-BI; Wed, 11 Mar 2026 17:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0RE3-0007ew-Da
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:36:19 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0RE1-0003Re-Tm
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:36:19 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 69A2E4358B;
 Wed, 11 Mar 2026 21:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDFAC4CEF7;
 Wed, 11 Mar 2026 21:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773264976;
 bh=6/klAm0vqZGN5immPcdhIOXblY49U19GwS0cNooAgRw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ivWAEHZHF29hmU85Gfgif/2obbK+vwjzdNxnQlioBBxlrY2H7hlCPDaYf5MibCzzG
 f5lJqORZmSVXhzqXajsTjQIrTW7333u4B4huV5wEFGcrhXoE8bxBy6uZT/YYyWrEd+
 Cuv0G110KDRBSFj3AEKMsVTUfYf15x8+gxVA1HKRcq6VMO6pdwZavAf+5D0WBjCvu5
 Kn2nDbwYGCgl8DMLuvowXru2oQUgxcZqrqwXpebE8SDfJqIAiS/6DbU07hKeez539p
 Gvf5kS/EWeZbG4r+kU5QeZ+cDRDCS5JTy5MesJktXI79wT675Z/CAsg1rbW47CT9yg
 B1v7zWGxKZY+Q==
Date: Wed, 11 Mar 2026 21:36:14 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 4/9] target/i386/mshv: change cpuid mask to UINT32_MAX
Message-ID: <20260311213614.GF3612627@liuwe-devbox-debian-v2.local>
References: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
 <20260311113505.1177878-5-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311113505.1177878-5-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=sea.source.kernel.org
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

On Wed, Mar 11, 2026 at 12:35:00PM +0100, Magnus Kulke wrote:
> The current implementation would only override the feature bits that are
> enabled, however we also want to consider disabled features, hence all
> bits are set on the masks in the hypercall argument.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

