Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B217CFC52C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Hy6-0003CG-K6; Mon, 14 Oct 2024 06:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0Hy5-0003C1-1R
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0Hy1-0001eK-8h
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728900379;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=YmVMb1LjhTDZqr3m/fsp4Y9cVdZKuACkwYPssaggWis=;
 b=XtOd2f+J4zhzLV0E8JVWJm9q3bgKpCp/6oBR/sqRSEY+lrNDJVT2/7tIXWYV1YxmglDw+w
 /X0+9P/+HAmB5XqVZIdi4EAXpNnARxAxMQ6x4oRpNcsfk5p6EcNVd1mUcOZ3ATJAo5cD19
 Dv1GVV7BxawIn4xWy/7if6+MXrNVGrA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-MGe3aOA1N9Gi78dz2zQAyQ-1; Mon,
 14 Oct 2024 06:06:17 -0400
X-MC-Unique: MGe3aOA1N9Gi78dz2zQAyQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 611CC1953943; Mon, 14 Oct 2024 10:06:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.155])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7CB519560AA; Mon, 14 Oct 2024 10:06:13 +0000 (UTC)
Date: Mon, 14 Oct 2024 11:06:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v2 4/4] For correcting code style: Variable declarations
 moved to the beginning of blocks Followed the coding style of using
 snake_case for variable names. And merged redundant route and networkroute
 variables.
Message-ID: <ZwztEZ3D3uWxbdkU@redhat.com>
References: <20241011031937.92216-1-demeng@redhat.com>
 <20241011031937.92216-5-demeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011031937.92216-5-demeng@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Same comment about $SUBJECT being too long. You need a blank line after
the 1st line in the commit message.

