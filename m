Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8EFCF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 07:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssdvi-0008Pv-Bk; Mon, 23 Sep 2024 03:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1ssdvg-0008PP-6x
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 03:56:20 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1ssdvc-000616-57
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 03:56:19 -0400
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 59C88138026F;
 Mon, 23 Sep 2024 03:56:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Mon, 23 Sep 2024 03:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727078172; x=
 1727164572; bh=eTz99Eakisq4ROFL2DK/NTXgm+4NR1A4pe1EaoYocC0=; b=C
 tsAFO9b+vuuOQjOFddt0+OiL394U2sJkA5wAWHXhkSCLTopestQtH+cf1xP/dH9u
 yj+ZqySiReaScDj5E4TqD+xAhSOP/A8L3bj+AgMDWwhhHegT2NX70CCy6YRvPVzy
 3uevZSD0q4GfVOwUtnrJE6vkLufXiwEnkzDOtw5El9dAel17+V+IemTBZMuyYjX9
 ejOrWtEJ9P46WRlxmp56giMyV93xwf12UqTWebH1fsP0Wb1lHIiG/+UM9mmQK7kp
 WKORXzR1fBWKQvqoK9szUHJkpPEG4PDGhohAe0Izdgsmy5DCKPr/xTLJs74eLAAe
 SRlXo1PeFacC+kYZMrZVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1727078172; x=1727164572; bh=eTz99Eakisq4ROFL2DK/NTXgm+4N
 R1A4pe1EaoYocC0=; b=Mk6Hkz+ZY/Mwvknb84FA/PIeGS3d1NTMwstRDmyCJxrc
 E1hBJogrIcFi47NIhTeDI4+ISbH3TWk3wyXinPK0D+TOoVmoxNhizuuJ42XhVwvh
 SiAXa5mnXW9iqAXuG10zd736/0o9CYkw8Q2RNFqogwgTz1AYOU6LX32UGgUp43q/
 swZDos/qELBreCosk4k/AulDIsZD5kraq3RryjZXAzeye+/OjtF5faWaba6YAAcz
 EVV2p0r+gA3hPZX8w1+V4cUBuJt/ET2RbmA9AenOgZjHD8V7rCPl97GZ14jkE+in
 vbt4CBJz1L4xG+1B+f7ccuEQhQqVAbBAA7UE16MkHA==
X-ME-Sender: <xms:Gx_xZkA06_TIRUhXQFoPnqMGYkr0FJAM1mX3ho2ntgmgr94J798a_Q>
 <xme:Gx_xZmjbDIxHkwoSefILdNd5LMQlNpRn7xAU-nAGpj-pOKrDOL0mOH13KB8f0Uysh
 ImCxiQpO6PJccdELzw>
X-ME-Received: <xmr:Gx_xZnkz2ZkzfT7TojkK4gplMprH3hEI_Zv_i5vYqQ7TtIM1AFL9RxeL_hHEgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelkedguddvkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
 evuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepmfhlrghushculfgvnhhsvghn
 uceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnhepveejtd
 ejteevfefhffehiedvffdvudelvdeigfekfeevledtieetffehgeeggfdunecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlh
 gvvhgrnhhtrdgukhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhr
 tghpthhtoheprghruhhnrdhkkhgrsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepqh
 gvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghushgthhes
 khgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpd
 hrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Gx_xZqwMKUyG1bIp1lmVYT5A3mR3BCnVrOJ6-XACciXK4JBQGyRdow>
 <xmx:Gx_xZpSxsGFTh4sbXMPs9eOdzWXCgRkz5yZuXXUjX0guvg1inrDbyA>
 <xmx:Gx_xZlYwHeXHISyAiNijDNEQZpXnSKDe4UftLtJAxcx-rMI_QzzZ2A>
 <xmx:Gx_xZiRqwFwwJo07hADZGb4GHiffg9MwdosJd8W0cS8U4uVwwPEBlg>
 <xmx:HB_xZiKeXk05h4uLuXIM5yaRdv4QqLyeBNgMUZDLVyAz9uppoaT2q7x9>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Sep 2024 03:56:10 -0400 (EDT)
Date: Mon, 23 Sep 2024 09:56:09 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Arun Kumar <arun.kka@samsung.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, foss@defmacro.it
Subject: Re: [PATCH] hw/nvme: clear masked events from the aer queue
Message-ID: <ZvEfGe6rSCuUEvie@AALNPWKJENSEN.aal.scsc.local>
References: <CGME20240906052849epcas5p2602787ff0700a8feca81ad173f957ffb@epcas5p2.samsung.com>
 <20240905235859.3416741-1-arun.kka@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905235859.3416741-1-arun.kka@samsung.com>
Received-SPF: pass client-ip=103.168.172.145; envelope-from=its@irrelevant.dk;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Sep  6 05:28, Arun Kumar wrote:
> clear masked events from the aer queue when get log page is issued with
> rae=0 without checking for the presence of outstanding aer requests
> 
> Signed-off-by: Arun Kumar <arun.kka@samsung.com>
> ---

Hi Arun,

Thanks, LGTM. One small nit below.

>  hw/nvme/ctrl.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..85039779da 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -1649,9 +1649,16 @@ static void nvme_smart_event(NvmeCtrl *n, uint8_t event)
>  
>  static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
>  {
> +    NvmeAsyncEvent *event, *next;
>      n->aer_mask &= ~(1 << event_type);
>      if (!QTAILQ_EMPTY(&n->aer_queue)) {

It's safe to remove the QTAILQ_EMTPY check as well.

> -        nvme_process_aers(n);
> +        QTAILQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
> +            if (event->result.event_type == event_type) {
> +                QTAILQ_REMOVE(&n->aer_queue, event, entry);
> +                n->aer_queued--;
> +                g_free(event);
> +            }
> +        }
>      }
>  }

We may want to check the mask when inserting as well? Currently
nvme_enqueue_event does not check the aer_mask and always inserts an
event, even if we have posted an AEN for a particular event type (but
event type has not been cleared yet).

