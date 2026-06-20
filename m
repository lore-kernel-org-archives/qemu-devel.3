Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CF2CD4F26
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 12:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waur7-0007sB-0f; Sat, 20 Jun 2026 08:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waur2-0007lc-7Z
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 08:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waur0-0007O9-9R
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 08:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781958676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7di4haFXasmjlYnXR1K1HgWKAF9SPZDb5eqM1XWFNo=;
 b=essSD1qwdLcj3t0z/A/tPuP2C7HR7j2rzldG03Y8TaC5No6NEvuyuAcGQ4+neD3B7M05xk
 i3wUkThd76xDfotuDw/s/6x8/bOBcfehKSiEf0I2YflQeiDXnWjHP/FO5jlmAogCuczq20
 CRcIl6Jym0MCwCVQJ3lnGrys7oKtFZ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-1o6Qap6_P-WnkHgS9fkIMw-1; Sat,
 20 Jun 2026 08:31:12 -0400
X-MC-Unique: 1o6Qap6_P-WnkHgS9fkIMw-1
X-Mimecast-MFC-AGG-ID: 1o6Qap6_P-WnkHgS9fkIMw_1781958671
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5118C18005A9; Sat, 20 Jun 2026 12:31:11 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A8D5180028B; Sat, 20 Jun 2026 12:31:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 3/4] qga: Move common channel routines to
 channel-common
From: marcandre.lureau@redhat.com
To: Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Denis V . Lunev" <den@virtuozzo.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260619180121.2982356-4-polina.vishneva@virtuozzo.com>
References: <20260619180121.2982356-1-polina.vishneva@virtuozzo.com>
 <20260619180121.2982356-4-polina.vishneva@virtuozzo.com>
Date: Sat, 20 Jun 2026 16:31:03 +0400
Message-Id: <178195866300.3446841.8157198213641714853.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5242;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZRlgbm/QKZGbzovqrlx3M0UDJpZfu7WpNpYxf49JWPI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqNogJZBTnQuXTxAoSPR9nyjo+72kN6ZyuXqtbC
 fJviuUskOGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajaICQAKCRDa6OEJdZac
 5YzcEAC7Js490eQd3AAIZJoXZ8h2T4uB2UKYqPTNZk7MsIdizn8lQ8QBf49Kxu96mJS39dXl6W2
 rGK5qVXKQENdWqOkh8jIjUyqb7pquoCMV8PeYF9z+8HpQtJhuoia3grU3PwKVQnKLtAeXjpJGPm
 ajjWjCnXI1JM6y1w/cwT83x1RoBxdRVdx4SUx0DgWLhTpV9Lokwoje5uNskEJtT86R1cCOM9gHO
 0E7QT39dPZiBoQuSsuCH/2VY/Zu08+cXegb2QzNdKdKj67r37/SqXTfZlpjc6Q9F1Nh0FdHhGPr
 mlgMfytDdPlUcug6ineb50OGVjO3UNcB39+2w2echSxKofSwOrhLTvZTaynnPEIBUDihjz65Mwp
 uBahkQOId/uAfzTTZSF3mVnIbZEC+L7af1h2sxCGgn++rXNNw23rZwMotfOazm5vlq5KgjZrgxO
 NbdgDLKTWsxkBlystH2t43ItGQSlUYvqPDsQ5XHTd5pfYPVAXzCwvbHkx8ZbfCp/WK4VRV6+ZBQ
 K0FMAJgt3d1TZA1dGLzmtH0FHmD3X1rz4Dik7sMP3m0Lv3BMYqPeZCPggqIiZcRCoUIZ0L0/bxc
 sJ+M88D64d7lPt67WqzIG5A3sHwJBb23tGsCNHgDQAQckCrN2oajMDTY8Hcogs7muQW9c1Zd1BD
 fkEyU+VGxVnApUg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Required to use them later in the Windows vsock path.
