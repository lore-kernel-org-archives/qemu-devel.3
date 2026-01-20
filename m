Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4FFCCF9F5
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 15:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viDqC-0002lz-FU; Tue, 20 Jan 2026 10:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1viDq5-0002hK-8a; Tue, 20 Jan 2026 10:40:17 -0500
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1viDq3-0000xO-1y; Tue, 20 Jan 2026 10:40:16 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id D1AD3EC0276;
 Tue, 20 Jan 2026 10:40:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 20 Jan 2026 10:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1768923610; x=1769010010; bh=P1HY7o/W0cCXVSKnbnWza4W8wTojK2TZ
 wcdlrxyueVc=; b=fB3j99rqX9uVMcf07W4Eh3LSt04kMGlRTiD2WAFn7QQnUVFh
 54P2spCBxFZdxXhrXfRunVWP6JIYg7Jj1w/piSX+/hCqweQF73ftOEryPhfbwDoP
 8SNoH0MKxI793tjsn8WlITJ/QwfUKR3OTJBNEBiPPyn8B3bohi7mZGQJRvVBc4W2
 H7U89/HwtHxCw4JNdybJ216hTr+PHh28WpbWQCIgY8w09FAwIAath7rZcdnj/DNW
 geR+LhYiJEAFnfLef9w1vojlrFZ1ODuPX4+sifJpQetWvl15pAkyu2ZLktnqNRIs
 MIho6wHVBs4Yh8BCRCbaMurPHQvbAGT5s/cwHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768923610; x=
 1769010010; bh=P1HY7o/W0cCXVSKnbnWza4W8wTojK2TZwcdlrxyueVc=; b=k
 TRh5IpVO98rp/UxjU9n0aZtvVISPkD2JrQRN9PDPuarF99tI/9uVziHiobkzpVUz
 daBd1yNnOK+5jtf4omIgtlOVNfVQQHve9aXlC86vMxBWcyU3J0p/PBwf81jCifVA
 L47nlqeuLTJKJqW6Z6xFYE+yjNd9yjd5YfQzVCvdxCofLEoWrFmIHqmbkD2DIbeb
 dB9/cx7WFB6iRTE0meZQHzTwSy6v3Yo+yHZyyupdtlDIe0EUm1cI2hXAk8Gx7KFj
 XjGeKfYWFbfxtCCrSM6l/LxyBY1/5/V7rBdDdH5eBtqgMMgwsMC1lYTSf8zrXaqX
 9MlBrIIoXhz9RwSeValkw==
X-ME-Sender: <xms:2qFvaTYiEYcfB6XCp0cITZtzrbh4Czlh1o4Ep4epl1xUxIO_WWVxVw>
 <xme:2qFvaZbV_qfVehcUSUxv9HWw9ludXS_8JBhCRZkjlvXfXjKE_pqsX-Ul213YI3Uq8
 JUiQJNQeiuhCtISLqGeSIuRuaT9G_fJR5G19dE8-Ci1zWFqxCnAs9I>
X-ME-Received: <xmr:2qFvaa_Cl-Pbe6fOf8eVMjLeBJEcZliTw-9UXu4ecVtC0o-Ale1L3BmxalAD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpegggfgtff
 fkuffhvfevofhfjgesthhqredtredtjeenucfhrhhomhepfdevhhgrugculfgrsghlohhn
 shhkihdfuceotghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrh
 hnpeekkeekfedujefgleeguddtuefghedvhfehhfdutdekffdujeelfeefkeegleejhfen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrug
 esjhgrsghlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpth
 htohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtohepqhgvmhhuqdgu
 vghvvghlqdgsohhunhgtvghsodgthhgrugepjhgrsghlohhnshhkihdrgiihiiesnhhonh
 hgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhr
 gh
X-ME-Proxy: <xmx:2qFvaYgs-1SgVo3wiyLqRiFbFUSGDCqoWwtYyaacHNSQ7Yqi2nuNMA>
 <xmx:2qFvaadblYOm6qBkRv72Tlqv5V_NMjH4YJrTtgzMHm8K2PK9OOGwww>
 <xmx:2qFvafpdetXJsRT_E6psJLIjITMdXphQx-0AvF7JjMNAulXUGMG-uw>
 <xmx:2qFvafCy68sr6CVeVJ28njGgvvFQwRLoZnrrsHPO8FM_z3SOR5KDWA>
 <xmx:2qFvabi2aNrptGv2XpFa-sYt6i0yTioMY6N90_3Ncx4LCpPuV0m8A3KI>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:40:09 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 47040446;
 Tue, 20 Jan 2026 15:40:08 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 10:40:08 -0500
Message-Id: <DFTJ3349306M.92OK2QAQPN6I@jablonski.xyz>
Subject: Re: [PATCH v5 08/12] ati-vga: Consolidate set dirty and dst update
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "Chad Jablonski" <chad@jablonski.xyz>, <qemu-devel@nongnu.org>
Cc: <balaton@eik.bme.hu>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260116024258.1487173-1-chad@jablonski.xyz>
 <20260116024258.1487173-9-chad@jablonski.xyz>
In-Reply-To: <20260116024258.1487173-9-chad@jablonski.xyz>
Received-SPF: pass client-ip=103.168.172.151; envelope-from=chad@jablonski.xyz;
 helo=fout-a8-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
> I plan to validate the above Radeon behavior in the future but I don't
> have the best test environment set up for that card at the moment.
> Zoltan if you've seen the dst_x behavior is required then we can modify
> this but otherwise it felt safe to me to follow the docs for now.

Just an update on Radeon (R100) behavior. I've confirmed in my testing that=
 it
also does _not_ update dst_x and dst_y after vram and host data sourced bli=
ts.
This contradicts the m6 register guide.

