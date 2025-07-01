Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E86C83030
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 01:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWQ5x-0007Ku-Pu; Mon, 30 Jun 2025 21:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uWQ5T-0007I7-UO
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 21:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uWQ5O-0000KD-51
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 21:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751334419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAZKeeKsqaizbOj1t6Jyw1N9SakyCz7ok3LhCcDZCpI=;
 b=QIh1o4RRcm2TYqJESfrMF2OXM+Yv1mCnqh64DgQziSH0ZG9bTDBRoP8DN5lj4EpD+5k9Bu
 xohQn6f7IfiKzMojv6x+FmY1E7q/9CJ+Tk3FHMBnyIvVkOzgkFrIfHtaCphscZ672j77tm
 uGOsdI+huknJSJ5feMaJMa2hbm82UXM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-Pkmpz05MOnarwGH2PNx_Vg-1; Mon, 30 Jun 2025 21:46:53 -0400
X-MC-Unique: Pkmpz05MOnarwGH2PNx_Vg-1
X-Mimecast-MFC-AGG-ID: Pkmpz05MOnarwGH2PNx_Vg_1751334412
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3132c1942a1so4299946a91.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 18:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751334411; x=1751939211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sAZKeeKsqaizbOj1t6Jyw1N9SakyCz7ok3LhCcDZCpI=;
 b=fQFHaPghKTQYZTixjeSTXikboZfpBS1xwprMZvV6czOzGTCi2FlhJ3pMNJYjn0cwi7
 VHxy3lG9q0P42TiYitssjtkULbrqbq709yyTGDExD5YqbqOVgxbrVE81mZGbfdH/RLzf
 mu9AFmsrG4m3FA9RWxaRm7jANV+3/+qWqVG6qtW1/rxE96OH28KsMZCeJrZPoWBjA6BZ
 O1OAkudF+BUYyKvYpEq9N/5u1TauE0J8ZdiF+K2zU4xHN7+35fze5T9gR/TjiwQYVm1A
 IH9zTJQXf1lvCjZpKm7qDi3O92FwyxA+WoR6cLR1whJg2419qqJ1aet62zf+mNY6izgn
 yiKA==
X-Gm-Message-State: AOJu0YwxBKOQbrJXK/Uo+Q+Bq+cmmJGFiZtBTIcM5gss/COY2xgo1v9A
 YYWqBPpW2HKXGQaEMT/zxvtojOQCSmlp/L0DVmLs0cVcMhBScNnc0oLIu2beTKpQ+LWJv4bA+FR
 aoZdvsugJPnb2Zb8xlTBxJD4xpMFPx2Rss1mo9iJ0Pmw/FzI3P9Eb5b/cDMKBYHx5LpKnGcwPJb
 Eb07PUlU3w3viCfUKZ8p8CrWqLQS7EVfU4pll9tGujXg==
X-Gm-Gg: ASbGncu8KMyUZmjCYhqjragTisrGwCEa7oQGqOgriqNsK+e7nlAA4meXB1/pQgoMeO1
 epLAc7D6AyfZDJtW/5L/9o05P93JuUCuNdw7ewxXOd4UTt4KSWt67G1fFPHxppH+w0q4wcgjTjx
 cO
X-Received: by 2002:a17:90b:3e8a:b0:312:eaea:afa1 with SMTP id
 98e67ed59e1d1-318c92f09ecmr22136347a91.29.1751334410631; 
 Mon, 30 Jun 2025 18:46:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU8YkGB3qeioviu6F5SQ3mWT9yTaLzukfJnoq68jDfqW3znwsbCRwpMYGLzW+xJIlRu5DlrnCZr/0v3rVAZrk=
X-Received: by 2002:a17:90b:3e8a:b0:312:eaea:afa1 with SMTP id
 98e67ed59e1d1-318c92f09ecmr22136303a91.29.1751334410093; Mon, 30 Jun 2025
 18:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250618155718.550968-1-lvivier@redhat.com>
 <20250618155718.550968-10-lvivier@redhat.com>
