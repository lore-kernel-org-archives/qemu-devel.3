Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE19ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNr6-0002aa-UD; Sat, 30 Aug 2025 11:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1usBho-0003og-5K
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 22:52:40 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1usBhl-0008En-Nu
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 22:52:39 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 151947A013F;
 Fri, 29 Aug 2025 22:52:34 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
 by phl-compute-06.internal (MEProxy); Fri, 29 Aug 2025 22:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1756522353;
 x=1756608753; bh=EW5ADFusadMyzkyvSlveU4fNtMRwtxTq406ASshOFpM=; b=
 mRtytAaQQO2FcDqVmec7kMRba1IqF18PFtN9aUMe5WRZ1iKKfbAJ00KbBYxpj+AC
 tpPfuNBBH/7MNidvXYx5LLvcOpMKTAO+ozD84BfGwEdtcze2sebGvuykhYBTc/IC
 US2raP2RdiBTy0QMgmt6FuKH2WDw29nTANYSYGjGvFSuMYHavg5lHWO4JoaTwnhf
 WtHgWE54mxNesc7ofAEN6WA4w2Ap+Deznc7IAa/SRrfWKOUqxExSepSgj7fN6Iin
 bg7KvWBPnFQ8m35nHIEeNAZuCl1szq7ssXyCJRKsfuOBjUYlWUuLiK/9Q2XNo+sM
 7cvSua0hCLDavtwvjujVOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756522353; x=
 1756608753; bh=EW5ADFusadMyzkyvSlveU4fNtMRwtxTq406ASshOFpM=; b=O
 UH7qGxWxTPaAPTNDbpC57LWKzV8tlkQ0luOkdRT4ruVctE8jeTzMrhnVkrOxI5rl
 WgAqW8QnkL0TFO4RwphwhpDsDmc//p2mGIfHYDesmS8f4Ojw+16x21hEpNCA0xJ9
 5nYBOVstBnmtQuWzLNjcjVaAKY70D3M4AazA0/hj17/uQFkcSTpihefXNE+OmCa1
 +0Li4ng+7LuOn8WOsn1HRmA+5zZbQVfXp/GNDv7dbyEN3950epWGXQLS6+8pECns
 58szPH0tjzvbPrbS7Y8rgWU5g+NTfwN7M0LkkdUCGt08rmZ1o9aMIgA8t/PXx1i0
 W9v5crw+38CCTx07nX3mg==
X-ME-Sender: <xms:cWeyaFHXxzCVQk_2rDkrdWepNaqcn9SRUYydoyOPXlH1dJMFiC61Mg>
 <xme:cWeyaKWPK1V2J2W2i1pyd3JC_QZVeVMG-0tct0UUA860lvoUw4qsg3YPi5TOwUVKZ
 efU7vpcvQ4nw3pMCtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeehvdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhirgig
 uhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeethefhlefgvdevvdekuefffeek
 heehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghp
 thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhlmhgusehlih
 hnrghrohdrohhrghdprhgtphhtthhopeguvghvvghlsehlihhsthhsrdhlihgsvhhirhht
 rdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprh
 gtphhtthhopehjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgs
 ohhniihinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehthhhuthhhsehrvgguhh
 grthdrtghomh
X-ME-Proxy: <xmx:cWeyaFg62RIwW-eit4qgKVL-uFIBsl7jySkrKTU0HTZhg-pyfjLH6A>
 <xmx:cWeyaKy2frBqI8T8wjFE88Y_ZvN416Q4rG2e-z92ogvqbTmOto-ZsQ>
 <xmx:cWeyaBNu0htC9K11c0OsIvH9p6l15IGhWoiYbACqjZ5apYNtRd7E_g>
 <xmx:cWeyaLVmCukXkxFzroI5fetep0BReGBDGg5zPj4TpkL26wv_gz_Wjg>
 <xmx:cWeyaIxj0gHjkbOd9aj-50runqr9zCaxdjDdNPvyepRI1HZMVFpXGUZr>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 3E63C2CE0078; Fri, 29 Aug 2025 22:52:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AlYk8EVD7EFJ
Date: Sat, 30 Aug 2025 10:52:13 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: devel@lists.libvirt.org, "Paolo Bonzini" <pbonzini@redhat.com>,
 "Thomas Huth" <thuth@redhat.com>, "Jason Wang" <jasowang@redhat.com>
Message-Id: <6ed130fe-7ddc-46ba-aefd-832ef87971ad@app.fastmail.com>
In-Reply-To: <20250828143800.49842-1-philmd@linaro.org>
References: <20250828143800.49842-1-philmd@linaro.org>
Subject: Re: [PATCH 0/2] hw/mips: Remove mipssim machine and mipsnet device
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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



=E5=9C=A82025=E5=B9=B48=E6=9C=8828=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=
=8D=8810:37=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
> mipssim machine (single user of  mipsnet device) is
> deprecated since v10.0; remove for 10.2.
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   hw/mips: Remove mipssim machine
>   hw/net: Remove mipsnet device model

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

I should really give another go for MIPS virt machine :-)

Thanks
Jiaxun

>
>  MAINTAINERS                             |   6 -
>  docs/about/deprecated.rst               |  12 -
>  docs/about/removed-features.rst         |   5 +
>  docs/system/target-mips.rst             |  11 -
>  configs/devices/mips-softmmu/common.mak |   1 -
>  hw/mips/mipssim.c                       | 249 --------------------
>  hw/net/mipsnet.c                        | 297 ------------------------
>  hw/mips/Kconfig                         |   7 -
>  hw/mips/meson.build                     |   1 -
>  hw/net/Kconfig                          |   3 -
>  hw/net/meson.build                      |   1 -
>  hw/net/trace-events                     |   7 -
>  12 files changed, 5 insertions(+), 595 deletions(-)
>  delete mode 100644 hw/mips/mipssim.c
>  delete mode 100644 hw/net/mipsnet.c
>
> --=20
> 2.51.0

--=20
- Jiaxun

