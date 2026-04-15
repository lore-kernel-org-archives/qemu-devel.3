Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF54DF43854
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD3HA-000366-Lt; Wed, 15 Apr 2026 12:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wD3H5-00035r-8s
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:39:35 -0400
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wD3H3-0003di-Li
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:39:35 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 31CA87A01D3;
 Wed, 15 Apr 2026 12:39:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 15 Apr 2026 12:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1776271169; x=1776357569; bh=eFPGxPaHYVbekxOqsM4tYRcuFMkMZ5zT
 ctnWlZ36XoM=; b=HcKk269mZOpowkFTSF2ICE3ShKJNR0s56CGimdwpIJwoOLVi
 x+wOOy51UdOPa+q+uYspCum2N7oBM06J8xeY8QM0fqNp3MU9i9+DbqWqg3Erms20
 X/wvvYXzqx+LbOXswF1JJU2UO0xdG6UziAFOme6dmvPxloEYutGAhP1NtEAqnt2w
 EMPNDSwZw8Hf3s95bxhCklCcp9sZdtpT1XK18iDgkN/YIu7kkICRErYBc/QwKRe6
 MZAGfgPoH4cmLiLVul+eLlPNRZo+RYXQf0qlE7asLGScFPFAnTmqMwrxql/xBLLM
 /QjGYYoBCAfUZFZkjDH/R+jxPR1XqgO/PlZqxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776271169; x=
 1776357569; bh=eFPGxPaHYVbekxOqsM4tYRcuFMkMZ5zTctnWlZ36XoM=; b=G
 skTbOy4DSTxz3aKPjw4i8TNjWiN2zipbeeGofgmQLEOTy5sFP3tLlBQbLd4dZ9gd
 Xb4hEde3dWWb3udcABDj4zpbE3WjFlhJR2Kr5aOQIKthNpTYU6wnU/XOZii1HMsY
 mdEQcNzkrmM/n39u5DBfLLCskxZIBaTNogUToOB3rSAfiqt8Y6CC4LJpFXsbuXTH
 k5Y9+PHrQ305W7aZ4m7xQOBFYQ9k3jEuYjgSxakdFhLx9ZbSKG04v+hl5I9Onz7S
 MOKj+cuy1IP2/9zA4GXhceOcRMOfpB79BoEQfxROy+n8XorDr0O54EZF8wD0Rea8
 ZEMycuZ5NI1gHe1a/ic9A==
X-ME-Sender: <xms:Qb_faREl5GfN59wLZWTynzDSf8NYRm7fHF6PNbCOujkK9S9NEJZ9YQ>
 <xme:Qb_fadXOS4Lo5LOIgGVGmuAdh_L3HzBbgWPpa2b0yn-ORqL53RkGXGsLiOIZ6BSWK
 VGQ80SliFOPvWQyFOEyAGfy254Ws5pEnHYWVTn0ELjQzTpZTRht3Qt3>
X-ME-Received: <xmr:Qb_faYJ8YGbMO6oS8uGdL86quaF2qafPqIG68EqBDYvZOtgcULwbG0rYnX8o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeehlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdej
 necuhfhrohhmpedfvehhrgguucflrggslhhonhhskhhifdcuoegthhgrugesjhgrsghloh
 hnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhephfefudffkeffheduffetledvkeet
 vdejhedtheektefhhedvgefhheethfffkeegnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhn
 sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrg
 htohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhk
 ihdrgiihiidprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpd
 hrtghpthhtohepsggvrgduvgesphhrohhtohhnrdhmvg
X-ME-Proxy: <xmx:Qb_faV_d6aOCYo3HMhmrdNzCpgq4kpFEAVtwVhKvJCCjbnv0PHZurw>
 <xmx:Qb_faTLRSwpLhLFfRNDj067Joeu6OkU5-UTN1BsGNAZJigRKcl736A>
 <xmx:Qb_faSlM6QSAcVHZJsA5VUN7uxPUQfx11SUBRZs_mmT7MHoNUkUrOA>
 <xmx:Qb_fafNWef2MlqthjdJeGCNsC45AjCKo2HKXaoemtAvSgXIcVsC4PQ>
 <xmx:Qb_faXaEDx_7pwUfecKuYAj0C4VUIvOt86LGU6zd7y3DToeF9DPZdRIs>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 12:39:29 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 8b15c769;
 Wed, 15 Apr 2026 16:39:28 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 12:39:28 -0400
Message-Id: <DHTVKTNF92GX.1CR2SGLBUGI6N@jablonski.xyz>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Chad Jablonski"
 <chad@jablonski.xyz>
Subject: Re: [PATCH 2/2] hw/display/ati: reset host_data.next on early
 returns in ati_host_data_flush()
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Feifan Qian" <bea1e@proton.me>
X-Mailer: aerc 0.21.0
References: <U62ZPP3C0eUIUhmFb68h6Zbpn_gAjGsyJL3MlLsNd6Y4685t5cgo1IQEs3jQpw27LX8rbQaav04Kd-xLwbQXykyIUq2ouFnbFlMgXoKB_NY=@proton.me>
 <42adf9e0-6e57-08e1-5fce-94a43ebad32a@eik.bme.hu>
In-Reply-To: <42adf9e0-6e57-08e1-5fce-94a43ebad32a@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.157; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b6-smtp.messagingengine.com
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

I agree with Zoltan on the overflow issue. I think it may be best fixed
by resetting next in the write handler after both ati_host_data_finish
and ati_host_data_flush. The next reset could be removed from inside of
ati_host_data_flush entirely. That way the write handler handles the full
lifecycle of next and it's both clearer and much harder to miss if new
failure cases are added.

>> + if (!ctx.bpp) {
>> + qemu_log_mask(LOG_GUEST_ERROR,
>> + "host_data_blt: invalid bpp\n");
>> + s->host_data.next =3D 0;
>> + return false;
>> + }

This guard is separate from the acc overflow issue but worth keeping.


