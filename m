Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C05F46C40
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kUa-0004yX-7j; Mon, 06 Apr 2026 09:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w9kUZ-0004x8-0k; Mon, 06 Apr 2026 09:59:51 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w9kUX-0003Lk-6h; Mon, 06 Apr 2026 09:59:50 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id DAF63EC00A7;
 Mon,  6 Apr 2026 09:59:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 06 Apr 2026 09:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1775483985; x=1775570385; bh=sTFM8rY9e+2vScz5FYIDB8oh5pjB/8GA
 NRxixCBt1CI=; b=j5PNHNaF5CDnFH0eNPVGnT2N9Kq+sLNgDar3tVEB3Yr4xcK/
 RVPQzqN3gFgVds/ED3fu0wvsvLjudqVTd9mEn28rJ4rqdqa+TyVrwFwX5swyR63H
 NzDdNoFIAIqpT8JHS4rQF/YkRynH4eKLIN3d1RzR/Iqrr58yo8aEj4tYYSlRuhzd
 3qobPOjcqtTslRjxgXZ+VcIMgzSYRKOTIzmNzDuWYpxxQcg9d3mSzBSKnE3o4VAZ
 MZXUzItmMX6Sp6PCaMmN5G2CN9XQ1mOZgMpGN8rR8mp60duL8LSIvX1WRYK3MIrg
 Ty+nO3J7pJexWjNwDkmjKZXZpNuEkPk+5rmxNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775483985; x=
 1775570385; bh=sTFM8rY9e+2vScz5FYIDB8oh5pjB/8GANRxixCBt1CI=; b=o
 3kn/l4reH8IlJSL1zIfvx2OKBvkEE7XP2gBVt3KykPmp08Slz/gdfZUfcc/nNo3n
 qmT2UAcD9ufEP3JhcFtCAs8ZdPDhRToYomhVVAsc4XwztGmoJEth/sV02mmkQze7
 03vvYp6FZwDnTPU6W7LvPquO8A3wUwu1JsNrXV/C9m704meQkL5laWHAXM/I+Li3
 JFkSY+nXK1EIYlRCaRZ0LACOa7zf2lgP7Lcum4P8ZUwhCP8hz3Hrt/hNI1U/VFRi
 pu5ZIHKmgL5JE1OyB30kaDrEO7JI4JHxb94DGS7AOxvHC83f6+06+20+mSnZ22yX
 z+8p1DFWi0OZwbzVEG4JQ==
X-ME-Sender: <xms:UbzTaSugUAM23EM8_XtVL10BM7QKMaOjl7eSwyPdn8BqRac_IZ4Vrg>
 <xme:UbzTaS4idRlkjX2pnh1fndC06NYLTugnvtjvbj8orfmY6wvBDO__2XhnledkI0j-A
 YFxLo3JVsg5RNebpS6LuRCsesDmGuzGK5fYNg_iEhYHge5XRyMuGg>
X-ME-Received: <xmr:UbzTaRT15wE5ud0q0B0SUUMe248Jj8FAGLiA8bk-WVPI66Bq_6tCj1xJh_lW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddujeeltdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdej
 necuhfhrohhmpedfvehhrgguucflrggslhhonhhskhhifdcuoegthhgrugesjhgrsghloh
 hnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhephfefudffkeffheduffetledvkeet
 vdejhedtheektefhhedvgefhheethfffkeegnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhn
 sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsghonh
 iiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehn
 ohhnghhnuhdrohhrghdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpd
 hrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepqhgv
 mhhuqdguvghvvghlqdgsohhunhgtvghsodgthhgrugepjhgrsghlohhnshhkihdrgiihii
 esnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:UbzTaRo4kJecUpcxoYbVnEXQaTs5q78kvnWVLKG4D7agoGSvy-tSug>
 <xmx:UbzTafLR2QEwFc_Jxb3sYzdbm2Q6VSiIEejgXx0pDFCtG0FetbjdyA>
 <xmx:UbzTaUr6Fmn8yOs5KSQY1u2eMVmN7g2CcB3tqgguEekIugf7zZOz8g>
 <xmx:UbzTaXzK9ICZVISFNoTc3ltnTLN7TkGqGa2-6IuWrdlJVMGh0vROGA>
 <xmx:UbzTaaH8d7D_BIHuZcV8AUK6NHt_CJGfZYDTHnqut7rVwOO--HAryeZ2>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 09:59:45 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id b3b83e26;
 Mon, 6 Apr 2026 13:59:44 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 09:59:44 -0400
Message-Id: <DHM4JMDNPIMH.1DLI1TRKFITA9@jablonski.xyz>
Cc: <pbonzini@redhat.com>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH] migration: Remove unnecessary zlib include from
 qemu-file.h
From: "Chad Jablonski" <chad@jablonski.xyz>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Chad
 Jablonski" <chad@jablonski.xyz>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20251219014512.387773-1-chad@jablonski.xyz>
 <5837fdc7-f74f-4677-ad90-84c2ac52f970@linaro.org>
In-Reply-To: <5837fdc7-f74f-4677-ad90-84c2ac52f970@linaro.org>
Received-SPF: pass client-ip=103.168.172.146; envelope-from=chad@jablonski.xyz;
 helo=fout-a3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

This patch receieved an R-b but hasn't been merged yet. Is there
anything else needed, or can it go into rc3?

Thanks

