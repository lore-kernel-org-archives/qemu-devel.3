Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92147CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 10:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwe7t-0007Hh-JZ; Thu, 11 Sep 2025 06:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwe7r-0007H9-Sm
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:01:59 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwe7p-0006UY-Ky
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757584917; x=1789120917;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=NwVt3Hvjb0IhQ6E9x92cjR0FTVxvrHIBhXtAyzklHFE=;
 b=hC6FwU3rOwyW9XGkmx5P72RHyX98yGlFgc8+OwJeJWh4CwJnYDV/4poh
 +NSVr64Yak/AQrAQXyLeaSzFjvAF+SwEpgX7PgvG1N48lgrjFwQB2ryqm
 nkbpvoIbnPHQ64Y5ccTZ37yHXS5Wi6dRXFUCr2Zz3NKldgvkmxasyWQK/
 +daTyl45zE0rYzyk9LgymdrO003n/5b8YmP1pcNDu0Tt4C9sQrJG27rdG
 ChCxzuYEJdFzqSQBlLV33BwGIOSa8cDtd0EB+uBgw6FVtGwL79oIZMrie
 1HUgUPg8LNQbucAL3tLZYAi7nFCyMVftWIPHKYM2Vhs3UQ8ZbYRb7hnEB w==;
X-CSE-ConnectionGUID: 6GRTpSexS/2QcVmTCTboGQ==
X-CSE-MsgGUID: N+Zb1G3eSeGXn4EPivJPNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59770309"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="59770309"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 03:01:53 -0700
X-CSE-ConnectionGUID: z6FCd+GkT3uRwKioCkE9+A==
X-CSE-MsgGUID: wEJx4mF0TSW9jsaAK0Pfxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="204410591"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 11 Sep 2025 03:01:52 -0700
Date: Thu, 11 Sep 2025 18:23:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 12/33] rust: add workspace authors
Message-ID: <aMKjMY4HXBGLAAdQ@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-13-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-13-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:44PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:44 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 12/33] rust: add workspace authors
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-4-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.toml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


