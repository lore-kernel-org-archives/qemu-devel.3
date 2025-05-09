Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466AEC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 12:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDMyE-0002kd-Dh; Fri, 09 May 2025 08:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uDMy2-0002g8-88
 for qemu-devel@nongnu.org; Fri, 09 May 2025 08:36:44 -0400
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uDMxw-0002q5-6c
 for qemu-devel@nongnu.org; Fri, 09 May 2025 08:36:41 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AE6321140197;
 Fri,  9 May 2025 08:36:34 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-06.internal (MEProxy); Fri, 09 May 2025 08:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1746794194;
 x=1746880594; bh=5DI4edy5GU6I3ncU4EIR+IXdrKhADNHY5cHHQR1edhI=; b=
 SOGTPM5uWpnbnA8zYV9rSY5VN4HVNpPUdxsgD7FslP3sY/h7qzeG02BH9MIXaWCA
 39j2P45rinwbBYwUW2Mkc3YgWx0tQMXKmzTntIayAgHu2gz1fok+Sl9H3QZUqquz
 o07CC0gshLfX7mjnadRwrtsh+iCFcsf9NwY6y448lL/t566k9/+b13JjceK8GrrD
 UBkeSGlgTJlufilH1hrvOdEWLbdB0grNO+OdtqwommP7c6xV03CWRGwVGAlkuPKS
 JHf+61f2ogEiIOKlaaom+zrRMjEdaS0OAH0/A3AtXJNnCUNQou2bD5Ti4CSBWidr
 W2ywu4m5mEot/dXgypLH9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746794194; x=
 1746880594; bh=5DI4edy5GU6I3ncU4EIR+IXdrKhADNHY5cHHQR1edhI=; b=A
 wD4KAUgpOph/CMDlx+pNwemITOVdBEC8VDQquNIQ+NBHT/ZeB4ynaT2vcXyihTPL
 VXzRGPZ/+ZQOts3aBZMAisd4qgg1i0Avcepi29zj51q9Bj81rPRT9Kf+G6tQcQ6h
 whn3RXGWaULx9y6go61RYlUw/OHiZpd+bk7LRkUUN+jyownbpMIdCSnDcDZmDYLQ
 t8CeASj2AqZw7nlNMe3wVlm/KoLHhCOt/MnUD3QSuOoj7yrCtPtFz1rcSVd0WI6e
 qwnny5/yt+H/fLpHN7bDKn518NMCT6xnR5s31oXEYG15cHeAnfjK9Jv6dIMNi7vn
 Gf18z/G6P7M4j0PfiCg/w==
X-ME-Sender: <xms:0vYdaP88GJ431kpVJfkp9-ke29-BUDP2gLum8nFOQUVyls0NKljp3Q>
 <xme:0vYdaLsuKbxWwGC8OWy8PmG-_6xTAeLYmHjP6RHTsnoLUX4ML7YHX25vt_b1ZEAU7
 c_uPTkb-mumKMukFC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvieefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
 tdejnecuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghngh
 esfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdff
 keethefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihg
 ohgrthdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
 hpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
 rghoshhonhhgsehlohhonhhgshhonhdrtghnpdhrtghpthhtoheplhhigihirghnghhlrg
 hisehlohhonhhgshhonhdrtghnpdhrtghpthhtohepmhgrohgsihgsoheslhhoohhnghhs
 ohhnrdgtnhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:0vYdaNA_SVPbr5eICsYje_BwnmirEUzq4TULGM80glZIptcXnVJ-sg>
 <xmx:0vYdaLd3KL6HtX7pbdCtg5oi5a3If7hRLvI2Qw5WlXJLl3xpp1f4Bw>
 <xmx:0vYdaEMnwZ1tFydwwmBJTUk30ZRqPp1a_kb-V0aAjdgZx3q_Tm6Vlg>
 <xmx:0vYdaNmFLoFVOXl_X_-faPP-M_HJZPA-7xaxh-p_IuWPsonuV2DqzA>
 <xmx:0vYdaKtyzo1PPWjQK61ZFSpApMHBgNgXDo_XRoZwo2i5kN1VUolN_tIj>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 300101C20067; Fri,  9 May 2025 08:36:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T61eab45fb9657032
Date: Fri, 09 May 2025 13:36:13 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "Song Gao" <gaosong@loongson.cn>
Cc: "Huacai Chen" <chenhuacai@kernel.org>,
 "QEMU devel" <qemu-devel@nongnu.org>, "Xianglai Li" <lixianglai@loongson.cn>
Message-Id: <5fa02121-43f6-4335-883e-efe07a2f3711@app.fastmail.com>
In-Reply-To: <20250509100747.1070094-4-maobibo@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
 <20250509100747.1070094-4-maobibo@loongson.cn>
Subject: Re: [PATCH 03/15] hw/intc/loongarch_extioi: Add irqchip-in-kernel
 save/restore function
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



=E5=9C=A82025=E5=B9=B45=E6=9C=889=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=
=8D=8811:07=EF=BC=8CBibo Mao=E5=86=99=E9=81=93=EF=BC=9A
> Add save and store funtction if irqchip-in-kernel property is enabled,
> it is to get/set ExtIOI irqchip state from KVM kernel.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/intc/loongarch_extioi.c         |  17 +++++
>  hw/intc/loongarch_extioi_kvm.c     | 100 +++++++++++++++++++++++++++++
>  include/hw/intc/loongarch_extioi.h |   2 +
>  3 files changed, 119 insertions(+)
>
> diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
> index 854f54684b..e81caf430c 100644
> --- a/hw/intc/loongarch_extioi.c
> +++ b/hw/intc/loongarch_extioi.c
> @@ -398,9 +398,21 @@ static void loongarch_extioi_reset_hold(Object=20
> *obj, ResetType type)
>      }
>  }
>=20
> +static int vmstate_extioi_pre_save(void *opaque)
> +{
> +    LoongArchExtIOIState *les =3D LOONGARCH_EXTIOI(opaque);
> +
> +    if (kvm_enabled() && les->irqchip_in_kernel) {
> +        return kvm_loongarch_extioi_pre_save(opaque);
> +    }
> +
> +    return 0;
> +}
> +

Hi Bibo,

I believe hijacking loongarch_extioi.c is not the proper way to do it.
The sensible solution is to create a TYPE_LOONGARCH_EXTIOI_KVM, which
inherits TYPE_LOONGARCH_EXTIOI_COMMON, and let machine create
TYPE_LOONGARCH_EXTIOI_KVM vs TYPE_LOONGARCH_EXTIOI as necessary.

In this way you can avoid ugly "irqchip-in-kernel" property.
Also you don't really want all those emulation functions in
loongarch_extioi.c to kick in when irqchip is in kernel. If
IOCSR VMEXIT happens on extioi range, it's a hypervisor error
rather than something needs to be emulated.

Also I think EXTIOI_VIRT_CONFIG range MMIO needs to be handled
differently on KVM vs userspace irqchip. EXTIOI_VIRT_CONFIG needs
to be relayed to kernel, as virt_iocsr_misc_write will perform
IOCSR read/write in userspace, this needs to be translated to
KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_STATE.

Hope it makes sense.

Thanks
--=20
- Jiaxun

