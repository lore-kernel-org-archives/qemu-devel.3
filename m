Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92243E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQw2W-0003cI-IY; Thu, 26 Dec 2024 17:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQw2S-0003bq-Ub
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:09:06 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQw2R-0000wZ-2N
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:09:04 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 3CC021380197;
 Thu, 26 Dec 2024 17:09:01 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Thu, 26 Dec 2024 17:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735250941;
 x=1735337341; bh=+SxT4xdPHznc01EeI2ZXE4RB/jFqlpVv5mq/sWu2i2A=; b=
 GejU7GWkLC8Dgta7+Uz2aS6iccJILjyBzUlNacIZCp2JrPNCwt4+SDmS/UNTd96G
 sDZVGWt5WWbGFaYySGmA9qok+3u0aiv67pBdGlSuQWlG6wj680WrAQf2YsdeH7l9
 PVc9mLh9j81OYLtV5Pb457FDhFo/s02t2kdUcH42s8wvsTAJBy8hqSbXW7zXjb4e
 0bMTpeEGNOI9Fes3wQogAL5Ky/I67ZdSWchBpZq6XkuHkAGqFLezTTZXTxdBiwvY
 HN5G/sIHYA+2mXj73aFOPJ8YfCXpi1s7xtI1bWiDNRb8c1p4GMAFOSLMqfW9T1XG
 2uxVl4qA93G6P3q34h86NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735250941; x=
 1735337341; bh=+SxT4xdPHznc01EeI2ZXE4RB/jFqlpVv5mq/sWu2i2A=; b=x
 +CbNxKzw9WPB9J+/8uJhb8rX6nTc/MGKkUsK8F6RibSf4OGlla/+1vn/483MsnLy
 4L3wgW7rZnBRzL2sbYk4eoT/Ulp3jMi9zg3XElyVrSYZVmjWpFGPVg51BOeNYz71
 8pCsB8hHwaZ/Y1VXhUfVQCLyhKo4aBv2bqBTpBw5KeBy9p/K40qJbLxD6KSG/baE
 66hlkp/tSOxx6MrkrmAQF2ThZgnEusnsfroU4TlxjsmsFONX0/cchsBCinzTDGyx
 6TAvipnbNDZJ3BLebFK+yGhgOdRRmdHrMFIjW5cuf4FJhmTuikFw6Fg3pcFrDNli
 sGf4DzaUj12KcEYPVEypw==
X-ME-Sender: <xms:-9NtZ0qGciIieyo8YNkn4pkELJt5Lm00poGh6AJUoC4XsjsBE5knEA>
 <xme:-9NtZ6rFl894zcL9zRpLjDM3PyHPu8jErbfif91IYL5rbZfq9XNv9T5XtCsEoZHVu
 HaqlH6ju-71UU_dKAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudehkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
 jeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgse
 hflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejheefuddvtdfggfdvffek
 teehhfelgfdvvedvkeeuffefkeehheegvefhveetjeenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghho
 rghtrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtg
 hpthhtohepmhgrrhgtvghlrdgrphhfvghlsggruhhmsehgmhgrihhlrdgtohhmpdhrtghp
 thhtohepvgguuhgrrhguoheshhgrsghkohhsthdrnhgvthdprhgtphhtthhopeifrghngh
 ihrghnrghnheehsehhuhgrfigvihdrtghomhdprhgtphhtthhopeiihhgrohdurdhlihhu
 sehinhhtvghlrdgtohhmpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrgh
 dprhgtphhtthhopehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhr
 ghdprhgtphhtthhopehgrghoshhonhhgsehlohhonhhgshhonhdrtghnpdhrtghpthhtoh
 epmhgrohgsihgsoheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehqvghmuhdquggv
 vhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:-9NtZ5M9TlsiYt7bGVEn9EXX0ZPt5tdVIUWmChgzNSTw16iXKejCkQ>
 <xmx:-9NtZ761Ca7VHtBbPQK21uI6PEzffReufJyN_jed-XN7H91Xyqmu2g>
 <xmx:-9NtZz7a1l6OFd2DOCJqkGGIFexjh6SH6CC0AbzGHvULFjm7vlQQog>
 <xmx:-9NtZ7g8nd-vjkxK2I3cHIaxYRvv64Rhr9ZDePQkXqy9_bSZO3xr-g>
 <xmx:_dNtZ3jtW8OarqR9_gkVOAUOshk2MyOda5Klkb6IZQyJXuSMKJH67BhD>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id CDAA01C20067; Thu, 26 Dec 2024 17:08:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 26 Dec 2024 22:08:38 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Richard Henderson" <richard.henderson@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>, "Bibo Mao" <maobibo@loongson.cn>,
 "Eric Blake" <eblake@redhat.com>, "Markus Armbruster" <armbru@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Yanan Wang" <wangyanan55@huawei.com>, "Zhao Liu" <zhao1.liu@intel.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>
Message-Id: <192abfba-5b21-4223-94a6-673155949662@app.fastmail.com>
In-Reply-To: <f2360c0b-979a-4473-a7b1-96caa54cff27@linaro.org>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-12-0414594f8cb5@flygoat.com>
 <f2360c0b-979a-4473-a7b1-96caa54cff27@linaro.org>
Subject: Re: [PATCH v2 12/23] target/loongarch: Scrutinise TCG bitops
 translation for 32 bit build
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a1-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B412=E6=9C=8826=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=889:55=EF=BC=8CRichard Henderson=E5=86=99=E9=81=93=EF=BC=9A
[...]
> While this allows the code to compile, (1) the functions are unused an=
d=20
> (2) they do not=20
> compute the required results.  For me, the latter is concerning.
>
> I'd suggest moving GEN_FALSE_TRANS out of trans_privileged.c.inc, then
>
> #ifdef TARGET_LOONGARCH64
> // all gen_foo_d
> TRANS(bytepick_d, 64, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_d)
> // etc
> #else
> GEN_FALSE_TRANS(bytepick_d)
> // etc
> #endif

Thanks for the insight!

I'm actually thinking about introducing an TRANS64 which resolves to
GEN_FALSE_TRANS if not on TARGET_LOONGARCH64.

Will try in next version.

Thanks
>
>
> r~

--=20
- Jiaxun

