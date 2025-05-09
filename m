Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3B8C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 12:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDMd5-0001JA-Fb; Fri, 09 May 2025 08:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uDMcw-0001Dw-HJ
 for qemu-devel@nongnu.org; Fri, 09 May 2025 08:14:55 -0400
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uDMcq-00007P-D0
 for qemu-devel@nongnu.org; Fri, 09 May 2025 08:14:54 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E57DD1140179;
 Fri,  9 May 2025 08:14:44 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-06.internal (MEProxy); Fri, 09 May 2025 08:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1746792884;
 x=1746879284; bh=lSubyW03DCg7OiznXvR1OSs6YXkjDZcyo+emS+GJmpE=; b=
 dyfOB7J1QKqy4z5aWn/w8NOpfdGJwWR77Vd6E/mra/1DY/hJ20M9CAs370IVebfw
 +H0el5UHcpiUk/fBS3qocPYEkLWF2rqp27gkTMRrgZyi1BCqBv116JOZjfUneyU/
 bMZYns7AfFFi+LLMFY4XFP7DFaxAYEQlG5yyRYM0GOOSrAwLJb0I0z9mDgJcy9SU
 a+pcI+J5pg0/EqClU/6jWWl3bHGkl3+T20vKsiVPIJCG4o8rd+zl8lkJULjA+kmd
 9UBqa2dGEbEIBi5/07k/gHfoO/1HQJ2NbCzYeXLnSa5qc6Ojc+k6FCoRHJJjpbPV
 gS8I6wmgMhSCqkAGqoDStQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746792884; x=
 1746879284; bh=lSubyW03DCg7OiznXvR1OSs6YXkjDZcyo+emS+GJmpE=; b=M
 hnzISAyuFd71GjitPDpAkXsq+sWJfQG6cj1VbiXpLisxr9nM31vFjEBjymBZId+o
 vfplobBIpPWHA86nLM1VSYHxJH6LZnXe+tdcXXRxihOTdzhZXnomWujqG8f/aJmx
 gDtzM36l1vCNc31l4GVVLpcb0NbYTc4lsfOpE6lYYsfxDJa9ysxumXoTl9MNA6sH
 JAgVRMw2cmjg9KdgMXQteDzwZCpvnkSINkodUUk7eCl9qtkL68kFeoMHXsiqGxH/
 Z0BkpdIivlCLC0Avz2LRLVkva4nWbPVE+Scik2JR0nI767mw7IN5MRAuFRSvSBRi
 nzqabLrWHEL/N2I21K37A==
X-ME-Sender: <xms:tPEdaKdWsfpXrfS5s7cD2zH2mYnDZ8Xyyjw1PlZU5_DMN1nWcwLElQ>
 <xme:tPEdaEMLRg2Sfksssw_6dzTONIq1oSnkG49Nxkxni-lNcUdOHrYMB2s5omc-Q0kF4
 JqHYwPHDaKovUSinbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvheelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:tPEdaLhVFQh8GUXVxHAgo8vmiCm9mWIcFAHd3cCbi_uCUpZnv1sjWA>
 <xmx:tPEdaH87nHY6YdtTsQdE18N9H5sJHVrw8lhaGC3mPwKbWHerAm9AFw>
 <xmx:tPEdaGszURUs61b8OBZN5D2AEz8m6eKPVUCvQqx12VW1wxv2pmRtlw>
 <xmx:tPEdaOGiT7kzIltMlwmm9TotqfS04DVQbLPh8-jKoW5X4c1Kds9JuA>
 <xmx:tPEdaNOPKGb1JfCoYzJlCA4WeI54REhdZVBB-TjIEhYhveboAOqLQYaI>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 522E81C20067; Fri,  9 May 2025 08:14:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T21cba618b4b61b3d
Date: Fri, 09 May 2025 13:14:16 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "Song Gao" <gaosong@loongson.cn>
Cc: "Huacai Chen" <chenhuacai@kernel.org>,
 "QEMU devel" <qemu-devel@nongnu.org>, "Xianglai Li" <lixianglai@loongson.cn>
Message-Id: <977bcff5-d3bf-47b5-8958-d279ca22a4d4@app.fastmail.com>
In-Reply-To: <20250509101245.1070255-4-maobibo@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
 <20250509101245.1070255-1-maobibo@loongson.cn>
 <20250509101245.1070255-4-maobibo@loongson.cn>
Subject: Re: [PATCH 14/15] target/loongarch: Report error with split
 kernel_irqchip option
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
=8D=8811:12=EF=BC=8CBibo Mao=E5=86=99=E9=81=93=EF=BC=9A
> Option kernel_irqchip=3Dsplit is not supported on LoongArch virt machi=
ne,
> report error and exit if detect split kernel_irqchip option.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  target/loongarch/kvm/kvm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 1bda570482..a8e5724b21 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -1249,7 +1249,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>=20
>  int kvm_arch_irqchip_create(KVMState *s)
>  {
> -    return 0;
> +    if (kvm_kernel_irqchip_split()) {
> +        error_report("-machine kernel_irqchip=3Dsplit is not supporte=
d on ARM.");
                                                                        =
   ^ ARM :)

Thanks

--=20
- Jiaxun

