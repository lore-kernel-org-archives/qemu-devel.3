Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47BFC3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 11:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uERcv-00041S-3r; Mon, 12 May 2025 07:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uERca-00040L-IQ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 07:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uERcY-0006ke-1R
 for qemu-devel@nongnu.org; Mon, 12 May 2025 07:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747050415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sk9SA6FOLmOWNXEg0gnQpypGyrGc8omN6O+2fnQDJqQ=;
 b=Qve9VJPfHoCsv/H/gHfQxnqHLlEyH3cEKTcGc7Nwu8I3kXmQCbwXqarM0DweGAVYS+xzhg
 OmaERt4jySK8YjjAG4P59zXl92MOL8rzSxVI2DD6StpRLHsKV6n3zGDOvMDdFpYL8b8Vzx
 MkzzpjmBr0K65582eDvPyxYGfxlqVmQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-0eSUqwgSOICr7CQAuprqHA-1; Mon,
 12 May 2025 07:46:52 -0400
X-MC-Unique: 0eSUqwgSOICr7CQAuprqHA-1
X-Mimecast-MFC-AGG-ID: 0eSUqwgSOICr7CQAuprqHA_1747050411
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 001C51800263; Mon, 12 May 2025 11:46:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.155])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 884DC18001DA; Mon, 12 May 2025 11:46:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 10125180038A; Mon, 12 May 2025 13:46:48 +0200 (CEST)
Date: Mon, 12 May 2025 13:46:47 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/9] ui/gtk: Document scale and coordinate handling
Message-ID: <hyeijrn3pxl5r5ij2zryiaar5xcqpj7oigpzwgdl3bl5wslddu@fdfgzn27uy52>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <20250511073337.876650-2-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511073337.876650-2-weifeng.liu.z@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, May 11, 2025 at 03:33:11PM +0800, Weifeng Liu wrote:
> The existence of multiple scaling factors forces us to deal with various
> coordinate systems and this would be confusing. It would be beneficial
> to define the concepts clearly and use consistent representation for
> variables in different coordinates.
> 
> Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> ---
>  ui/gtk.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 982037b2c0..9f3171abc5 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -800,6 +800,71 @@ void gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget *widget)
>  #endif
>  }
>  
> +/**
> + * DOC: Coordinate handling.
> + *
> + * We are coping with sizes and positions in various coordinates and the
> + * handling of these coordinates is somewhat confusing. It would benefit us
> + * all if we define these coordinates explicitly and clearly. Besides, it's
> + * also helpful to follow the same naming convention for variables
> + * representing values in different coordinates.
> + *
> + * I. Definitions
> + *
> + * - (guest) buffer coordinate: this is the coordinates that the guest will
> + *   see. The x/y offsets and width/height specified in commands sent by
> + *   guest is basically in buffer coordinate.
> + *
> + * - (host) pixel coordinate: this is the coordinate in pixel level on the
> + *   host destop. A window/widget of width 300 in pixel coordinate means it
> + *   occupies 300 pixels horizontally.
> + *
> + * - (host) logical window coordinate: the existence of global scaling
> + *   factor in desktop level makes this kind of coordinate play a role. It
> + *   always holds that (logical window size) * (global scale factor) =
> + *   (pixel size).
> + *
> + * - global scale factor: this is specified in desktop level and is
> + *   typically invariant during the life cycle of the process. Users with
> + *   high-DPI monitors might set this scale, for example, to 2, in order to
> + *   make the UI look larger.
> + *
> + * - zooming scale: this can be freely controlled by the QEMU user to zoom
> + *   in/out the guest content.
> + *
> + * II. Representation
> + *
> + * We'd like to use consistent representation for variables in different
> + * coordinates:
> + * - buffer coordinate: prefix fb
> + * - pixel coordinate: prefix p
> + * - logical window coordinate: prefix w
> + *
> + * For scales:
> + * - global scale factor: prefix gs
> + * - zooming scale: prefix scale/s
> + *
> + * Example: fbw, pw, ww for width in different coordinates
> + *
> + * III. Equation
> + *
> + * - fbw * gs * scale_x = pw

Well.  That is one possible approach (and this is what qemu is doing
today, for historical reasons, because most code dates back to pre
high-dpi days).

A possible alternative would be to go for fbw * scale_x = pw, i.e. let
the guest run in pixel coordinates instead of window coordinates.  The
guest would do the high-dpi scaling then.  That requires setting
physical display width and height in ui_info, so the guest can figure
what the display resolution is and go into high-dpi mode if needed.

We probably also need a non-high-dpi compatibility mode for old guests.
That mode would start with "zooming scale = global scale" instead of
"zooming scale = 1", and the dpi calculation would have to consider
that too.

(maybe best done on top of this nice cleanup).

take care,
  Gerd


