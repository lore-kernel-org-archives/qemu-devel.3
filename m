Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0252C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 12:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUnAe-0002Tv-Cs; Fri, 19 Jul 2024 08:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sUnAc-0002TN-Pz
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:57:10 -0400
Received: from fhigh1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sUnAX-0003NI-5I
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:57:10 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id EC63C114057A;
 Fri, 19 Jul 2024 08:57:02 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
 by compute2.internal (MEProxy); Fri, 19 Jul 2024 08:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1721393822;
 x=1721480222; bh=rb/Bp5bERugzP3jG353G17iEP+jUwZ220smUueMmgmg=; b=
 d4NjaKIC2zqHLIP0Dns2Iss+Y+T5nukacj3ZD2Yw/ZJCaiAnfD6Fb7a1yKsxsYVO
 THOIMBJA5fVvEhxRf+QZH0yTs+kuJhFPd0qkkpsmME0P41VK/Gos8ikkV8MT9V89
 q1zpRiu9og2AOGI764aC1RBMiOHK0sgGPlBDb9Yoaj+YwNjgo6PB+JpW+T62TcXw
 mt5bxuKpXyWl+iV/AyS9liUanlYO/KhMTDC90zOyqMJIjfv127o/ngkxsyWITYdC
 VK/G1TLHCxOSLo5Ja3laR7JhkUbUYgVDJpUcxkUa7l2GWLG/3TDhPDDVWxv8Ldpe
 OgCxHHMrq8et8O6Y1MwxVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721393822; x=
 1721480222; bh=rb/Bp5bERugzP3jG353G17iEP+jUwZ220smUueMmgmg=; b=H
 Ai8cshk1Dot4mWumzHLgYW+Dfq77YWc98EZNf8NxLYr9My1RUFCvb5uXD6m0nG2t
 HW5255AKigV1UKxJbZPB/W8rFC0vhFYbKqLFHrNRLW2pHsVqlUbt2sHG6WysiluK
 WsAgbD1Or6dWXJp36JfldS2ZB6ViGTcvEFBeLxgRFaE44biwNxGnV62ZZo/5BDGr
 pEQlZUz9lj8qedlRd4vHmCdTBdgp4hHq4IAt3Hg6116XcrDOF5JD5kZ6Z6Lo0Krt
 UkoCExgyjH7LeWMTmnvYH8yb+7Ilqf0Id9wXG8d8XJJirnqIKut94q0Z9TlFW77n
 yeSMdGzMXBYiTvz6k8h/A==
X-ME-Sender: <xms:nmKaZj6zUbF2Cbrs8bxkM68Zy9FjMn5DVocczZvx4szn49HmKi8YfA>
 <xme:nmKaZo4h8S-ceI0HtNwSvFfMEPV-ESM0zWOFF3aChqLLQSespNJdHlCA1-mgvKOpw
 cTcxsKP3KBkp7fRarI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrhedugdehjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
 rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
 eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
 geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:nmKaZqc1GRiTZP-vULTLPJK1tHlbAbgzWKblYmHq-xB7OcbF7-rShw>
 <xmx:nmKaZkJOx3WK8q5FxKlg2BlJNN5E0ryf13SFKtRiLGxzgofyFgnV_Q>
 <xmx:nmKaZnJiR9MBvY6j94E69nb2DE7Pm_Ar3XosAJN-YF9j5IGc_MiQHw>
 <xmx:nmKaZtzy1TWXoSMS2Mf4uHXEG7aW9tOauIVyiTtE8g12JVURUCb1_A>
 <xmx:nmKaZkorPnW7nCy3yvmDsUq1yVwyfnQ-Q40N2nfJQtkBcbrTJAQsgAYm>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 769E919C0064; Fri, 19 Jul 2024 08:57:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
