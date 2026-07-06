Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE32C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 15:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wglT7-0001aN-4u; Mon, 06 Jul 2026 11:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wglT4-0001Zh-LQ; Mon, 06 Jul 2026 11:42:46 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wglT2-0003Pz-Rn; Mon, 06 Jul 2026 11:42:46 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CE80B1400139;
 Mon,  6 Jul 2026 11:42:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 11:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1783352563;
 x=1783438963; bh=d2bMpgtxyXzRsGkt5jHRk4xdPjDxTeSXbPbSUGmLYeE=; b=
 SSeUImQzzdbjeMlwjhqOi0h5/TXOlrTxmqGvgOyqROC14itDgFhbtSCgOdv2ivCY
 cAp7Lsyw+xj2Ulte8dawdXK9AALiKtIJ8XQupin4LIQkhGKPS/10tZYWyNZJOuIg
 f7vwpYYuAnuqaj2vRvWelPa5oTiRw5ZIialeHkQ16m+8OJ5ZhiLGh3I6VGsG4reG
 v/2ThQPS81Flwr5i9G54NnRmxQ/kpfZgBHwDjX36Lg1g1HpPH3mJE8pKHt5iqJ5G
 voo8W/qauaDK4jto6Mv5f9zkx3xWBSsKpe9FAjKJRBuwNby7DZwFuASCU7QyHSUR
 leIysGzYfF9F+Hgs7yW0cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783352563; x=
 1783438963; bh=d2bMpgtxyXzRsGkt5jHRk4xdPjDxTeSXbPbSUGmLYeE=; b=Q
 GI7qjtPmqHp4gbx8lVvl9e1oUGCnqNE+L28bo41Tw+Jn3yWcpbQaWu5hfyBTaJOD
 B+KzLTmkB+/oYE/jtzmF2tDaQyC36kRS0GK04NcV+/bPiYER54qgEef215akBeBn
 06Kg5SQLvwjGd+0a9QcbvOIhWvfWnBMzWx10HeDXIqaKbLNGiDEW8Id+9GNLMTSG
 02b1r+O0jXCE/lFZxLQ/y5nFWSVv7LjiE6FYcLWe5JyBhrBqPuwMsyH0gAQzWaXV
 1zZ/XPe9+Q6qR4jIVISCXpMTUtDLfGryxY3qztVOhg1vfdsQC7i2LRqvTc7Rz4lB
 NRaYjFGe4hTAan9G1BeUQ==
X-ME-Sender: <xms:88xLaj0acTb4msndVw_jcfCZsQDxcb8lYl_4ibtJGLQCsavwj4j02A>
 <xme:88xLakX-xOBZVpC2JPqldqE5Y5N44HwLToI2NUcJkfAm-_gs8zo5tZjEbhKYHxcDv
 I5Lbp5dgwfj91aoKvtUipjsaTlL3OvvUKprJ_5_9_-ZBosV4qcYkw>
X-ME-Received: <xmr:88xLamIdMtloEIv9xFXEZfibQiIP8HVos41QtD57C02NO8-VWxpDpk1rIUU>
X-ME-Proxy-Cause: dmFkZTGW7exPy/qJBiVeOe+xSIkO2oH2qd31DVyugJssjwOqkBcoJG48BJIJlZUdG4iK4G
 nyN+kWubq+zI1vAbPIcr355yjHZ4vanDEpagH599zn/7SR5hXpz3fIbHp+n9Z2Yv8HHody
 SOuSzerGpQg5UFqZuDi60TkmFZzHcyZAYKGB4uT1zXbF8JiWTFIQlpNcKVZp2JPyvZqsQs
 0BAVC3CKFJ4IJO5n12Ce6PJlWZI7BOv6r/rYND9DOK3muDWkIq1x7kaVejg6jDuzEi5tKY
 pOuyKA2WFj0fYC1MLAIb/knA+9daJ2KnHWeRQTfBsDjcqnAUMsH3g/AGTJN2tk+auqRaaf
 qyR0vptv1yfjo8YwM3Oh0cINEHgrmDdpV5zxVMlO70OxCR2JaVigb6rw83TNUaUSKYPMNu
 +WVgYU9kob8py0y+sdEHs0OYFd9yToHO1wiP2fdHej8svAVRHmTagunC2YDVIcjtxlvC9F
 g6qIy7HzSk8+KppuAXKqRPkQ6EymnUSyKuGUwuiPgBtjWgfY3vUK2WVCEmHpATDUZX96XC
 AKeLm2NMLbQDFMYUfyrkIaNMo2XEh6NDFcY/ygxgtI/jaRvfXW/f1QCosldwqMRFwuEmL2
 U7D3fcNBIH6FVfXK+ctv1BlQW8zByRLJlrOAOUdbsoi8TV0oYL/cvoayLaLQ
