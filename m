Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6586D6D22A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 15:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWFik-0004nu-9X; Thu, 18 Dec 2025 10:15:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vWFih-0004nf-I6
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:15:11 -0500
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vWFif-0002GV-Ln
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:15:11 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 526177A01BF;
 Thu, 18 Dec 2025 10:15:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 18 Dec 2025 10:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1766070907; x=1766157307; bh=XUrTJThE2tTLtswryInZj3roS9tDizrY
 v+uZyJrduO4=; b=gLbYIrWu5KSoXAuKaiPQ98zXLgmLpZiFdpQxgo52u67YPbvl
 I9dFteSWFjWqh05RjRjDMkzO7Tc4BMprUCbaQ2bjFDRkkoky5a4zySVKBcUmZBTc
 1bKwnGkmDk1aA/pm/Ns9czFn5eyQsXQoRay9//IpE23fCZcljNtu5fJRJAUasUxj
 b5I/osngp9G84vnZTd155qNcB6UOMCQV2QiXYpfkEXpSzZeRwxuY+BfSGMp2tZ0I
 p4Bni6LS1iMae9YGvzPAe/7SdMFkSVeVeqnprKiD0rDWBKy7wndu3nfnm0CgoWDh
 ZLTb4cY7NJBcFtZwBArz0rGg0TvJ08Y5zWPhAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766070907; x=
 1766157307; bh=XUrTJThE2tTLtswryInZj3roS9tDizrYv+uZyJrduO4=; b=H
 9FPG0VVTyjLsDN9YuA/LRb1WjcOG6RmVhUDwrBpnzV1zsyQlNiA1EcrhOeZ6jGeT
 kbaYTmJCd04pnIzVi4guuhrg2Bcu72n7LjCX7FyPV9Xlu2kHIe+BChaLcZ1M77GN
 D0DaGh7gaZnqEk/5p4ipjrV/5+PZ+2fj5DfDchNKNX4Asr+7u2EOwEvyyLrOdAc8
 3sFemTHuhUGCG8EGk9PlcQIZygKOFvI+uOO3xnXtYZP0U+nVHAizCCqypP8Hax6X
 zo8yBgeQ0C1nj0xmIKbvjiMn1Sk2Kg9yJCmooVzNZdp01//eJnAR1oH5YA9BDS/Z
 fxYUX3Trg00rqABegMxYA==
X-ME-Sender: <xms:ehpEaaFFB-fB8OUIKT-7dxSrNp4pgieo-g1PxyrYx5Bjbth4JsMpJg>
 <xme:ehpEaSxD5WZk1kmKrr1JaqUoNLkOJNLsEKQBih6qnUs5GqcXxsbQEAY4b7m_-cHKL
 LTYDTsMl6POFLNholsOtmM2ZjHi31xLga5mXZ78ERr8nkE8juxIRGc>
X-ME-Received: <xmr:ehpEaRgqBRMYGqhr9QCibC22uUPCAE57HI9qF6R1XTiFg16LK4pb6NbX_qHp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegheejhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepggfgtgffkf
 evuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfvehhrgguucflrggslhhonhhs
 khhifdcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnh
 ephfefudffkeffheduffetledvkeetvdejhedtheektefhhedvgefhheethfffkeegnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrgguse
 hjrggslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtg
 hpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgr
 thhonhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:ehpEadz_7kN5WUNhT7Ns7-7aOFsybl4vlV6og-dyhYw2qGNbm6H6RQ>
 <xmx:ehpEaUIU1LfxI23JNzvqhkCYpUfTWLz1MgHwI2aaQVkEPNK72D8JYQ>
 <xmx:ehpEaURt6cIWalvn0DLRA_e7Qr8sFFkTk_lTsVOG9bptB_1k-M6lVg>
 <xmx:ehpEacqnEdaafVliTuyR3dBEZ73lXMFYhEaxXFZImUwSUEk3GEpXHA>
 <xmx:expEaYcvtadJgnV-g227OAT8afffoikURnsT5wsLiVmaKJGTaiIN3C7x>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 10:15:05 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 30143985;
 Thu, 18 Dec 2025 15:15:05 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Dec 2025 10:15:05 -0500
Message-Id: <DF1FVXH13BOZ.3LKLJRZPLLC3P@jablonski.xyz>
Cc: <balaton@eik.bme.hu>
Subject: Re: [PATCH v3 10/11] ati-vga: Implement HOST_DATA register writes
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "Chad Jablonski" <chad@jablonski.xyz>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20251118154812.57861-1-chad@jablonski.xyz>
 <20251118154812.57861-11-chad@jablonski.xyz>
In-Reply-To: <20251118154812.57861-11-chad@jablonski.xyz>
Received-SPF: pass client-ip=202.12.124.155; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b4-smtp.messagingengine.com
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

>      case SRC_SC_BOTTOM:
>          s->regs.src_sc_bottom =3D data & 0x3fff;
> +    case HOST_DATA0:
> +    case HOST_DATA1:
> +    case HOST_DATA2:
> +    case HOST_DATA3:
> +    case HOST_DATA4:
> +    case HOST_DATA5:
> +    case HOST_DATA6:
> +    case HOST_DATA7:

Oops, it looks like I was testing this with warnings as errors disabled.
The fallthrough from SRC_SC_BOTTOM to HOST_DATA_* is unintentional. This
will be fixed in v4.

