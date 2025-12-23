Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3BFE6F07B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 09:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXz87-0000WV-5R; Tue, 23 Dec 2025 04:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vXz80-0000WG-VZ
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 04:56:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vXz7x-0004VT-OG
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 04:56:28 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4db9Ny3NpNzHnGjg;
 Tue, 23 Dec 2025 17:55:30 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 3C8A94057A;
 Tue, 23 Dec 2025 17:56:07 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 09:56:06 +0000
Date: Tue, 23 Dec 2025 09:56:05 +0000
To: fanhuang <FangSheng.Huang@amd.com>
CC: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, Alistair Popple
 <apopple@nvidia.com>, "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>, Paul
 Blinzer <Paul.Blinzer@amd.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 1/1] numa: add 'spm' option for Specific Purpose Memory
Message-ID: <20251223095605.0000065d@huawei.com>
In-Reply-To: <20251209093841.2250527-2-FangSheng.Huang@amd.com>
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
 <20251209093841.2250527-2-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 9 Dec 2025 17:38:41 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> This patch adds support for Specific Purpose Memory (SPM) through the
> NUMA node configuration. When 'spm=on' is specified for a NUMA node,
> the memory region will be reported to the guest as soft reserved,
> allowing device drivers to manage it separately from normal system RAM.
> 
> Note: This option is only supported on x86 platforms. Using spm=on
> on non-x86 machines will result in an error.
> 
> Usage:
>   -numa node,nodeid=0,memdev=m1,spm=on
> 
> Signed-off-by: fanhuang <FangSheng.Huang@amd.com>

Given the discussions at LPC around how to present GPU/HBM memory and
suggestions that reserved might be a better choice. I wonder if this
patch should provide that option as well?  Or maybe as a potential follow
up. The fun their is that you also need to arrange for DSDT entries to
tie the region to the driver that actually wants it.

Anyhow that session reminded me of what SPM was designed for
(you don't want to know how long it took to come up with the name)
and it is a little more subtle than the description in here suggests.

The x86 specific code looks fine to me but I'm more or less totally
unfamiliar with that, so need review from others.

+CC a few folk from that discussion. I wasn't there in person and
it sounded like the discussion moved to the hallway so it may
have come to a totally different conclusion!

https://lpc.events/event/19/contributions/2064/ has links to slides
and youtube video.

> diff --git a/qapi/machine.json b/qapi/machine.json
> index 907cb25f75..cbb19da35c 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -500,6 +500,12 @@
>  # @memdev: memory backend object.  If specified for one node, it must
>  #     be specified for all nodes.
>  #
> +# @spm: if true, mark the memory region of this node as Specific
> +#     Purpose Memory (SPM).  The memory will be reported to the
> +#     guest as soft reserved, allowing device drivers to manage it
> +#     separately from normal system RAM.  Currently only supported
> +#     on x86.  (default: false, since 10.0)

As below. This needs to say something about letting the guest know
that it might want to let a driver manage it separately from normal
system RAM.

> +#
>  # @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145, points
>  #     to the nodeid which has the memory controller responsible for
>  #     this NUMA node.  This field provides additional information as
> @@ -514,6 +520,7 @@
>     '*cpus':   ['uint16'],
>     '*mem':    'size',
>     '*memdev': 'str',
> +   '*spm':    'bool',
>     '*initiator': 'uint16' }}
>  
>  ##
> diff --git a/qemu-options.hx b/qemu-options.hx
> index fca2b7bc74..ffcd1f47cf 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -431,7 +431,7 @@ ERST
>  
>  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
> -    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
> +    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node][,spm=on|off]\n"
>      "-numa dist,src=source,dst=destination,val=distance\n"
>      "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
>      "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n"
> @@ -440,7 +440,7 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>  SRST
>  ``-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator]``
>    \ 
> -``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator]``
> +``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator][,spm=on|off]``
>    \
>  ``-numa dist,src=source,dst=destination,val=distance``
>    \ 
> @@ -508,6 +508,13 @@ SRST
>      largest bandwidth) to this NUMA node. Note that this option can be
>      set only when the machine property 'hmat' is set to 'on'.
>  
> +    '\ ``spm``\ ' option marks the memory region of this NUMA node as
> +    Specific Purpose Memory (SPM). When enabled, the memory will be
> +    reported to the guest as soft reserved, allowing device drivers to
> +    manage it separately from normal system RAM. This is useful for
> +    device-specific memory that should not be used as general purpose
> +    memory. This option is only supported on x86 platforms.

This wants tweaking.  As came up at the LPC discussion, SPM is for
memory that 'might' be used as general purpose memory if the policy of the
guest is to do so - as Alistair pointed out at LPC, people don't actually
do that very often, but none the less that's why this type exists. It is
a strong hint to the guest that it needs to apply a policy choice to
what happens to this memory.

Reserved is for memory that is only suitable for use other than generic
memory.

