Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4A1E784BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 03:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYc0J-00048b-Cv; Wed, 24 Dec 2025 22:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vYc0H-00047z-J0; Wed, 24 Dec 2025 22:27:05 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vYc0G-0006mL-8j; Wed, 24 Dec 2025 22:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766633224; x=1798169224;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Faez61rYceuWxZTUcFAPE0XaAg2e0BxkOozvnjQMs9w=;
 b=Lv3xbAnEoB4nNAuenAAl1//J4xScllQoL7PY++cUg0oN9ZB9iuu8HqBc
 GCBDVv+sIXkuVgLkR4hnsPEbC2/7QsxAKlDauRV7jz6Sg6M8hdAnBjGEn
 0TUNPnYtyGdcJP41FzUJT3Bh1VsdHujzBPyGnELC0+hg0jGvdQ869i8dF
 r6NuKa2O2KiIS5Is19PSeMOep8TMPkVeGjV5jNl9QlEJRBT9zdS1BGPrY
 3WDdDSbv3fJStGan6d3FFu548t9zJEg7V66QD7OsMpycTFztLmFiywGqb
 CLkcY0wSZqT5MDZM57Z4InUh7+dHFFNTo5A+J99UicTLp5Hlt0fQNp6Wd Q==;
X-CSE-ConnectionGUID: SnYH586fTS2hqbjp3A1GAw==
X-CSE-MsgGUID: VajUOfTmTr64V//8BPeoWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="79174099"
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; d="scan'208";a="79174099"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Dec 2025 19:27:01 -0800
X-CSE-ConnectionGUID: AwrHZ4D/QoigxlOxO8TR5Q==
X-CSE-MsgGUID: /I0JpGO2QcKG1zG27OSgCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; d="scan'208";a="205050946"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 24 Dec 2025 19:26:58 -0800
Date: Thu, 25 Dec 2025 11:51:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-rust@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Max Filippov <jcmvbkbc@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 7/8] rust/system: Stop exposing bogus
 DEVICE_NATIVE_ENDIAN symbol
Message-ID: <aUy01/UfrhM4kxbL@intel.com>
References: <20251224134644.85582-1-philmd@linaro.org>
 <20251224134644.85582-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251224134644.85582-8-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Wed, Dec 24, 2025 at 02:46:43PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 24 Dec 2025 14:46:43 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 7/8] rust/system: Stop exposing bogus
>  DEVICE_NATIVE_ENDIAN symbol
> X-Mailer: git-send-email 2.52.0
> 
> We want to remove the bogus DEVICE_NATIVE_ENDIAN definition
> (by only having it explicit, either big or little one). Stop
> exposing it to rust devices to avoid it spreading further.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  rust/system/src/memory.rs | 6 ------
>  1 file changed, 6 deletions(-)

Good. I suppose this could help simplify vm-memory support.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


