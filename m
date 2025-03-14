Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBF5C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 20:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttBYK-0006O4-FO; Fri, 14 Mar 2025 16:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1ttBYG-0006NX-MA
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 16:22:41 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1ttBYE-0003uU-OY
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 16:22:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 1947BA4729D;
 Fri, 14 Mar 2025 20:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974E8C4CEE3;
 Fri, 14 Mar 2025 20:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741983756;
 bh=e/+ICA0UdW+Xu6KMh6EABG3DWjPfafP8epBewffPOR0=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=iN6snPiAnZ9QTC3EYOVHsXSbCT238s42nuZ8Fre6KzS3rGSmIfAJOlOpWsedSww3Z
 vNRciT5mpKmdJiodZ6wvYkSl9GnkPbSV0S7r6fvyFUSwVXiQntxHO2thHlt2wuSCoR
 F0aIYYq2wYmyomk/3l7iAJ1TJX6tCh6lvoHxYSu4tYPQWmS+0GVI+Cp/vegxQVfNns
 zZ/j+18a/mu9DSL6HLdFbwY4/TMTFS6bFifyUL1sViu9PbouwjxhpJLiWlv+KUcgLS
 7CB9ilXt230Ob6J84Y9aBBVczss5OPZkmC0duPxuX95qEyJqTyD1qY3ev5qnrRzsFR
 kwESDEqPXJdlw==
Date: Fri, 14 Mar 2025 13:22:34 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Markus Armbruster <armbru@redhat.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, edgar.iglesias@gmail.com, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/2] hw/xen: Downgrade a xen_bus_realize() non-error to
 warning
In-Reply-To: <20250314143500.2449658-3-armbru@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2503141321300.3477110@ubuntu-linux-20-04-desktop>
References: <20250314143500.2449658-1-armbru@redhat.com>
 <20250314143500.2449658-3-armbru@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=sstabellini@kernel.org; helo=nyc.source.kernel.org
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

On Fri, 14 Mar 2025, Markus Armbruster wrote:
> xen_bus_realize() reports a failure to set up a watch as error, but it
> doesn't treat it as one: it simply continues.  Report a warning
> instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-bus.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index 2aacc1436f..f808a01813 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -353,10 +353,9 @@ static void xen_bus_realize(BusState *bus, Error **errp)
>              xs_node_watch(xenbus->xsh, node, key, xen_bus_backend_changed,
>                            xenbus, &local_err);
>          if (local_err) {
> -            /* This need not be treated as a hard error so don't propagate */
> -            error_reportf_err(local_err,
> -                              "failed to set up '%s' enumeration watch: ",
> -                              type[i]);
> +            warn_reportf_err(local_err,
> +                             "failed to set up '%s' enumeration watch: ",
> +                             type[i]);
>              local_err = NULL;
>          }
>  
> -- 
> 2.48.1
> 

