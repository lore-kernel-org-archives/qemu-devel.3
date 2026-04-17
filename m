Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B187F436A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 13:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDjK7-0006HW-0b; Fri, 17 Apr 2026 09:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wDjK5-0006Gy-94
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:33:29 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wDjK3-0002QG-8P
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:33:29 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 4295CEC011D;
 Fri, 17 Apr 2026 09:33:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 17 Apr 2026 09:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1776432805; x=1776519205; bh=ebQVo28ykEouTYcWlYkvKa13I7iv0swc
 7G6GTtqJSIk=; b=cW7YjJkt1yvfIpBkgkxkyhI2qYqGyJ2ii0GWhWSTCldWMaud
 F4OMj8SiTdQZz8/Opsw5dVsylfSFjV3aGNa2O6lMnFJ0HKFNNFh6hTzJG/Gc73ZG
 Ycecvp9lD2/Z2xk/MPF6Tmff6Vn7dGEhZhLhQ/7/qyLpYmJCFpNeJydrSjCmD5aD
 44Ub/ribvb+d7qlmy80fXXz8HF1G+zLhCY9SdiQFTMkLVeIaB8HNhYMZBzNQdRYv
 RYb9vyowigBiSw1F1KAko64bvLWzJPmHfQGrp/+iRxaN1mC4raTzoInNgM8BawFK
 fVXK0B7wrFmOAzlAu94FQ8mDS5quGtcBjCeblA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776432805; x=
 1776519205; bh=ebQVo28ykEouTYcWlYkvKa13I7iv0swc7G6GTtqJSIk=; b=Z
 RBp8b6QjcYx8PpTgtU6Z3OrbbrhiqdH30gWGZwOfGBC84yCmTXjrqnqeCqEQUY9F
 X5w+2FbwT8atNEshCKTr5vDijg1K0rxUfZy6po3wIzgLOSG7Hmdq3tWFyLqQhIvz
 mAvYtG4Ja213okgMuQ3TgbDKSYRXJy70ua2u83Wxz5ambLrbTBgHQaakF7D/cgqY
 PBLl8RvWCUX6nG6N1uj5xsS/E+DQ5+prdLW7aekyQtsbo8e0ekoJmAIxZ5KmjqKx
 0gyaZnllG2eGOXEe0bfhRvOVDjRb03+dK5wrnsCL2TA6TaiLykSju/i2vzz3MKEk
 zydhGNDKCMvNHxNIKu3GA==
X-ME-Sender: <xms:pDbiabObYTxJVAxGJwjgtnhKgsdTaAQYIoidi5q0uZCc4ZJqXjiI9A>
 <xme:pDbiac_dpI0sxytLV7RqiTdcUHC1X3KrAeD-Pm_Q5FXEEfGX_JiCkvSJhEtNDpaXN
 Oij_M4KhbJyCW6EybQSAfyzVoI5sE7_hOYBTJLk-_09--oHnvuCci4>
X-ME-Received: <xmr:pDbiafR4ONk7GVzdAp3TmPEpGStkAitRDMZMBz2gmDQemepY5VPvkLVOlegO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtddtudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhepggfgtgffkffhvfevuffofhgjsehtqhertdertdej
 necuhfhrohhmpedfvehhrgguucflrggslhhonhhskhhifdcuoegthhgrugesjhgrsghloh
 hnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepvedukeeffedtkeekgfdvgeduheef
 ueegheeftdeuheeiheeggfegtedthefgheetnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhn
 sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvggrud
 gvsehprhhothhonhdrmhgvpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdig
 hiiipdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoh
 epqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:pDbiaenFxits_DMXoMbENipzv9v5_sMMU0AMyC-tAxIDdNwdddTTTQ>
 <xmx:pDbiafTPfmcawMChlIGFxzrBYuDjMRGyu_UPuO25aK0040s-cj8lQg>
 <xmx:pDbiacMQWpueZOF5Pq06zgtGV5I3fuXCx4TsamCOYCPmBQwITSEnlg>
 <xmx:pDbiaYVoFyZsaLMF4UyIr7wREpsyqTcUl0YaytFndUVuFNYo_AiSzA>
 <xmx:pTbiabiAHLcNQBXeffTiIPLVQj7vXqb8e9lVwXM4M698OvNFt7II3nPb>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 09:33:24 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id c7a3817e;
 Fri, 17 Apr 2026 13:33:23 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 09:33:23 -0400
Message-Id: <DHVGVFPUN8S7.3N0XBLZGL3UZE@jablonski.xyz>
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: "Feifan Qian" <bea1e@proton.me>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/2] hw/display/ati: reset host_data.next on early
 returns in ati_host_data_flush()
X-Mailer: aerc 0.21.0
References: <U62ZPP3C0eUIUhmFb68h6Zbpn_gAjGsyJL3MlLsNd6Y4685t5cgo1IQEs3jQpw27LX8rbQaav04Kd-xLwbQXykyIUq2ouFnbFlMgXoKB_NY=@proton.me>
 <42adf9e0-6e57-08e1-5fce-94a43ebad32a@eik.bme.hu>
 <DHTVKTNF92GX.1CR2SGLBUGI6N@jablonski.xyz>
 <376dc5c2-5e10-ce42-3b2f-bebaf9f0f646@eik.bme.hu>
In-Reply-To: <376dc5c2-5e10-ce42-3b2f-bebaf9f0f646@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=chad@jablonski.xyz;
 helo=fout-a1-smtp.messagingengine.com
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

On Wed Apr 15, 2026 at 4:10 PM EDT, BALATON Zoltan wrote:
> On Wed, 15 Apr 2026, Chad Jablonski wrote:
>> I agree with Zoltan on the overflow issue. I think it may be best fixed
>> by resetting next in the write handler after both ati_host_data_finish
>> and ati_host_data_flush. The next reset could be removed from inside of
>> ati_host_data_flush entirely. That way the write handler handles the ful=
l
>> lifecycle of next and it's both clearer and much harder to miss if new
>> failure cases are added.
>>
>>>> + if (!ctx.bpp) {
>>>> + qemu_log_mask(LOG_GUEST_ERROR,
>>>> + "host_data_blt: invalid bpp\n");
>>>> + s->host_data.next =3D 0;
>>>> + return false;
>>>> + }
>>
>> This guard is separate from the acc overflow issue but worth keeping.
>
> Without context I'm not sure where this was proposed to be added but=20
> there's such check in ati_2d_do_blt. If we move this check out from there=
=20
> that one is not needed after adding similar check in ati_2d_blt too.=20
> Having duplicate check seems unnecessary. Then should we move the=20
> dst_stride check out of ati_2d_do_blt too?
>
> Regards,
> BALATON Zoltan


Good point, I missed that the check also happens in ati_2d_blt. It was
proposed to also add it to ati_host_data_flush. There is a possibility
for a division by zero there before ati_2d_do_blt is called. A non-host
data blit also calls ati_2d_blt so removing the check from that function
means that path will no longer be covered. There may be a better way to
organize this to avoid the duplication but does it make sense to get the
overflow fix in first?

