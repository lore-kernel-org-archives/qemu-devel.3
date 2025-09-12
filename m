Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05696CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwz1U-0001bl-H5; Fri, 12 Sep 2025 04:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwz1R-0001aw-2C
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:20:45 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwz1J-0002JV-Rg
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757665238; x=1789201238;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=+hVOO6R5Mr9T61i3mjA0rVNagbA5/FzfonStyPae86I=;
 b=icBKfhEP4KiO2nVyyhcUsoET97ECKSFV/6WF0v1HTWLbk4L7a3V3n8Q8
 QuVr7X7wHW6/UepHVKVRasc6LG764/kmzWeqfJl/+KT0I5SN25jof1QVH
 Usd98FVvIkhwRbARptxhkZQ4L7lfVF028AQPBGLiPZT3tPy72WrhJyMFu
 8AlTefNz0NNxbVo4R5iWWYFe+2YJ3bbFo/0SzOAPxPZyrpvG0hzlpJFwf
 vn8G1sqFWeHHlhHx4bIQkzS7KVNExIGu/a+hj5VqSKJAR4ATP+jBxnrmW
 Mqd+jd3E+2R8ls2lqioXZ/M14KZQzzXBznIKLMGNHPB2npDXXf55c1A52 g==;
X-CSE-ConnectionGUID: 0MDNzsoHR+SeO+mAk5BUdw==
X-CSE-MsgGUID: HTX8vuSDSB63DidaFZD09A==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59944446"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="59944446"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 01:20:34 -0700
X-CSE-ConnectionGUID: MagI5NxQR6enEuv7Lh8tWw==
X-CSE-MsgGUID: 55NjpVngTUO1RcjhDapdXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="211063977"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 12 Sep 2025 01:20:33 -0700
Date: Fri, 12 Sep 2025 16:42:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 26/33] rust/hpet: drop now unneeded qemu_api dep
Message-ID: <aMPc8lXTNYEVJmYt@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-27-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-27-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 08, 2025 at 12:49:58PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:58 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 26/33] rust/hpet: drop now unneeded qemu_api dep
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-18-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.lock                | 1 -
>  rust/hw/timer/hpet/Cargo.toml  | 1 -
>  rust/hw/timer/hpet/meson.build | 1 -
>  3 files changed, 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


