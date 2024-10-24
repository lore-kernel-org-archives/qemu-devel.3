Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD0CD0BB7A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3u80-0000aw-Pv; Thu, 24 Oct 2024 05:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1t3u7v-0000ag-HM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:27:33 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1t3u7s-0000BI-62
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iy9F29ZncgNGpBMpge/TfQcHTfrCkFTh9+oquJ+L1Lc=; t=1729762048; x=1730366848; 
 b=jeSVytY3ieTD7qSWUabKENUsuTnkKqUo+/66431H7j9ZhO0RkBjYmR9YxWRhN5VoWmflkupIRgr
 IZIpK6z2sJwhfLw6xDJ4hQrHrTqhRNQW8PLEWkZPLDu6th6rMevS+xeVPZ33EP3gJbfsQGkP/aN3z
 0io9Lxo4q/m1v1s0vMQ21mdLp6lAJ0P9OH7XifqFy8Wqox0fTHlashoyQV94VZnZ8/zW6078tIUtG
 mCDp3C+lFbB4cHULsHNe7O57JKwO+wfVR4boCL5UDhCyux39QGx4vsPu5rY5+50neihmvvrGUWjlS
 R+HAoPM2TnEPJEn6xb5F03SFDgaQpvu/OGbg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.98) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1t3u7l-00000003bLN-3Cu8; Thu, 24 Oct 2024 11:27:21 +0200
Received: from p57bd904e.dip0.t-ipconnect.de ([87.189.144.78]
 helo=[192.168.178.20]) by inpost2.zedat.fu-berlin.de (Exim 4.98)
 with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1t3u7l-00000003yo9-2KED; Thu, 24 Oct 2024 11:27:21 +0200
Message-ID: <e208e9b36c0d66d1c689617c46b9659d56ad4bf5.camel@physik.fu-berlin.de>
Subject: Re: Please put qemu-system-sh4eb back.
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas Huth <thuth@redhat.com>
Cc: Rob Landley <rob@landley.net>, qemu-devel@nongnu.org, jeff@coresemi.io, 
 peter.maydell@linaro.org
Date: Thu, 24 Oct 2024 11:27:20 +0200
In-Reply-To: <9f8b2357-a28a-4b80-aa5c-ff1725e364d9@redhat.com>
References: <d6755445-1060-48a8-82b6-2f392c21f9b9@landley.net>
 <9f8b2357-a28a-4b80-aa5c-ff1725e364d9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.144.78
X-ZEDAT-Hint: PO
Received-SPF: pass client-ip=130.133.4.66;
 envelope-from=glaubitz@zedat.fu-berlin.de; helo=outpost1.zedat.fu-berlin.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Thomas,

On Thu, 2024-10-24 at 07:44 +0200, Thomas Huth wrote:
> On 24/10/2024 02.11, Rob Landley wrote:
> > I use it, and ship system images for it:
> >=20
> >  =C2=A0 https://landley.net/bin/mkroot/latest/sh4eb.tgz
>=20
> Oh, that's interesting, I've been told that the r2d machine does not work=
 in=20
> big endian mode:
>=20
>   https://lore.kernel.org/qemu-devel/87a5fwjjew.wl-ysato@users.sourceforg=
e.jp/
>=20
> But yes, your binaries apparently work there, so sorry for the confusion.
> I'll send a patch to revert the removal.

With my SuperH kernel maintainer hat on, let me say thank you for sorting t=
his
out so quickly! Much appreciated.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

