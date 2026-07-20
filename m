Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276E4C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wloZl-00072F-W4; Mon, 20 Jul 2026 10:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wloYv-0006MS-0Z
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:01:41 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wloYr-00073l-TE
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Slqwz6vN/i+bdBmCGkz4GOr7yRQlX4L+f4I63sxrlXU=; b=bjWEjWfslJ63FaeoNcjT18Mdv8
 PlGgTTdG/6Dk68guA8JHzJZjSpvRfla85fqmpdfeJJZ4pXCn1cLXZxWv9YzQggn/yuHnRLZ84tqpY
 sfrLmjS1RN+kBlpttIl83spFZylwdrIJWAeGLrFqJQZPomlaHLkVu7kFedyUOEKbboeTQ8CSwcv9R
 TYLq17RmiqhmXYLq7OJlTeC2t8tW1xGGqgb580hYisOmmCNJp3iGEaoAOegMeS9cTl+cHxJ5iiqPi
 OKOepFbt5/e/gFwz3uu+XvUxv0XjlIUxHjxJ7rd2RTEyzd4ulVSqcnoFTxNQs/bONUivCxlBFShJb
 bjN5xA/hHIELtxVJ/f8Z2Bs2uXfyOUyzUb2myPfyh9rHP4oeHw1FId1LMDY9DvPOU49RpCWiwA4YF
 ZbfuSvDSzjiLZs4ViL7NXt/ElSDhH5+ebiLREHs+VPQrrwW9i7vkQO4T46bqruc2o/DT/l3Sr1VmR
 ME9s2pyzYddHKW8lCjrSn2RiII0q4RYNA/ngXVJ31QSzzo9grKGYcPG0EGf7M1imD2bFMyLTmMBgZ
 IHAbnDEPamufGlS1bMlYJBpi6tu6x5lAXlJI5XF9WyY9Ei1csRUcFdJWVXJsAqXiElm4tS+q1elTk
 joJgoeuXXFnZasY2HbMhVlCzgJAZC8nLb/ClVe1Fw=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Daniel =?UTF-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Jia Jia <physicalmtea@gmail.com>
Subject: Re: [PATCH 2/3] hw/9pfs/virtio: disable hotpluggable property of
 virtio-9p device
Date: Mon, 20 Jul 2026 16:01:33 +0200
Message-ID: <23179315.EfDdHjke4D@weasel>
In-Reply-To: <20260720132337.0110bd9e@imammedo>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <alo5LiqOfOVx0Yxu@redhat.com> <20260720132337.0110bd9e@imammedo>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Monday, 20 July 2026 13:23:37 CEST Igor Mammedov wrote:
> On Fri, 17 Jul 2026 15:16:14 +0100
>=20
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > On Fri, Jul 17, 2026 at 04:05:42PM +0200, Christian Schoenebeck wrote:
> > > On Monday, 13 July 2026 09:49:35 CEST Igor Mammedov wrote:
[...]
> > > > the patch would break unplug flow by effectively removing 'eject' k=
nob
> > > > from guest side, which is part of unplug flow.
> > >=20
> > > These are two different things: device_del would not be affected by
> > > this.
> > >=20
> > > 1. Ejecting the device from host side e.g. via QMP would still work.
> > >=20
> > > vs.
> > >=20
> > > 2. Ejecting from guest side OTOH would be disabled.
> > >=20
> > > It is also different from regular block devices where you have
> > > convenient ways to eject a block device on guest OSes. For a virtio-9p
> > > device it is not that easy.
> >=20
> > Igor can correct me if I'm wrong, but IIUC there's no distinction
> > to those 2 scenarios from the guest POV.
> >=20
> > A "device_del" in QMP does not actually delete a device from the
> > QEMU POV.  Rather it triggers an ACPI notification to the geust
> > OS, that the operator wants to unplug the device.  The guest OS
> > then honours (or not) that by initiating a guest side "eject".
> > IOW disabling guest initiated eject would break device_del too
> > AFAIK.
>=20
> That's how it works.
> Sorry if I wasn't able to convey the message in my previous replies.

OK, I just realized I was wrong. The QMP device_del path also checks for
dc->hotpluggable early via qdev_hotplug_unplug_allowed_common() and would=20
already abort there. And I can also see the flow that it just triggers ACPI=
=20
and guest eventually completing device eject.
=20
So yes, it would disable both guest *and* host side eject.

I already dropped this patch from v2 anyway.

Thanks!

/Christian




