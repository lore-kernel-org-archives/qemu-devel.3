Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE4606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iNFbZe7n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJ5i-0002LX-RU; Mon, 26 Oct 2026 07:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLJ5g-0002L7-R3
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLJ5d-0002AS-Sh
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793014928;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=yFDTwb0KvzZY0SVjrfXnVpqTKh5TAP1FZorDGgY+CM8=;
 b=iNFbZe7nKcwHOOtW616lfTohyBsJRDfWatYySJCxPSKY0MfhSmeySK2vpiMGDc+b93gJUA
 8HocchwUWQFtCq9x1GqV9BhazAL0/8b3haE6i8muYGpuSYN59lif8GPC1Kb+xDQ1XtSZ+s
 PbHwtGdfRF/cGToHJlKaL0+5somC56I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-OMP_SyxbOtSndIF4_O_Djg-1; Mon,
 26 Oct 2026 07:42:06 -0400
X-MC-Unique: OMP_SyxbOtSndIF4_O_Djg-1
X-Mimecast-MFC-AGG-ID: OMP_SyxbOtSndIF4_O_Djg_1793014925
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1A501955BC1; Mon, 26 Oct 2026 11:42:04 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2648D410; Mon, 26 Oct 2026 11:42:01 +0000 (UTC)
Date: Mon, 26 Oct 2026 11:41:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2] qga: implement 'guest-network-get-route' for FreeBSD
Message-ID: <at88hq0I8VdpQcKJ@redhat.com>
References: <20261017133532.64567-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261017133532.64567-1-bogorodskiy@gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 17, 2026 at 03:35:32PM +0200, Roman Bogorodskiy wrote:
> Implement 'guest-network-get-route' for FreeBSD. This
> implementation uses the sysctl(3) interface to get
> the routing table.
> 
> Limitations:
> 
>  - This implementation does not populate irtt, refcnt, use,
>    window, source, and srcprefixlen fields.
>  - The implementation uses the default FIB (routing table) 0.
>    Selecting QGA's active FIB is left for the follow-up patch.
> 
> While here, spell Windows correctly in @GuestNetworkRoute documentation
> in qapi-schema.json.
> 
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
> Changes since v1:
> 
>  - qga/qapi-schema.json spelling: windows -> Windows, freebsd -> FreeBSD
>    in the "@GuestNetworkRoute" documentation.
>  - meson.build: check that the 'struct rt_metrics' has 'rmx_metric'
>    member which is available only on FreeBSD 16.
> 
>  meson.build          |   6 ++
>  qga/commands-bsd.c   | 180 +++++++++++++++++++++++++++++++++++++++++++
>  qga/qapi-schema.json |  31 ++++----
>  3 files changed, 202 insertions(+), 15 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 255c887e8e..cb69d5a3c7 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2759,6 +2759,12 @@ config_host_data.set('HAVE_STRUCT_STAT_ST_ATIM',
>  config_host_data.set('HAVE_BLK_ZONE_REP_CAPACITY',
>                       cc.has_member('struct blk_zone', 'capacity',
>                                     prefix: '#include <linux/blkzoned.h>'))
> +config_host_data.set('HAVE_STRUCT_RT_METRICS_RMX_METRIC',
> +                     cc.has_member('struct rt_metrics', 'rmx_metric',
> +                                   prefix: '''
> +                                       #include <sys/types.h>
> +                                       #include <sys/socket.h>
> +                                       #include <net/route.h>'''))
>  
>  # has_type
>  config_host_data.set('CONFIG_IOVEC',
> diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
> index 1c51d099eb..63254e0812 100644
> --- a/qga/commands-bsd.c
> +++ b/qga/commands-bsd.c
> @@ -21,6 +21,11 @@
>  #include <sys/mount.h>
>  #include <net/if_dl.h>
>  #include <sys/statvfs.h>
> +#if defined(__FreeBSD__)
> +#include <sys/sysctl.h>
> +#include <net/route.h>
> +#include <net/if.h>
> +#endif
>  #if defined(__NetBSD__) || defined(__OpenBSD__)
>  #include <net/if_arp.h>
>  #include <netinet/if_ether.h>
> @@ -228,4 +233,179 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
>      free_fs_mount_list(&mounts);
>      return ret;
>  }
> +
> +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
> +{
> +    GuestNetworkRouteList *head = NULL, **tail = &head;
> +    int mib[] = { CTL_NET, PF_ROUTE, 0, AF_UNSPEC, NET_RT_DUMP, 0, 0 };
> +    g_autofree char *buf = NULL;
> +    size_t len;
> +
> +    if (sysctl(mib, nitems(mib), NULL, &len, NULL, 0) == -1) {
> +        error_setg_errno(errp, errno, "sysctl size");
> +        return NULL;
> +    }
> +
> +    buf = g_malloc0(len);
> +
> +    if (sysctl(mib, nitems(mib), buf, &len, NULL, 0) == -1) {
> +        error_setg_errno(errp, errno, "sysctl routes");
> +        return NULL;
> +    }
> +
> +    for (char *p = buf, *end = buf + len; p < end; ) {
> +        struct rt_msghdr *rtm = (struct rt_msghdr *)p;
> +        struct sockaddr *addresses[RTAX_MAX] = { NULL };
> +        struct sockaddr *sa;
> +        char destination[NI_MAXHOST];
> +        char gateway[NI_MAXHOST];
> +        char ifname[IFNAMSIZ] = "?";

IIUC, by s3etting this to "?" you're expecting it to be
left alone if ....

> +        const struct sockaddr *dst = NULL;
> +        const struct sockaddr *gw = NULL;
> +        const struct sockaddr *netmask = NULL;
> +        struct sockaddr_in normalized_mask = { 0 };
> +        char netmask_buf[INET_ADDRSTRLEN];
> +
> +        g_autoptr(GuestNetworkRoute) route = g_new0(GuestNetworkRoute, 1);
> +
> +        if ((size_t)(end - p) < sizeof(*rtm) ||
> +            rtm->rtm_msglen < sizeof(*rtm) ||
> +            rtm->rtm_msglen > (size_t)(end - p)) {
> +            break;
> +        }
> +
> +        p += rtm->rtm_msglen;
> +
> +        if (rtm->rtm_version != RTM_VERSION) {
> +            continue;
> +        }
> +
> +        sa = (struct sockaddr *)(rtm + 1);
> +        for (int i = 0; i < RTAX_MAX; i++) {
> +            if (rtm->rtm_addrs & (1U << i)) {
> +                addresses[i] = sa;
> +                sa = (struct sockaddr *)((char *)sa + SA_SIZE(sa));
> +            }
> +        }
> +
> +        if_indextoname(rtm->rtm_index, ifname);

....this fails to resolve the interface name. 

> +
> +        route->iface = g_strdup(ifname);

This is a non-optional field so we must return something on
failure, and I see that the Windows impl returns a string
based on the if index. eg matching logic would be more
like:

   if (if_indextoname(rtm->rtm_index, ifname) > 0) {
      route->iface = g_strdup(ifname)
   } else {
      route->iface = g_strdup_printf("if%u", rtm->rtm_index);
   }


> +        if (dst->sa_family == AF_INET) {
> +            if (inet_ntop(AF_INET,
> +                          &((const struct sockaddr_in *)dst)->sin_addr,
> +                          destination, NI_MAXHOST) == NULL) {
> +                continue;
> +            }
> +            route->version = 4;
> +        } else if (dst->sa_family == AF_INET6) {
> +            if (getnameinfo(dst, dst->sa_len,
> +                            destination, NI_MAXHOST,
> +                            NULL, 0, NI_NUMERICHOST) != 0)
> +                continue;
> +            route->version = 6;

Do you need to have different code paths for AF_INET
vs AF_INET6 ?   IIUC,    getnameinfo() should handle
both  AF_INET  and AF_INET6 the same way, so we ought
to not need inet_ntop() path at all.

> +        } else {
> +            continue;
> +        }
> +        route->destination = g_strdup(destination);
> +
> +        gw = addresses[RTAX_GATEWAY];
> +        if (gw) {
> +            if (gw->sa_family == AF_INET) {
> +                if (inet_ntop(AF_INET,
> +                              &((const struct sockaddr_in *)gw)->sin_addr,
> +                              gateway, NI_MAXHOST) == NULL) {
> +                    continue;
> +                }
> +                route->gateway = g_strdup(gateway);
> +            } else if (gw->sa_family == AF_INET6) {
> +                if (getnameinfo(gw, gw->sa_len,
> +                                gateway, NI_MAXHOST,
> +                                NULL, 0, NI_NUMERICHOST) != 0) {
> +                    continue;
> +                }
> +                route->nexthop = g_strdup(gateway);
> +            }

Same Q about using getnameinfo() exclusively

> +        }
> +
> +        netmask = addresses[RTAX_NETMASK];
> +        if (dst->sa_family == AF_INET) {
> +            if (netmask && netmask->sa_len != 0) {
> +                memcpy(&normalized_mask, netmask,
> +                       MIN(netmask->sa_len, sizeof(normalized_mask)));
> +            } else if (rtm->rtm_flags & RTF_HOST) {
> +                normalized_mask.sin_addr.s_addr = 0xFFFFFFFF;
> +            }
> +
> +            if (inet_ntop(AF_INET, &normalized_mask.sin_addr,
> +                          netmask_buf, sizeof(netmask_buf)) != NULL) {
> +                route->mask = g_strdup(netmask_buf);
> +            } else {
> +                route->mask = NULL;
> +            }
> +        } else if (dst->sa_family == AF_INET6) {
> +            struct sockaddr_in6 normalized_mask6;
> +            memset(&normalized_mask6, 0, sizeof(normalized_mask6));
> +
> +            if (netmask && netmask->sa_len != 0) {
> +                int prefix_len = 0;
> +                bool valid_mask = true;
> +                bool zero_found = false;
> +
> +                memcpy(&normalized_mask6, netmask,
> +                       MIN(netmask->sa_len, sizeof(normalized_mask6)));
> +
> +                for (int i = 0; i < sizeof(normalized_mask6.sin6_addr); i++) {
> +                    uint8_t byte = normalized_mask6.sin6_addr.s6_addr[i];
> +                    for (int bit = 7; bit >= 0; bit--) {
> +                        if ((byte >> bit) & 1) {
> +                            if (zero_found) {
> +                                valid_mask = false;
> +                                break;
> +                            }
> +                            prefix_len++;
> +                        } else {
> +                            zero_found = true;
> +                        }
> +                    }
> +                    if (!valid_mask) {
> +                        break;
> +                    }
> +                }
> +
> +                if (valid_mask) {
> +                    route->desprefixlen = g_strdup_printf("%d", prefix_len);
> +                } else {
> +                    route->desprefixlen = NULL;
> +                }
> +            } else if (rtm->rtm_flags & RTF_HOST) {
> +                route->desprefixlen = g_strdup("128");
> +            } else {
> +                route->desprefixlen = g_strdup("0");
> +            }
> +        }
> +
> +        if (rtm->rtm_rmx.rmx_mtu) {
> +            route->mtu = rtm->rtm_rmx.rmx_mtu;
> +            route->has_mtu = true;
> +        }
> +
> +        route->flags = (uint32_t)rtm->rtm_flags;
> +        route->has_flags = true;
> +
> +        QAPI_LIST_APPEND(tail, route);
> +        route = NULL;
> +    }
> +
> +    return head;
> +}
>  #endif /* __FreeBSD__ */


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


