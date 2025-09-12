Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94135CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 07:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwy6Z-00071T-V1; Fri, 12 Sep 2025 03:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwy6X-00070L-P9
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 03:21:57 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwy6Q-0000sv-QX
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 03:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757661711; x=1789197711;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Q7qbP2Pokyh8IIX1pIYq6P+PMy1YXdxpCfJqBC60O6w=;
 b=mrLLL6adSRh1toBpFpIKzH4Vfj2pObll7n/JzZ0sNn+Qra/vP9lD8YO2
 S+wWGEGFvcMT/rPKRUz0l9Jd/hYx3UQxNoIwymwSSUj3cl0svZj56aKQF
 F+/u7N09rQjwMyjAUT2ZfMcUuAnJ8ArXldIJMQHL8ddblJrsh7jVujBs8
 16hiurvx1wjbVQh0H4zxQzOYantV6J7gCeBpBOB4AO7x/rcUX5ShXGxPf
 lQRnWSsk31Xdoq7SfNpgHqa03DqN+F/iDAU5oNxk3YpDi3FyBCVcSnEGM
 5FZrvuCJrbpY6ex7E/0louwwLp1NxDNVVlT/QKV9ptPRsD9WLcXTPsEkg A==;
X-CSE-ConnectionGUID: hlJaxIaIRzqipYI1FrOUvQ==
X-CSE-MsgGUID: CYiTDhjXSte6XfbFyicmdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59042899"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="59042899"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 00:21:48 -0700
X-CSE-ConnectionGUID: j+OxMagvQ6qIDVtTjZT5CQ==
X-CSE-MsgGUID: WHGkw6kUT5CzGDbYlDZDWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="177934797"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 12 Sep 2025 00:21:47 -0700
Date: Fri, 12 Sep 2025 15:43:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 17/33] rust: make build.rs generic over various
 ./rust/projects
Message-ID: <aMPPK2LsjCQDWvTI@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-18-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-18-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Sep 08, 2025 at 12:49:49PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:49 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 17/33] rust: make build.rs generic over various
>  ./rust/projects
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Guess the name of the subdir from the manifest directory, instead of
> hard-coding it. In the following commits, other crates can then link to
> this file, instead of maintaining their own copy.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-5-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/build.rs | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


