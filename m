Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18C3EB1052
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxfC-0001a1-Bb; Tue, 10 Mar 2026 10:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxf7-0001ZH-H5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:02:17 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxf5-0001zl-Pn
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773151336; x=1804687336;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=JGaCL+mxYuU3146HULqWpU733i51dlRbHB+odY4Bbi4=;
 b=hMMnNTEE/czzakUxYkwU9/Tk1nCXXS/tvMbxRfH/cTLphARR3yhbHp+Y
 VNjjyeNaznxVA3mmm2O46UuHXZ53qHosS/tTO+H15TI2mcAXJCGsqkAsq
 hELy1jHiRQwTifwBL1Df8Ndck7EoFhZW7jOsJKwNEM5iRgcPFHNWAzS4U
 PqCQFlENEG1l6e9GySOWc5lWoQxDPiNEbJsrcSJAppXAo9AEM3uPsE+dk
 vJ0GjqNmBXLm/L7/TKEFtdz5VOB+y9T3lEp7T2DMFf9SIzq41xQQKeGBy
 qRaRBvPaaNyDukG8/Ickb90LHoQ9UHm8pV5hgzdvral89FWaOTHJbYLGK w==;
X-CSE-ConnectionGUID: XIL9YoWxRfCrR2hwHkndfw==
X-CSE-MsgGUID: KK/idCH8RB24mN1TS92iaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74240310"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="74240310"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 07:02:14 -0700
X-CSE-ConnectionGUID: maqWQm1RQ5ipykeqEJpf1Q==
X-CSE-MsgGUID: pRCD1+hKQIyBLK/tIyyrjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="258039607"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 10 Mar 2026 07:02:11 -0700
Date: Tue, 10 Mar 2026 22:28:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 05/10] hw/i386/pc: Remove pc_compat_3_1[] array
Message-ID: <abAqhQ30mIqOEutd@intel.com>
References: <20260309145013.44327-1-philmd@linaro.org>
 <20260309145013.44327-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309145013.44327-6-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 09, 2026 at 03:50:07PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon,  9 Mar 2026 15:50:07 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 05/10] hw/i386/pc: Remove pc_compat_3_1[] array
> X-Mailer: git-send-email 2.53.0
> 
> The pc_compat_3_1[] array was only used by the pc-q35-3.1
> and pc-i440fx-3.1 machines, which got removed. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20260307152635.83893-6-philmd@linaro.org>
> ---
>  include/hw/i386/pc.h |  3 ---
>  hw/i386/pc.c         | 25 -------------------------
>  2 files changed, 28 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


