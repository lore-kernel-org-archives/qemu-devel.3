Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF17C3600C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 11:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txOtW-0005ae-7h; Wed, 26 Mar 2025 07:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1txOtU-0005a2-Sh
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:26:00 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1txOtR-0006EY-Cy
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:25:59 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-47688ae873fso68091601cf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742988356; x=1743593156; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BnvpWylyh4DisXpHunBIyns2XIaKGBFJDebBH3f1y0I=;
 b=ApeaLzshcoMXpNjDmrVzsMela3+mbN6DXvajYTOs0aesspGekAWYwoK6nFjykOW4jc
 RJPgJQ0Ty8GghyP9OK8w4XCXg6Gw1uqXxrO1AmC0N82wuzJep58YJk82Rvm4zJ+N2O4Z
 hLTHrdz833uwCgUjUV2tX/SqOhHnjr4bRGUngBeLV+jmEuWlb8RcxVlx9E6MSmDmlWZG
 ruM0K1/nPsm1oAOJcE5vQge+KRpWXCP0pVeW7KMRbf9Ma58f4ZnCycnEo/Z7A5CLU0ZR
 R7hfsDHty18WNlkzILOFXI3y0DYYQ3lUt3HAmPET8rQNBRn+B/Dos8Sx6jDrckVoVtNs
 lDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742988356; x=1743593156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BnvpWylyh4DisXpHunBIyns2XIaKGBFJDebBH3f1y0I=;
 b=BahOBCrV/fYdQj3uvTa4XiIUXkQtQ7209b+n+WOOc8DgLb4qcCWrRjawn7sZu2eK3c
 f6zLFCkpqFPQzHJpQ1HtapVTjWXVNqqTMUIEsp2izypO6zInJpzkpBRw3G/f8J/Jt328
 0RqwMtOHYVjclOVOyciham8XOLq2FK/uOTHA6kSUUh6oDgvlXEdsO8dU3MAkSdcu/boN
 1OQH1kR/lqKikRfjmhmogch0NIMlOAxKl2NgjL576zBIJvm2dgvTHuDrf4BMGxlQYtTA
 HzelrhbLPlX6/Ca10ISwfb5MbdQg7T88ZHpsR/L+czl6OO6yoK7DDOvVQHejwak+WI8D
 6pQA==
X-Gm-Message-State: AOJu0YwcN3Gu28SQfoq6c7xbX6NiNF+nL4MCN80ssQz+0l4aTJIMrtj+
 mWmd/rn4nXIFAnY586SBlJAWS/pWPfT43gWnMnMhy3pqsBHRz5bVwTBsZ2Rl4MbTDLz1asVL+NO
 KDWIsUIMsz7W32P12CRz/z6hyqxifrTlT
X-Gm-Gg: ASbGncuNWIgtvkfMkIDKc8BcvJTfgAP3+FApKevLRus49NkJyvcxbyEyw5igIq85n0B
 OsHd0K9L/YU0iR/QhKgTjFvArc4n1vkoJQhuidRbXCsQGHP/N7LSbqvPclPgKGKKBL+8g1tT9FD
 0eb+dmJXW18jfchcbmdYWKP+XxQtiAbdtkVNdLKSHMPn7JPxJVBfdMGlNit7s=
X-Google-Smtp-Source: AGHT+IEpR22vzyITsJPP3HHHUdjR0lBZpORR1OCDmDeDRn66IKPeFkwvi8LvAvDuOvgMQJKFkKIhh7eKBf2eC3Zt4dM=
X-Received: by 2002:a05:622a:22aa:b0:476:7f5c:e304 with SMTP id
 d75a77b69052e-4771dd7038dmr311237171cf.19.1742988355734; Wed, 26 Mar 2025
 04:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250326093418.397269-1-yuq825@gmail.com>
 <20250326093418.397269-6-yuq825@gmail.com>
In-Reply-To: <20250326093418.397269-6-yuq825@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 26 Mar 2025 15:25:42 +0400
X-Gm-Features: AQ5f1JoX_oK-7oN1xXQHmB8WWEp1pihhvYtXH2g6DtJVFyja326nmHLpFecVjF0
Message-ID: <CAJ+F1CJ_Xc8mbMGKTZYUJT=irpAWG32AU3nhFhNzB6amDt_xGA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] ui/dbus: change dbus ScanoutDMABUF interface
To: yuq825@gmail.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Wed, Mar 26, 2025 at 1:34=E2=80=AFPM <yuq825@gmail.com> wrote:
>
> From: Qiang Yu <yuq825@gmail.com>
>
> To handle multi plane.
>
> v2:
>   * use new dmabuf API and check length
>
> Signed-off-by: Qiang Yu <yuq825@gmail.com>
> ---
>  ui/dbus-display1.xml |  37 +++++++++++++++
>  ui/dbus-listener.c   | 108 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 138 insertions(+), 7 deletions(-)
>
> diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
> index 72deefa455..c1d1a402b7 100644
> --- a/ui/dbus-display1.xml
> +++ b/ui/dbus-display1.xml
> @@ -614,6 +614,43 @@
>      </method>
>    </interface>
>
> +  <!--
> +      org.qemu.Display1.Listener.Unix.MultiPlane:
> +
> +      This optional client-side interface can complement
> +      org.qemu.Display1.Listener on ``/org/qemu/Display1/Listener`` for
> +      Unix-specific multi plane DMABUF scanout setup.
> +  -->
> +  <?if $(env.HOST_OS) !=3D windows?>
> +  <interface name=3D"org.qemu.Display1.Listener.Unix.MultiPlane">

