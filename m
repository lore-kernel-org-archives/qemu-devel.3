Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF71CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpw7-0003Vp-2Q; Wed, 30 Sep 2026 04:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBpw3-0003ML-Vx; Wed, 30 Sep 2026 04:45:08 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBpw2-0001xU-IZ; Wed, 30 Sep 2026 04:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790757906; x=1822293906;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ClM8Jc68LyOguZgFdTWgxsOsvXvhnmZ2NiutDVUkJII=;
 b=gtXxhe3VPKUmqFMNaX4Ka6PlNl16UECMMjIW7h1tY+3FsioyEemSOYnW
 C2/7AfgpBFap9OxekVyzOk5RDAZI1KHmN2bvLsK2Tzl4ei7/CyP87a3/J
 vH9rX7I4SR7gGDXfKXBAw3yR3SmbFlfm4QP7tkZw/BagI9mjwBjjUalyU
 Vg6v9BZr1B2Aonbe9boWYEpUzQt03AgQLaz/pvFDvKkBKh6vou1k614Ji
 Y1Nqr4Trd+K55ggijDOkBfaOeu3ypvzZ52cIVHenLPFfTr3kXXTQiVkxg
 LGlXWvPTgh2dXbVRIivS/Zm99ahk4/ssQf/8pLTdecazq3jPdmh2PqgCA w==;
X-CSE-ConnectionGUID: 8UYgbGQ1Tg6BdDp3rXP8Vg==
X-CSE-MsgGUID: Cw1zwdvbTpu/v7K0413PrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90444442"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90444442"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:45:04 -0700
X-CSE-ConnectionGUID: yaUQnPSoRMGqRzjVpOgo3Q==
X-CSE-MsgGUID: BpJGQm09Tla3s+lKHoazvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="274236035"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by fmviesa006.fm.intel.com with ESMTP; 30 Sep 2026 01:44:59 -0700
Date: Wed, 30 Sep 2026 16:44:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>
Subject: Re: [PATCH v3 04/10] hw/or1k/virt: use unique QOM name
Message-ID: <arzMCW6XBQH8/w4u@intel.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-5-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260926081551.29-5-luoyonggang@gmail.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Sat, Sep 26, 2026 at 04:15:44PM +0800, Yonggang Luo wrote:
> Date: Sat, 26 Sep 2026 16:15:44 +0800
> From: Yonggang Luo <luoyonggang@gmail.com>
> Subject: [PATCH v3 04/10] hw/or1k/virt: use unique QOM name
> X-Mailer: git-send-email 2.52.0.windows.1
> 
> Set TYPE_VIRT_MACHINE to MACHINE_TYPE_NAME("or1k-virt") so OpenRISC
> virt no longer collides with other virt-machine types in one process.
> Keep the -M / help / migration name as virt via
> machine_class_set_name().
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/or1k/virt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

