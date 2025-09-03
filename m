Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A7ACA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 14:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utoDU-00016P-DY; Wed, 03 Sep 2025 10:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1utoDT-00016B-82
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1utoDQ-0001X8-Da
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756908717;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6YvKYSGJCVvrVbUyGGlxZ6400hmQigYKNiTQ6AngArA=;
 b=RypgCa9V8fGt7Lzblt+fvCkXGK/LIJmxVhmgyV2DlPP2yETOs3u0ZlLHgc+ahgHJzaWIq2
 r5vnCf6eddsQZkI7XOnSYA2b1OxnFPPLhOhmF8p8o4JL4yMsyDNqchOk24YuupPKzr1Cy2
 +BJAr8jvkXp6znEnZZ8Gssb8wV91Tlc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-oJnDZIZCPti2Tw9vtJ_bog-1; Wed,
 03 Sep 2025 10:11:54 -0400
X-MC-Unique: oJnDZIZCPti2Tw9vtJ_bog-1
X-Mimecast-MFC-AGG-ID: oJnDZIZCPti2Tw9vtJ_bog_1756908708
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AE1E180057A; Wed,  3 Sep 2025 14:11:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.63])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C87819560B9; Wed,  3 Sep 2025 14:11:41 +0000 (UTC)
Date: Wed, 3 Sep 2025 16:11:37 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 peterx@redhat.com, mst@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v2 1/8] net/tap: add some trace points
Message-ID: <aLhLvIts2vVl63Xr@redhat.com>
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
 <20250903133706.1177633-2-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903133706.1177633-2-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 03, 2025 at 04:36:58PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Add trace points to simplify debugging migration.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  net/tap.c        | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
>  net/trace-events |  7 ++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/net/tap.c b/net/tap.c
> index 2530627a9a..224fb37310 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -43,6 +43,7 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/sockets.h"
>  #include "hw/virtio/vhost.h"
> +#include "trace.h"
>  
>  #include "net/tap.h"
>  
> @@ -148,6 +149,9 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
>      g_autofree struct iovec *iov_copy = NULL;
>      struct virtio_net_hdr hdr = { };
>  
> +    trace_tap_receive_iov(s->using_vnet_hdr, s->host_vnet_hdr_len, iovcnt,
> +                          iov->iov_len);
> +
>      if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
>          iov_copy = g_new(struct iovec, iovcnt + 1);
>          iov_copy[0].iov_base = &hdr;
> @@ -183,6 +187,49 @@ static void tap_send_completed(NetClientState *nc, ssize_t len)
>      tap_read_poll(s, true);
>  }
>  
> +static char *tap_dump_packet(const uint8_t *buf, int size)
> +{
> +    int i, j;
> +    char hex_line[80];  /* Enough space for hex pairs + spaces */
> +    char ascii_line[17]; /* 16 + 1 for null terminator */
> +    GString *dump_str = g_string_new(NULL);
> +
> +    g_string_append_printf(dump_str, "Packet dump (%d bytes):\n", size);

It occurrs to me that this ability to dump a buffer is likely useful for
other areas of QEMU. How about moving this to somewhere in util/ and
renaming it to something like "dump_buffer".

You can drop the 'Packet dump' prefix, and bytes count, as you can
include that info in the trace-events format string instead.

> +
> +    for (i = 0; i < size; i += 16) {
> +        memset(hex_line, 0, sizeof(hex_line));
> +        memset(ascii_line, 0, sizeof(ascii_line));
> +
> +        /* Build hex line in groups of 2 bytes (4 hex chars) */
> +        int hex_pos = 0;
> +        for (j = 0; j < 16 && (i + j) < size; j += 2) {
> +            if (i + j + 1 < size) {
> +                /* Two bytes available */
> +                hex_pos += snprintf(hex_line + hex_pos,
> +                                    sizeof(hex_line) - hex_pos,
> +                                    "%02x%02x ", buf[i + j], buf[i + j + 1]);
> +            } else {
> +                /* Only one byte left */
> +                hex_pos += snprintf(hex_line + hex_pos,
> +                                    sizeof(hex_line) - hex_pos,
> +                                    "%02x   ", buf[i + j]);
> +            }
> +        }
> +
> +        /* Build ASCII line */
> +        for (j = 0; j < 16 && (i + j) < size; j++) {
> +            uint8_t byte = buf[i + j];
> +            ascii_line[j] = (byte >= 32 && byte <= 126) ? byte : '.';
> +        }
> +
> +        /* Add the line in tcpdump-like format */
> +        g_string_append_printf(dump_str, "\t0x%04x:  %-40s %s\n",
> +                               i, hex_line, ascii_line);
> +    }
> +
> +    return g_string_free(dump_str, false);
> +}

> diff --git a/net/trace-events b/net/trace-events
> index cda960f42b..b51427f539 100644
> --- a/net/trace-events
> +++ b/net/trace-events
> @@ -29,3 +29,10 @@ vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asid_num) "
>  vhost_vdpa_net_load_cmd(void *s, uint8_t class, uint8_t cmd, int data_num, int data_size) "vdpa state: %p class: %u cmd: %u sg_num: %d size: %d"
>  vhost_vdpa_net_load_cmd_retval(void *s, uint8_t class, uint8_t cmd, int r) "vdpa state: %p class: %u cmd: %u retval: %d"
>  vhost_vdpa_net_load_mq(void *s, int ncurqps) "vdpa state: %p current_qpairs: %d"
> +
> +# tap.c
> +tap_receive_iov(bool using_vnet_hdr, uint32_t host_vnet_hdr_len, int iovcnt, size_t iov_len) "using_vnet_hdr:%d host_vnet_hdr_len:%u iovcnt:%d iov_len:%zu"
> +tap_send_packet(bool using_vnet_hdr, uint32_t host_vnet_hdr_len, int size) "using_vnet_hdr:%d host_vnet_hdr_len:%u size:%d"
> +tap_enable(void) "tap enabled"
> +tap_disable(void) "tap disabled"
> +tap_packet_dump(const char *dump_str) "%s"

This could be 

     tap_packet_dump(size_t bytes, const char *dump_str) "Package dump (%zu bytes) %s"

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


