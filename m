Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3331BE6BF35
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 18:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vltOn-0001eG-Ea; Fri, 30 Jan 2026 13:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vltOj-0001e1-Qv; Fri, 30 Jan 2026 13:39:13 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vltOh-0005VU-Qg; Fri, 30 Jan 2026 13:39:13 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id C925B1D0005A;
 Fri, 30 Jan 2026 13:39:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 30 Jan 2026 13:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1769798349; x=1769884749; bh=zl/q46758wUIodpI8mSYR8Y+Mkcv1HIt
 PJlNPyaewuY=; b=Xj1CCmQEblAW8aOod2uYjVTQuzKGizWcnuxCLtH3lukXagSO
 bz+ef8lktV6ZndX8B4W/WK5DaO9brct1k7o0DBLUuS1AHi+r3FwRtgumkGDX3lbR
 AIhlLlgQebg90ALbgfj1abFYhKRBbqoEKRAuWucTVM4DJ1UCbh8xKH2W9GX3yksW
 bJUxOEQ9boslwTI8Wsi01kZdQIWbkgFFiInuLhx6QxZ0w/6D2SFA10hWfa0tAmfz
 0K/83Z5SD/HJFNqC8vfPiyU+EROz64Y9oyVnczQSWUjyOVv/unnLCcMM0kF5qBlg
 ciM//xENCOXy0OC4gCrI8/D3SbwKk7gp4MSRxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769798349; x=
 1769884749; bh=zl/q46758wUIodpI8mSYR8Y+Mkcv1HItPJlNPyaewuY=; b=g
 IR69yt0rUoAT1Gfesdfq7UFQFjLSRoOCf271HxoCqA3eOa0LRVUHEUljqIw4igXS
 cqcb1beIxnSjlZWnAGNS5o38c5P8B7xuNQ8kDqdajeFSfwG1I1cbt+BpMxGcP05q
 IbhK2LMVPkEb8Ni3rOkUTmSSEJT6z7X4Jx8CeMr/xbEySGsIPDtiCSvfS6IdgDjS
 kHE1Hr+u2V1qnbhCeECllpKHymzy9X21buCwmrSy7K1wfiKE4GqdZA7VNqq+kf9p
 sfX2n30GvzdOOYdefxcvQh1iK+omaUO+MEAwAXuxoy58NqHmQwutwViQ3qxluJhy
 qIWbkIuiVPqwQISvneUvg==
X-ME-Sender: <xms:zfp8ab7aVwZ-RCB6O_7mwQpZlBHigVQN99zpSGFar9uZ2mXfGNTiOg>
 <xme:zfp8aX6XRXAPrPWUWyxnzj4LW5Riuruiz2XL_k0UyqngbOZtD-vIKDObeQcl7HMUY
 At1kiUB_JPJEfR2vh2g4iOvTelhEmj5nF0Kmz8zX__uvjjDpArafqY>
X-ME-Received: <xmr:zfp8aXfCzq2y2NEKsAvlSLF_VC7y0Anm8Mnw6LTE0dL_S5104q9M2NIumNC3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeljeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvfevuffhofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeekffekuddvtdehjeduhfekteet
 gedvfeffieeugfefffevheeggfdtkeeuteekteenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrg
 gusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehn
 ohhnghhnuhdrohhrghdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuh
 dprhgtphhtthhopehqvghmuhdquggvvhgvlhdqsghouhhntggvshdotghhrggupehjrggs
 lhhonhhskhhirdighiiisehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:zfp8abDEkxRE_vXIUlzi2NYo7PbKpudQEldIbSRIZ7cweoVjuzIsbA>
 <xmx:zfp8aa8UIiXCvpkCm9RlKQKsx1YSA4yU6l36lN46M1JBYbbCl8trEg>
 <xmx:zfp8aWJWApAr0qHc6mzpQDcZwrZc9uhPRJDynquVfRvvb7QkiosNvw>
 <xmx:zfp8aTjn3ZCXMk9qCZUX0j_8OJxOVgRsttKAXuHoe8zqrGoNcSWfZg>
 <xmx:zfp8aUBc8ivT4Vn9FPYZq3yI89CNDYuqaWZS6zJ3CPej1gkQK_2Ayfk6>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 13:39:08 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id a3f62bc6;
 Fri, 30 Jan 2026 18:39:08 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Jan 2026 13:39:08 -0500
Message-Id: <DG255L1QLG9F.K2BWVSSGYRHG@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH v5 11/12] ati-vga: Implement HOST_DATA register writes
From: "Chad Jablonski" <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260116024258.1487173-1-chad@jablonski.xyz>
 <20260116024258.1487173-12-chad@jablonski.xyz>
 <3d1cf407-dd57-edff-25fe-1dd56c1b5052@eik.bme.hu>
In-Reply-To: <3d1cf407-dd57-edff-25fe-1dd56c1b5052@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.149; envelope-from=chad@jablonski.xyz;
 helo=fout-b6-smtp.messagingengine.com
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
>> +static void ati_host_data_reset(ATIHostDataState *hd)
>> +{
>> +    hd->next =3D 0;
>> +    hd->row =3D 0;
>> +    hd->col =3D 0;
>> +}
>
> I wonder where the real chip keeps track of these. Isn't this where the=
=20
> dst_x dst_y would be updated? Or it may have some internal state not=20
> exposed as registers? Maybe if you can dump registers you could compare=
=20
> their values during blits after each host data reg write and check how=20
> they change to reveal if any of them are updated? (But only if you're=20
> curious; it would do for emulation using this approach with a separate=20
> state as well.)
>

So far it's looking to me like this is internal state not exposed
through the registers. I do see one register that increments after every
host_data* write but it's in the PM4/CCE range (0x07e8) and is completely
undocumented. It _is_ a bit surprising to see changes in that range given C=
CE
is disabled. But nothing really obvious or conclusive yet, unfortunately.

