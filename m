Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AF8D15DBD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vXe-0001TL-4W; Mon, 21 Oct 2024 12:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2vXc-0001Sp-1z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2vXZ-0007D7-SA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729529156;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NaEfoQe7qSZ5BfXtr/BGm8aV+6UTg4Np56OTSFJzk0w=;
 b=Rkj4QuGVb3XLUN+ylFWrC3jR70Gw//V+48q/YPx3e4TPc2Wt5zXAMNlsvDy7xpU4WB88Ou
 hzGAyaFqrVtAZFp+PopZWH84ug3wGVE542BLlV3ww70Moba1M7Maf/GVca5hk0nLtI/XzZ
 F0kFwLareSc3CjMA0uSWNtf6wyWHXVo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-OvhZqK0kMGq8CPYlDuRTwg-1; Mon,
 21 Oct 2024 12:45:54 -0400
X-MC-Unique: OvhZqK0kMGq8CPYlDuRTwg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73D801955DAE; Mon, 21 Oct 2024 16:45:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5462195605F; Mon, 21 Oct 2024 16:45:48 +0000 (UTC)
Date: Mon, 21 Oct 2024 17:45:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v3 1/4] qemu-ga: 'Null' check for mandatory parameters
Message-ID: <ZxaFOdhqE54A5vWf@redhat.com>
References: <20241021132839.463255-1-demeng@redhat.com>
 <20241021132839.463255-7-demeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021132839.463255-7-demeng@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 21, 2024 at 09:28:36PM +0800, Dehan Meng wrote:
> sscanf return values are checked and add 'Null' check for
> mandatory parameters.
> 
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  qga/commands-linux.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 51d5e3d927..f0e9cdd27c 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -2103,7 +2103,9 @@ static char *hexToIPAddress(const void *hexValue, int is_ipv6)
>          int i;
>  
>          for (i = 0; i < 16; i++) {
> -            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
> +            if (sscanf(&hex_str[i * 2], "%02hhx", &in6.s6_addr[i]) != 1) {
> +                return NULL;
> +            }
>          }
>          inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);
>  
> @@ -2164,6 +2166,10 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
>                  networkroute = route;
>                  networkroute->iface = g_strdup(Iface);
>                  networkroute->destination = hexToIPAddress(Destination, 1);
> +                if (networkroute->destination == NULL) {
> +                    g_free(route);
> +                    continue;
> +                }

This is still leaking the 'networkroute->iface' string.

The existing code is a bit strange having 'route' and 'networkroute'
variables.

I'd suggest removing the "route" variable entirely.

Then have a code pattern that relies on g_autoptr to automatically
free the struct & all its fields.

eg something that looks approx like this:

   g_autoptr(GuestNetorkRoute) networkroute = NULL;

   ...
   
   if (is_ipv6) {
       ...
       networkroute = g_new0(GuestNetorkRoute, 1);
       networkroute->iface = g_strdup(Iface);
       networkroute->destination = hexToIPAddress(Destination, 1);
       if (networkroute->destination == NULL) {
          continue;
       }
       ...
   } else {
       ...
       networkroute = g_new0(GuestNetorkRoute, 1);
       networkroute->iface = g_strdup(Iface);
       networkroute->destination = hexToIPAddress(Destination, 1);
       if (networkroute->destination == NULL) {
          continue;
       }
       ...
   }

   QAPI_LIST_APPEND(tail, g_steal_pointer(&networkroute));
  

>                  networkroute->metric = Metric;
>                  networkroute->source = hexToIPAddress(Source, 1);
>                  networkroute->desprefixlen = g_strdup_printf(
> @@ -2195,6 +2201,10 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
>                  networkroute = route;
>                  networkroute->iface = g_strdup(Iface);
>                  networkroute->destination = hexToIPAddress(&Destination, 0);
> +                if (networkroute->destination == NULL) {
> +                    g_free(route);
> +                    continue;
> +                }
>                  networkroute->gateway = hexToIPAddress(&Gateway, 0);
>                  networkroute->mask = hexToIPAddress(&Mask, 0);
>                  networkroute->metric = Metric;
> -- 
> 2.40.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