> 
> ga_channel_common_client_add() now takes ownership of client_ch on
> success only; on failure the caller keeps it and disposes of it via the
> new ga_channel_common_gio_destroy() helper.
> The Windows vsock path needs this: it has to release the CRT fd wrapper
> with qemu_close_socket_osfhandle() before channel teardown closes the
> SOCKET, so the caller must still own the channel on the error path.
> 
> Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> Message-ID: <20260619180121.2982356-4-polina.vishneva@virtuozzo.com>
>
> diff --git a/qga/channel-common.h b/qga/channel-common.h
> new file mode 100644
> index 00000000000..8e82bf09099
> --- /dev/null
> +++ b/qga/channel-common.h
> @@ -0,0 +1,44 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QEMU Guest Agent common GIOChannel lifecycle
> + *
> + * Copyright (c) 2026 Virtuozzo International GmbH.
> + */
> +#ifndef QGA_CHANNEL_COMMON_H
> +#define QGA_CHANNEL_COMMON_H
> +
> +#include "channel.h"
> +
> +typedef struct GAChannelCommon {
> +    GIOChannel *listen_channel;
> +    GIOChannel *client_channel;
> +    GAChannelMethod method;
> +    GAChannelCallback event_cb;
> +    gpointer user_data;
> +} GAChannelCommon;
> +
> +/* Common GIOChannel lifecycle (channel-common.c) */
> +void ga_channel_common_listen_close(GAChannelCommon *c);
> +
> +/* Start listening on a vsock "cid:port" path; returns an fd or -1. */
> +int ga_channel_common_vsock_listen(const char *path, Error **errp);
> +
> +/* Shut down and unref a GIOChannel not tracked by a GAChannelCommon. */
> +void ga_channel_common_gio_destroy(GIOChannel *ch);
> +
> +/*
> + * Takes ownership of client_ch on success only; on failure the caller keeps
> + * it and must dispose of it via ga_channel_common_gio_destroy().
> + */
> +int ga_channel_common_client_add(GAChannelCommon *c,
> +                                 GIOChannel *client_ch,
> +                                 GIOFunc event_fn, gpointer data);
> +void ga_channel_common_client_close(GAChannelCommon *c);
> +GIOStatus ga_channel_common_read(GAChannelCommon *c, gchar *buf,
> +                                 gsize size, gsize *count);
> +GIOStatus ga_channel_common_write_all(GAChannelCommon *c,
> +                                      const gchar *buf, gsize size);
> +void ga_channel_common_free(GAChannelCommon *c);
> +
> +#endif /* QGA_CHANNEL_COMMON_H */
> diff --git a/qga/channel-common.c b/qga/channel-common.c
> new file mode 100644
> index 00000000000..9732a194776
> --- /dev/null
> +++ b/qga/channel-common.c
> @@ -0,0 +1,115 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QEMU Guest Agent common GIOChannel lifecycle
> + *
> + * Copyright (c) 2026 Virtuozzo International GmbH.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/sockets.h"
> +#include "channel-common.h"
> +
> +void ga_channel_common_gio_destroy(GIOChannel *ch)
> +{
> +    g_io_channel_shutdown(ch, true, NULL);
> +    g_io_channel_unref(ch);
> +}
> +
> +/* The vsock analogue of unix_listen(): returns a listening fd or -1. */
> +int ga_channel_common_vsock_listen(const char *path, Error **errp)
> +{
> +    SocketAddress *addr;
> +    char *addr_str;
> +    int fd;
> +
> +    addr_str = g_strdup_printf("vsock:%s", path);
> +    addr = socket_parse(addr_str, errp);
> +    g_free(addr_str);

Could use g_autofree here too

> +    if (!addr) {
> +        return -1;
> +    }
> +
> +    fd = socket_listen(addr, 1, errp);
> +    qapi_free_SocketAddress(addr);
> +    return fd;
> +}
> +
> +void ga_channel_common_listen_close(GAChannelCommon *c)
> +{
> +    g_assert(c->listen_channel);
> +    ga_channel_common_gio_destroy(c->listen_channel);
> +    c->listen_channel = NULL;
> +}
> +
> +int ga_channel_common_client_add(GAChannelCommon *c, GIOChannel *client_ch,
> +                                 GIOFunc event_fn, gpointer data)
> +{
> +    GError *err = NULL;
> +
> +    g_assert(c && !c->client_channel);
> +    g_io_channel_set_encoding(client_ch, NULL, &err);
> +    if (err != NULL) {
> +        g_warning("error setting channel encoding to binary");
> +        g_error_free(err);
> +        return -1;
> +    }
> +    g_io_add_watch(client_ch, G_IO_IN | G_IO_HUP, event_fn, data);
> +    c->client_channel = client_ch;
> +    return 0;
> +}
> +
> +void ga_channel_common_client_close(GAChannelCommon *c)
> +{
> +    g_assert(c->client_channel);
> +    ga_channel_common_gio_destroy(c->client_channel);
> +    c->client_channel = NULL;
> +}
> +
> +GIOStatus ga_channel_common_read(GAChannelCommon *c, gchar *buf,
> +                                 gsize size, gsize *count)
> +{
> +    return g_io_channel_read_chars(c->client_channel, buf, size, count, NULL);
> +}
> +
> +GIOStatus ga_channel_common_write_all(GAChannelCommon *c,
> +                                      const gchar *buf, gsize size)
> +{
> +    GError *err = NULL;

g_error_free() is missing in this function.

Use g_auto?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