On Fri, Oct 11, 2024 at 11:19:37AM +0800, Dehan Meng wrote:
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  qga/commands-linux.c | 116 ++++++++++++++++++++-----------------------
>  1 file changed, 53 insertions(+), 63 deletions(-)
> 
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 4f0e38be81..c6cca630ef 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -2094,12 +2094,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
>      return head;
>  }
>  
> -static char *hexToIPAddress(const void *hexValue, int is_ipv6)
> +static char *hex_to_ip_address(const void *hex_value, int is_ipv6)
>  {
>      if (is_ipv6) {
>          char addr[INET6_ADDRSTRLEN];
>          struct in6_addr in6;
> -        const char *hexStr = (const char *)hexValue;
> +        const char *hex_str = (const char *)hex_value;
>          int i;
>  
>          for (i = 0; i < 16; i++) {
> @@ -2111,11 +2111,11 @@ static char *hexToIPAddress(const void *hexValue, int is_ipv6)
>  
>          return g_strdup(addr);
>      } else {
> -        unsigned int hexInt = *(unsigned int *)hexValue;
> -        unsigned int byte1 = (hexInt >> 24) & 0xFF;
> -        unsigned int byte2 = (hexInt >> 16) & 0xFF;
> -        unsigned int byte3 = (hexInt >> 8) & 0xFF;
> -        unsigned int byte4 = hexInt & 0xFF;
> +        unsigned int hex_int = *(unsigned int *)hex_value;
> +        unsigned int byte1 = (hex_int >> 24) & 0xFF;
> +        unsigned int byte2 = (hex_int >> 16) & 0xFF;
> +        unsigned int byte3 = (hex_int >> 8) & 0xFF;
> +        unsigned int byte4 = hex_int & 0xFF;
>  
>          return g_strdup_printf("%u.%u.%u.%u", byte4, byte3, byte2, byte1);
>      }
> @@ -2131,6 +2131,7 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
>      int firstLine;
>      int is_ipv6;
>      int i;
> +    char iface[IFNAMSIZ];
>  
>      for (i = 0; i < 2; i++) {
>          firstLine = 1;
> @@ -2146,72 +2147,61 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
>                  firstLine = 0;
>                  continue;
>              }
> -            GuestNetworkRoute *route = NULL;
> -            GuestNetworkRoute *networkroute;
> -            char Iface[IFNAMSIZ];
> -            if (is_ipv6) {
> -                char Destination[33], Source[33], NextHop[33];
> -                int DesPrefixlen, SrcPrefixlen, Metric, RefCnt, Use, Flags;
>  
> -                /* Parse the line and extract the values */
> +            GuestNetworkRoute *route = g_new0(GuestNetworkRoute, 1);
> +
> +            if (is_ipv6) {
> +                char destination[33], source[33], next_hop[33];
> +                int des_prefixlen, src_prefixlen, metric, refcnt, use, flags;
>                  if (sscanf(line, "%32s %x %32s %x %32s %x %x %x %x %s",
> -                           Destination, &DesPrefixlen, Source,
> -                           &SrcPrefixlen, NextHop, &Metric, &RefCnt,
> -                           &Use, &Flags, Iface) != 10) {
> +                           destination, &des_prefixlen, source,
> +                           &src_prefixlen, next_hop, &metric, &refcnt,
> +                           &use, &flags, iface) != 10) {
>                      continue;
>                  }
>  
> -                route = g_new0(GuestNetworkRoute, 1);

By moving this up to the time of declaration of 'route', you've introduced
a memory leak when the above 'sscanf' line triggers the 'continue' branch.

> -                networkroute = route;
> -                networkroute->iface = g_strdup(Iface);
> -                networkroute->destination = hexToIPAddress(Destination, 1);
> -                networkroute->metric = Metric;
> -                networkroute->source = hexToIPAddress(Source, 1);
> -                networkroute->desprefixlen = g_strdup_printf(
> -                    "%d", DesPrefixlen
> -                );
> -                networkroute->srcprefixlen = g_strdup_printf(
> -                    "%d", SrcPrefixlen
> -                );
> -                networkroute->nexthop = hexToIPAddress(NextHop, 1);
> -                networkroute->has_flags = true;
> -                networkroute->flags = Flags;
> -                networkroute->has_refcnt = true;
> -                networkroute->refcnt = RefCnt;
> -                networkroute->has_use = true;
> -                networkroute->use = Use;
> -                networkroute->version = 6;
> -            } else {
> -                unsigned int Destination, Gateway, Mask, Flags;
> -                int RefCnt, Use, Metric, MTU, Window, IRTT;
> +                route->iface = g_strdup(iface);
> +                route->destination = hex_to_ip_address(destination, 1);
> +                route->source = hex_to_ip_address(source, 1);
> +                route->nexthop = hex_to_ip_address(next_hop, 1);
> +                route->desprefixlen = g_strdup_printf("%d", des_prefixlen);
> +                route->srcprefixlen = g_strdup_printf("%d", src_prefixlen);
> +                route->metric = metric;
> +                route->has_flags = true;
> +                route->flags = flags;
> +                route->has_refcnt = true;
> +                route->refcnt = refcnt;
> +                route->has_use = true;
> +                route->use = use;
> +                route->version = 6;
>  
> -                /* Parse the line and extract the values */
> +            } else {
> +                unsigned int destination, gateway, mask, flags;
> +                int refcnt, use, metric, mtu, window, irtt;
>                  if (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
> -                           Iface, &Destination, &Gateway, &Flags, &RefCnt,
> -                           &Use, &Metric, &Mask, &MTU, &Window, &IRTT) != 11) {
> +                           iface, &destination, &gateway, &flags, &refcnt,
> +                           &use, &metric, &mask, &mtu, &window, &irtt) != 11) {
>                      continue;
>                  }
>  
> -                route = g_new0(GuestNetworkRoute, 1);

Again, introduced a memory leak for the same reason.

> -                networkroute = route;
> -                networkroute->iface = g_strdup(Iface);
> -                networkroute->destination = hexToIPAddress(&Destination, 0);
> -                networkroute->gateway = hexToIPAddress(&Gateway, 0);
> -                networkroute->mask = hexToIPAddress(&Mask, 0);
> -                networkroute->metric = Metric;
> -                networkroute->has_flags = true;
> -                networkroute->flags = Flags;
> -                networkroute->has_refcnt = true;
> -                networkroute->refcnt = RefCnt;
> -                networkroute->has_use = true;
> -                networkroute->use = Use;
> -                networkroute->has_mtu = true;
> -                networkroute->mtu = MTU;
> -                networkroute->has_window = true;
> -                networkroute->window = Window;
> -                networkroute->has_irtt = true;
> -                networkroute->irtt = IRTT;
> -                networkroute->version = 4;
> +                route->iface = g_strdup(iface);
> +                route->destination = hex_to_ip_address(&destination, 0);
> +                route->gateway = hex_to_ip_address(&gateway, 0);
> +                route->mask = hex_to_ip_address(&mask, 0);
> +                route->metric = metric;
> +                route->has_flags = true;
> +                route->flags = flags;
> +                route->has_refcnt = true;
> +                route->refcnt = refcnt;
> +                route->has_use = true;
> +                route->use = use;
> +                route->has_mtu = true;
> +                route->mtu = mtu;
> +                route->has_window = true;
> +                route->window = window;
> +                route->has_irtt = true;
> +                route->irtt = irtt;
> +                route->version = 4;
>              }
>  
>              QAPI_LIST_APPEND(tail, route);
> -- 
> 2.40.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


