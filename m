Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5F6EE3698
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqa17-00053H-CM; Thu, 12 Feb 2026 11:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vqa15-00052e-Tz
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:58:11 -0500
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vqa14-0006kJ-1G
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:58:11 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 417FE7A0198;
 Thu, 12 Feb 2026 11:58:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 12 Feb 2026 11:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1770915486;
 x=1771001886; bh=vQtupsz5sio9uXnM1SoKDK1XGlMxNo176e885mIcJSU=; b=
 BCaQU9oTMvPXTQeBVHZHmuDyYzfo+TKryCLwzlPeT6+6zC5w7JefBA9soC0QeAjH
 XSegXTLPISEmuOE/BI26PgdRnZ0Gb3iJsEPban17aQApw/asbxvvWv5TSGFTlUSR
 eV2IOC9aW9Jqr55jIFTGmFInQei/qs8YodNzjImIBUNSacu7xqHxjjZ+lGEyuqtl
 MMBa8dloAcaUszYPExrGLnzzk8gBKXmGZirr9egWMwBflL14fWQsv/xyiUCwfYgb
 y/OxwjRYZCJcJEaEKGKmnU1DaK5OLl56I99lWUIXVLM8+GZ7UeUdqc+tyzfuwE9u
 LIlvrncb3XVLUF962zLOog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770915486; x=
 1771001886; bh=vQtupsz5sio9uXnM1SoKDK1XGlMxNo176e885mIcJSU=; b=b
 xjeOCnDl4gp8VeA1tg6KxkAD9uVuzhfvZDW8Pmj1Xkb8xhogc6YMj/YyFO/mK7KU
 0lBHDTaqM091Qypdp0LbdiRrf1NT1yMJX5Srlnarzse01tUgShrXQfdHdOoEzr33
 fcQqpq3iD54sxC3cRT0/JgeHTgk+gitKcW0pwrfM0B3aPn6RpaUJmzDfy0UB7SEH
 Q1v74+p2RozpRsuODECBQMOrT85CUeuU/xDP1zUf+TevlnZ0qCrCpZO3Z/2bYvB6
 DNAd4O9O9VNwZP7EN1HYAHHTcWaLIYqED0EThNSu5NNIjbkyy4xCzUogSudaa/9v
 5bwE8ejsdT8/3iCKdaPsg==
X-ME-Sender: <xms:ngaOaahFRMGHBoVY0l_PS3jOv1Hb9wmccL23lF-JaTIqtASZITL_uQ>
 <xme:ngaOaRA4GmAJa5O-QCdYuyDcS52U2is3xz077OP_yncGybf3jyARvXgXuN6qaYR-H
 jSm-eHIuNIYD8Uw0b3YSY2hEb3-7S8mT9MUAC8wtP-3uHdgJ5OH-w>
X-ME-Received: <xmr:ngaOafs0kTx4ybSxSHj0-dlUVi2WvucHaRoLfDBER0O0g7QKmKXd6a6_bK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehleduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
 hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
 htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
 veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepvddpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtoheprghkrhhofihirghksehlihhnuhigrdhisghmrdgtoh
 hmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:ngaOaeZZq-gH-CucdW6SrbHCxuljQd_HqBu2Zk9Ne1FX8oZYhaOW_Q>
 <xmx:ngaOaaVoiEFX4eYwNFsBdZ065uHX14nSGX9FcuHgfiBjY0rFwp5D8Q>
 <xmx:ngaOaa63zKBO8_-z7dVb_4zZefMUyZLt7QKOPLLpt1kYkiB7CeDI_g>
 <xmx:ngaOadg7LXiMekJcd_8Ll4Zs8Yt5nQP8Rart-3fSBlTW3Iea269rhw>
 <xmx:ngaOaTH1_y4hD_QTKPpW3RnwXHP7e4HRa9QnU9V91iYO1eAE24P19ZC8>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 11:58:06 -0500 (EST)
Date: Thu, 12 Feb 2026 09:58:04 -0700
From: Alex Williamson <alex@shazbot.org>
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC] hw/vfio: What is the best way to detect start of vfio
 device migration
Message-ID: <20260212095804.3ad5b4a4@shazbot.org>
In-Reply-To: <72283828-6d7e-4c80-ba24-8c114c8d052d@linux.ibm.com>
References: <72283828-6d7e-4c80-ba24-8c114c8d052d@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.155; envelope-from=alex@shazbot.org;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 12 Feb 2026 10:45:47 -0500
Anthony Krowiak <akrowiak@linux.ibm.com> wrote:

> I created a sysfs attribute for a mediated device to enable/block migration
> of the associated VFIODevice in QEMU. When the sysfs attribute is changed,
> an eventfd is signaled to QEMU to enable or block migration. In response,
> QEMU adds a migration blocker to the VFIODevice object and sets it's
> 'enable_migration' field to 'ON_OFF_AUTO_OFF'.

If some userspace entity has an inclination to block migration, why
wouldn't it just coordinate with the VM orchestration tools rather than
take this inherently racy and vfio specific path of the device
signaling up through QEMU?  Thanks,

Alex

