Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA6DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 00:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv4Ov-0002z4-0j; Thu, 11 Apr 2024 20:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rv4Os-0002yn-8M
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 20:04:14 -0400
Received: from wfhigh7-smtp.messagingengine.com ([64.147.123.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rv4Op-0002W5-Nv
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 20:04:13 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.west.internal (Postfix) with ESMTP id 2D47018000F6
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 20:04:06 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute5.internal (MEProxy); Thu, 11 Apr 2024 20:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buhman.org; h=cc
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
 t=1712880245; x=1712966645; bh=qZcNMuxv3+R2tkgrqX00gSps2W/uON3E
 qrODaMuoeJQ=; b=rG0bc+8gg2pKuC8wdWD7SOzcR2vh5iHlvs6dl59V7dUSL1+/
 nE6dWaJWvZ97WklHCnMDXJbVc1o5zg/JFcE2a6ZYnUJkHbvDJbF3aU9N2iPJkp7M
 qa3n6QoG6vRvS1t19OnmeMoGtxSeYuZ4igNLurpTPhym0C9FmnSydXuXdfTZR1Wf
 qL71pEFOJofeia5a3L34fNqPkadWJOh1qBa0aUvAXyWrybklYDVNH3/j/94XdyG2
 J/bS7b76VtSzrLy41x0BAW426acv3y+6hilhrvfxVmow2wf05W2sXVFNSHsQVP5H
 Ku1gMIyBYJNFvIxHBmuElDkJxkq2daJtBKTNwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1712880245; x=1712966645; bh=qZcNMuxv3+R2tkgrqX00gSps2W/uON3EqrO
 DaMuoeJQ=; b=DAqw8Y1X4UkFYqbDmqf7VKRZFOOGQZb55fro/xh9r5ADg/cZ6aL
 YcOVaKLhhZIYOc7gpcjnlt+VN8hK0NA+SdNRjvGssEJJHOZ2qa7g8jXPrk4fkQDo
 NEsPx0QjbzRHKFY7jkPKXHuJxlsdsCGf3V/0kdaO8GDVp/LRY8m6trqUBcJebMOV
 jK/0U4zj7IM4m3I84FdHWjyI93CB837/uTvcYAdJ+ICuZqw3Tn0mgzsDnMUI7fjq
 AnH2vR04b8h2NPgk/tmTo/2RcMmSrYGIOmQA4wRymDKXluLs3G+Ck3iPZo9atpi5
 rqCtbHIqQA0jBpMRz6erglZOMhkFgAjXxDg==
X-ME-Sender: <xms:dXoYZvQYjva2TF_syuN8XrTf7ell3Qx2oe0uZ9rWzzALib9OBsKcAg>
 <xme:dXoYZgz00YVnRJXxIVtcKlAddIGlUQ46a8AAy-p_qNEnuHD7c9h7DOMhuxIjHgrMf
 KNRlPebYGRyQ1evt_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehledgfedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
 erredtnecuhfhrohhmpedfkggrtghkuceuuhhhmhgrnhdfuceoiigrtghksegsuhhhmhgr
 nhdrohhrgheqnecuggftrfgrthhtvghrnhepjedtfeeugeeluddvvedvvdeileevfeejhf
 dttedttdetudffteehfefhffefgfetnecuffhomhgrihhnpehqvghmuhdrohhrghenucev
 lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiirggtkhessg
 huhhhmrghnrdhorhhg
X-ME-Proxy: <xmx:dXoYZk0JGPZeoExquj0m_-VIX_bkMMpsbCcZfS5-KaSUF-EHp-naiA>
 <xmx:dXoYZvCPdv7xkjEXWs-OfJGGsOszI0gJNmxYj5VnbgmN-G3zLJkBVA>
 <xmx:dXoYZoitUOumb4IA6Dhb57eCMRTgzPE2e8hzNGhxu2LZIYCxF6hRSA>
 <xmx:dXoYZjqviBdZ0IWfv7-utdzhGcVXtU7WmzlecLTRM2PqeGMf4w7UhA>
 <xmx:dXoYZgIjTvrmKUjrppn5zmjT-PJSpBUq-EAnQkmvNzDuYj8pra_ZGYUT>
Feedback-ID: i1541475f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 4697AA60079; Thu, 11 Apr 2024 20:04:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
MIME-Version: 1.0
Message-Id: <a60e71ec-93d5-40bc-83b9-99a635e8d1ab@app.fastmail.com>
Date: Fri, 12 Apr 2024 08:03:54 +0800
From: "Zack Buhman" <zack@buhman.org>
To: qemu-devel@nongnu.org
Subject: wiki.qemu.org account access request
Content-Type: text/plain
Received-SPF: pass client-ip=64.147.123.158; envelope-from=zack@buhman.org;
 helo=wfhigh7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

I noticed the recent SH4 patches are included in the 9.0.0-rc3 release. 

Is it appropriate that I request a wiki.qemu.org account so that I may document these changes in https://wiki.qemu.org/ChangeLog/9.0 in a manner that is consistent with how the changes to other CPUs have been documented so far?

If so, I indeed desire such an account.

