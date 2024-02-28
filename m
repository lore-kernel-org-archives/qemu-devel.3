Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D6BC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfInS-0006cx-Nq; Wed, 28 Feb 2024 07:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rfIlk-0004wZ-7v
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:10:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rfIli-0005tx-51
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709122236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrE6NOi6ri+E6IZDLBU5wT9YSqv7l5WQSw67sMbsP8I=;
 b=Ur1lBu5yWFqmDGwNxlEfCD58I0TK1FHSyGEY1JtvQZbQXvN+RrovCpSf4utNg0pc0U/M4Q
 VRU5WSUAghHWbtAEc9TDrsourcmn1BMbAhIE7DbFFPPTkOhs3nz5ngjo1rXVeNMoG3smTa
 iVR+pdoOE6gXvEAl4fJ8MikBuuRd8Ys=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-tli3d0oVOP-2HvIzcKj-1g-1; Wed, 28 Feb 2024 07:10:35 -0500
X-MC-Unique: tli3d0oVOP-2HvIzcKj-1g-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d2cab09c27so4978351fa.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:10:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709122233; x=1709727033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrE6NOi6ri+E6IZDLBU5wT9YSqv7l5WQSw67sMbsP8I=;
 b=FVJNwHnhMNPvRhVTPaXSFbfNMS0U5wRjfxT1zmw4XaadvFIVrBPbwyNkp9m8sRBH+/
 cifz4cMvH6c4NJFVJu6Lgx01IktfoDGBZh8/wNw4XmUt7h8DCBBxRbW337jil5jDRKMW
 4EzCHFTA02IDRMUCkoQVhGR5w36t8BQbCzEzbliD1LqNDEP/qdh2JV3ymcNU1ySgOgdo
 OuF67SATBmwcclZ6v0viYBMH2U4qX3jyHjYzdoDCX/XvCtK+L8zvHznOAf5E8MLlBQYu
 yMS/g6T/6pjjFqZFmEittHrcYNLmQp/IUbKPBt++C+b5QgBYi1J78Sp0E4kz1c+G4WIY
 OV9A==
X-Gm-Message-State: AOJu0Yw710T5vCCsq5tHJ6K5CYaeFolnxmWZaAD/Ufu/ZUCYK3ExyjG6
 SgkCJNXcN0fT7vn4Y2KZ1lICzrwBV/94KogPrkuVLcKeT5V++G9PmEhhAHkbH8mGbxyCYPhERV4
 a8OxC+/4A/Xcix0fDjyuMwqVLarSc82SoD4lR1CgtmPci05Mxb8STCfWDButGoZomGzHwBqklxD
 o+txl4g1L8fAPLH8/NFTySEMfn3YB79Dd9LuU=
X-Received: by 2002:a05:6512:114c:b0:512:e506:1c66 with SMTP id
 m12-20020a056512114c00b00512e5061c66mr10198949lfg.26.1709122233199; 
 Wed, 28 Feb 2024 04:10:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsD8OBbnPtknIBpDvtL/xFyMJbViB26xXZ+8wDLUhs9VmgggfLixj78ugPXGRVoikVpDmw9sWYF57ZS3UCzq0=
X-Received: by 2002:a05:6512:114c:b0:512:e506:1c66 with SMTP id
 m12-20020a056512114c00b00512e5061c66mr10198929lfg.26.1709122232815; Wed, 28
 Feb 2024 04:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20240224015123.1575580-1-satyeshwar.singh@intel.com>
