Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B3BD13C32
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOTq-0007L2-VW; Mon, 26 Jan 2026 10:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vkOTp-0007Kg-OM; Mon, 26 Jan 2026 10:26:17 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vkOTm-0006sv-Ek; Mon, 26 Jan 2026 10:26:17 -0500
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 54D66140002B;
 Mon, 26 Jan 2026 10:26:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Mon, 26 Jan 2026 10:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1769441171; x=1769527571; bh=lBted6hgrYpjkGwRyfvCpEje8EFeybv4
 /h6AKDUJ2nk=; b=riUoj53a4uJbZRoFRSmoBUh1oRFvzEikkQ31gM92lZ24381z
 Jeq8uvnLXMZbj4HtqjHmZTPw0WLS/EmiOjeHmaxEziDErLy18TZTcZyuT1J4H/ZE
 liDW4+4NVy0mxURCXuBELsbiLR5P1DqrzTrUAmzEUW4QJeHTBiAEr2Yx3Mc20RIa
 d5/wCDsOzmsRvRXuRgHr10rWxUjpP1+mnn/9YPLa5KKx6yjpfGOmOi5cLQBE0sKx
 aNtxTgAapqrh2liussb33jkXXTfF7WVIQtRVjrIFAdBXea4+Tq+ZWBaqZErYPlE3
 6My4BRc+dGesjKYLtesc74rKQOaodK0K29fqVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769441171; x=
 1769527571; bh=lBted6hgrYpjkGwRyfvCpEje8EFeybv4/h6AKDUJ2nk=; b=X
 JVhJarEa8pn9ZxisMf005N5V1Kj5+JqbX8U6yXFqXAvj1aASs4CiyCqQ2zdx0QD5
 7kyVHjadkN1OOb285r/cfnpZms5oxX7Au5Ly+MQviU6p59ai7Rr8UrXXFXlxHBg7
 pFF8aC27i6iLXDCpSlwy18Ur7WnCftT/vUuxUEpnG/QDBFpjmgJqWl6hNnM6Xy8J
 PJn5b4TnQWle2CVXjFQHu+0xgyVa3LRo6ox9dxH1MhEWstWsw1Y7ugE3mySplU67
 HDn+WOER3Ul8c9c2BV2elPTx0MY0AlsRlPhMMOd5Iy11Kf0p1+QjItnRU+uF3NC4
 k3CrlGsDLPrjOOgebTuDw==
X-ME-Sender: <xms:kod3aYLqzamc2zecRw7dXY2Ss6U5MrvfIlwLF7pzTbK-tB2S9mHsUg>
 <xme:kod3aSuzH6fZPjaB7OkFXczvfPor12b0hmljjxJS3jdHxxcnm0ZO0qZHXwS01qoMy
 Uex3syKdbzYz-WYkrISzBknDWCgE0CR0Y4w1HgNpNECHa6sEs41khFD>
X-ME-Received: <xmr:kod3aVT5O_LCCasnfxpcjkvHx8B5GlrDv4iBjg7aztOLYLKROZeib1vYzmDZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheektdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkuffhvfevofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeekkeekfedujefgleeguddtuefg
 hedvhfehhfdutdekffdujeelfeefkeegleejhfenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlqdgsohhunhgtvghsodgthhgrugepjhgrsghlohhnshhkihdrgiihiies
 nhhonhhgnhhurdhorhhgpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighi
 iipdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtohep
 qhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:kod3aYPWO2T3ePpBt0ZSQls3c0KvMpYrtQRKr_VJylZA9-vmLWvh0w>
 <xmx:kod3aaZVjhnXR2m12w7Enf9XiYb94afUIZvR9jHqRDEWKdu4Yn_ZVA>
 <xmx:kod3aSyvgDNQ3lEzU70_rrs3bj8QDVS3hfq6GXA52qs38WiM1ltw8A>
 <xmx:kod3aVIE6Uoj4e9G6oGhHgbJlOjJ1FqHqKKgVVgXzebw3s3xp09vAA>
 <xmx:k4d3aUyAzaYanrj87jEn7LfRYEREJ4xpUqP6CCPhCIA6kuz686WRmKXy>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 10:26:10 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id df0ec4c4;
 Mon, 26 Jan 2026 15:26:09 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 10:26:09 -0500
Message-Id: <DFYMJNMCJGVU.1VNVU1PXZZWQR@jablonski.xyz>
Subject: Re: [PATCH v5 06/12] ati-vga: Create setup_2d_blt_dst helper
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260116024258.1487173-1-chad@jablonski.xyz>
 <20260116024258.1487173-7-chad@jablonski.xyz>
 <e81ba5b9-acbe-5fb7-6fc0-c31e3c3dd601@eik.bme.hu>
In-Reply-To: <e81ba5b9-acbe-5fb7-6fc0-c31e3c3dd601@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.152; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
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

>>
>> -static int ati_bpp_from_datatype(ATIVGAState *s)
>> +typedef struct {
>> +    QemuRect rect;
>> +    int bpp;
>> +    int stride;
>> +    bool top_to_bottom;
>> +    bool left_to_right;
>> +    uint8_t *bits;
>> +} ATIBltDst;
>
> I'll need to look at this and further patches in more detail but I wonder=
=20
> if we need separate types for BltDst and BltSrc or could we use a single=
=20
> type for both maybe not using some fields for Src. But if that would not=
=20
> simplify things then these can be separate too.
>

I do think that we would end up with unused fields in some cases. To me
this mapped well conceptually to the ROP3 operations. For example the
fill operations won't use src at all. It's possible we would even end up
with ATIBltBrush or similar in the future. But definitely open to
changing it if you feel strongly after looking at it in more detail!

>> +    ATIBltDst _dst; /* TEMP: avoid churn in future patches */
>> +    ATIBltDst *dst =3D &_dst;
>
> These will be removed but names beginning with _ are reserved and should=
=20
> not be used so maybe this (and _src in next patch) should be dst_ or=20
> something else? Can the churn be avoided by reorganising changes or movin=
g=20
> converting to pointer in a separate patch? This patch is quite long and=
=20
> mixes pointer conversion with other refactoring so separating those may=
=20
> help in review.
>

Ah, yep, renaming the _dst and _src makes sense! As far as the churn, as I
look at this again I think it's primarily because there's an inconsistency
in how the register values are accessed and this is attempting to unify tha=
t.
The local variables become struct members (e.g. bpp becomes dst->bpp) and s=
o
do the direct register references (e.g. s->regs.dst_pitch becomes dst->stri=
de).
Whether dst is a pointer or a local struct doesn't change that.

I was thinking we could initialize the dst struct and then assign the local=
s to
those values to avoid churn (e.g. unsigned dst_x =3D dst->rect.x) and anyth=
ing
using those locals wouldn't need to be updated. But then the problem still
remains with the direct register references.

Another thought is that we could first create local variables for each of t=
hese,
even those that are currently direct register references, and do the replac=
ement
in the function. Then in a separate patch assign the locals to the struct
members. The locals could then either stick around indefinitely or be repla=
ced
themselves with direct references to the struct in another patch.

Do you have any preference, or maybe even other ideas about which might be
clearer?

