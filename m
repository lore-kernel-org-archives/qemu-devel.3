Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D19D0C606
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 12:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Jjw-00030W-0p; Fri, 25 Oct 2024 08:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4Jjt-00030G-Ts
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4Jjs-0003d6-6j
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729860502;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=B9S/IEouqGIyuyHIuaLPuM+goYWbjD0yNKfUV+cFoY0=;
 b=NzyYpEYZRuzovfr+i3EAnXiY9R9a/aFeNbB2Syb4UC0BKbNd4P85H0JRvKClnb6EyZ4tVb
 KvMouh45OoWvZUli7esKExqoasqovt8T74Hx2eGEVyCMz56AN3Se6Yj9OBwK5kwi2gwlId
 pnRIVigUMYzzz3lWCtSQzUMEs+Zxbp8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-3d99tjC7MN6nUr6DDzUDyw-1; Fri,
 25 Oct 2024 08:48:19 -0400
X-MC-Unique: 3d99tjC7MN6nUr6DDzUDyw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 632461955D4D; Fri, 25 Oct 2024 12:48:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6241300018D; Fri, 25 Oct 2024 12:48:15 +0000 (UTC)
Date: Fri, 25 Oct 2024 13:48:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v4 1/5] qemu-ga:  'Null' check for mandatory parameters
Message-ID: <ZxuTjJvrdIKKT4AC@redhat.com>
References: <20241022142948.531325-1-demeng@redhat.com>
 <20241022142948.531325-2-demeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022142948.531325-2-demeng@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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

On Tue, Oct 22, 2024 at 10:29:44PM +0800, Dehan Meng wrote:
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

This still hasn't fixed the leak problems identified in the previous
review of the last version

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


