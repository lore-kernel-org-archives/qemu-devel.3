Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1097FF60C8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 05:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Rxo-00018Z-W4; Tue, 31 Mar 2026 01:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w7Rxk-000181-Od
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 01:48:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w7Rxi-0007Lv-Nv
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 01:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774936103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbeSRiKfHuldxV+ZHsw7G/nM9ZQIk0KeRo/GHAABLw4=;
 b=E01wpf3rdTxEO5oLXMtsMKeEEHik0FKj+hyTSI/hHSR4Fbw457nWEurZnF6u6O6U246ok5
 0LCTIAGOTZSJRdcrH54WCwRtGNy15fIOPm+Ui1DFp9QSD+bqb9otGsyNsu94TI/1FUSmGa
 /GXgkTRu0mrcRwli1LadDP1yQKmk9P8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-or1fNVBKNc6UmrV5XvAn3w-1; Tue,
 31 Mar 2026 01:48:19 -0400
X-MC-Unique: or1fNVBKNc6UmrV5XvAn3w-1
X-Mimecast-MFC-AGG-ID: or1fNVBKNc6UmrV5XvAn3w_1774936098
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E21911800345; Tue, 31 Mar 2026 05:48:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.48])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 855871800763; Tue, 31 Mar 2026 05:48:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6A390180060B; Mon, 30 Mar 2026 08:23:57 +0200 (CEST)
Date: Mon, 30 Mar 2026 08:23:57 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: VGA default endianness (was: [PATCH] hw/display/cirrus_vga_isa:
 Disable global_vmstate by default for new machines)
Message-ID: <acoQV5ZyGAw9hggX@sirius.home.kraxel.org>
References: <20260326154850.301609-1-thuth@redhat.com>
 <30981a1a-b895-3829-0f9c-7b22e72bd0fa@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30981a1a-b895-3829-0f9c-7b22e72bd0fa@eik.bme.hu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.54, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, Mar 29, 2026 at 09:07:42PM +0200, BALATON Zoltan wrote:
> On Thu, 26 Mar 2026, Thomas Huth wrote:
> > In the long run, we would like to get rid of the code that allows to
> 
> Not related to this patch but there's another hack in vga that might be good
> to get rid of similarly. At hw/display/vga.c:2263 it says:
> 
>     /*
>      * Set default fb endian based on target, could probably be turned
>      * into a device attribute set by the machine/platform to remove
>      * all target endian dependencies from this file.
>      */
>     s->default_endian_fb = target_big_endian();
>     s->big_endian_fb = s->default_endian_fb;
> 
> I think this does not make much sense as VGA is little endian but since this
> hack is there since forever just changing it may break some guests.

Short history lesson:  Loooong ago vga used to have hard-coded
endianess.  Then vga got support for switching endianness at runtime,
and this was added for backward compatibility.

IIRC the arrival of little endian powerpc support triggered all that,
and I had my share of endian bugs in different places during that time.

Some guest drivers have been fixed since, the linux driver explicitly
sets endianess since years, but ...

> I've tried that changing the default_endian_fb to false at least
> breaks OpenBIOS and its QEMU VGA NDRV for MacOS.

... apparently not all guest drivers.

> So at least those might need some backward compatibility property
> until they are fixed. I don't know what else could it break

Only the colors will break.  Guest writes big-endian data, host
interprets that as little-endian data, and you get a funny looking
screen.

> but maybe it would be a good opportunity to change it with new machine
> types with a property that could also be set by users if something breaks
> just to find out what might need fixing and eventually be able to remove it.

I think it makes sense to try fix the remaining guest drivers first.

take care,
  Gerd