In-Reply-To: <20250618155718.550968-10-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 09:46:38 +0800
X-Gm-Features: Ac12FXypo-Vo8OYKhBPmPJNqglyCqkW5xcJusY0ZBuh9POUcNHuzAdHMjkxvr60
Message-ID: <CACGkMEvcC7jv9LN5bP61E0OgSBENswotm+3fq8NAg3wBC9vUEQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] net: Add passt network backend
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 18, 2025 at 11:58=E2=80=AFPM Laurent Vivier <lvivier@redhat.com=
> wrote:
>
> This commit introduces support for passt as a new network backend.
> passt is an unprivileged, user-mode networking solution that provides
> connectivity for virtual machines by launching an external helper process=
.
>
> The implementation reuses the generic stream data handling logic. It
> launches the passt binary using GSubprocess, passing it a file
> descriptor from a socketpair() for communication. QEMU connects to
> the other end of the socket pair to establish the network data stream.
>
> The PID of the passt daemon is tracked via a temporary file to
> ensure it is terminated when QEMU exits.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hmp-commands.hx   |   3 +
>  meson.build       |   6 +
>  meson_options.txt |   2 +
>  net/clients.h     |   4 +
>  net/hub.c         |   3 +
>  net/meson.build   |   3 +
>  net/net.c         |   4 +
>  net/passt.c       | 434 ++++++++++++++++++++++++++++++++++++++++++++++
>  qapi/net.json     | 124 +++++++++++++
>  qemu-options.hx   |  18 ++
>  10 files changed, 601 insertions(+)
>  create mode 100644 net/passt.c
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 06746f0afc37..d0e4f35a30af 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1287,6 +1287,9 @@ ERST
>          .name       =3D "netdev_add",
>          .args_type  =3D "netdev:O",
>          .params     =3D "[user|tap|socket|stream|dgram|vde|bridge|hubpor=
t|netmap|vhost-user"
> +#ifdef CONFIG_PASST
> +                      "|passt"
> +#endif
>  #ifdef CONFIG_AF_XDP
>                        "|af-xdp"
>  #endif
> diff --git a/meson.build b/meson.build
> index 34729c2a3dd5..485a60a0cb0c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1288,6 +1288,10 @@ if not get_option('slirp').auto() or have_system
>    endif
>  endif
>
> +enable_passt =3D get_option('passt') \
> +  .require(host_os =3D=3D 'linux', error_message: 'passt is supported on=
ly on Linux') \
> +  .allowed()
> +
>  vde =3D not_found
>  if not get_option('vde').auto() or have_system or have_tools
>    vde =3D cc.find_library('vdeplug', has_headers: ['libvdeplug.h'],
> @@ -2541,6 +2545,7 @@ if seccomp.found()
>    config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
>  endif
>  config_host_data.set('CONFIG_PIXMAN', pixman.found())
> +config_host_data.set('CONFIG_PASST', enable_passt)
>  config_host_data.set('CONFIG_SLIRP', slirp.found())
>  config_host_data.set('CONFIG_SNAPPY', snappy.found())
>  config_host_data.set('CONFIG_SOLARIS', host_os =3D=3D 'sunos')
> @@ -4965,6 +4970,7 @@ if host_os =3D=3D 'darwin'
>    summary_info +=3D {'vmnet.framework support': vmnet}
>  endif
>  summary_info +=3D {'AF_XDP support':    libxdp}
> +summary_info +=3D {'passt support':     enable_passt}
>  summary_info +=3D {'slirp support':     slirp}
>  summary_info +=3D {'vde support':       vde}
>  summary_info +=3D {'netmap support':    have_netmap}
> diff --git a/meson_options.txt b/meson_options.txt
> index a442be29958f..3146eec19440 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -234,6 +234,8 @@ option('pixman', type : 'feature', value : 'auto',
>         description: 'pixman support')
>  option('slirp', type: 'feature', value: 'auto',
>         description: 'libslirp user mode network backend support')
> +option('passt', type: 'feature', value: 'auto',
> +       description: 'passt network backend support')
>  option('vde', type : 'feature', value : 'auto',
>         description: 'vde network backend support')
>  option('vmnet', type : 'feature', value : 'auto',
> diff --git a/net/clients.h b/net/clients.h
> index be53794582cf..e786ab420352 100644
> --- a/net/clients.h
> +++ b/net/clients.h
> @@ -29,6 +29,10 @@
>  int net_init_dump(const Netdev *netdev, const char *name,
>                    NetClientState *peer, Error **errp);
>
> +#ifdef CONFIG_PASST
> +int net_init_passt(const Netdev *netdev, const char *name,
> +                   NetClientState *peer, Error **errp);
> +#endif
>  #ifdef CONFIG_SLIRP
>  int net_init_slirp(const Netdev *netdev, const char *name,
>                     NetClientState *peer, Error **errp);
> diff --git a/net/hub.c b/net/hub.c
> index cba20ebd874f..e3b58b1c4f8e 100644
> --- a/net/hub.c
> +++ b/net/hub.c
> @@ -285,6 +285,9 @@ void net_hub_check_clients(void)
>              case NET_CLIENT_DRIVER_NIC:
>                  has_nic =3D 1;
>                  break;
> +#ifdef CONFIG_PASST
> +            case NET_CLIENT_DRIVER_PASST:
> +#endif
>              case NET_CLIENT_DRIVER_USER:
>              case NET_CLIENT_DRIVER_TAP:
>              case NET_CLIENT_DRIVER_SOCKET:
> diff --git a/net/meson.build b/net/meson.build
> index bb3c011e5a30..da6ea635e95d 100644
> --- a/net/meson.build
> +++ b/net/meson.build
> @@ -34,6 +34,9 @@ system_ss.add(when: 'CONFIG_TCG', if_true: files('filte=
r-replay.c'))
>  if have_l2tpv3
>    system_ss.add(files('l2tpv3.c'))
>  endif
> +if enable_passt
> +  system_ss.add(files('passt.c'))
> +endif
>  system_ss.add(when: slirp, if_true: files('slirp.c'))
>  system_ss.add(when: vde, if_true: files('vde.c'))
>  if have_netmap
> diff --git a/net/net.c b/net/net.c
> index ba051441053f..e6789378809c 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1267,6 +1267,9 @@ static int (* const net_client_init_fun[NET_CLIENT_=
DRIVER__MAX])(
>      const char *name,
>      NetClientState *peer, Error **errp) =3D {
>          [NET_CLIENT_DRIVER_NIC]       =3D net_init_nic,
> +#ifdef CONFIG_PASST
> +        [NET_CLIENT_DRIVER_PASST]     =3D net_init_passt,
> +#endif
>  #ifdef CONFIG_SLIRP
>          [NET_CLIENT_DRIVER_USER]      =3D net_init_slirp,
>  #endif
> @@ -1372,6 +1375,7 @@ void show_netdevs(void)
>          "dgram",
>          "hubport",
>          "tap",
> +        "passt",
>  #ifdef CONFIG_SLIRP
>          "user",
>  #endif
> diff --git a/net/passt.c b/net/passt.c
> new file mode 100644
> index 000000000000..ce194b1e02f0
> --- /dev/null
> +++ b/net/passt.c
> @@ -0,0 +1,434 @@
> +/*
> + * passt network backend
> + *
> + * Copyright Red Hat
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include <glib/gstdio.h>
> +#include <gio/gio.h>
> +#include "net/net.h"
> +#include "clients.h"
> +#include "qapi/error.h"
> +#include "io/net-listener.h"
> +#include "stream_data.h"
> +
> +typedef struct NetPasstState {
> +    NetStreamData data;
> +    GPtrArray *args;
> +    gchar *pidfile;
> +    pid_t pid;
> +} NetPasstState;
> +
> +static int net_passt_stream_start(NetPasstState *s, Error **errp);
> +
> +static void net_passt_cleanup(NetClientState *nc)
> +{
> +    NetPasstState *s =3D DO_UPCAST(NetPasstState, data.nc, nc);
> +
> +    kill(s->pid, SIGTERM);
> +    g_remove(s->pidfile);
> +    g_free(s->pidfile);
> +    g_ptr_array_free(s->args, TRUE);
> +}
> +
> +static ssize_t net_passt_receive(NetClientState *nc, const uint8_t *buf,
> +                                  size_t size)
> +{
> +    NetStreamData *d =3D DO_UPCAST(NetStreamData, nc, nc);
> +
> +    return net_stream_data_receive(d, buf, size);
> +}
> +
> +static gboolean net_passt_send(QIOChannel *ioc, GIOCondition condition,
> +                                gpointer data)
> +{
> +    if (net_stream_data_send(ioc, condition, data) =3D=3D G_SOURCE_REMOV=
E) {
> +        NetPasstState *s =3D DO_UPCAST(NetPasstState, data, data);
> +        Error *error;
> +
> +        /* we need to restart passt */
> +        kill(s->pid, SIGTERM);
> +        if (net_passt_stream_start(s, &error) =3D=3D -1) {
> +            error_report_err(error);
> +        }
> +
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    return G_SOURCE_CONTINUE;
> +}
> +
> +static NetClientInfo net_passt_info =3D {
> +    .type =3D NET_CLIENT_DRIVER_PASST,
> +    .size =3D sizeof(NetPasstState),
> +    .receive =3D net_passt_receive,
> +    .cleanup =3D net_passt_cleanup,
> +};
> +
> +static void net_passt_client_connected(QIOTask *task, gpointer opaque)
> +{
> +    NetPasstState *s =3D opaque;
> +
> +    if (net_stream_data_client_connected(task, &s->data) =3D=3D 0) {
> +        qemu_set_info_str(&s->data.nc, "stream,connected to pid %d", s->=
pid);
> +    }
> +}
> +
> +static int net_passt_start_daemon(NetPasstState *s, int sock, Error **er=
rp)
> +{
> +    g_autoptr(GSubprocess) daemon =3D NULL;
> +    g_autofree gchar *contents =3D NULL;
> +    g_autoptr(GError) error =3D NULL;
> +    GSubprocessLauncher *launcher;
> +
> +    qemu_set_info_str(&s->data.nc, "launching passt");
> +
> +    launcher =3D g_subprocess_launcher_new(G_SUBPROCESS_FLAGS_NONE);
> +    g_subprocess_launcher_take_fd(launcher, sock, 3);
> +
> +    daemon =3D  g_subprocess_launcher_spawnv(launcher,
> +                                           (const gchar *const *)s->args=
->pdata,
> +                                           &error);

I wonder if such launching is a must or at least we should allow
accepting fd from the management layer (e.g in the case that execve()
is restricted)?

> +    g_object_unref(launcher);
> +
> +    if (!daemon) {
> +        error_setg(errp, "Error creating daemon: %s", error->message);
> +        return -1;
> +    }
> +
> +    if (!g_subprocess_wait(daemon, NULL, &error)) {
> +        error_setg(errp, "Error waiting for daemon: %s", error->message)=
;
> +        return -1;
> +    }
> +
> +    if (g_subprocess_get_if_exited(daemon) &&
> +        g_subprocess_get_exit_status(daemon)) {
> +        return -1;
> +    }
> +
> +    if (!g_file_get_contents(s->pidfile, &contents, NULL, &error)) {
> +        error_setg(errp, "Cannot read passt pid: %s", error->message);
> +        return -1;
> +    }
> +
> +    s->pid =3D (pid_t)g_ascii_strtoll(contents, NULL, 10);
> +    if (s->pid <=3D 0) {
> +        error_setg(errp, "File '%s' did not contain a valid PID.", s->pi=
dfile);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +

...

> +    if (net_passt_stream_start(s, errp) =3D=3D -1) {
> +        qemu_del_net_client(nc);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> diff --git a/qapi/net.json b/qapi/net.json
> index 97ea1839813b..76d7654414f7 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -112,6 +112,125 @@
>    'data': {
>      'str': 'str' } }
>
> +##
> +# @NetDevPasstOptions:
> +#
> +# Unprivileged user-mode network connectivity using passt
> +#
> +# @path: path to passt binary
> +#
> +# @quiet: don't print informational messages
> +#
> +# @debug: be verbose
> +#
> +# @trace: extra verbose
> +#
> +# @vhost-user: enable vhost-user
> +#
> +# @pcap-file: log traffic to pcap file
> +#
> +# @mtu: assign MTU via DHCP/NDP
> +#
> +# @address: IPv4 or IPv6 address
> +#
> +# @netmask: IPv4 mask
> +#
> +# @mac: source MAC address
> +#
> +# @gateway: IPv4 or IPv6 address as gateway
> +#
> +# @interface: interface for addresses and routes
> +#
> +# @outbound: bind to address as outbound source
> +#
> +# @outbound-if4: bind to outbound interface for IPv4
> +#
> +# @outbound-if6: bind to outbound interface for IPv6
> +#
> +# @dns: IPv4 or IPv6 address as DNS
> +#
> +# @search: search domains
> +#
> +# @fqdn: FQDN to configure client with
> +#
> +# @dhcp-dns: enable/disable DNS list in DHCP/DHCPv6/NDP
> +#
> +# @dhcp-search: enable/disable list in DHCP/DHCPv6/NDP
> +#
> +# @map-host-loopback: addresse to refer to host
> +#
> +# @map-guest-addr: addr to translate to guest's address
> +#
> +# @dns-forward: forward DNS queries sent to
> +#
> +# @dns-host: host nameserver to direct queries to
> +#
> +# @tcp: enable/disable TCP
> +#
> +# @udp: enable/disable UDP
> +#
> +# @icmp: enable/disable ICMP
> +#
> +# @dhcp: enable/disable DHCP
> +#
> +# @ndp: enable/disable NDP
> +#
> +# @dhcpv6: enable/disable DHCPv6
> +#
> +# @ra: enable/disable route advertisements
> +#
> +# @freebind: bind to any address for forwarding
> +#
> +# @ipv4: enable/disable IPv4
> +#
> +# @ipv6: enable/disable IPv6
> +#
> +# @tcp-ports: TCP ports to forward
> +#
> +# @udp-ports: UDP ports to forward
> +#
> +# Since: 10.1
> +##
> +{ 'struct': 'NetDevPasstOptions',
> +  'data': {
> +    '*path':               'str',
> +    '*quiet':              'bool',
> +    '*debug':              'bool',
> +    '*trace':              'bool',
> +    '*vhost-user':         'bool',
> +    '*pcap-file':          'str',
> +    '*mtu':                'int',
> +    '*address':            'str',
> +    '*netmask':            'str',
> +    '*mac':                'str',
> +    '*gateway':            'str',
> +    '*interface':          'str',
> +    '*outbound':           'str',
> +    '*outbound-if4':       'str',
> +    '*outbound-if6':       'str',
> +    '*dns':                'str',
> +    '*search':             ['String'],
> +    '*fqdn':               'str',
> +    '*dhcp-dns':           'bool',
> +    '*dhcp-search':        'bool',
> +    '*map-host-loopback':  'str',
> +    '*map-guest-addr':     'str',
> +    '*dns-forward':        'str',
> +    '*dns-host':           'str',
> +    '*tcp':                'bool',
> +    '*udp':                'bool',
> +    '*icmp':               'bool',
> +    '*dhcp':               'bool',
> +    '*ndp':                'bool',
> +    '*dhcpv6':             'bool',
> +    '*ra':                 'bool',
> +    '*freebind':           'bool',
> +    '*ipv4':               'bool',
> +    '*ipv6':               'bool',
> +    '*tcp-ports':          ['String'],
> +    '*udp-ports':          ['String'] },
> +    'if': 'CONFIG_PASST' }

I would like to know the plan to support migration and its
compatibility for passt.

Thanks


