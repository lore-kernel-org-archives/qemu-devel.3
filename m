Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51906C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97qp-0000k0-HA; Tue, 22 Sep 2026 17:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x97qO-0000ir-4z
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:16:04 -0400
Received: from mail-yx2-x23.google.com ([2607:f8b0:4864:41::23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x97qM-0005uY-1E
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:16:03 -0400
Received: by mail-yx2-x23.google.com with SMTP id
 00721157ae682-8659af7454eso6560897b3.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 14:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1790111760; x=1790716560;
 darn=nongnu.org; 
 h=mime-version:content-transfer-encoding:content-type:msip_labels
 :content-language:accept-language:message-id:date:thread-index
 :thread-topic:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Izb6ajyCAxxRPznDz8TX/SIbVBRUXaJB+AKUwqQALDA=;
 b=Qqn9lbdhi1lcK6ME8fcv9bvmkp6OKWlXI7VE9HW+eCQE1BFF9jm5DGmKquTAsHqGGu
 bKAIVN2f0zWWWmWOQm/fjfSEo42ZnCdRyBzNGhwQYJZeB2ksaxViASkcNU+JMR7PYT1O
 LwTnFY+F6iwCmD+EyQovfWlu62o7XG1j5jrIB1y4ekvDa8aA67fo+Mia4FraBmfaKaUC
 8vH3THWuoYyuRyJBFQE2X8PlO4cTAGRyawoAhJzVIh+EktDHgO7i4Fh5Pp3No1x+KN0L
 3GBx9ksGOX32gUy4tc2Xkt62yVyfap47mBknb3VdqQpEYCI1eD+H8eJJUPdzCobaylzZ
 xuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790111760; x=1790716560;
 h=mime-version:content-transfer-encoding:content-type:msip_labels
 :content-language:accept-language:message-id:date:thread-index
 :thread-topic:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Izb6ajyCAxxRPznDz8TX/SIbVBRUXaJB+AKUwqQALDA=;
 b=Fgt6MyzwDMKfqklRh/VpXHsAlKL4wVcwsPcBQwQ8w/ezxUNULF8gQ87Jx81t09Rby7
 1NiZyGmpWhp0tFTZGVB5za7LJ4bvTLj0FZuzcfNfHBjBfF/h7RAzV7cNW2wMnJCyyDm3
 Y5Nuxr17eOigD1c02OEJ55j9LOWZ4LsyBJ04LFjryFgqVoi7ZIRtxsHIGYCpSi2BXdLa
 uLfx1PZGiWra5YSaB8ZkY3JcuJGEdXaoHchIvlq/i/wPsMJk8Aru9kAEqAZPLbuaQsOO
 Zx+5qxg5S8vuiz1yZnQP/9j+SWMsBUOIGgLL2KZJqkN+fd2eLg/kJjQCWyF1rT87ohq8
 zP4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoDD7ZHaFY435YCuYMpkjKnC4Id+kF5BPj3QeVedivPHwVRndZiqZIkBUYla1itHR5Y2JpDMExSMkm@nongnu.org
X-Gm-Message-State: AFuF++n6yh6EsafuIcMGo3H/hqf85vrc5X2Bvw4u5rmlcmWofeVoz0Ft
 1cop4lwBXFD2mhoo2CpQGisiaWPtq7B4T2H9E9s9ZwxEqAIql4aH8jpxJqE/jVdxX10=
X-Gm-Gg: AYBFou3Ngq+472ZdS/Yp1heNpCQJx6f6jYmdKZ8/JkdA+cagr6RdZKlVO2YJAyRvm3j
 3BZmUuaKp8zFDoyKfYX/m+9493Baeyq4Ufi36Th+0ZHurG0TtdM8No9hKMrFBJnz/nRUGnhERFA
 UF7y8OWMFtzG2gnhx8gTTWofWEH/L3Df0twN3Ct/GPX5e3+rErcj6n8XZ2jcHnhKWaX5WDGm3QU
 sgky6DMh7UHxxJRSzRdPLja1wUh9qC5xJdlKrolShAjNjIVUDR+DGhi52If1GV0SdHUH/ytXClH
 wYCjOYyR+FpTLcsYL06fZA6F9Q7awoM4nro+WIvb1/dEyu3hui06uRPMFYQgRQDwXzv9OR7NATn
 uRVOHAnapdBx76YBIdYwS+eookJL6Hj40hMTS75XWpP53Nlh3s+ICNNUa9V6D3aVgvqBoNZl/rD
 yXLlXTPYsB5jfGWpvvoisSLQiRxe+j5jHOmV5vKDByFXlu6bDaAB8C5ZXLVvt1rvyqGznAjvv2o
 vA0LCGAfM8UpHDik0ErvHEPthmiEMKMPp4knUrjnKhILGZYTtCM0oPKkT9lN2COgdOzPrhFIqcF
 E+FN/yJDsqg=
X-Received: by 2002:a05:690c:3:b0:873:5c0f:27f with SMTP id
 00721157ae682-8a45afa9680mr5530977b3.41.1790111760306; 
 Tue, 22 Sep 2026 14:16:00 -0700 (PDT)
Received: from DB9PR08MB11896.eurprd08.prod.outlook.com
 ([2603:1026:c02:415e::5]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a4664e5e20sm2508487b3.38.2026.09.22.14.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 14:15:59 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>
CC: "weqaar.janjua@packetfive.com" <weqaar.janjua@packetfive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/2] pci: Add device ID for CnuasNIC RDMA network adapter
Thread-Topic: [PATCH 1/2] pci: Add device ID for CnuasNIC RDMA network adapter
Thread-Index: AQHdStWgU4ECwM5PSUaDas0zGm76GA==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 22 Sep 2026 21:15:57 +0000
Message-ID: <DB9PR08MB11896EAA7213A5ED71B028BD4F2832@DB9PR08MB11896.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: none client-ip=2607:f8b0:4864:41::23;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-yx2-x23.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, GB_FAKE_RF_SHORT=1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi Gerd,=0A=
=0A=
On Fri, 18 Sep 2026 at 15:42:30 +0200, Gerd Hoffmann wrote:=0A=
> On Thu, Sep 17, 2026 at 06:08:28PM +0000, Weqaar Janjua wrote:=0A=
> > PCI device ID under QEMU vendor ID 0x1b36, device ID 0x0015=0A=
> > =0A=
> > Request is for the CnuasNIC non-virtio QEMU device model of the Cnuas p=
roject.=0A=
> > =0A=
> > CnuasNIC (QEMU device name: cnuas-vnic) is a software-emulated RDMA NIC=
 =0A=
> > supporting RoCEv2 and native InfiniBand, with guest Linux network and R=
DMA =0A=
> > drivers and a standard verbs provider.=0A=
> > =0A=
> > Datasheet: https://cnuas.io/cnuas/docs/datasheets/CnuasNIC_Datasheet/=
=0A=
> > =0A=
> > The allocation is requested in preparation for public release and upstr=
eam =0A=
> > submission.=0A=
> =0A=
> Ok.  Update to documentation and header file looks good.=0A=
> =0A=
> Ideally this update should be submitted together with the upstream=0A=
> submission of the device emulation code.  Sending it beforehand (to=0A=
> avoid the IDs changing while the code is under review) is possible=0A=
> too, but please include a link to the repository with the code then.=0A=
=0A=
Thank you for the review. I will prepare a revised series v2 that submits t=
he =0A=
PCI ID allocations together with the corresponding CnuasNIC and CnuasGPU =
=0A=
device model patches. The complete code will be included in the patch =0A=
series rather than provided through a public repository link. My understand=
ing =0A=
earlier was that PCI IDs need to be assigned before submitting core patch w=
ork.=0A=
=0A=
> > Cnuas is an experimental rack-scale AI/HPC emulation platform for funct=
ional =0A=
> > experimentation in academic and industrial research and development. It=
s =0A=
> > architecture and device interfaces are described in the public arXiv pr=
eprint =0A=
> > paper:=0A=
> > =0A=
> > Cnuas: A Software-Defined AI/HPC Rack-scale Emulation Platform and Hype=
rscale =0A=
> > Data Center Facility Twin=0A=
> > https://doi.org/10.48550/arXiv.2609.15889=0A=
> > =0A=
> > Website: https://cnuas.io=0A=
> =0A=
> This is the device added by patch 2/2, right?  So this should go only to=
=0A=
> the other commit message.=0A=
=0A=
Yes, that is correct. I will keep the device-specific background in the =0A=
corresponding commits.=0A=
=0A=
Regards,=0A=
=0A=
Weqaar Janjua=0A=
Packet Five Networks Ltd.=0A=
Dublin, Ireland=0A=
https://www.packetfive.com=