In-Reply-To: <20240224015123.1575580-1-satyeshwar.singh@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Feb 2024 16:10:21 +0400
Message-ID: <CAMxuvaysAxuchZAc-R+fAXfjtCOnKZhPDZbWHSEzgA-s5f5EkA@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: Fix HW cursor visibility
To: Satyeshwar Singh <satyeshwar.singh@intel.com>
Cc: qemu-devel@nongnu.org, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Feb 24, 2024 at 4:49=E2=80=AFAM Satyeshwar Singh
<satyeshwar.singh@intel.com> wrote:
>
> When show-cursor is on, most of the time Windows VM draws the cursor by
> itself and hands it over to Qemu as a separate resource. However,
> sometimes, Windows OS gives control of the cursor to applications like
> Notepad. In such cases a software cursor which is part of the overall
> framebuffer is drawn by the application. Windows intimates the indirect
> display driver (IDD) about this change through a flag and IDD is in turn
> responsible for communicating with the hypervisor (Qemu) to hide the HW
> cursor. This show/hide cursor can happen any time dynamically.
>
> Unfortunately, it seems like Qemu doesn't expect this change to happen
> dynamically. The code in virtio-gpu.c was written such that
> update_cursor would first call dpy_cursor_define if the cursor shape has
> changed and this is not a simple move operation (which indeed is the
> case when moving to a SW cursor) and then call dpy_mouse_set.
> dpy_cursor_define calls toolkits like GTK but in addition to creating
> the cursor content, it also calls gdk_window_set_cursor thereby setting
> the cursor. It is therefore, the right function to either show or hide
> the cursor but there was no code present to hide the cursor. Changing
> the cursor visibility in dpy_mouse_set has two issues. First,
> dpy_cursor_define already decided to display the cursor so showing the
> cursor in the previous call only to hide it in dpy_mouse_set doesn't
> sound right. Second, dpy_mouse_set skips the rest of the code if we
> are in absolute mode so adding this code there wouldn't work in that
> mode.
>
> Qemu makes the decision of whether to show or hide the cursor by
> observing the cursor->resource_id flag in virtio-gpu.c as is evident
> from the lines
>         dpy_mouse_set(s->con, cursor->pos.x, cursor->pos.y,
>                   cursor->resource_id ? 1 : 0);
> The last parameter is considered the "visible" parameter in gdk code.
> Therefore, in this patch we continue with the same model. Instead of
> changing the function prototype and changing a dozen plus files, we are
> adding the visible field in QEMUCursor data structure and passing
> it from virtio-gpu to the GTK code where we check if the cursor is

You will need to review all usages of QEMUCursor and set visible =3D
true by default.

Whether it's better or not than modifying a dozen files with a new
"visible" argument, I can't say.

Also we should have consistent behaviour across all display backends,
not just GTK.

> visible or not. If not, we simply call gdk_window_set_cursor with NULL

You should use GtkDisplayState.null_cursor, there is an option to
still show the cursor, even when the guest makes it invisible.
(show-cursor=3Don)

Which guest software do you test with?

Both gtk and firefox with cursor none test will actually set a
"transparent" cursor, which we don't detect. Maybe we should also have
some check for this case to implement that "show-cursor" behaviour in
that case too.

> parameter, thereby hiding the cursor. Once Windows VM switches back to
> the HW cursor, then IDD would again provide a new resource_id to Qemu
> and we can start displaying it once more.
>
> Signed-off-by: Satyeshwar Singh <satyeshwar.singh@intel.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  hw/display/virtio-gpu.c | 1 +
>  include/ui/console.h    | 1 +
>  ui/gtk.c                | 5 +++++
>  3 files changed, 7 insertions(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 1c1ee230b3..1ae9be605b 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -98,6 +98,7 @@ static void update_cursor(VirtIOGPU *g, struct virtio_g=
pu_update_cursor *cursor)
>
>          s->current_cursor->hot_x =3D cursor->hot_x;
>          s->current_cursor->hot_y =3D cursor->hot_y;
> +        s->current_cursor->visible =3D cursor->resource_id ? 1 : 0;
>
>          if (cursor->resource_id > 0) {
>              vgc->update_cursor_data(g, s, cursor->resource_id);
> diff --git a/include/ui/console.h b/include/ui/console.h
> index a4a49ffc64..47c39ed405 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -161,6 +161,7 @@ typedef struct QEMUCursor {
>      uint16_t            width, height;
>      int                 hot_x, hot_y;
>      int                 refcount;
> +    int                 visible;
>      uint32_t            data[];
>  } QEMUCursor;
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 810d7fc796..12a76de570 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -478,6 +478,11 @@ static void gd_cursor_define(DisplayChangeListener *=
dcl,
>          return;
>      }
>
> +    if(!c->visible) {
> +        gdk_window_set_cursor(gtk_widget_get_window(vc->gfx.drawing_area=
), NULL);
> +        return;
> +    }
> +
>      pixbuf =3D gdk_pixbuf_new_from_data((guchar *)(c->data),
>                                        GDK_COLORSPACE_RGB, true, 8,
>                                        c->width, c->height, c->width * 4,
> --
> 2.33.1
>


