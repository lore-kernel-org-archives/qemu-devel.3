Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C5FC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 12:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taD50-0001go-CQ; Tue, 21 Jan 2025 07:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1taD4z-0001fI-4E
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:10:01 -0500
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1taD4x-0007Ai-H2
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:10:00 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6A97F25401F2;
 Tue, 21 Jan 2025 07:09:58 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Tue, 21 Jan 2025 07:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1737461398;
 x=1737547798; bh=iAVzyZ0C870BZk/886kSbHhmH/4D/2VWz+rCkSFqN8c=; b=
 PfM28h9eCMksEeImUCyENABhHbzp16NmTdJzn107ImztdraLhGVXX/WOP8PnzsQP
 hYGxM7TiEyngaS4OgC3du+dMdOBJTyCeoodx/88GfwcW0CEAQy8mVJdMdyE9BlKP
 3ZKfzasQMB1DsvdtaI7VBZYsiOjmxAGBH2vHHgj2Mtdv/ThT6DQywZug7R3HoZU8
 BYQmQ+hzLr7Qi3/nh18OtMDnE+bVoyTR1bonavx61GFvpLcxUCsqi9R9bqI1uI9g
 LPVDu2MI8chC68QRJxfDfHb1P7KKF5Td/CfSp1Ok5948mFxgiZDx+M8tG6hn4u9V
 A3C1XD+0GxFHojPYUS+cUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1737461398; x=1737547798; bh=i
 AVzyZ0C870BZk/886kSbHhmH/4D/2VWz+rCkSFqN8c=; b=xcqZbjKaLbxpgRfSO
 wm1p8O7azAkZtnyfVIjwG4dszhDUMYBOs+wfR/ytaCnib+yyprrmDNtBYUfH/R4K
 y0v+6921y7rNDHsTl1LKqMpNz9DL8sp9yml1J37Tum0INMfYCfcOgSfB4YUUCE6Y
 WfNP6VmoF+JuT7tA3zjy/kLo3XPT6Hg9RpwuxyuPc02LyGiepMgFnk71Nw3r6jef
 EQi3JIt5724GaH4/SYGJ0UqhvKylO+3U3YSdVDSwDGzu2fnxXKDjJkR1eNHQxLEw
 FdiF1E1fxiUYX9ejmedU/nq+UTDG/wtSuvQLJ10KJ1BWaRGivG8mvUJiq2fs8MAy
 UGJ0Q==
X-ME-Sender: <xms:lo6PZ53FVyz8f5kRB-glMD6c02NsPdrt6F9P6tW2308h9QW5BlChWw>
 <xme:lo6PZwFOnFfyrJ1AJE6by8Cf2GVIdHXDeKYaPPMdNQ9662qalkoISRfzgNhtNuSvn
 WGNUJTEm452mSeSi54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgtdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
 ucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejvdfgteevhfffhfduffehleei
 ieevledvieelfffggefhfeekuefhudegfeelffenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopegrrhhikhgrlhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhlmhgusehl
 ihhnrghrohdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurd
 horhhgpdhrtghpthhtohepthhhuhhthhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:lo6PZ5507nnKtAYU0r-FmjaqnTv5VyrJLNwxAIFH8TPqiReWmRooGg>
 <xmx:lo6PZ20H2fHFoBwNKLsiXi4xm6GyZonuN5goXXbHPo58EIhRZ4lnAg>
 <xmx:lo6PZ8Hb05DooNwFF1pJDtknm1fQu13I8y775t6agh83RUB7oCG14Q>
 <xmx:lo6PZ3-TdnZbSIBJTuc6DmhfR0oJPeGIb-wDsW3vgvcsQDZk8nbGTg>
 <xmx:lo6PZwBK6ALGc8VU547L19vKbvi7wKiWKFdSgNnPjqu_GZevu6tsef52>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 08E841C20066; Tue, 21 Jan 2025 07:09:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 21 Jan 2025 12:09:38 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Thomas Huth" <thuth@redhat.com>, "QEMU devel" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Aleksandar Rikalo" <arikalo@gmail.com>
Message-Id: <f96de148-67e2-41ab-ad5e-23d68af25f85@app.fastmail.com>
In-Reply-To: <b0accbae-b9ca-4fb2-a842-f08ac947ef0a@app.fastmail.com>
References: <20250121103655.1285596-1-thuth@redhat.com>
 <b0accbae-b9ca-4fb2-a842-f08ac947ef0a@app.fastmail.com>
Subject: Re: [PATCH] mips: Mark the "mipssim" machine as deprecated
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b8-smtp.messagingengine.com
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



=E5=9C=A82025=E5=B9=B41=E6=9C=8821=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=E5=
=8D=8812:07=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A82025=E5=B9=B41=E6=9C=8821=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=
=E5=8D=8810:36=EF=BC=8CThomas Huth=E5=86=99=E9=81=93=EF=BC=9A
>> We are not aware of anybody still using this machine, support for it
>> has been withdrawn from the Linux kernel (i.e. there also won't be
>> any future development anymore), and we are not aware of any binaries
>> online that could be used for regression testing to avoid that the
>> machine bitrots ... thus let's mark it as deprecated now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  If anybody is still using this machine, please speak up now!
>
>
> FYI I'm using it to run MIPS AVP (Architecture Verification Programs)
> time by time to check TCG's compliance.
>
> It is a proprietary software so unfortunately no binary available
> to public :-(
>
> AVP has two supported platforms, the first is plain old MIPSSIM
> here, the second is OVPSim MIPS, which is compatible with my previous
> MIPS virt machine effort.
>
> Maybe I should bring MIPSSIM work back?
                        ^ Oops I meant MIPS VIRT.

Thanks
--=20
- Jiaxun