X-ME-Proxy: <xmx:88xLau38wyGyQblueNW48bEK6Z15CHXVW8YR0G8yAes08NFUxtq_Rg>
 <xmx:88xLak5z4G3TMjuTaNH8v8WCJSKmjt9Hmu78Nk7kkkcJORqyDgp78A>
 <xmx:88xLav-LXrKwbnGHA9HGQwp6okXGPp0G2iTwvCWu-f9do8jU8D5sbQ>
 <xmx:88xLajUR94j8cjvGcdN-Aog07ujXWm1w4BHhEFULn3Mylg3S-UmBEg>
 <xmx:88xLagaprHktYNbPAsj1kXHCdMjFtPRWWXXnNbEtD2GVSTndQejlS4PU>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 11:42:42 -0400 (EDT)
Date: Mon, 6 Jul 2026 09:42:41 -0600
From: Alex Williamson <alex@shazbot.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eric Auger
 <eric.auger@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 alex@shazbot.org
Subject: Re: [PATCH] vfio/listener: Only warn on misalignment for VFIO-owned
 regions
Message-ID: <20260706094241.1457bbc6@shazbot.org>
In-Reply-To: <CAFEAcA9wOZhn41Twz9zzCBD4MAET2+gbF71kUKnr7r6TXfhjuw@mail.gmail.com>
References: <20260702160640.3875666-1-clg@redhat.com>
 <20260706082023.7ee830b8@shazbot.org>
 <3f799ad7-08a5-44c7-b6bf-b143da038593@redhat.com>
 <CAFEAcA9wOZhn41Twz9zzCBD4MAET2+gbF71kUKnr7r6TXfhjuw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.154; envelope-from=alex@shazbot.org;
 helo=fhigh-a3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, 6 Jul 2026 16:27:46 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 6 Jul 2026 at 16:12, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> >
> > On 7/6/26 16:20, Alex Williamson wrote: =20
> > > On Thu,  2 Jul 2026 18:06:40 +0200
> > > C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> > > =20
> > >> Any device on the board can have non-page-aligned memory regions. The
> > >> VFIO listener should not warn about misalignment for regions that are
> > >> not VFIO-related.
> > >>
> > >> Replace the vfio_known_safe_misalignment() whitelist with a
> > >> vfio_get_vfio_device() ownership check: only warn when a VFIO device=
's
> > >> own region is misaligned. For all other regions, emit a trace event
> > >> and silently skip. Extract the misalignment test into a
> > >> vfio_section_misaligned() helper for readability.
> > >>
> > >> Note: vfio_get_vfio_device() currently only covers VFIO PCI devices,
> > >> including vfio-user-pci.  Other VFIO backends (AP, CCW) don't expose
> > >> memory regions through this path so this is sufficient for now. =20
> > >
> > > I thought the whole point was to warn when there are non-vfio devices
> > > that we cannot insert into the DMA map.  851d6d1a0ff2 added tpm-crb-c=
md
> > > to an ignore list because it's not a DMA target.  The intention of th=
at
> > > ignore list was to continue to evaluate devices that are misaligned
> > > and either add them to the ignore list or determine they could be a
> > > valid DMA target and correct the alignment. =20
> >
> > If the goal was to use the VFIO listener to catch all misaligned region=
s,
> > and potentially fix them, we should reconsider that approach :
> >
> >    https://lore.kernel.org/qemu-devel/20260701080843.2418461-1-clg@redh=
at.com/
> >
> > As Peter pointed out, regions that are not page-aligned regions are val=
id :
> >
> >    https://lore.kernel.org/qemu-devel/CAFEAcA-QHJ=3DHaBc5WSLLap8NdDw+tt=
y4EFfGt6cmmNOK6e_m7w@mail.gmail.com/
> >
> > and aligning them would require a machine compat for migration. =20
>=20
> It seems very unlikely that anything not page-aligned is going
> to be a sensible target for DMA ops from a device: the main
> reason to have a non-page-aligned or non-page-sized region is that
> it's the way we've chosen to implement a device, or it's some
> "RAM but not general-purpose RAM" thing. If there's a path to
> warn/error if it's actually used for a DMA op that would be worthwhile,

But for a vfio-pci device there is no DMA op, it either gets mapped
into the IOMMU for direct access to the device or not.  This is the
point at which that decision is made.

> but as it stands I think all this warning will ever cause us to
> do is add more entries to its whitelist every time it complains.

IMO, that's ok.  That's the purpose.  We're up to one whole class of
device so far, we don't care about mapping failures to TPM devices.  If
some day this does fire on something we care about, especially a
regression, it'll earn its keep.  It doesn't seem like an excessive
burden yet. Thanks,

Alex

