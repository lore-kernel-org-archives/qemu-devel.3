Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542DBC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 14:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOI0n-0005iZ-GM; Mon, 01 Jul 2024 10:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sOI0l-0005iM-9G
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:28:07 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sOI0i-0003DX-2a
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:28:07 -0400
To: Gerd Hoffmann <kraxel@redhat.com>
CC: Igor Mammedov <imammedo@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Topic: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Index: AQHay8LaAvswndvg80eMKvHK2hQHrg==
Date: Mon, 1 Jul 2024 14:27:50 +0000
Message-ID: <bdf1a67fa18249cb9947adba8732323f@baidu.com>
References: <20240625035224.13019-1-gaoshiyuan@baidu.com>
 <20240627154548.74a969c2@imammedo.users.ipa.redhat.com>
 <6d033738d79d4b9a83fe216679f8e587@baidu.com>
 <20240701104000.52df4854@imammedo.users.ipa.redhat.com>
 <02403c2f69574128a1700d8b3db37381@baidu.com>,
 <b7fmdp5joww5plrwr3hfedv4zfoicxrzbtynaoui452y4zrtq2@hi236cyermam>
In-Reply-To: <b7fmdp5joww5plrwr3hfedv4zfoicxrzbtynaoui452y4zrtq2@hi236cyermam>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.127.85.136]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.56
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> > > > If I want to use ACPI PCI hotplug in the pxb bridge, what else need=
 to be done?
> > >
> > > does it have to be hotplug directly into pxb or
> > > would be it be sufficient to have hotplug support
> > > on pci-bridge attached to a pxb?
> >
> > It's sufficient to hotplug support on pci-bridge attached to a pxb.
>
> ... but I guess using this instead would be better anyway?

https://lore.kernel.org/all/20220422135101.65796823@redhat.com/t/#r831d589f=
243c24334a09995620b74408847a87a0

According this message, It seems that the current QEMU does not support it =
yet.=20
I tried to hotplug on pci-bridge attached to a pxb, no device found in the =
guest.


>
> take care,
> =A0 Gerd=

