Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFC9C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAnS-0007rS-Hm; Tue, 23 Jul 2024 04:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWAnP-0007Yc-2W
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:22:55 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWAnN-0000Zq-FN
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721722973; x=1753258973;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=4N1TSsvOhvveEK5eWpQA+zE0ellzIbO3VlwNu6lB/xo=;
 b=Rqu+0ClkX9EyRJgt6xI3bSjdX6fkqVWWGgtt2dgv1FK5j0yJJPGVVPZn
 4tHLXuyp1aL0X13oCieIdyjKjfSY4DkXevD3P1CmTubLEwbY3p80tMqAh
 UFx1FNM9YJX5ftGa8xQgwfwbMUeQL9XcnX64Qqdm7fcmYuLxmojKo0RAo
 jdAIcF5+seiPCp06dZdT/t+DGlbwIAl01UNFNU8fzjasfsJlN0Zu8lThz
 Y08tqu7HnC40XrWvMEc5cUBMu7mTq2WRNJ3+cLAMS+KWT9tzDAtL70Kwq
 L3G6xzdXmagZXp0AfGf85QdhX23V5wy/agm2X5iHTONSut1vp6Fxc1Sg2 Q==;
X-CSE-ConnectionGUID: 1jVPK7TTQwuDqlMQ3YgHPg==
X-CSE-MsgGUID: tnJL2SIsStCtFvxME+e6Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19458707"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="19458707"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 01:22:52 -0700
X-CSE-ConnectionGUID: Hejwk+HiQkOc0rpncfbDfg==
X-CSE-MsgGUID: L6T/ZmDFT2qKLK4WYiT2og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="52051807"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 23 Jul 2024 01:22:48 -0700
Date: Tue, 23 Jul 2024 16:38:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v5 5/8] .gitattributes: add Rust diff and merge
 attributes
Message-ID: <Zp9sCMwJA2btMuTd@intel.com>
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <990592c7c93a3b2b692dd773c4c9191a82146a80.1721648163.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <990592c7c93a3b2b692dd773c4c9191a82146a80.1721648163.git.manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Mon, Jul 22, 2024 at 02:43:35PM +0300, Manos Pitsidianakis wrote:
> Date: Mon, 22 Jul 2024 14:43:35 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [RFC PATCH v5 5/8] .gitattributes: add Rust diff and merge
>  attributes
> X-Mailer: git-send-email 2.44.0
> 
> Set rust source code to diff=rust (built-in with new git versions)
> and merge=binary for Cargo.lock files (they should not be merged but
> auto-generated by cargo)
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  .gitattributes | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


