Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50A3E7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQwod-0008MR-10; Thu, 26 Dec 2024 17:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQwoc-0008M9-3U
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:58:50 -0500
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQwoZ-0005xg-UB
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:58:49 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AD7201140117;
 Thu, 26 Dec 2024 17:58:46 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Thu, 26 Dec 2024 17:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735253926;
 x=1735340326; bh=RjdIR8JqH5CFQhYu3Hy78KRXvk7SCTcr+PzUEoeUmDo=; b=
 KpvlOb1/rvhA/9aXwRO+EQx/VaJM+QQtcJrw0EIfUfYmetVCqhMbOHrFTH3bqxwz
 F++ATEgk+FtBusXPa6nhLSVE/oyaJFhpOQ7MW63Foch/3kwJyWEeE5BYx5ij25On
 qvBP2gfoCqd3yDpynd0xeACKiuOickXhVlUWV9Oe1MtOgxqA1a9c0RhmwJor6ksd
 hD0Dgyly2bQk1UJCuwh+UnQ+mSz2ErEfhRWRKzhBWlSjK2dWyIi1wVwN1jOqEgBj
 3Sqthf81NwYHjLfWUgvJmJTolBx3xL6br9bYIld4hZ4aPDqc0fvwnpMQYmtpyu0r
 9Khp3i+7G3VBFH1+0zGbDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735253926; x=
 1735340326; bh=RjdIR8JqH5CFQhYu3Hy78KRXvk7SCTcr+PzUEoeUmDo=; b=l
 JuHOm3JHkMu1u6TDJ3fLR5nbd++DutIoCmI6dYeEQa7mKuVg2AskeXHePLzZ+xyH
 X9CFWulTBUgDwhLjC2yePMihfzYk+nqu+9D7UkjXQJdVP7DQndWdjdZ2UTE7yyq+
 CD6i8pr4/wOmFVAMaHG/VxMdu/mC5cqcwE5alj4XiI5MjAR8hdvrV0Jz2tDLRM+c
 7PlLwJGkd9BewG+ZjuKHl6R4mDLibFAel/lpA600sIJ2FkPEYgGnZRblFNNt+AT0
 bMixDjTdReBN/0undBM/LgD/HEIsD7wGXPsd/3400fUAcJPORKmXoOtEdNnOe//e
 FBAk5EJ23jldfwCpKt5xg==
X-ME-Sender: <xms:pd9tZ1rOEMNWFKti3j0LvguLpx-taRpNAHP1nV-rvqWSeJ-4ykZ6bg>
 <xme:pd9tZ3rUerY6Dc7dbsyYnGiJ77ULNMXU3JGZNmrXZlwEwS6MS335gmrw1H0DYWdWy
 -VW_HtfmDaOrJlT9O0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduledgtdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
 hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
 thdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtph
 htthhopehmrghrtggvlhdrrghpfhgvlhgsrghumhesghhmrghilhdrtghomhdprhgtphht
 thhopegvughurghrughosehhrggskhhoshhtrdhnvghtpdhrtghpthhtohepfigrnhhghi
 grnhgrnhehheeshhhurgifvghirdgtohhmpdhrtghpthhtohepiihhrghouddrlhhiuhes
 ihhnthgvlhdrtghomhdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpd
 hrtghpthhtohepghgrohhsohhngheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehm
 rghosghisghosehlohhonhhgshhonhdrtghnpdhrtghpthhtohepqhgvmhhuqdguvghvvg
 hlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegrrhhmsghruhesrhgvughhrghtrdgt
 ohhm
X-ME-Proxy: <xmx:pd9tZyNsCrHvvmIW1YsnmibbayqPzopCyKz9g7gNeN48QBIousihFg>
 <xmx:pd9tZw7pvg3tQg-lByenituhljG2lB8XD_ocyRyt1geCjiUM0w9Z-w>
 <xmx:pd9tZ06T15h_XmDycfJFuQVhcFPg6D06LAxCjzfJWlo4v5l65UpD9g>
 <xmx:pd9tZ4ho8LL8bF2kinEH_rdU_v6B5m3ztFVZQ0PPN9RN037HQXb5jA>
 <xmx:pt9tZxyVoQ2fhV_Bws510MgZFEx95z33eVJdEml63aNNZXi7OYDKaM24>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id A3AB01C20066; Thu, 26 Dec 2024 17:58:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 26 Dec 2024 22:58:25 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>, "Bibo Mao" <maobibo@loongson.cn>,
 "Eric Blake" <eblake@redhat.com>, "Markus Armbruster" <armbru@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 "Yanan Wang" <wangyanan55@huawei.com>, "Zhao Liu" <zhao1.liu@intel.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>
Message-Id: <b31fde39-87f1-470b-86af-bb648caf6cfe@app.fastmail.com>
In-Reply-To: <1f72e77a-5da9-4119-8e92-a707552f856f@linaro.org>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-6-0414594f8cb5@flygoat.com>
 <1f72e77a-5da9-4119-8e92-a707552f856f@linaro.org>
Subject: Re: [PATCH v2 06/23] target/loongarch: Store some uint64_t values as
 target_ulong
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
=E4=B8=8B=E5=8D=8810:48=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=
=93=EF=BC=9A
> On 26/12/24 22:19, Jiaxun Yang wrote:
>> Store internal registers including GPRs, CSRs, and LBT scratchs
>> as target_ulong, as per architecture specification.
>>=20
>> The only exception here is tlb_misc, as it's only used by QEMU
>> internally and need keep to be 64bit to store all required fields.
>>=20
>> There is no migration ABI change, as target_ulong is uint64_t on
>> existing loongarch64 builds anyway.
>
> I'm working on a prototype series where target_ulong becomes uint64_t
> under TCG. This patch is going the opposite direction. Not sure what
> to say at this point (I'm not rejecting it, just wondering).

Does this mean TCGv will always be 64bit?

I'm doing this just to keep all TCG _tl load/store sane. If that's the
way to go, I'm happy to adopt full uint64_t approach.

Thanks
>
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   target/loongarch/cpu.c     |  34 ++++++------
>>   target/loongarch/cpu.h     | 132 ++++++++++++++++++++++------------=
-----------
>>   target/loongarch/machine.c | 120 ++++++++++++++++++++--------------=
-------
>>   3 files changed, 143 insertions(+), 143 deletions(-)

--=20
- Jiaxun

