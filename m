Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D65DCF8860
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5df-0007tM-Ri; Thu, 20 Nov 2025 09:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5dX-0007YA-Ki; Thu, 20 Nov 2025 09:27:51 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5dV-0005lW-Rl; Thu, 20 Nov 2025 09:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763648870; x=1795184870;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VzkwBbu55terI7Gk51gvD9Sy33QOdgz2vgeGUec9HeM=;
 b=FmCciSs4DXjQKroHigwDNOx2/cLQ7jDnaYJq2hotUpOYFm5PLMtWGCLg
 mLKa6i6RFdqZYZMarYq97sOvByMsZtBeKn9tYG57bKYdLNim41xX+Guo2
 5KOQxx1Irk3Rc9Yo/3vZbpRvW4X/EJHaloNfGsmx1zgmP8mEgh0M7uzZ/
 q2zMSYJ48EvulsCAfDHnwwOvaMun+t2MJ/EEC1PO2eTt2Pi25ApkUzZ61
 1A1rw0FWhAB4gUQo9FNCAp3W0z93XYrK8QRqmfsJSy2PyudSaXJQ/StDk
 oehBweWK2xIBqvRMBsK1Vn9GJTh8EGsc5Y3dYe0G72pF31EgzXSk0TpXr w==;
X-CSE-ConnectionGUID: /uiOO1h6Qw6JeQTr/Q25tA==
X-CSE-MsgGUID: YWS5NYVTQt6BMhMGw2cUgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="76046330"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="76046330"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 06:27:40 -0800
X-CSE-ConnectionGUID: 9nFPYYJSQb+f0FYmVzBmuQ==
X-CSE-MsgGUID: q5v6UEhQRkqlZrvb/lfD1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="195685217"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 20 Nov 2025 06:27:36 -0800
Date: Thu, 20 Nov 2025 22:49:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-rust@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Josh Stone <jistone@redhat.com>
Subject: Re: [PATCH v2 1/4] hpet: remove unused trace events
Message-ID: <aR8qlQD45kw0yACO@intel.com>
References: <20251119205200.173170-1-stefanha@redhat.com>
 <20251119205200.173170-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119205200.173170-2-stefanha@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Wed, Nov 19, 2025 at 03:51:57PM -0500, Stefan Hajnoczi wrote:
> Date: Wed, 19 Nov 2025 15:51:57 -0500
> From: Stefan Hajnoczi <stefanha@redhat.com>
> Subject: [PATCH v2 1/4] hpet: remove unused trace events
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/timer/trace-events | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


