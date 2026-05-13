Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6BECD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNAD8-0006vr-08; Wed, 13 May 2026 10:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wNAD2-0006ur-3L
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:05:12 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wNACx-0003Dy-I6
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1778681101; x=1779285901; i=deller@gmx.de;
 bh=k/NgdOgAeFtdU6Ae2zxy3Klk5Q284H5DI7l163yuFfw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ouetjHrlfG+42CN30MugRCAQSnktGICs67Ey2kjXyFe7MemmiKaF7gYPHS4vOX2C
 JASzctdLYpg11efQT4x4cIseUvtuY6oZWS2UV192MYuLeMaiC0spGBGbK/irEUmUl
 YvVrovf1OAz644q1DQeBM4Bi22kI9fUXzmiVMv9Gaj2F2zxsmmHZBofqwMMqFGPyV
 VRxheQqZJfFXrHzaPQUPHKSjb+yKE71o2gHTmod25mUk8F0R3eMCqDEaQ9oUgook7
 fwq33J8yiwTmXJDSkx5t0M8iPFEeqTz2IrIf7FRCb3aWMZ3T9ooN8WPvPEwz+y7e+
 K8mqVANq52FZ+TSzAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1xTLrZ1jx2-0136P6; Wed, 13
 May 2026 16:05:01 +0200
Message-ID: <2538f422-a48e-45ad-91af-a2e395393109@gmx.de>
Date: Wed, 13 May 2026 16:04:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Limit USB 1.0 (UHCI/OCHI) and 2.0 (EHCI) to non-virt use cases
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org
References: <agRC56rkfb4z6zSO@redhat.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <agRC56rkfb4z6zSO@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vj1JYRuHpw5AY+UcpsRjLjgyyf1ZWqUy1R+HdUk3XG4Rbso8swX
 Nl+wahL1zAZhBFgtlvaHXbKMJ+YZZsaCU/OGobMrCr7Diloqx/qUlxk70kR1+4nHNEGQAI4
 CLy6cDAXJ9EZ7ikgpLWtZbP2UR+ZSAaIzBOvdKAlnRwntYaTv48H8eis3hvzBeRdpqYsZpz
 iMNRYNlM8fSO8WtYGlFCA==
UI-OutboundReport: notjunk:1;M01:P0:I5alZMuicrI=;l9a85gvoveQX6Ugl0cIQD0ze3r/
 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
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/13/26 11:22, Daniel P. Berrang=C3=A9 wrote:
> QEMU has implemented four generic USB controllers
>=20
>   * UHCI - USB 1.0 only
>   * OHCI - USB 1.0 only
>   * EHCI - USB 2.0 only (must have UHCI companions for 1.0 compat)
>   * XHCI - All of USB 3.0, 2.0, 1.0 in one controller
>=20
> We have two variants of XHCI, the generic one (hcd-xhci.c) and the
> NEC one (hcd-xhci-nec.c)
>=20
> Historically for security reports we have considered all of them in
> scope of virtualization, since initially with KVM the XHCI impl was
> not present in QEMU & thus KVM guests used UHCI/EHCI with USB tablet
> for a period of time
>=20
> All of the USB subsystem is currently orphaned, so we have no dedicated
> maintainer available to deal with bug reports (volunteers welcome to
> step up here...)
>=20
>=20
> While the need for USB is reduced given the availability of virtio-input=
,
> not all guests have drivers out of the box, so at least USB tablet is
> still interesting for KVM use cases with some modern OS.
>=20
> It is also not that unusual for people to need USB host device assignmen=
t
> with KVM virt to make various pieces of specialized hardware (security
> tokens, smart cards, custom dongles, etc) available directly to guests.
>=20
> IOW, we can't entirely exclude USB from virtualization use cases IMHO.
>=20
>=20
> In terms of virtualization, XHCI is the only impl that is sensible to
> use. UHCI/OHCI/EHCI all impose an unreasonable CPU load on any guest
> usage of USB.  XHCI should be supported by any guest OS  approx the
> last 15 years, which should be sufficient for virtualization use cases
> with OS that are not EOL by their vendor.
>=20
>=20
> Thus to reduce our maint burden around security bug handling, it is
> proposed henceforth to classify UHCI, OHCI and EHCI under the non-
> virtualization use case and thus be excluded from security bug triage
> processes. No CVEs would be assigned, bugs would be reported publically
> in gitlab:
>=20
>    https://www.qemu.org/docs/master/system/security.html#non-virtualizat=
ion-use-case
>=20
>=20
> The XHCI controller (specifically the hcd-xhci.c variant) would remain
> as our only option for the virtualization use case, with security proces=
s
> applied to bugs & eligible for CVE assignment:
>=20
>    https://www.qemu.org/docs/master/system/security.html#virtualization-=
use-case
>=20
>=20
> The other NEC XHCI variant (hcd-xhci-nec.c) would also be treated as
> non-virtualization use case, since it needlessly duplicates hcd-xhci.c
> impl and thus is only interesting for emulation of this specific HW
> variant.
>=20
>=20
> NB, there are no functional limitations / restrictions from this policy,
> it is largely just a semantic exercise. From a management application
> POV, however, it would strongly suggest that guests be configured with
> XHCI as the default choice if the user asks for USB, and in turn also
> imply that '-usb' not be used since that is UHCI/OHCI typically. CC'ing
> libvirt, though it is really a matter for virt-install/virt-manager/
> openstack/kubevirt etc above libvirt to pick their defaults for USB
> controllers.

I support this proposal.
It keeps the "commercial side" of qemu ("KVM") more secure by defining
which drivers (XHCI) are fully supported and should ideally be used,
while still allowing to use the other USB drivers for the IMHO less-used a=
nd
less-critical use cases (e.g. foreign hardware emulation).

Helge

