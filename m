Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191BCCA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 07:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqRDr-00046z-2s; Mon, 25 Aug 2025 03:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqRDo-00046c-7y
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:02:28 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqRDl-0007h8-8k
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756105345; x=1787641345;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=T+I7aXdbeRjd6BQoOMdiJ7OXj7dqbtSJSK9mhnC6Dxc=;
 b=TjQgLAMdqpd6FHahl7YICdXuuek8nnqHlKCCFruCOhfu1kbRlTzros5q
 3aUSOx6ndGyCyOo4TYYFbJkcZY9WAaar6lqjNdZ/joprMXxr7V121FPhZ
 NRML8ILiKJXlvIvxFIHFdjpfpztAYkP9GV0RiHjO8lULZi3Nbmvz0uLgU
 4HP/LZtDJek+Qn+5QR5dmxUWl+TYoCbZFP8gQWWbSUZ5RLaaKIW/jobFs
 oq3SHK7mQNp7u+qY1obiwlAze1LiXPPk4foohABjfoC7lrszwOBkTCMyu
 JpEsLI3P5leYfP9FBGvKrmmzOa8zcU9CzkJZ1B2+TbHcb/eLi9FDYJull w==;
X-CSE-ConnectionGUID: 4fQwXjg2RzKj5XEukivOgQ==
X-CSE-MsgGUID: ewfqe4cCSwOFEIKQvgmV3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="69683640"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="69683640"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 00:02:17 -0700
X-CSE-ConnectionGUID: p7mWenX2RXy7e/pdR2B37Q==
X-CSE-MsgGUID: QY63b6jXTo60fkP3j7AmAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="169148987"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 25 Aug 2025 00:02:15 -0700
Date: Mon, 25 Aug 2025 15:24:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com,
 berrange@redhat.com, mads@ynddal.dk
Subject: Re: [PATCH 01/14] treewide: write "unsigned long int" instead of
 "long unsigned int"
Message-ID: <aKwPkXzi67+UGAnP@intel.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822122655.1353197-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

On Fri, Aug 22, 2025 at 02:26:42PM +0200, Paolo Bonzini wrote:
> Date: Fri, 22 Aug 2025 14:26:42 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 01/14] treewide: write "unsigned long int" instead of "long
>  unsigned int"
> X-Mailer: git-send-email 2.50.1
> 
> Putting "unsigned" in anything but the first position is weird.

I think one reason may be gcc uses something like ¡®long unsigned int *¡®
by default?

../hw/misc/imx7_src.c: In function ¡®imx7_src_write¡¯:
../hw/misc/imx7_src.c:218:42: error: passing argument 2 of ¡®clear_bit¡¯ from incompatible pointer type [-Werror=incompatible-pointer-types]
  218 |             clear_bit(R_CORE1_RST_SHIFT, &change_mask);
      |                                          ^~~~~~~~~~~~
      |                                          |
      |                                          uint32_t * {aka unsigned int *}
In file included from /media/liuzhao/data/qemu-cook/include/qemu/bitmap.h:16,
                 from /media/liuzhao/data/qemu-cook/include/hw/qdev-core.h:6,
                 from /media/liuzhao/data/qemu-cook/include/hw/sysbus.h:6,
                 from /media/liuzhao/data/qemu-cook/include/hw/misc/imx7_src.h:13,
                 from ../hw/misc/imx7_src.c:12:
/qemu/include/qemu/bitops.h:93:54: note: expected ¡®long unsigned int *¡¯ but argument is of type ¡®uint32_t *¡¯ {aka ¡®unsigned int *¡¯}
   93 | static inline void clear_bit(long nr, unsigned long *addr)
      |                                       ~~~~~~~~~~~~~~~^~~~
cc1: all warnings being treated as errors

> As such,
> tracetool's Rust type conversion will not support it.  Remove it from
> the whole of QEMU's source code, not just trace-events.

But I also agree it's a good idea to clean this up.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  crypto/pbkdf-gcrypt.c        | 2 +-
>  crypto/pbkdf-gnutls.c        | 2 +-
>  crypto/pbkdf-nettle.c        | 2 +-
>  hw/display/exynos4210_fimd.c | 2 +-
>  hw/misc/imx7_src.c           | 4 ++--
>  hw/net/can/can_sja1000.c     | 4 ++--
>  hw/xen/trace-events          | 4 ++--
>  7 files changed, 10 insertions(+), 10 deletions(-)

...

> diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
> index df0b0a69057..817c95bf65b 100644
> --- a/hw/misc/imx7_src.c
> +++ b/hw/misc/imx7_src.c
> @@ -169,7 +169,7 @@ static void imx7_src_write(void *opaque, hwaddr offset, uint64_t value,
>  {
>      IMX7SRCState *s = (IMX7SRCState *)opaque;
>      uint32_t index = offset >> 2;
> -    long unsigned int change_mask;
> +    uint32_t change_mask;

We needs "unsigned long", otherwise, there'll be the error as I listed
above.

>      uint32_t current_value = value;
>  
>      if (index >= SRC_MAX) {

...

> diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
> index 5b6ba9df6c4..545c520c3b4 100644
> --- a/hw/net/can/can_sja1000.c
> +++ b/hw/net/can/can_sja1000.c
> @@ -750,8 +750,8 @@ uint64_t can_sja_mem_read(CanSJA1000State *s, hwaddr addr, unsigned size)
>              break;
>          }
>      }
> -    DPRINTF("read addr 0x%02x, %d bytes, content 0x%02lx\n",
> -            (int)addr, size, (long unsigned int)temp);

tmep is "uint64_t", so there's no need to convert its type?

We can just drop `(long unsigned int)` directly.

> +    DPRINTF("read addr 0x%02x, %d bytes, content 0x%02x\n",
> +            (int)addr, size, (unsigned)temp);
>      return temp;
>  }

Others look fine to me. With the nits fixed,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


