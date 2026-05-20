Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A32CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfZ6-0005HG-M7; Wed, 20 May 2026 07:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wPfYu-0005Ev-7d
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:58:08 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wPfYr-0002MY-RH
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:58:07 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 687DE4431C;
 Wed, 20 May 2026 10:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B6B1F00894;
 Wed, 20 May 2026 10:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779271333;
 bh=aIpug8Xhuvwvpey0104SYTmAB76CSl7Xcf+smxCd7OU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=KAV6e7fVUzLr+qWMlhdMvFxRJBuKVN8eti6+y6RG3nDvabjVWQfjwa+pOwLanm/7j
 ZLcARKwv44cN9VWrR3WOu2l00+w2eIuMdzXKf02VlQdTSUwTeE5Nv0yO8NiCKdzdYJ
 QwVc+/e722LXnN+G5HPpQMdpohjoC92vwoPJoqPU3HJhHyHOYmiSpHHiq8bpap5qFr
 AgsLHfNvvcyEAnzjkX4ncXbEwN5redUrGB5Mvse9SlmMg+nbSZ79t86AdjLmP4uyBp
 MLek5ca3Qno8mmBXFt1ZvxIqGaaO8UpEoyZ0SR9wX3fLDc2BhHWbJp74Zt1eAurpPe
 t1SYI82dwvp/A==
Date: Wed, 20 May 2026 11:02:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Lant <joshualant@gmail.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, arpit1.kumar@samsung.com
Subject: Re: [RFC QEMU PATCH 02/10] qdev/qbus: Allow hidden devices to be
 busless on QEMU startup
Message-ID: <20260520110205.428d0395@jic23-huawei>
In-Reply-To: <20260429135717.3048713-3-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
 <20260429135717.3048713-3-joshualant@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 29 Apr 2026 14:48:36 +0100
Joshua Lant <joshualant@gmail.com> wrote:

> Extend the capability for hiding devices, introduced for virtio-net
> device in:
> 
> commit f3a8505656935cde32e28c1c6317f725084da1e0
> Author: Jens Freimann <jfreimann@redhat.com>
> Date:   Tue Oct 29 12:48:55 2019 +0100
> qdev/qbus: add hidden device support
> 
> Currently only endpoint devices can be hidden with a primary device
> and failover (known static configuration). However, looking at future
> composable systems, we see a need for hidden devices which have no associated
> bus upon boot. Move the check for hidden devices to before the bus
> search, and if it is hidden ignore the case where the device was
> described on the CLI without the "bus=" field.
> 
> This is motivated by a specific use-case: implementing the VCS
> command set, part of the CXL specification (CXL r3.2 Section 7.1.3). In
> this scenario a switch controlled by a Fabric Manager is able to change the
> virtual hierarchy of devices seen by a guest within a fixed physical system
> topology. The connecting bus is not known until runtime when
> a bind command is issued by the Fabric Manager.

So this comes back to the earlier comment on whether they are completely
hidden from a guest.  They aren't quite - we need to be able to
get to them via the MCTP or cxl-switch-cci (in band mailbox) paths.

Maybe we can solve that later without any compatibility problems
or by cheating and just searching hidden devices. I'm not sure.
> 
> Signed-off-by: Joshua Lant <joshualant@gmail.com>
> ---
>  system/qdev-monitor.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index f2aa400a77..b51dfe0645 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -650,6 +650,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>      DeviceState *dev;
>      BusState *bus = NULL;
>      QDict *properties;
> +    bool hide_device;
>  
>      driver = qdict_get_try_str(opts, "driver");
>      if (!driver) {
> @@ -663,6 +664,11 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>          return NULL;
>      }
>  
> +    /* Is the device hidden from the guest?
> +     * If yes, no need to find a default bus if none given...
> +     * Bus could be provided at runtime (i.e. in a switch)*/
> +    hide_device = qdev_should_hide_device(opts, from_json, errp);
> +
>      /* find bus */
>      path = qdict_get_try_str(opts, "bus");
>      if (path != NULL) {
> @@ -675,14 +681,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>                         driver, object_get_typename(OBJECT(bus)));
>              return NULL;
>          }
> -    } else if (dc->bus_type != NULL) {
> +    } else if (dc->bus_type != NULL && !hide_device) {
>          bus = qdev_find_default_bus(dc, errp);
>          if (!bus) {
>              return NULL;
>          }
>      }
>  
> -    if (qdev_should_hide_device(opts, from_json, errp)) {
> +    if (hide_device) {
>          if (bus && !qbus_is_hotpluggable(bus)) {
>              error_setg(errp, "Bus '%s' does not support hotplugging",
>                         bus->name);


