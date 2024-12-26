Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1936FE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvaK-0005l1-22; Thu, 26 Dec 2024 16:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvaI-0005jQ-03
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:39:58 -0500
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvaF-0004zY-SA
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:39:57 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3FFD7114017A;
 Thu, 26 Dec 2024 16:39:54 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Thu, 26 Dec 2024 16:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735249194;
 x=1735335594; bh=gRTZ8sWzeXAN743akuYufrBa3e84UlQoItjS8X+vbEY=; b=
 O3RC7PKGY+SePjShsqPsfCkbTneDmdIjqAMo46gBDiW1en4gf9CldBUYajpyosp6
 lYS9W7jAH4YBZMTBMRBf/RgRGyniWfWhT9+SlEgtayzptrVzTjiFrPBaBcnUkYW/
 I1RUHQlzrLF/b13gfhdxvk2A7KcI+OlF6az2iFdhGTYPTtuJ6h894CZlsimtunO1
 g6RbkP5nL8fCTfZK/wQ3u3sy8J3SbXBjpRIh7ktY1veCbhuVlkxPP8E9Lk2F4c/H
 w2uh37g/vIxWrQ/f8Pxokot5ZgYm5QTDSh+i/g6dkKS5oYuZZKvAIKqburiK0RFg
 +IG1cQighy3foIXpQoin7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735249194; x=
 1735335594; bh=gRTZ8sWzeXAN743akuYufrBa3e84UlQoItjS8X+vbEY=; b=C
 UBv34MxG4fPEBVTJwYJumAPNcf7fGUf9h8bfS5mJX5wdwsoFzI/ckr/1RdBJ08Cn
 Tx/jQp1CjikbX/B/LN+m2pffB3HJDvuMbPrYof1Q1noTD6P430XBK9BzuWyclecs
 WEXP6uNhowkrCru7yA5IxXu0Chwq/RSeB2ms8kahKTXrCT7s6MOL8UPUDyVKoxn+
 IgQ9LQF4hDfxmBvcfzKbntqZlwe5ZUNejgEBKnm1iO0Z5fkF5/d5nbmV0P5ZjZIo
 qtlBmaaUuTk5LlFGzml5HYCShdX0pecxwaIiwTnPd5ufKuwFrihtVT3AMBAh3mpu
 V2+QTgRRu6PQFwI8QBtvQ==
X-ME-Sender: <xms:Kc1tZ9cIp3Z6K-IqbAgDdlbf6zJNs1wvQv6Z3gyOwP18Xlm1d8yAHQ>
 <xme:Kc1tZ7MJOnfrni7kUOaz64ia-0GRRtkFIY-XXjpa376-A4q7uiitIFm_Yw1zPLOfE
 F9yooJujlHVVdgYoZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudehvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Kc1tZ2hL0Qo9sNB8JOC9ZfEI7x3P9-5ltYTS0ktu1jDVARZH1R51NQ>
 <xmx:Kc1tZ2_3n51AGk7of5M2DZmti7mq7G98Lovk1bJxOGde1XMe4nqNDA>
 <xmx:Kc1tZ5vYAW42wy2PNJfXuP2sLk_6uopH_RyVioHFLMSUmDliZ6sQMw>
 <xmx:Kc1tZ1EYLxnpzA3nxIN1JRjKiH9Ik8PDHTUg_toYAplW-mO5jmi2vA>
 <xmx:Ks1tZ1Hhb2abyxTvSU35O_pinFdAUgFOv7w6UxsthhIukkxDiRTAYwTs>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 2E44D1C20066; Thu, 26 Dec 2024 16:39:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 26 Dec 2024 21:39:31 +0000
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
Message-Id: <2524d6e1-fa65-42ec-8b5b-60b0c74b3165@app.fastmail.com>
In-Reply-To: <bf043ccb-21e6-4ff6-a8c2-ab2e38b6fc9a@linaro.org>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-9-0414594f8cb5@flygoat.com>
 <bf043ccb-21e6-4ff6-a8c2-ab2e38b6fc9a@linaro.org>
Subject: Re: [PATCH v2 09/23] target/loongarch: Use target_ulong for CSR
 helpers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.156;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a5-smtp.messagingengine.com
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
=E4=B8=8B=E5=8D=889:31=EF=BC=8CRichard Henderson=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>  =20
>> -target_ulong helper_crc32c(target_ulong val, target_ulong m, uint64_=
t sz)
>> +target_ulong helper_crc32c(target_ulong val, target_ulong m, target_=
ulong sz)
>>   {
>>       uint8_t buf[8];
>>       target_ulong mask =3D ((sz * 8) =3D=3D 64) ? -1ULL : ((1ULL << =
(sz * 8)) - 1);
>>=20
>
> Changes to helper definitions, but not to the declarations.
>
> Is this patch a victim of incorrect splitting, or incorrect rebasing?

Aha, those pairs of definitions and declarations are inconsistent in
existing code.

I should reflect this in commit message.

Thanks
>
>
> r~

--=20
- Jiaxun

