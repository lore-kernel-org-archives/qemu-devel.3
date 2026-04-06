Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D34F46C53
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9m7K-00036i-28; Mon, 06 Apr 2026 11:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w9m7I-00036O-Jv
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:43:56 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w9m7H-00012N-81
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:43:56 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 34B24140021A;
 Mon,  6 Apr 2026 11:43:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 06 Apr 2026 11:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1775490234; x=1775576634; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p
 0gRn5cEe2Wc=; b=dxAvemeD1a/jYSaP3HRoXh5t1ya1qbtBgPzPYLOhpKY/romz
 CNiiKPR41t0BL8UFUXldZx5tfd/IooZk/fOT06eHDeM0jHkdDCCJFiW0qnU8nECR
 zshHuKFbCfpTCLxr5hDIhPi3P1AfZ8rIP8DmvZiA/AiEOVNfhgmz5SJxgVykVnOJ
 wfJv5+LUZFxkOoqSaavigmJfrLVpLf67U27HFl7IzvcLBlMMdRltvP2jPYLuHr++
 zPoPL/dMkOFCfeiVAU91n/2rprhQIPNjJVIXVRs6hbQykZYijV5T3f9Se/Quc1cw
 Bm6rR/v/n/G0+KBqPgdr8vjrZtddStzweMVgCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775490234; x=
 1775576634; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p0gRn5cEe2Wc=; b=h
 0yGSsC/oWlJvZywLDCLnON+qvpa+eCRjFFqT97sRqTKXJ3Zwy61+f8c1GMEXtuIM
 SoozMIaurF81f0iKDxdyJXKunziPtd6nohkPJoNIaR/WUNi9FZBYOqi1S7w44KP6
 Echg8EkNROMMgo6PXQUS96NhWX9icIdubHxbChjZWl7sMK3AxRTM7SrTSR7iaDVv
 yGHMqGCEPNTY1i7W4lOJJvcHKDwBNBevmtLbvZs8mEpbKyEzDzJxx2VHVN8zzcv2
 Ajyyqs3QHGLZ7cJdYqxbpGoncswvIlpxy1ArRkQ08AlGj3jw3TO86lQplJ68Sixd
 A5UGtndJNmQXJ31vI0BYg==
X-ME-Sender: <xms:utTTadcQQErKUo4PIEf1LI6yFtTPl0UE6IXhfq_4jHJn0VDD3Tqw1g>
 <xme:utTTaddZaiNSmXTG3qCNaigmqO3FaiZkV_GsJKIJExX7r5WrF7vhscBclMr7tEAqZ
 CPejmAnumuF5SQT9-MD_BIPaQirHy7ph7KQjpCgUr82n1e-6Qn9lZU>
X-ME-Received: <xmr:utTTaYxGd9B-uetgBUqa1Z69atirfLiBJ9zUHndME1S-_lFyq84OZf0pKmws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeduvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhepggfgtgffkffuhffvvefofhgjsehtqhertdertdej
 necuhfhrohhmpedfvehhrgguucflrggslhhonhhskhhifdcuoegthhgrugesjhgrsghloh
 hnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepkeekkeefudejgfelgedutdeugfeh
 vdfhhefhuddtkeffudejleeffeekgeeljefhnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhn
 sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilh
 hmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhn
 ghhnuhdrohhrghdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvug
 hhrghtrdgtohhmpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhho
 rdhorhhgpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtphhtth
 hopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopegsrghlrghtohhn
 segvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:utTTac8_6uuElrhwcCpoMM1F6rEDbHHnBNg71s12F96mAijUls_ucg>
 <xmx:utTTaYj5mYRNDz-I2kB82wE56MDj4d751j5CB1g33mruEARTR01ADg>
 <xmx:utTTabHObBfpX8yQchTnfzXxgxMem4oCFNeRKjM2ueo8uG0-d5kGSA>
 <xmx:utTTaf9iDThOkbzyt2cqg-qbiQE90fsweMgbHt52kTrGtKzFhxK8Tg>
 <xmx:utTTadMLA0vj4eh4jSGUpzeyDvZ1QJdnFSIjZxj5V4Il30v7LOkZgb3b>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 11:43:53 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 67185b56;
 Mon, 6 Apr 2026 15:43:53 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 11:43:53 -0400
Message-Id: <DHM6RCZUBGT1.35AC30RQV1C2L@jablonski.xyz>
Subject: Re: [PATCH 2/2] ati-vga: Update mode on CRTC_PITCH change
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Peter
 Maydell" <peter.maydell@linaro.org>
X-Mailer: aerc 0.21.0
References: <cover.1775228029.git.balaton@eik.bme.hu>
 <3f54ff54a873a8f8a0cc5f14660703b4025a69e2.1775228029.git.balaton@eik.bme.hu>
In-Reply-To: <3f54ff54a873a8f8a0cc5f14660703b4025a69e2.1775228029.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

