Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F391606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aO2lxI4s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJs3D-0005Az-Jr; Thu, 22 Oct 2026 08:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJs3B-00059j-Uz
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJs39-00057A-QK
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792672658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Clbe/o4w+2nY/rY2BSMIyOSsbKW9maM/xywyd5qyJAg=;
 b=aO2lxI4sodne28/ZTtHb8DJAmWiTcWs8Jv5dmcIH9DF/zYSMsj+5vcj4aiJvtzMgp0V+Kd
 1pmZnLQhFtEQhGa6WBduC6COBHKC/WVydt9y7H4u5+rKKtER32ASvqbNY8sELhT42sVuCf
 enARms0X4EFwVh10gTXy2+akqmS0VLk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-8fH3BGUNPfaPxve3o7qrYA-1; Thu,
 22 Oct 2026 12:37:31 +0000
X-MC-Unique: 8fH3BGUNPfaPxve3o7qrYA-1
X-Mimecast-MFC-AGG-ID: 8fH3BGUNPfaPxve3o7qrYA_1792672650
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F3E118002AD; Thu, 22 Oct 2026 12:37:30 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7110C195608C; Thu, 22 Oct 2026 12:37:28 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] ui/dbus: send a Scanout before the first Update of
 a new surface
From: marcandre.lureau@redhat.com
To: Christian Quante <christian@quante.one>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
In-Reply-To: <20261022053535.38791-2-christian@quante.one>
References: <20261022053535.38791-1-christian@quante.one>
 <20261022053535.38791-2-christian@quante.one>
Date: Thu, 22 Oct 2026 16:37:19 +0400
Message-Id: <179267263902.3250908.2995842987435876699.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2835;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hd9ls+rUNceDPwK+jFdmgHTtTiASOkk66CSmaEzg2CY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2gOCR/W7iP1STsr5jFC0BnQ0FfUi7f51TlWVQ
 lO5pt8SeL6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatoDggAKCRDa6OEJdZac
 5UiuD/0bfrV3Irg/C5nJ9/XHe/ckaz66se4sIqWSlRaE3E07c2j/I7giZV77s2wDPyqVL/eu9J4
 MHLvulmS+LCn4Jm8Kg1xhY1EXs5l+zEAudYd2l1W+bvv1QhX2KtcBMChqMNJqcBAveqw5Dlx59p
 ov4/lFKk33cUVzyY6dkbYF1njhSMLPFFpeaSkgUPaJ768CwjfzJDcHuo0pNk38jLGz+DzhuMLmf
 JAXX9AezCsR6bfRc2dJBmGM3D+Kx3Gg52E9XtMbOCacrTnCq4/77SOrttIj9bT0UZF0EzPOZcyD
 rL/fDouQhMeio2/SKc69eiQ+i/5mGs0qkHXPkIpJ0YfeUTmCxnLwT6w7b9Jh/EtDqYary/yQp6Q
 3ULfIJd/G+mBM6oSZfYxFxdppQOFbZM6Bmlu8XUbMVzNUfvJmQKW7V7Te8pvFqBdlPqBrXMKG9C
 znDLrtBZ9ncdUCyMhBd9NZOvcnT9L0PSnwdr5Z8c/kkTbPXn2czDFdgHmYfq432e1bhD9yFLvq6
 HF4kg4mclpzGpcKjbSNG/BAOqUlxWTrhn7plLASmrBvlqBNsnqDeycd1ZsiIi66f4lkJMMK3t6P
 5MYPjba2Dt2TPnRRl8BXm0VlKyywzc0pBJ3ZjssETZC5hwzKxddZKvjY+MqQokSm0gi3Wxb7FK/
 njMlscCiVY+q0RQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Without OpenGL and without shared memory, the D-Bus listener sends a
> Scanout only for an update that covers the whole surface, and
> dbus_gfx_switch() only records the new surface. So when a device draws
> a new surface in parts, the client gets Updates for a size that no
> Scanout has given it. VGA text mode is such a device: vga_draw_text()
> sends one update per row of characters, so a text mode that changes its
> size does not send a Scanout. According to ui/dbus-display1.xml, Update
> is only called after a Scanout call, and Scanout is the call that
> resizes the display.
> 
> The client can learn the new size only from the Width and Height
> properties of the Console. They come on a different connection, and
> the generated skeleton sends PropertiesChanged from an idle callback,
> after the redraw. A client that sets up a new buffer when this signal
> comes loses the rows that came before it. VGA text mode does not send
> them again: it redraws only the characters that change, and all of
> them only after changes such as a new font or palette, or with blinking
> enabled.
> 
> The Windows NT 4.0 setup shows this. With blinking off, it changes the
> character height from 16 to 12 lines (720x400 to 720x396), and in a
> D-Bus client large parts of its blue background stayed black.
> 
> With shared memory, dbus_scanout_map() already sends ScanoutMap with the
> new size at the first update after a surface switch. Do the same without
> shared memory: the first update after a switch sends a Scanout of the
> whole surface.
> 
> Signed-off-by: Christian Quante <christian@quante.one>
> Message-ID: <20261022053535.38791-2-christian@quante.one>
> ---
>  ui/dbus-listener.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 624d0fb71d6b..d25132fe7e0a 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -71,6 +71,8 @@ struct _DBusDisplayListener {
>      DisplayChangeListener dcl;
>      DisplaySurface *ds;
>      enum share_kind ds_share;
> +    /* true until a Scanout of ds has been sent */
> +    bool ds_scanout_pending;
>  
>      bool ds_mapped;
>      bool can_share_map;
> @@ -844,6 +846,7 @@ static void ddl_scanout(DBusDisplayListener *ddl)
>          ddl->proxy, surface_width(ddl->ds), surface_height(ddl->ds),
>          surface_stride(ddl->ds), surface_format(ddl->ds), v_data,
>          G_DBUS_CALL_FLAGS_NONE, DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
> +    ddl->ds_scanout_pending = false;

Have you considered clearing the flag in dbus_scanout_map() when ScanoutMap is
sent? (add ScanoutMap in the comment on the field)

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


