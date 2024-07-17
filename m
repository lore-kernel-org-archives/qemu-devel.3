Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F998C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxxL-0005zx-Kh; Wed, 17 Jul 2024 02:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTxxF-0005dC-LI; Wed, 17 Jul 2024 02:15:58 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTxxC-0007YN-Sk; Wed, 17 Jul 2024 02:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721196955; x=1752732955;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lxVTDdL+S0Cn0Lj0YQLBnh1gWlr2LWb/YRUTiBXoNuw=;
 b=UYN/cS1ZLrQHndV6afKVZFlLuSwyvPrMil/nj9xiTN+lr4EBQ/AyZNzs
 4HzSGkJEzPyo/x42f+Zv2xymGWrp0PXrr5fFR6Bptebv07Qr03ZiCiSJb
 ogBKJ/EKum0TblJRooIPSdPmk6cBAPu64on9X7mKYq/d5CWImubo4uDfg
 Rqw3K8+hDXePBY9uF9SFqg6CHkqKtf8CoV7UlGwYiT8NGoo2eratDY47R
 WpyMd1OsYZeQFt5TZODxD4nytVIdcbjo8e36gn1dq4cnCykx7Rd0/2e0s
 IlYuDCWmr7I396oe/HtDHRYDduZUq0MbREiKFSx34OvsNrNatsgMNdfaF Q==;
X-CSE-ConnectionGUID: B3Xt47jRTXeFD84gdK8OfQ==
X-CSE-MsgGUID: nGLi1FLHQ6uyLA8MrGXTUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="12582827"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="12582827"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 23:15:48 -0700
X-CSE-ConnectionGUID: oYAqu01kQJuznZcfCRHKog==
X-CSE-MsgGUID: 4nIPCdO/TTSTEXc+WvZw8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="51009713"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 16 Jul 2024 23:15:46 -0700
Date: Wed, 17 Jul 2024 14:31:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] doc/net/l2tpv3: Update boolean fields' description to
 avoid short-form use
Message-ID: <ZpdlQDIjGp4wR8aR@intel.com>
References: <20240708092630.2596945-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708092630.2596945-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Hi Jason,

Just a kind ping. Does this update satisfy you?
Since the original example generates the warning.

Thanks,
Zhao

On Mon, Jul 08, 2024 at 05:26:30PM +0800, Zhao Liu wrote:
> Date: Mon, 8 Jul 2024 17:26:30 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH] doc/net/l2tpv3: Update boolean fields' description to
>  avoid short-form use
> X-Mailer: git-send-email 2.34.1
> 
> The short-form boolean options has been deprecated since v6.0 (refer
> to docs/about/deprecated.rst).
> 
> Update the description and example of boolean fields in l2tpv3 option to
> avoid deprecation warning.
> 
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  qemu-options.hx | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ad6521ef5e7e..edeaefe2c79a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3353,7 +3353,7 @@ SRST
>                           -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
>                           -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
>  
> -``-netdev l2tpv3,id=id,src=srcaddr,dst=dstaddr[,srcport=srcport][,dstport=dstport],txsession=txsession[,rxsession=rxsession][,ipv6=on|off][,udp=on|off][,cookie64][,counter][,pincounter][,txcookie=txcookie][,rxcookie=rxcookie][,offset=offset]``
> +``-netdev l2tpv3,id=id,src=srcaddr,dst=dstaddr[,srcport=srcport][,dstport=dstport],txsession=txsession[,rxsession=rxsession][,ipv6=on|off][,udp=on|off][,cookie64=on|off][,counter=on|off][,pincounter=on|off][,txcookie=txcookie][,rxcookie=rxcookie][,offset=offset]``
>      Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3931)
>      is a popular protocol to transport Ethernet (and other Layer 2) data
>      frames between two systems. It is present in routers, firewalls and
> @@ -3368,7 +3368,7 @@ SRST
>      ``dst=dstaddr``
>          destination address (mandatory)
>  
> -    ``udp``
> +    ``udp=on``
>          select udp encapsulation (default is ip).
>  
>      ``srcport=srcport``
> @@ -3377,7 +3377,7 @@ SRST
>      ``dstport=dstport``
>          destination udp port.
>  
> -    ``ipv6``
> +    ``ipv6=on``
>          force v6, otherwise defaults to v4.
>  
>      ``rxcookie=rxcookie``; \ ``txcookie=txcookie``
> @@ -3385,7 +3385,7 @@ SRST
>          Their function is mostly to prevent misconfiguration. By default
>          they are 32 bit.
>  
> -    ``cookie64``
> +    ``cookie64=on``
>          Set cookie size to 64 bit instead of the default 32
>  
>      ``counter=off``
> @@ -3419,7 +3419,7 @@ SRST
>          # launch QEMU instance - if your network has reorder or is very lossy add ,pincounter
>  
>          |qemu_system| linux.img -device e1000,netdev=n1 \\
> -            -netdev l2tpv3,id=n1,src=4.2.3.1,dst=1.2.3.4,udp,srcport=16384,dstport=16384,rxsession=0xffffffff,txsession=0xffffffff,counter
> +            -netdev l2tpv3,id=n1,src=4.2.3.1,dst=1.2.3.4,udp=on,srcport=16384,dstport=16384,rxsession=0xffffffff,txsession=0xffffffff,counter=on
>  
>  ``-netdev vde,id=id[,sock=socketpath][,port=n][,group=groupname][,mode=octalmode]``
>      Configure VDE backend to connect to PORT n of a vde switch running
> -- 
> 2.34.1
> 

