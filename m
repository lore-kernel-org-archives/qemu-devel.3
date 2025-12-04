Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E786D20698
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 13:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR9o1-0003UM-HR; Thu, 04 Dec 2025 08:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vR9nz-0003Sw-U1; Thu, 04 Dec 2025 08:55:35 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vR9ny-00017M-8p; Thu, 04 Dec 2025 08:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764856534; x=1796392534;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5UAS0847LidIJwT3lHJnOPMdlUc/PLQRq8Y6I54pzAw=;
 b=ClXwoWe/Uo29PGdTW93uN8eBfKR1uKZtu+15Z+MN2SWdwBaZ739j43e4
 YZoZApDbCGGBF2jMV+Ii6e8OV7sGgby8pcGdXpzrpm/Npv9BLh8SDmaqg
 zatpSCgEnO83JZs7DRpt+toU+uzuGhUUKG066qjwLjISRLIJLZv5kJqU5
 ElzBLbKrlHlL8AmoDS/apPfCXGmzXNQA1L+S2BL2LXRhRblW4ahMRTRYI
 lm+MZ+mw5YkVKQAgKq268demkrWtA2jkBacEKCou/hm80G9j9FvSRAHZl
 3b7L0aGdrXLRONWOoX84meTDQy0bnMPEF7WzmveQC4/ma0SmGhdXv6oyx w==;
X-CSE-ConnectionGUID: pu3gE7O3Q7ayVgCgIfjT0Q==
X-CSE-MsgGUID: 3nbOkZKUSVqg7l1HNmeDNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78340407"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="78340407"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 05:55:32 -0800
X-CSE-ConnectionGUID: e5syOX7ZREirLP6m6JJJyw==
X-CSE-MsgGUID: AYg5yv6LQnKdkDLHMPvnXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="200115652"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 04 Dec 2025 05:55:30 -0800
Date: Thu, 4 Dec 2025 22:20:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 03/14] subprojects: add serde
Message-ID: <aTGYnruC+Ti9RG0L@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001080051.1043944-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001080051.1043944-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Oct 01, 2025 at 10:00:40AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 10:00:40 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/14] subprojects: add serde
> X-Mailer: git-send-email 2.51.0
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.toml                               |  2 ++
>  rust/meson.build                              |  2 ++
>  scripts/archive-source.sh                     |  3 ++
>  scripts/make-release                          |  2 +-
>  subprojects/.gitignore                        |  3 ++
>  .../packagefiles/serde-1-rs/meson.build       | 36 +++++++++++++++++++
>  .../packagefiles/serde-1.0.226-include.patch  | 16 +++++++++
>  .../packagefiles/serde_core-1-rs/meson.build  | 25 +++++++++++++
>  .../serde_core-1.0.226-include.patch          | 15 ++++++++
>  .../serde_derive-1-rs/meson.build             | 35 ++++++++++++++++++
>  .../serde_derive-1.0.226-include.patch        | 11 ++++++
>  subprojects/serde-1-rs.wrap                   | 11 ++++++
>  subprojects/serde_core-1-rs.wrap              | 11 ++++++
>  subprojects/serde_derive-1-rs.wrap            | 11 ++++++
>  14 files changed, 182 insertions(+), 1 deletion(-)
>  create mode 100644 subprojects/packagefiles/serde-1-rs/meson.build
>  create mode 100644 subprojects/packagefiles/serde-1.0.226-include.patch
>  create mode 100644 subprojects/packagefiles/serde_core-1-rs/meson.build
>  create mode 100644 subprojects/packagefiles/serde_core-1.0.226-include.patch
>  create mode 100644 subprojects/packagefiles/serde_derive-1-rs/meson.build
>  create mode 100644 subprojects/packagefiles/serde_derive-1.0.226-include.patch
>  create mode 100644 subprojects/serde-1-rs.wrap
>  create mode 100644 subprojects/serde_core-1-rs.wrap
>  create mode 100644 subprojects/serde_derive-1-rs.wrap

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


