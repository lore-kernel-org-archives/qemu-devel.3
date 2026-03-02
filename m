Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A1AEA4E22
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 15:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx5Wd-0002Bl-HO; Mon, 02 Mar 2026 10:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx5Wb-0002BK-Ll
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 10:49:38 -0500
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx5WZ-0003H6-0f
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 10:49:37 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id AB7EAEC055C;
 Mon,  2 Mar 2026 10:49:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 10:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1772466572; x=1772552972; bh=cSzixbUqW1BxYabOpRdTX01g9pKxh9ZQ
 OqSJeiHQsBs=; b=Kp5JcVzERYLMXdWXJ182TcOMLiH42SEaLVai8m1CLYub61y3
 F4mswdwqPro2mCn3LnTKdJlnz6jfR07TkulNTuyxO2IPFew/6NadhUr4BEG+XKQ6
 w6gEP+YgmqJDDT8xs7xp7kttLRABhysLZe5OJ05KOKiGAk8jlIZBzp5YkHE3jqzG
 VXi6RzlHXfEWZYPZp0ZHK/l2YNzJvOc9bGIqtfzM7xeQBXJYgQhJuRKNsbSQaMMf
 BtKWlFTL2KMk6Aa+aPPtBNMwaZZTFAMF/7NMKmPxKbW7KTcTJxswPJthJcQIPCYZ
 R3gNoUwtyoTJ7PZTrLfTvb8VkMWNjn+cxumJEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772466572; x=
 1772552972; bh=cSzixbUqW1BxYabOpRdTX01g9pKxh9ZQOqSJeiHQsBs=; b=2
 jpXfaAPUIxW/66k6xQiajhqlP+qDQf/8p7oXXy6rDu+6C81vy8+CoOH6QKIYkhxi
 uWdTU8mqNXcWR91SI/PGendVRzIUsOOJzGSZ3PFIxeZvvF1bL0O0i34ftPqYtyVe
 gAFCL4pGeUf3zqagR7LDJ2IeFQk8nxjeRPfpzCxosEeGrLFJqxm9JaKf9Jw4d0m2
 lLHqoMJ3trWhsQMUHi64hIHj0BDVmiSbyNDE0Xrq1PLyVP+/1iM9/wq38oveWDwk
 SVZDOce3mM97otoKa51aoEHAACF5GkUCku+wqqSQx4/VIWI/i3Ib/O7uCBzAaKcs
 QX/oSytS3H2cnG+zw4PJw==
X-ME-Sender: <xms:i7GlaZS932C-tZeL05DDmotSke4dsdBZIobqXZY9AhoLhyK1XM_7SQ>
 <xme:i7GlaZqWM3sAztIBj-xt-EIQ_jlV_Cx6vnE6tTqN3qXW7N9e7bhQAnskSY_0L1VyO
 QXGazfpnZZoW31cdsVdxeoJViAaWtCzCdPQHWdNLi3HFaAdoqZ7-Jqg>
X-ME-Received: <xmr:i7GlaXIOUNPzUNLF11_dSh6fu6qsoiiBGxibz7vfHe9dgtLXZIRTrKjlrHpO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheektdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehmrghrtggrnhgurhgv
 rdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhrggusehjrggslh
 honhhskhhirdighiiipdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdp
 rhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:i7Glacq8yZiyuMGtqDeijyTA7fxYtDWm7nCQ4FVUuaFQ5Hse1ol4Tg>
 <xmx:i7Glafya0LgWDcChXG4WomeO7lm-wxVbicytcuBIVQPawiN28ETpPg>
 <xmx:i7GlaQO_XIicPTI52K7fCD78rZ5W8WW-LxB3A04ZqyvivQC07nUl8g>
 <xmx:i7GlaU5OF2oF4iFSK_c9dPLX48G8I6MDgskg_vv1VhNVGaujWtIiPg>
 <xmx:jLGlaZH07DfjVp_1Jd07VnmMXyTXdY7O_CA8CWxNxuNVy-EVTkniY5za>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 10:49:31 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 209f4006;
 Mon, 2 Mar 2026 15:49:30 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Mar 2026 10:49:30 -0500
Message-Id: <DGSEYLNI8QYM.H1MSRR2IWS1F@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v9 17/18] ati-vga: Implement HOST_DATA register writes
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260227203944.746471-1-chad@jablonski.xyz>
 <20260227203944.746471-18-chad@jablonski.xyz>
 <bacdcf5e-6382-734d-d29e-c1ec435f5572@eik.bme.hu>
In-Reply-To: <bacdcf5e-6382-734d-d29e-c1ec435f5572@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.148; envelope-from=chad@jablonski.xyz;
 helo=fout-a5-smtp.messagingengine.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

>
> I think these may not be the best constants as you still do a lot of=20
> calculation with them so maybe it could be simplified but I don't know=20
> how. If there's no visible difference in output with normal usage only in=
=20
> corned cases that only happened during testing then maybe it's too early=
=20
> to try to implement this and we could go back to the previous 128 bit=20
> accumulator unless you found some real world usage where this would=20
> matter. Otherwise I think this would only matter with a concurent 2D=20
> engine where host data writes could continue in the other half of the 256=
=20
> bit register while the 2D engine does the operation on the already writte=
n=20
> half. So if we get the same graphical result with only storing 128 bits=
=20
> for now we could do that and rething this when we can run the 2D engine=
=20
> concurrently.
>

With well-behaved drivers there should be no difference. The only real
behavioral difference I've seen is when host_data blits are ended early.
I have tests covering this behavior now and it's documented so I have no pr=
oblem
going back to the 128-bit implementation for now. If we do run into real
drivers that depend on this we can always easily resurrect it.

