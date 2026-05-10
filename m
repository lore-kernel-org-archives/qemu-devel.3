Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFBCCD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 01:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtBQ-00033K-3o; Sat, 09 May 2026 21:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wLtBO-000333-5r; Sat, 09 May 2026 21:42:14 -0400
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wLtBM-0003Zm-Md; Sat, 09 May 2026 21:42:13 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 22F2F1D000AF;
 Sat,  9 May 2026 21:42:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sat, 09 May 2026 21:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1778377328; x=1778463728; bh=3WAumMk0sxq89DgD8sv+OkF3ZvrA6gT3
 EDSzK52GKT8=; b=P2gZdrfZolysC4qDnHMuAAYU9MutDeRsM/wyaesHdxeqDHvZ
 fcQM184yNWrTs0jglzl9k6n76fqwLIE7Clv5mBEYAI14RlBoI82lpeTvX9ULkGaE
 c+upz0+LrPmlSY/g3QoZ7XQZ3XfXe6JIFv98NBw/Eio4kF1QAOpqDDl6tvm75fMy
 krstyTQSblva8f6ZyV1zECeClY6AlZYBH5+SZehZ+BlYJxE6uahRAOHRnMO5MzXU
 WhG78T/oxsrMVuibqujBYwHzrbqCuALu0xOfDbktAb86Gz5syNibIi33CgYCtbtP
 I4QmsrM01imkblOIklj/JLtminpGHNGhrwxb0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778377328; x=
 1778463728; bh=3WAumMk0sxq89DgD8sv+OkF3ZvrA6gT3EDSzK52GKT8=; b=s
 0hPvMNIcvPQ1ZIf404ZbzRcaN2z7MjYts5ZioyXlSnHS57LHilsX6lKCraz/naSd
 0qTkIRuxZDXTVUwXYBb74POQWW4vd7hLOpFi/BCCfdKc1Mbic9SuZj5TXrgEfsEt
 QN1K2FQ2hJuJkpJFWVGHdLwnTWm0ihF0qtK+E4TdU0ZIh99BGyAIgZxu+nJoj1oQ
 MSEe2cS+TEQOhWes1uEhUC7BBUgAQ48GCYqpohhj8uMSH2sG6fkuHqxWQQSC9p3z
 NAJOOlSjrWKm/1riNZgEdJQip+/KoR/YmeXKLF8Q/SOqhsU+JezeeMrVFS3jGThY
 x7ZmdG8E53iSNRfouvLQA==
X-ME-Sender: <xms:b-L_acouLI2nwwWmEL-33jz1SInkWntRFNxZpFvS0SuiGEry2WwJfg>
 <xme:b-L_aU5s3xouYaxLLpqw-vagDsSbCA_XZk-yj7gFRMEyXozrU8BT_1FXdSjuwOyLj
 IKPGB3L_CXTqkL08gnMYPPFA58UtuXLgemvEIsTohKbK1J0pqAzhAA>
X-ME-Received: <xmr:b-L_aTcNm5PvBdva83VevXr2oa2ry4HGukEEwM53UMZg_nzQh2KlEvlEVJ8t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegkedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrg
 gusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgrthhonhesvghikhdr
 sghmvgdrhhhupdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtph
 htthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepmhgr
 rhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomhdprhgtphhtthhopehphh
 hilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvges
 nhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:b-L_aZ54R5YkZFVhuZ1GBc6BHvP8XOucWQCpJjABqrOD_QO8XWd4fQ>
 <xmx:b-L_aasjKbDJo7_EAhCsXdzJjWjzYrZEu1_eSebHEJIigoz7674SaQ>
 <xmx:b-L_aZgxgXUmxl1wt5tThtRpaTiwmhXwpgpMuNNRS2DXYD5h7ZxnjA>
 <xmx:b-L_aVoJixYpO8syQZVl4CzNIGGc3pSkPEe9O_mNYAtnpnVAe1e3JA>
 <xmx:cOL_aQK6bVSh9hMVZbMFaBmupTOyX4tlnz7Uhm782XfnWRre_CACsMmJ>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 21:42:07 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id f6f7d29e;
 Sun, 10 May 2026 01:42:06 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 09 May 2026 21:42:06 -0400
Message-Id: <DIEM5D5TZCT8.220EX775JYH3F@jablonski.xyz>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH v3] ati-vga: fix ati_set_dirty address calculation
From: "Chad Jablonski" <chad@jablonski.xyz>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "BALATON
 Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260506153920.C6B27596978@zero.eik.bme.hu>
 <e454a3c4-5d9c-4482-9f99-553f799a6d39@linaro.org>
In-Reply-To: <e454a3c4-5d9c-4482-9f99-553f799a6d39@linaro.org>
Received-SPF: pass client-ip=202.12.124.149; envelope-from=chad@jablonski.xyz;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Thanks Zoltan for the v3. I was away for a bit there.
Glad to see it queued. Thank you Philippe.

