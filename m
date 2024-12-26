Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0905DE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 02:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQdvh-0005zP-Fw; Wed, 25 Dec 2024 21:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQdvf-0005yz-Bk
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 21:48:51 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQdvd-0008Mg-Jc
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 21:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735181330; x=1766717330;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ERRa0GNR3pWzjTIR975KjOskzl/Zk8b0PBCRk//borU=;
 b=FhCZuh5mKMN/gFWG6MEoEy0Agsd/8Y7at9pIvxCkO2tlv6Hgepm59KpR
 w1ZYJQiifMiIAdEXhFgGP+ZL6I2wCmFWiwI9eV6RfFrdmLU9WdoatUdn7
 45u8ysvDZQSm8FHANCrt+ZWVBHfseZBf2rZlemOJ7k6P7Dx2yxM0VAYGp
 pcfXyv6qm1L57TyTNGR3hrS9+SKCKaksg685tZsU1nOJEm6+YbKfKf0IK
 C7cS/m1Dx03jXP1a0WkSEecm1dp1CSIUcxx/eHbXmPrN6Q72OWx2uCY0Q
 3XYZHXA1ejeJUH68iLCncQ6bNHZuZYbVNLaNu4G/hqG+UwssT4Ifa+V5J A==;
X-CSE-ConnectionGUID: cDXPKEqUQWCPSeRNhkr1Ow==
X-CSE-MsgGUID: uMvdvZ/2QIebBTjnGUNpVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="39287656"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; d="scan'208";a="39287656"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2024 18:48:46 -0800
X-CSE-ConnectionGUID: Xpuf/RhIS9ivOUSFKF898Q==
X-CSE-MsgGUID: iW0AiCvcRX+A13TFrhHEXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="104804072"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 25 Dec 2024 18:48:45 -0800
Date: Thu, 26 Dec 2024 11:07:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [PATCH 06/12] rust: qom: move device_id to PL011 class side
Message-ID: <Z2zIb4Jo6/TbgJ9Y@intel.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
 <20241220142955.652636-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220142955.652636-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Dec 20, 2024 at 03:29:48PM +0100, Paolo Bonzini wrote:
> Date: Fri, 20 Dec 2024 15:29:48 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 06/12] rust: qom: move device_id to PL011 class side
> X-Mailer: git-send-email 2.47.1
> 
> There is no need to monkeypatch DeviceId::Luminary into the already-initialized
> PL011State.  Instead, now that we can define a class hierarchy, we can define
> PL011Class and make device_id a field in there.
> 
> There is also no need anymore to have "Arm" as zero, so change DeviceId into a
> wrapper for the array; all it does is provide an Index<hwaddr> implementation
> because arrays can only be indexed by usize.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 59 +++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 31 deletions(-)

...

>  impl DeviceId {
> -    const PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
> -    const PL011_ID_LUMINARY: [c_uchar; 8] = [0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1];
> +    const ARM: Self = Self(&[0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1]);
> +    const LUMINARY: Self = Self(&[0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1]);
>  }
>  

It seems you didn't choose to hardcode device ID to save 3 lines of code :)

Both are fine for me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


