Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536EDFD2D9C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxcK-00087u-Q0; Tue, 10 Mar 2026 09:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxcH-00087E-KC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:59:21 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxcG-0001Xq-0h
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773151160; x=1804687160;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Skmo0FEpcLzZbJk0Y+DocG6yS6qYHzBfIFEXEWunzi0=;
 b=Ej1o+WMFSK+CF18sB0WXHPfmDLOWHYH8yzMwetSBq0GwdZVbaQI6vbCv
 mzXtoJjVfEfiUyer/1U75wCJ5FvAkpm9YLG0zKQuZVW1mrOpQVrlUgyQe
 +rOklpvd2aowZlBJ5GgSjD3wJeqHxzHJq1uenyhlnzW7yJLUecpn+J9Ej
 STTeKk7LYZ+Sx9OvPH7WGtCiJ9vSesnKop6NVRbQ0emmycd9EghC2GHI6
 lBQbMrKXDd8M4eRKDzJXg5EV3tGmvI36MLWNwXpX9yXQdn7ZInn3WHbHc
 in5e5c2nSGdvrqP4pyo8ZfqIcEQu+1PZy9MPuvVEL0ADZnGdYpSazTy1r Q==;
X-CSE-ConnectionGUID: j98L9d8lQMShTtUxhCyp5g==
X-CSE-MsgGUID: c/yNuYg7RX2ru0gd6KywOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="99662764"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="99662764"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 06:59:18 -0700
X-CSE-ConnectionGUID: MOb94uwfSpGnD4vFEwZSBA==
X-CSE-MsgGUID: EyGYtQTjSyy9SjUODj087A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="224579389"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 10 Mar 2026 06:59:16 -0700
Date: Tue, 10 Mar 2026 22:25:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 02/10] hw/i386/pc: Remove PCMachineClass::pvh_enabled
 field
Message-ID: <abAp1WfvlsrBtnQ2@intel.com>
References: <20260309145013.44327-1-philmd@linaro.org>
 <20260309145013.44327-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309145013.44327-3-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Mon, Mar 09, 2026 at 03:50:04PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon,  9 Mar 2026 15:50:04 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 02/10] hw/i386/pc: Remove PCMachineClass::pvh_enabled
>  field
> X-Mailer: git-send-email 2.53.0
> 
> The PCMachineClass::pvh_enabled boolean was only used by
> the pc-q35-3.1 and pc-i440fx-3.1 machines, which got removed.
> Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20260307152635.83893-3-philmd@linaro.org>
> ---
>  include/hw/i386/pc.h | 3 ---
>  hw/i386/pc.c         | 6 ++----
>  hw/i386/x86-common.c | 3 +--
>  3 files changed, 3 insertions(+), 9 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


