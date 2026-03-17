Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FB3FF6E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 22:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2cdZ-00081I-Lu; Tue, 17 Mar 2026 18:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w2cdW-000819-L5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 18:11:39 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w2cdS-0005Ee-CP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 18:11:35 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id EAA94EC00B4;
 Tue, 17 Mar 2026 18:11:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 18:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1773785492; x=1773871892; bh=m5zML0x9FhlNamEURUaQYBSRup7okcYx
 s0kUoyPk5pI=; b=DogeW1IMXsp5nivCfwn4PdY0Bngx+wdPbnyDryi3fKiRHafW
 NZR9O++pWOSScW+Ps2CBqmhQpUxfFLwmE/RQagGmFgu9UPUFc3vs1DqxOoa6FN00
 wy2s8RkM96g1WlxcW2xE/j3WSudbBatgBAk/8NSFyHZSa/81d2QDvZo/UONHCROO
 Pjpyh0NornA5g6nvmDPfqiiN3g8/UlXbHR0RQP6F1dCwzmN865A+YBQSesASrLqU
 Vbx3xoheHoFotlkPcLqus1RKoRmLP2JT+QwufvfObUy4LQVZ5xHd3EwI7ZoKxg5D
 Gk855M+eXry4HNAxj+8ZElc+ChZiPbsaaGBu+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773785492; x=
 1773871892; bh=m5zML0x9FhlNamEURUaQYBSRup7okcYxs0kUoyPk5pI=; b=t
 l7iRdqjgxVImubkiCU56M/KouHCQSZU3/fTkju8GkKIDngfHGGu9YUWJaQ5I/Uik
 e9Xw46/SprNo/ETlMQPlJZUesVyf7nKtfyRSZDsODq2xAxtOVFoe0XId0KpoBNU9
 EDZWz5yq4AYjmQVHJH3wne51vW1TD1cdVlmlxfTI8HK34FW8s8yNLhb8pdUiy/o7
 Z9+8kgPSuspTG6yIh2qXF58QGWm+LCwPdcLTnNO6qEtEsvRccsMKn7WURFjDrW4N
 crl0n7wDZ4BbBLRGywnLqMHus1+9cvC1gfkSPb+iKxhfAHlPxptZVESN9CMo+lTj
 I4UPpHFOs4iCDpCAzCEdg==
X-ME-Sender: <xms:lNG5aYbBnscEIQw5pN8k3ksEhAa-Arg3iMXcNSdCfTuTQRhIlp3dkg>
 <xme:lNG5aXELcDOjaQYhUePbfFk9mdanP9KfOFO7PT7D8RjnT0-6gNvUGwvLJ8VB59CbZ
 QuYO5bFnSyZpPXC1JbZm3URMGVnTtoQOgD9ij36UWR1379tlzPmFkk>
X-ME-Received: <xmr:lNG5acy_62MKIOzQdy6KralkECsHDHPH04fkAEBv5FPeierOuMObF11rKP0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvgeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkhffvvefuofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeevudekfeeftdekkefgvdegudeh
 feeugeehfedtueehieehgefggeettdehgfehteenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrh
 gtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomhdprhgtphhtthhopehphhhi
 lhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsg
 hmvgdrhhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehkrh
 grgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:lNG5aZlhr_VDmldrt9bnvJR65HOxCJvCBXTIvrtqOqGvpzWpjQpmKw>
 <xmx:lNG5aVnT3TqFe0bdr46PmNtIL5W3jpOaPJLTtqeb5Zwz_9xF10wKdg>
 <xmx:lNG5abwRke_81ERczD6OZx8ydHDFPuTJZWN7gTFxGYLAnyRQaH_AYw>
 <xmx:lNG5aarrC8b0CDXmLqzrNzDqleEpF5Nwo2fKDz9HkfgNwUViLfXNZQ>
 <xmx:lNG5aX7VJ6TIa_glTMZNjTu-VMKDFJePEAzqFQ9eZ-cznu_qdCFZ_5Su>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 18:11:31 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 72ea8c6d;
 Tue, 17 Mar 2026 22:11:31 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 18:11:31 -0400
Message-Id: <DH5EH98LVPBI.CG92QKRD78O8@jablonski.xyz>
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/4] ati-vga: Also switch mode on HW cursor enable bit
 change
X-Mailer: aerc 0.21.0
References: <cover.1773618848.git.balaton@eik.bme.hu>
 <c4edeb5a19ad62b6bb14240dbbce8a54de08321a.1773618848.git.balaton@eik.bme.hu>
In-Reply-To: <c4edeb5a19ad62b6bb14240dbbce8a54de08321a.1773618848.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.149; envelope-from=chad@jablonski.xyz;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Tested this on x86_64 Solaris 10. Prior to the patch xterm under XOrg is
drawn incorrectly. It looks like scanlines are drawn every other line.
After, xterm is drawn correctly.

Tested-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

