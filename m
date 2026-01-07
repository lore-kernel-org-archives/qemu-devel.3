Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F999CF6BE2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 01:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdIip-0007Bn-L4; Tue, 06 Jan 2026 20:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdIim-0006oF-Sd; Tue, 06 Jan 2026 20:52:25 -0500
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdIil-0002HL-G1; Tue, 06 Jan 2026 20:52:24 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id CE929EC0248;
 Tue,  6 Jan 2026 20:52:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 06 Jan 2026 20:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1767750741; x=1767837141; bh=++tw6hUVbJD9cn5+3rUbGOqqV/Dc6VjL
 ise8HRaW06w=; b=A18/yN+WWAAhhXPiTVTlirO/pSBsnSug1Vn2O5tJEO9fEKJ9
 g/qvj6YaPpL+bDAZD9UxTxdvQY5NiMDWo+M5bMd8lQwiiPA3b4Od+YenWqZ0Fdrc
 qi+fiduzC3HoSVbiBJbU1xVeg99VRVRDJvOkayxe44rWS7pG8XvFtOHTJwo/fDIy
 bsJibIv17E/stknu9JUSoAI+unxYbKiFsh2Dnb7JBwgIHNaxWNduKv2n1FSgZj7v
 oJkRmhdQ5+/TBLUjt6tP6EpWSTWuADV+O35bG2aJZxYrruCIsNke4U3VMMAP+gkS
 Gjf4982Kvbga/sQBC9rW02Rx9uJBQKBys/h8qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767750741; x=
 1767837141; bh=++tw6hUVbJD9cn5+3rUbGOqqV/Dc6VjLise8HRaW06w=; b=g
 NnxiDz1/WeEuaARp6MEjYZ4/gUWZkajGjTi+R/ZLCYZPfW+AIyzCuDO983ARnrg/
 1XqVs6+oT5EpT+x7xJ17SkZCxklx/t4GMd3tmKDAL8AoDzFGpITqNNZuyuktpMHH
 1rrjg+stjsfOe02HnTjmYxUxn1MFnxU6VTi3dP3tKL/DY+uA8hIvu93u6NtAsd6g
 QBujF/HfRHRm3awAZ9o1jofrunyH7gdxgFm2wQjdgpUht1TyrJXowCjBK+FFcgrC
 4Pq4qEZuCJ9lPZLitAMPM0E9Il58VpCYJ6L4l1JdOx+auR2HRjrCfNlGbU/P1L1a
 h4CK8b2HFqZkhiKCI5I6g==
X-ME-Sender: <xms:VbxdaXXeKflsKCQ4VW0a-iXnwh2jsbJdBRfQOqmK29dSh6TY2NGOHA>
 <xme:VbxdaaLjdqx3WA-gJEfC-EfUFZzAT9jZxBk-3IIexylESPdd07MLktPDI01xYHVpH
 T3Kwvfgg5_Zd2Sr5gRRawQYFkvLAmPCRjeqm402Hni89526ShiwlBw>
X-ME-Received: <xmr:Vbxdaf-Fmm1494Z3rpll6ns5gqRilnPBTw3yQbU_LDQ31YWcpHIUy74y5wOT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddukedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkuffhvfevofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeekkeekfedujefgleeguddtuefg
 hedvhfehhfdutdekffdujeelfeefkeegleejhfenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlqdgsohhunhgtvghsodgthhgrugepjhgrsghlohhnshhkihdrgiihiies
 nhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuh
 drohhrghdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphht
 thhopegthhgrugesjhgrsghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:VbxdaVJdg9XdO--x-jG33V9DLZ5v6WLQWE52zHNt0vJYxf9kgXsVkA>
 <xmx:Vbxdacm19GBSTfm--taIVwwXm2ZqottgmUk6o4Tk1gS3osBudnwuTg>
 <xmx:VbxdaRMQu47YoxdN3zycf83g2-Plm5UazjYj6fip0krqU_VfTtBcrw>
 <xmx:Vbxdaa3Qxzx6urq8G67IB-e-BYIpTIY8NFsoTrMak-1AuoqFGPVpRQ>
 <xmx:VbxdaR8FRPV9B3kgbm2AtN1E8UMCpkAKi6yBuHltrS76noPZkrhlBQ5X>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 20:52:21 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 07e49446;
 Wed, 7 Jan 2026 01:52:21 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Jan 2026 20:52:21 -0500
Message-Id: <DFHZC7DG5UZG.157Y4WLZ0MF3L@jablonski.xyz>
Subject: Re: [PATCH v4 8/9] ati-vga: Implement HOST_DATA register writes
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260106185700.2102742-1-chad@jablonski.xyz>
 <20260106185700.2102742-9-chad@jablonski.xyz>
 <bcce15ee-9f83-128a-0894-2e7c87ceff8c@eik.bme.hu>
In-Reply-To: <bcce15ee-9f83-128a-0894-2e7c87ceff8c@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.145; envelope-from=chad@jablonski.xyz;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

>
> Is it documented somewhere that writing these registers reset the host=20
> data or is it from experiments? Are there any other registers that may=20
> need to reset or are these the only place (apart from HOST_DATA_LAST) tha=
t=20
> terminate host data?
>

I haven't seen documentation on this or done extensive testing on it yet. M=
y
reasoning for placing them here was that these writes kick off blits and so
it seemed like a safe place to do this. I agree though, it would be much be=
tter
to know how this actually behaves. I suspect at the very least there are mo=
re
register writes that do this. I'll see what else I can learn here
through testing.