As it may be used with single plane, it is essentially ScanoutDMABUF2,
I think we should use that name rather than MultiPlane.

> +    <!--
> +        ScanoutDMABUF2:
> +        @dmabuf: DMABUF file descriptor of each plane.
> +        @width: display width, in pixels.
> +        @height: display height, in pixels.
> +        @offset: offset of each plane, in bytes.
> +        @stride: stride of each plane, in bytes.
> +        @num_planes: plane number.
> +        @fourcc: DMABUF fourcc.
> +        @modifier: DMABUF modifier.
> +        @y0_top: whether Y position 0 is the top or not.

Let's use this opportunity adding a few fields that went missing in
V1: x, y, backing_width, backing_height.

lgtm otherwise

> +
> +        Resize and update the display content with DMABUF.
> +    -->
> +    <method name=3D"ScanoutDMABUF2">
> +      <arg type=3D"ah" name=3D"dmabuf" direction=3D"in"/>
> +      <arg type=3D"u" name=3D"width" direction=3D"in"/>
> +      <arg type=3D"u" name=3D"height" direction=3D"in"/>
> +      <arg type=3D"au" name=3D"offset" direction=3D"in"/>
> +      <arg type=3D"au" name=3D"stride" direction=3D"in"/>
> +      <arg type=3D"u" name=3D"num_planes" direction=3D"in"/>
> +      <arg type=3D"u" name=3D"fourcc" direction=3D"in"/>
> +      <arg type=3D"t" name=3D"modifier" direction=3D"in"/>
> +      <arg type=3D"b" name=3D"y0_top" direction=3D"in"/>
> +    </method>
> +  </interface>
> +  <?endif?>
> +
>    <!--
>        org.qemu.Display1.Clipboard:
>
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 90147972cd..a225890084 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -85,6 +85,7 @@ struct _DBusDisplayListener {
>  #endif
>  #else /* !WIN32 */
>      QemuDBusDisplay1ListenerUnixMap *map_proxy;
> +    QemuDBusDisplay1ListenerUnixMultiPlane *multi_plane_proxy;
>  #endif
>
>      guint dbus_filter;
> @@ -288,10 +289,9 @@ static void dbus_call_update_gl(DisplayChangeListene=
r *dcl,
>  }
>
>  #ifdef CONFIG_GBM
> -static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
> -                                QemuDmaBuf *dmabuf)
> +static void dbus_scanout_dmabuf_single_plane(DBusDisplayListener *ddl,
> +                                             QemuDmaBuf *dmabuf)
>  {
> -    DBusDisplayListener *ddl =3D container_of(dcl, DBusDisplayListener, =
dcl);
>      g_autoptr(GError) err =3D NULL;
>      g_autoptr(GUnixFDList) fd_list =3D NULL;
>      int fd;
> @@ -322,6 +322,81 @@ static void dbus_scanout_dmabuf(DisplayChangeListene=
r *dcl,
>          y0_top, G_DBUS_CALL_FLAGS_NONE,
>          -1, fd_list, NULL, NULL, NULL);
>  }
> +
> +static void dbus_scanout_dmabuf_multi_plane(DBusDisplayListener *ddl,
> +                                            QemuDmaBuf *dmabuf)
> +{
> +    g_autoptr(GError) err =3D NULL;
> +    g_autoptr(GUnixFDList) fd_list =3D NULL;
> +    int i, fd_index[DMABUF_MAX_PLANES], num_fds;
> +    uint32_t width, height, fourcc;
> +    GVariant *fd, *offset, *stride, *fd_handles[DMABUF_MAX_PLANES];
> +    uint64_t modifier;
> +    bool y0_top;
> +    int nfds, noffsets, nstrides;
> +    const int *fds =3D qemu_dmabuf_get_fds(dmabuf, &nfds);
> +    const uint32_t *offsets =3D qemu_dmabuf_get_offsets(dmabuf, &noffset=
s);
> +    const uint32_t *strides =3D qemu_dmabuf_get_strides(dmabuf, &nstride=
s);
> +    uint32_t num_planes =3D qemu_dmabuf_get_num_planes(dmabuf);
> +
> +    assert(nfds >=3D num_planes);
> +    assert(noffsets >=3D num_planes);
> +    assert(nstrides >=3D num_planes);
> +
> +    fd_list =3D g_unix_fd_list_new();
> +
> +    for (num_fds =3D 0; num_fds < num_planes; num_fds++) {
> +        int plane_fd =3D fds[num_fds];
> +
> +        if (plane_fd < 0)
> +            break;
> +
> +        fd_index[num_fds] =3D g_unix_fd_list_append(fd_list, plane_fd, &=
err);
> +        if (fd_index[num_fds] < 0) {
> +            error_report("Failed to setup dmabuf fdlist: %s", err->messa=
ge);
> +            return;
> +        }
> +    }
> +
> +    ddl_discard_display_messages(ddl);
> +
> +    width =3D qemu_dmabuf_get_width(dmabuf);
> +    height =3D qemu_dmabuf_get_height(dmabuf);
> +    fourcc =3D qemu_dmabuf_get_fourcc(dmabuf);
> +    modifier =3D qemu_dmabuf_get_modifier(dmabuf);
> +    y0_top =3D qemu_dmabuf_get_y0_top(dmabuf);
> +
> +    offset =3D g_variant_new_fixed_array(G_VARIANT_TYPE_UINT32,
> +                                       offsets, num_planes, sizeof(uint3=
2_t));
> +    stride =3D g_variant_new_fixed_array(G_VARIANT_TYPE_UINT32,
> +                                       strides, num_planes, sizeof(uint3=
2_t));
> +
> +    for (i =3D 0; i < num_fds; i++) {
> +        fd_handles[i] =3D g_variant_new_handle(fd_index[i]);
> +    }
> +    fd =3D g_variant_new_array(G_VARIANT_TYPE_HANDLE, fd_handles, num_fd=
s);
> +
> +    qemu_dbus_display1_listener_unix_multi_plane_call_scanout_dmabuf2(
> +        ddl->multi_plane_proxy, fd, width, height, offset, stride, num_p=
lanes,
> +        fourcc, modifier, y0_top, G_DBUS_CALL_FLAGS_NONE,
> +        -1, fd_list, NULL, NULL, NULL);
> +}
> +
> +static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
> +                                QemuDmaBuf *dmabuf)
> +{
> +    DBusDisplayListener *ddl =3D container_of(dcl, DBusDisplayListener, =
dcl);
> +
> +    if (ddl->multi_plane_proxy) {
> +        dbus_scanout_dmabuf_multi_plane(ddl, dmabuf);
> +    } else {
> +        if (qemu_dmabuf_get_num_planes(dmabuf) > 1) {
> +            g_debug("org.qemu.Display1.Listener.ScanoutDMABUF does not s=
upport mutli plane");
> +            return;
> +        }
> +        dbus_scanout_dmabuf_single_plane(ddl, dmabuf);
> +    }
> +}
>  #endif /* GBM */
>  #endif /* OPENGL */
>
> @@ -514,10 +589,6 @@ static void dbus_scanout_texture(DisplayChangeListen=
er *dcl,
>          error_report("%s: failed to export dmabuf for texture", __func__=
);
>          return;
>      }
> -    if (num_planes > 1) {
> -        error_report("%s: does not support multi-plane dmabuf", __func__=
);
> -        return;
> -    }
>      dmabuf =3D qemu_dmabuf_new(w, h, offset, stride, x, y, backing_width=
,
>                               backing_height, fourcc, modifier, fd, num_p=
lanes,
>                               false, backing_y_0_top);
> @@ -886,6 +957,8 @@ dbus_display_listener_dispose(GObject *object)
>  #ifdef CONFIG_OPENGL
>      egl_fb_destroy(&ddl->fb);
>  #endif
> +#else /* !WIN32 */
> +    g_clear_object(&ddl->multi_plane_proxy);
>  #endif
>
>      G_OBJECT_CLASS(dbus_display_listener_parent_class)->dispose(object);
> @@ -1074,6 +1147,26 @@ dbus_display_listener_setup_shared_map(DBusDisplay=
Listener *ddl)
>  #endif
>  }
>
> +static void dbus_display_listener_setup_multi_plane(DBusDisplayListener =
*ddl)
> +{
> +#ifndef WIN32
> +    g_autoptr(GError) err =3D NULL;
> +
> +    if (!dbus_display_listener_implements(
> +            ddl, "org.qemu.Display1.Listener.Unix.MultiPlane")) {
> +        return;
> +    }
> +    ddl->multi_plane_proxy =3D
> +        qemu_dbus_display1_listener_unix_multi_plane_proxy_new_sync(
> +            ddl->conn, G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START, NULL,
> +            "/org/qemu/Display1/Listener", NULL, &err);
> +    if (!ddl->multi_plane_proxy) {
> +        g_debug("Failed to setup Unix multi plane proxy: %s", err->messa=
ge);
> +        return;
> +    }
> +#endif
> +}
> +
>  static GDBusMessage *
>  dbus_filter(GDBusConnection *connection,
>              GDBusMessage    *message,
> @@ -1162,6 +1255,7 @@ dbus_display_listener_new(const char *bus_name,
>      dbus_display_listener_setup_shared_map(ddl);
>      trace_dbus_can_share_map(ddl->can_share_map);
>      dbus_display_listener_setup_d3d11(ddl);
> +    dbus_display_listener_setup_multi_plane(ddl);
>
>      con =3D qemu_console_lookup_by_index(dbus_display_console_get_index(=
console));
>      assert(con);
> --
> 2.43.0
>


--=20
Marc-Andr=C3=A9 Lureau

