Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E251DCF6499
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFTX-0004fq-4L; Mon, 30 Sep 2024 08:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1svFTS-0004dD-Rc
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:25:59 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1svFTR-0002oh-9e
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:25:58 -0400
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 51E6D1140274;
 Mon, 30 Sep 2024 08:25:55 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Mon, 30 Sep 2024 08:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1727699155;
 x=1727785555; bh=f0lN5pzDjiFequXmm31wymRy4w8b/ncSFdC2RcpaelI=; b=
 jBtHz1LbxMvB+86XWsajGEtI02fEuQnlyANKPAJita0fJ1pe2c0Fbb+CsoqTU0Sn
 tgRzKZ1L/am4F66WISAHKD45YspAVAew0Q0blyjExHjju78qBmjc0NmVbUoTLxtE
 TKZJ5S359r9UEvH5+EmROwWS2NY0Hg2RANRmkpCVdmTxrD+11lUwNIA7c14nSjtc
 M/XHyDnXstII5bapO/AxaHaigS5KEtEdx980Cx1dNHqYm+po+HDmoKCW+2dhANI6
 xcFBycE754+qVD7M4AMWIyS65RaQxxInPCiEiFTu4lCadL9sCblhhhazSPNCdScL
 0LVW6U1ppAovC6XQINQVIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727699155; x=
 1727785555; bh=f0lN5pzDjiFequXmm31wymRy4w8b/ncSFdC2RcpaelI=; b=j
 pG8oIZW9VMLG/o2k5VUvhUrPLINA9AgnQ+DuMk38ySNn3gErSoW7/2tY1O0IqCjP
 nu1I79hpRFneDKHqh8xdQNI4T3Tuxm9c+Kcv8tXj5oTLKSZMp0sfjE1SBBQF+LRV
 ubw4CkpOL0GLyZkm58BNdLHIZXQiYyay0QV0PocgqolroLyREiaZl88JQmE/s26z
 lyUF6oAQ44GvgH83jEtWlavhvjT5GtJrPTwlLFXHhzs0sJdZXhyBxKTxDKBW4g36
 VqpTTpVDZGUu/7vN9qaKuoLofCgekSEYInGJHc8UhwBi9TzesnbzR5W1rThI8tjG
 7MchS9jQWwTJMHShZVPJQ==
X-ME-Sender: <xms:0pj6ZqbXcSuxGUtwx76YLzW3tfXKjKnIs4McEgZs-_mbKuFinz0znw>
 <xme:0pj6ZtYRNtAhw0gc3Zo4pCTMI56VAqR82jpfOsRJktpRywjnCvmJ6srTdQ54Gcwyd
 dTIyLzmjt4FOCGwD3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
 hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
 thdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htoheprghurhgvlhhivghnsegruhhrvghlfedvrdhnvghtpdhrtghpthhtoheprghrihhk
 rghlohesghhmrghilhdrtghomhdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrh
 hnvghlrdhorhhgpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgt
 phhtthhopehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrghdprh
 gtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohep
 hhhpohhushhsihhnsehrvggrtghtohhsrdhorhhgpdhrtghpthhtohepthhhuhhthhesrh
 gvughhrghtrdgtohhmpdhrtghpthhtoheprghnjhhosehrvghvrdhngh
X-ME-Proxy: <xmx:0pj6Zk80tDcrvjVgTpDCvofWqk6Asx800dX356Oz1T5_qADbhd34Gw>
 <xmx:0pj6ZsqrcJ5pMig265R1gK7l6QqSBkxWi2_wqKk2kVx3E8uv2p3a6g>
 <xmx:0pj6ZlplzHYklT7KbrDGOAq5-en6VpQEfWnPDhNBcZe1ind8xwNXQQ>
 <xmx:0pj6ZqSf9DOBwI1dNwLxjVqR2-4tOiKohkhPxn0u3KfYjvcKMGmWZg>
 <xmx:05j6ZpfOpBj643Sk_m79ZyH9ht5PflIsiY7zO2GMPhPnROBaq9GKowy->
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 305181C20066; Mon, 30 Sep 2024 08:25:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 30 Sep 2024 13:25:32 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Thomas Huth" <thuth@redhat.com>, "Aurelien Jarno" <aurelien@aurel32.net>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Aleksandar Rikalo" <arikalo@gmail.com>,
 "Huacai Chen" <chenhuacai@kernel.org>, "Anton Johansson" <anjo@rev.ng>
Message-Id: <c16d4f58-d170-4cbe-a6a0-739e33554a63@app.fastmail.com>
In-Reply-To: <20240930091101.40591-1-philmd@linaro.org>
References: <20240930091101.40591-1-philmd@linaro.org>
Subject: Re: [PATCH 00/12] target/mips: Remove target-specific endianness
 knowledge
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.153;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a2-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B49=E6=9C=8830=E6=97=A5=E4=B9=9D=E6=9C=88 =E4=B8=8A=E5=
=8D=8810:10=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
> Get vCPU endianness from CP0::BE bit.
> Propagate endianness at the board level, using QOM property.
> Remove target-specific endianness knowledge from target/.

For the series:

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Will this lead us to bi-endian QEMU executable?

Thanks
- Jiaxun

>
> Philippe Mathieu-Daud=C3=A9 (12):
>   target/mips: Declare cpu_is_bigendian_env() in 'internal.h'
>   target/mips: Introduce mo_endian_env() helper
>   target/mips: Replace MO_TE by  mo_endian_env() in get_pte()
>   target/mips: Convert mips16e decr_and_load/store() macros to functio=
ns
>   target/mips: Introduce mo_endian() helper
>   target/mips: Explode MO_TExx -> MO_TE | MO_xx
>   target/mips: Replace MO_TE by mo_endian()
>   target/mips: Expose MIPSCPU::is_big_endian property
>   hw/mips/cps: Set the vCPU 'cpu-big-endian' property
>   hw/mips: Have mips_cpu_create_with_clock() take an endianness argume=
nt
>   target/mips: Remove target-specific code in mips_cpu_reset_hold()
>   hw/mips/malta: Remove TARGET_BIG_ENDIAN #ifdef'ry
>
>  include/hw/mips/cps.h                     |   1 +
>  target/mips/cpu.h                         |   7 +-
>  target/mips/internal.h                    |  11 ++
>  target/mips/tcg/translate.h               |   5 +
>  hw/mips/cps.c                             |   4 +
>  hw/mips/fuloong2e.c                       |   2 +-
>  hw/mips/jazz.c                            |   2 +-
>  hw/mips/loongson3_virt.c                  |   2 +-
>  hw/mips/malta.c                           |   9 +-
>  hw/mips/mipssim.c                         |   2 +-
>  target/mips/cpu.c                         |  17 ++-
>  target/mips/tcg/ldst_helper.c             |  15 +--
>  target/mips/tcg/msa_helper.c              |   2 +-
>  target/mips/tcg/mxu_translate.c           |  18 ++--
>  target/mips/tcg/sysemu/tlb_helper.c       |   2 +-
>  target/mips/tcg/translate.c               | 120 +++++++++++-----------
>  target/mips/tcg/tx79_translate.c          |   8 +-
>  target/mips/tcg/micromips_translate.c.inc |  22 ++--
>  target/mips/tcg/mips16e_translate.c.inc   | 109 ++++++++++----------
>  target/mips/tcg/nanomips_translate.c.inc  |  32 +++---
>  20 files changed, 212 insertions(+), 178 deletions(-)
>
> --=20
> 2.45.2

--=20
- Jiaxun

