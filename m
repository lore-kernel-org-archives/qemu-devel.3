Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516A9C9830E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 00:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAFsi-0002Sw-GA; Fri, 25 Sep 2026 20:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1xAFsh-0002Sn-EM
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 20:03:07 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1xAFsf-0001bn-J6
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 20:03:06 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3DA4B60136;
 Sat, 26 Sep 2026 00:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0436F1F000FF;
 Sat, 26 Sep 2026 00:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790380976;
 bh=KU4PWy0mBJokvr4s3BV1IMevw+IlOh139vlSdWolPiA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=fCmrxWFPntnmrUrxfSLmlWcnWk8h4nombku6cEZvzQEYHjpCL2QIE6CHyuvtJ29Kn
 fQWoXbTn47/I0b84E/Uo8xNRl4wzTBA6kDwMXXo7fDTJcG2GE3yckWuZ0BO4b8EUNG
 hDbMctFpvPqGL5d56ZOS64wCSmslT9W8SLizVXlC8nIE6J5HHpSnc8frbGSprfMy6O
 nafA3UdsilDyZ9V7T5Yu/BSt9cI+CPuU9UDhZq/4fSn/R4SVGWDqKL4Y+SWuUP3b2T
 kme4+23UZh/aU2N56r5qkzAtZWj4aa++Oer5xKDzdNoKqsw/GqG/NNvNjZ2kLknelD
 TM6dPI4HiF3iw==
Date: Sat, 26 Sep 2026 01:02:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw/pci-bridge: honour CONFIG_CXL in PXB
Message-ID: <20260926010251.4b02f4e0@jic23-hlaptop>
In-Reply-To: <20260922115613.1926083-1-berrange@redhat.com>
References: <20260922115613.1926083-1-berrange@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 22 Sep 2026 12:56:13 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> If CONFIG_CXL=3Dn is added to the Kconfig, the build fails to link
> the PXB device:
>=20
> /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in =
function `pxb_cxl_realize':
> /home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c=
:202:(.text+0x330): undefined reference to `cxl_component_register_block_in=
it'
> /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in =
function `pxb_cxl_dev_reset':
> /home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c=
:309:(.text+0x768): undefined reference to `cxl_component_register_init_com=
mon'
>=20
> Fixes: 6e4e3ae936 (hw/cxl/component: Implement host bridge MMIO (8.2.5, t=
able 142))
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

