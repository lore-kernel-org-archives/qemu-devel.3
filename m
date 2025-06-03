Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A46C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPr3-0003OY-Rj; Tue, 03 Jun 2025 07:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMPr1-0003ON-5e
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMPqy-0005uX-QP
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748950245;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HOiobj3AIKiWkuUoXo62SJwe8dm8/A/y7BXGyUKJ20E=;
 b=XO/NhvZBpk5qOrt2b2BSvBqksH1+rL+hxz/L/dTgKKIXu6O6c1g0kbIHkOKvA/l5FpkzAh
 pYzIiQKlzi2Pfg1yEnRB0uyGglY/8zgNif28g2s54K2O1AFW0xhaOIfxTRGzGixL6D7iQH
 +78NQApUafF+ZWorwje9/1N3szpSzOw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-GuVUiX_5MEO-4Qh9SuDmgA-1; Tue,
 03 Jun 2025 07:30:44 -0400
X-MC-Unique: GuVUiX_5MEO-4Qh9SuDmgA-1
X-Mimecast-MFC-AGG-ID: GuVUiX_5MEO-4Qh9SuDmgA_1748950243
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FB1E195609F; Tue,  3 Jun 2025 11:30:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C306130002C2; Tue,  3 Jun 2025 11:30:40 +0000 (UTC)
Date: Tue, 3 Jun 2025 12:30:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 02/23] ui/vnc: take account of client byte order in pixman
 format
Message-ID: <aD7c3f5Tb_mqgkKq@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
 <20250522102923.309452-3-berrange@redhat.com>
 <e6c7920b-8078-4d97-92ce-2efafb645953@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6c7920b-8078-4d97-92ce-2efafb645953@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 03, 2025 at 01:18:55PM +0200, Thomas Huth wrote:
> On 22/05/2025 12.29, Daniel P. Berrangé wrote:
> > The set_pixel_conversion() method is responsible for determining whether
> > the VNC client pixel format matches the server format, and thus whether
> > we can use the fast path "copy" impl for sending pixels, or must use
> > the generic impl with bit swizzling.
> > 
> > The VNC server format is set at build time to VNC_SERVER_FB_FORMAT,
> > which corresponds to PIXMAN_x8r8g8b8.
> > 
> > The qemu_pixman_get_format() method is then responsible for converting
> > the VNC pixel format into a pixman format.
> > 
> > The VNC client pixel shifts are relative to the associated endianness.
> > 
> > The pixman formats are always relative to the host native endianness.
> > 
> > The qemu_pixman_get_format() method does not take into account the
> > VNC client endianness, and is thus returning a pixman format that is
> > only valid with the host endianness matches that of the VNC client.
> ...
> 
>  Hi Daniel,
> 
> this patch breaks the output in the TigerVNC viewer for me.
> If I run "./qemu-system-x86_64 -vnc :1" on my laptop, and then connect to it
> via "vncviewer :1", the output of the BIOS now appears in yellow letters
> (instead of grey ones).
> 
> FWIW, the output of TigerVNC viewer is:
> 
>  TigerVNC viewer v1.15.0
>  Built on: 2025-04-08 00:00
>  Copyright (C) 1999-2025 TigerVNC team and many others (see README.rst)
>  See https://www.tigervnc.org for information on TigerVNC.
> 
>  Tue Jun  3 13:17:50 2025
>   DecodeManager: Detected 16 CPU core(s)
>   DecodeManager: Creating 4 decoder thread(s)
>   CConn:       Connected to host localhost port 5901
>   CConnection: Server supports RFB protocol version 3.8
>   CConnection: Using RFB protocol version 3.8
>   CConnection: Choosing security type None(1)
>   CConn:       Using pixel format depth 24 (32bpp) little-endian rgb888
> 
> Could you please have a look what's going wrong here?

Yes, I can reproduce too, will check this out.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