MIME-Version: 1.0
Message-Id: <c7e11721-812f-4ca5-9115-1ae060b4ff25@app.fastmail.com>
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
Date: Fri, 19 Jul 2024 20:56:42 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Bibo Mao" <maobibo@loongson.cn>, "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>, "Paolo Bonzini" <pbonzini@redhat.com>,
 "Huacai Chen" <chenhuacai@kernel.org>,
 "Xiaojuan Yang" <yangxiaojuan@loongson.cn>,
 "Xianglai Li" <lixianglai@loongson.cn>
Subject: Re: [PATCH v5 00/19] Reconstruct loongson ipi driver
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.152;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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



=E5=9C=A82024=E5=B9=B47=E6=9C=8818=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=889:32=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
> Since v4:
> - Fix build failure due to rebase (Song)
> - Loongarch -> LoongArch (Song)
> - Added Song's tags
>
> Since v3:
> - Use DEFINE_TYPES() macro (unreviewed patch #1)
> - Update MAINTAINERS
> - Added Bibo's tags

For the whole series:

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks! Tested on MIPS loongson3-virt with 2, 4 CPUs, all working fine.

I'll get this covered by CI later.
- Jiaxun

>
> Thanks,
>
> Phil.
>
> Bibo Mao (16):
>   hw/intc/loongson_ipi: Access memory in little endian
>   hw/intc/loongson_ipi: Rename LoongsonIPI -> LoongsonIPIState
>   hw/intc/loongson_ipi: Extract loongson_ipi_common_finalize()
>   hw/intc/loongson_ipi: Extract loongson_ipi_common_realize()
>   hw/intc/loongson_ipi: Add TYPE_LOONGSON_IPI_COMMON stub
>   hw/intc/loongson_ipi: Move common definitions to loongson_ipi_common=
.h
>   hw/intc/loongson_ipi: Move IPICore::mmio_mem to LoongsonIPIState
>   hw/intc/loongson_ipi: Move IPICore structure to loongson_ipi_common.h
>   hw/intc/loongson_ipi: Pass LoongsonIPICommonState to send_ipi_data()
>   hw/intc/loongson_ipi: Add LoongsonIPICommonClass::get_iocsr_as handl=
er
>   hw/intc/loongson_ipi: Add LoongsonIPICommonClass::cpu_by_arch_id
>     handler
>   hw/intc/loongson_ipi: Expose loongson_ipi_core_read/write helpers
>   hw/intc/loongson_ipi: Move common code to loongson_ipi_common.c
>   hw/intc/loongarch_ipi: Add loongarch IPI support
>   hw/loongarch/virt: Replace Loongson IPI with LoongArch IPI
>   hw/intc/loongson_ipi: Restrict to MIPS
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/intc/loongson_ipi: Declare QOM types using DEFINE_TYPES() macro
>   hw/intc/loongson_ipi: Remove unused headers
>   docs: Correct Loongarch -> LoongArch
>
>  MAINTAINERS                           |   6 +-
>  docs/about/emulation.rst              |   2 +-
>  include/hw/intc/loongarch_ipi.h       |  25 ++
>  include/hw/intc/loongson_ipi.h        |  50 +---
>  include/hw/intc/loongson_ipi_common.h |  72 ++++++
>  include/hw/loongarch/virt.h           |   1 -
>  hw/intc/loongarch_ipi.c               |  68 +++++
>  hw/intc/loongson_ipi.c                | 355 +++-----------------------
>  hw/intc/loongson_ipi_common.c         | 344 +++++++++++++++++++++++++
>  hw/loongarch/virt.c                   |   4 +-
>  hw/rtc/ls7a_rtc.c                     |   2 +-
>  hw/intc/Kconfig                       |   8 +
>  hw/intc/meson.build                   |   2 +
>  hw/loongarch/Kconfig                  |   2 +-
>  14 files changed, 570 insertions(+), 371 deletions(-)
>  create mode 100644 include/hw/intc/loongarch_ipi.h
>  create mode 100644 include/hw/intc/loongson_ipi_common.h
>  create mode 100644 hw/intc/loongarch_ipi.c
>  create mode 100644 hw/intc/loongson_ipi_common.c
>
> --=20
> 2.41.0

--=20
- Jiaxun

