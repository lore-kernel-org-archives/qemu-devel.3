Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9428FCAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 07:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VE1-0001Pi-Bz; Tue, 30 Sep 2025 03:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v3VDz-0001PW-H9; Tue, 30 Sep 2025 03:56:39 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v3VDs-0008Tr-VO; Tue, 30 Sep 2025 03:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759218993; x=1790754993;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=IPOfkgJq0tWJ6Nf0d+SDM3ZsL7BRc+UftsOrRMeUpYw=;
 b=B173adx06XyArKKRL6/3E5OIbYXF4cXww7y1cCUbQoSWxNpl9LWF7K6s
 MlQnhNQriu8wTGC8iKjCUG9bR8xU8D4K8L4jc787zxA/Y/DEhwDEvwnDB
 //VS9TTd4Et3U2KlpkS5yjtHFedYTSJGorw25F82KDrbMrOZZedeNu/Ba
 PXrTNhwZDy485eJ3jUfEW4nuPWqrsqXOaiE6ma54RTGQ6QwZOnPszB4OI
 4GkcvX9/B1vWJMaSYgsO0HHa1djxLMUNyWg1viiCSBb64Mt/Voehq5Yj/
 xr9Um6uWFXst4rV1WngKj5KokuVFOEkScr55GShAb6mjdpC4rnWuHtP05 w==;
X-CSE-ConnectionGUID: QkIdzVReRFy7YUEGNE0HUQ==
X-CSE-MsgGUID: BkWYGGIcTM66O5xtjz5qgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="60682128"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; d="scan'208";a="60682128"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 00:56:26 -0700
X-CSE-ConnectionGUID: zLx4XDfIQLue+cQAcX494A==
X-CSE-MsgGUID: VpmESbhXTbeXZ95W/4AXqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; d="scan'208";a="202138483"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 30 Sep 2025 00:56:24 -0700
Date: Tue, 30 Sep 2025 16:18:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] subprojects: Update .gitignore for syn
Message-ID: <aNuSUHztLSchfd0o@intel.com>
References: <20250930075351.1853721-1-zhao1.liu@intel.com>
 <675a6965-7c32-4b4d-8d27-88acac0c440d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <675a6965-7c32-4b4d-8d27-88acac0c440d@linaro.org>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 30, 2025 at 09:50:24AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue, 30 Sep 2025 09:50:24 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH] subprojects: Update .gitignore for syn
> 
> On 30/9/25 09:53, Zhao Liu wrote:
> > The commit a530a8d4ac39 missed to update syn version, this is because
> > the code base of its v2 patch has fixed syn version, so that the fix for
> > syn were lost during the rebase from v1 to v2.
> > 
> > To rectify this mistake, update the syn version.
> > 
> > Fixes: a530a8d4ac39 ("subprojects: Update .gitignore for proc-macro2 and syn")
> 
> IIUC the subprojects is in commit 9a6d6ae8afb, so:
> 
> Fixes: 9a6d6ae8afb ("subprojects: update proc-macro2 and syn")
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

It's because the subject of a530a8d4ac39 mentioned to fix syn but it
actually didn't :-).

Fixes tag for 9a6d6ae8afb is also fine for me.

Thanks!

-Zhao


