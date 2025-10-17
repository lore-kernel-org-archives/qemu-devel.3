Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568B6CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 14:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9l1l-0001LS-Fi; Fri, 17 Oct 2025 10:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v9l1i-0001Kj-Ay
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:01:51 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v9l1Y-0004JZ-Vr
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:01:49 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C60DB7A00BA;
 Fri, 17 Oct 2025 10:01:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 17 Oct 2025 10:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1760709696; x=1760796096; bh=cBGamWSTg+YBKKXQG7s45tKiM9KfBuFN
 Tp2mqzv5bFI=; b=qjZS0OfV0G5vXN8CklLSIam2vYjJ6Py3iwdHUloxP2nJdXIw
 qrdMo3ZNDdgifvon4/yxCJV8+IX30t+A+t1bl+XSzoQllQquYo1Hd0R81bUwZpIM
 t6aGiLLWHHpEZeNI9fASBx9GYApR50ulQZ/ibyHp50sLlLlmwYfLHeh2Ia+nUP+Q
 HhLqCYqLT4i5XCjJpPEiys1gL24r4kcrysW2JIwUwOGY1OK8zlGkyhGsb0BZoLG8
 u8HQy6xhjBxvFf2GNok6YIS1+AC/PZOTcqUjfROwZdXRfLuHmevTjY8SklZZSEqx
 cZh6TXQMsQriYien2BZZtLphfsokiSTItANh0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760709696; x=
 1760796096; bh=cBGamWSTg+YBKKXQG7s45tKiM9KfBuFNTp2mqzv5bFI=; b=y
 K1yA40snlGicltjb7jRgO9mEFX3xLJfuNhdJ2awqk8wZ4u1hPwfDxeztMtzEFRc0
 hlWYXMjDQ4Thksp7j+VNFY0rahyM9ss25zBiz57EH4zYXiPxytEE+2DNd0BoMWcE
 oi6hKJgzeduejgnhhd0J4KfuReVwodxMcaLnPaqs/XNZBTar/mt6Hmya9jWYNz2i
 xO2SveOhLEz5+1+2Bh+LrGQrA1gELriKI/+HdteUcXyKWeIy5nuQzq0iY6hoAdMY
 BNDg4W0HldAnjbeblv1kTC2m6cXdw8qJJuyh+Lo5+DBdmpsoboGqJNGTA0kv8Bw+
 l4B+A+slqa8kec1F1dwiA==
X-ME-Sender: <xms:QEzyaGtGa58EHYGtkmjIC9wieh3ELNF8tIIKHW-aRUAUK-X350eZxA>
 <xme:QEzyaCUEwhFWYSpliHUCHs4YB8zozoC3ijp9SGbTnJ1Yx_Z5I3f6Grg_7jXql4UXn
 -7_3KzNP85GWvTeYQyQVc3l4eLm27otosqSh5lqoKNvYdAfWL3_XJWm>
X-ME-Received: <xmr:QEzyaKGUg2oxlUhsz9bBCccmSG3RNa-h5YsajGft99CxyPwrhu5lSP76e8s7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelfeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrrg
 igvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhk
 ihdrgiihiidprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtph
 htthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghp
 thhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:QEzyaM0YnLlP47moIX1BmrtwmTfb2fc3JxqQ83qGFFc9i7LI0WKbzw>
 <xmx:QEzyaEN60B10BRmeX2wLdvn8rRiQX3g9ZAUJMILwkljQAw3ZQfWnJQ>
 <xmx:QEzyaD6aXNPTfYhLN8Tj9kY5h4rplMvZY0WN6CDOEicrn-ADOTueWA>
 <xmx:QEzyaG2oYnzZgeGKH733D-wrjbItde7WbqTX1Uyd2TfwTonOxNMPCQ>
 <xmx:QEzyaAyuxE0GCkFt_9j2-mmMVtTNk43U5pJO93gGVybjhS3wFScX_vLX>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 10:01:35 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 9caf9ab3;
 Fri, 17 Oct 2025 14:01:34 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 10:01:34 -0400
Message-Id: <DDKNHVF2WXKI.3L940C12AL5T1@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <kraxel@redhat.com>, <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2] ati-vga: Fix framebuffer mapping by using
 hardware-correct aperture sizes
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20251015173716.1764461-1-chad@jablonski.xyz>
 <55dc6bce-c965-2202-f61c-d6bfb2d64820@eik.bme.hu>
 <66a869c9-de72-1c1a-0413-3366cecdef7c@eik.bme.hu>
In-Reply-To: <66a869c9-de72-1c1a-0413-3366cecdef7c@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.155; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Fixing all of these and sending v3 shortly.

- Chad

