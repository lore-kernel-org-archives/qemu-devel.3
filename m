Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2867AD68BC2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 23:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW0X1-0008Uo-Sx; Wed, 17 Dec 2025 18:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1vW0Wy-0008Th-RB; Wed, 17 Dec 2025 18:02:05 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1vW0Ww-0002UN-8v; Wed, 17 Dec 2025 18:02:04 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1A1C81400109;
 Wed, 17 Dec 2025 18:02:00 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
 by phl-compute-04.internal (MEProxy); Wed, 17 Dec 2025 18:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=trainwit.ch; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1766012520;
 x=1766098920; bh=/4lkz2Dr+wnLBNubSA4eO5YhKgzx08Vdptl/tHrANIU=; b=
 K38xzxkLwgLlDUCd1GUD5STm6SlP3V8ZDNGAo8RXlIRvnBc+6LAfUH0hN/XYoD2j
 T2p9L7ar5CuvTuViin5761AqppsKR/bwkyvtsX7/6DDQvcz7MEBso6Ty/B8BSPLn
 T79vMWqFEpK+RDlcza8h1N7ocfNpfN78+BPQu69WMnldT+c3LBu0hKivoqws6x9D
 cuoFHkOAzTHQDJN/KDFFB/3n99yCmrDpa/K0rJffCZzxfF5mzSiVSgiN52oP+N0Y
 SUFOJxRUNaAtL4+hCnZvMOc9UVunsPFcGxd+c3C7zsLE3mKyCsto1a11oEEa5yHp
 j1kRAk5FftBNS8DJbIC6bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766012520; x=
 1766098920; bh=/4lkz2Dr+wnLBNubSA4eO5YhKgzx08Vdptl/tHrANIU=; b=K
 6qrwOn2zeRCOFbEiY0kXeIq8GC+dWV6DPApVwY4CSzxudoWMQkQeohhnW5DU+MsO
 Laoy0G9MYmQGhs70Wq7l8G6WuSBXhBNZ3vpCjACzNmyCVV+uvmB8thdRGJ1BBhua
 IKtP2Al1kl+VN/XrPVmSjCPHrGGFNkpWfdIF7gFbHNghKJn+SiayMsYt6r6pEWnp
 POZGV0qKHFk22qoqfmw3SyAJ3tLbLhe6L/aXQYPQg1lI/SEfWsog3z7lTmRyM9uN
 9CMPtGO8gNLNq6zE3R0xBEFPxd8MfSqoGtB25mbR6oYfnYEIFC4qYDMc7tO3Hxdg
 K4UzMej7oW3GScuaelYWQ==
X-ME-Sender: <xms:ZzZDab8V7Wt9hkaaannGTMglYVgDSvs9YcYtv5jpwEhaFJJWNv8Nww>
 <xme:ZzZDaSiwHn-fyfCFt9G6CVdVGdcWZOGyRAlOFjSjZz-BCDp33N__HeZi6tYLBahXF
 86oMM4l0Ywd6600LePhseE_0ySuEwP_D2h6zDIJ63iMMlB2ddjN8JE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegfeekfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdhjuhhlihgr
 ucdlmhhiughnihhghhhtvhgvihhlmddfuceomhhiughnihhghhhtsehtrhgrihhnfihith
 drtghhqeenucggtffrrghtthgvrhhnpeegleehjedtgffguefhhfeujefgueehkeehueef
 gfeifefhudeitefhjeelkeekkeenucffohhmrghinhepghhithhlrggsrdgtohhmnecuve
 hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhiughnihhg
 hhhtsehtrhgrihhnfihithdrtghhpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
 hpohhuthdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhr
 ghdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepqh
 gvmhhuqdgrrhhmsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrg
 husehrvgguhhgrthdrtghomhdprhgtphhtthhopehpsghonhiiihhnihesrhgvughhrght
 rdgtohhm
X-ME-Proxy: <xmx:ZzZDaWSKH7ruR6AdDvfkLe0W4tDXafLqwUYgglwUir2V0IMwWi2VIw>
 <xmx:ZzZDafcFZdniMQEIJi7CjvzdFJtHIobNW2cmO-V0nJjtkSy40tiMHw>
 <xmx:ZzZDadrO1k2LLFnzS4jZwnWYglbNU0RUjTy6mQoKsz1HeoHaL_OKLQ>
 <xmx:ZzZDaY9eM8N-e5tq6Tc5PWL_PyzfqMKinQ_nwf1snTV9dclTpwxLYQ>
 <xmx:aDZDaZw7ulK0p5Nx8gDl4BUAj9j2ubbx6TJYNcjDCYzDdmnYxiK02u8k>
Feedback-ID: ib36e48e7:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 9A9A92CE0078; Wed, 17 Dec 2025 18:01:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AY8kgBHH1kaR
Date: Thu, 18 Dec 2025 10:01:39 +1100
From: "julia (midnightveil)" <midnight@trainwit.ch>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Peter Maydell" <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, qemu-arm@nongnu.org
Message-Id: <9d4cc1a3-0baf-4c89-8de1-5998c35693d8@app.fastmail.com>
In-Reply-To: <3c5328f2-f8e7-4154-bab5-e80f46306aae@linaro.org>
References: <20251217-cmsdk-uart-disabled-warning2-v1-1-847de48840bc@trainwit.ch>
 <3c5328f2-f8e7-4154-bab5-e80f46306aae@linaro.org>
Subject: Re: [PATCH] hw/char/cmsdk-apb-uart.c: log guest_errors for r/w to
 disabled uart
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.155;
 envelope-from=midnight@trainwit.ch; helo=fhigh-a4-smtp.messagingengine.com
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

Hi Phil,

Interesting that that's the case for the PL011. I've run into situations=
 before where turns out it was never enabled and it was still printing, =
discovered this after turning guest errors on. Do people usually run wit=
h guest errors on?

At least for this UART it doesn't print until it's enabled, (and if you'=
re checking the TXFULL bit then the guest is essentially deadlocked if p=
olling), so that's not an issue.

Julia

On Thu, 18 Dec 2025, at 01:59, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Julia,
>
> On 17/12/25 08:10, julia wrote:
>> I don't want to admit how many hours I spent trying to figure out why
>> nothing was being printed (as the enable-ing code hadn't yet run,
>> even thought it existed).
>
> You are not alone, few of us have been there too :/
>
> This is why I added this commit for the PL011:
> https://gitlab.com/qemu-project/qemu/-/commit/abf2b6a0
> but it had to be reverted, see:
> https://gitlab.com/qemu-project/qemu/-/commit/5b14454d
>
>>=20
>> Signed-off-by: julia <midnight@trainwit.ch>
>> ---
>>   hw/char/cmsdk-apb-uart.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>
> Anyway for your patch:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Regards,
>
> Phil.

