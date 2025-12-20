Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186A5E668A5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 00:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWkUj-00077l-9f; Fri, 19 Dec 2025 19:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vWkUh-00077N-TN
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 19:06:48 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vWkUf-0007U8-Gf
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 19:06:47 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4ACB214000C8;
 Fri, 19 Dec 2025 19:06:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 19 Dec 2025 19:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1766189202;
 x=1766275602; bh=uP2unCIWDU3A7v1w9Vm1SuytIFKF6aoaLTx9wKRYXoQ=; b=
 CCw2mjCSiwG8rLbZSlDPJ47f81xTGqW+OEu/4NmMasTnU1XjzXHWrHkEFFojeTHy
 1M3XXYneLwUNf29DgmdUlZXUmZbtnERxnPiFmNNtw9GNkQCsDAKQyKk1jH814Pua
 5xXxZW9Hujh8GYJPY80b9joslTBL4Fs3D84Br5KxXfyjfu0iK0WhQnIvtu5LeJ4H
 DjL4Wdq0oXBEf9JfisCpXDqbf/pm/Kt9O5vkECOcrQs2sLUuF2J/lgIf9MQG2iQA
 FKM0tVXL2EbiDKBFJ3wxeusVEeWzPb+4w1vihjRgqhoq1+j4cy7kUG9DZfa7XwpV
 x9ShNAXlpD/fVRviPc7Pdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766189202; x=
 1766275602; bh=uP2unCIWDU3A7v1w9Vm1SuytIFKF6aoaLTx9wKRYXoQ=; b=j
 Iv2rUp5wIU0K0+VM4VVVXLK9iGPIege+y4RleSWFheISmM+lKYW/RekV63oBdqqm
 eN8q1jPc+dgAxATYfJHOMKLgxb4vX4vTHZECNWX2Rbjbbu3u8Qr3YAgkSlFoGSmm
 Lebxd94DuxvmoW0gaN9mmc74IRrNTJXx9RCeq2Tk0sRf0l8kI6HcxslVyTqTEKLw
 GC75VFowGPIQ05l9tBLpSypPVhgroQ4eoneUAaCZfog+/L7obFYF9vLMq4seQrJV
 /B3iH3kxpPAeEk5udTE67LG8io7U4ffpw5zSwmJMnoPeOC4H15+03kQ2PJhHMO4l
 eQtlZUlnF+0thEntOPrzQ==
X-ME-Sender: <xms:kehFaRtjDe6JPwtTaNnEft1TjxsWvspsMj_uYWmBxKaPfOWIbkNnMQ>
 <xme:kehFaTbOnS3dYxHgPpaVTyyUDa6-wn0RDl4JX6QN10uxZsuOF8P1j_1QOAXKtXykY
 ub55tlhrY9n_xAOHkqynemeIZsKBSXBU8K23qt6fJAmGMZ2DxI_0Q>
X-ME-Received: <xmr:kehFaQWZdncDqWiLg1J5EszKEu7nOQCMWWawwWG7b-QWQTOVcwAjh8rx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegleejtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfgjfhggtgfgsehtqhertddttdejnecuhfhrohhmpeetlhgvgicuhghi
 lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
 gvrhhnpefgffdvfeejjeeuveefteduhfegteefueehteefkeejvdduvdeuhefftdegjeek
 teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
 gvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtoheprghjrgihghgrrhhgnhhsihhtsehgmhgrihhlrdgtohhmpd
 hrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthho
 pehiohhmmhhusehlihhsthhsrdhlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
 gtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kehFaYTmBslcgXtrXJ_5iKz90G7PXfNT3B4hNv7UKHyMrVcQdsdKPg>
 <xmx:kehFaeMYfg3JWoxGiHO2mElYh9OHiJtMl40n2dUTrzRf13gggCVRHQ>
 <xmx:kehFaWT6PbifTwjvQvjV-LqDh3vjrwaQqWtMq8vGsCAGCXqp-mgfyw>
 <xmx:kehFachD_xOhNKUgbnKflG_3pToE5rEPcE6NKyyg9b_iS9Iux55LYQ>
 <xmx:kuhFadwZ0cWOGA2ugIgENtV1gdBZpbRyKCgWumKmqQ4AIIicaF-xTaNA>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 19:06:41 -0500 (EST)
Date: Fri, 19 Dec 2025 17:06:37 -0700
From: Alex Williamson <alex@shazbot.org>
To: Ajay Garg <ajaygargnsit@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A lingering doubt on PCI-MMIO region of PCI-passthrough-device
Message-ID: <20251219170637.2c161b7b.alex@shazbot.org>
In-Reply-To: <CAHP4M8X=e+dP-T_if5eA=gccdbxkkObYvcrwA3qUBONKWW3W_w@mail.gmail.com>
References: <CAHP4M8Uy7HLiKjnMCdNG+QG+0cizN82c_G87AuzDL6qDCBG5vg@mail.gmail.com>
 <20251215045203.13d96d09.alex@shazbot.org>
 <CAHP4M8WeHz-3VbzKb_54C5UuWW-jtqvE=X37CSssUa5gti41GQ@mail.gmail.com>
 <CAHP4M8X=e+dP-T_if5eA=gccdbxkkObYvcrwA3qUBONKWW3W_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.152; envelope-from=alex@shazbot.org;
 helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 19 Dec 2025 11:53:56 +0530
Ajay Garg <ajaygargnsit@gmail.com> wrote:

> Hi Alex.
> Kindly help if the steps listed in the previous email are correct.
>=20
> (Have added qemu mailing-list too, as it might be a qemu thing too as
> virtual-pci is in picture).
>=20
> On Mon, Dec 15, 2025 at 9:20=E2=80=AFAM Ajay Garg <ajaygargnsit@gmail.com=
> wrote:
> >
> > Thanks Alex.
> >
> > So does something like the following happen :
> >
> > i)
> > During bootup, guest starts pci-enumeration as usual.
> >
> > ii)
> > Upon discovering the "passthrough-device", guest carves the physical
> > MMIO regions (as usual) in the guest's physical-address-space, and
> > starts-to/attempts to program the BARs with the
> > guest-physical-base-addresses carved out.
> >
> > iii)
> > These attempts to program the BARs (lying in the
> > "passthrough-device"'s config-space), are intercepted by the
> > hypervisor instead (causing a VM-exit in the interim).
> >
> > iv)
> > The hypervisor uses the above info to update the EPT, to ensure GPA =3D>
> > HPA conversions go fine when the guest tries to access the PCI-MMIO
> > regions later (once gurst is fully booted up). Also, the hypervisor
> > marks the operation as success (without "really" re-programming the
> > BARs).
> >
> > v)
> > The VM-entry is called, and the guest resumes with the "impression"
> > that the BARs have been "programmed by guest".
> >
> > Is the above sequencing correct at a bird's view level?

It's not far off.  The key is simply that we can create a host virtual
mapping to the device BARs, ie. an mmap.  The guest enumerates emulated
BARs, they're only used for sizing and locating the BARs in the guest
physical address space.  When the guest BAR is programmed and memory
enabled, the address space in QEMU is populated at the BAR indicated
GPA using the mmap backing.  KVM memory slots are used to fill the
mappings in the vCPU.  The same BAR mmap is also used to provide DMA
mapping of the BAR through the IOMMU in the legacy type1 IOMMU backend
case.  Barring a vIOMMU, the IOMMU IOVA space is the guest physical
address space.  Thanks,

Alex

